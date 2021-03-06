USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_RETRESUMENGTIAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_RETRESUMENGTIAS]
	(
		@Fecha	DATETIME,
		@Tipo	CHAR(1)
	)
AS
BEGIN	
	IF @Tipo = 'C'
		SELECT 	enc.NumeroOperacion,
		enc.Fecha,
		enc.FechaVigencia,
		enc.RutCliente,
		enc.CodCliente,
		cl.Clnombre
		FROM	Bacparamsuda.dbo.tbl_mov_garantia enc,
			Bacparamsuda.dbo.CLIENTE cl
		WHERE	enc.Fecha = @Fecha
		AND	cl.Clrut = enc.RutCliente
		AND	cl.Clcodigo = enc.CodCliente
		ORDER BY enc.NumeroOperacion ASC
	ELSE
		SELECT 	enc.Folio,
		enc.Fecha,
		enc.FechaVigencia,
		enc.RutCliente,
		enc.CodCliente,
		cl.Clnombre
		FROM	Bacparamsuda.dbo.tbl_garantias_otorgadas enc,
			Bacparamsuda.dbo.CLIENTE cl
		WHERE	enc.Fecha = @Fecha
		AND	cl.Clrut = enc.RutCliente
		AND	cl.Clcodigo = enc.CodCliente
		ORDER BY enc.Folio ASC
END
GO
