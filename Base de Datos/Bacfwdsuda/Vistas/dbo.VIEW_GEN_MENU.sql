USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_GEN_MENU]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_GEN_MENU]
AS 
   SELECT 
         entidad         , 
         indice          ,
         nombre_opcion   ,                                  
         nombre_objeto   ,              
         posicion        ,
         entidadfox    
   FROM BACPARAMSUDA..GEN_MENU

GO
