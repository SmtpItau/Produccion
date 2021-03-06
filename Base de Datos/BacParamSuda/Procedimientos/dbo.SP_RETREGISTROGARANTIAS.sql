USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETREGISTROGARANTIAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETREGISTROGARANTIAS]
AS
BEGIN
	SET NOCOUNT ON
	SELECT	NumeroGarantia,
		RutCliente,
		CodCliente,
		cl.clnombre,
		FolioAsocia
	FROM	BacParamsuda.dbo.tbl_gar_AsociacionGtia,
		BacParamsuda.dbo.CLIENTE cl
	WHERE	RutCliente = cl.clrut
	AND	CodCliente = cl.clcodigo
	ORDER BY NumeroGarantia ASC	

	SET NOCOUNT OFF
END

GO
