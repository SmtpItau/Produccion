USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_GLOSAMAIL]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_GLOSAMAIL]
AS
BEGIN
	SET NOCOUNT ON
	SELECT 		ISNULL( SubjectEmail  , 'N/A' )  as AsuntoEmail
		,	ISNULL(MensajeEmail, 'Sin Mensaje') AS GlosaEmail
	FROM dbo.tbl_Parametros_Gral_Garantias
	SET NOCOUNT OFF
END
GO
