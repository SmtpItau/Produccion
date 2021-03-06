USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAOPERACION_TICKETINTRAMESA_COMPRAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAOPERACION_TICKETINTRAMESA_COMPRAS]
	( 	@nNumOper 			NUMERIC(10,0)
	,	@ncorrela 			NUMERIC(03,0)
	,	@sTipoper			VARCHAR(03)
	,	@nNumoperRel			NUMERIC(10,0)
	,	@dFechaOperacion		DATETIME
	,	@iCodCarteraOrigen		SMALLINT
	,	@iCodMesaOrigen			SMALLINT
	,	@iCodCarteraDestino		SMALLINT
	,	@iCodMesaDestino		SMALLINT
	,       @cmascara 			CHAR (12)      	= ''	-- familia del instrumento
	,       @cinstser 			CHAR (12)      	= ''    -- serie
        ,	@cgenemi 			CHAR (10)      	= ''    -- generico del emisor
        ,  	@cnemomon 			CHAR (05)      	= ''    -- generico de la moneda
        ,  	@nnominal 			NUMERIC (19,4) 	= 00    -- nominles  
        ,  	@ntir  				NUMERIC (19,4) 	= 00    -- tir de compra 
        ,  	@npvp 			 	NUMERIC (19,2) 	= 00    -- porcentaje valor presente
        ,  	@nvpar  			NUMERIC (19,8) 	= 00    -- valor par
        ,  	@nvptirc			FLOAT          	= 00    -- valor presente a tir de compra
        ,  	@nnumucup 			NUMERIC (03,0) 	= 00    -- numero del oltimo  cuprn vencido
        ,  	@cfecpro 			DATETIME       	= ''    -- fecha de proceso
        ,  	@ntasest 			NUMERIC (09,4) 	= 00    -- tasa estimada
        ,  	@cfecemi			DATETIME       	= ''    -- fecha de emisirn
        ,  	@cfecven 			DATETIME       	= ''    -- fecha de vencimiento
        ,  	@cmdse  			CHAR (01) 	= ''    -- indica si es seriado o no
        ,  	@ncodigo 			NUMERIC (05) 	= 00    -- codigo de la familia
        ,  	@cserie  			CHAR (12) 	= ''    -- serie de la familia
        ,  	@nmonemi			NUMERIC (03) 	= 00    -- moneda del emisor
        ,  	@nrutemi 			NUMERIC (09) 	= 00 	-- rut del emisor
        ,  	@ntasemi			NUMERIC (09,4) 	= 00    -- tasa estimada
        ,  	@nbasemi			NUMERIC (03) 	= 00    -- base estimada
        ,  	@cusuario 			CHAR  (12) 	= ''    -- usuario
        ,  	@cterminal			CHAR (12) 	= ''    -- terminal
        ,  	@dfecpcup			DATETIME 	= ''    -- fecha de cup½n
        ,  	@dconvexidad 			FLOAT  		= 00 	-- convexidad
        ,  	@dduratmac  			FLOAT  		= 00   	-- durati¢n macaulay
        ,  	@dduratmod 			FLOAT  		= 00	-- duration modificado
        ,  	@fecha_pagomañana               DATETIME     	= ''
    )
AS
BEGIN
	SET NOCOUNT ON	;

	DECLARE @ok        	CHAR (01) 
  	,	@cseriado  	CHAR (01) 	
	,	@cfamilia  	CHAR (10) 	
	,	@cTipoLchr 	CHAR (01) 	;

	DECLARE	@j         	INTEGER  
	,	@nlutil    	INTEGER  	;
	

	DECLARE @nRut      	NUMERIC(09,0)  
	,       @nValcomu  	NUMERIC(19,4)		
	,	@nValtasemi 	NUMERIC(19,0)   
	, 	@nPrimaDesc	NUMERIC(19,0)	;

	DECLARE @nvalmon  	FLOAT  		;



