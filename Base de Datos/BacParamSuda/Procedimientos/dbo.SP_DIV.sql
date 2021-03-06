USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIV]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DIV]( @num FLOAT, @den FLOAT , @div FLOAT OUTPUT )
WITH RECOMPILE
AS
BEGIN
     IF @den <> 0
        SELECT @div = @num / @den * 1.0
     ELSE
        SELECT @div = 0.0
END  -- Procedure

GO
