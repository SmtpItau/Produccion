USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerTipoCampoDesc]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerTipoCampoDesc]    Script Date: 27-11-2013 18:15:02 ******/

-- ==========================================================================         
-- Author		: Marcela Encina            
-- Create date  : 01-06-2013        
-- Description  : Obtiene los campos coincidentes a los sistemas consultados       
-- ==========================================================================    

CREATE PROCEDURE [dbo].[Wizard_ObtenerTipoCampoDesc]       
	@IdCampo   AS INT = 0
   
AS            
BEGIN            
        
SET NOCOUNT ON;  
		
	SELECT	c.IDCAMPODESC
	,		c.NOMBRECAMPODESC
	,		c.ESTRUCTURA
	,		c.Dato
	FROM	CAMPODESC c
	WHERE	c.IDCAMPODESC = @IdCampo 
		 
END
GO
