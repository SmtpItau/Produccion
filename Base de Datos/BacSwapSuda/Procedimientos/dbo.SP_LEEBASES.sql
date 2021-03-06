USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEBASES]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEEBASES]  
   (   @Codigo    NUMERIC(3) = 0
   ,   @iProducto INT    = 0  
   )
AS 
BEGIN

   SET NOCOUNT ON

   SELECT codigo , glosa , dias , base
   ,      LTRIM(RTRIM(glosa)) 
        + SPACE(50) 
        + LTRIM(RTRIM(dias)) 
        + REPLICATE(' ' , 5 - LEN(LTRIM(RTRIM(dias)))) 
        + LTRIM(RTRIM(base))
        + REPLICATE(' ', 5 - LEN(LTRIM(RTRIM(base))))
   FROM   BASE
         
END
GO
