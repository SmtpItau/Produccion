USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_SISTAMA_CNT]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_SISTAMA_CNT]
AS  
BEGIN  
   
SET NOCOUNT ON  
-- Sistemas que generan transacciones
 SELECT id_sistema  
 ,      nombre_sistema  
 ,      operativo   
   FROM VIEW_SISTEMA_CNT   
  WHERE operativo = 'S'   
    AND gestion   = 'N'  
-- Grupos de Sistemas
union
 SELECT id_sistema = Gr.Id_Grupo
 ,      nombre_sistema = Sis.nombre_Sistema
 ,      operativo      = 'S' 
   FROM VIEW_SISTEMA_CNT Sis,  TBL_AGRPROD Gr
  WHERE Gr.Id_Grupo = Sis.Id_Sistema
  ORDER BY nombre_sistema  
  
SET NOCOUNT OFF  
  
END  
GO