--	select @cmdse, @cmascara , @cfamilia 

 	SET @ok  = '0'  	;
	SET @nvalmon = 1.0  	;
	SET @cmascara = '*'  	;
	SET @cTipoLchr = ''  	;

	SET @nRut     = (SELECT acrutprop FROM mdac);

 SELECT @cmascara = semascara
FROM VIEW_SERIE
 WHERE seserie = @cinstser

/*	SET @cmascara = (SELECT ISNULL(semascara,'*')
		 	   FROM VIEW_SERIE 
			  WHERE seserie = @cinstser);
*/
	IF SUBSTRING(@cmascara,1,6) <> 'FMUTUO'
	BEGIN
		SET @cgenemi  = ''
	END

	
IF @cmdse ='S'
 BEGIN
  IF @cmascara='*'
  BEGIN
   SELECT @cfamilia = '*'
   IF SUBSTRING(@cinstser,1,3)='PCD' AND SUBSTRING(@cinstser,1,6)<>'PCDUS$'
       SELECT @cfamilia='PCDUF'
   ELSE
   BEGIN
    SET @j = dataLENgth(@cinstser)
    WHILE @j <>0
    BEGIN
     SELECT @cfamilia=inserie FROM VIEW_INSTRUMENTO WHERE inserie=SUBSTRING(@cinstser,1,@j)
     IF @cfamilia<>'*'
         BREAK
         SET @j = @j-1
    END
   END
   IF @cfamilia='*'
   BEGIN
    IF SUBSTRING(@cinstser,1,3)='PTF'
     SET  @cfamilia = 'PTF'
   END
   IF @cfamilia='*'
    SET  @cfamilia = 'LCHR'
    SEt ROWCOUNT 1
    SELECT @nlutil = LEN(msmascara)
      FROM VIEW_MASCARA_INSTRUMENTO
   WHERE msfamilia=@cfamilia
   SET ROWCOUNT 0
   SELECT @cmascara = '*'

   SELECT @cmascara = semascara
   FROM VIEW_SERIE
   WHERE seserie=SUBSTRING(@cinstser,1,@nlutil)
  END
 END
 ELSE
  SELECT @cmascara = @cserie


--	select @cmdse, @cmascara , @cfamilia 

