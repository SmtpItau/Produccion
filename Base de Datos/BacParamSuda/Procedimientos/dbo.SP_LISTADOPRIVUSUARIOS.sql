USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOPRIVUSUARIOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADOPRIVUSUARIOS]
   (   @Usuario     CHAR(15)
   ,   @Tipo        CHAR(1)
   ,   @Titulo      VARCHAR(80) = ''
   )
AS
BEGIN 

   SET NOCOUNT ON

   IF @Tipo = 'U'
   BEGIN
      SELECT 'usuario'           = usr.usuario
      ,      'nombre'            = usr.nombre
      ,      'tipo_usuario'      = usr.tipo_usuario
      ,      'tipo_privilegio'   = 'U'
      ,      'entidad'           = pri.entidad
      ,      'nombre_opcion'     = CASE WHEN mnu.posicion = 0 THEN mnu.nombre_opcion
                                        WHEN mnu.posicion = 1 THEN '   ' + mnu.nombre_opcion
                                        WHEN mnu.posicion = 2 THEN '       ' + mnu.nombre_opcion
                                        WHEN mnu.posicion = 3 THEN '          ' + mnu.nombre_opcion
                                        ELSE                       mnu.nombre_opcion
                                   END 
      ,      'dias_expira'       = ISNULL(usr.dias_expiracion,0)
      ,      'titulo'            = @Titulo
      ,      'Banco_entidad'     = acnomprop
      FROM   BacParamSuda..USUARIO                   usr with(nolock)
             LEFT JOIN BacParamSuda..GEN_PRIVILEGIOS pri with(nolock) ON pri.usuario = usr.usuario
             LEFT JOIN BacParamSuda..GEN_MENU        mnu with(nolock) ON mnu.entidad = pri.entidad and mnu.nombre_objeto = pri.opcion
      ,      BacTraderSuda..MDAC                         with(nolock) 
      WHERE  usr.usuario         = @Usuario
      AND    pri.tipo_privilegio = 'U'
      AND    pri.habilitado      = 'S'
      ORDER BY mnu.entidad, mnu.indice

   END

   IF @Tipo = 'T'
   BEGIN

      SELECT 'usuario'           = pri.usuario
         ,   'nombre'            = tip.Descripcion
         ,   'tipo_usuario'      = tip.tipo_usuario
         ,   'tipo_privilegio'   = pri.tipo_privilegio
         ,   'entidad'           = pri.entidad
         ,   'nombre_opcion'     = CASE WHEN mnu.posicion = 0 THEN mnu.nombre_opcion
                                        WHEN mnu.posicion = 1 THEN '   ' + mnu.nombre_opcion
                                        WHEN mnu.posicion = 2 THEN '       ' + mnu.nombre_opcion
                                        WHEN mnu.posicion = 3 THEN '          ' + mnu.nombre_opcion
                                        ELSE                       mnu.nombre_opcion
                                   END 
         ,   'dias_expira'       = 0 --> tip.dias_expiracion
         ,   'titulo'            = @Titulo
         ,   'Banco_entidad'     = acnomprop
      FROM   BacParamSuda..GEN_TIPOS_USUARIO          tip with(nolock)
             LEFT JOIN BacParamSuda..GEN_PRIVILEGIOS  pri with(nolock) ON tip.tipo_usuario = pri.usuario
             LEFT JOIN BacParamSuda..GEN_MENU         mnu with(nolock) ON mnu.entidad      = pri.entidad and mnu.nombre_objeto = pri.opcion
      ,      BacTraderSuda..MDAC                          with(nolock) 
      WHERE  tip.Tipo_Usuario    = @usuario
        AND  pri.tipo_privilegio = 'T'
        AND  pri.habilitado      = 'S'
      ORDER BY pri.usuario, pri.entidad, mnu.indice

   END

END
GO
