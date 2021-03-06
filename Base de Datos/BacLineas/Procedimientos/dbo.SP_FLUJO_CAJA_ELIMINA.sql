USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_CAJA_ELIMINA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_FLUJO_CAJA_ELIMINA    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_FLUJO_CAJA_ELIMINA] (
     @CodConcepto  NUMERIC(3),
     @FechaOperacion  DATETIME     
         )
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS (SELECT 1 FROM FLUJOCAJA_OPERACION WHERE codigo_concepto = @CodConcepto AND DATEPART(MM,FechaOperacion ) = DATEPART(MM,@FechaOperacion) ) BEGIN
  IF EXISTS (SELECT 1 FROM FLUJOCAJA_OPERACION WHERE codigo_concepto = @CodConcepto AND DATEPART(YY,FechaOperacion ) = DATEPART(YY,@FechaOperacion) ) BEGIN
  
   DELETE FROM FLUJOCAJA_OPERACION WHERE codigo_concepto = @CodConcepto AND DATEPART(MM,fechaoperacion ) = DATEPART(MM,@FechaOperacion) AND DATEPART(YY,fechaoperacion ) = DATEPART(YY,@FechaOperacion)
  END
 
 END
 SET NOCOUNT OFF
END
GO
