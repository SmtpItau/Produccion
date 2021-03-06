USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerTablaInstrumento]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[Wizard_ObtenerTablaInstrumento]    Script Date: 27-11-2013 18:15:02 ******/

-- ==================================================================
-- Author		: Marcela Encina        
-- Create date  : 18-06-2013    
-- Description  : Obtiene los nombres de las tablas por sistema   
-- ==================================================================
CREATE PROCEDURE [dbo].[Wizard_ObtenerTablaInstrumento]   
	@Sistema		AS VARCHAR(10)	= ''
,	@TipoMovCartera AS INT			= 0
,	@Estructura		AS VARCHAR(2)	= ''
AS        
BEGIN        
    
	SET NOCOUNT ON;  
	
	IF @Sistema = 'OPT'
	BEGIN	
		SELECT	DISTINCT
				t.NombreTabla
		,		t.BASEDATO
		,		c2.ESTRUCTURA
		FROM	CAMPODESC c2
		INNER JOIN Campo		 c ON c.IDCAMPODESC = c2.IDCAMPODESC 
		INNER JOIN Tablas_Wizard t ON t.IdTabla		= c.IdTabla 
		INNER JOIN Instrumento	 i ON i.IdInstrumento = t.IdInstrumento 
		WHERE	(i.SISTEMA		= @Sistema			OR	@Sistema		= '')
		AND		(t.IdCmov		= @TipoMovCartera	OR	@TipoMovCartera	= 0)
		AND		(c2.ESTRUCTURA	= @Estructura		OR	@Estructura		= '')
	END
	ELSE
	BEGIN
		SELECT	DISTINCT
				t.NombreTabla
		,		t.BASEDATO		
		FROM	CAMPODESC c2
		INNER JOIN Campo		 c ON c.IDCAMPODESC = c2.IDCAMPODESC 
		INNER JOIN Tablas_Wizard t ON t.IdTabla		= c.IdTabla 
		INNER JOIN Instrumento	 i ON i.IdInstrumento = t.IdInstrumento 
		WHERE	(i.SISTEMA		= @Sistema			OR	@Sistema		= '')
		AND		(t.IdCmov		= @TipoMovCartera	OR	@TipoMovCartera	= 0)		
	END
END

GO
