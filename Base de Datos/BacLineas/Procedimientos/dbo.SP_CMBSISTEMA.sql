USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBSISTEMA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CMBSISTEMA]
AS 
BEGIN
 SET NOCOUNT ON
 
 SELECT id_sistema
 ,      nombre_sistema
   FROM VIEW_SISTEMA_CNT  
  WHERE operativo = 'S' 
    AND gestion   = 'N'
  ORDER BY  nombre_sistema
 SET NOCOUNT OFF
END

GO
