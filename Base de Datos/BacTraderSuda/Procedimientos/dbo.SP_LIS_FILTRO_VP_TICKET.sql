USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIS_FILTRO_VP_TICKET]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LIS_FILTRO_VP_TICKET]
	(
   		@iCodMesa	SMALLINT =0  
   	,	@iCodCartera	SMALLINT=0		
	,	@sqlfami1       VARCHAR(255)=''
   	, 	@sqlmone1       VARCHAR(255)=''
   	,	@sqlseri1       CHAR(255)='' 
	)
AS
BEGIN

	SET NOCOUNT ON	;

	DECLARE @nError         NUMERIC(02,0)
	,	@hwnd2          NUMERIC(09,0)
	,	@rutcart        NUMERIC(09,0)
	,	@tipcart        NUMERIC(05,0)
	,	@numdocu        NUMERIC(10,0)
	,	@correla        NUMERIC(03,0)
	,	@numdocuo       NUMERIC(10,0)
	,	@correlao       NUMERIC(03,0)
	,	@nominal        NUMERIC(19,4)
	,	@tircomp        NUMERIC(19,4)
	,	@pvpcomp        NUMERIC(19,2)
	,	@vptirc         NUMERIC(19,4)
	,	@pvpmcd         NUMERIC(19,2)
	,	@tirmcd         NUMERIC(19,4)
	,	@vpmcd          NUMERIC(19,4)
	,	@vptirci        NUMERIC(19,4)
	,	@numucup        NUMERIC(03,0)
	,	@interesc       NUMERIC(19,4)
	,	@reajustc       NUMERIC(19,4)
	,	@intereci       NUMERIC(19,4)
	,	@reajusci       NUMERIC(19,4)
	,	@capitalc       NUMERIC(19,4)
	,	@capitaci       NUMERIC(19,4)
	,	@codigo         NUMERIC(03,0)
	,	@tasest         NUMERIC(09,4)
	,	@rutemi         NUMERIC(09,0)
	,	@monemi         NUMERIC(03,0)
	,	@tasemi         NUMERIC(09,4)
	,	@basemi         NUMERIC(03,0)
	,	@Contador       NUMERIC(19,4)		;


	DECLARE @mascara        CHAR(12)
	,	@usuario        CHAR(20)
	,	@usuario2       CHAR(20)
	,	@tipoper        CHAR(03)
	,	@serie          CHAR(12)
	,	@instser        CHAR(12)
	,	@genemi         CHAR(10)
	,	@nemmon         CHAR(05)
	,	@fecemi         CHAR(10)
	,	@fecven         CHAR(10)
	,	@cseriado       CHAR(01)
	,	@fecpcup        CHAR(10)
	,	@fecsal         CHAR(10)		;

	DECLARE @vpmcd100       REAL			;


	DECLARE @xfecpcup       DATETIME		
	,	@fecproc        DATETIME		;
		
	DECLARE @x              INTEGER
	,	@y              INTEGER			;



	DECLARE @sqlfijo1       VARCHAR(255)
	,	@sqlfijo2       VARCHAR(255)
	,	@sqlfijo3       VARCHAR(255)		;

	
	SET @fecproc  = (SELECT acfecproc FROM MDAC)	;


	SET @xfecpcup 	= ''				;
	SET @x 		= 0				;
	SET @y 		= 0				;
	SET @Contador 	= 0				;


	CREATE TABLE #temp2 (
		nerror  	NUMERIC(02,0)  	NULL,
                hwnd2  		NUMERIC(09,0)  	NULL,
                usuario2	CHAR(20)  	NULL,
                rutcart  	NUMERIC(9,0)  	NULL,
                tipcart  	NUMERIC(1,0)  	NULL,
                numdocu  	NUMERIC(9,0)  	NULL,
                correla  	NUMERIC(3,0)  	NULL,
                numdocuo 	NUMERIC(9,0)  	NULL,
                correlao 	NUMERIC(3,0)  	NULL,
                tipoper  	CHAR    (03)  	NULL,
                seserie  	CHAR(12)  	NULL,
                instser  	CHAR(12)  	NULL,
                genemi  	CHAR(05)  	NULL,
                nemmon  	CHAR(05)  	NULL,
                nominal  	NUMERIC(19,4)  	NULL,
                tircomp  	NUMERIC(19,4)  	NULL,
                pvpcomp  	NUMERIC(19,4)  	NULL,
                vptirc  	NUMERIC(19,4)  	NULL,
                pvpmcd  	NUMERIC(19,4)  	NULL,	
                tirmcd  	NUMERIC(19,4)  	NULL,
                vpmcd100 	NUMERIC(19,4)  	NULL,
                vpmcd  		NUMERIC(19,4)  	NULL,
                vptirci  	NUMERIC(19,4)  	NULL,
                fecsal  	CHAR(10)  	NULL,
                numucup  	NUMERIC( 5,0)  	NULL,
                interesc 	NUMERIC(19,4)  	NULL,
                reajustc 	NUMERIC(19,4)  	NULL,
                intereci 	NUMERIC(19,4) 	NULL,
                reajusci 	NUMERIC(19,4)  	NULL,
		capitalc 	NUMERIC(19,4)  	NULL,
                capitaci 	NUMERIC(19,4)  	NULL,
                codigo  	NUMERIC(03,0)  	NULL,
                mascara  	CHAR(12)  	NULL,
    		tasest  	NUMERIC(19,4)  	NULL,
                rutemi  	NUMERIC( 9,0)  	NULL,
                monemi  	NUMERIC(03,0)  	NULL,
                tasemi  	NUMERIC(09,4)  	NULL,
                basemi  	NUMERIC(03,0)  	NULL,
                fecemi  	CHAR(10)  	NULL,
                fecven  	DATETIME 	NULL,
		fecpcup  	CHAR(10)  	NULL,
		bloq  		CHAR(1)   	NULL,
		diasdisp 	NUMERIC(5,0)  	NULL,
		custodia_dcv 	CHAR(01)  	NULL,
		seriados 	CHAR(01)  	NULL,																																								
		convexidad 	FLOAT   	NULL,
		durationMAC 	FLOAT   	NULL,
		durationMOD 	FLOAT   	NULL,
		nombre_carterasuper CHAR(20)  	NULL,
		id_libro	CHAR(06) 	NULL,
		Modalidad_Pago	CHAR(1)  	)



	INSERT INTO #temp2 
        SELECT DISTINCT  ISNULL(@nError,0) 	,
               ISNULL(@hwnd2,0)      	,       
               ISNULL(@usuario2,'')   	,       
		acrutprop		,	-- Ac
               0			,
               car.numero_documento		,
               car.correlativo		,
               car.numero_documento		,
               car.correlativo		,
               'CP'			,
               ins.inserie      		,  -- view_instr
               car.Nemotecnico    		,
               ''			,
               mnnemo	,	
               car.VALOR_NOMINAL 		,
               car.tir			,			
               car.pvp			,
               car.valor_presente		,
               car.PVP			,
               car.TIR			,
               0     	    		,
               car.valor_presente		,
               car.valor_presente		,
               CONVERT(CHAR(10),car.Fecha_Vencimiento,103),
               car.NumeroUltCupon    		,
               0            		,
               0	    		,
		0			,
		0	    		,
               	car.valor_presente		,
               	car.valor_presente		,
	       	car.codigoInstrumento,
	       	car.mascara   	 	,
	       	car.Tir_Estimada     		,
		CASE 
			WHEN car.seriado = 'S'  THEN (SELECT distinct serutemi FROM view_serie WHERE semascara = car.mascara)
			ELSE mov.Rut_Emision    END,  -- Rut de Emisor
		CASE 
			WHEN car.seriado = 'S'  THEN (SELECT distinct semonemi FROM view_serie WHERE semascara = car.mascara)
			ELSE mov.Moneda_Emision END,
		CASE 
			WHEN car.seriado = 'S'  THEN (SELECT distinct setasemi FROM view_serie WHERE semascara = car.mascara)
			ELSE mov.Tasa_Emision END,
		CASE 
			WHEN car.seriado = 'S'  THEN (SELECT distinct sebasemi FROM view_serie WHERE semascara = car.mascara)
			ELSE mov.Base_Emision END,
		CONVERT(CHAR(10),mov.fecha_emision,103)	,
		mov.Fecha_Vencimiento			,
		CONVERT(CHAR(10),car.FechaUltCupon,103)		,
		' ',
		DATEDIFF(day,acfecproc,mov.Fecha_Vencimiento),
		'N',
		car.Seriado	,
		Convexidad                                             ,
		Duration                                              ,
		DurationMod                                           ,
		' ',
		0, 
		car.PagoHoy		
		
	 FROM 	tbl_carticketrtafija 	car , 
		tbl_movticketrtafija 	mov ,
	      	mdac			ac  ,			
		VIEW_MONEDA		mon ,
		VIEW_INSTRUMENTO	ins
	WHERE car.valor_nominal > 0
	  AND mov.numero_documento = car.numero_documento
	  AND mov.correlativo = car.correlativo 
	  AND mov.Tipo_Operacion = 'CP'
	  AND ins.incodigo = car.codigoInstrumento 
	  AND mon.mncodmon = car.moneda
	  AND ( CHARINDEX(RTRIM(LTRIM(inserie)),@sqlfami1) > 0 )
	  AND ( CHARINDEX(RTRIM(LTRIM(mnnemo)),@sqlmone1) > 0 )
	  AND car.CodCarteraOrigen  = @iCodCartera
	  AND car.CodMesaOrigen     = @iCodMesa


