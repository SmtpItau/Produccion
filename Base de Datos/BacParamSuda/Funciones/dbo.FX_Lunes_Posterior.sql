USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FX_Lunes_Posterior]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FX_Lunes_Posterior](@Fecha DATETIME)

RETURNS DATETIME
AS
BEGIN
	declare @Feriado datetime
	
	Set @Feriado = DATEADD( dd, 1, @Fecha )
	while DATEPART( weekDay, @Feriado ) <> 2 /* Lunes */
	    Set @Feriado = DATEADD( dd, 1, @Feriado )
	
	RETURN @FERIADO
	
END

GO
