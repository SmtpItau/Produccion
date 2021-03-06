USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasasMaximas_Chequea]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_TasasMaximas_Chequea] (	@cCodigo_Producto	CHAR	(05)	,
						@nCodigo_Moneda		NUMERIC	(05)	,
						@nDias			NUMERIC	(05)	,
						@nMonto			NUMERIC	(19,04)	,
						@nTasa			NUMERIC	(19,04)	)
AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	DECLARE @nTasaMinima	NUMERIC(09,04),
		@nTasaMaxima	NUMERIC(09,04),
		@nContador	INTEGER       ,
                @CONTROL        CHAR(01)       ,
                @cCodigo_Grupo  CHAR(10)


	SELECT	@nTasaMinima	= 0,
		@nTasaMaxima	= 0,
		@nContador	= 0

         SELECT @CONTROL = 'N'

         SET ROWCOUNT 1

         SELECT @cCodigo_grupo = codigo_grupo
         FROM	GRUPO_PRODUCTO_DETALLE
         WHERE codigo_producto = @cCodigo_Producto
        
-- select * from PRODUCTO_CONTROL

	SET ROWCOUNT 0

	SELECT	@CONTROL = estado
	FROM	PRODUCTO_CONTROL
	WHERE	codigo_control	= 'MAXCN'
	AND	Codigo_Producto = @cCodigo_Producto
	AND	id_sistema	='BTR'


	IF @CONTROL = 'N'
                  RETURN

 
	SELECT	@nContador	= COUNT(*)
	FROM	TASAS_MAXIMAS_CONVENCIONAL
	WHERE	@cCodigo_Producto	= Codigo_Producto
	AND	@nCodigo_Moneda		= Codigo_Moneda
	AND	@nDias			>=DiasDesde
        AND     @nDias                  <=DiasHasta
	AND	@nMonto			> MontoMinimo
	AND	@nMonto			<=MontoMaximo



	SELECT	@nTasaMinima	= TasaMinima,
		@nTasaMaxima	= TasaMaxima
	FROM	TASAS_MAXIMAS_CONVENCIONAL
	WHERE	@cCodigo_Producto	= Codigo_Producto
	AND	@nCodigo_Moneda		= Codigo_Moneda
	AND	@nDias			>=DiasDesde 
	AND	@nDias			<=DiasHasta
	AND	@nMonto			> MontoMinimo
	AND	@nMonto			<=MontoMaximo



	IF	@nContador = 0
	BEGIN
		SELECT Estado='NO', Descripcion = 'No Existen Tasas Maximas Convecionales Definidas Para esta Operación'
		RETURN
	END


	IF	@nContador > 1
	BEGIN
		SELECT Estado='NO', Descripcion = 'Multiple Difinición de Tasas Maximas Convecionales Para esta Operación'
		RETURN
	END


	IF	@nTasa < @nTasaMinima
	BEGIN
		SELECT Estado='NO', Descripcion = 'Tasa es Inferior a Tasa Minima Convencional Para esta Operación'
		RETURN
	END

	IF	@nTasa > @nTasaMaxima
	BEGIN
		SELECT Estado='NO', Descripcion = 'Tasa es Superior a Tasa Maxima Convencional Para esta Operación'
		RETURN
	END


	SELECT Estado='SI', Descripcion = 'Tasa Correcta'


	SET NOCOUNT OFF

END

GO
