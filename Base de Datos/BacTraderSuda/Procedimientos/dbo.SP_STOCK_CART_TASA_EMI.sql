USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_STOCK_CART_TASA_EMI]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_STOCK_CART_TASA_EMI] (@cFecRep CHAR(08))
AS 
BEGIN

SET NOCOUNT ON
	DECLARE @fPvp  FLOAT  ,
	  	@fMT  FLOAT  ,
		@fMTUM  FLOAT  ,
		@fMT_cien FLOAT  ,
		@fVan  FLOAT  ,
		@fVpar  FLOAT  ,
		@nNumucup INTEGER  ,
		@fIntucup FLOAT  ,
		@fAmoucup FLOAT  ,
		@fSalucup FLOAT  ,
		@nNumpcup INTEGER  ,
		@fIntpcup FLOAT  ,
		@fAmopcup FLOAT  ,
		@fSalpcup FLOAT  ,
		@fDurat  FLOAT  ,
		@fConvx  FLOAT  ,
		@fDurmo  FLOAT  ,
		@nError  INTEGER,
		@cProg   CHAR(10),
		@codigo  INT,
		@xfecemi DATETIME,
		@ntasemi FLOAT,
		@nbase	 NUMERIC(04),
		@ntasest FLOAT,
		@Nominal NUMERIC(19,4),
		@xTir	 NUMERIC(09,4),
		@dFecRep DATETIME,
		@Fecven	 DATETIME,
		@dFecucup DATETIME,
		@instser  CHAR(12),
		@monemis  NUMERIC(04),
		@dFecpcup DATETIME,
		@nVTasEmHoy NUMERIC(19),
		@nDiasDev  NUMERIC(04),
		@FecPg   datetime,
		@FecPago datetime

        DECLARE @ACFECPROC CHAR(10), @ACFECPROX   CHAR(10), @UF_HOY FLOAT , @UF_MAN FLOAT, @IVP_HOY FLOAT,
		   @IVP_MAN   FLOAT   , @DO_HOY      FLOAT   , @DO_MAN FLOAT , @DA_HOY FLOAT, @DA_MAN FLOAT,
		   @ACNOMPROP CHAR(40), @RUT_EMPRESA CHAR(12), @HORA   CHAR(8),@FECHA_HOY char(10),
                   @NomProp CHAR(50) ,  @RutProp CHAR(12)

	DECLARE @dFecPrx     	DATETIME,
		@nCont	     	INT,
		@n	     	INT,
		@cEstado 	CHAR(01),
		@nMtoaDif       NUMERIC(19,0),
		@nPlazoTot    	INT,
		@nMoneda_Hoy    FLOAT,
		@nMoneda_Man  	FLOAT,
		@nPlazoTran   	INT,
		@nCapitalTe	NUMERIC(19,0),
		@nCapitalTeuM	NUMERIC(19,0),
		@nMtoDifDia 	NUMERIC(19,0),
		@nPagcup 	NUMERIC(19,0),
		@nCapTasEmiUm	NUMERIC(19,0),
		@nVpteTasaEmiPx NUMERIC(19,0),
		@nReajTasEmiPx 	NUMERIC(19,0),
		@nInteTasEmiPx 	NUMERIC(19,0),
		@dFecPc		DATETIME,
		@nMtoDifDiaAcu	NUMERIC(19,0)

	SELECT @dFecRep = CONVERT(Datetime,@cFecRep)
        SELECT @dFecPrx = acfecprox FROM MDAC

	EXECUTE dbo.sp_Base_Del_Informe 
		@acfecproc OUTPUT, @acfecprox   OUTPUT, @uf_hoy OUTPUT, @uf_man OUTPUT, @ivp_hoy  OUTPUT , 
		@ivp_man   OUTPUT, @do_hoy      OUTPUT, @do_man OUTPUT, @da_hoy OUTPUT, @da_man   OUTPUT , 
                @acnomprop OUTPUT, @rut_empresa OUTPUT, @hora   OUTPUT


	-- STOCK PROPIO
	SELECT 	NUMDOCU 	= lTrim(rtrim(Convert(Char(10),cpnumdocu))) + '-' + lTrim(rtrim(Convert(Char(03),cpcorrela))) ,
		CORRELA		= cpcorrela,
		INSTSER		= RTRIM(cpinstser) + (case when Fecha_pagomañana > @dFecRep THEN ' *' ELSE '' END),
