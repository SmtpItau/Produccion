USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_CMBPLAZA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Corresponsales_CmbPlaza    fecha de la secuencia de comandos: 03/04/2001 15:18:01 ******/
CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_CMBPLAZA]
as 
begin
 set nocount on
 
 select codigo_plaza,glosa,codigo_pais
 from PLAZA 
  
 
 set nocount off
end 
GO
