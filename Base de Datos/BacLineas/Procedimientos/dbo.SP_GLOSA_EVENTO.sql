USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSA_EVENTO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_GLOSA_EVENTO    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
create procedure [dbo].[SP_GLOSA_EVENTO]
  (@glosa_EVENTO char(30))
as 
begin
 set nocount on
 select codigo_evento,descripcion
 from VIEW_LOG_EVENTO
 where descripcion=@glosa_EVENTO
 set nocount off
end
GO
