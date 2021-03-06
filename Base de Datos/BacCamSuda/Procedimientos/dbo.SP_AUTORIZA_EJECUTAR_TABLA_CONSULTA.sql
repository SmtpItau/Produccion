USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AUTORIZA_EJECUTAR_TABLA_CONSULTA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_AUTORIZA_EJECUTAR_TABLA_CONSULTA]( @Usuario CHAR(100))
AS
BEGIN

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
  SELECT @Instruccion = 'GRANT SELECT ON ' + name + ' TO ' + @Usuario FROM sysobjects WHERE type <> 'S' AND type = 'U' --and category = 0
  SET ROWCOUNT 0
  SELECT @Cont = @Cont + 1  
  EXECUTE(@Instruccion)
 END
 
 SET NOCOUNT OFF
END

GO
