USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AUTORIZA_EJECUTAR_TABLA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_AUTORIZA_EJECUTAR_TABLA]( @Usuario CHAR(100))
AS
BEGIN
-- Objetivo : al usuario enviado como parametro le atribuye permiso de ejecucion a procedimientos
-- Autor    : Miguel Gajardo
-- Fecha    : 11 de Julio de 2001
 SET NOCOUNT ON
 DECLARE @Objecto CHAR(255)
 DECLARE @Instruccion VARCHAR(500)
 DECLARE @Cont  INTEGER
 DECLARE @Total  INTEGER
 IF NOT EXISTS(SELECT uid FROM sysusers WHERE name = @Usuario) BEGIN
  PRINT 'Usuario enviado al procedimientos no existe en la base de datos'
  RETURN
 END
  
 SELECT @Total = COUNT(*) FROM sysobjects WHERE type <> 'S' AND type = 'U' --and category = 0
 SELECT @Cont  = 1
 WHILE @Cont <= @Total
 BEGIN
  SET ROWCOUNT @Cont
  SELECT @Instruccion = 'GRANT SELECT,INSERT,UPDATE,DELETE ON ' + name + ' TO ' + @Usuario FROM sysobjects WHERE type <> 'S' AND type = 'U' --and ategory = 0
  SET ROWCOUNT 0
  SELECT @Cont = @Cont + 1  
  EXECUTE(@Instruccion)
 END
 
 SET NOCOUNT OFF
END
-- sp_autoriza_ejecutar_tabla 'bacuser'


GO
