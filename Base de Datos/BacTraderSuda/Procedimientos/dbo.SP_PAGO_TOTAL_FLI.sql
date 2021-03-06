USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAGO_TOTAL_FLI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAGO_TOTAL_FLI]
   (   @Operacion  NUMERIC(9)
   ,   @Usuario    VARCHAR(15)
   ,   @Terminal   VARCHAR(50)
   ,   @Ventana    NUMERIC(9)
   )
AS
BEGIN

	SET NOCOUNT ON	;

	EXECUTE SP_GENERA_CORTES

	DECLARE @Numpago     NUMERIC(9)
	DECLARE @Numdocu     NUMERIC(9)

	EXECUTE @Numpago     = SP_BUSCA_NUM_OPER_PAGOS @Operacion

	DECLARE @nRutcart	NUMERIC(9)
	DECLARE @nNumoper	NUMERIC(10)
	DECLARE @nNumdocu	NUMERIC(10)
	DECLARE @nCorrela	NUMERIC(03)
	DECLARE @nPago          NUMERIC(10)
	DECLARE @nNominalp	NUMERIC(19,4)
	DECLARE @nVptirv        NUMERIC(19,4)
	DECLARE @cUsuario	CHAR(12)
	DECLARE @cTerminal	CHAR(12)
	DECLARE @cInstser	CHAR(12)
	DECLARE @cTipopago   	CHAR(1)
	DECLARE @nTir        	NUMERIC(9,04)
	DECLARE @nPvent      	NUMERIC(19,04)
	DECLARE @nCantcort   	NUMERIC(9)
	DECLARE @nMontcort   	NUMERIC(19,4)
   	DECLARE @valinicial  	NUMERIC(19,4)
	DECLARE @fTotFLI	NUMERIC(21,0)
	DECLARE @fTotFLIP	NUMERIC(21,0)
	DECLARE @fDiferencia	NUMERIC(21,0)

-- resumen
	SET  @Numdocu      = (SELECT MAX(pago) FROM papeleta_fli WHERE numero_operacion=@operacion);

	IF @Numdocu  = 0  or @Numdocu  IS NULL  
		SELECT @Numdocu=1      
	ELSE 
			SELECT @Numdocu=@Numdocu+1      
---                                                                                  ^                          '
------------------------------------------> [ Proceso  de grabación ] <------------------------------------------'

	INSERT INTO 
	papeleta_Fli(
		fecha_operacion
	,	numero_operacion
	,	pago
	,	instrumento
	,	nominal
	,	tir  			
	,	valor_referencial
	,	margen
	,	valor_inicial
	,	CarteraSuper
	)
	 SELECT vifecinip
	,	@Operacion
	,	@Numdocu      
	,	viinstser
	,	SUM(vinominal)
	,	vitirvent
	,	SUM(vivptirv)
	,	ROUND(SUM(vivalinip)/SUM(vivptirv),4)
	,	SUM(vivalinip)
	,	Codigo_carterasuper
	   FROM mdvi
   	  WHERE vinumoper = @Operacion
          GROUP 
	     by vifecinip,  vinumoper , viinstser, vitirvent, Codigo_carterasuper


	INSERT INTO 
	Resumen_Operaciones_Fli
 	( 	Fecha_Operacion
	,	numero_Operacion
	, 	Tipo_operacion 	
	,	Total_Operacion
	,	Usuario
	,	Hora
	,	Pago
	)
	SELECT  vifecinip 
	,	vinumoper 
	,	'FLIP'
	,	SUM(vivalinip)
	,	@Usuario
	,       CONVERT(CHAR(8),GETDATE(),108)
	,	@Numdocu      
	  FROM mdvi
   	WHERE  vinumoper = @Operacion
	GROUP by vifecinip,  vinumoper 


    --> Total de Operaciones FLI                                 < --
	SET @fTotFLI = ( SELECT total_operacion 
			   FROM Resumen_Operaciones_Fli 
			  WHERE numero_operacion = @Operacion 
			    AND tipo_operacion = 'FLI' );

    --> Total de Operaciones FLIP                                < --
	SET @fTotFLIP =( SELECT SUM(total_operacion) 
			   FROM Resumen_Operaciones_Fli 
			  WHERE numero_operacion = @Operacion 
			    AND tipo_operacion = 'FLIP'
		  	    AND pago <> 0 );

--select  @fTotFLIP , @ftotflip

    --<|> --------------------------------------------------------- >

	IF @fTotFLI <> @fTotFLIP   --> Revision si cuadra FLI con sus pagos
	BEGIN

		   SET @fDiferencia =  (@fTotFLI - @fTotFLIP ) -- Calculo Diferencia 

