USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAGO_TOTAL_PARCIAL_FLI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAGO_TOTAL_PARCIAL_FLI]
	   	(	@Operacion  	NUMERIC(09)
		,	@Usuario    	VARCHAR(15)
		,   	@Terminal   	VARCHAR(50)
		,	@Ventana    	NUMERIC(09)
   		,	@nnumPago	NUMERIC(09)  )
AS
BEGIN

	DECLARE @nRutcart	NUMERIC(09)
	,	@nNumoper	NUMERIC(10)
	,	@nNumdocu	NUMERIC(10)
	,	@nCorrela	NUMERIC(03)
	,	@nPago       	NUMERIC(10)
	,	@iFilas   	NUMERIC(09)
   	,	@iFila    	NUMERIC(09)
	,	@nCantcort   	NUMERIC(21) 	;

	DECLARE @nNominalp	NUMERIC(19,04)
	,	@nVptirv     	NUMERIC(19,04)
	,	@nTir        	NUMERIC(09,04)
	,	@nPvent      	NUMERIC(19,04)
	,	@nMontcort   	NUMERIC(21,04)
	,	@vInicial    	NUMERIC(19,04)	;
	
	DECLARE @cUsuario	CHAR(12)
	,	@cTerminal	CHAR(12)
	,	@cInstser	CHAR(12)
	,	@cTipopago   	CHAR(01)	;



	SET NOCOUNT ON;

	EXECUTE DBO.SP_GENERA_CORTES		;

	SELECT morutcart = morutcart
   	,      monumoper = monumoper
	,      monumdocu = Documento
	,      mocorrela = Correlativo
	,      mocorpago = IDENTITY(INT)
	,      monominal = ROUND(Nominal_compra-Nominal_Venta,0)
	,      movpresen = ROUND(Valor_Presente-vPresente_Venta,0)
	,      movinicial= ROUND( (Valor_Presente*margen)- (vPresente_Venta*margen) ,0)
	,      usuario   = @Usuario
	,      terminal  = @Terminal
	,      moinstser = Serie
	,      Tipopago  = 'S' --> CASE WHEN Nominal_Venta = Nominal_compra THEN 'S' ELSE 'P' END --> S = Total ; P = Parcial
	,      motir     = Tasa_Compra --Tasa_Venta
	,      movpar    = Valor_Par -- vpar_Venta
          INTO #tmp_pagos_fli_parcial
	  FROM mdmo 
         INNER 
	  JOIN DETALLE_FLI 
            ON documento = monumdocu 
           AND correlativo = mocorrela 
--           AND marca = 'S' 
           AND ventana = @Ventana
         WHERE monumoper = @Operacion;


	SELECT @iFilas   = MAX(mocorpago)
   	,      @iFila    = 1
   	  FROM #tmp_pagos_fli_parcial;


	WHILE @iFilas >= @iFila
	BEGIN
		SELECT  @nrutcart	= morutcart
		,       @nnumoper	= monumoper
		,       @nnumdocu	= monumdocu
		,       @nCorrela	= mocorrela
		,       @nPago       	= mocorpago
		,       @nnominalp   	= monominal
		,       @nvptirv     	= movpresen
		,       @cusuario	= usuario
		,       @cterminal   	= terminal
		,       @cinstser	= moinstser
		,       @ctipopago   	= Tipopago
		,       @ntir        	= motir
		,       @npvent      	= movpar
		,       @vinicial    	= movinicial
		   FROM #tmp_pagos_fli_parcial
	          WHERE mocorpago=@iFila;
   
	      SELECT TOP 1
	             @nCantcort    = cvcantcort
	      ,      @nMontcort    = cvmtocort
	        FROM MDCV
	       WHERE cvnumoper     = @nNumoper
	         AND cvnumdocu     = @nNumdocu
      		 AND cvcorrela     = @nCorrela;

		EXECUTE bactradersuda.DBO.SP_GRABARPAGOS 
			@nRutcart 
		,	@nNumoper
		,	@nNumdocu
		, 	@nCorrela
		,	@nnumPago
--		,	@nPago 
		,	@nNominalp 
		,	@nVptirv
		,	@cUsuario
		,	@cTerminal
		,	@cInstser
		,	@cTipopago
		,	@nTir
		,	@nPvent
		,	@vinicial    	
		,	@Ventana    	;


		EXECUTE SP_VTCORTESPARCIAL_PAGOSFLI 
			@nRutcart
		,	@nNumdocu
		,	@nCorrela
		,	@nNumoper
		,	@nCantcort
		,	@nMontcort
		,	@cTipopago
		,	@nnumPago 	;

      
		EXECUTE SP_GRABARFLI_PAGOS_NUEVO    
			@nNumdocu
		,	@nCorrela
		,	@nNominalp
		,	@nNumoper
		,	@nVptirv 	
		,	@vinicial	;	


		EXECUTE SP_VTCORTESPARCIAL_PAGOS  
			@nRutcart
		,	@nNumdocu
		,	@nCorrela
		,	@nNumoper
		,	@nCantcort
		,	@nMontcort	;

		SET @iFila=@iFila + 1	;
	END

	EXECUTE SVC_GBR_FLJ_LQZ 
		''
	,	@cInstser
	, 	''
	,	''
	,	0
	,	0
	,	0
	,	0
	,	''
	,	''
	,	0
	,	0
	,	0
	,	0
	,	''
	,	0
	,	0
	,	1
	,	@cUsuario;

END

GO
