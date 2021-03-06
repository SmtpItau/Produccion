USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHKRELACION_OPER_GARANTIAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CHKRELACION_OPER_GARANTIAS]
	(
		@modo CHAR(3)
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @cantidad INTEGER,
		@i INTEGER,
		@borrado NUMERIC(10)

	SELECT 	@cantidad = 0,
		@i = 0
	

	CREATE TABLE #listaBorrar(indice INTEGER identity,
			  numGtia NUMERIC(10))

	IF @modo = 'BFW'
	BEGIN
		INSERT INTO #listaBorrar
		SELECT NumeroOperacion
		FROM Bacparamsuda..tbl_registro_garantias
		WHERE Sistema = 'BFW'
		AND OperacionSistema  NOT IN (SELECT canumoper FROM Bacfwdsuda..mfca WHERE canumoper = OperacionSistema)
	END
	IF @modo = 'PCS'
	BEGIN
		INSERT INTO #listaBorrar
		SELECT NumeroOperacion
		FROM Bacparamsuda..tbl_registro_garantias
		WHERE Sistema = 'PCS'
		AND OperacionSistema  NOT IN (SELECT numero_operacion FROM BacSwapsuda..Cartera 
						WHERE numero_operacion = OperacionSistema
						AND tipo_flujo = 1 AND numero_flujo = 1)
	END

	/* Proceso de eliminación de la relación de garantías - operaciones */

	SELECT @cantidad = COUNT(*) FROM #listaBorrar
	IF @cantidad > 0
	BEGIN
		SELECT @i = 1
		WHILE @i <= @cantidad
		BEGIN
			SELECT @borrado = numGtia FROM #listaBorrar WHERE indice = @i
			DELETE FROM Bacparamsuda..tbl_registro_garantias WHERE NumeroOperacion = @borrado 
			SELECT @i = @i + 1
		END
	END
	SET NOCOUNT OFF
END
GO
