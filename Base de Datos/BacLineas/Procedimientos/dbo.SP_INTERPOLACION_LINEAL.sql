USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERPOLACION_LINEAL]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERPOLACION_LINEAL]   (   @X1   FLOAT
                                          ,   @X2   FLOAT
                                          ,   @Y1   FLOAT
                                          ,   @Y2   FLOAT
                                          ,   @X    FLOAT
                                          ,   @Y    FLOAT OUTPUT
                                          )
AS BEGIN


   SET NOCOUNT ON

   SELECT   @Y   = @Y1 + (@Y2 - @Y1) / (@X2 - @X1) * (@X - @X1)



END
GO
