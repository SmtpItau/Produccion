USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerCamposOrigen]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerCamposOrigen]    Script Date: 27-11-2013 18:15:02 ******/

-- ==================================================================
-- Author		: Marcela Encina        
-- Create date  : 18-06-2013    
-- Description  : Obtiene los campos origen   
-- ==================================================================
CREATE PROCEDURE [dbo].[Wizard_ObtenerCamposOrigen]   
	@Sistemas	AS VARCHAR(10) = ''''
AS        
BEGIN        
    
	SET NOCOUNT ON;  
	
	SELECT	c.NombreCampo, c.NombreDescriptivo, t.NombreTabla, i.SISTEMA
	FROM	Campo c
	INNER JOIN Tabla		t ON t.IdTabla			= c.IdTabla
	INNER JOIN Instrumento	i ON i.IdInstrumento	= t.IdInstrumento
	WHERE	CHARINDEX(RTRIM(LTRIM(i.SISTEMA)),@Sistemas) > 0 OR @Sistemas = ''''
	--i.SISTEMA		= @Sistema	OR	@Sistema = ''''
	ORDER BY i.SISTEMA

END

GO
