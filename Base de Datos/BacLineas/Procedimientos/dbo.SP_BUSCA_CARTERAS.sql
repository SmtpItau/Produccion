USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CARTERAS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BUSCA_CARTERAS]
AS BEGIN
	SELECT	tbcodigo1
	,		tbglosa 
	FROM BacparamSuda.dbo.TABLA_GENERAL_DETALLE 
	WHERE tbcateg  = 204
END
GO
