USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Valida_Region]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Valida_Region] (
						     @CODIGO_REGION INT
        			  	            )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

	 IF NOT EXISTS(SELECT codigo_region FROM REGION
		   WHERE  codigo_region	= @codigo_region)
 		   BEGIN	
	   		SELECT 'NO EXISTE'
        END

END


GO
