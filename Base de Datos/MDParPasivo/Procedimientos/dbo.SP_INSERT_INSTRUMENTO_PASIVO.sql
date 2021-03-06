USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_INSTRUMENTO_PASIVO]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_INSTRUMENTO_PASIVO]
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

DELETE INSTRUMENTO_PASIVO
 
INSERT INTO INSTRUMENTO_PASIVO 
			( codigo_instrumento,
			  nombre_instrumento,
			  codigo_producto,
			  glosa,
			  codigo_contable
			)
			SELECT 
			   INCODIGO,
			   INGLOSA,
			   CASE WHEN INTIPO = 'LC' THEN 'CORFO' 
				WHEN INTIPO = 'LB' THEN 'LOCAL'
				WHEN INTIPO = 'RF' THEN 'BONOS'
			   END,
			   ININST,
			   ININST
			
			FROM 	DESARROLLO.MDIN 
			  
END

GO
