USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_PERFIL_USUARIO_LINEAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PERFIL_USUARIO_LINEAS]
   (   @iTag                     INTEGER
   ,   @Usuario                  VARCHAR(15)   = ''
   ,   @Sistema                  CHAR(3)       = ''
   ,   @Lin_Inst_Financiera      INTEGER       = 0
   ,   @Lin_Otra_Instirucion     INTEGER       = 0
   ,   @Impresion_Papelteas      INTEGER       = 0
   ,   @Monitor_Operaciones      INTEGER       = 0
   ,   @Liberacion_Operaciones   INTEGER       = 0
   ,   @Producto                 VARCHAR(5)    = ''
   ,   @Tipo_Cliente             INTEGER       = 0
   ,   @Activado                 INTEGER       = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 1
   BEGIN
      SELECT usuario = RTRIM(LTRIM(usuario))
         ,   nombre  = CASE WHEN CHARINDEX('-',nombre, 1) > 0 THEN RTRIM(LTRIM(SUBSTRING(nombre, 1, CHARINDEX('-',nombre, 1) - 1)))
                            ELSE nombre
                       END
      FROM   BacParamSuda.dbo.USUARIO
      WHERE  usuario      <> 'ADMINISTRA'
      ORDER BY usuario
   END

   IF @iTag = 2
   BEGIN
      SELECT sis.id_sistema
      ,      LTRIM(RTRIM(pro.codigo_producto))
      ,      LTRIM(RTRIM(pro.descripcion))
      FROM   BacParamSuda..SISTEMA_CNT            sis with(nolock) 
             INNER JOIN BacParamSuda.dbo.PRODUCTO pro with(nolock) ON sis.id_sistema = pro.id_sistema
      WHERE  sis.operativo  = 'S' AND sis.gestion = 'N'
      and   (sis.id_sistema = @Sistema or @Sistema = '')
      AND    pro.estado     = 1
      ORDER BY sis.id_sistema, pro.descripcion
   END

   IF @iTag = 3
   BEGIN
      SELECT id_sistema     = id_sistema
      ,      nombre_sistema = LTRIM(RTRIM(nombre_sistema))
      FROM   BacParamSuda.dbo.SISTEMA_CNT 
      WHERE  operativo      = 'S'
      AND    gestion        = 'N'
   END

   IF @iTag = 4
   BEGIN
      SELECT Codigo = tbcodigo1
      ,      Glosa  = nemo
      FROM   BacParamSuda.dbo.TABLA_GENERAL_DETALLE 
      WHERE  tbcateg = 72
      ORDER BY tbglosa
   END

   IF @iTag = 5
   BEGIN
      DELETE FROM dbo.PERFIL_USUARIO_LINEAS
            WHERE Usuario = @Usuario
              AND Sistema = @Sistema
   END

   IF @iTag = 6
   BEGIN
      INSERT INTO dbo.PERFIL_USUARIO_LINEAS
      (   Usuario
      ,   Sistema
      ,   Lin_Inst_Financiera
      ,   Lin_Otra_Instirucion
      ,   Impresion_Papelteas
      ,   Monitor_Operaciones
      ,   Liberacion_Operaciones
      ,   Producto
      ,   Tipo_Cliente
      ,   Activado
      )
      VALUES
      (   @Usuario
      ,   @Sistema
      ,   @Lin_Inst_Financiera
      ,   @Lin_Otra_Instirucion
      ,   @Impresion_Papelteas
      ,   @Monitor_Operaciones
      ,   @Liberacion_Operaciones
      ,   @Producto
      ,   @Tipo_Cliente
      ,   @Activado
      )

      UPDATE dbo.PERFIL_USUARIO_LINEAS
         SET Lin_Inst_Financiera    = @Lin_Inst_Financiera
         ,   Lin_Otra_Instirucion   = @Lin_Otra_Instirucion
         ,   Impresion_Papelteas    = @Impresion_Papelteas
         ,   Monitor_Operaciones    = @Monitor_Operaciones
         ,   Liberacion_Operaciones = @Liberacion_Operaciones
       WHERE Usuario                = @Usuario

   END

   IF @iTag = 7
   BEGIN
      SELECT Usuario
      ,      Sistema
      ,      Lin_Inst_Financiera
      ,      Lin_Otra_Instirucion
      ,      Impresion_Papelteas
      ,      Monitor_Operaciones
      ,      Liberacion_Operaciones
      ,      Producto
      ,      Tipo_Cliente
      ,      Activado 
      FROM   dbo.PERFIL_USUARIO_LINEAS
      WHERE  Usuario = @Usuario
      and   (Sistema = @Sistema or @Sistema = '')
      ORDER BY Usuario, Sistema, Producto, Tipo_Cliente
   END

END
GO
