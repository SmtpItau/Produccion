USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAECATEGORIA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TRAECATEGORIA    fecha de la secuencia de comandos: 03/04/2001 15:18:13 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_TRAECATEGORIA    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[SP_TRAECATEGORIA]
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
