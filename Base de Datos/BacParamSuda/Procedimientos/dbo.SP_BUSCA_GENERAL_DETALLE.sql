USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_GENERAL_DETALLE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_GENERAL_DETALLE] 
 AS
 BEGIN
 	
    SELECT * FROM tabla_general_detalle WHERE tbcateg = 6000
	
 END

GO
