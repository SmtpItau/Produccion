USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_CAJA_GRABA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_FLUJO_CAJA_GRABA    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_FLUJO_CAJA_GRABA] (
     @CodConcepto  NUMERIC(3),
     @FechaOperacion  DATETIME,
     @MOperacion  NUMERIC(19)
         )
AS
BEGIN
 SET NOCOUNT ON
  INSERT INTO  FLUJOCAJA_OPERACION 
    VALUES  (
    @CodConcepto,
    @FechaOperacion,
    @MOperacion
    )
  
  SELECT 'INSERTA'
 SET NOCOUNT OFF
END
GO
