USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAOPERGARANTIAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRAOPERGARANTIAS]
	(	@numGarantia	NUMERIC(9),
		@rutCliente	NUMERIC(9),
		@codCliente	NUMERIC(5),
		@codSistema	CHAR(3),
		@numOperacion	NUMERIC(9)
	)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_Registro_Garantias WHERE NumeroOperacion = @numGarantia
						AND RutCliente = @rutCliente
						AND CodCliente = @codCliente
						AND Sistema    = @codSistema
						AND OperacionSistema = @numOperacion)

		/* Ver si hay candidatos a eliminar en tbl_Garantias_Faltantes */
		IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_Garantias_Faltantes
			WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias
			WHERE Sistema  = @codSistema AND OperacionSistema = @numOperacion))
			
			DELETE Bacparamsuda..tbl_Garantias_Faltantes
			WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias
			WHERE Sistema = @codSistema AND OperacionSistema = @numOperacion)
	
		/* Continuar con el proceso de eliminación del registro de garantías */	

		DELETE FROM Bacparamsuda..tbl_Registro_Garantias WHERE NumeroOperacion = @numGarantia
						AND RutCliente = @rutCliente
						AND CodCliente = @codCliente
						AND Sistema    = @codSistema
						AND OperacionSistema = @numOperacion
END
GO
