USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Eliminar_Ciudad]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Eliminar_Ciudad] ( @codigo_ciudad int,
						       @nombre	    char(50)
						     )
AS 
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	IF NOT EXISTS(SELECT clciudad FROM CLIENTE
	   WHERE  clciudad = @codigo_ciudad)
    	   BEGIN
		   DELETE COMUNA WHERE Codigo_ciudad = @codigo_ciudad	
	   	   DELETE CIUDAD WHERE	codigo_ciudad	= @codigo_ciudad

        END ELSE
	   BEGIN
	   	   SELECT 'RELACIONADA'
  	END

END


GO
