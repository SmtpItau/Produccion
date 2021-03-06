USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAOPERACION_TICKETINTRAMESA_VENTAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAOPERACION_TICKETINTRAMESA_VENTAS]
	( 	@nNumOper 			NUMERIC(10,0)
	,	@nNumDocu			NUMERIC(10,0)
	,	@ncorrela 			NUMERIC(03,0)
	,	@sTipoper			VARCHAR(03)
	,	@nNumoperRel			NUMERIC(10,0)
	,	@dFechaOperacion		DATETIME
	,	@iCodCarteraOrigen		SMALLINT
	,	@iCodMesaOrigen			SMALLINT
	,	@iCodCarteraDestino		SMALLINT
	,	@iCodMesaDestino		SMALLINT
	,	@nnominal   			NUMERIC(19,4) 
	,	@ntir       			NUMERIC(19,4) 
	,	@npvp       			NUMERIC(19,2)
	,	@nvpar      			NUMERIC(19,8)
	,	@nvptirv    			FLOAT
	,	@nnumucup   			NUMERIC(03,0)
	,	@cfecpro    			DATETIME
	,	@ntasest    			NUMERIC(09,4)
	,	@nmonemi    			NUMERIC(03,0)
	,	@nrutemi    			NUMERIC(09,0)
	,	@ntasemi    			NUMERIC(09,4)
	,	@nbasemi    			NUMERIC(03,0)
	,	@cusuario   			CHAR(12)
	,	@cterminal  			CHAR(12)
	,	@cmascara   			CHAR(12)
	,	@cinstser   			CHAR(12)
	,	@cgenemi   			CHAR(10)
	,	@cnemomon   			CHAR(05)
	,  	@cfecemi   			DATETIME
	,	@cfecven   			DATETIME
	,	@ncodigo   			NUMERIC(05,0)
	,	@ncorrvent   			INTEGER
	,	@fecha_pagomañana  		DATETIME 
	,	@nValorCompraPM          	FLOAT
   )
