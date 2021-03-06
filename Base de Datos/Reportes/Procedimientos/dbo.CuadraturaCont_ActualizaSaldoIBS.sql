USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_ActualizaSaldoIBS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaCont_ActualizaSaldoIBS](@codIBS INT, @saldoIBS FLOAT, @moneda VARCHAR(10)) 
AS
DECLARE @fechaProcesoAnt DATETIME

SELECT @fechaProcesoAnt = acfecante FROM Bacfwdsuda..mfac

IF(SELECT saldoIBS FROM CuadraturaContableDerivados WHERE codIBS = @codIBS AND fechaCuadratura = @fechaProcesoAnt AND Moneda = @moneda) = 0

BEGIN
	UPDATE  CuadraturaContableDerivados
	SET saldoIBS = @saldoIBS
	   ,flacActualiza = 1
	WHERE codIBS = @codIBS 
		  AND Moneda = @moneda

END

GO
