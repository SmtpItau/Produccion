USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CASILLA_TRANSMISION]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CON_CASILLA_TRANSMISION]
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

    SELECT   Nombre_host                    
            ,Direccion_host                 
            ,Usuario_host         
            ,Clave_host           
            ,Path_inical_host    
    FROM CASILLA_TRANSMISION

END

GO
