USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_FWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_FWD '20181031'
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_FWD]
(  
	@FECHA DATE = NULL
)
AS
BEGIN
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ DETALLE OPERACIONES
--MODIFICACION	: 27-06-2018	CAMPOS TASA, IND_CAN_ANT
--MODIFICACION	: 16-10-2018	IND_CAN_ANT

SET NOCOUNT ON

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/    
	-- DECLARE @FECHA DATE
	-- SET @FECHA = '2017-11-20'
	DECLARE @FECHA_PROC_FILTRO	DATE
	DECLARE @FECHA_INI_FILTRO	DATE
	DECLARE @ENTIDAD VARCHAR(30)
	
	

	SET @ENTIDAD = (SELECT TOP 1 ENTIDAD FROM BACSWAPSUDA.DBO.SWAPGENERAL WITH(NOLOCK)) 

	IF @FECHA IS NULL 
		BEGIN
			SET @FECHA_PROC_FILTRO = (SELECT TOP 1 acfecproc FROM BacFwdSuda.dbo.mfac WITH(NOLOCK)) 
		END 
	ELSE
		BEGIN
			SET @FECHA_PROC_FILTRO = @FECHA 
		END

	SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')


	IF OBJECT_ID('TEMPDB..#TMP_DETALLE_FWD') IS NOT NULL BEGIN
		DROP TABLE #TMP_DETALLE_FWD
	END


	CREATE TABLE #TMP_DETALLE_FWD
	(
/*01*/	 NRO_DOCUMENTO			NUMERIC(20)
/*02*/	,NRO_OPERACION			NUMERIC(20)
/*03*/	,NRO_CORRELATIVO		NUMERIC(20)
/*04*/	,FEC_DATA				DATE--NUMERIC(8)
/*05*/	,COD_ENTIDAD			VARCHAR(4)
/*06*/	,COD_PRODUCTO			VARCHAR(4) DEFAULT('BFW')
/*07*/	,COD_SUBPRODU			VARCHAR(4)
/*08*/	,NUM_CUENTA				VARCHAR(12)
/*09*/	,NUM_SECUENCIA_CTO		NUMERIC(4) DEFAULT 1
/*10*/	,COD_DIVISA				VARCHAR(4)
/*11*/	,COD_REAJUSTE			VARCHAR(3)
/*12*/	,IDF_PERS_ODS			VARCHAR(25)
/*13*/	,COD_CENTRO_CONT		VARCHAR(4)
/*14*/	,COD_OFI_COMERCIAL		VARCHAR(5)
/*15*/	,COD_GESTOR_PROD		VARCHAR(15)
/*16*/	,COD_BASE_TAS_INT		VARCHAR(3)
/*17*/	,COD_BCA_INT			VARCHAR(3)
/*18*/	,COD_COMPOS_INT			CHAR(1)
/*19*/	,COD_MOD_PAGO			CHAR(1)
/*20*/	,COD_MET_AMRT			VARCHAR(4)
/*21*/	,COD_CUR_REF			VARCHAR(5)
/*22*/	,COD_TIP_TAS			VARCHAR(2)
/*23*/	,TAS_INT				NUMERIC(8,5)
/*24*/	,TAS_DIF_INC_REF		NUMERIC(8,5)
/*25*/	,FEC_ALTA_CTO			DATE --NUMERIC(8)
/*26*/	,FEC_INI_GEST			DATE --NUMERIC(8)
/*27*/	,FEC_CAN_ANT			DATE --NUMERIC(8)
/*28*/	,FEC_ULT_LIQ			DATE --NUMERIC(8)
/*29*/	,FEC_PRX_LIQ			DATE --NUMERIC(8)
/*30*/	,FEC_ULT_REV			DATE --NUMERIC(8)
/*31*/	,FEC_PRX_REV			DATE --NUMERIC(8)
/*32*/	,FEC_VEN				DATE --NUMERIC(8)
/*33*/	,FRE_PAGO_INT			NUMERIC(5)
/*34*/	,COD_UNI_FRE_PAGO_INT	CHAR(1)
/*35*/	,FRE_REV_INT			NUMERIC(5)
/*36*/	,COD_UNI_FRE_REV_INT	CHAR(1)
/*37*/	,PLZ_CONTRACTUAL		NUMERIC(5)
/*38*/	,PLZ_AMRT				NUMERIC(5)
/*39*/	,COD_UNI_PLZ_AMRT		CHAR(1)
/*40*/	,IMP_INI_MO				NUMERIC(20,4)
/*41*/	,IMP_CUO_MO				NUMERIC(20,2)
/*42*/	,IMP_CUO_INI_MO			NUMERIC(20,2)
/*43*/	,NUM_CUO_PAC			NUMERIC(5)
/*44*/	,NUM_CUO_PEND			NUMERIC(5)
/*45*/	,IMP_PAGO_ML			NUMERIC(20,4)
/*46*/	,IMP_PAGO_MO			NUMERIC(20,4)
/*47*/	,IND_CAN_ANT			CHAR(1)
/*48*/	,IND_TAS_PREDEF			CHAR(1)
/*49*/	,TAS_PREDEF				NUMERIC(8,5)
/*50*/	,IMP_INI_ML				NUMERIC(20,4)
/*51*/	,TAS_INT_ORIGEN			NUMERIC(8,5)
/*52*/	,COD_PORTAFOLIO			VARCHAR(10)
/*53*/	,DES_PORTAFOLIO			VARCHAR(20)
/*54*/	,COD_NEMOTECNICO		VARCHAR(20)
/*55*/	,COD_CARTERA_FINANCI	CHAR(8)
/*56*/	,COD_TIP_LIBRO			VARCHAR(1)
/*57*/	,NUM_DOC				VARCHAR(12)
/*58*/	,NUM_OPE_ANT			VARCHAR(12)
/*59*/	,T_FLUJO				INT DEFAULT 0
	)
	
	
	/********************************************************************************************/
	/*			CARGA DE VALORES DE MONEDA CONTABLE												*/
	/********************************************************************************************/
	IF OBJECT_ID('TEMPDB..##RENT_VALOR_TC_CONTABLE') IS NOT NULL BEGIN
		DROP TABLE ##RENT_VALOR_TC_CONTABLE
	END
	
	EXEC REPORTES.DBO.SP_RENT_VALOR_TC_CONTABLE @FECHA=@FECHA
	/********************************************************************************************/
	declare @plazos_fwd table(
		canumoper				numeric(10),
		cod_base_tas_int		char(1),
		plz_amortizacion		numeric(10),
		plz_contractual			numeric(10),
		cod_uni_plz_amrt		char(1),		
		fre_rev_interes			numeric(10),
		cod_uni_fre_rev_int		char(1),		
		fre_pago_interes		numeric(10),
		cod_uni_fre_pago_int	char(1)
	)

	declare cur_plazos_fwd cursor for
	select canumoper,cafecha,cafecvcto,cafecvenor,caantici,caplazoope,caplazo
	from BacFwdSuda.dbo.mfca with (nolock) where cafecvcto>=@fecha_proc_filtro
	union all
	select canumoper,cafecha,cafecvcto,cafecvenor,caantici,caplazoope,caplazo
	from BacFwdSuda.dbo.mfcah with (nolock) where cafecproc between @fecha_ini_filtro and @fecha_proc_filtro

	declare 
		@numoper		numeric(10)
		,@cafecha		date
		,@cafecvcto		date
		,@cafecvenor	date
		,@caantici		char(1)
		,@caplazoope	numeric(10)
		,@caplazo		numeric(10)

	open cur_plazos_fwd 
	fetch next from cur_plazos_fwd 
	into @numoper,@cafecha,@cafecvcto,@cafecvenor,@caantici,@caplazoope,@caplazo		
	while @@FETCH_STATUS=0 begin
		declare @aux_str varchar(100)
		declare @aux_num numeric(10)

		if @caplazoope = 0 and @caplazo <> 0 begin
			set @caplazoope = @caplazo
		end else if @caplazoope <> 0 and @caplazo = 0 begin
			set @caplazo = @caplazoope			
		end

		set @aux_str = (case
							when @caplazo <31 then 'D'
							when @caplazo >=31 and @caplazo <365 then 'M'
							when @caplazo >=365 then 'A'
						end)
		set @aux_num = (case
							when @caplazo <31 then 1
							when @caplazo >=31 and @caplazo <365 then 2
							when @caplazo >=365 then 3
						end)



		insert into @plazos_fwd
		select 
		 canumoper				= @numoper
		,cod_base_tas_int		= (case
										when @caplazo <=90 then 'M'
										when @caplazo >=91 and @caplazo <=179 then 'M'
										when @caplazo >=180 and @caplazo <=364 then 'S'
										when @caplazo >=365		then 'A'
									end)
		,plz_amortizacion		= (case
										when @caplazo <31 then @caplazo
										when @caplazo >=31 and @caplazo <365 then round(@caplazo/30,0,0)
										when @caplazo >=365 then round(@caplazo/365,0,0)
									end)
		,plz_contractual		= @caplazo	
		,cod_uni_plz_amrt		= @aux_str
		,fre_rev_interes		= @aux_num
		,cod_uni_fre_rev_int	= @aux_str		
		,fre_pago_interes		= @aux_num
		,cod_uni_fre_pago_int	= @aux_str


		fetch next from cur_plazos_fwd 
		into @numoper,@cafecha,@cafecvcto,@cafecvenor,@caantici,@caplazoope,@caplazo		
	end
	close cur_plazos_fwd
	deallocate cur_plazos_fwd



	INSERT INTO #TMP_DETALLE_FWD
	SELECT	DISTINCT
