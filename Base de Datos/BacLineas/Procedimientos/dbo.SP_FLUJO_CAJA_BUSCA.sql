USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_CAJA_BUSCA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_FLUJO_CAJA_BUSCA    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_FLUJO_CAJA_BUSCA] (
     @CodConcepto  NUMERIC(3),
     @FechaOperacion  DATETIME     
         )
AS
BEGIN
 SET NOCOUNT ON
 SELECT  Codigo_Concepto, 
  FechaOperacion,              
  MontoOperacion         
 FROM FLUJOCAJA_OPERACION WHERE codigo_concepto = @CodConcepto AND DATEPART(MM,FechaOperacion ) = DATEPART(MM,@FechaOperacion) AND DATEPART(YY,fechaoperacion ) = DATEPART(YY,@FechaOperacion)
 SET NOCOUNT OFF
END
GO
