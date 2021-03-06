USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[tblMitigacion_Save]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[tblMitigacion_Save] ( @codFamilia	CHAR(06),
										  @iPlazoIni	INT		,
										  @iPlazoFin	INT		,
										  @fPorcentaje	FLOAT	
										)  
AS
BEGIN
	
	INSERT INTO dbo.tblMitigacion(
		codFamilia		,
		iPlazoIni		,
		iPlazoFin		,	
		fPorcentaje		)
	VALUES(
		@codFamilia		,
		@iPlazoIni		,
		@iPlazoFin		,
		@fPorcentaje	);
	
END 
-- Base de Datos --
GO
