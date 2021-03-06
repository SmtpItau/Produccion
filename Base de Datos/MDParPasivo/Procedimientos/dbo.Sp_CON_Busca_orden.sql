USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CON_Busca_orden]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Sp_CON_Busca_orden]
		( @ctipo CHAR(1))

AS

BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON


	SELECT * INTO #Temp FROM SWITCH_OPERATIVO
	DELETE #Temp WHERE (Codigo_Control = 'INICIO' AND  Sistema <> 'SCE')  OR (Codigo_Control = 'CONTABILIDAD' AND  Sistema <> 'SCE') OR (Codigo_Control = 'FIN' AND  Sistema <> 'SCE')

IF @cTipo = '1' 
   SELECT Codigo_control,Orden,Descripcion,reproceso,sistema FROM #Temp GROUP BY Codigo_control,Orden,Descripcion,reproceso,sistema ORDER BY Orden

IF @cTipo = '2' 
   SELECT Codigo_control,Orden_Especial,Descripcion,reproceso,sistema FROM #Temp GROUP BY Codigo_control,Orden_Especial,Descripcion,reproceso,sistema ORDER BY Orden_Especial


END   /* FIN PROCEDIMIENTO */


GO
