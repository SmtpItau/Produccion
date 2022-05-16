USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_USUARIO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_USUARIO]
AS 
   SELECT 
         usuario     ,
         clave          ,
         nombre         ,                         
         tipo_usuario   ,
         fecha_expira   ,           
         cambio_clave ,
         bloqueado ,
  Reset_Psw      
   FROM BACPARAMSUDA..USUARIO

GO
