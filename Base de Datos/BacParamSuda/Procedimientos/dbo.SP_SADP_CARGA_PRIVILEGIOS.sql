USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CARGA_PRIVILEGIOS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_CARGA_PRIVILEGIOS]
   (   @Usuario   VARCHAR(15)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Tipo          VARCHAR(20)
       SET @Tipo          = (SELECT TOP 1 tipo_usuario FROM BacParamSuda.dbo.USUARIO with(nolock) WHERE usuario = @Usuario)

   SELECT 'Indice'        = Menu.Indice
      ,   'Posicion'      = Menu.Posicion
      ,   'Opcion'        = Menu.Opcion
      ,   'Descripcion'   = Menu.Descripcion
      ,   'habilitado'    = 'S'
     FROM dbo.SADP_PRIVILEGIOS     Ptip with(nolock)
          INNER JOIN dbo.SADP_MENU Menu with(nolock) ON Menu.Opcion = Ptip.Opcion AND Ptip.Habilitado = 1
    WHERE Ptip.Tipo       = 'T' 
      AND Ptip.Nombre     = @Tipo
      AND Ptip.Habilitado = 1

   UNION

   SELECT 'Indice'        = Menu.Indice
      ,   'Posicion'      = Menu.Posicion
      ,   'Opcion'        = Menu.Opcion
      ,   'Descripcion'   = Menu.Descripcion
      ,   'habilitado'    = 'S'
     FROM dbo.SADP_PRIVILEGIOS     Ptip with(nolock)
          INNER JOIN dbo.SADP_MENU Menu with(nolock) ON Menu.Opcion = Ptip.Opcion AND Ptip.Habilitado = 1
    WHERE Ptip.Tipo       = 'U' 
      AND Ptip.Nombre     = @Usuario
      AND Ptip.Habilitado = 1
 ORDER BY Menu.Indice

END
GO
