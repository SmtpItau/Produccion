USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_RETGARANTIASDISPONIBLES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_RETGARANTIASDISPONIBLES]
	(	@rutCliente NUMERIC(9),
		@codCliente NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON


	SELECT 	b.NumeroOperacion, 
		b.Fecha, 
		(SELECT SUM(a.ValorPresente) FROM tbl_Cartera_Garantia a WHERE a.NumeroOperacion = b.NumeroOperacion) AS ValorPresente,
		b.FechaVigencia
	FROM 	tbl_mov_garantia b,
		TABLA_GENERAL_DETALLE c
	WHERE	b.RutCliente = @rutCliente AND
		b.CodCliente = @codCliente AND	
		c.tbcateg = 8700 AND
		c.nemo = 'C' AND	--- C de Constituidas
		b.TipoGarantia = c.tbcodigo1 AND
		b.NumeroOperacion NOT IN (SELECT NumeroGarantia 
			FROM BacParamSuda.dbo.tbl_gar_AsociacionGtia
			WHERE RutCliente = @rutCliente AND
			CodCliente = @codCliente)
	ORDER BY b.NumeroOperacion
END	
GO