/*01*/			NRO_DOCUMENTO				
/*02*/		,	NRO_OPERACION				
/*03*/		,	NRO_CORRELATIVO				
/*04*/		,	Forward.FEC_DATA
/*05*/		,	COD_ENTIDAD
/*06*/		,	Forward.COD_PRODUCTO
/*07*/		,	Forward.COD_SUBPRODU
/*08*/		,	Forward.NUM_CUENTA
/*09*/		,	Forward.NUM_SECUENCIA_CTO
/*10*/		,	Forward.COD_DIVISA
/*11*/		,	Forward.COD_REAJUSTE
/*12*/		,	Forward.IDF_PERS_ODS
/*13*/		,	COD_CENTRO_CONT				= '2230'
/*14*/		,	Forward.COD_OFI_COMERCIAL
/*15*/		,	Forward.COD_GESTOR_PROD
/*16*/		,	Forward.COD_BASE_TAS_INT
/*17*/		,	Forward.COD_BCA_INT
/*18*/		,	Forward.COD_COMPOS_INT
/*19*/		,	Forward.COD_MOD_PAGO
/*20*/		,	Forward.COD_MET_AMRT
/*21*/		,	Forward.COD_CUR_REF
/*22*/		,	Forward.COD_TIP_TAS
/*23*/		,	TAS_INT =					0 --CONVERT(NUMERIC(20,10), ROUND(Forward.TAS_INT, 5))
/*24*/		,	TAS_DIF_INC_REF =			0
/*25*/		,	Forward.FEC_ALTA_CTO
/*26*/		,	Forward.FEC_INI_GEST 
/*27*/		,	Forward.FEC_CAN_ANT
/*28*/		,	Forward.FEC_ULT_LIQ
/*29*/		,	Forward.FEC_PRX_LIQ
/*30*/		,	Forward.FEC_ULT_REV
/*31*/		,	Forward.FEC_PRX_REV
/*32*/		,	Forward.FEC_VEN
/*33*/		,	Forward.FRE_PAGO_INT
/*34*/		,	Forward.COD_UNI_FRE_PAGO_INT
/*35*/		,	Forward.FRE_REV_INT
/*36*/		,	Forward.COD_UNI_FRE_REV_INT
/*37*/		,	Forward.PLZ_CONTRACTUAL
/*38*/		,	Forward.PLZ_AMRT
/*39*/		,	Forward.COD_UNI_PLZ_AMRT
/*40*/		,	Forward.IMP_INI_MO
/*41*/		,	Forward.IMP_CUO_MO
/*42*/		,	Forward.IMP_CUO_INI_MO
/*43*/		,	Forward.NUM_CUO_PAC
/*44*/		,	Forward.NUM_CUO_PEND
/*45*/		,	Forward.IMP_PAGO_ML
/*46*/		,	Forward.IMP_PAGO_MO
/*47*/		,	Forward.IND_CAN_ANT
/*48*/		,	Forward.IND_TAS_PREDEF
/*49*/		,	Forward.TAS_PREDEF
/*50*/		,	Forward.IMP_INI_ML
/*51*/		,	TAS_INT_ORIGEN = 0		
/*52*/		,	Forward.COD_PORTAFOLIO
/*53*/		,	DES_PORTAFOLIO = CONVERT(VARCHAR(20), Forward.DES_PORTAFOLIO)		
/*54*/		,	Forward.COD_NEMOTECNICO
/*55*/		,	Forward.COD_CARTERA_FINANCI
/*56*/		,	Forward.COD_TIP_LIBRO
/*57*/		,	Forward.NUM_DOC						
/*58*/		,	Forward.NUM_OPE_ANT
/*59*/		,	Forward.TFLUJO
    FROM	(
				SELECT	
						NRO_DOCUMENTO			= 0
				,		NRO_OPERACION			= car.canumoper
				,		NRO_CORRELATIVO			= 1
				,		'FEC_DATA'				= CONVERT(DATE,@FECHA_PROC_FILTRO)
				,		'COD_ENTIDAD'			= '1769'
				,		'COD_PRODUCTO'			= 'BFW'
				,		'COD_SUBPRODU'			= car.cacodpos1
				,		'NUM_CUENTA'			= car.canumoper
				,		'NUM_SECUENCIA_CTO'		= 1
				,		'COD_DIVISA'			= case 
													when cacodmon1 in (998,997) then 'CLP'
													when cacodmon1 in (994,13) then 'USD'
													else (select ltrim(rtrim(mnnemo)) from BacParamSuda.dbo.moneda with(nolock) where mncodmon = cacodmon1)
													end																						
				,		'COD_REAJUSTE'			= case
													when cacodmon1 in (998,997) then 'UF'
													else null
													end		
				,		'IDF_PERS_ODS'			= rtrim(ltrim(CONVERT(varchar,cacodigo))) + '-' + ISNULL(cldv,'0')
				,		'COD_CENTRO_CONT'		= '2230'
				,		'COD_OFI_COMERCIAL'		= ''
				,		'COD_GESTOR_PROD'		= CAOPERADOR--ltrim(rtrim(caoperador))--ltrim(rtrim(ISNULL(substring(ltrim(rtrim(caoperador)),1,8),'')))
				,		'COD_BASE_TAS_INT'		= pl.cod_base_tas_int
				,		'COD_BCA_INT'			= '1'
				,		'COD_COMPOS_INT'		= 'C'
				,		'COD_MOD_PAGO'			= 'V'
				,		'COD_MET_AMRT'			= '1'
				,		'COD_CUR_REF'			=  0	--cacodpos1				-- ??? Código de la curva con las que se establecela tasa de interes para las operaciones a tasa variable: Ejemplo:  Libor, Tab, ICP….
				,		'COD_TIP_TAS'			= 'F'
				
				,		'TAS_INT'				= 0												  
				,		'TAS_DIF_INC_REF'		= 0
				
				,		'FEC_ALTA_CTO'			= cafecha
				,		'FEC_INI_GEST'			= cafecha
				,		'FEC_CAN_ANT'			= (case when ltrim(rtrim(caantici))='A' then cafecvcto else convert(date,'1900-01-01') end)
				,		'FEC_ULT_LIQ'			= cafecha
				,		'FEC_PRX_LIQ'			= (case when ltrim(rtrim(caantici))='A' then cafecvenor else cafecvcto end)
				,		'FEC_ULT_REV'			= cafecha
				,		'FEC_PRX_REV'			= (case when ltrim(rtrim(caantici))='A' then cafecvenor else cafecvcto end)
				,		'FEC_VEN'				= (case when ltrim(rtrim(caantici))='A' then cafecvenor else cafecvcto end)
				,		'FRE_PAGO_INT'			= pl.fre_pago_interes
				,		'COD_UNI_FRE_PAGO_INT'  = pl.cod_uni_fre_pago_int
				,		'FRE_REV_INT'			= pl.fre_rev_interes
				,		'COD_UNI_FRE_REV_INT'	= pl.cod_uni_fre_rev_int
				,		'PLZ_CONTRACTUAL'		= pl.plz_contractual
				,		'PLZ_AMRT'				= pl.plz_amortizacion
				,		'COD_UNI_PLZ_AMRT'		= pl.cod_uni_plz_amrt
				,		'IMP_INI_MO'			= camtomon1 --CASE WHEN var_moneda2 > 0 AND ( cacodpos1 = 1 )  THEN 0 ELSE camtomon1 END
				,		'IMP_CUO_MO'			= 0
				,		'IMP_CUO_INI_MO'		= camtomon1 --caequusd1
				,		'NUM_CUO_PAC'			= 1--caplazo
				,		'NUM_CUO_PEND'			= (case 
														when convert(date,cafecvcto)<=@FECHA_PROC_FILTRO then 0
														else 1
												   end)
				,		'IMP_PAGO_ML'			= caequmon2
												--(CASE
												--	WHEN cacodmon1 = 999	THEN	(camtomon1 + cadiftipcam)
												--	WHEN cacodmon1 = 998	THEN	ROUND(((camtomon1 + cadiftipcam) * @vUF_FinMes),0)
												--	WHEN cacodmon1 = 13		THEN	ROUND(((camtomon1 + cadiftipcam) * @vDolar_obsFinMes),0)
												--	ELSE							ROUND(((camtomon1 + cadiftipcam) * (SELECT ISNULL(vmvalor,0) FROM #VALOR_TC_CONTABLE WHERE mncodmon = cacodmon1)),0)
												--END	)
				,		'IMP_PAGO_MO'			= camtomon1--camtomon1 --caequusd1
				-- MGM Cambio en el Indicador de Cancelacion 
				,		'IND_CAN_ANT'			= (case when ltrim(rtrim(caantici))='A' then 1 else 5 end) -- Indicador cancelación anticipada: 1 = prepago total, 2 = castigo, 3 = renovación, 4 = refinanciamiento, 5 = otros eventos fuera de dominio
				-- MGM 30-07-2018
				,		'IND_TAS_PREDEF'		= 'N'			-- Indicador si la tasa de costo fondo viene informada por el operacional: S = viene predefinida, N = No viene predefinida
				,		'TAS_PREDEF'			= 0				-- Valor de la tasa de costo fondo predefinida
				,		'IMP_INI_ML'			= case 
													when cacodmon1 in (998,999) then camtomon1
													else
														camtomon1 * (select top 1 vmvalor from ##RENT_VALOR_TC_CONTABLE where vmcodigo = cacodmon1)
												   end
													
				
												  /*
												  CASE  WHEN cacodmon1 = 999	THEN	camtomon1
														WHEN cacodmon1 = 998	THEN	ROUND(camtomon1 * @vUF_FinMes,0)
														WHEN cacodmon1 = 13		THEN	ROUND(camtomon1 * @vDolar_obsFinMes,0)
												  ELSE	
														ROUND(camtomon1 * (SELECT ISNULL(vmvalor,0) FROM #VALOR_TC_CONTABLE WHERE mncodmon = cacodmon1),0)
												  END
												  */
				,		'TAS_INT_ORIGEN'		=	0
				,		'COD_PORTAFOLIO'		=  cacodcart
				,		'DES_PORTAFOLIO'		=  (SELECT tbglosa FROM bacparamsuda..tabla_general_detalle WHERE tbcateg = 204 and tbcodigo1 = cacodcart)								
				,		'COD_NEMOTECNICO'		= NULL
				,		'COD_CARTERA_FINANCI'	= CASE  WHEN cacodcart = 1 THEN 'TR'  -- Trading
														WHEN cacodcart = 2 THEN 'PLP' -- Portfolio LP
														WHEN cacodcart = 3 THEN 'ET' -- Estructuración
														WHEN cacodcart = 4 THEN 'BL' -- BALANCE
														WHEN cacodcart = 9 THEN 'PR' -- PROPIETARIO
														WHEN cacodcart = 10 THEN 'PLO' -- PORTFOLIO LO 180
														WHEN cacodcart = 13 THEN 'MT' -- MM TASA   -- REVISAR
														WHEN cacodcart = 14 THEN 'MF' -- MM FX -- REVISAR
														WHEN cacodcart = 16 THEN 'BGF' -- Balance Gestion Financiera -- REVISAR
												  ELSE
														'BGL' -- Balance Gestion Liquidez -- REVISAR
												  END
				,		'COD_TIP_LIBRO'			= (CASE WHEN calibro = 1 THEN 'N' ELSE 'B' END) 
				,		NUM_DOC					= null
				,		NUM_OPE_ANT				= null
				,		TFLUJO				    = 1
--+++fmo 20180802 operaciones cartera vigente
				from	bacfwdsuda.dbo.mfca							as car	with(nolock) 
				left  join bacparamsuda.dbo.cliente			as cl	with(nolock) on cl.clrut = car.cacodigo	and cl.clcodigo = car.cacodcli						
				left  join bacfwdsuda.dbo.view_forma_de_pago as pg	with(nolock) on car.cafpagomn = pg.codigo 						
				inner join bacfwdsuda.dbo.view_producto		 as b	with(nolock) on b.id_sistema = 'BFW' and b.codigo_producto = car.cacodpos1
				left  join @plazos_fwd as pl on car.canumoper = pl.canumoper
--				WHERE	cafecvcto >= @FECHA_PROC_FILTRO
-----fmo 20180802 operaciones cartera vigente
				UNION ALL
				SELECT 
						NRO_DOCUMENTO			= 0
				,		NRO_OPERACION			= cah.canumoper 
				,		NRO_CORRELATIVO			= 1
				,		'FEC_DATA'				= convert(date,@FECHA_PROC_FILTRO)
				,		'COD_ENTIDAD'			= '1769'
				,		'COD_PRODUCTO'			= 'BFW'
				,		'COD_SUBPRODU'			= cacodpos1
				,		'NUM_CUENTA'			= cah.canumoper
				,		'NUM_SECUENCIA_CTO'		= 1
				,		'COD_DIVISA'			= case 
													when cacodmon1 in (998,997) then 'CLP'
													when cacodmon1 in (994,13) then 'USD'
													else (select ltrim(rtrim(mnnemo)) from BacParamSuda.dbo.moneda with(nolock) where mncodmon = cacodmon1)
													end																						
				,		'COD_REAJUSTE'			= case
													when cacodmon1 in (998,997) then 'UF'
													else null
													end		
				,		'IDF_PERS_ODS'			= RTRIM(LTRIM(CONVERT(varchar,cacodigo))) + '-' + ISNULL(cldv,'0')
				,		'COD_CENTRO_CONT'		= '2230'
				,		'COD_OFI_COMERCIAL'		= ''
				,		'COD_GESTOR_PROD'		= caoperador---ltrim(rtrim(caoperador))--LTRIM(RTRIM(ISNULL(SUBSTRING(LTRIM(RTRIM(caoperador)),1,8),'')))
				,		'COD_BASE_TAS_INT'		= pl.cod_base_tas_int
				,		'COD_BCA_INT'			= '1'
				,		'COD_COMPOS_INT'		= 'C'
				,		'COD_MOD_PAGO'			= 'V'
				,		'COD_MET_AMRT'			= '1'
				,		'COD_CUR_REF'			= 0--cacodpos1 -- Código de la curva con las que se establecela tasa de interes para las operaciones a tasa variable: Ejemplo:  Libor, Tab, ICP….
				,		'COD_TIP_TAS'			= 'F'

				,		'TAS_INT'				= 0				
				,		'TAS_DIF_INC_REF'		= 0

				,		'FEC_ALTA_CTO'			= cafecha
				,		'FEC_INI_GEST'			= cafecha
				,		'FEC_CAN_ANT'			= (case when ltrim(rtrim(caantici))='A' then cafecvcto else convert(date,'1900-01-01') end)
				,		'FEC_ULT_LIQ'			= cafecha
				,		'FEC_PRX_LIQ'			= (case when ltrim(rtrim(caantici))='A' then cafecvenor else cafecvcto end)
				,		'FEC_ULT_REV'			= cafecha
				,		'FEC_PRX_REV'			= (case when ltrim(rtrim(caantici))='A' then cafecvenor else cafecvcto end)
				,		'FEC_VEN'				= (case when ltrim(rtrim(caantici))='A' then cafecvenor else cafecvcto end)
				,		'FRE_PAGO_INT'			= pl.fre_pago_interes
				,		'COD_UNI_FRE_PAGO_INT'	= pl.cod_uni_fre_pago_int
				,		'FRE_REV_INT'			= pl.fre_rev_interes																									
				,		'COD_UNI_FRE_REV_INT'	= pl.cod_uni_fre_rev_int
				,		'PLZ_CONTRACTUAL'		= pl.plz_contractual
				,		'PLZ_AMRT'				= pl.plz_amortizacion
				,       'COD_UNI_PLZ_AMRT'		= pl.cod_uni_plz_amrt													
				,		'IMP_INI_MO'			= camtomon1		--CASE WHEN var_moneda2 > 0 AND ( cacodpos1 = 1 )  THEN 0  ELSE camtomon1  END
				,		'IMP_CUO_MO'			= 0				--camtomon1
				,		'IMP_CUO_INI_MO'		= camtomon1		--caequusd1
				,		'NUM_CUO_PAC'			= 1 --caplazo
				,		'NUM_CUO_PEND'			= (case 
														when convert(date,cafecvcto)<=@FECHA_PROC_FILTRO then 0
														else 1
												   end)
				,		'IMP_PAGO_ML'			= caequmon2
												/*
												(CASE	
													WHEN cacodmon1 = 999	THEN	(camtomon1 + cadiftipcam)
													WHEN cacodmon1 = 998	THEN	ROUND(((camtomon1 + cadiftipcam) * @vUF_FinMes),0)
													WHEN cacodmon1 = 13		THEN	ROUND(((camtomon1 + cadiftipcam) * @vDolar_obsFinMes),0)
													ELSE							ROUND(((camtomon1 + cadiftipcam) * (SELECT ISNULL(vmvalor,0) FROM #VALOR_TC_CONTABLE WHERE mncodmon = cacodmon1)),0)
												END	)*/
				,		'IMP_PAGO_MO'			= camtomon1 --cacodmon1
				-- MGM Cambio en el Indicador de Cancelacion
				,		'IND_CAN_ANT'			= (case when ltrim(rtrim(caantici))='A' then 1 else 5 end)
				-- MGM 30-07-2018
				,		'IND_TAS_PREDEF'		= 'N'
				,		'TAS_PREDEF'			= 0
				,		'IMP_INI_ML'			= case 
													when cacodmon1 in (998,999) then camtomon1
													else
														camtomon1 * (select top 1 vmvalor from ##RENT_VALOR_TC_CONTABLE where vmcodigo = cacodmon1)
												   end
												  /*
												  CASE	WHEN cacodmon1 = 999	THEN	camtomon1
														WHEN cacodmon1 = 998	THEN	ROUND(camtomon1 * @vUF_FinMes,0)
														WHEN cacodmon1 = 13		THEN	ROUND(camtomon1 * @vDolar_obsFinMes,0)
												  ELSE							
														ROUND(camtomon1 * (SELECT ISNULL(vmvalor,0) FROM #VALOR_TC_CONTABLE WHERE mncodmon = cacodmon1),0)
												  END
												  */
				,		'TAS_INT_ORIGEN'		=	0
				,		'COD_PORTAFOLIO'		=  cacodcart
				,		'DES_PORTAFOLIO'		=	(select tbglosa from bacparamsuda..tabla_general_detalle where tbcateg = 204 and tbcodigo1 = cacodcart)			
				,		'COD_NEMOTECNICO'		= NULL
				,		'COD_CARTERA_FINANCI'	= CASE WHEN cacodcart = 1 THEN 'TR'  -- Trading
													 WHEN cacodcart = 2 THEN 'PLP' -- Portfolio LP
													 WHEN cacodcart = 3 THEN 'ET' -- Estructuración
													 WHEN cacodcart = 4 THEN 'BL' -- BALANCE
													 WHEN cacodcart = 9 THEN 'PR' -- PROPIETARIO
													 WHEN cacodcart = 10 THEN 'PLO' -- PORTFOLIO LO 180
													 WHEN cacodcart = 13 THEN 'MT' -- MM TASA   -- REVISAR
													 WHEN cacodcart = 14 THEN 'MF' -- MM FX -- REVISAR
													 WHEN cacodcart = 16 THEN 'BGF' -- Balance Gestion Financiera -- REVISAR
													 ELSE
													 'BGL' -- Balance Gestion Liquidez -- REVISAR
													 END
					,		'COD_TIP_LIBRO'			= (CASE WHEN calibro = 1 THEN 'N' ELSE 'B' END) 
					,		NUM_DOC					= NULL	
					,		NUM_OPE_ANT				= NULL
					,		TFLUJO					= 1
--+++fmo 20180802 operaciones cartera historica vencidos
				from    bacfwdsuda..mfcah            cah        with(nolock)    
				left  join bacparamsuda.dbo.cliente				with(nolock) on	clrut= cacodigo and clcodigo = cacodcli   
				left  join bacfwdsuda..view_forma_de_pago  pg	with(nolock) on cafpagomn=pg.codigo 
				inner join bacfwdsuda..view_producto b			with(nolock) on	b.id_sistema= 'BFW' and b.codigo_producto = cacodpos1
				left  join @plazos_fwd	as pl on cah.canumoper = pl.canumoper
				where cah.cafecvcto between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
-----fmo 20180802 operaciones cartera historica vencidos
    )	Forward
	
	ORDER
	BY		Forward.NRO_OPERACION	
	

	/******************************************************************************/
	/*			DESPLIEGUE														  */
	/******************************************************************************/

	SELECT * FROM #TMP_DETALLE_FWD
	ORDER BY NRO_OPERACION

END
GO
