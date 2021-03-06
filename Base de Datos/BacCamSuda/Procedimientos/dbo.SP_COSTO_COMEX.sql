USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COSTO_COMEX]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_COSTO_COMEX]      
   (    @CompVenta      CHAR(1),      
        @Fecha          CHAR(8),      
        @Monto          NUMERIC(18,4),      
        @UnidadNegocio  INT = 0,  
        @iMoneda     INT = 13  
   )       
AS      
BEGIN      
  
 SET NOCOUNT ON      
      
   -->   Se incluye para realizar el filtro respecto al Origen. El cual se maneja en codificacion discordante entre la tabla de Comex y Origenes    
   /*
   SET @UnidadNegocio = CASE WHEN @UnidadNegocio = 0  THEN 2   --> EJECUTIVO INTERNACIONAL    --> COMEX    
                             WHEN @UnidadNegocio = 8  THEN 2   --> EJECUTIVO INTERNACIONAL    --> COMEX    
                             WHEN @UnidadNegocio = 13 THEN 3   --> EJECUTIVO GRANDES EMPRESAS --> GGEE    
                             WHEN @UnidadNegocio = 14 THEN 4   --> ESPECIALISTA COMEX         --> ECOMEX    
                             ELSE                          1   --> NO APLICA                  --> ''    
                        END    
   */

   SELECT @UnidadNegocio   = CASE WHEN @UnidadNegocio = 0 THEN 2 ELSE ISNULL(tbcodigo1, 1) END
     FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE 
    WHERE tbcateg          = 8602 
      AND tbtasa           = @UnidadNegocio

   IF @UnidadNegocio IS NULL
      SET @UnidadNegocio = 1

    
 IF  @CompVenta= 'V'       
  SELECT Costo_Venta,      
   Entre_Desde,      
   Entre_Hasta,      
   Spread_Venta,      
   Spread_Trading_Venta,      
   perfil_comercial      
  FROM COSTOS_COMEX      
  WHERE Fecha   = @Fecha      
      AND  PERFIL_COMERCIAL = @UnidadNegocio      
      AND  @Monto           BETWEEN Entre_Desde AND Entre_Hasta      
      AND  CodMoneda    = @iMoneda  
      
 IF  @CompVenta= 'C'       
  SELECT Costo_COMPRA,      
   Entre_Desde,      
   Entre_Hasta,      
   Spread_Compra,      
   Spread_Trading_Compra,      
   perfil_comercial      
  FROM COSTOS_COMEX      
  WHERE Fecha   = @Fecha      
      AND  PERFIL_COMERCIAL = @UnidadNegocio      
      AND  @Monto           BETWEEN Entre_Desde AND Entre_Hasta      
      AND  CodMoneda    = @iMoneda    
      
END      
GO
