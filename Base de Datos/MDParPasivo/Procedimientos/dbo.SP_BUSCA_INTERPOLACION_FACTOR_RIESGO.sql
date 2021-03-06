USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_INTERPOLACION_FACTOR_RIESGO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_INTERPOLACION_FACTOR_RIESGO]
( 
                             @id_Sistema	CHAR	(5)	,
                             @Producto		CHAR	(5)	,
                             @Instrumento	NUMERIC (05,0) 	,
                             @nMoneda1      	NUMERIC (05,0) 	,
                             @nMoneda2    	NUMERIC (05,0)	,
                             @dFecPro    	DATETIME 	,
                             @dFecvcto_Grupo	DATETIME	,
                             @dFecvctop        	DATETIME	,
			     @nMontolin      	NUMERIC(19,4)	,
			     @nMatrizriesgo	FLOAT	OUTPUT
)
AS

BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
        SET NOCOUNT ON
        SET DATEFORMAT dmy

	--Variables de Calculo de Interpolacion Lineas
	DECLARE	@Dias_Grupo		INTEGER
	DECLARE	@Dias			INTEGER
	DECLARE	@Dias_Inicio            INTEGER
	DECLARE	@Dias_Inicio_AUX	INTEGER
	DECLARE	@Dias_Fin               INTEGER
	DECLARE	@Dias_Fin_AUX           INTEGER
	DECLARE	@Flujo_Inicio        	FLOAT
	DECLARE	@Flujo_Inicio_AUX      	FLOAT
	DECLARE	@Flujo_Fin	        FLOAT
	DECLARE	@Flujo_Fin_AUX	        FLOAT
        DECLARE	@Pendiente	        FLOAT
        DECLARE	@Factor_Riesgo	        FLOAT
	DECLARE @iFound			INT
	DECLARE @iFound_AUX		INT
	SET	@iFound		= 0
	SET	@nMatrizriesgo	= 0


