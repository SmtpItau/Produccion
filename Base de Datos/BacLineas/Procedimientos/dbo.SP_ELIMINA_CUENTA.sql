USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_CUENTA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINA_CUENTA    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINA_CUENTA    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ELIMINA_CUENTA]( @Cuenta  CHAR(12) ) WITH RECOMPILE
AS 
BEGIN
     ----<< Valida envio de Cuenta
     IF DATALENGTH(RTRIM(@Cuenta)) = 0
     BEGIN
          SELECT -1,'No se recibio Cuenta Contable para ser Eliminada'
          RETURN
     END
     ----<< Valida existencia de Cuenta
     IF NOT EXISTS (SELECT 1 FROM PLAN_DE_CUENTA WHERE cuenta = @Cuenta)
     BEGIN
          SELECT -1,'No Existe Cuenta ' + @Cuenta + ' en Plan de Cuentas'
          RETURN
     END
    
     ----<< Valida existencia de Cuenta en pTrfiles fisicos
     IF EXISTS (SELECT 1 FROM PERFIL_DETALLE_CNT WHERE codigo_cuenta = @Cuenta)
     BEGIN
          SELECT -1,'Cuenta ' + @Cuenta + ' esta registrada en PTrfiles Contables (Ffsicos)'
          RETURN
     END
    
     ----<< Valida existencia de Cuenta en pTrfiles l=gicos
     IF EXISTS (SELECT * FROM PERFIL_VARIABLE_CNT WHERE codigo_cuenta = @Cuenta)
     BEGIN
          SELECT -1,'Cuenta ' + @Cuenta + ' esta registrada en PTrfiles Contables (L=gicos)'
          RETURN
     END
    
     ----<< Eliminando
     DELETE FROM PLAN_DE_CUENTA WHERE cuenta = @Cuenta
     IF @@ERROR <> 0
     BEGIN
          SELECT @@ERROR,'Cuenta ' + @Cuenta + ' NO pudo ser Eliminanda'
          RETURN
     END
END
GO
