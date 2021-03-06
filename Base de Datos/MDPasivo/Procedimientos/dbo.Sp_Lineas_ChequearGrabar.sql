USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_ChequearGrabar]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_ChequearGrabar]
			(
                        @dFecPro		CHAR(08)        ,
			@cSistema		CHAR	(03)	,
			@cProducto		CHAR	(05)	,
			@nNumoper		NUMERIC	(10)	,
			@nNumdocu		NUMERIC	(10,0)	,
			@nCorrela		NUMERIC	(10,0)	,
			@nRutcli		NUMERIC	(09,0)	,
			@nCodigo		NUMERIC	(09,0)	,
			@nMonto			FLOAT		,
			@nMtoori		FLOAT		,
			@fTipcambio		FLOAT		,
			@dFecvctop		CHAR(08)	,
			@cUsuario		CHAR	(15)	,
			@nRut_emisor		NUMERIC	(09)	,
			@nMonedaEmision		NUMERIC	(03)	,
			@dFecvctoInst		CHAR(08)	,
			@nInCodigo		NUMERIC	(05)	,
			@cSeriado		CHAR	(01)	,
			@cModPago		CHAR	(01)	,
			@cTipo_Riesgo		CHAR	(01)	,
			@nCodigo_pais		NUMERIC	(05)	,
			@cPagoCheque		CHAR	(01)	,
			@nRutCheque		NUMERIC	(09,0)	,
			@dFecvctoCehque		CHAR(08)	,
			@nFactorVenta		FLOAT		,
                        @FormaPago		NUMERIC (03,00)	,
			@Ccodigo_carterasuper	CHAR	(01) = ' ',
                        @nMoneda_Control        NUMERIC(3)	,
			@nMoneda1		NUMERIC	(03) = 0,
			@nMoneda2		NUMERIC	(03) = 0,
			@nCorrelativoFrp	INT 	= 0,
			@nMontoMX2		FLOAT	=0	
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	SET NOCOUNT ON
	SET DATEFORMAT DMY

	DECLARE @Codigo_Grupo	CHAR(10)
        DECLARE @cTipo_Moneda   CHAR(1)
        DECLARE @cTipo_Moneda_Pac  CHAR(1)
        DECLARE @cFuerte        CHAR(1)
        DECLARE @nParidad       FLOAT
        DECLARE @cNemo          CHAR(8)
	DECLARE @settlement	CHAR(1)
	DECLARE @nInCodigoMatr  INTEGER

	DECLARE	@nMontoCLP	FLOAT,
		@nMontoUSD	FLOAT,
		@nMontoMX	FLOAT,
		@nMonedaAUX	NUMERIC(03)


        SELECT @cTipo_Moneda =  mnextranj, 
               @cFuerte      =  mnrrda,
               @cNemo        =  mnnemo
        FROM MONEDA WITH (NOLOCK INDEX=PK_MONEDA)
        WHERE mncodmon = @nMonedaEmision

        SELECT @cTipo_Moneda_pac =  mnextranj
        FROM MONEDA WITH (NOLOCK INDEX=PK_MONEDA)
        WHERE mncodmon = @nMoneda1

        IF @cTipo_Moneda_pac = '0' and (@cProducto = 'CI' or @cProducto ='VI' )BEGIN
           SELECT  @cProducto = rtrim(@cProducto) + 'X'
        END

        IF @nRutcli = 0
                SELECT @nRutcli = clrut 
                    ,  @nCodigo = clcodigo
                        FROM CLIENTE WITH (NOLOCK) WHERE NumPro_PU = @nCodigo



	IF @nRut_emisor = 0
		SELECT @nRut_emisor = @nRutcli 



	IF @cSistema = 'BTR' AND @cProducto in('CP','VP')
             SELECT  @nInCodigoMatr = @nincodigo 
        ELSE
             SELECT  @nInCodigoMatr = 0



--        IF @nincodigo = 0 BEGIN
--             SELECT  @nincodigo = incodigo FROM INSTRUMENTO WHERE INSERIE=@cProducto
--        END



	SELECT	@Codigo_Grupo = codigo_grupo
	FROM	GRUPO_PRODUCTO_DETALLE  WITH (NOLOCK)
	WHERE	id_sistema		= @cSistema
	AND	codigo_producto		= @cProducto
	AND	codigo_instrumento	= @nInCodigoMatr




	SELECT @Codigo_Grupo = ISNULL(@Codigo_Grupo, ' ')
-- select * from GRUPO_PRODUCTO_DETALLE

	IF @cSistema = 'BCC' BEGIN
		SELECT @settlement = settlement FROM FORMA_DE_PAGO  WITH (NOLOCK INDEX=PK_FORMA_DE_PAGO) WHERE codigo = @FormaPago

		IF @settlement = '1'
			SELECT @Codigo_Grupo = 'SETTLE'
	END



        
	IF @cSistema = 'BTR' BEGIN
	        SELECT @cSeriado = 'N'
        	SELECT @cSeriado = inmdse FROM INSTRUMENTO WITH (NOLOCK INDEX=PK_INSTRUMENTO)
	        WHERE incodigo = @nInCodigo
	END



	SELECT	@nMontoCLP = @nMonto,
		@nMontoUSD = @nMtoori,
		@nMontoMX  = @nMontoMX2


        SELECT @nParidad  = 1


	IF @cSistema = 'INV' OR (@csistema ='BTR' AND @cTipo_Moneda = '0' AND @cProducto NOT IN('CIX','VIX')) BEGIN


		IF @cTipo_Moneda = '0' BEGIN

			SELECT @nParidad = CASE WHEN Vmparidad  = 0 
						THEN 1 ELSE Vmparidad 
						END
			FROM	VIEW_POSICION
			WHERE	codigo_area = 'PTAS'
			AND	vmcodigo    = @cNemo  
			AND	Vmfecha     = @dFecPro


			IF @cFuerte = 'D' BEGIN
				SELECT  @nMonto = @nMonto / @nParidad 
			END ELSE BEGIN
               			SELECT  @nMonto = @nMonto * @nParidad 
			END 

	                SELECT @nMontoCLP = ROUND(@nMonto * (CASE WHEN vmvalor = 0 THEN 1
	                                                 ELSE ISNULL(vmvalor, 1)
	                                            END ),0)
	                FROM VALOR_MONEDA  WITH (NOLOCK INDEX=PK_VALOR_MONEDA)
	                WHERE vmcodigo = 994 AND 
	                      vmfecha  = @dFecPro 

		END


        END 


	IF (@csistema ='BTR' AND @cProducto IN('CIX','VIX')) BEGIN

		SELECT @nMontoCLP = @nMonto

                SELECT @nMontoUSD = ROUND(@nMontoCLP / (CASE WHEN vmvalor = 0 THEN 1
	                                                 ELSE ISNULL(vmvalor, 1)
	                                            END ),2)
	                FROM VALOR_MONEDA  WITH (NOLOCK INDEX=PK_VALOR_MONEDA)
	                WHERE vmcodigo = 994 AND 
	                      vmfecha  = @dFecPro 

			SELECT @nParidad = CASE WHEN Vmparidad  = 0 
						THEN 1 ELSE Vmparidad 
						END
			FROM	VIEW_POSICION
			WHERE	codigo_area = 'PTAS'
			AND	vmcodigo    = @cNemo  
			AND	Vmfecha     = @dFecPro


			IF @cFuerte = 'D' BEGIN
				SELECT  @nMontoMx = @nMontoUSD / @nParidad 
			END ELSE BEGIN
               			SELECT  @nMontoMX = @nMontoUSD * @nParidad 
			END 

		SELECT @nMonto = @nMontoCLP

        END 


	IF @cSistema = 'BTR' AND @cProducto IN('ICOL','ICAP','FPD') AND @nMoneda1 <> 999 BEGIN

                SELECT @nMonto = ROUND(@nMonto * (CASE WHEN vmvalor = 0 THEN 1
                                                 ELSE ISNULL(vmvalor, 1)
                                            END ),0)
                FROM VALOR_MONEDA  WITH (NOLOCK INDEX=PK_VALOR_MONEDA)
                WHERE vmcodigo = @nMoneda1 AND 
                      vmfecha  = @dFecPro 


        END 




	IF @cSistema = 'BTR' BEGIN
                SELECT @nMtoori = @nMonto / (CASE WHEN vmvalor = 0 THEN 1
                                                 ELSE ISNULL(vmvalor, 1)
                                            END )
                FROM VALOR_MONEDA  WITH (NOLOCK INDEX=PK_VALOR_MONEDA)
                WHERE vmcodigo = 994 AND 
                      vmfecha  = @dFecPro 
        END 



        SELECT @nMonto = @nMonto / (CASE WHEN vmvalor = 0 THEN 1
					ELSE ISNULL(vmvalor, 1)
                                    	END )
        FROM VALOR_MONEDA  WITH (NOLOCK INDEX=PK_VALOR_MONEDA)
        WHERE vmcodigo = @nMoneda_Control  
        AND  vmfecha  = @dFecPro 


	DELETE	LINEA_CHEQUEAR WITH (ROWLOCK)
	WHERE	NumeroOperacion		= @nNumoper
	AND	Numerodocumento		= @nNumdocu
	AND	NumeroCorrelativo	= @nCorrela
	AND	Id_Sistema		= @cSistema
	AND	Codigo_Producto		= @cProducto
        AND   	nCorrelativoFrp		= @nCorrelativoFrp


	INSERT INTO LINEA_CHEQUEAR WITH (ROWLOCK)
		(
		FechaOperacion		,
		NumeroOperacion		,
		Numerodocumento		,
		NumeroCorrelativo	,
		Rut_Cliente		,
		Codigo_Cliente		,
		Id_Sistema		,
		Codigo_Producto		,
		Codigo_Grupo		,
		MontoTransaccion	,
		MontoOriginal      	,
		TipoCambio		,
		FechaVencimiento	,
		Operador		,
		Rut_Emisor		,
		Moneda_Emision		,
		FechaVctoInst		,
		InCodigo		,
		Seriado			,
		Compensacion		,
		Tipo_Riesgo		,
		codigo_pais		,
		Pago_Cheque		,
		Rut_Cheque		,
		FechaVctoCheque		,
		FactorVenta		,
                FormaPago		,
		codigo_carterasuper	,
		Moneda1			,
		Moneda2			,
		nCorrelativoFrp		,
		MontoMX2	
		)
	SELECT 	@dFecPro		,
		@nNumoper		,
		@nNumdocu		,
		@nCorrela		,
		@nRutcli		,
		@nCodigo		,
		@cSistema		,
		@cProducto		,
		@Codigo_Grupo		,
		@nMontoCLP		,
		@nMontoUSD		, 
		@fTipcambio		,
		@dFecvctop		,
		@cUsuario		,
		@nRut_emisor		,
		@nMonedaEmision		,
		@dFecvctoInst		,
		@nInCodigo		,
		@cSeriado		,
		@cModPago		,
		@cTipo_Riesgo		,
		@nCodigo_pais		,
		@cPagoCheque		,
		@nRutCheque		,
		@dFecvctoCehque		,
		@nFactorVenta           ,
                @FormaPago		,
		@Ccodigo_carterasuper	,
		@nMoneda1		,
		@nMoneda2		,
		@nCorrelativoFrp	,
		@nMontoMX

	SELECT cGrupo = @Codigo_Grupo

END

GO