--	select @cCodigo_Grupo , @nMoneda1 , @nMoneda2 ,@dFecPro, @dFecvctop , @nMatrizriesgo 
        --INTERPOLACION DEL FACTOR DE RIESGO 
        --Dias del Flujo

        SET  @Dias_Grupo = DATEDIFF(day, @dFecPro, @dFecvcto_Grupo)
        SET  @Dias = DATEDIFF(day, @dFecPro, @dFecvctop)


	IF @id_Sistema = 'BCC'
	BEGIN
		SELECT	@nMatrizriesgo	= 100
		RETURN
	END

	SELECT	@Dias_Inicio_AUX = 0


        IF EXISTS(  	SELECT 1 FROM MATRIZ_RIESGO WITH(NOLOCK)
			WHERE	id_sistema = @id_Sistema
			AND	codigo_producto = @Producto
			AND	codigo_instrumento = @Instrumento
			AND	dias_grupo_hasta <= @Dias_Grupo
			AND	codigo_moneda = @nMoneda1
			AND	codigo_moneda2= @nMoneda2)
        BEGIN

		SELECT	@Dias_Inicio_AUX = ISNULL(max(dias_grupo_desde),0)
		FROM	MATRIZ_RIESGO WITH(NOLOCK)
		WHERE	id_sistema = @id_Sistema
		AND	codigo_producto = @Producto
		AND	codigo_instrumento = @Instrumento
		AND	dias_grupo_hasta <= @Dias_Grupo
		AND	codigo_moneda 	= @nMoneda1
		AND	codigo_moneda2	= @nMoneda2

        END
	ELSE
	BEGIN

		SELECT	@Dias_Inicio_AUX = dias_grupo_desde
		FROM	MATRIZ_RIESGO WITH(NOLOCK)
		WHERE	id_sistema = @id_Sistema
		AND	codigo_producto = @Producto
		AND	codigo_instrumento = @Instrumento
		AND	dias_grupo_desde > @Dias_Grupo
		AND	dias_grupo_hasta <= @Dias_Grupo
		AND	codigo_moneda 	= @nMoneda1
		AND	codigo_moneda2	= @nMoneda2

        END




        --Obtiener Flujo Inicial **************************************
        SET	@Flujo_Inicio	= 0  --Inicializa el Flujo de Inicio

        IF EXISTS(  	SELECT 1 FROM MATRIZ_RIESGO WITH(NOLOCK)
			WHERE	id_sistema = @id_Sistema
			AND	codigo_producto = @Producto
			AND	codigo_instrumento = @Instrumento
			AND	dias_grupo_desde < @Dias_Grupo
			AND	dias_grupo_hasta >= @Dias_Grupo
			AND	dias_hasta<= @Dias
			AND	codigo_moneda = @nMoneda1
			AND	codigo_moneda2= @nMoneda2)
        BEGIN

		SELECT	@Dias_Inicio	= ISNULL(max(dias_desde),0) -- Obtiene la Fecha para buscar el Flujo de Inicio
		FROM	MATRIZ_RIESGO WITH(NOLOCK)
		WHERE	id_sistema = @id_Sistema
		AND	codigo_producto = @Producto
		AND	codigo_instrumento = @Instrumento
		AND	dias_grupo_desde < @Dias_Grupo
		AND	dias_grupo_hasta >= @Dias_Grupo
		AND	dias_hasta	<= @Dias
		AND	codigo_moneda 	= @nMoneda1
		AND	codigo_moneda2	= @nMoneda2

		SELECT	@Flujo_Inicio	= isnull(porcentaje,0)      -- Obtiene el Flujo de Inicio
		FROM	MATRIZ_RIESGO WITH(NOLOCK)
		WHERE	id_sistema = @id_Sistema
		AND	codigo_producto = @Producto
		AND	codigo_instrumento = @Instrumento
		AND	dias_grupo_desde < @Dias_Grupo
		AND	dias_grupo_hasta >= @Dias_Grupo
		AND	dias_desde	= @Dias_Inicio
		AND	codigo_moneda 	= @nMoneda1
		AND 	codigo_moneda2	= @nMoneda2



		SELECT	@iFound = 0

		SELECT	@Flujo_Inicio_aux = isnull(porcentaje,0),      -- Obtiene el Flujo de Inicio DESDE EL GRUPO ANTERIOR
			@iFound = 1
		FROM	MATRIZ_RIESGO WITH(NOLOCK)
		WHERE	id_sistema = @id_Sistema
		AND	codigo_producto = @Producto
		AND	codigo_instrumento = @Instrumento
		AND	dias_grupo_desde= @Dias_Inicio_AUX
		AND	dias_desde	= @Dias_Inicio
		AND	codigo_moneda 	= @nMoneda1
		AND 	codigo_moneda2	= @nMoneda2


		IF @iFound = 0 SELECT @Flujo_Inicio_aux = @Flujo_Inicio



        END
	ELSE
	BEGIN
		-- Si no Existe Flujo Anterior se asume como inicial el mismo porcentaje del primer flujo
		SELECT	@Flujo_Inicio	= isnull(porcentaje,0),
			@Dias_Inicio	= dias_desde
		FROM	MATRIZ_RIESGO WITH(NOLOCK)
		WHERE	id_sistema = @id_Sistema
		AND	codigo_producto = @Producto
		AND	codigo_instrumento = @Instrumento
		AND	dias_grupo_desde < @Dias_Grupo
		AND	dias_grupo_hasta >= @Dias_Grupo
		AND	dias_desde     <= @Dias
		AND	dias_hasta     >= @Dias
		AND  	codigo_moneda 	= @nMoneda1
		AND	codigo_moneda2	= @nMoneda2



		SELECT	@iFound = 0

		SELECT	@Flujo_Inicio_aux = isnull(porcentaje,0),      -- Obtiene el Flujo de Inicio DESDE EL GRUPO ANTERIOR
			@iFound = 1
		FROM	MATRIZ_RIESGO WITH(NOLOCK)
		WHERE	id_sistema = @id_Sistema
		AND	codigo_producto = @Producto
		AND	codigo_instrumento = @Instrumento
		AND	dias_grupo_desde= @Dias_Inicio_AUX
		AND	dias_desde	= @Dias_Inicio
		AND	codigo_moneda 	= @nMoneda1
		AND 	codigo_moneda2	= @nMoneda2


		IF @iFound = 0 SELECT @Flujo_Inicio_aux = @Flujo_Inicio


        END


        -- 	Fin Flujo Inicial **************************************
        --	Obtiene Dias Inicial - Dias Final - Flujo Final

        SET	@Dias_Inicio	= 0
        SET     @Dias_Fin	= 0
        SET     @Flujo_fin      = 0
	SET     @iFound	        = 0



	SELECT	@Dias_Inicio		= dias_desde ,
		@Dias_Fin		= dias_Hasta ,
		@Dias_Fin_AUX		= dias_grupo_Hasta ,
		@Flujo_fin 		= isnull(porcentaje,0),
		@iFound			= 1
	FROM	MATRIZ_RIESGO WITH(NOLOCK)
	WHERE	id_sistema = @id_Sistema
	AND	codigo_producto = @Producto
	AND	codigo_instrumento = @Instrumento
	AND	dias_grupo_desde < @Dias_Grupo
	AND	dias_grupo_hasta >= @Dias_Grupo
	AND	dias_desde     <= @Dias
	AND	dias_hasta     >= @Dias
	AND	codigo_moneda 	= @nMoneda1
	AND	codigo_moneda2	= @nMoneda2



	SELECT	@iFound_AUX = 0	

	SELECT	@Flujo_fin_AUX 		= isnull(porcentaje,0),
		@iFound_AUX		= 1
	FROM	MATRIZ_RIESGO WITH(NOLOCK)
	WHERE	id_sistema 	= @id_Sistema
	AND	codigo_producto = @Producto
	AND	codigo_instrumento = @Instrumento
	AND	dias_grupo_desde= @Dias_Inicio_AUX
	AND	dias_desde      = @Dias_Inicio
	AND	codigo_moneda 	= @nMoneda1
	AND	codigo_moneda2	= @nMoneda2


	IF @iFound_AUX = 0
		SELECT	@Flujo_fin_AUX = @Flujo_fin

