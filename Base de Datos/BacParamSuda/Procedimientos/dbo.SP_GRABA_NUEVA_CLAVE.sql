USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_NUEVA_CLAVE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_NUEVA_CLAVE]
            (   @Usuario       CHAR(15)
            ,   @NuevaClave    CHAR(15)  
            )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @Clave           CHAR(15)
   DECLARE @Fecha_Expira    DATETIME
   DECLARE @Clave_Anterior2 CHAR(15)
   DECLARE @Clave_Anterior3 CHAR(15)
   DECLARE @Dias_Expiracion NUMERIC(5)
   DECLARE @Reset_Psw     CHAR(1)
   DECLARE @Fecha_Proceso   DATETIME
   SELECT @Fecha_Proceso   = acfecproc FROM VIEW_MDAC
   SELECT @Clave           = clave,
          @Fecha_Expira    = fecha_expira,
          @Clave_Anterior2 = clave_anterior2,
          @Clave_Anterior3 = clave_anterior3,
          @Dias_Expiracion = Dias_Expiracion,
          @Reset_Psw    = Reset_Psw
      FROM USUARIO
      WHERE usuario = @Usuario
   UPDATE USUARIO SET 
             clave           = @NuevaClave
         ,   Fecha_Expira    = DATEADD(DAY,@Dias_Expiracion,@Fecha_Proceso)
         ,   Clave_Anterior1 = @clave_anterior2
         ,   Clave_Anterior2 = @clave_anterior3
         ,   Clave_Anterior3 = @clave
         ,   Reset_Psw      = '0'
      WHERE usuario = @Usuario
   SET NOCOUNT OFF
   SELECT 'OK'
END
--sp_helptext Sp_Graba_Nueva_Clave
--SELECT * FROM USUARIO
---  Sp_Graba_Nueva_Clave 'MMORENO','miriaml'
--- select * from VIEW_MDAC
-- update USUARIO set Tipo_Clave = "C", reset_psw = "1" WHERE USUARIO = "ADMINISTRA"
GO
