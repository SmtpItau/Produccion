USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_GRABAR_INVERSION_INSTRUMENTO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEA_GRABAR_INVERSION_INSTRUMENTO](
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nNumoper NUMERIC(10) )
AS
BEGIN
 DECLARE @nTotalDisponible NUMERIC (19,4) ,
  @nMonto   NUMERIC (19,4) ,
  @nRut_emisor  NUMERIC(9) ,
  @nInCodigo  NUMERIC(05) ,
  @nMoneda_Emision  NUMERIC(03)
 DECLARE Cursor_INVERSION_INSTRUMENTO SCROLL CURSOR FOR
 SELECT Rut_emisor  ,
  Moneda_Emision  ,
  inCodigo  ,
  SUM(MontoTransaccion)
 FROM VIEW_LINEA_CHEQUEAR
 WHERE NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 AND Codigo_Producto = @cProducto
 GROUP BY
  Rut_emisor  ,
  Moneda_Emision  ,
  inCodigo
 OPEN Cursor_INVERSION_INSTRUMENTO
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM Cursor_INVERSION_INSTRUMENTO
  INTO @nRut_emisor ,
   @nMoneda_Emision,
   @nIncodigo ,
   @nMonto
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  UPDATE VIEW_MARGEN_INVERSION_INSTRUMENTO
  SET TotalOcupado = TotalOcupado    + @nMonto,
   TotalDisponible = TotalDisponible - @nMonto
  WHERE id_sistema = @cSistema
  AND instrumento = @nInCodigo
  AND codigo_moneda = @nMoneda_Emision
  AND rut_emisor = @nRut_emisor
 END
 CLOSE Cursor_INVERSION_INSTRUMENTO
 DEALLOCATE Cursor_INVERSION_INSTRUMENTO
END
-- select * from VIEW_MARGEN_INVERSION_INSTRUMENTO


GO
