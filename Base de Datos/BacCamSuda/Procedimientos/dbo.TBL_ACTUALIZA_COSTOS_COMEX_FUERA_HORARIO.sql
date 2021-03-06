USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[TBL_ACTUALIZA_COSTOS_COMEX_FUERA_HORARIO]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[TBL_ACTUALIZA_COSTOS_COMEX_FUERA_HORARIO] (@FECHA DATETIME)
AS 
BEGIN
	
	/*
	SELECT * FROM BacCamSuda.dbo.costos_comex WHERE Fecha = '20090925' AND CodMoneda = 13
	TBL_ACTUALIZA_COSTOS_COMEX_FUERA_HORARIO '20090925'
	*/
	
	UPDATE BacCamSuda.dbo.costos_comex 
	SET Costo_Compra_OutTime = Costo_Compra, Costo_Venta_OutTime = Costo_Venta   
	WHERE CodMoneda = 13 AND Fecha = @fecha


	UPDATE BacCamSuda.dbo.costos_comex 
	SET Costo_Compra = 0, Costo_Venta = 0   
	WHERE CodMoneda = 13 AND Fecha = @fecha
	
END
  
GO
