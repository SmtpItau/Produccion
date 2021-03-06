USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Rescata_Datos_Usuario]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Rescata_Datos_Usuario]
       (
         @Usuario     VARCHAR(15)
       )
AS
BEGIN

    SET NOCOUNT ON

    SELECT CLAVE, USUARIO
         , TIPO_USUARIO
         , 'FECHA_EXPIRACION' = CONVERT( CHAR(10), FECHA_EXPIRA, 103 )
         , bloqueado
         , cambio_clave
         , clave_anterior1
         , clave_anterior2
         , clave_anterior3
         -- DMV: 11/11/2009: Se implementa esta solución temporal hasta que los campos sean creado en el servidor de certificación
         , 'clave_anterior4' = Clave_Anterior4
         , 'clave_anterior5' = Clave_Anterior5
         , reset_psw
         , Largo_Clave
         , Tipo_Clave
         , Dias_Expiracion 
      FROM LNKBAC.bacparamsuda.dbo.USUARIO 
     WHERE @Usuario IN ( USUARIO, '' )
END
GO
