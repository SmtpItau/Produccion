USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Cambio_Clave]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Graba_Cambio_Clave]
   (   @Usuario       CHAR(15)
   ,   @ClaveAnterior  CHAR(15)
   ,   @NuevaClave    CHAR(15)
   ,   @ConfirmaClave  CHAR(15)
   ,   @dFechaExpira  DATETIME
   ,   @Fecha_Proceso  DATETIME
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
   DECLARE @largo_clave     INTEGER

   SELECT @Clave           = clave
      ,   @Fecha_Expira    = fecha_expira
      ,   @Clave_Anterior1 = clave_anterior1
      ,   @Clave_Anterior2 = clave_anterior2
      ,   @Clave_Anterior3 = clave_anterior3
      ,   @Clave_Anterior4 = clave_anterior4
      ,   @Clave_Anterior5 = clave_anterior5
      ,   @Dias_Expiracion = Dias_Expiracion
      ,   @largo_clave	   = Largo_Clave
     FROM LNKBAC.BacParamSuda.dbo.USUARIO
      WHERE usuario = @Usuario

   If @NuevaClave = '' Or @ConfirmaClave = '' 
   BEGIN
	SELECT -1, 'Debe Ingresar Clave Nueva y Confirmación de Clave Nueva.'
	RETURN -1
   END 

   If @NuevaClave <> @ConfirmaClave  
   BEGIN
	SELECT -1, 'La Clave Nueva y la Clave Confirmación deben ser Iguales.'
	RETURN -1
   END 

   If @ClaveAnterior = @NuevaClave  
   BEGIN
	SELECT -1, 'Esta clave ya fue usada con anterioridad.'
	RETURN -1
   END 

   If len(ltrim(rtrim(@NuevaClave))) < @largo_clave  
   BEGIN
	SELECT -1, 'El largo minimo de la clave, debe ser igual a ' + cast(@largo_clave as varchar)
	RETURN -1
   END 

   IF (@NuevaClave = @Clave 	     OR @NuevaClave = @Clave_Anterior1 OR @NuevaClave = @Clave_Anterior2 
   OR  @NuevaClave = @Clave_Anterior3 OR @NuevaClave = @Clave_Anterior4 OR @NuevaClave = @Clave_Anterior5) 
   BEGIN
	SELECT -1, 'Clave ha sido usada anteriormente'
	RETURN -1
   END 

   UPDATE LNKBAC.BacParamSuda.dbo.USUARIO
      SET clave           = @NuevaClave
      ,   Fecha_Expira    = @dFechaExpira --> DATEADD(DAY,@Dias_Expiracion,@Fecha_Proceso)
      ,   Clave_Anterior1 = clave
      ,   Clave_Anterior2 = @clave_anterior1
      ,   Clave_Anterior3 = @clave_anterior2
      ,   Clave_Anterior4 = @clave_anterior3
      ,   Clave_Anterior5 = @clave_anterior4
      ,   Reset_Psw       = '0'
      ,   bloqueado       = 0
      ,   Dias_Expiracion = DATEDIFF(DAY, @Fecha_Proceso, @dFechaExpira)
      WHERE usuario = @Usuario

   SELECT 'OK'

END
GO
