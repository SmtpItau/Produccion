USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GARANTIAS_ASOCIADAS_OPERACION]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GARANTIAS_ASOCIADAS_OPERACION]
	(
		@rSistema	CHAR(3),
		@rOpSistema	NUMERIC(10)
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	@asociados AS INTEGER,
		@lista AS VARCHAR(400),
		@i AS INTEGER,
		@tope AS INTEGER

	SELECT 	@asociados = 0,
		@lista = ''

	SELECT 	@asociados = COUNT(NumeroOperacion) FROM Bacparamsuda..tbl_registro_garantias
		WHERE Sistema = @rSistema AND OperacionSistema = @rOpSistema

	IF @asociados > 0
	BEGIN
		CREATE TABLE #Asociados(folio INTEGER identity,
			NumOp NUMERIC(10))

		INSERT INTO #Asociados
		SELECT NumeroOperacion
		FROM Bacparamsuda..tbl_registro_garantias
		WHERE Sistema = @rSistema AND OperacionSistema = @rOpSistema
		ORDER BY NumeroOperacion ASC

		SELECT @tope = COUNT(*) FROM #Asociados
		SELECT @i = 0
		WHILE @i <= @tope
		BEGIN
			SELECT @lista = @lista + CONVERT(VARCHAR(10),NumOp)+'-' FROM #Asociados WHERE folio = @i
			SELECT @i = @i + 1
		END
	END

	IF LEN(@lista) > 0
		SELECT @lista = SUBSTRING(@lista, 1, LEN(@lista)-1)

	SELECT 	@asociados AS 'Cantidad', @lista AS 'Garantias'

	SET NOCOUNT OFF
END
GO
