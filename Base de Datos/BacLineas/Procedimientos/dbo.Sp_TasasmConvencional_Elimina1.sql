USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasasmConvencional_Elimina1]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TasasmConvencional_Elimina1    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
--DROP PROCEDURE dbo.Sp_TasasmConvencional_Elimina1 
--GO
CREATE PROCEDURE [dbo].[Sp_TasasmConvencional_Elimina1] 
  ( @codigo_producto CHAR(5)  ,
   @codigo_moneda  NUMERIC(5,0) 
   
  )
AS 
BEGIN
   SET NOCOUNT OFF
   IF EXISTS(SELECT codigo_producto FROM TASAS_MAXIMAS_CONVENCIONAL 
  WHERE codigo_producto = @codigo_producto  
      AND codigo_moneda = @codigo_moneda)
      
   BEGIN
    DELETE TASAS_MAXIMAS_CONVENCIONAL 
  WHERE codigo_producto = @codigo_producto  
      AND codigo_moneda = @codigo_moneda
       
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
