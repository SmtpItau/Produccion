USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Valida_Pais]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Valida_Pais] (
						   @codigo_pais int
        			  	          )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	 IF NOT EXISTS(SELECT codigo_pais FROM PAIS
		   WHERE  codigo_pais	= @codigo_pais
			  )
 		   BEGIN	
	   		SELECT 'NO EXISTE'
        END

END


GO
