USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHAHABIL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FECHAHABIL]
			(
			@dFecha	DATETIME	,
			@nPais	NUMERIC(05)	,
			@nPlaza	NUMERIC(05)	,
			@lFlag	INTEGER OUTPUT
			)
AS BEGIN
SET NOCOUNT ON
   
	IF NOT EXISTS(SELECT feano FROM VIEW_FERIADO 
					WHERE	feplaza	= @nPlaza  AND
						feano	= YEAR(@dFecha) ) BEGIN
		SELECT @lFlag = 0
	END ELSE BEGIN
		SELECT @lFlag = 1
	END

	IF ((DATEPART(dw, @dFecha) = 6) OR (DATEPART(dw, @dFecha) = 7)) BEGIN
		SELECT @lFlag = 1
	END
SET NOCOUNT OFF
END
--Sp_FechaHabil '20030130'

GO
