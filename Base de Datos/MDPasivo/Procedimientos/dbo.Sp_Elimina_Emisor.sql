USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Elimina_Emisor]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Elimina_Emisor]
                  (@nrut NUMERIC(9))
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM mdpasivo..SERIE_PASIVO WHERE rut_emisor = @nrut) 
	BEGIN
	   SELECT 'NN'
	   RETURN
        END

	DELETE EMISOR WHERE emrut = @nrut
        SET NOCOUNT OFF
	IF @@ERROR<> 0 	SELECT 'NO'
	ELSE 		SELECT 'SI'
END

GO
