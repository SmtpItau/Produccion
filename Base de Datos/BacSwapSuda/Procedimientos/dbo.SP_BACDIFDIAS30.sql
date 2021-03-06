USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACDIFDIAS30]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BACDIFDIAS30]( 
	                                @fecInicial DATETIME,   
					@fecFinal 	DATETIME,
					@diferencia	INTEGER = 0.0 OUTPUT
				)
AS 
BEGIN

	SET NOCOUNT ON

	DECLARE @meses 		INTEGER		,
		@fechacal	DATETIME	,
		@difdias	INTEGER

	SELECT @meses 	 	= DATEDIFF(mm,@fecinicial,@fecfinal)
	SELECT @fechacal 	= DATEADD(mm,@meses,@fecinicial)
	SELECT @difdias 	= DATEDIFF(dd,@fechacal,@fecfinal)
	SELECT @diferencia 	= ( @meses * 30 ) + @difdias

	SET NOCOUNT OFF

END
GO
