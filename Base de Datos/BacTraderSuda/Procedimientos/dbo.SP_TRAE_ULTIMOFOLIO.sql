USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_ULTIMOFOLIO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_ULTIMOFOLIO]
     
AS
BEGIN
   SELECT isnull(MAX(Correla_Interno),0) + 1 FROM  BAC_TESORERIA_FOLIOS 
END


GO
