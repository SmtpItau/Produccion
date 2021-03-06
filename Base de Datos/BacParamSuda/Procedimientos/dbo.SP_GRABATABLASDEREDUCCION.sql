USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABATABLASDEREDUCCION]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABATABLASDEREDUCCION]
	(	@nPuntero	INTEGER
	,	@Segmento	INTEGER
	,	@Internacional	INTEGER
	,	@Nacional	INTEGER
	,	@Porcentaje	NUMERIC(5)
	,	@Monto		NUMERIC(13)
	)
AS
BEGIN

	SET NOCOUNT ON

	IF @nPuntero = 1
	BEGIN
		DELETE FROM Bacparamsuda.dbo.TBL_TABLAS_DE_REDUCCION
			WHERE Segmento = @Segmento
	END

	INSERT INTO Bacparamsuda.dbo.TBL_TABLAS_DE_REDUCCION
	(	Segmento
	, 	Internacional
	, 	Nacional
	, 	Porcentaje
	, 	Monto
	)
	VALUES
	(	@Segmento
	,	@Internacional
	,	@Nacional
	,	@Porcentaje
	,	@Monto
	)

END
GO
