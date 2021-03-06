USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERFAMILIASTASAREF]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERFAMILIASTASAREF]
AS
BEGIN
   SET NOCOUNT ON
   
	SELECT	incodigo
	,	inserie
	,	inglosa 
        ,       InUnidadTiempoTasaRef 
        ,       InEstrucPlazoTasaRef 
        INTO #Temporal
	FROM	BacParamSuda.dbo.INSTRUMENTO where incodigo <> 20
        ORDER BY inserie

        insert into #Temporal select 20, 'LH-A', 'LETRAS HIP. CLASF. A', 'DIA', 'PT'
        insert into #Temporal select 20, 'LH-AA', 'LETRAS HIP. CLASF. AA' , 'DIA', 'PT'

        SELECT * FROM #TEMPORAL
   
   SET NOCOUNT OFF
END

GO
