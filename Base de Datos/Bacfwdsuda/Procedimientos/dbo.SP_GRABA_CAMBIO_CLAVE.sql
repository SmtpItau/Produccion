USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CAMBIO_CLAVE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_GRABA_CAMBIO_CLAVE]
            (   
                @Usuario       CHAR(15),
                @NuevaClave    CHAR(15),  
		@dFechaExpira  DATETIME
            )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @Clave           CHAR(15)
   DECLARE @Fecha_Expira    DATETIME
   DECLARE @Clave_Anterior1 CHAR(15)
   DECLARE @Clave_Anterior2 CHAR(15)
   DECLARE @Clave_Anterior3 CHAR(15)
   DECLARE @Clave_Anterior4 CHAR(15)
   DECLARE @Clave_Anterior5 CHAR(15)
   DECLARE @Dias_Expiracion NUMERIC(5)
   DECLARE @Fecha_Proceso   DATETIME

   SELECT @Fecha_Proceso   = ( select acfecproc from BacFwdSuda.dbo.MFAC )
   SELECT @Clave           = clave
      ,   @Fecha_Expira    = fecha_expira
      ,   @Clave_Anterior1 = clave_anterior1
      ,   @Clave_Anterior2 = clave_anterior2
      ,   @Clave_Anterior3 = clave_anterior3
      ,   @Clave_Anterior4 = clave_anterior4
      ,   @Clave_Anterior5 = clave_anterior5
      ,   @Dias_Expiracion = Dias_Expiracion
     FROM BACPARAMSUDA..USUARIO
    WHERE usuario = @Usuario

   IF (@NuevaClave = @Clave 	     OR @NuevaClave = @Clave_Anterior1 OR @NuevaClave = @Clave_Anterior2 
   OR  @NuevaClave = @Clave_Anterior3 OR @NuevaClave = @Clave_Anterior4 OR @NuevaClave = @Clave_Anterior5) 
   BEGIN
	SELECT -1, 'Clave ha sido usada anteriormente'
	RETURN -1
   END 

   UPDATE BACPARAMSUDA..USUARIO 
      SET clave           = @NuevaClave
      ,   Fecha_Expira    = @dFechaExpira --> DATEADD(DAY,@Dias_Expiracion,@Fecha_Proceso)
      ,   Clave_Anterior1 = clave
      ,   Clave_Anterior2 = @clave_anterior1
      ,   Clave_Anterior3 = @clave_anterior2
      ,   Clave_Anterior4 = @clave_anterior3
      ,   Clave_Anterior5 = @clave_anterior4
         ,   Reset_Psw       = '0'
  ,   bloqueado       = 0
    WHERE usuario = @Usuario

   SELECT 'OK'
   SET NOCOUNT OFF
END

GO
