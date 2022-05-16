USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_SISTEMAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCAR_SISTEMAS]
AS
BEGIN
   SELECT id_sistema
         ,nombre_sistema 
     FROM SISTEMA_CNT 
    WHERE operativo = 'S'
      and gestion   = 'N'
END 
GO
