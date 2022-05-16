USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBSISTEMA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CMBSISTEMA]
AS 
BEGIN
 SET NOCOUNT ON
 
 SELECT id_sistema,nombre_sistema
 
 FROM SISTEMA_CNT  
 
 WHERE operativo='S' and  gestion ='N'
 
 ORDER BY  nombre_sistema
 SET NOCOUNT OFF
END
-- select * from sistema_cnt
GO
