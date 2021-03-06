USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ValoresPassword]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ValoresPassword]
         (   @Usuario CHAR(15)
         )
AS
BEGIN

SET DATEFORMAT dmy
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
   FROM USUARIO
   WHERE usuario = @usuario

END


GO
