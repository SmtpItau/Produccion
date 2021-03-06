USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORESPASSWORD]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORESPASSWORD]
         (   @Usuario CHAR(15)
         )
AS
BEGIN
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
END

GO
