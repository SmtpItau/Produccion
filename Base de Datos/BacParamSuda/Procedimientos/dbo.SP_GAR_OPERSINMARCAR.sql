USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_OPERSINMARCAR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_OPERSINMARCAR]
	(	@Numdocu NUMERIC(9),
		@Correla NUMERIC(5)
	)
AS
BEGIN
	SET NOCOUNT ON
	IF EXISTS(SELECT 1 FROM BacTraderSuda..mdbl
			WHERE blnumdocu = @Numdocu
			AND blcorrela = @Correla)
		SELECT 'NO'
	ELSE
		SELECT 'SI'
	SET NOCOUNT OFF
END
GO
