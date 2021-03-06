USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_USUARIOS_COMEX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_TRAE_USUARIOS_COMEX]
   (   @Usuario    CHAR(15)      
   ,   @sOpcion    CHAR(1)    = ''      
   , @iMoneda INT     = 13     
   )      
AS      
BEGIN      
      
   SET NOCOUNT ON      
      
   -->   (CASE WHEN LTRIM(RTRIM(USU.clase)) = '' THEN TIPOUSU.clase ELSE USU.clase END)      
      
   SELECT 'Nombre' = usr.nombre      
      ,   'Perfil' = CASE WHEN ltrim(rtrim( usr.Clase )) = '' THEN Tip.clase ELSE usr.clase END      
      ,   'MtoMax' = isnull( cto.Monto,   0.0)      
      ,   'Origen' = isnull( cla.nemo, '')      
      ,   'Glosa'  = isnull( cla.tbglosa, '')      
   FROM   BacParamSuda.dbo.USUARIO                         usr      
          LEFT JOIN BacParamSuda.dbo.GEN_TIPOS_USUARIO     tip ON usr.Tipo_Usuario = tip.Tipo_Usuario      
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE cla ON cla.tbcateg      = 8602 and tbcodigo1 = usr.clase      
          LEFT JOIN (SELECT Monto  = ISNULL( MAX(montomax), 0.0)  
       ,  Perfil = perfil_comercial    
                      FROM BacCamSuda.dbo.COSTOS_COMEX, MEAC       
                     WHERE fecha = acfecpro       
        AND CodMoneda  = @iMoneda     
                  GROUP BY perfil_comercial )               cto ON cto.Perfil       = usr.clase      
   WHERE usr.usuario = @Usuario      
      
END     
GO
