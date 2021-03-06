USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TOTALGARANTIASCLIENTE]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TOTALGARANTIASCLIENTE]
	(	@rutCliente NUMERIC(9),
		@codCliente NUMERIC(5)	
	)
AS
BEGIN
	SET NOCOUNT ON

	SELECT ISNULL(SUM(b.ValorPresente),0)
	FROM	Bacparamsuda.dbo.tbl_mov_garantia a,
		Bacparamsuda.dbo.tbl_mov_garantia_detalle b
	WHERE	a.RutCliente = @rutCliente AND
		a.CodCliente = @codCliente AND
		a.TipoMovimiento = 'I' AND
		a.Estado = 'V' AND
		a.NumeroOperacion = b.NumeroOperacion
END
GO
