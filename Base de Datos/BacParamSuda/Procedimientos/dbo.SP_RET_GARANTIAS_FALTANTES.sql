USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RET_GARANTIAS_FALTANTES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RET_GARANTIAS_FALTANTES]
AS
BEGIN
	SET NOCOUNT ON
	SELECT 	t.Fecha AS 'Fecha Emisión', t.RutCliente AS 'Rut Cliente', t.CodCliente AS 'Cód. Cliente', 
	c.clNombre AS 'Cliente', t.NumGarantia AS 'N° Garantía', t.MontoFaltante AS 'Faltante', t.MontoRequerido AS 'Requerido'
	FROM 	Bacparamsuda.dbo.tbl_Garantias_Faltantes t,
		Bacparamsuda.dbo.CLIENTE c
	WHERE	t.RutCliente = c.clRut
	AND	t.CodCliente = c.clCodigo
	AND	Avisado <> 'S'
	ORDER BY t.Fecha, t.RutCliente, t.NumGarantia
	SET NOCOUNT OFF
END

GO
