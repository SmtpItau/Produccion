USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESET_TABLAS_SIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RESET_TABLAS_SIM]  
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @cuantos1 NUMERIC(9),
		@cuantos2 NUMERIC(9),
		@cuantos3 NUMERIC(9)

	SELECT 	@cuantos1 = COUNT(*) FROM Cartera_Sim
	SELECT	@cuantos2 = COUNT(*) FROM MovDiario_Sim
	SELECT	@Cuantos3 = COUNT(*) FROM CarteraLog_Sim

	IF @cuantos1 > 0
		DELETE Cartera_Sim
	IF @cuantos2 > 0
		DELETE MovDiario_Sim
	IF @cuantos3 > 0
		DELETE CarteraLog_Sim

	UPDATE SwapGeneral_Sim
	SET numero_operacion = 0

	SET NOCOUNT OFF
END
GO
