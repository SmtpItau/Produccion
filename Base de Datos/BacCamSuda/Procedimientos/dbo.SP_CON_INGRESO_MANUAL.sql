USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_INGRESO_MANUAL]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_INGRESO_MANUAL]
		(   @FechaProceso DATETIME	   	
   		)
AS
BEGIN
     SET NOCOUNT ON
	SELECT  Fecha_Proceso
	,	Moneda 
	,	SUM(Monto_Compra) AS  Monto_Compra           
	,	SUM(Monto_Venta)  AS  Monto_Venta          
	FROM	TBL_HEDGE_INGRESO_MANUAL WITH (NOLOCK)
	WHERE	Fecha_Proceso = @FechaProceso
	GROUP 
	BY	Fecha_Proceso,Moneda
  
END
GO
