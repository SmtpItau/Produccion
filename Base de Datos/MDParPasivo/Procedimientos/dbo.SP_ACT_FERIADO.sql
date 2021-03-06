USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_FERIADO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_FERIADO]
			(
			@nPais		NUMERIC(05)	,
			@nPlaza		NUMERIC(05)	,
			@dFecha		DATETIME	,
			@feriado	CHAR(01)
			)
AS BEGIN 

   SET NOCOUNT ON
   SET DATEFORMAT dmy

		IF EXISTS(SELECT fecha 	FROM FERIADO	WHERE	plaza	= @nPlaza	AND
								Pais	= @nPais	AND
								fecha	= @dFecha) BEGIN
			IF @feriado = 'N' BEGIN
				DELETE FERIADO
				WHERE	plaza	= @nPlaza	AND
					Pais	= @nPais	AND
					fecha	= @dFecha

			END
		END ELSE BEGIN
			IF @feriado = 'S' BEGIN
				INSERT INTO FERIADO
				SELECT  @nPais	,
					@nPlaza	,
				        @dFecha
			END

		END

SET NOCOUNT OFF

END

GO
