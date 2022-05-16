USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABATASACOMPPARCIAL]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABATASACOMPPARCIAL]
		(	@numero		NUMERIC(10)	,
			@correlativo	NUMERIC(10)	,
			@tasa	FLOAT
		)
AS
BEGIN

	SET NOCOUNT ON

	UPDATE 	cortes 
	SET 	cortastab	= @tasa
	WHERE	cornumoper	= @numero	AND
		corcorrela	= @correlativo

	SET NOCOUNT OFF

END


-- select * from cortes



GO
