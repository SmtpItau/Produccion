USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIV]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DIV]
      (   @n   FLOAT        ,
          @d   FLOAT        ,
          @r   FLOAT OUTPUT 
      )
AS
BEGIN
   SET NOCOUNT ON
   IF @d = 0.0 BEGIN
      SELECT @r = 0.0
   END ELSE BEGIN 
      SELECT @r = @n / @d
   END
   SET NOCOUNT OFF
END



GO
