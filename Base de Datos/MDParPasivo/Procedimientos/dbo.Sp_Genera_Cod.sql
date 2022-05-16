USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Genera_Cod]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Genera_Cod]
		
	
AS
BEGIN 
        SET DATEFORMAT DMY 

	SET NOCOUNT ON

	SELECT MAX(mncodcor)
	FROM MONEDA
        WHERE   ESTADO<>'A'

END


GO