AS
BEGIN

	SET NOCOUNT ON	;

	DECLARE @nestado 		INTEGER  ,
		@fcontrol 		DATETIME ,
		@dfecvtop  		DATETIME ,
		@cTipoLchr 		CHAR (01) ,
		@nRut  			NUMERIC (09,0)

	 DECLARE @ffactor 	FLOAT
	 DECLARE @fcapitalc 	NUMERIC (19,4) -- capital de la compra MDDI actual
	 DECLARE @finteresc 	NUMERIC (19,4) -- intereses de la compra MDDI actuales
	 DECLARE @freajustc 	NUMERIC (19,4) -- reajustes de la compra MDDI actuales
	 DECLARE @fnominal 	NUMERIC (19,4) -- nominales dISponibles MDDI actuales
	 DECLARE @ncapitalc 	NUMERIC (19,4) -- nuevo capital dISponible
	 DECLARE @ninteresc 	NUMERIC (19,4) -- nuevos intereses MDDI
	 DECLARE @nreajustc 	NUMERIC (19,4) -- nuevos reajustes  MDDI
	 DECLARE @fvptirc 	NUMERIC (19,4) -- valor presente MDDI actual
	
	 --* variables para obtener datos de la tabla MDCP
	 DECLARE @fcapitalo  	 NUMERIC (19,4) -- capital de la compra propia
	 DECLARE @fintereso 	 NUMERIC (19,4) -- intereses de la compra propia
	 DECLARE @freajusto 	 NUMERIC (19,4) -- reajustes de la compra propia
	 DECLARE @fnominalo 	 NUMERIC (19,4) -- nominales originales
	 DECLARE @fvalcomu 	 NUMERIC (19,4) -- capital  um de la compra propia
	 DECLARE @fvalcomp 	 NUMERIC (19,4) -- capital $$ de la compra propia
	 DECLARE @ncapitalo  	 NUMERIC (19,4) -- nuevo capital de la compra MDCP
	 DECLARE @nintereso 	 NUMERIC (19,4) -- nuevo intereses de la compra MDCP
	 DECLARE @nreajusto  	 NUMERIC (19,4) -- nuevo reajustes de la compra MDCP
	 DECLARE @nvalcomu 	 NUMERIC (19,4) -- nuevo capital um MDCP
	 DECLARE @nvalcomp 	 NUMERIC (19,4) -- nuevo capital $$ MDCP
	 DECLARE @nvalcompv 	 NUMERIC (19,4) -- capital $$ venta
	 DECLARE @nvalcomuv 	 NUMERIC (19,4) -- capital um venta
	 DECLARE @nvalcomuo 	 NUMERIC (19,4) -- nuevo capital um MDCP original
	 DECLARE @nvalcompo 	 NUMERIC (19,4) -- nuevo capital $$ MDCP original
	 DECLARE @nvalcompvo 	 NUMERIC (19,4) -- capital $$ venta
	 DECLARE @nvalcomuvo 	 NUMERIC (19,4) -- capital um venta
	 DECLARE @fvalcompo 	 NUMERIC (19,4) -- capital $$ venta
	 DECLARE @fvalcomuo 	 NUMERIC (19,4) -- capital um venta
	 DECLARE @nfeccompo      DATETIME
	 DECLARE @ntircompo      NUMERIC (8,4)
	 DECLARE @nvparo         NUMERIC (19,8) --88
	 DECLARE @npvparo        NUMERIC (8,4)
	 DECLARE @ninteresv 	 NUMERIC (19,2) -- interes venta
	 DECLARE @nreajustv 	 NUMERIC (19,2) -- reajuste venta
	 DECLARE @nutilidad 	 NUMERIC (19,2) -- utilidad venta
	 DECLARE @nperdida 	 NUMERIC (19,2) -- perdida venta
	 DECLARE @cseriado 	 CHAR (01)
	 DECLARE @calculo        NUMERIC(19,4)
	 DECLARE @ValorPrenteT0  FLOAT	  -- VB+-08/05/2009 Recibira monto T0 de ventas PM	
	
	--** Calculos LCHR Emision Propia **--
        DECLARE @fPrimadesco	NUMERIC	(19,4)	, -- Prima o Descuento Hist¢rico
		@fValtasemio	NUMERIC (19,4)	, -- Valor Tasa Emmisi¢n Hist¢rico
		@nPrimadesc	NUMERIC	(19,4)	, -- Prima o Descuento Hist¢rico
		@nValtasemio	NUMERIC (19,4)	, -- Valor Tasa Emmisi¢n Hist¢rico
		@nValtasemi     NUMERIC (19,4)	, 
		@nPrimadesv	NUMERIC (19,4)	,
		@nPrimadesvo	NUMERIC (19,4)	,
		@nValtasemv	NUMERIC (19,4)	,
		@nPriDesAcum	NUMERIC (19,4)	,
		@nPriDesDia	NUMERIC (19,4)	,
		@nDifPriDesVta	NUMERIC (19,4)	,
		@dFeccomp	DATETIME	,
		@dFecven	DATETIME	,
		@nValParVta	NUMERIC (19,4)	,
		@fValmon_Hoy	FLOAT           ,
		@nperdidaLetra NUMERIC (19,4)  ,
		@var1 		NUMERIC (19,4)	,
		@nutilidadLetra NUMERIC(19,4)	,
		@cTipo_Moneda_papel	CHAR	(01)	,	-- wms
		@nDecimal		INTEGER


	SELECT	@nRut		= acrutprop	,
		@cTipoLchr	= ''		,
		@fValmon_Hoy	= 0.0		,
		@nPrimadesv	= 0		,
		@nValtasemv	= 0		,
		@nPriDesDia	= 0		,
		@nPriDesAcum	= 0		,
		@nValParVta	= 0		,
		@nDifPriDesVta	= 0
	FROM	MDAC

	SELECT	@cTipo_Moneda_papel  = CASE
						WHEN mnmx='C' THEN '0'
						ELSE '1'
					  	END	,
		@nDecimal		= mndecimal
	FROM	VIEW_MONEDA
	WHERE	mncodmon=@nmonemi

        -->     Se Agrego 22-07-2008.- Para Reemplazar la "CASE WHEN .... " en cada uno de los Redondeos mas abajo.-

        DECLARE @nRedondeo      NUMERIC(9)
            SET @nRedondeo      = CASE WHEN @cTipo_Moneda_papel = '0' THEN @nDecimal ELSE 0 END


	DECLARE @nvalmon  	FLOAT  		;


	SET @nvalmon = 1.0  	;

	IF @nmonemi <> 999 AND @nmonemi <> 13
		SET @nvalmon =(SELECT vmvalor 
				  FROM VIEW_VALOR_MONEDA 
				 WHERE vmcodigo=@nmonemi 
				   AND vmfecha=@cfecpro ) ;

	SELECT @fcapitalc 	= Valor_Compra
	,      @fnominal  	= valor_nominal
	,      @fvptirc   	= Valor_Presente
	,      @fcapitalo      	= valor_compra
	,      @fvalcomu 	= Valor_Compra_UM
	,      @fvalcomp 	= valor_compra
	,      @nvparo         	= vpar
	,      @npvparo        	= pvp
	,      @cseriado       	= seriado
