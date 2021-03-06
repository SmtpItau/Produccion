USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_Usuarios]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CON_Usuarios]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    SELECT   usuario
            ,clave
            ,nombre
            ,tipo_usuario    
            ,fecha_expira
            ,cambio_clave 
            ,bloqueado 
            ,clase 
            ,clave_anterior1 
            ,clave_anterior2 
            ,clave_anterior3
            ,Largo_Clave
            ,Tipo_Clave
            ,Dias_Expiracion
            ,codigo_area
            ,rut_usuario
            ,dv_usuario
            ,mail_usuario
            ,activo 
    FROM USUARIO
    WHERE ACTIVO='S'

END

GO
