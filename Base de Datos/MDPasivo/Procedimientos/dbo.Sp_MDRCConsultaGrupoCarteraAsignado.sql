USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDRCConsultaGrupoCarteraAsignado]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_MDRCConsultaGrupoCarteraAsignado]
       (
        @Codigo_Grupo  CHAR(5)        	
       )
AS
BEGIN
SET NOCOUNT ON 
SET DATEFORMAT dmy
	SELECT Codigo_Grupo_Cartera
	FROM TIPO_CARTERA 
	WHERE Codigo_Grupo_Cartera = @Codigo_Grupo
SET NOCOUNT OFF
END

GO
