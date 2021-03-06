USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAL_DUR_CONVEX]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CAL_DUR_CONVEX] 	(@FechaProceso 	DATETIME
				 	,@TIR		FLOAT
				 	,@Serie		VARCHAR(10)
					,@Dur		FLOAT OUTPUT
					,@DurMod    FLOAT OUTPUT
					,@Convex	FLOAT OUTPUT)
AS
SET NOCOUNT ON

BEGIN
SELECT 
tdmascara	AS Serie
,tdcupon	AS N_Cupon
,tdfecven	AS FVcto
,12/sepervcup	AS Periocidad
,tdflujo	AS Flujo
,CONVERT(NUMERIC,DATEDIFF(d,@FechaProceso,tdfecven))/365 	  AS Remanente
,tdflujo/POWER(1+@TIR/100,CONVERT(NUMERIC,DATEDIFF(d,@FechaProceso,tdfecven))/365) AS VP_Flujo
,(CONVERT(NUMERIC,DATEDIFF(d,@FechaProceso,tdfecven))/365) * (tdflujo/POWER(1+@TIR/100,CONVERT(NUMERIC,DATEDIFF(d,@FechaProceso,tdfecven))/365)) AS 'VP_Flujo*Remanente'
,(CONVERT(NUMERIC,DATEDIFF(d,@FechaProceso,tdfecven))/365) * (tdflujo/POWER(1+@TIR/100,CONVERT(NUMERIC,DATEDIFF(d,@FechaProceso,tdfecven))/365)) * (CONVERT(NUMERIC,DATEDIFF(d,@FechaProceso,tdfecven))/365 + 1) / (POWER(1+@TIR/100,2)) AS Conv_Flujo
INTO #Dur_Convex
FROM bacparamsuda..tabla_desarrollo INNER JOIN bacparamsuda..serie ON tdmascara = semascara
WHERE tdmascara = @Serie
	AND tdfecven > @FechaProceso
------CONSULTA DE RESULTADO------
SELECT 
@Dur 		= SUM(VP_Flujo*Remanente)/SUM(VP_Flujo) 		
,@DurMod 	=(SUM(VP_Flujo*Remanente)/SUM(VP_Flujo))/(1+(@TIR/100)/Periocidad)
,@Convex 	=(SUM(Conv_Flujo)/SUM(VP_Flujo)) 	
FROM #Dur_Convex
GROUP BY Serie, Periocidad
END





GO
