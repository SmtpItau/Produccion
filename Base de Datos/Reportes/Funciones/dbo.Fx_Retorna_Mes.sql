USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Retorna_Mes]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_Retorna_Mes]
	(	@dFecha		DATETIME	
	)	RETURNS		VARCHAR(30)
AS
BEGIN

	DECLARE @cRetorno	VARCHAR(30)
		SET	@cRetorno	=	(	SELECT	CONVERT(CHAR(2), @dFecha , 103) + ' de '
							+	case	when datepart(month, @dFecha ) = 1	THEN 'Enero'
										when datepart(month, @dFecha ) = 2	THEN 'Febrero'
										when datepart(month, @dFecha ) = 3	THEN 'Marzo'
										when datepart(month, @dFecha ) = 4	THEN 'Abril'
										when datepart(month, @dFecha ) = 5	THEN 'Mayo'
										when datepart(month, @dFecha ) = 6	THEN 'Junio'
										when datepart(month, @dFecha ) = 7	THEN 'Julio'
										when datepart(month, @dFecha ) = 8	THEN 'Agosto'
										when datepart(month, @dFecha ) = 9	THEN 'Septiembre'
										when datepart(month, @dFecha ) = 10 THEN 'Octubre'
										when datepart(month, @dFecha ) = 11 THEN 'Noviembre'
										when datepart(month, @dFecha ) = 12 THEN 'Diciembre'
									end + ' de '
							+ ltrim(rtrim(datepart(year, @dFecha ))))

	RETURN @cRetorno

END

GO
