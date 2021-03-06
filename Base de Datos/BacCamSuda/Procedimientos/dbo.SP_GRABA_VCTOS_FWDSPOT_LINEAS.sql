USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_VCTOS_FWDSPOT_LINEAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---- INICIO: Dbo.Sp_Graba_Vctos_FwdSpot_Lineas
CREATE PROCEDURE [dbo].[SP_GRABA_VCTOS_FWDSPOT_LINEAS] (	@nNumoperFwd 	NUMERIC(10),
						@nNumoperSpt 	NUMERIC(10),
						@nError		NUMERIC(5) OUTPUT)
				
AS
BEGIN
	SET NOCOUNT ON

	-- MAP 20070827 Valuta de lo que se va a recibir, al anticipar parcial toma
        -- como plazo de control de lÃ­mite el de la operaciÃ³n original que puede ser 
        -- del orden de los meses.

	DECLARE @nRutcli  		NUMERIC(09,0),
		@nCodigo  		NUMERIC(09,0),
		@dFeciniop  		DATETIME,
		@dFecvctop  		DATETIME,
		@nMontolin_pesos	FLOAT,
		@fTipcambio  		NUMERIC(08,4),
		@nMontolin  		NUMERIC (19,4),
		@cUsuario		CHAR(15),  -- MAP 20060920
		@formapago		NUMERIC(5),
		@cMonedaOp		NUMERIC(5),
		@cProducto		CHAR(05),
		@fecproc		DATETIME,
		@RutEntidad		NUMERIC(10),
      		@cCheque		CHAR(01),
      		@nRutCheque		NUMERIC(10),
		@RecibimosCodigo	NUMERIC(05),
		@EntregamosCodigo	NUMERIC(05),
		@ControlaLinea		CHAR(01),
		@Operacion		CHAR(01),
		@nProc			NUMERIC(05),
		@cChequea_linea		CHAR(01),
		@fecprocx		DATETIME,
		@TipCli			NUMERIC(1),
		@mocodmon		CHAR(03),		
        @moterm    VARCHAR(10) -- MAP 21 Octubre 2009



	SELECT	@fecproc = ACFECPRO,
		@RutEntidad = ACRUT,
		@fecprocx = ACFECPRX
	FROM meac
	
	-- MAP 21 OCtubre 2009
    SELECT  @moterm = ''
    SELECT  @moterm = moTerm FROM TBVENCIMIENTOSFORWARD
    WHERE   monumfut = @nNumoperFwd
	
	IF @moterm = 'FORWARD' BEGIN -- MAP 21 Octubre 2009
	-- ADAPTAR PARA LOS ANTICIPOS
	SELECT 	@nRutcli  		= morutcli,
		@nCodigo  		= mocodcli,
		@dFeciniop  		= mofecini,
		@dFecvctop  		= moValuta2, -- MAP 20070827 Valuta de lo que se va a recibir
		@nMontolin_pesos	= momonpe,
		@fTipcambio  		= moticam,
		@nMontolin  		= moussme,
		@cUsuario		= mooper,
		@cProducto		= motipmer,
		@formapago		= cafpagomn,
		@cMonedaOp		= cacodmon2,
		@Operacion		= motipope,
		@EntregamosCodigo	= moentre,
		@RecibimosCodigo	= morecib,
		@mocodmon		= mocodmon

  	FROM TBVENCIMIENTOSFORWARD, view_Mfca
	WHERE monumfut = @nNumoperFwd 
	AND canumoper = @nNumoperFwd

	END  -- MAP 21 OCtubre 2009
        ELSE BEGIN
        -- 21 Octubre 2009
        SELECT 
                    @nRutcli  		= morutcli,
		    @nCodigo  		= mocodcli,
		    @dFeciniop  		= mofecini,
		    @dFecvctop  		= moValuta2, -- MAP 20070827 Valuta de lo que se va a recibir
		    @nMontolin_pesos	= momonpe,
		    @fTipcambio  		= moticam,
		    @nMontolin  		= moussme,
		    @cUsuario		= mooper,
		    @cProducto		= motipmer,
		    @formapago		= case when motipope = 'C' then moentre else morecib end , -- Forma Pago Mn  select * from 
		    @cMonedaOp		= isnull( (select mncodmon from bacParamsuda..moneda where mnnemo = mocodcnv), 999 ),  -- cacodmon2,
		    @Operacion		= motipope,
                    @EntregamosCodigo	= moentre,
                    @RecibimosCodigo	= morecib,
                    @mocodmon		= mocodmon

             FROM TBVENCIMIENTOSFORWARD                            
	     WHERE monumfut = @nNumoperFwd
         END

	

      	SELECT 	@cCheque = 'N'
      	SELECT	@nRutCheque = 0


	IF @fecproc = @dFecvctop AND @cProducto <> 'ARBI'
		SELECT @dFecvctop = @fecprocx

	IF @Operacion = 'C' BEGIN
        	IF (@RecibimosCodigo in(15,16) And @cProducto = 'EMPR') Or (@EntregamosCodigo in(15,16) And @cProducto = 'CANJ') BEGIN
            		SELECT @cCheque = 'S'
            		SELECT @nRutCheque = @nRutcli
        	END
	END

   	If @RutEntidad = @nRutcli
       		SELECT @cChequea_linea = 'N'
   	Else
   		SELECT @cChequea_linea = 'S'

	SELECT 	@nError = 0,
		@nProc  = 0



        -------->> tipo de mercado 
     	SELECT @TipCli = Cltipcli FROM VIEW_CLIENTE
                                 WHERE clrut    = @nRutcli AND
                                       clcodigo = @nCodigo

        SELECT @cProducto = (CASE WHEN (@TipCli > 0 AND @TipCli < 4) AND @mocodmon <> 'USD' THEN 'ARBI'
                           WHEN (@TipCli > 0 AND @TipCli < 4) AND @mocodmon  = 'USD' THEN 'PTAS'
                                 ELSE 'EMPR'
                            END)

	If @cChequea_linea = 'S' BEGIN
    		EXECUTE @nProc = BACLINEAS..Sp_Lineas_ChequearGrabar 	@fecproc,
									'BCC',
									@cProducto,
									@nNumoperSpt,
									0,
									0,
									@nRutcli,
									@nCodigo,
									@nMontolin,
									0,
									@dFecvctop,
									@cUsuario,
									0,
									0,
									@fecproc,
									0,
									'N',
									0,
									'C',
									0,
									@cCheque,
									@nRutCheque,
									@dFecvctop,
									0,
									@RecibimosCodigo,
									0,
									0,
									''

		If @nProc <> 0
			SELECT @nError = @nProc

		SELECT	@ControlaLinea = ' '
		SELECT 	@ControlaLinea = CASE WHEN @fecproc <> @dFecvctop And @nRutcli <> @RutEntidad THEN ' ' ELSE 'N' END

		EXECUTE @nProc = BACLINEAS..Sp_Lineas_Chequear 	'BCC',
								@cProducto,
								@nNumoperSpt,
								@Operacion,
								@cCheque,
								@ControlaLinea

		If @nProc <> 0
			SELECT @nError = @nProc

		If @Operacion = 'C' BEGIN
			EXECUTE	@nProc = BACLINEAS..Sp_Lineas_GrbOperacion	'BCC',
										@cProducto,
										@nNumoperSpt,
										@nNumoperSpt,
										@Operacion,
										@cCheque,
										@ControlaLinea
			If @nProc <> 0
				SELECT @nError = @nProc
		END
		ELSE BEGIN
			EXECUTE	@nProc = BACLINEAS..SP_GRABA_LIMITES_VENTAS	'BCC',
										@cProducto,
										@nNumoperSpt,
										@nNumoperSpt,
										@Operacion,
										@cCheque,
										@ControlaLinea
			If @nProc <> 0
				SELECT @nError = @nProc
		END
	END

	SET NOCOUNT OFF

	IF @nError = 0
       		SELECT @nError = 0
END

GO
