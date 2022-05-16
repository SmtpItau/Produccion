USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Familia_Ins]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Familia_Ins]
		(@EMRUT NUMERIC(10))
	
AS BEGIN 
SET DATEFORMAT dmy
SET NOCOUNT OFF
	SELECT emgeneric,emcodigo
	FROM EMISOR
	WHERE emrut =@EMRUT
SET NOCOUNT ON
END

GO