-->	,      @cTipoLchr      	= cptipoletra
	,      @fprimadesco    	= Valor_PrimaDescto     
	,      @nValtasemi    	= Valor_Tasa_Emision     
	,      @dFeccomp	= ISNULL(Fecha_Operacion,'')
	,      @dFecven		= ISNULL(Fecha_Vencimiento,'')
	  FROM tbl_carticketrtafija
	 WHERE Numero_Documento = @nnumdocu
	   AND Correlativo	= @ncorrela

	
	   SET @ValorPrenteT0  = @fvptirc			;

	   SET @ffactor = 1.00 - (@nnominal / CASE WHEN @fnominal = 0 THEN 1 WHEN  @fnominal IS NULL THEN 1 ELSE @fnominal END )	;

	   SET @ncapitalc = ROUND(@fcapitalc * @ffactor,0)	;

	IF @ffactor <> 0   SET @ValorPrenteT0  = @fvptirc-ROUND(@fvptirc* @ffactor,0) ;  

	   SET @fvptirc   = ROUND(@fvptirc* @ffactor,0)		;
 
	   SET @ncapitalo   = ROUND(@fcapitalo   * @ffactor, @nRedondeo)
	   SET @nvalcomu    = ROUND(@fvalcomu    * @ffactor,4)

	   SET @nvalcomp    = ROUND(@fvalcomp    * @ffactor, @nRedondeo)

	   SET @nvalcomuo   = ROUND(@fvalcomuo   * @ffactor,4)
	   SET @nvalcompo   = ROUND(@fvalcompo   * @ffactor, @nRedondeo)

	   SET @nprimadesc  = ROUND(@fprimadesco * @ffactor,0)
	   SET @nvaltasemio = ROUND(@fvaltasemio * @ffactor,0)

	   SET @nprimadesc  = CASE WHEN @fprimadesco IS NULL  THEN 0 ELSE @fprimadesco  END
	   SET @nvaltasemio = CASE WHEN @nvaltasemio IS NULL  THEN 0 ELSE @nvaltasemio END


	UPDATE tbl_carticketrtafija
	   SET valor_nominal  	  = valor_nominal - @nnominal 
	,      Valor_Compra	  = @nvalcomp 		
	,      Valor_Compra_UM	  = @nvalcomu    		
	,      Valor_Presente	  = @fvptirc              
	,      Valor_PrimaDescto = @nprimadesc	
	,      Valor_Tasa_Emision= @nvaltasemio		
	 WHERE Numero_Documento = @nnumdocu
	   AND Correlativo	= @ncorrela

   -->     Se Agrego 22-07-2008.- Para Reemplazar la Fecha de Calculo de variable '@nPriDesAcum' y '@fValmon_Hoy'
	DECLARE @dFechaCalculoPrima   DATETIME
	    SET @dFechaCalculoPrima   = CASE WHEN @cFecpro = @fecha_pagomañana THEN @cFecpro ELSE @fecha_pagomañana END

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
	,	Correlativo_Operacion
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
	,	@nNumDocu
	,	@nCorrela
	,	0
	,	0	
	,	@nNumoper
	,	@ncorrvent
	,	@iCodCarteraOrigen
	,	@iCodMesaOrigen
	,	@iCodCarteraDestino
	,	@iCodMesaDestino
	,	@sTipoper
	,	@cInstser
	,	@cMascara
	,	@nCodigo
	,	@cseriado
	,	@cFecEmi  
	,	@cFecVen
	,	@nMonemi
	,	@ntasemi
	,	@nbasemi
	,	@nrutemi
	,	@nnominal
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN @ntasemi ELSE @ntir END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN 100.0    ELSE @npvp END	
	,	@nvpar
	,	@ntasest
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) 		ELSE @nvptirv END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) 		ELSE @nvalcomp END	
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
	,	Correlativo_operacion
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
	,	@nNumoperRel
	,	@nCorrela
	,	@nNumoper
	,	@nCorrVent	
	,	@nNumoperRel
	, 	@nCorrela
	,	@iCodCarteraDestino	---JBH, 18-12-2009 @iCodCarteraOrigen
	,	@iCodMesaDestino	---JBH, 18-12-2009 @iCodMesaOrigen
	,	@iCodCarteraOrigen	---JBH, 18-12-2009 @iCodCarteraDestino
	,	@iCodMesaOrigen		---JBH, 18-12-2009 @iCodMesaDestino
	,	@sTipoperRelacion
	,	@cInstser
	,	@cMascara
	,	@nCodigo
	,	@cseriado
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
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirv END	
	,	CASE WHEN @ncodigo = 20 AND @nrutemi = @nRut THEN ROUND(@nValtasemi,0) ELSE @nvptirv END	
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

	SET NOCOUNT OFF
	SELECT 'OK'

END

GO