--	select * from #temp2

	IF @sqlseri1 = 'VACIO'
	BEGIN

		SELECT * 
	 	  INTO #tem_seri 
		  FROM #temp2 
		 WHERE codigo in (6,7,9,11,13,14) 
	      ORDER BY fecven

		INSERT #tem_seri 
		SELECT * 
		  FROM #temp2 
		 WHERE codigo not in (6,7,9,11,13,14) 
	      ORDER BY instser 

		SELECT  		
 			nerror 		, 
        	        hwnd2		,
	                usuario2	,
	                rutcart		,
	                tipcart		,
	                numdocu		,
	                correla		,
	                numdocuo	,
	                correlao	,
	                tipoper		,
	                seserie		,
	                instser  	,
	                genemi  	,
			nemmon  	,
	                nominal  	,
	                tircomp  	,
	                pvpcomp  	,
	                vptirc  	,
	                pvpmcd  	,
	                tirmcd  	,
	                vpmcd100 	,
	                vpmcd  		,
	                vptirci 	,
	                fecsal  	,
	                numucup  	,
	                interesc 	,
	                reajustc 	,
	                intereci 	,
	                reajusci 	,
	                capitalc 	,
	                capitaci 	,
	                codigo  	,
	                mascara  	,
	                tasest  	,
	                rutemi  	,
		        monemi  	,
	                tasemi  	,
	                basemi  	,
	                fecemi  	,
	                CONVERT(CHAR(10	),fecven,103),
			fecpcup  	,
			bloq  		,
			diasdisp 	,
			custodia_dcv 	,
			seriados 	,
			convexidad 	,
			durationMAC 	,
			durationMOD 	,
			nombre_carterasuper ,
			id_libro 	,
			Modalidad_Pago
		FROM 	#tem_seri 
		ORDER BY instser

	END 
	ELSE 	
	BEGIN
		DECLARE @sqlaux 	VARCHAR(255)
		,	@sqlaux2 	VARCHAR(255)	;

		DECLARE @cont 		INTEGER		;

		SET @sqlaux2 = ''

       		WHILE 1 = 1 BEGIN

			SET @cont =  CHARINDEX(';',@sqlseri1)

			IF @cont = 0 BEGIN
				BREAK
			END

			SELECT @sqlaux = CHAR(39) + SUBSTRING( @sqlseri1, 1, @cont - 1) + CHAR(39) + ' OR instser = '
			SELECT @sqlaux2 = @sqlaux2 + @sqlaux
			SELECT @sqlseri1 = RTRIM(SUBSTRING(@sqlseri1,@cont + 1,LEN(@sqlseri1))) 
       
		END

		SELECT @sqlaux = RTRIM(SUBSTRING(@sqlaux2,1,LEN(@sqlaux2)-13)) 
		EXECUTE ('SELECT * FROM #temp2 WHERE instser = ' + @sqlaux + ' ORDER BY instser' )

	END

	SET NOCOUNT OFF

END

GO
