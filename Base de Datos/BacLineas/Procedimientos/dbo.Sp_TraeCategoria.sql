USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TraeCategoria]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TraeCategoria    fecha de la secuencia de comandos: 03/04/2001 15:18:13 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_TraeCategoria    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
create procedure [dbo].[Sp_TraeCategoria]
as 
begin
 set nocount on
 select
  ctcateg,
  ctdescrip
  from 
  TABLA_GENERAL_GLOBAL  
 set nocount off
end 






GO
