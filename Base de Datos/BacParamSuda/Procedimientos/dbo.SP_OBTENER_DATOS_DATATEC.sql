USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTENER_DATOS_DATATEC]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_OBTENER_DATOS_DATATEC]    
(  @tipoOperacion CHAR(1)    
 , @codMoneda VARCHAR(5)  
 , @DatoFteExterna  NUMERIC(19,4) OUTPUT   
)    
AS    
BEGIN    
  
 SET NOCOUNT ON    
     
 DECLARE @fechaProc DATETIME    
 ,  @Moneda  NUMERIC(5,0)  
    
 SELECT @fechaProc = ACFECPRO    
 FROM Baccamsuda..meac    
 WHERE ACRUT = 97023000    
    
 SELECT @Moneda = CONVERT(NUMERIC(5,0), @codMoneda)  
   
 IF @fechaProc IS NULL    
 BEGIN    
  SELECT @DatoFteExterna = NULL    
  RETURN 0    
 END    
    
 IF @tipoOperacion NOT IN ('C','V')    
 BEGIN    
 SELECT @DatoFteExterna = NULL    
 RETURN 0    
 END    
  
 IF @tipoOperacion = 'C'    
  SELECT TOP 1    
				@DatoFteExterna = Costo_Compra_OutTime --> Costo_Compra  
  FROM Baccamsuda..COSTOS_COMEX    
  WHERE Fecha   = @fechaProc    
  AND  codMoneda  = @Moneda  
 ELSE    
  SELECT TOP 1    
				@DatoFteExterna = Costo_Venta_OutTime	-->	Costo_Venta  
  FROM Baccamsuda..COSTOS_COMEX    
  WHERE Fecha   = @fechaProc    
  AND  codMoneda  = @Moneda  
  
 RETURN 0    
END    

GO