--	select  @cmascara , @cserie, @nlutil


	IF @nmonemi <> 999 AND @nmonemi <> 13
		SET @nvalmon =(SELECT vmvalor 
				  FROM VIEW_VALOR_MONEDA 
				 WHERE vmcodigo=@nmonemi 
				   AND vmfecha=@cfecpro ) ;
	
	IF @ncodigo=20 BEGIN

		IF @nRutemi=@nRut BEGIN
			SELECT @cTipoLchr = CASE
                           WHEN CHARINDEX('*',@cInstser) <> 0    THEN 'V'
                           WHEN CHARINDEX('&',@cInstser) <> 0    THEN 'F'
                           WHEN SUBSTRING(@cInstser,7,2) = '01'  THEN 'V'
                           WHEN SUBSTRING(@cInstser,7,2) <>'01'  THEN 'F'
			END
		END

		IF @nRutemi = 97030000
			SET @cTipoLchr = 'E'
		IF @nRutemi<>@nRut AND @nRutemi<>97030000
			SET @cTipoLchr = 'O'
	END

	IF @nmonemi = 999 
            SET @nValcomu = round(@nvptirc/@nvalmon,0)
	ELSE
            SET @nValcomu = round(@nvptirc/@nvalmon,4)

	IF @nRutemi = @nRut AND @ncodigo = 20 
	BEGIN
		SET @nValtasemi = @nnominal * (@nvpar/100) * @nvalmon
		SET @nPrimaDesc = @nvptirc - @nValtasemi    
	END ELSE BEGIN
		SET @nValtasemi = 0.0
		SET @nPrimaDesc = 0.0
	END

	DECLARE @sTipoperRelacion	VARCHAR(03)	;
	    SET @sTipoperRelacion	= CASE @sTipoper WHEN 'CP' THEN 'VP' 
							 ELSE 'CP' END ;


    --> Se Graba operación original 	
	INSERT INTO 
	dbo.tbl_movTicketRtaFija(
		Fecha_Operacion				-- 1
	,	Numero_Documento			-- 2
	, 	Correlativo				-- 3
	,	Numero_Documento_Relacion		-- 4
	,	Correlativo_Relacion			-- 5
	,	Numero_Operacion			-- 6
	,	Correlativo_Operacion			-- 5
	, 	CodCarteraOrigen			-- 7
	,	CodMesaOrigen				-- 8
	,	CodCarteraDestino			-- 9
	,	CodMesaDestino				-- 10
	,	Tipo_Operacion				-- 11
	,	Nemotecnico				-- 12
	,	Mascara					-- 13
	,	CodigoInstrumento			-- 14
	,	Seriado					-- 15
	,	Fecha_Emision				-- 16
	,	Fecha_Vencimiento			-- 17
	,	Moneda_Emision				-- 18
	,	Tasa_Emision				-- 19
	,	Base_Emision				-- 20
	,	Rut_Emision
	,	Valor_Nominal
	,	Tir
	,	pvp
	,	vpar
	,	Tir_Estimada
	,	Valor_Presente
	,	Valor_Compra
	,	Valor_Compra_UM
	,	Valor_Tasa_Emision
	,	Valor_PrimaDescto
	,	Valor_InicialPacto
	,	Valor_VencimientoPacto
	,	Hora
	,	Usuario
	,	Pagohoy
	,	Fecha_Activacion
	)
	VALUES (
		@dFechaOperacion
	,	@nNumoper
	,	@nCorrela
	,	0
	,	0	
	,	@nNumoper
	,	@nCorrela
	,	@iCodCarteraOrigen
	,	@iCodMesaOrigen
	,	@iCodCarteraDestino
	,	@iCodMesaDestino
	,	@sTipoper
	,	@cInstser
	,	@cMascara
	,	@nCodigo
	,	@cMdSe
	,	@cFecEmi  
	,	@cFecVen
	,	@nMonemi
	,	@ntasemi
	,	@nbasemi
	,	@nrutemi
	,	@nnominal
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN @ntasemi  ELSE @ntir    END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN 100.0         ELSE @npvp    END	
	,	@nvpar
	,	@ntasest
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi/@nvalmon,4) ELSE @nvalcomu END	
	,	@nValtasemi
	,	@nPrimaDesc
	,	0
	,	0
	,	CONVERT(CHAR(08), GETDATE(),108)
	,	@cUsuario
	,	CASE WHEN @Fecha_pagoMañana=@cFecpro THEN 'S' ELSE 'N' END
	,	@Fecha_pagoMañana
	)
	

    --> Se Graba operación espejo	
	INSERT INTO 
	dbo.tbl_movTicketRtaFija(
		Fecha_Operacion
	,	Numero_Documento
	, 	Correlativo
	,	Numero_Documento_Relacion
	,	Correlativo_Relacion
	,	Numero_Operacion
	,	Correlativo_Operacion	
	, 	CodCarteraOrigen
	,	CodMesaOrigen
	,	CodCarteraDestino
	,	CodMesaDestino
	,	Tipo_Operacion
	,	Nemotecnico
	,	Mascara
	,	CodigoInstrumento
	,	Seriado
	,	Fecha_Emision
	,	Fecha_Vencimiento
	,	Moneda_Emision
	,	Tasa_Emision
	,	Base_Emision
	,	Rut_Emision
	,	Valor_Nominal
	,	Tir
	,	pvp
	,	vpar
	,	Tir_Estimada
	,	Valor_Presente
	,	Valor_Compra
	,	Valor_Compra_UM
	,	Valor_Tasa_Emision
	,	Valor_PrimaDescto
	,	Valor_InicialPacto
	,	Valor_VencimientoPacto
	,	Hora
	,	Usuario
	,	Pagohoy
	,	Fecha_Activacion
	)
	VALUES (
		@dFechaOperacion
	,	@nNumoper
	,	@nCorrela
	,	@nNumoper
	,	@nCorrela	
	,	@nNumoperRel
	,	@nCorrela
	,	@iCodCarteraDestino	---JBH, 18-12-2009 @iCodCarteraOrigen
	,	@iCodMesaDestino	---JBH, 18-12-2009 @iCodMesaOrigen
	,	@iCodCarteraOrigen	---JBH, 18-12-2009 @iCodCarteraDestino
	,	@iCodMesaOrigen		---JBH, 18-12-2009 @iCodMesaDestino
	,	@sTipoperRelacion
	,	@cInstser
	,	@cMascara
	,	@nCodigo
	,	@cMdSe
	,	@cFecEmi  
	,	@cFecVen
	,	@nMonemi
	,	@ntasemi
	,	@nbasemi
	,	@nrutemi
	,	@nnominal
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN @ntasemi  ELSE @ntir    END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN 100.0         ELSE @npvp    END	
	,	@nvpar
	,	@ntasest
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi/@nvalmon,4) ELSE @nvalcomu END	
	,	@nValtasemi
	,	@nPrimaDesc
	,	0
	,	0
	,	CONVERT(CHAR(08), GETDATE(),108)
	,	@cUsuario
	,	CASE WHEN @Fecha_pagoMañana=@cFecpro THEN 'S' ELSE 'N' END
	,	@Fecha_pagoMañana
	)


     --> se graba cartera
	INSERT INTO dbo.tbl_carTicketRtaFija( 
		Fecha_Operacion
	,	Numero_Documento
	, 	Correlativo
	,	Numero_Documento_Relacion
	,	Correlativo_Relacion		
	,	Numero_Operacion		
	, 	CodCarteraOrigen		
	,	CodMesaOrigen			
	,	Tipo_Operacion			
	,	Nemotecnico			
	,	Mascara				
	,	CodigoInstrumento	
	,	Moneda	
	,	Seriado				
	,	Valor_Nominal			
	,	Tir				
	,	pvp				
	,	vpar				
	,	Tir_Estimada			
	,	Valor_Presente			
	,	Valor_Compra			
	,	Valor_Compra_UM			
	,	Valor_Tasa_Emision		
	,	Valor_PrimaDescto		
	,	Duration			
	,	DurationMod			
	,	Convexidad			
	,	Valor_InicialPacto		
	,	Valor_VencimientoPacto		
	,	Fecha_Vencimiento		
	,	NumeroUltCupon			
	,	FechaUltCupon			
	,	FechaProxCupon			
	,	PagoHoy				
	) 
	  VALUES
	(
		@dFechaOperacion	
	,	@nNumoper
	,	@nCorrela
	,	0
	,	0
	,	@nNumoper
	,	@iCodCarteraOrigen
	,	@iCodMesaOrigen
	,	@sTipoper
	,	@cInstser
	,	@cMascara
	,	@nCodigo
	,	@nmonemi
	,	@cMdse
	,	@nnominal
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN @ntasemi  ELSE @ntir    END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN 100.0         ELSE @npvp    END	
	,	@nvpar
	,	@nTasest
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirc END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi/@nvalmon,4) ELSE @nvalcomu END	
	,	@nValtasemi
	,	@nPrimaDesc
	,	@dduratmac
	,	@dduratmod
	,	@dConvexidad
	,	0
	,	0
	,	@cFecven
	,	@nnumucup		
	,	@dfecpcup
	,	@dfecpcup
	,	CASE WHEN @Fecha_pagoMañana=@cFecpro THEN 'S' ELSE 'N' END
	)
	
	SET NOCOUNT OFF
 	SELECT @ok
END

GO
