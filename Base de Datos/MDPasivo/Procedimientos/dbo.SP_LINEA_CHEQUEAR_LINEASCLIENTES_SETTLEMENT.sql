USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_LINEASCLIENTES_SETTLEMENT]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_LINEASCLIENTES_SETTLEMENT]
			(
			@ccodigo_grupo		CHAR	(10)	,
			@dFecPro		DATETIME	,
			@nRutcli		NUMERIC	(09,0)	,
			@nCodigo		NUMERIC	(09,0)	,
			@dFecvctop		DATETIME	,
			@nMonto			NUMERIC	(19,4)	,
			@cTipo_Riesgo		CHAR	(01)	,
			@nMontoconriesgo	FLOAT		,
			@nMontosinriesgo	FLOAT		,
                        @nForma_Pago            INTEGER
			)
AS BEGIN
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
		FROM 	CLIENTE
		WHERE	clrut	 = @nRutcli

      	SELECT 	@cNombre = clnombre
              , @Filial  = clclsbif              
	FROM 	CLIENTE
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
                @FechaFinContrato       = FechaFinContrato
        FROM	LINEA_GENERAL
	WHERE	rut_cliente		= @nRutcli
	AND 	codigo_cliente		= @nCodigo



	IF @iFound = 1 
	BEGIN

                IF @Bloqueado = 'S'
                     INSERT INTO #TEMP1 SELECT 'Linea General bloqueada para ' + @cNombre

		IF @Fecha_Vencimiento < @dFecPro OR @FechaFinContrato < @dFecpro
                     INSERT INTO #TEMP1 SELECT 'Linea General bloqueada por vencimiento para ' + @cNombre


                IF @dFecvctop > @FechaFinContrato
                     INSERT INTO #TEMP1 SELECT 'Fecha Vcto. de operación es mayor a la Fecha Fin de Contrato General para ' + @cNombre

		--*************** LINEA CASA MATRIZ
		IF @nRutcasamatriz > 0 AND @Filial = 'F'
		BEGIN

			SELECT 	@cNombreCMatriz = isnull((SELECT  clnombre  FROM CLIENTE 
                                                                            WHERE	clrut	 	= @nRutcasamatriz
                                                                             AND	clcodigo 	= @nCodigocasamatriz
                                                         ),'NO EXISTE')

			SELECT 	@iFound 		= 0

			SELECT	@iFound 		= 1				,
				@nTotalOcu		= TotalOcupado + @nMonto	,
				@nSinriesgoOcup	 	= SinriesgoOcupado + @nMonto	,
				@nConriesgoOcup	 	= ConriesgoOcupado + @nMonto    ,
				@nDisponible		= TotalDisponible	        ,
				@nSinriesgodisponible 	= Sinriesgodisponible	        ,
				@nConriesgodisponible 	= Conriesgodisponible
		       	FROM	LINEA_AFILIADO
			WHERE	rutcasamatriz 	= @nRutcasamatriz
			AND 	codigocasamatriz= @nCodigocasamatriz

			IF @iFound = 0
				INSERT INTO #TEMP1 SELECT 'No existe Línea para Filiales de ' + @cNombreCMatriz


			IF @nTotalOcu > @nMontosinriesgo
				INSERT INTO #TEMP1 SELECT 'Monto Sobrepasa Linea para Filiales de ' + @cNombreCMatriz


			IF @cTipo_Riesgo = "S"
                              IF @nSinriesgoOcup > @nMontosinriesgo
				INSERT INTO #TEMP1 SELECT 'Monto Sobrepasa Linea Sin Riesgo para Filiales de ' + @cNombreCMatriz


			IF @cTipo_Riesgo = "C"
				IF @nConriesgoOcup > @nMontoConriesgo
					INSERT INTO #TEMP1 SELECT 'Monto Sobrepasa Linea Con Riesgo para Filiales de ' + @cNombreCMatriz


			--LINEA TOTAL **********************

			If @nDisponible < 0	SELECT @nExceso = @nMonto * (-1)
			ELSE			SELECT @nExceso = @nDisponible - @nMonto


			IF @nExceso < 0
				INSERT INTO #TEMP1 SELECT 'Linea Grupo Excedido Para ' + @cNombreCMatriz


			--SIN RIESGO **********************


			IF @cTipo_Riesgo = "S"
			BEGIN

				If @nSinriesgoDisponible < 0	SELECT @nExceso = @nMonto * (-1)
				ELSE				SELECT @nExceso = @nSinriesgoDisponible - @nMonto

				IF @nExceso < 0
					INSERT INTO #TEMP1 SELECT 'Linea Grupo (Con Garantía) Excedido Para ' + @cNombreCMatriz

			END

			--CON RIESGO **********************


			IF @cTipo_Riesgo = "C"
			BEGIN
				
				If @nConriesgoDisponible < 0	SELECT @nExceso = @nMonto * (-1)
         			ELSE				SELECT @nExceso = @nConriesgoDisponible - @nMonto

				IF @nExceso < 0
      				        INSERT INTO #TEMP1 SELECT 'Linea Grupo (Sin Garantía) Excedido Para ' + @cNombreCMatriz

			END


		END

		--*************** LINEA SISTEMA
		SELECT 	@iFound = 0,
                        @Bloqueado = ' '
		SELECT	@iFound 	= 1		,
			@cCtrlplazo	= controlaplazo ,
                        @Bloqueado      = Bloqueado	,
			@Fecha_Vencimiento = FechaVencimiento,
                        @FechaFinContrato = FechaFinContrato
	       	FROM	LINEA_SISTEMA
		WHERE	rut_cliente	= @nRutcli 
		AND	codigo_cliente	= @nCodigo
		AND 	codigo_grupo    = @ccodigo_grupo

		IF @iFound = 0
			INSERT INTO #TEMP1 SELECT 'No Existe Linea Sistema Para ' + @cNombre

                IF @Bloqueado = 'S'
                     INSERT INTO #TEMP1 SELECT 'Linea Sistema Bloqueada para ' + @cNombre

		IF @Fecha_Vencimiento < @dFecPro OR @FechaFinContrato < @dFecpro
                     INSERT INTO #TEMP1 SELECT 'Linea Sistema Bloqueada por Vencimiento para ' + @cNombre

                IF @dFecvctop > @FechaFinContrato
                     INSERT INTO #TEMP1 SELECT 'Fecha Vcto. de Operacion es Mayor a la Fecha Fin de Contrato de Sistema para ' + @cNombre


		--*************** LINEA POR PLAZO

		IF @cCtrlplazo='S'
		BEGIN


			SELECT 	@iFound 	= 0
			SELECT	@iFound 	= 1
		       	FROM	LINEA_POR_PLAZO
			WHERE	rut_cliente=@nRutcli
			AND	codigo_cliente=@nCodigo
			AND	codigo_grupo = @ccodigo_grupo
			AND	plazodesde <= DATEDIFF(day, @dFecPro, @dFecvctop)
			AND	plazohasta  > DATEDIFF(day, @dFecPro, @dFecvctop)

--			IF @iFound = 0
--				INSERT INTO #TEMP1 SELECT 'No Existe Linea Para Plazo '  + RTRIM(LTRIM(CONVERT(CHAR(06), DATEDIFF(day, @dFecPro, @dFecvctop)))) + ' Días Para ' + @cNombre

		END

	END
	ELSE
		INSERT INTO #TEMP1 SELECT 'No Existe Linea General Para ' + @cNombre

SET NOCOUNT OFF
END







GO
