USE [BacSwapSuda]
GO
/****** Object:  View [dbo].[view_gen_menu]    Script Date: 13-05-2022 11:17:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[view_gen_menu]
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
