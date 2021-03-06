USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_LIMPIA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_LIMPIA]
AS
BEGIN

	SET NOCOUNT ON

	UPDATE 	LINEA_GENERAL
	SET 	TotalOcupado = 0 ,
		TotalExceso = 0  ,
		TotalDisponible = TotalAsignado


	UPDATE 	LINEA_SISTEMA
	SET 	TotalOcupado = 0 ,
		TotalExceso = 0  ,
		TotalDisponible = TotalAsignado

	UPDATE 	LINEA_PRODUCTO_POR_PLAZO
	SET 	TotalOcupado = 0 ,
		totalexceso = 0  ,
		TotalDisponible = TotalAsignado

       	UPDATE 	POSICION_GRUPO
       	SET 	totaldisponible = 0,
		totalexcedido = 0

       	UPDATE 	POSICION_GRUPO
       	SET 	totaldisponible = totalposicion - totalocupado
       	WHERE 	totalposicion > totalocupado

       	UPDATE 	POSICION_GRUPO
       	SET 	totalexcedido = (totalposicion - totalocupado) * -1
       	WHERE 	totalposicion < totalocupado

	UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO 
	SET 	Acumulado_Diario = 0

	SET NOCOUNT OFF

END
GO
