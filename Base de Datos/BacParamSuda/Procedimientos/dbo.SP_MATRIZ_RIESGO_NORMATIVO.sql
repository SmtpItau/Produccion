USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZ_RIESGO_NORMATIVO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MATRIZ_RIESGO_NORMATIVO]
   (   @iTag            INTEGER
   ,   @iCodigoRiesgo   INTEGER         = 0
   ,   @iplazo_desde    INTEGER         = 0
   ,   @iplazo_hasta    INTEGER         = 0
   ,   @nfactor1        NUMERIC(21,4)   = 0.0
   ,   @nfactor2        NUMERIC(21,4)   = 0.0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 0
   BEGIN
      SELECT codigo_riesgo, glosa_riesgo FROM RIESGO_NORMATIVO ORDER BY glosa_riesgo
   END
   
   IF @iTag = 1
   BEGIN
      SELECT plazo_desde     = plazo_desde
         ,   plazo_hasta     = plazo_hasta
         ,   factor1         = factor1
         ,   factor2         = factor2
        FROM MATRIZ_RIESGO_NORMATIVO with(nolock) 
       WHERE codigo_riesgo   = @iCodigoRiesgo
   END

   IF @iTag = 2
   BEGIN
      DELETE FROM MATRIZ_RIESGO_NORMATIVO 
            WHERE codigo_riesgo = @iCodigoRiesgo
   END

   IF @iTag = 3
   BEGIN
      INSERT INTO MATRIZ_RIESGO_NORMATIVO
      (   codigo_riesgo
      ,   plazo_desde
      ,   plazo_hasta
      ,   factor1
      ,   factor2
      )
      VALUES
      (   @iCodigoRiesgo
      ,   @iplazo_desde
      ,   @iplazo_hasta
      ,   @nfactor1
      ,   @nfactor2
      )
   END

END
GO
