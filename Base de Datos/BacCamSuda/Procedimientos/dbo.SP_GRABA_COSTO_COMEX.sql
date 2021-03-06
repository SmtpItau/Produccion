USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_COSTO_COMEX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_COSTO_COMEX]
(     @Tipo						CHAR(2),
      @Fecha						CHAR(8),  
      @Entre_Desde					NUMERIC(18,4),  
      @Entre_Hasta					NUMERIC(18,4),  
      @Costo_Compra					NUMERIC(18,4),  
      @Costo_Venta					NUMERIC(18,4),  
      @Spread_Compra				NUMERIC(18,4),  
      @Spread_Venta					NUMERIC(18,4),  
      @Spread_Trading_Compra		NUMERIC(18,4),  
      @Spread_Trading_Venta			NUMERIC(18,4),  
      @Perfil_Comercial				INT 	= 0,	   -- PRD7494
      @Monto_max		NUMERIC(18,4) 	= 0,	-- PRD7494
      @monCod			NUMERIC(5)	= 0	--> 31-05-2011 arm+-
       )  
AS  
BEGIN  
 SET NOCOUNT ON  
   
 IF @Tipo = 'BF'  
 BEGIN  
  SELECT Entre_Desde,  
   Entre_Hasta,  
   Costo_Compra,  
   Costo_Venta,  
   Spread_Compra,  
   Spread_Venta,  
   Spread_Trading_Compra,  
   Spread_Trading_Venta,  
   perfil_comercial,-- PRD7494  
   montomax,		-- PRD7494
   codMoneda         
  FROM COSTOS_COMEX  
  WHERE Fecha = @Fecha  
  AND  Perfil_Comercial = @Perfil_Comercial    
  And     codMoneda = @monCod	
  ORDER BY Entre_Desde, Entre_Hasta  
 END  
  
 IF @Tipo = 'EU'  
  BEGIN  
   DELETE COSTOS_COMEX  
   WHERE Fecha   = @Fecha  
   AND Entre_Desde  = @Entre_Desde  
   AND Entre_Hasta  = @Entre_Hasta  

   IF @@ERROR <> 0  
    BEGIN  
     PRINT 'ERROR_PROC FALLA BORRANDO COSTO.'  
     RETURN 1  
    END  
  END  

 IF @Tipo = 'G'  
 BEGIN  
   INSERT INTO COSTOS_COMEX( Fecha,  
       Entre_Desde,  
       Entre_Hasta,  
       Costo_Compra,  
       Costo_Venta,  
       Spread_Compra,  
       Spread_Venta,  
       Spread_Trading_Compra,  
       spread_trading_venta,  
       perfil_comercial,  
       montomax,
       CodMoneda)
  
     VALUES ( @Fecha,  
       @Entre_Desde,  
       @Entre_Hasta,  
       @Costo_Compra,  
       @Costo_Venta,  
       @Spread_Compra,  
       @Spread_Venta,  
       @Spread_Trading_Compra,  
       @Spread_Trading_Venta,  
       @perfil_comercial,  
       @monto_max,
       @MonCod )
  
   IF @@ERROR <> 0  
    BEGIN  
     PRINT 'ERROR_PROC FALLA AGREGANDO COSTOS COMEX'  
     RETURN 1  
    END  
    
  END  
	
 IF @Tipo = 'D'  
 BEGIN  
  DELETE COSTOS_COMEX  
  WHERE Fecha = @Fecha  
  AND perfil_comercial = @perfil_comercial  
  AND		CodMoneda		 = @MonCod
  
   IF @@ERROR <> 0  
    BEGIN  
     PRINT 'ERROR_PROC FALLA AGREGANDO COSTOS COMEX'  
     RETURN 1  
    END  
 END  
  
END  
GO
