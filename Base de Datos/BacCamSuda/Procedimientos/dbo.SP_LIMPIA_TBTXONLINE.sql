USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_TBTXONLINE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LIMPIA_TBTXONLINE]
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO TbTxOnlineHistorico
	SELECT	*
	FROM	tbtxonline

	DELETE tbtxonline

	SET NOCOUNT OFF

END





GO
