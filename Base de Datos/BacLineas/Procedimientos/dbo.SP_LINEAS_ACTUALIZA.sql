USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ACTUALIZA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_ACTUALIZA]
AS
BEGIN

	-->+++CONTROL IDD, jcamposd no actualizar líneas BAC proceso ya no es utilizado
	RETURN
	-->---CONTROL IDD, jcamposd no actualizar líneas BAC proceso ya no es utilizado


	SET NOCOUNT ON

	UPDATE 	LINEA_GENERAL
	SET 	totaldisponible = 0 ,
		totalexceso = 0

	UPDATE 	LINEA_GENERAL
	SET 	totaldisponible = totalasignado - totalocupado
	WHERE 	totalasignado > totalocupado

	UPDATE 	LINEA_GENERAL
	SET 	totalexceso  = ( totalasignado - totalocupado ) * -1
	WHERE 	totalasignado < totalocupado

	UPDATE 	LINEA_SISTEMA
	SET 	totaldisponible = 0 ,
		totalexceso = 0

	UPDATE 	LINEA_SISTEMA
	SET 	totaldisponible = totalasignado - totalocupado
	WHERE 	totalasignado > totalocupado

	UPDATE 	LINEA_SISTEMA
	SET 	totalexceso  = ( totalasignado - totalocupado ) * -1
	WHERE 	totalasignado < totalocupado

	UPDATE 	LINEA_PRODUCTO_POR_PLAZO
	SET 	totaldisponible = 0 ,
		totalexceso = 0

	UPDATE 	LINEA_PRODUCTO_POR_PLAZO
	SET 	totaldisponible = totalasignado - totalocupado
	WHERE 	totalasignado > totalocupado

	UPDATE 	LINEA_PRODUCTO_POR_PLAZO
	SET 	totalexceso  = ( totalasignado - totalocupado ) * -1
	WHERE 	totalasignado < totalocupado

       	UPDATE 	POSICION_GRUPO
       	SET 	totaldisponible = 0,
		totalexcedido = 0

       	UPDATE 	POSICION_GRUPO
       	SET 	totaldisponible = totalposicion - totalocupado
       	WHERE 	totalposicion > totalocupado

       	UPDATE 	POSICION_GRUPO
       	SET 	totalexcedido = (totalposicion - totalocupado) * -1
       	WHERE 	totalposicion < totalocupado


	SET NOCOUNT OFF

END
GO
