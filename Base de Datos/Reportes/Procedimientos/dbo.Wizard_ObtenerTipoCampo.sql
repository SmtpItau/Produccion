USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerTipoCampo]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerTipoCampo]    Script Date: 27-11-2013 18:15:02 ******/

-- ===================================================  
-- Author		: Marcela Encina          
-- Create date  : 14-06-2013      
-- Description  : Obtiene los tipos de los campos   
-- ===================================================  

CREATE PROCEDURE [dbo].[Wizard_ObtenerTipoCampo]     
	@Campo			AS INT = 0,--VARCHAR(50) = '''',   
	@Fwd			AS VARCHAR(10) = '''',    
	@Swap			AS VARCHAR(10) = '''',    
	@Spot			AS VARCHAR(10) = '''',    
	@RentaFija		AS VARCHAR(10) = '''',     
	@InvExterior	AS VARCHAR(10) = '''',    
	@Opciones		AS VARCHAR(10) = '''',
	@MovCartera		AS INT		   = 0 
    
AS          
BEGIN          
      
	SET NOCOUNT ON;
	
	SELECT	DISTINCT 
			c2.IDCAMPODESC
	,		c2.NOMBRECAMPODESC
	,		c2.Dato
	,		c.NombreCampo	
	,		c.Id	
	,		t.NombreTabla
	,		t.BASEDATO
	,		i.SISTEMA
	,		t.IdTabla    
	,		c2.Estructura
	FROM	CAMPODESC			c2
	INNER JOIN  Campo			c ON	c.IDCAMPODESC	= c2.IDCAMPODESC
	INNER JOIN  Tablas_Wizard	t ON	t.IdTabla		= c.IdTabla    
	INNER JOIN	Instrumento		i ON	t.IdInstrumento = i.IdInstrumento	
	WHERE	c2.IDCAMPODESC = @Campo--c2.NOMBRECAMPODESC	= @Campo
	AND		t.IdCMov			= @MovCartera
	AND		(i.SISTEMA			= @Fwd    
	OR		i.SISTEMA			= @Swap    
	OR		i.SISTEMA			= @Spot    
	OR		i.SISTEMA			= @RentaFija    
	OR		i.SISTEMA			= @InvExterior    
	OR		i.SISTEMA			= @Opciones		
			)

END
GO
