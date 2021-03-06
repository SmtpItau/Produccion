USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAL_DURATION]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CAL_DURATION]( @FechaProceso DATETIME
				 ,@TIR		FLOAT
				 ,@Serie	VARCHAR(10)
				 ,@Dur		FLOAT OUTPUT
				 ,@DurMod       FLOAT OUTPUT)
AS
BEGIN
SET NOCOUNT ON

SELECT 
tdmascara	AS Serie
,tdcupon	AS N_Cupon
,tdfecven	AS FVcto
,12/sepervcup	AS Periocidad
,tdflujo	AS Flujo
,CAST(DATEDIFF(d,@FechaProceso,tdfecven) AS NUMERIC)/365	  AS Remanente
,tdflujo/POWER(1+@TIR/100,CAST(DATEDIFF(d,@FechaProceso,tdfecven) AS NUMERIC)/365) AS VP_Flujo
,(CAST(DATEDIFF(d,@FechaProceso,tdfecven) AS NUMERIC)/365) * (tdflujo)/POWER( (1+@TIR/100),CAST(DATEDIFF(d,@FechaProceso,tdfecven) AS NUMERIC)/365) AS 'VP_Flujo*Remanente'
INTO #Duration
FROM bacparamsuda..tabla_desarrollo INNER JOIN bacparamsuda..serie ON tdmascara = semascara
WHERE tdmascara = @Serie
	AND tdfecven > @FechaProceso
------CONSULTA DE RESULTADO------
SELECT 
@Dur 		= SUM(VP_Flujo*Remanente)/SUM(VP_Flujo) 		
,@DurMod 	=(SUM(VP_Flujo*Remanente)/SUM(VP_Flujo))/(1+(@TIR/100)/Periocidad) 	
FROM #Duration
GROUP BY Serie, Periocidad

END


GO
