USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_SISTEMA_DRV]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_SISTEMA_DRV]
    @cGrupo	CHAR(03)
AS
BEGIN
 set nocount on
 SELECT Id_Sistema
 FROM   TBL_AGRPROD 
 WHERE  Id_Grupo = @cGrupo
END 
GO
