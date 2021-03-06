USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_Obtiene_SeriePasivos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaContable_Obtiene_SeriePasivos]
AS
BEGIN

    SELECT tipo_Bono AS id, nombre_serie AS nombre FROM MDPasivo.[dbo].[SERIE_PASIVO] with (nolock)
	UNION 
	SELECT nombre_serie , nombre_serie FROM MDPasivo.dbo.CARTERA_PASIVO_HISTORICA
	WHERE nombre_serie NOT IN(SELECT nombre_serie FROM MDPasivo.[dbo].[SERIE_PASIVO] with (nolock))
	GROUP BY nombre_serie
	UNION
	SELECT  'UCOR-*' , 'UCOR-*'  
	UNION
	SELECT  'BCOR-D*', 'BCOR-D*'
	UNION			
	SELECT  'BCOR-O*', 'BCOR-O*' 
	UNION
	SELECT  'BCOR-P*', 'BCOR-P*' 
	UNION
	SELECT  'BCOR-J*', 'BCOR-J*' 
	UNION
	SELECT  'BCOR-l*', 'BCOR-l*' 
	UNION
	SELECT  'BCOR-K*', 'BCOR-K*' 
	UNION
	SELECT  'BCOR-M*', 'BCOR-M*' 
	UNION
	SELECT  'BCORAI*', 'BCORAI*' 
	UNION
	SELECT  'BCORAD*', 'BCORAD*' 
	UNION
	SELECT  'BCORAE*', 'BCORAE*'
	UNION			
	SELECT  'BCORAF*', 'BCORAF*' 
	UNION
	SELECT  'BCORAG*', 'BCORAG*' 
	UNION
	SELECT  'UCORAA*', 'UCORAA*' 
	UNION
	SELECT  'UCORBI*', 'UCORBI*' 
	UNION
	SELECT  'UCORBN*', 'UCORBN*' 
	UNION
	SELECT  'UCORBJ*', 'UCORBJ*' 
	UNION
	SELECT  'UCORBL*', 'UCORBL*' 
	UNION
	SELECT  'UCORBF*', 'UCORBF*' 
	UNION
	SELECT  'UCORBP*', 'UCORBP*' 
END

GO
