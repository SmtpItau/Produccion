USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_TIPO_DESTINATARIO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_TIPO_DESTINATARIO]
AS
BEGIN

	SET NOCOUNT ON

	SELECT codigo  = tbcodigo1
	,      glosa   = tbglosa
	  FROM BacparamSuda.dbo.TABLA_GENERAL_DETALLE
	 WHERE tbcateg = 7209;

	SET NOCOUNT OFF
END
GO
