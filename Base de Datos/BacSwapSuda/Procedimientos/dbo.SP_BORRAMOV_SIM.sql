USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAMOV_SIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRAMOV_SIM]  
	(	@Operacion NUMERIC(9)
	)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT Numero_Operacion FROM CARTERA_SIM WHERE Numero_Operacion = @Operacion)
		DELETE CARTERA_SIM WHERE Numero_Operacion = @Operacion

	IF EXISTS(SELECT Numero_Operacion FROM MovDiario_Sim  WHERE Numero_Operacion = @Operacion)
		DELETE MovDiario_Sim WHERE Numero_Operacion = @Operacion

	IF EXISTS(SELECT Numero_Operacion FROM CarteraLog_Sim  WHERE Numero_Operacion = @Operacion)	
		DELETE CarteraLog_Sim  WHERE Numero_Operacion = @Operacion

	SET NOCOUNT OFF
END
GO
