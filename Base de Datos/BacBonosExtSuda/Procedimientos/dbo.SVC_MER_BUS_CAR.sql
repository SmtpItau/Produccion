USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_MER_BUS_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SVC_MER_BUS_CAR]
(  
     @FECHA   CHAR(8)   
)
AS
BEGIN

	/*Prc: Obtine la informacion de la relacion de la tablas
       	Text_mvt_dri; text_rsu; text_ser, para llenar la grilla de 
	Tasa de Mercado incorporando los valores de sIsin,sCursip,sBBnums*/
	/*MAP 20171219
	  Se modifica para calcular Precio para los instrumentos
	  tipo Coltes
	  Se debe analizar el comportamiento de la pantalla
	  y ver si hay que programar algo distinto para COLTES.
	  Por ahora si hay precio en la grilla de valorizacion
	  valoriza por precio y se calcula en este 
	  procedimiento.
	*/

	SET NOCOUNT ON

	DECLARE @fechaTM	CHAR(8)
	,	@acFecProc	DATETIME 

	SELECT	@acFecProc	= acfecproc 
	FROM	text_arc_ctl_dri	

	SELECT @fechaTM = @fecha

	SELECT	rsu.rsfecpro	--1
	,	rsu.rsnumdocu	--2
	,	rsu.cod_familia	--3
	,	rsu.id_instrum	--4
	,	rsu.rsfecvcto	--5	 
	,	rsu.rsnominal	--6
	,	rsu.rsvppresen	--7
	,	rsu.rsrutcart	--8
	,	rsu.rstir	--9
	,	rsu.rspvp	--10
	,	rsu.rstirmerc	--11
	,	rsu.rspvpmerc	--12
	,	rsu.rsvalmerc	--13
	,	rsu.rsvalvenc	--14
	,	'CODIGO'				= ISNULL(	(CASE	WHEN rsu.SW_TIR = 0  AND rsu.SW_pvp = 1 THEN '10'
										WHEN rsu.SW_TIR = 1  AND rsu.SW_pvp = 0 THEN '9' END ), '0')
	,	'CODIDENT'				= CUSIP
	,	'sIsin'					= SPACE(15)	--ISNULL(ind.sIsin,'') sIsin 
	,	'sCursip'				= SPACE(15)	--ISNULL(ind.sCusip,'') sCursip
	,   'sBBnums'				= SPACE(15)	--ISNULL(ind.sBBnumber,'') sBBnums
	,	'FECTM'					= CONVERT(CHAR(10), CONVERT(DATETIME,@fecha),103)    
	,	'VPTCLT'				= ISNULL(clt_vptc_valact,0)
	,	'VPTMLT'				= ISNULL(clt_vptm_valact,0)
	,	'DIFLT'					= ISNULL(clt_res_vm_vp,0)
	,	'DifCLP'				= ((rsu.rsvalmerc - rsu.rsvppresen) * ISNULL((	SELECT	Tipo_Cambio
									FROM	BACPARAMSUDA..VALOR_MONEDA_CONTABLE (NOLOCK)
									WHERE	Fecha		= @acFecProc
										AND	Codigo_Moneda	= CASE WHEN rsmonemi = '13' THEN '994' ELSE rsmonemi END),0))
	,	'Libro'					= ISNULL((SELECT TBGLOSA FROM BACPARAMSUDA..TABLA_GENERAL_DETALLE WHERE TBCATEG = '1552' AND TBCODIGO1 = RSU.RsId_Libro),'')
	,	'CarteraSuper'			= ISNULL((SELECT TBGLOSA FROM BACPARAMSUDA..TABLA_GENERAL_DETALLE WHERE TBCATEG = '1111' AND TBCODIGO1 = RSU.codigo_carterasuper),'')
	,	'CarteraFin'			= ISNULL((SELECT TBGLOSA FROM BACPARAMSUDA..TABLA_GENERAL_DETALLE WHERE TBCATEG = '204' AND TBCODIGO1 = RSU.Tipo_Cartera_Financiera),'')
    ,   'Familia'				= TipIns.Nom_Familia
	,   'EsColtes'				= case when isnull( ser.coltes, 0 ) = 0 then 'NO' else 'SI' end   
	,   'CalculoTasaColTes'		= case when isnull( ser.coltes, 0 ) = 0 then 'No Aplica' else 'Falta    ' end
	,   'TasaEmision'			= ser.tasa_emis
	,   'CorrelativoTmp'		= IDENTITY(INT, 1,1)
	,   'FechaUltimoPago'		= rsu.rsfecucup
	,   'FechaProxPago'			= rsu.rsfecpcup
	,   'FechaEmision'			= ser.fecha_emis
	,   'MdaEmision'			= rsu.rsmonemi
	,	'marcaColtes'			= ISNULL(ser.coltes,0) --COLTES, 20171218 jcamposd
	INTO	#TEMPORAL
	FROM	TEXT_RSU	          rsu
                LEFT  JOIN TEXT_SER       ser ON ser.cod_familia = rsu.cod_familia AND ser.cod_nemo       = rsu.cod_nemo
				LEFT JOIN   text_fml_inm  TipIns ON rsu.Cod_familia = TipIns.Cod_familia
	        LEFT  JOIN TEXT_CTR_INV	  car ON (car.cpnumdocu = rsu.rsnumoper    AND car.cpcorrelativo	= rsu.rscorrelativo)
	        LEFT  JOIN BACTRADERSUDA..TBL_CARTERA_LIBRE_TRADING CTL
	ON    (clt_sistema		=  'BEX'
	AND		clt_fechaproc		=  @FECHA
	AND		clt_numoper		= rsu.rsnumoper
	AND		clt_numcorr		= rsu.rscorrelativo)
	WHERE	rsu.rsfecpro	= @fecha
	AND	rsu.rscartera		= '333'
    AND     rsu.rstipoper   = 'DEV'
        --+++jcamposd 20170130 debe solo valorizar los documento que no se encuentran vencidos
        AND cpfecven	> @FECHA
        -----jcamposd 20170130 debe solo valorizar los documento que no se encuentran vencidos
        
	ORDER	BY	
                rsu.id_instrum
	,	rsu.rsnumdocu 
	,	rsu.cod_familia

	CREATE NONCLUSTERED INDEX TEMP_001 ON #TEMPORAL (CODIDENT)

	/* Calcula tasa para los ColTes */
	DECLARE @dFecPro	DATETIME	,
		@TipFomulas		CHAR(1)		,
		@tipo_cal		FLOAT		,
		@cod_familia	NUMERIC(04)	,
		@cod_nemo		CHAR(20)	,
		@fecha_vcto		DATETIME	,
		@TR				FLOAT		,
		@TE				FLOAT		,
		@TV				FLOAT		,
		@TT				FLOAT		,
		@BA				FLOAT		,
		@BF				FLOAT		,
		@NOM			FLOAT		,
		@MT				FLOAT		,
		@VV				FLOAT		,
		@VP				FLOAT		,
		@PVP			FLOAT		,
		@VAN			FLOAT		,
		@FP				DATETIME	,
		@FE				DATETIME	,
		@FV				DATETIME	,
		@FU				DATETIME	,
		@FX				DATETIME	,
		@FC				DATETIME	,
		@CI				FLOAT		,
		@CT				FLOAT		,
		@INDEV			FLOAT		,
		@PRINC			FLOAT		,
		@INCTR			FLOAT		,
		@FIP			DATETIME	,
		@CAP			FLOAT		,
		@SPREAD			FLOAT		,
		@Retorno		CHAR(1)	= 'N'	,	
		@PX_IN			FLOAT		,
		@PX_AM			FLOAT		,
		@PRINC_PASO		FLOAT		,
		@INDEV_PASO		FLOAT		,
		@PX_IN_CUPON	FLOAT		,
		@PX_AM_CUPON	FLOAT		,
		@Factor         FLOAT           ,
		@Dur_Mac        FLOAT           ,
		@Dur_Mod        FLOAT           ,
		@Convexi        FLOAT  ,
		@monemi         NUMERIC(3),
		@corr           NUMERIC(10)
				
				         
    select @dFecPro = @fecha
	select @FP      = @fecha
	select @FC      = @fecha


	declare @Sale   numeric(2) = 1
	declare @Precio float

	while @Sale > 0
	Begin

		select top 1  @cod_familia = t.cod_familia
		,@cod_nemo		= t.id_instrum
		,@fecha_vcto	= t.rsfecvcto
		,@TE			= t.TasaEmision
		,@TV			= t.TasaEmision
		,@TT			= 0
		,@BA			= 0
		,@BF			= 365
		,@NOM			= t.rsnominal
		,@MT			= t.rsvppresen
		,@corr			= CorrelativoTmp
		,@FU			= FechaUltimoPago
		,@FX			= FechaProxPago
		,@fE			= FechaEmision
		,@FV			= t.rsfecvcto
		,@TR			= t.rstir
		,@VV			= t.rsnominal
		,@TT			= 0
		,@BA			= 365
		,@BF			= 365  
		,@VP			= 0 
		,@VAN			= 0					
		,@SPREAD		= 0
		,@FIP			= FechaUltimoPago
		,@CAP			= 0
		,@INDEV			= 0
		,@PRINC			= 0
		,@Ci			= 0
		,@CT			= 0
		,@Factor		= 0
		,@Dur_Mac		= 0
		,@Dur_Mod		= 0
		,@Convexi		= 0
		,@INCTR			= 0
		,@monemi		= t.MdaEmision
		,@PVP			= t.rspvp  --- ACA rescatar el 
		FROM #TEMPORAL t --- 
		WHERE CalculoTasaColTes = 'Falta    ' 

		UPDATE #TEMPORAL 
		SET CalculoTasaColTes = 'Realizada'
		WHERE CorrelativoTmp = @corr

		  -- Calculo de precio Limpio
		  -- Con Curva
		SELECT @PVP = isnull( dbo.Fx_PVP_COLTES(2,2000,@cod_nemo,@TR,@FP,@NOM,@PVP,@MT,@FV,@FE, 'S'), @PVP )

		UPDATE #Temporal
		SET   rspvpmerc = @PVP
        WHERE CorrelativoTmp = @corr
		
		IF @@ERROR<>0
		BEGIN
			-- ROLLBACK TRANSACTION
			SELECT 'NO','PROBLEMAS EN Svc_Prc_val_ins'
			RETURN
		END 

		SELECT @Sale = (select count(1) from #TEMPORAL where CalculoTasaColtes = 'Falta    ' and EsColtes = 'SI' ) 
	End

	UPDATE	#TEMPORAL
	SET	sISIN		= a.sIsin
		,sCURSIP	= a.sCusip
		,sBBnums	= a.sBBnumber
	FROM TEXT_Ident	a
	WHERE	CODIDENT	= a.cod_id
	-- and     cod_familia   <> 2001                                                              -- 20160808 MNAVARRO Parametrizacion
	and cod_familia in ( select Cod_familia from text_fml_inm where UsaIdInternacionalSN = 'S' )  -- 20160808 MNAVARRO Parametrizacion

	SELECT	rsfecpro	--1
	,	rsnumdocu	--2
	,	cod_familia	--3
	,	id_instrum	--4
	,	rsfecvcto	--5	 
	,	rsnominal	--6
	,	rsvppresen	--7
	,	rsrutcart	--8
	,	rstir		--9
	,	rspvp		--10
	,	rstirmerc	--11  -- Esta es la columna
	,	rspvpmerc	--12
	,	rsvalmerc	--13
	,	rsvalvenc	--14
	,	CODIGO
	,	SISIN
	,	SCURSIP
	,   SBBNUMS
	,	FECTM
	,	VPTCLT
	,	VPTMLT
	,	DIFLT
	,	DIFCLP
	,	LIBRO
	,	CARTERASUPER
	,	CARTERAFIN
	,   Familia
	,   EsColtes
	,   FechaEmision
	,	CorrelativoTmp
	,	marcaColtes	--31
	FROM	#TEMPORAL
	ORDER 	BY	
        familia,   id_instrum
	,	rsnumdocu 
	,	cod_familia

	SET NOCOUNT OFF

END

GO
