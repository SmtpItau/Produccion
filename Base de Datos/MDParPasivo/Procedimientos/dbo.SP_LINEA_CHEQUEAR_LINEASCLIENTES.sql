USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_LINEASCLIENTES]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_LINEASCLIENTES]
			(
			@ccodigo_grupo		CHAR	(10)	,
			@dFecPro		DATETIME	,
			@nRutcli		NUMERIC	(09,0)	,
			@nCodigo		NUMERIC	(09,0)	,
			@dFecvctop		DATETIME	,
			@nMonto			NUMERIC	(19,4)	,
			@cTipo_Riesgo		CHAR	(01)	,
			@nMontoconriesgo	FLOAT		,
			@nMontosinriesgo	FLOAT
			)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT DMY


	DECLARE @cNombre		CHAR(60)
	DECLARE @cNombreCMatriz		CHAR(60)
	DECLARE	@iFound			INTEGER
	DECLARE @nRutcasamatriz		NUMERIC	(09,0)
	DECLARE @nCodigocasamatriz	NUMERIC	(09,0)
	DECLARE @cCtrlplazo		CHAR	(01)
	DECLARE @nTotalDisponible	NUMERIC	(19,4)
	DECLARE @nTotalOcu		NUMERIC	(19,4)
	DECLARE @nSinriesgoOcup		NUMERIC	(19,4)
	DECLARE @nConriesgoOcup		NUMERIC	(19,4)
	DECLARE @Bloqueado              CHAR(1)
	DECLARE @Filial                 CHAR(1)
	DECLARE @nExceso 		NUMERIC	(19,4)
	DECLARE @nSinriesgodisponible	NUMERIC	(19,4)
	DECLARE @nConriesgodisponible	NUMERIC	(19,4)
	DECLARE @nDisponible		NUMERIC	(19,4)
	DECLARE @Fecha_Vencimiento	DATETIME
	DECLARE @FechaFinContrato       DATETIME


	IF @nCodigo = 0			-- Generalmente cuando se envia a Chequear un emisor
		SELECT 	@nCodigo = clcodigo
		FROM 	CLIENTE WITH (NOLOCK)
		WHERE	clrut	 = @nRutcli

	SET @cNombre = ' : No existe en tabla de Clientes Rut : ' + + convert(char,@nRutcli)
      	SELECT 	@cNombre = ISNULL(clnombre,' : No existe en tabla de Clientes Rut :' + convert(char,@nRutcli))
              , @Filial  = clclsbif
	FROM 	CLIENTE WITH (NOLOCK)
	WHERE	clrut	 = @nRutcli
	AND	clcodigo = @nCodigo



	--*************** LINEA GENERAL

	SELECT	@iFound			= 0,
                @Bloqueado              = ' '
	SELECT	@iFound			= 1			,
		@nRutcasamatriz		= rutcasamatriz		,
		@nCodigocasamatriz	= codigocasamatriz      ,
                @Bloqueado              = Bloqueado		,
		@Fecha_Vencimiento	= FechaVencimiento      ,
                @FechaFinContrato      = FechaFinContrato
        FROM	LINEA_GENERAL WITH (NOLOCK)
	WHERE	rut_cliente		= @nRutcli
	AND 	codigo_cliente		= @nCodigo


	IF @iFound = 1 BEGIN

		--*************** LINEA GRUPO
		SELECT 	@iFound = 0,
                        @Bloqueado = ' '
		SELECT	@iFound 	        = 1		            ,
			@cCtrlplazo	        = controlaplazo             ,
                        @Bloqueado              = Bloqueado	            ,
			@Fecha_Vencimiento      = FechaVencimiento        ,
                        @FechaFinContrato       = FechaFinContrato        ,
                        @nTotalOcu		= TotalOcupado + @nMonto	, -- dls
    			@nSinriesgoOcup	 	= SinriesgoOcupado + @nMonto	,
			@nConriesgoOcup	 	= ConriesgoOcupado + @nMonto    ,
			@nDisponible		= TotalDisponible	        ,
			@nSinriesgodisponible 	= Sinriesgodisponible	        ,
			@nConriesgodisponible 	= Conriesgodisponible
	       	FROM	LINEA_SISTEMA WITH (NOLOCK)
		WHERE	rut_cliente	= @nRutcli 
		AND	codigo_cliente	= @nCodigo
		AND 	codigo_grupo    = @ccodigo_grupo

		IF @iFound = 0 BEGIN
			INSERT INTO #TEMP1 SELECT 'No Existe Linea Sistema Para ' + @cNombre
                END

    			--LINEA TOTAL **********************

			If @nDisponible < 0 BEGIN
                            SET @nExceso = @nMonto * (-1)
			END ELSE BEGIN
                            SET @nExceso = @nDisponible - @nMonto
                        END

			--SIN RIESGO **********************

			IF @cTipo_Riesgo = 'S' BEGIN
				If @nSinriesgoDisponible < 0 BEGIN
                                    SET @nExceso = @nMonto * (-1)
				END ELSE BEGIN 
                                    SET @nExceso = @nSinriesgoDisponible - @nMonto
                                END

			END

			--CON RIESGO **********************

			IF @cTipo_Riesgo = 'C' BEGIN
				
				If @nConriesgoDisponible < 0 BEGIN
                                	SET @nExceso = @nMonto * (-1)
                                END ELSE BEGIN
    				        SET @nExceso = @nConriesgoDisponible - @nMonto
                                END

                        END

		--*************** LINEA POR PLAZO

		IF @cCtrlplazo='S'BEGIN
			SET 	@iFound 	= 0
			SELECT	@iFound 	= 1
		       	FROM	LINEA_POR_PLAZO WITH (NOLOCK)
			WHERE	rut_cliente=@nRutcli
			AND	codigo_cliente=@nCodigo
			AND	codigo_grupo = @ccodigo_grupo
			AND	DATEDIFF(day, @dFecPro, @dFecvctop) >= plazodesde
			AND	DATEDIFF(day, @dFecPro, @dFecvctop) <= plazohasta

			IF @iFound = 0 BEGIN
				INSERT INTO #TEMP1 SELECT 'No Existe Linea Grupo ' + LTRIM(RTRIM(@ccodigo_grupo)) + ' Para Plazo '  + RTRIM(LTRIM(CONVERT(CHAR(06), DATEDIFF(day, @dFecPro, @dFecvctop)))) + ' Días Para ' + @cNombre
                      END
		END

	END

	ELSE

	INSERT INTO #TEMP1 SELECT 'No Existe Linea General Para ' + @cNombre

END







GO
