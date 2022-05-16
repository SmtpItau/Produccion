USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETDESTINATARIOSEMAILGTIAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETDESTINATARIOSEMAILGTIAS]
	(	@tipoDestinatario INTEGER
	)
AS
BEGIN
	SET NOCOUNT ON
	SELECT NombreDestinatario, DireccionEmail
	FROM Bacparamsuda.dbo.tbl_gar_DireccionEmail
	WHERE TipoDestinatario = @tipoDestinatario
END
GO
