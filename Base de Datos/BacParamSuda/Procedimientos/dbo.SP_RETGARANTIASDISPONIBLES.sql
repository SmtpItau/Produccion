USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETGARANTIASDISPONIBLES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETGARANTIASDISPONIBLES]
	(	@rutCliente NUMERIC(9),
		@codCliente NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON
	SELECT a.NumeroOperacion, b.Fecha, a.ValorPresente, b.FechaVigencia
	FROM 	tbl_Cartera_Garantia a,
		tbl_mov_garantia b,
		TABLA_GENERAL_DETALLE c
	WHERE	b.RutCliente = @rutCliente AND
		b.CodCliente = @codCliente AND	
		b.NumeroOperacion = a.NumeroOperacion AND
		c.tbcateg = 8700 AND
		c.nemo = 'C' AND	--- C de Constituidas
		b.TipoGarantia = c.tbcodigo1 AND
		a.NumeroOperacion NOT IN (SELECT NumeroOperacion FROM tbl_registro_garantias
						WHERE RutCliente = @rutCliente AND CodCliente = @codCliente)

	ORDER BY a.NumeroOperacion
END	
GO