--select @fDiferencia 
		
		UPDATE Resumen_Operaciones_Fli 
		   SET total_operacion =  total_operacion + @fDiferencia    -- > sumo diferencia para cuadrar pagos
		 WHERE numero_operacion = @Operacion 
		   AND tipo_operacion = 'FLIP'
		   AND pago = @numdocu  ;

--select 'detalle' , @fTotFLIP 

		SET @fTotFLIP =( SELECT SUM(valor_inicial)
			   	   FROM papeleta_fli 
				  WHERE numero_operacion = @Operacion 
				    AND pago <> 0 );

--select  @fTotFLIP , @ftotflip

		IF @fTotFLI <> @fTotFLIP   
		BEGIN
			SET @fDiferencia =  (@fTotFLI - @fTotFLIP ) -- Calculo Diferencia 
--select @fDiferencia 

			SET ROWCOUNT 1 
			UPDATE papeleta_fli 
			   SET valor_inicial = (valor_inicial + @fDiferencia )
			 WHERE numero_operacion = @Operacion 
	 		   AND pago = @numdocu ;

			SET ROWCOUNT 0

		END

	END 

---           *                  *                          '
------------------------------------------> [ Proceso  de grabación ] <------------------------------------------'


	SELECT morutcart=virutcart
   	,      monumoper=vinumoper
	,      monumdocu=vinumdocu
	,      mocorrela=vicorrela
	,      mocorpago = identity(int)
	,      monominal=vinominal
	,      movpresen=vivptirv
	,      usuario  = @Usuario
	,      terminal = @Terminal
	,      moinstser=viinstser
	,      Tipopago = 'S' --> S = Total ; P = Parcial
	,      motir=vitirvent
	,      movpar=0 
	,      movalinip= vivalinip
	  INTO #TMP_PAGOS_FLI
	  FROM MDvi
   WHERE  vinumoper = @Operacion

   DECLARE @iFilas   NUMERIC(9)
   DECLARE @iFila    NUMERIC(9)

   SELECT  @iFilas   = MAX(mocorpago)
   ,       @iFila    = 1
   FROM    #TMP_PAGOS_FLI

	WHILE   @iFilas >= @iFila
	BEGIN

	SELECT  @nRutcart	   = morutcart
	,       @nNumoper	   = monumoper
	,       @nNumdocu	   = monumdocu
      ,       @nCorrela	   = mocorrela
      ,       @nPago       = mocorpago
      ,       @nNominalp   = monominal
      ,       @nVptirv     = movpresen
      ,       @cUsuario	   = usuario
      ,       @cTerminal   = terminal
      ,       @cInstser	   = moinstser
      ,       @cTipopago   = Tipopago
      ,       @nTir        = motir
      ,       @nPvent      = movpar
      ,       @valinicial  =movalinip
      FROM    #TMP_PAGOS_FLI
      WHERE   mocorpago    = @iFila
   
      SELECT TOP 1
             @nCantcort    = cvcantcort
      ,      @nMontcort    = cvmtocort
      FROM   MDCV
      WHERE  cvnumoper     = @nNumoper
      AND    cvnumdocu     = @nNumdocu
      AND    cvcorrela     = @nCorrela


		EXECUTE bactradersuda.dbo.sp_grabarpagos 
			@nRutcart 
		,	@nNumoper
		,	@nNumdocu
		, 	@nCorrela
		,	@numPago
		,	@nNominalp 
		,	@nVptirv
		,	@cUsuario
		,	@cTerminal
		,	@cInstser
		,	@cTipopago
		,	@nTir
		,	@nPvent
		,	@valinicial    	
		,	@Ventana    	;


		EXECUTE sp_vtcortesparcial_pagosfli 
			@nRutcart
		,	@nNumdocu
		,	@nCorrela
		,	@nNumoper
		,	@nCantcort
		,	@nMontcort
		,	@cTipopago
		,	@numPago 	;

      
		EXECUTE sp_grabarfli_pagos_nuevo    
			@nNumdocu
		,	@nCorrela
		,	@nNominalp
		,	@nNumoper
		,	@nVptirv 	
		,	@valinicial	;	


		EXECUTE sp_vtcortesparcial_pagos  
			@nRutcart
		,	@nNumdocu
		,	@nCorrela
		,	@nNumoper
		,	@nCantcort
		,	@nMontcort	;


		SET @iFila = @iFila + 1
	END

	EXECUTE SVC_GBR_FLJ_LQZ '', @cInstser, '', '', 0, 0, 0, 0, '', '', 0, 0, 0, 0, '', 0, 0, 1, @cUsuario

END



GO
