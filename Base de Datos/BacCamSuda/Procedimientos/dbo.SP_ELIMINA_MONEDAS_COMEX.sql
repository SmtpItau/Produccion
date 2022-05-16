USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_MONEDAS_COMEX]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_MONEDAS_COMEX]	
	(	@moUNegocios	CHAR(3)	)
AS
BEGIN
	DELETE FROM dbo.MONEDAS_COMEX WHERE mpUnegocio = @moUNegocios and mpcodmon <> 13
END
GO
