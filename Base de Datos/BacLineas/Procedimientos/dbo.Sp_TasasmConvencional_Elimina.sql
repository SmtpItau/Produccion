USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasasmConvencional_Elimina]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_TasasmConvencional_Elimina] 
  ( @codigo_producto CHAR(5)  ,
   @codigo_moneda  NUMERIC(5,0) ,
   @diasdesde  NUMERIC(5,0) ,
   @DiasHasta   NUMERIC(5,0)    ,
   @MontoMinimo            NUMERIC(19,4)   ,
   @MontoMaximo            NUMERIC(19,4)   ,
   @TasaMinima   NUMERIC(8,4)    ,
   @TasaMaxima   NUMERIC(8,4)    
  )
AS 
BEGIN
   SET NOCOUNT OFF
   IF EXISTS(SELECT codigo_producto FROM TASAS_MAXIMAS_CONVENCIONAL 
  WHERE codigo_producto = @codigo_producto  
      AND codigo_moneda = @codigo_moneda
      AND diasdesde = @diasdesde
      AND DiasHasta  = @DiasHasta   
      AND MontoMinimo = @MontoMinimo            
      AND MontoMaximo = @MontoMaximo            
      AND TasaMinima = @TasaMinima   
      AND TasaMaxima = @TasaMaxima   )
   BEGIN
    DELETE TASAS_MAXIMAS_CONVENCIONAL 
  WHERE codigo_producto = @codigo_producto  
      AND codigo_moneda = @codigo_moneda
      AND diasdesde = @diasdesde  
      AND DiasHasta  = @DiasHasta   
      AND MontoMinimo = @MontoMinimo            
      AND MontoMaximo = @MontoMaximo            
      AND TasaMinima = @TasaMinima   
      AND TasaMaxima = @TasaMaxima   
    IF @@ERROR <> 0 
    BEGIN
 
     SELECT "ERROR"
    END ELSE
    BEGIN
  SELECT "OK"
    END
   END ELSE
   BEGIN
    SELECT "NO EXISTE"
   END
   SET NOCOUNT ON
END






GO
