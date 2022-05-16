USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBSISTEMA2]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CMBSISTEMA2]
AS 
BEGIN
 SET NOCOUNT ON
 
 SELECT id_sistema
 ,      nombre_sistema
   FROM VIEW_SISTEMA_CNT
  WHERE id_sistema IN ('BCC','BFW','BTR','PCS')
  ORDER BY  nombre_sistema

 SET NOCOUNT OFF
END

GO
