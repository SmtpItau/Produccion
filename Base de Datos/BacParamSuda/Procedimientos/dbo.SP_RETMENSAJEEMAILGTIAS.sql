USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETMENSAJEEMAILGTIAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETMENSAJEEMAILGTIAS]
AS
BEGIN
	SET NOCOUNT ON
	SELECT ISNULL(MensajeEmail,'Sin mensaje')
	FROM BacParamsuda.dbo.tbl_Parametros_Gral_Garantias
END

GO
