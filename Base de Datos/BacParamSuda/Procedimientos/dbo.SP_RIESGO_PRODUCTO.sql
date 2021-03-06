USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIESGO_PRODUCTO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RIESGO_PRODUCTO]
   (   @iTag               INTEGER
   ,   @Id_Sistema         VARCHAR(3) = ''
   ,   @Producto           VARCHAR(5) = ''
   ,   @nRiesgoNormativo   INTEGER    = 0
   ,   @nRiesgoInterno     INTEGER    = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 0
   BEGIN
      SELECT GlosaProducto    = LTRIM(RTRIM(P.id_sistema)) + '-' + LTRIM(RTRIM(P.descripcion))
      ,      RiegoNormativo   = ISNULL(A.glosa_riesgo, 'SIN ASIGNACION') --> riesgo_normativo
      ,      RiesgoInterno    = ISNULL(B.glosa_riesgo, 'SIN ASIGNACION') --> riesgo_interno
      ,      CodigoProducto   = P.codigo_producto
      ,      Modulo           = P.id_sistema
      ,      CodNormativo     = P.riesgo_normativo
      ,      CodInterno       = P.riesgo_interno
      FROM   BacParamSuda..PRODUCTO     P with(nolock) 
             LEFT JOIN BacParamSuda..RIESGO_NORMATIVO A with(nolock) ON A.codigo_riesgo = riesgo_normativo
             LEFT JOIN BacLineas..RIESGOINTERNO       B with(nolock) ON B.codigo_riesgo = riesgo_interno
      WHERE  P.id_sistema IN('PCS', 'BFW')
      ORDER BY P.id_sistema, P.codigo_producto
   END

   IF @iTag = 1
   BEGIN
      SELECT codigo_riesgo, glosa_riesgo FROM RIESGO_NORMATIVO with(nolock) ORDER BY glosa_riesgo
   END
   IF @iTag = 2
   BEGIN
      SELECT codigo_riesgo, glosa_riesgo FROM BacLineas..RIESGOINTERNO with(nolock) ORDER BY glosa_riesgo
   END

   IF @iTag = 3
   BEGIN
      UPDATE BacParamSuda..PRODUCTO
         SET riesgo_normativo = @nRiesgoNormativo
         ,   riesgo_interno   = @nRiesgoInterno
       WHERE id_sistema       = @Id_Sistema
        AND  codigo_producto  = @Producto
   END

END
GO
