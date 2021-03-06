USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADMINISTRACION_PERFIL]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ADMINISTRACION_PERFIL]
   (   @iTag          INTEGER
   ,   @xUsuario      VARCHAR(15)
   ,   @xSistema      VARCHAR(3)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 1
   BEGIN
      SELECT DISTINCT Lin_Inst_Financiera, Lin_Otra_Instirucion, Impresion_Papelteas, Monitor_Operaciones, Liberacion_Operaciones
      FROM  BacLineas.dbo.PERFIL_USUARIO_LINEAS
      WHERE Usuario = @xUsuario
   END

   IF @iTag = 2
   BEGIN
      SELECT DISTINCT Sistema, nombre_sistema
        FROM BacLineas.dbo.PERFIL_USUARIO_LINEAS
             INNER JOIN BacParamSuda.dbo.SISTEMA_CNT ON id_sistema = Sistema
      WHERE  Usuario  = @xUsuario
      AND    Activado = 1
   END
   
   IF @iTag = 3
   BEGIN
      SELECT DISTINCT codigo_producto, descripcion
        FROM BacLineas.dbo.PERFIL_USUARIO_LINEAS 
             INNER JOIN BacParamSuda.dbo.PRODUCTO ON id_sistema = Sistema  AND codigo_producto = Producto
      WHERE Usuario  = @xUsuario
      AND  (Sistema  = @xSistema or @xSistema = '')
      AND   Activado = 1
   END

END
GO
