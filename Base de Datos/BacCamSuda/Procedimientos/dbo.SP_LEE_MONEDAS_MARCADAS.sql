USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MONEDAS_MARCADAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_MONEDAS_MARCADAS]
	(	@moUNegocios	CHAR(3)	)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT mpcodmon, mpestado  FROM MONEDAS_COMEX WHERE mpUnegocio = @moUNegocios

END
GO
