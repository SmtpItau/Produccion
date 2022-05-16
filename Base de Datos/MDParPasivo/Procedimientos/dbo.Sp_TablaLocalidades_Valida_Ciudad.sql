USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Valida_Ciudad]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Valida_Ciudad] (
						    @CODIGO_CIUDAD INT
        			  	            )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	 IF NOT EXISTS(SELECT codigo_ciudad FROM CIUDAD
		   WHERE  codigo_ciudad	= @codigo_ciudad)
 		   BEGIN	
	   		SELECT 'NO EXISTE'
        END
   	SET NOCOUNT ON
END


GO
