USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_INGRESO_USUARIO]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_VALIDA_INGRESO_USUARIO]
   (   @Usuario	CHAR(15)	
   ,   @Clave  	CHAR(15)	=''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @lc_bloqueado  CHAR(1)
   ,       @lc_clave      CHAR(15)
   ,       @lc_fec_expira CHAR(10)

   IF EXISTS(SELECT 1 FROM BacParamSuda.dbo.USUARIO WHERE usuario = @Usuario)
   BEGIN
      SELECT @lc_bloqueado  = bloqueado
         ,   @lc_clave      = clave
         ,   @lc_fec_expira = convert(char(10),Fecha_Expira,103)
      FROM   BacParamSuda.dbo.USUARIO 
      WHERE  Usuario        = @Usuario
		
      IF @lc_bloqueado = '1'
      BEGIN
         SELECT -1, 'No pudo entrar al sistema: usuario bloqueado'
         RETURN -1
      END 
      IF @lc_clave <> @Clave
      BEGIN
         SELECT -1, 'Clave Invalida.'
         RETURN -1
      END 
   END ELSE
   BEGIN
      SELECT -1, 'Â¡ Usuario no se encuentra definido. !'
      RETURN -1
   END

   SELECT clave
      ,   tipo_usuario
      ,   CONVERT(CHAR(10), fecha_expira, 103)
      ,   cambio_clave
      ,   dias_expiracion
      ,   largo_clave
      ,   tipo_clave
   FROM   BacParamSuda.dbo.USUARIO with(nolock)
   WHERE  Usuario = @Usuario

END



GO
