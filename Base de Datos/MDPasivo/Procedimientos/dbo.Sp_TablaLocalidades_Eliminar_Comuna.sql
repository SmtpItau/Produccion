USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Eliminar_Comuna]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Eliminar_Comuna](@CODIGO_COMUNA 	INT,
			  			   	     @NOMBRE		CHAR(50) 
      				  	                     )AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

     IF NOT EXISTS(SELECT clcomuna FROM CLIENTE
     WHERE clcomuna = @codigo_comuna )
     BEGIN

  	  DELETE FROM COMUNA WHERE codigo_comuna = @codigo_comuna 

     END ELSE
     BEGIN

   	   SELECT 'RELACIONADA'
	
     END

END


GO
