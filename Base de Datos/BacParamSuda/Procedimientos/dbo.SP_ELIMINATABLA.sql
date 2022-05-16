USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINATABLA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINATABLA]
   (   @tbcateg   NUMERIC(5)
   ,   @tbcodigo1 CHAR(6)    = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DELETE TABLA_GENERAL_DETALLE 
   WHERE  tbcateg   = @tbcateg 
   AND   (tbcodigo1 = @tbcodigo1 or @tbcodigo1 = '')

END
GO