--	SELECT	@iFound	= 1 , @nMatrizriesgo	= 100 WHERE @ccodigo_grupo= 'SETTLE'
--select @Flujo_Inicio_Aux, @Flujo_fin_Aux
--select @Flujo_Inicio , @Flujo_fin

	IF @iFound = 1
	BEGIN

		IF @Flujo_Inicio_aux <> @Flujo_Inicio BEGIN
                        SET @Pendiente	= (@Dias_Fin_Aux - @Dias_Inicio_AUX)/ ( @Flujo_Inicio - @Flujo_Inicio_aux )
      	                SET @Flujo_Inicio = @Flujo_Inicio_Aux + (@Dias_Grupo - @Dias_Inicio_AUX) / @Pendiente
		END


		IF @Flujo_Fin_aux <> @Flujo_Fin BEGIN
                        SET @Pendiente	= (@Dias_Fin_AUX - @Dias_inicio_AUX) / ( @Flujo_Fin - @Flujo_Fin_aux )
       	                SET @Flujo_Fin	= @Flujo_Fin_Aux + (@Dias_Grupo - @Dias_Inicio_AUX) / @Pendiente
		END

--select 'interpolados', @Flujo_Inicio , @Flujo_fin

		IF @Flujo_Fin <> @Flujo_Inicio	BEGIN
                        SET @Pendiente	   = (@Dias_Fin - @Dias_Inicio)/(@Flujo_Fin - @Flujo_Inicio)
       	                SET @nMatrizriesgo = @Flujo_Inicio + (@Dias - @Dias_Inicio) / @Pendiente
		END
		ELSE BEGIN
     		        SET @nMatrizriesgo = @Flujo_Inicio
		END

		IF @nMatrizriesgo > 0 SET @nMontolin = ROUND(@nMontolin/ 100 * @nMatrizriesgo,4)

	END	

--select Dias_Grupo=@Dias_Grupo, incio_aux = @Dias_Inicio_AUX, fin_aux = @Dias_Fin_Aux, Dias=@Dias, DIAS_INICIO = @Dias_Inicio, DIAS_FIN = @Dias_fIN
--select @nMatrizriesgo		

END

GO
