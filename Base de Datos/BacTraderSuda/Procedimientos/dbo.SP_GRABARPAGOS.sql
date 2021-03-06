USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARPAGOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABARPAGOS](
		@nRutcart	NUMERIC(09,0)  	,  -- 01 Rut de la cartera
		@nNumoper	NUMERIC(10,0)  	,  -- 02 Numero de operaci«n de venta
		@nNumdocu	NUMERIC(10,0)  	,  -- 03 Numero del documento
		@nCorrela	NUMERIC(03,0)  	,  -- 04 Correlativo de la operacion
                @nPago		NUMERIC(10,0)  	,  -- 05 Correlativo de Pagos
		@nNominalp	NUMERIC(19,4)  	,  -- 06 Nominales vendidos
                @nVptirv	NUMERIC(19,4)  	,  -- 07 Valor presente 
		@cUsuario	CHAR	(12)	,  -- 08 Usuario
		@cTerminal	CHAR	(12)	,  -- 09 Terminal
		@cInstser	CHAR	(12)	,  -- 10 Serie
                @cTipopago	CHAR  (1)      	,  -- 11 Tipo Pago
	        @nTir		NUMERIC(09,04) 	,  -- 12 Tir
                @nPvent		NUMERIC(19,04) 	,  -- 13 V. par
		@valinicial	NUMERIC(19,04)	,  -- 14 Valor Inicial
		@ventana	NUMERIC(9) )
AS
BEGIN


	SET NOCOUNT ON;


	DECLARE	@cHora		CHAR(15)         
	,       @Reproceso      CHAR(1)         
	,       @Sreproceso     CHAR(1)         ;

	DECLARE @x              INTEGER         
	,       @cant_reg       INTEGER         ;

	
        DECLARE @dFecpro	DATETIME         
	,       @acFecProc      DATETIME         
	,       @dFecucup       DATETIME        ;

	DECLARE @fcpdurat       FLOAT            
	,	@fcpdurmod      FLOAT           
	,	@fcpconvex      FLOAT           
	,	@nTotalPresente FLOAT
	,	@nValor		FLOAT		;

	DECLARE @Tipcartera     NUMERIC(02,0)    
	,	@nMonemi        NUMERIC(03,0)    
	,       @nMonpact       NUMERIC(03,0)    
	,       @nTippagoi      NUMERIC(03,0)    
	,       @Codorigen      NUMERIC(03,0)    
	,       @nCodigo        NUMERIC(03,0)      
	,       @nValinip       NUMERIC(19,4)	        
	,	@Nominal        NUMERIC(21,8)   
	,       @Valor          NUMERIC(19,4)	;


	SET @cHora=CONVERT(CHAR(15),GETDATE(),108) ;

	SELECT @dFecpro   = acfecproc 
	,      @acFecProc = acfecproc  
	  FROM mdac

	SELECT @nCodigo    = vicodigo  
	,      @Nominal    = vinominal 
	,      @Valor      = vivptirv
	,      @nValinip   = vivalinip
	  FROM mdvi
	 WHERE vinumoper = @nNumoper 
	   AND vinumdocu = @nNumdocu 
	   AND vicorrela = @nCorrela

	SET @nValor = (SELECT TOP 1 ISNULL(vPresente_venta,0) 
		         FROM detalle_fli 
			WHERE documento = @nNumdocu 
			  AND Correlativo = @nCorrela 
			  AND ventana=@ventana);


	SET @nTotalPresente = (SELECT TOP 1  ISNULL(pavpresen,0) 
		         FROM pagos_fli 
			WHERE panumdocu = @nNumdocu 
			  AND pacorrela = @nCorrela 
			  AND panumoper = @nNumoper);
	
	SET @dFecucup = (SELECT Top 1 cpfecucup     
			   FROM	MdCp		 
			  WHERE cprutcart = @nRutcart 
			    AND cpnumdocu = @nNumdocu 
			    AND cpcorrela = @nCorrela); 

	SELECT @Codorigen=mocodigo	
	,      @nMonemi=momonemi	
	,      @nMonpact=momonpact	
	,      @nTippagoi=moforpagi	
	,      @nTotalPresente= CASE WHEN @nTotalPresente = 0  THEN movpresen ELSE @nTotalPresente  END
	  FROM mdmo
         WHERE monumoper = @nNumoper 
           AND monumdocu = @nNumdocu 
	   AND mocorrela = @nCorrela
	   AND motipoper ='FLI';

--	IF @nominal = @nnominalp SET @nVptirv = @nValinip   --> Corresponde al valor que salio de Cartera


	INSERT INTO 
	pagos_fli(
		PAFECPRO   ,
		PARUTCART  ,
               PANUMDOCU  ,    
               PACORRELA  ,
               PANUMOPER  ,  
               PANUMPAGO  ,
               PAPTIPOPAGO,
               PAINSTSER  ,
               PACODIGO   ,
               PANOMINAL  ,
               PAVPRESEN  ,
               PATIPOBONO ,
               PACONDPACTO,
               PAHORA     ,
               PAUSUARIO  ,
               PATERMINAL ,
               PASTATUS   ,
               PAPAPELETA ,
               PACONTRATO ,
               PAMEDIODEPAGOI,
               PAFECUCUP  ,
               PAFECPCUP  ,
               PADURAT    ,
               PADURMOD   ,
               PACONVEX   ,
               PATIPOCARTERA,
               PAMONEMI   ,
               PAMONPACT  ,
	    PAFORPAGI ,
               PAREPROCESO,
               PASWREPROCESO,
               PACODORIGEN ,
	       PATIR,
	       PVPVENT	,
		pavalinicial   )
         VALUES
            (
               @dFecpro   ,
               @nRutcart  ,
	       @nNumdocu  ,
	       @nCorrela  ,
	       @nNumoper  ,
               @nPago     ,
               @cTipopago ,
               @cInstser  ,               
               ISNULL(@nCodigo,0)   ,
               ISNULL(@nNominalp ,0),
	       @nVptirv , --> ISNULL(@nValor,0)	  ,  --> VB+- 13/07/2009 @nVptirv   
               ''         ,
               ''         ,
               @cHora     ,                 
               @cUsuario  ,
	       @cTerminal ,
               'P'        ,
               0          ,
               0          ,
               ''         ,
               @dFecucup  ,
               @dFecucup  ,
               0	  ,
               0	  ,
               0	  ,
               0	  ,
               @nMonemi   ,
               @nMonpact  ,
               @nTippagoi ,
               ''	  ,
               ''	  ,
               @Codorigen ,
	       @nTir      ,
               @nPvent	  ,
	       @valinicial		
            ) 

IF @@error <> 0 
BEGIN
   SELECT 'ERROR' , 'Problemas al Insertar Tabla de Pagos, Reintente'
   RETURN
END

END

GO
