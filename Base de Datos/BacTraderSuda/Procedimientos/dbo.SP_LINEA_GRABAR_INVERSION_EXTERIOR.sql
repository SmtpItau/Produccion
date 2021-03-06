USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_GRABAR_INVERSION_EXTERIOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEA_GRABAR_INVERSION_EXTERIOR](
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nNumoper NUMERIC(10) )
AS
BEGIN
 DECLARE @nMonto   NUMERIC (19,4) ,
  @nMontoSpo  NUMERIC (19,4) ,
  @nMontoFwd  NUMERIC (19,4) ,
  @nRutcli  NUMERIC (09,0) ,
  @nCodigo  NUMERIC (09,0) ,
  @nPlazo   NUMERIC (05,0) ,
  @dFecvctop  DATETIME ,
  @cUsuario  CHAR (15) ,
  @dFeciniop  DATETIME
 DECLARE Cursor_INVERSION_EXTERIOR SCROLL CURSOR FOR
 SELECT Rut_Cliente  ,
  Codigo_Cliente  ,
  DATEDIFF(DAY,fechaoperacion,fechavencimiento),
  SUM(MontoTransaccion) ,
  FechaVencimiento ,
  Operador  ,
  FechaOperacion
 FROM VIEW_LINEA_CHEQUEAR
 WHERE NumeroOperacion = @nNumoper
 AND Id_Sistema = @cSistema
 AND Codigo_Producto = @cProducto
 GROUP 
 BY Rut_Cliente  ,
  Codigo_Cliente  ,
  DATEDIFF(DAY,fechaoperacion,fechavencimiento),
  FechaVencimiento ,
  Operador  ,
  FechaOperacion
 OPEN Cursor_INVERSION_EXTERIOR
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM Cursor_INVERSION_EXTERIOR
  INTO @nRutcli ,
   @nCodigo ,
   @nPlazo  ,
   @nMonto  ,
   @dFecvctop ,
   @cUsuario ,
   @dFeciniop 
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT  @nMontoSpo = 0,
   @nMontoFwd = 0
  IF ( @cSistema = 'BCC' AND @cProducto = 'ARBI' ) 
   SELECT  @nMontoSpo = @nMonto
  IF ( @cSistema = 'BFW' AND @cProducto = '1' )
   SELECT  @nMontoFwd = @nMonto
  UPDATE VIEW_INVERSION_EXTERIOR
  SET InvExt_Ocupado  = InvExt_Ocupado + @nMonto ,
   InvExt_Disponible = InvExt_Disponible - @nMonto ,
   ArbFwd_Ocupado  = ArbFwd_Ocupado + @nMontoFwd  ,
   ArbFwd_Disponible = ArbFwd_Disponible - @nMontoFwd ,
   ArbSpo_Ocupado  = ArbSpo_Ocupado + @nMontoSpo ,
   ArbSpo_Disponible = ArbSpo_Disponible - @nMontoSpo
  WHERE Rut_Cliente   = @nRutcli
  AND Codigo_Cliente   = @nCodigo
  AND Plazo   = @nPlazo
  INSERT INTO VIEW_INVERSION_EXTERIOR_DETALLE(
   Rut_Cliente  ,
   Codigo_Cliente  ,
   Numero_Operacion ,
   TipodeOperacion  ,
   FechaInicio  ,
   FechaFinal  ,
   MontoOperacion  ,
   Usuario   )
  SELECT @nRutcli  ,
   @nCodigo  , 
   @nNumoper  ,
   @cProducto  ,
   @dFeciniop  ,
   @dFecvctop  ,
   @nMonto   ,
   @cUsuario
 END
 CLOSE Cursor_INVERSION_EXTERIOR
 DEALLOCATE Cursor_INVERSION_EXTERIOR
END
-- select * FROM VIEW_INVERSION_EXTERIOR
-- select * FROM VIEW_INVERSION_EXTERIOR_detalle
-- Rut_Cliente Codigo_Cliente Numero_Operacion TipodeOperacion FechaInicio                 FechaFinal                  MontoOperacion        Usuario    


GO
