USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TODOS_SISTEMAS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TODOS_SISTEMAS]
AS
BEGIN
 SELECT  nombre_sistema             + SPACE(50) + id_sistema     
 FROM VIEW_SISTEMA_CNT 
 WHERE  id_sistema ='BTR' 
 OR  id_sistema ='BFW'
 OR  id_sistema ='BCC'
END


GO
