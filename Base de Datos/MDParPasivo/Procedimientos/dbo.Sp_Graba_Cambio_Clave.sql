USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Cambio_Clave]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROC [dbo].[Sp_Graba_Cambio_Clave]
            (   @Usuario       CHAR(15)
            ,   @NuevaClave    CHAR(15)  
            )
AS
BEGIN


   SET NOCOUNT ON
   SET DATEFORMAT dmy

   DECLARE @Clave           CHAR(15)
   DECLARE @Fecha_Expira    DATETIME
   DECLARE @Clave_Anterior2 CHAR(15)
   DECLARE @Clave_Anterior3 CHAR(15)
   DECLARE @Dias_Expiracion NUMERIC(5)

   DECLARE @Fecha_Proceso   DATETIME

   SELECT @Fecha_Proceso   = Fecha_Proceso FROM DATOS_GENERALES

   SELECT @Clave           = clave
      ,   @Fecha_Expira    = fecha_expira
      ,   @Clave_Anterior2 = clave_anterior2
      ,   @Clave_Anterior3 = clave_anterior3
      ,   @Dias_Expiracion = Dias_Expiracion
      FROM USUARIO
      WHERE usuario = @Usuario

   UPDATE USUARIO SET 
             clave           = @NuevaClave
         ,   Fecha_Expira    = DATEADD(DAY,@Dias_Expiracion,@Fecha_Proceso)
         ,   Clave_Anterior1 = @clave_anterior2
         ,   Clave_Anterior2 = @clave_anterior3
         ,   Clave_Anterior3 = @clave
      WHERE usuario = @Usuario

   SET NOCOUNT OFF

   SELECT 'OK'

END




GO
