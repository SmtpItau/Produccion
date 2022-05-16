USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMDER_Actualiza_CheckAnulacion_Simulador]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_COMDER_Actualiza_CheckAnulacion_Simulador](@numOperacion INT, @Operador VARCHAR(20), @Anulacion BIT)
AS
BEGIN
 DECLARE @fechaProceso  DATETIME
 SELECT @fechaProceso = acfecproc FROM Bacfwdsuda.dbo.mfac  WITH (NOLOCK)

	--SELECT * FROM COMDER_Simulador_Lineas 
	UPDATE COMDER_Simulador_Lineas
	SET Anular = @Anulacion
	WHERE NumeroOperacion = @numOperacion
	  AND UsuarioLog = @Operador  
	  AND FechaProceso = @fechaProceso

END 

GO