--		fecha_operacion = Fecha_pagomañana,
		fecha_operacion = cpfeccomp		,
		monemi		= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0) END),
		UM		= Space(10),
		NOMINAL		= cpnominal + isnull((select sum(vinominal) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		VALORCOMPRA	= cpvalcomp + isnull((select sum(vivalcomp) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		CAPITAL_TE_UM	= Convert(numeric(19,4),0),
		CAPITAL_TE_PE	= isnull(Capital_Tasa_Emi,0) + isnull((select sum(Mdvi.Capital_Tasa_Emi) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		TIRCOMP		= cptircomp,
		TASAEMI		= CONVERT(Numeric(9,4),0),
		VPTASAEMI	= cpvptasemi,
		INTTASAEMI	= Convert(numeric(19,0),0),
		REATASAEMI	= Convert(numeric(19,0),0),
		DIFDIARIO	= Convert(numeric(19,0),0),
		DIFACUM		= Convert(numeric(19,0),0),
		MTOADIF		= Valor_a_Diferir,
		FECCOMP		= cpfeccomp,
		MASCARA		= cpmascara,
		FECVENC		= cpfecven,
		CODIGO		= cpcodigo,
		FECEMI		= cpfecemi,
		BASE		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
		FECPCUP		= cpfecpcup,
		PLAZORES	= Datediff(day,acfecproc,cpfecven),
		ORDEN		= CASE WHEN Valor_a_Diferir >= 0 THEN 1 ELSE 2 END, 
                NomProp		= (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --acnomprop,
                RutProp		= Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
		acfecproc	= @dFecRep,
		HORA		= CONVERT(CHAR(8),getdate(),108),
                UF_HOY          = @uf_hoy,
          	IVP_HOY  	= @ivp_hoy,
                DO_HOY  	= @do_hoy,
                DA_HOY  	= @da_hoy,
		FecPago		= Fecha_pagomañana,
		Flag		= IDENTITY(INT)
	INTO #PASO
	FROM MDCP,Mdac
	WHERE --Fecha_pagomañana <= @dFecRep AND 
              (SUBSTRING (cpinstser,1,3) = 'ITA' OR SUBSTRING (cpinstser,1,3) = 'COR') AND cpcodigo = 20


/* Momentaneamente se excluye este parrafo hasta definir bien si van o no las ventras pm
	-- Actualiza las operaciones ventas definitivas PM 
	UPDATE #PASO
	SET 	#PASO.NOMINAL		= #PASO.NOMINAL + Isnull( (SELECT SUM(NOMINAL) FROM TABLA_VENTAS WHERE numdocu = #PASO.numdocu And correla = #PASO.correla and Serie = Instser And TIPO_LISTADO = 'S' And Fechapago = @dFecPrx) ,0),
		#PASO.PRECIO_OP_UM	= #PASO.PRECIO_OP_UM + isnull( (SELECT SUM(VALORCONTABLE) FROM TABLA_VENTAS WHERE numdocu = #PASO.numdocu And correla = #PASO.correla and Serie = Instser And TIPO_LISTADO = 'S' And Fechapago = @dFecPrx) ,0),
		#PASO.PRECIO_OP	= #PASO.PRECIO_OP + isnull( (SELECT SUM(VALORCONTABLE) FROM TABLA_VENTAS WHERE numdocu = #PASO.numdocu And correla = #PASO.correla and Serie = Instser And TIPO_LISTADO = 'S' And Fechapago = @dFecPrx) ,0),
		#PASO.INTERES		= #PASO.INTERES + isnull( (SELECT SUM(VALORCONTABLE) FROM TABLA_VENTAS WHERE numdocu = #PASO.numdocu And correla = #PASO.correla and Serie = Instser And TIPO_LISTADO = 'S' And Fechapago = @dFecPrx) ,0),
		#PASO.ValorCont	= #PASO.ValorCont + isnull( (SELECT SUM(VALORCONTABLE) FROM TABLA_VENTAS WHERE numdocu = #PASO.numdocu And correla = #PASO.correla and Serie = Instser And TIPO_LISTADO = 'S' And Fechapago = @dFecPrx) ,0),
		#PASO.VerVp		= CASE WHEN #PASO.numdocu = a.numdocu and #PASO.correla = a.correla and a.Tipo_listado = 'S' and a.FechaPago = @dFecPrx THEN ' ' ELSE 'X' END
	FROM TABLA_VENTAS a
	WHERE Orden = 1 and a.numdocu = #PASO.numdocu And a.correla = #PASO.correla and Serie = a.Instser And a.TIPO_LISTADO = 'S' And a.Fechapago = @dFecPrx  
*/


	UPDATE #PASO
	SET CAPITAL_TE_UM = Round( (CAPITAL_TE_PE/(SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = monemi AND vmfecha = fecha_operacion)),4),
	    TASAEMI       = (Select setasemi FROM View_Serie Where Semascara = MASCARA),
	    UM		  = mnnemo FROM VIEW_MONEDA WHERE monemi = mncodmon

	SELECT @nCont = Max(Flag) From #Paso
	SELECT @n = Min(Flag) from #Paso

	WHILE @n <= @nCont
	Begin
		SELECT @cEstado = '*'




		SELECT 	@nMtoaDif = MTOADIF,
		  	@nPlazoTot     = Datediff(day,fecha_operacion,FECVENC),
		  	@nPlazoTran    = Datediff(day,fecha_operacion,@dFecRep),
			@nDiasDev      = Datediff(day,@dFecRep,@dFecPrx),
		  	@nCapitalTe    = CAPITAL_TE_PE,
			@nCapitalTeuM  = CAPITAL_TE_UM,
			@cProg         = 'SP_' + Isnull((SELECT inprog From View_Instrumento Where incodigo = codigo),'') ,
          		@codigo        = Codigo,
			@xfecemi       = FECEMI,
			@Fecven        = FECVENC,
			@ntasemi       = TASAEMI,
			@nbase	       = BASE,
			@ntasest       = 0.0,
			@Nominal       = NOMINAL,
			@xTir	       = TIRCOMP,
			@nVTasEmHoy    = VPTASAEMI,
			@monemis       = monemi,
			@dFecPc	       = FECPCUP,
			@instser       = INSTSER,
			@FecPago       = FecPago,
		  	@cEstado       = ' '
		FROM #PASO
		WHERE Flag = @n

		IF @cEstado = '*' BREAK 
			SELECT @FecPg = (CASE WHEN @FecPago > @dFecRep THEN @FecPago ELSE @dFecRep END)

		  	SELECT @nMoneda_Hoy   = vmvalor FROM View_Valor_moneda Where vmcodigo = @monemis and vmfecha = @FecPg
		  	SELECT @nMoneda_Man   = vmvalor FROM View_Valor_moneda Where vmcodigo = @monemis and vmfecha = @dFecPrx

			Select 	@fPvp = 0,@fMt = 0,@fMtum = 0,@fMt_cien = 0,@fVan = 0,@fVpar = 0,@nNumucup = 0,@dFecucup = '',
		   		@fIntucup = 0,@fAmoucup = 0,@fSalucup = 0,@nNumpcup = 0,@fIntpcup = 0,@fAmopcup = 0,@fSalpcup = 0,
		   		@fDurat   = 0,@fConvx   = 0,@fDurmo   = 0

   	   		EXECUTE @nError = @cProg 2, @dFecPrx, @codigo,@instser, @monemis, @xfecemi, @Fecven,
       		   		@ntasemi, @nbase, @ntasest,@Nominal OUTPUT, @xTir OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
           	   		@fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
           	   		@fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
           	   		@fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

			IF @dFecPc >= @dFecPrx 
				SELECT @nPagcup = ROUND( (@fIntucup + @fAmoucup) * @nMoneda_Man, 0)
			ELSE
				SELECT @nPagcup = 0

			SELECT @nVpteTasaEmiPx = Round( ((@fVpar*@Nominal)/100)*@nMoneda_Man,0)
		        SELECT @nReajTasEmiPx = ROUND(( @nMoneda_Man - @nMoneda_Hoy ) * @nCapitalTeuM, 0)     -- del Día
			SELECT @nInteTasEmiPx =  ((@nVpteTasaEmiPx+@nPagcup) - @nVTasEmHoy - @nReajTasEmiPx ) -- del Día

			SELECT 	@nMtoDifDiaAcu =  Round( (@nMtoaDif/@nPlazoTot) * @nPlazoTran,0 )
			SELECT 	@nMtoDifDia =  Round( (@nMtoaDif/@nPlazoTot) * @nDiasDev,0 )

			UPDATE #PASO
			SET 	DIFDIARIO	= @nMtoDifDia,
				DIFACUM		= @nMtoDifDiaAcu,
				INTTASAEMI	= @nInteTasEmiPx,
				REATASAEMI	= @nReajTasEmiPx
			WHERE Flag = @n
			SELECT @n = @n + 1
	END



/*	DECLARE @COUNT INT

	SET @COUNT = (select * from #PASO)



	IF @COUNT <> 0
		BEGIN*/

			SELECT * FROM #PASO ORDER BY ORDEN,MTOADIF
/*
		END

	ELSE

		BEGIN

			SELECT 	NUMDOCU 	    = '',
				    CORRELA		    = '',
				    INSTSER		    = '',
				    fecha_operacion = '',
				    monemi		    = '',
				    UM		        = '',
				    NOMINAL		    = '',
				    VALORCOMPRA	    = '',
				    CAPITAL_TE_UM	= '',
				    CAPITAL_TE_PE	= '',
				    TIRCOMP		    = '',
				    TASAEMI		    = '',
				    VPTASAEMI	    = '',
				    INTTASAEMI	    = '',
				    REATASAEMI	    = '',
				    DIFDIARIO	    = '',
				    DIFACUM		    = '',
				    MTOADIF		    = '',
				    FECCOMP		    = '',
				    MASCARA		    = '',
				    FECVENC		    = '',
				    CODIGO		    = '',
				    FECEMI		    = '',
				    BASE		    = '',
				    FECPCUP		    = '',
				    PLAZORES	    = '',
				    ORDEN		    = '', 
				    NomProp		    = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --acnomprop,
					RutProp		    = '',
				    acfecproc	    = '',
				    HORA		    = '',
					UF_HOY          = '',
          			IVP_HOY  	    = '',
					DO_HOY  	    = '',
					DA_HOY  	    = '',
				    FecPago		    = '',
				    Flag	        = ''

		END*/
END
-- Base de Datos --

GO
