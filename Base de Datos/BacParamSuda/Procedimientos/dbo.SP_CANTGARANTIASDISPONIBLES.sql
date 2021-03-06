USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANTGARANTIASDISPONIBLES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CANTGARANTIASDISPONIBLES]
	(	@rutCliente	NUMERIC(9),
		@codCliente	NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON
	SELECT COUNT(DISTINCT a.NumeroOperacion)
	FROM 	tbl_Cartera_Garantia a,
		tbl_mov_garantia b
	WHERE	b.RutCliente = @rutCliente AND
		b.CodCliente = @codCliente AND	
		b.NumeroOperacion = a.NumeroOperacion AND
		a.NumeroOperacion NOT IN (SELECT NumeroOperacion FROM tbl_registro_garantias
						WHERE RutCliente = @rutCliente AND CodCliente = @codCliente)
END
GO
