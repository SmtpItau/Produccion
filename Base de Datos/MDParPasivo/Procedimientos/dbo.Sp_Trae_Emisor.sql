USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Emisor]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Trae_Emisor](@xRut         NUMERIC(9))
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF EXISTS(SELECT * FROM EMISOR WHERE emrut = @xRut AND estado = 'A')
   BEGIN
	SELECT 'EXISTE', 'Emisor ya Fue Utilizado'
	RETURN
   END	
   	
 
 	SELECT emcodigo,
		emrut,
		emdv,
		emnombre,
		emgeneric,
		emdirecc,
		emcomuna,
		emtipo,
		emglosa,
		embonos,
        	'emglosa'   = CASE WHEN emglosa  = 'S' THEN 'SI'
                           ELSE 'NO'
                           END
	FROM  EMISOR 
	WHERE emrut = @xRut

END


GO
