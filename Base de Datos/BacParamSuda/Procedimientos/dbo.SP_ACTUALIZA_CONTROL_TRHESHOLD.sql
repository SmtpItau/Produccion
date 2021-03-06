USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_CONTROL_TRHESHOLD]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_CONTROL_TRHESHOLD]
   (   @Segmento   INTEGER
   ,   @Modulo     CHAR(3)
   ,   @Producto   INTEGER
   ,   @Plazo      NUMERIC(9) = 0
   ,   @Threshold  CHAR(1)    = 'N'
   ,   @Riesgo     CHAR(1)    = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   SET @Riesgo = CASE WHEN @Riesgo = ''  THEN ''
                      WHEN @Riesgo = 'S' THEN 'N'
                      WHEN @Riesgo = 'C' THEN 'S'
                 END

   UPDATE BacParamSuda.dbo.TBL_CONTROL_THRESHOLD 
      SET Plazo     = @Plazo
      ,   Threshold = @Threshold
    WHERE Segmento  = @Segmento
      AND Modulo    = @Modulo
      AND Producto  = @Producto
      AND Riesgo    = @Riesgo

END
GO
