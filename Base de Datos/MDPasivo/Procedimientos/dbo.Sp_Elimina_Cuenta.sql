USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Cuenta]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Elimina_Cuenta]( @Cuenta  CHAR(16) ) WITH RECOMPILE
AS BEGIN
SET NOCOUNT ON
     ----<< Valida envio de Cuenta
     IF DATALENGTH(RTRIM(@Cuenta)) = 0 BEGIN
          SELECT -1,'No se recibio Cuenta Contable para ser Eliminada'
          RETURN
     END
     ----<< Valida existencia de Cuenta
     IF NOT EXISTS (SELECT 1 FROM PLAN_DE_CUENTA WHERE cuenta = @Cuenta) BEGIN
          SELECT -1,'No Existe Cuenta ' + @Cuenta + ' en Plan de Cuentas'
          RETURN
     END
    
     ----<< Valida existencia de Cuenta en pTrfiles fisicos
     IF EXISTS (SELECT 1 FROM PERFIL_DETALLE_CNT WHERE codigo_cuenta = @Cuenta) BEGIN
          SELECT -1,'Cuenta ' + @Cuenta + ' esta registrada en PTrfiles Contables (Ffsicos)'
          RETURN
     END
    
     ----<< Valida existencia de Cuenta en pTrfiles l=gicos
     IF EXISTS (SELECT * FROM PERFIL_VARIABLE_CNT WHERE codigo_cuenta = @Cuenta) BEGIN
          SELECT -1,'Cuenta ' + @Cuenta + ' esta registrada en PTrfiles Contables (L=gicos)'
          RETURN
     END
    
     ----<< Eliminando
     DELETE PLAN_DE_CUENTA WHERE cuenta = @Cuenta
     IF @@ERROR <> 0    BEGIN
          SELECT @@ERROR,'Cuenta ' + @Cuenta + ' NO pudo ser Eliminanda'
          RETURN
     END
SET NOCOUNT OFF
END
GO
