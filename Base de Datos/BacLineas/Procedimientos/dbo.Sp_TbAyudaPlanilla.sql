USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TbAyudaPlanilla]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TbAyudaPlanilla    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
create procedure [dbo].[Sp_TbAyudaPlanilla]
  
as
begin
 set nocount off
 SELECT codigo_tabla,codigo_caracter,glosa
 FROM AYUDA_PLANILLA
 WHERE codigo_numerico=0 AND codigo_caracter="0"
 ORDER BY codigo_numerico
     set nocount on
end






GO
