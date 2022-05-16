USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACINFORMACIONBASICA_LEEMONEDAS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACINFORMACIONBASICA_LEEMONEDAS]
AS 
BEGIN

SET NOCOUNT ON

 SELECT mncodmon
 ,      mnglosa 
 ,      mnnemo
 ,      mnsimbol 
   FROM VIEW_MONEDA 
  WHERE mnmx <> 'C' 
  ORDER BY mnglosa

SET NOCOUNT OFF

END
GO
