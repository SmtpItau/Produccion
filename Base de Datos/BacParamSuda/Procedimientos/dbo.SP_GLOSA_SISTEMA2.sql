USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSA_SISTEMA2]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Glosa_Sistema2    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
CREATE PROCEDURE [dbo].[SP_GLOSA_SISTEMA2]
as 
begin
 set nocount on
 select id_sistema,nombre_sistema
 from SISTEMA_CNT 
 
 
 set nocount off
end
GO
