USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Grupos_Carteras]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Carga_Grupos_Carteras]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

	SELECT  Codigo_Grupo_Cartera,
		Descripcion 
        FROM  TIPO_GRUPO_CARTERA
END
GO
