USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_MOTIVOS_BLOQUEOCLIENTES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_MNT_MOTIVOS_BLOQUEOCLIENTES]
(
	 @codMotivo		NUMERIC(5,0) = 0
	,@descMotivo	VARCHAR(70) = ''
	,@modoOpera		CHAR(1) = 'L'
)
AS
BEGIN
	SET NOCOUNT ON
	IF @modoOpera = 'L'		--- Leer toda la tabla
	BEGIN
		SELECT	 codMotivo
				,descMotivo
		FROM BacParamsuda..TBL_MOTIVOS_BLOQUEOCLIENTES
		ORDER BY codMotivo ASC
		RETURN 0
	END
	IF @modoOpera = 'I'		--- Insertar
	BEGIN
		IF @codMotivo < 0 OR @descMotivo = ''
		BEGIN
			SELECT -1, 'Motivo en blanco o fuera de rango'
			RETURN 1
		END
		IF @codMotivo >= 0 AND @descMotivo <> ''
			INSERT INTO BacParamsuda..TBL_MOTIVOS_BLOQUEOCLIENTES
			VALUES(@codMotivo, @descMotivo)

		RETURN 0
	END
	IF @modoOpera = 'U'		--- Actualizar
	BEGIN
		IF @codMotivo < 0
		BEGIN
			SELECT -1, 'Motivo fuera de rango'
			RETURN 1
		END
		IF @descMotivo = ''
		BEGIN
			SELECT -1, 'El detalle del motivo está en blanco!'
			RETURN 1
		END
		IF NOT EXISTS(SELECT codMotivo FROM BacParamsuda..TBL_MOTIVOS_BLOQUEOCLIENTES WHERE codMotivo = @codMotivo)
		BEGIN
			SELECT -1, 'No se encontró el motivo para actualizar!'
			RETURN 1
		END
		UPDATE BacParamsuda..TBL_MOTIVOS_BLOQUEOCLIENTES
		SET  descMotivo = @descMotivo
		WHERE codMotivo = @codMotivo 
		RETURN 0
	END

	IF @modoOpera = 'D'		--- Eliminar (Delete)
		IF EXISTS(SELECT codMotivo FROM BacParamsuda..TBL_MOTIVOS_BLOQUEOCLIENTES)
		BEGIN
			--- Validar que no existen bloqueos con el código a eliminar!
			IF EXISTS(SELECT rutCliente FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES
					WHERE codMotivo = @codMotivo)
			BEGIN		
					SELECT -1, 'Hay bloqueos con el código seleccionado!'
					RETURN 1
			END

			DELETE FROM BacParamsuda..TBL_MOTIVOS_BLOQUEOCLIENTES
			WHERE codMotivo = @codMotivo
			RETURN 0
		END
		ELSE
		BEGIN
			SELECT -1, 'No se encontró el motivo para eliminar!'
			RETURN 1
		END
END			
GO
