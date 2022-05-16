USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAEMONEDAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAEMONEDAS]
AS
BEGIN
 
 SET NOCOUNT ON

   SELECT mncodmon
   ,      mnglosa 
     FROM VIEW_MONEDA
ORDER BY MNGLOSA

 SET NOCOUNT OFF
END
GO
