USE [BacLineas]
GO
/****** Object:  View [dbo].[VIEW_USUARIO]    Script Date: 13-05-2022 10:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_USUARIO]
AS 
   SELECT usuario     
      ,   clave          
      ,   nombre                                  
      ,   tipo_usuario   
      ,   fecha_expira              
      ,   cambio_clave 
      ,   bloqueado
      ,   clase 
      ,   clave_anterior1 
      ,   clave_anterior2 
      ,   clave_anterior3 
      ,   Largo_Clave 
      ,   Tipo_Clave 
      ,   Dias_Expiracion 
      ,   RutUsuario

   FROM bacparamsuda..USUARIO





GO
