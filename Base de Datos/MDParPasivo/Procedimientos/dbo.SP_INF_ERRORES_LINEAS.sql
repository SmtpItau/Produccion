USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_ERRORES_LINEAS]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_INF_ERRORES_LINEAS](@dfecha CHAR(8))
AS
BEGIN 
	IF EXISTS(SELECT 1  FROM ERRORES_LINEAS
			    WHERE fecha_proceso = @dfecha) BEGIN


		SELECT fecha =CONVERT(CHAR(10),fecha_proceso,103),
		       mensaje = UPPER(mensaje)
        	FROM ERRORES_LINEAS
		WHERE fecha_proceso = @dfecha

	END ELSE BEGIN

		SELECT fecha = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecha),103),
		       mensaje = CONVERT(VARCHAR(255),' ')
	
	END
END
GO
