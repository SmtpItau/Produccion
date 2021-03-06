USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHAHABIL]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FECHAHABIL]
		(
		@dFecha	DATETIME	,
		@nPais	NUMERIC(05)	,
		@lFlag	INTEGER OUTPUT
		)
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

   	SET DATEFIRST 1
	IF NOT EXISTS(SELECT fecha FROM FERIADO 
					WHERE	plaza	= 22		AND
						pais 	= @nPais	AND
						fecha	= @dFecha) BEGIN
		SELECT @lFlag = 0
	END ELSE BEGIN
		SELECT @lFlag = -1
	END

	IF ((DATEPART(dw, @dFecha) = 6) OR (DATEPART(dw, @dFecha) = 7)) BEGIN
		SELECT @lFlag = -1
	END

SET NOCOUNT OFF
END
GO
