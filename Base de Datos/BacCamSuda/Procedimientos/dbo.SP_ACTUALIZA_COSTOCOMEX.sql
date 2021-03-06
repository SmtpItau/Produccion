USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_COSTOCOMEX]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_ACTUALIZA_COSTOCOMEX]   
  (   @PrVenta NUMERIC(18,4),    
      @PrCompr  NUMERIC(18,4),      
      @Fecha    CHAR(8)      
  )      
--***********************************************************************/      
--Modificacion: Se agrega filtro para agregar codigo de moneda   */      
--a la tabla costos_comex            */      
--Fecha 01/07/2011              */      
--***********************************************************************/      
AS       
BEGIN     
   
 --> 11489 - Restricción de horario para invertir Comex -   
 DECLARE @iSwTime INT  --> control horario  
 DECLARE @iBloqued INT  --> bloqueo temporal  
  
  SET @iSwTime = 1 --> True (1=ON TIME ; 0=OUT TIME)  
  SET @iBloqued = 0 --> Activo (0=Activo ; 1=Bloqueado)  
  
 SELECT @iSwTime = CASE WHEN (Hora_Apertura <= CONVERT(CHAR(10), GETDATE(), 108) ) AND (Hora_Cierre >= CONVERT(CHAR(10), GETDATE(), 108)) THEN 1 ELSE 0 END  
  , @iBloqued = Bloqueado  
 FROM BacParamSuda.dbo.TBL_CONTROL_HORARIO_COMEX with(nolock)  
  
  
 --> Antes de Dejar en Cero por el control Horario, actualizo los valores necesarios  
   UPDATE COSTOS_COMEX  
   SET  Costo_Compra_OutTime = case when @PrVenta <> 0 then @PrVenta else @PrCompr end  
  ,  Costo_Venta_OutTime  = case when @PrVenta <> 0 then @PrVenta else @PrCompr end  
   WHERE  Fecha     = @Fecha  
   AND  CodMoneda    = 13        
 --> Antes de Dejar en Cero por el control Horario, actualizo los valores necesarios  
  
  
 IF @iSwTime = 0 OR @iBloqued = 1  
 BEGIN  
  SET @PrCompr = 0.0  
  SET @PrVenta = 0.0  
 END  
 --> 11489 - Restricción de horario para invertir Comex -   
  
   
 DECLARE @tipo_cambio NUMERIC(18,4)    
 IF @PrVenta <> 0           
    begin    
  SET @tipo_cambio = @PrVenta    
 end ELSE    
 begin    
  SET @tipo_cambio = @PrCompr    
 end    
    
  UPDATE COSTOS_COMEX  
  SET    Costo_Compra = @tipo_cambio,        
         Costo_Venta  = @tipo_cambio,        
         CodMoneda    = 13        
  WHERE Fecha         = @Fecha        
  AND   CodMoneda     = 13        
  
END  

GO
