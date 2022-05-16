USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_MER_VER_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_MER_VER_DAT] 
   (   @FECHA   DATETIME   )
AS 
BEGIN

   SELECT  COUNT(*) 
     FROM  TEXT_RSU 
     WHERE RSFECPRO = @FECHA
       AND rscartera = '333'
END

GO
