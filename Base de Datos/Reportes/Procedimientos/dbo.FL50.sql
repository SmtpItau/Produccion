USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[FL50]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--dbo.FL50 '2021-10-04'
CREATE PROCEDURE [dbo].[FL50] (@dFechaProceso DATETIME)
AS
BEGIN	

 	SET NOCOUNT ON
	--declare @dFechaProceso DATETIME
	--set @dFechaProceso ='20220329'
	Declare @TipoSalida bit = 0

	if @dFechaProceso is null  
	begin   
	 set @dFechaProceso =  (SELECT fecha_proceso FROM MDPASIVO..View_Datos_Generales)
	end  

	select vmcodigo, vmfecha,vmvalor 
	     into #VALOR_MONEDA
		from MDPASIVO..VIEW_VALOR_MONEDA
		 where vmfecha = @dFechaProceso

	insert #VALOR_MONEDA
		  select 13, vmfecha, vmvalor from #VALOR_MONEDA where vmcodigo = 994
		  union
		  select 999, @dFechaProceso, 1 

	/*DECLARACION DE VARIABLES*/
	DECLARE @monto_UF		NUMERIC(19,4)
	,		@monto_DO		NUMERIC(19,4)
	,		@CntReg			INT
	/*FIN DECLARACION*/

	SELECT @monto_UF = VMVALOR FROM MDPASIVO..VIEW_VALOR_MONEDA WHERE VMCODIGO = 998 AND VMFECHA = @dFechaProceso
	SELECT @monto_DO = VMVALOR FROM MDPASIVO..VIEW_VALOR_MONEDA WHERE VMCODIGO = 994 AND VMFECHA = @dFechaProceso

	CREATE TABLE #INT_SALIDA 
		(	REG_SALIDA	varchar(160)
		,	ORDEN		INT
		)

	CREATE TABLE #INT_FLU_OPE
		(	/*05*/	prod			CHAR(16)
		,	/*06*/	con_no			VARCHAR(20)
		,	/*07*/	coup_dt			DATETIME
		,	/*08*/	lcy_coup_amt	NUMERIC(19,2)
		,	/*09*/	lcy_amrt_amt	NUMERIC(19,2)
		,	/*10*/	Lcy_int_amt		NUMERIC(19,2)
		,	/*11*/	br				CHAR(4)
		,	/*12*/	cc				VARCHAR(10)
		)

	IF (SELECT Fecha_Proceso FROM MDPASIVO..VIEW_DATOS_GENERALES) = @dFechaProceso 
	BEGIN
	
		INSERT INTO #INT_FLU_OPE
		SELECT
		/*05*/	'prod'			=	'BONOS', 
		/*06*/	'con_no'		=	LTRIM(RTRIM(STR(p.numero_operacion)))+LTRIM(RTRIM(STR(p.numero_correlativo)))	,
		/*07*/	'coup_dt'		=	FB.Fecha_Vencimiento,
		/*08*/	'lcy_coup_amt'	=	ROUND(((FB.Amortizacion*P.nominal)/100)* 
		                                     isnull( V.VmValor, 1) , 0 )
									+ ROUND(((FB.Interes*P.nominal)/100) * isnull( V.VmValor, 1) , 0),
		/*09*/	'lcy_amrt_amt'	=	ROUND(((FB.Amortizacion*P.nominal)/100)* isnull( V.VmValor, 1) , 0),
		/*10*/	'Lcy_int_amt'	=	ROUND(((FB.Interes*P.nominal)/100)     * isnull( V.VmValor, 1) , 0),
		/*11*/	'br'			=	'0011',
		/*12*/	'cc'			=	REPLICATE('0',9)+'1'
		FROM	MDPASIVO..CARTERA_PASIVO P
                LEFT JOIN #VALOR_MONEDA V on vmcodigo = P.moneda_emision 
			,	MDPASIVO..FLUJO_BONOS FB
		WHERE	P.Codigo_Instrumento IN(1,15)
		AND	FB.Nombre_Serie = P.Nombre_Serie
		AND	FB.Fecha_Vencimiento >= @dFechaProceso	
		AND	P.nombre_serie NOT LIKE ('%GAST%')
	
		INSERT INTO #INT_FLU_OPE
		SELECT
		/*05*/	'prod'			=	glosa,
		/*06*/	'con_no'		=	LTRIM(RTRIM(STR(p.numero_operacion)))+LTRIM(RTRIM(STR(p.numero_correlativo)))	,
		/*07*/	'coup_dt'		=	p.Fecha_Vencimiento,
		/*08*/	'lcy_coup_amt'		=	presente_colocacion,
		/*09*/	'lcy_amrt_amt'		=	valor_colocacion_clp,
		/*10*/	'Lcy_int_amt'		=	interes_colocacion,
		/*11*/	'br'				=	'0011',
		/*12*/	'cc'				=	REPLICATE('0',9)+'1'
		FROM	MDPASIVO..CARTERA_PASIVO P
		,	MDPASIVO..instrumento_pasivo i
		WHERE	P.Codigo_Instrumento IN(11,9)
		and	P.Codigo_Instrumento=i.codigo_instrumento
		AND	P.nombre_serie NOT LIKE ('%GAST%')
	
		INSERT INTO #INT_FLU_OPE
		SELECT
		/*05*/	'prod'			=	(SELECT glosa FROM MDPASIVO..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento)  + (SELECT glosa FROM MDPASIVO..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) ,
		/*06*/	'con_no'		=	LTRIM(RTRIM(STR(p.numero_operacion)))+LTRIM(RTRIM(STR(p.numero_correlativo)))	, --P.Numero_Operacion,
		/*07*/	'coup_dt'		=	FB.cuota_vencimiento,
		/*08*/	'lcy_coup_amt'		=	ROUND( cuota_flujo   * isnull( V.vmvalor, 1 ) ,0),
		/*09*/	'lcy_amrt_amt'		=	ROUND( cuota_capital * isnull( V.vmvalor, 1 ) ,0),
		/*10*/	'Lcy_int_amt'		=	ROUND( cuota_interes * isnull( V.vmvalor, 1 ) ,0), 
		/*11*/	'br'				=	'0011',
		/*12*/	'cc'				=	REPLICATE('0',9)+'1'
		FROM	MDPASIVO..CARTERA_PASIVO P
		     LEFT JOIN #VALOR_MONEDA V on vmcodigo = P.moneda_emision 
		,	MDPASIVO..FLUJO_CREDITOS FB
		WHERE	P.Codigo_Instrumento NOT IN(1 , 15,11,9)
		AND	FB.numero_operacion = P.numero_operacion
		AND	FB.numero_correlativo = P.numero_correlativo
		AND	FB.cuota_vencimiento >= @dFechaProceso	
		AND	P.nombre_serie NOT LIKE ('%GAST%')
	END
	ELSE
	BEGIN
		INSERT INTO #INT_FLU_OPE
		SELECT
		/*05*/	'prod'			=		'BONOS',  
		/*06*/	'con_no'		=	LTRIM(RTRIM(STR(p.numero_operacion)))+LTRIM(RTRIM(STR(p.numero_correlativo)))	,
		/*07*/	'coup_dt'		=	FB.Fecha_Vencimiento,
		/*08*/	'lcy_coup_amt'	=	ROUND(((FB.Amortizacion*P.nominal)/100)* isnull( V.vmvalor, 1 ) ,0) 
								+	ROUND(((FB.Interes*P.nominal)/100) *     isnull( V.vmvalor, 1 ), 0),
		/*09*/	'lcy_amrt_amt'	=	ROUND(((FB.Amortizacion*P.nominal)/100)* isnull( V.vmvalor, 1 ) ,0),
		/*10*/	'Lcy_int_amt'	=	ROUND(((FB.Interes*P.nominal)/100)     * isnull( V.vmvalor, 1 ) ,0),
		/*11*/	'br'			=	'0011',
		/*12*/	'cc'			=	REPLICATE('0',9)+'1'
		FROM	MDPASIVO..CARTERA_PASIVO_HISTORICA P
		LEFT JOIN #VALOR_MONEDA V on V.vmcodigo = P.moneda_emision
		,	MDPASIVO..FLUJO_BONOS FB
		WHERE	P.Codigo_Instrumento IN(1,15)
		AND	FB.Nombre_Serie = P.Nombre_Serie
		AND	FB.Fecha_Vencimiento >= @dFechaProceso	
		AND	P.nombre_serie NOT LIKE ('%GAST%')
		AND 	P.fecha_cartera = @dFechaProceso

		INSERT INTO #INT_FLU_OPE
		SELECT
		/*05*/	'prod'			=	glosa,
		/*06*/	'con_no'		=	LTRIM(RTRIM(STR(p.numero_operacion)))+LTRIM(RTRIM(STR(p.numero_correlativo)))	,
		/*07*/	'coup_dt'		=	p.Fecha_Vencimiento,
		/*08*/	'lcy_coup_amt'		=	presente_colocacion,
		/*09*/	'lcy_amrt_amt'		=	valor_colocacion_clp,
		/*10*/	'Lcy_int_amt'		=	interes_colocacion,
		/*11*/	'br'				=	'0011',
		/*12*/	'cc'			=	REPLICATE('0',9)+'1'
		FROM	MDPASIVO..CARTERA_PASIVO_HISTORICA P
		,	MDPASIVO..instrumento_pasivo i
		WHERE	P.Codigo_Instrumento IN(11,9)
		AND	P.Codigo_Instrumento=i.codigo_instrumento
		AND	P.nombre_serie NOT LIKE ('%GAST%')
		AND 	P.fecha_cartera = @dFechaProceso
	
		INSERT INTO #INT_FLU_OPE
		SELECT
		/*05*/	'prod'			=	(SELECT glosa FROM MDPASIVO..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) + (SELECT glosa FROM MDPASIVO..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) ,
		/*06*/	'con_no'		=	LTRIM(RTRIM(STR(p.numero_operacion)))+LTRIM(RTRIM(STR(p.numero_correlativo)))	,--P.Numero_Operacion,
		/*07*/	'coup_dt'		=	FB.cuota_vencimiento,
		/*08*/	'lcy_coup_amt'		=	ROUND( cuota_flujo   * isnull( V.vmvalor, 1 ) ,0),
		/*09*/	'lcy_amrt_amt'		=	ROUND( cuota_capital * isnull( V.vmvalor, 1 ) ,0),
		/*10*/	'Lcy_int_amt'		=	ROUND( cuota_interes * isnull( V.vmvalor, 1 ) ,0), 
		/*11*/	'br'				=	'0011',
		/*12*/	'cc'				=	REPLICATE('0',9)+'1'
		FROM	MDPASIVO..CARTERA_PASIVO_HISTORICA P
		    LEFT JOIN #VALOR_MONEDA V on V.vmcodigo = P.moneda_emision
		,	MDPASIVO..FLUJO_CREDITOS FB
		WHERE	P.Codigo_Instrumento NOT IN(1,15,11,9)
		AND	FB.numero_operacion = P.numero_operacion
		AND	FB.numero_correlativo = P.numero_correlativo
		AND	FB.cuota_vencimiento >= @dFechaProceso	
		AND	P.nombre_serie NOT LIKE ('%GAST%')
		AND 	P.fecha_cartera = @dFechaProceso
	END

	INSERT INTO #INT_FLU_OPE
	SELECT
	/*05*/	'prod'			=	(SELECT glosa FROM MDPASIVO..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) + (SELECT glosa FROM MDPASIVO..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) ,
	/*06*/	'con_no'		=	LTRIM(RTRIM(STR(p.numero_operacion)))+LTRIM(RTRIM(STR(p.numero_correlativo)))	,
	/*07*/	'coup_dt'		=	FB.cuota_vencimiento,
	/*08*/	'lcy_coup_amt'	=	ROUND( cuota_flujo   * isnull( V.vmvalor, 1 ) ,0),
	/*09*/	'lcy_amrt_amt'	=	ROUND( cuota_capital * isnull( V.vmvalor, 1 ) ,0),
	/*10*/	'Lcy_int_amt'	=	ROUND( cuota_interes * isnull( V.vmvalor, 1 ) ,0), 
	/*11*/	'br'			=	'0011',
	/*12*/	'cc'			=	REPLICATE('0',9)+'1'
	FROM	MDPASIVO..MOVIMIENTO_PASIVO P
	 lEFT JOIN #VALOR_MONEDA V on V.vmcodigo =  P.moneda_emision
	,	MDPASIVO..FLUJO_CREDITOS FB
	WHERE	P.Codigo_Instrumento IN(111,230,224)
	AND	FB.numero_operacion = P.numero_operacion
	AND	FB.numero_correlativo = P.numero_correlativo
	AND	FB.cuota_vencimiento >= @dFechaProceso	
	AND     P.fecha_movimiento = @dFechaProceso
	AND     P.tipo_operacion = 'VEN'
	AND	P.nombre_serie NOT LIKE ('%GAST%')

	if @TipoSalida != 0
	SELECT  
	/*01*/	  	'CL '									as ctry
	/*02*/	,	CONVERT(char(8),@dFechaProceso,112)		as intf_dt	
	/*03*/	,	'FLC3'	+ SPACE(10)						as src_id
   	/*04*/ 	,	'001'									as cem
	/*05*/ 	,	'MD01' + SPACE(12)			--prod			
	/*06*/ 	,	left(con_no+space(20), 20)				as con_no
 	/*07*/ 	,	CONVERT(char(8),coup_dt,112)			as coup_dt
			, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_coup_amt*100))),19)		as lcy_coup_amt	--8
			, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_amrt_amt*100))),19)		as lcy_amrt_amt	--9
			, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(Lcy_int_amt*100))),19)		as Lcy_int_amt	--10
	/*11*/ 	,	br	--'1  '
	/*12*/ 	,	cc	--SPACE(10)
	,		0	--> Para Establecer un Orden	
	FROM #INT_FLU_OPE --order by cem, prod, con_no
	else
	begin

	INSERT INTO #INT_SALIDA
	SELECT 
	/*01*/	  	'CL '	 
	/*02*/	+	CONVERT(char(8),@dFechaProceso,112)  	
	/*03*/	+	'FLC3'	+ SPACE(10) 
   	/*04*/ 	+	'001'	
	/*05*/ 	+	'MD01' + SPACE(12)		-- prod CONVERT(CHAR(16),'MD01')
	/*06*/ 	+	CONVERT(CHAR(20),con_no)
 	/*07*/ 	+	CONVERT(char(8),coup_dt,112)
			+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_coup_amt*100))),19)		--8
			+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(lcy_amrt_amt*100))),19)		--9
			+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),abs(Lcy_int_amt*100))),19)		--10
	/*11*/ 	+	br	--'1  '
	/*12*/ 	+	cc	--SPACE(10)
	,		0	--> Para Establecer un Orden	
	FROM	#INT_FLU_OPE

	SELECT @CntReg	=(SELECT COUNT(*) FROM #INT_FLU_OPE )+1

--	INSERT INTO #INT_SALIDA 
--	SELECT	'99' + CONVERT(CHAR(8),@dFechaProceso,112) + RTRIM(REPLICATE('0',10 - LEN (@CntReg))+ CONVERT(CHAR,CONVERT(NUMERIC,@CntReg))) + SPACE(119)
--		,	1	 --> Para Establecer un Orden

	SELECT REG_SALIDA FROM #INT_SALIDA ORDER BY ORDEN
	END

drop table #VALOR_MONEDA
drop table #INT_SALIDA
drop table #INT_FLU_OPE

END

GO
