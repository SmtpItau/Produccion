USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAGTIASOTORGADAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRAGTIASOTORGADAS]
	(	@iFolio NUMERIC(10)
	,	@Numdocu	NUMERIC(9)
	,	@Correlativo	NUMERIC(5)
	,	@Nemotecnico	VARCHAR(12)
	)
AS
BEGIN
	SET NOCOUNT ON

	IF @iFolio > 0
	BEGIN
		DELETE FROM Bacparamsuda..tbl_Garantias_Otorgadas_Detalle
		WHERE Folio = @iFolio
		AND Numdocu = @Numdocu
		AND Correlativo = @Correlativo
		AND Nemotecnico = @Nemotecnico
		SELECT 'OK'
	END
	ELSE
		SELECT 'NO'

	SET NOCOUNT OFF
END
GO
