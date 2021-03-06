USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AGREGACOSTOS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_AGREGACOSTOS]
	(	@FechaAct CHAR(8)
	,	@FechaAnt CHAR(8) 
	)
AS    
BEGIN    
  
 IF NOT EXISTS ( SELECT * FROM COSTOS_COMEX WHERE Fecha = @FechaAct)    
 BEGIN    
    
 SELECT  FECHA,    
   Entre_Desde,    
   Entre_Hasta,    
   Costo_Compra,    
   Costo_Venta,    
   Spread_Compra,    
   Spread_Venta,    
   Spread_Trading_Compra,    
   Spread_Trading_Venta,    
   perfil_comercial,    
   montomax,    
   CodMoneda, --> se agrega 19-08-2011    
   Costo_Compra_OutTime,  
   Costo_Venta_OutTime  
   INTO #COSTOS    
 FROM COSTOS_COMEX    
 WHERE Fecha = @FechaAnt    
    
 UPDATE #COSTOS    
 SET  FECHA = @FechaAct    
    
 INSERT INTO COSTOS_COMEX  
 ( FECHA,    
  Entre_Desde,    
  Entre_Hasta,    
  Costo_Compra,    
  Costo_Venta,    
  Spread_Compra,    
  Spread_Venta,    
  Spread_Trading_Compra,    
  Spread_Trading_Venta,    
  perfil_comercial,    
  montomax,    
  CodMoneda,  
  Costo_Compra_OutTime,  
  Costo_Venta_OutTime  
 )    
 SELECT  FECHA,    
   Entre_Desde,    
   Entre_Hasta,    
   Costo_Compra = 0,    
   Costo_Venta  = 0,    
   Spread_Compra,    
   Spread_Venta,    
   Spread_Trading_Compra,    
   Spread_Trading_Venta,    
   perfil_comercial,    
   montomax,        
            CodMoneda,  
   Costo_Compra_OutTime,  
   Costo_Venta_OutTime  
 FROM #COSTOS    
  
 IF @@ERROR <> 0    
 BEGIN    
  PRINT 'ERROR_PROC FALLA AGREGANDO COSTOS COMEX'    
  RETURN 1    
 END  
  
 DELETE #COSTOS    
  
END    
  
  
--Se agrega para proyecto 5538 Costos para operaciones Web eIBS  
 IF NOT EXISTS ( SELECT * FROM COSTOS_COMEX_IBS WHERE Fecha = @FechaAct)  
 BEGIN  
  
		SELECT
				FECHA,
				NEMO,
				SEGMENTO,
				CODMONEDA,
				MONTOMAX,
				SPREAD_TRADING_COMPRA,
				SPREAD_TRADING_VENTA,
				ENTRE_DESDE,
				ENTRE_HASTA,
				SPREAD_COMPRA,
				SPREAD_VENTA
  
  INTO #COSTOS_IBS  
  FROM COSTOS_COMEX_IBS  
  WHERE Fecha= @FechaAnt  
  
  UPDATE #COSTOS_IBS  
  SET FECHA = @FechaAct  
  
		INSERT INTO COSTOS_COMEX_IBS(	FECHA,
				NEMO,
				SEGMENTO,
				CODMONEDA,
				MONTOMAX,
				SPREAD_TRADING_COMPRA,
				SPREAD_TRADING_VENTA,
				ENTRE_DESDE,
				ENTRE_HASTA,
				SPREAD_COMPRA,
				SPREAD_VENTA    
     )  
  
			SELECT 		FECHA,
				NEMO,
				SEGMENTO,
				CODMONEDA,
				MONTOMAX,
				SPREAD_TRADING_COMPRA,
				SPREAD_TRADING_VENTA,
				ENTRE_DESDE,
				ENTRE_HASTA,
				SPREAD_COMPRA,
				SPREAD_VENTA    
   FROM #COSTOS_IBS  
  
  IF @@ERROR <> 0  
  BEGIN  
   PRINT 'ERROR_PROC FALLA AGREGANDO COSTOS WEB'  
   RETURN 1  
  END  
  DELETE #COSTOS_IBS  
 END  
  
  
 SELECT 1    
  
END  

GO
