USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_INTRA_OVER]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TRAE_INTRA_OVER]
AS 
BEGIN
	SET NOCOUNT ON
 
		SELECT  ISNULL(acminintraday,0)  ,
			ISNULL(acmaxintraday,0)  ,
			ISNULL(acminovernight,0) ,
			ISNULL(acmaxovernight,0)
		FROM  	view_meac

	SET NOCOUNT OFF

END
GO
