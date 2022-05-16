USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSA_SISTEMA2]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GLOSA_SISTEMA2]
AS 
BEGIN
 SET NOCOUNT ON
 
   SELECT id_sistema
   ,      nombre_sistema
     FROM VIEW_SISTEMA_CNT
    ORDER BY nombre_sistema
 
 SET NOCOUNT OFF
END
GO
