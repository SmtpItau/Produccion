USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_EjecutaConsultaCarteras]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   

CREATE PROCEDURE [dbo].[CuadraturaContable_EjecutaConsultaCarteras]
AS
BEGIN

	EXEC [dbo].[CuadraturaContable_Forwards]

	EXEC [dbo].[CuadraturaContable_ForwardsAsiatico]

	EXEC [dbo].[CuadraturaContable_Swap]

	EXEC [dbo].[CuadraturaContable_Opciones]

	EXEC [dbo].[CuadraturaContable_RentaFija]

	EXEC [dbo].[CuadraturaContable_RentaFijaExt]

	EXEC [dbo].[CuadraturaContable_Pactos]

	EXEC [dbo].[CuadraturaContable_Pasivos]


END

GO
