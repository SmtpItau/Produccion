USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORESPASSWORD]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_VALORESPASSWORD]
         (   
            @Usuario CHAR(15)
         )
AS
BEGIN
   SET NOCOUNT ON
   SELECT clave          
      ,   fecha_expira              
      ,   cambio_clave 
      ,   bloqueado
      ,   clave_anterior1 
      ,   clave_anterior2 
      ,   clave_anterior3 
      ,   Largo_Clave 
      ,   Tipo_Clave 
      ,   Dias_Expiracion 
     FROM VIEW_USUARIO
    WHERE usuario = @usuario
   SET NOCOUNT OFF
END



GO
