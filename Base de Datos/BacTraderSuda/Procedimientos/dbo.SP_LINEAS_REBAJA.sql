USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_REBAJA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_REBAJA] ( @dFecPro DATETIME ,
     @cSistema CHAR (03) ,
     @nNumoper NUMERIC (10,0) ,
     @nNumdocu NUMERIC (10,0) ,
     @nCorrela NUMERIC (03,0) ,
     @nFactor FLOAT  )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Contador  INTEGER,
  @sw   CHAR(1)
 DECLARE @ctranssaccion  CHAR(15) ,
  @ctipo_detalle  CHAR(1)  ,
  @cactualizo_linea CHAR(1)  ,
  @nmontotransaccion NUMERIC(19,4) ,
  @ctipo_movimiento CHAR(1)  ,
  @nrutcli  NUMERIC(09,0) ,
  @ncodigo  NUMERIC(09,0) ,
  @nplazodesde  NUMERIC(09,0) ,
  @nplazohasta  NUMERIC(09,0) ,
  @csistematras  CHAR (03) ,
  @nmonto   NUMERIC(19,4) ,
  @dfecvctop  DATETIME ,
  @ccontrolaplazo  CHAR(01) ,
  @nRutcasamatriz  NUMERIC (09,0) ,
  @nCodigocasamatriz NUMERIC (09,0)
 DECLARE cursor_Rev SCROLL CURSOR FOR
 SELECT  Linea_Transsaccion ,
  NumeroCorre_Detalle ,
  Tipo_Detalle  ,
  Actualizo_Linea  ,
  MontoTransaccion ,
  Tipo_Movimiento  ,
  Rut_Cliente  ,
  Codigo_Cliente  ,
  PlazoDesde  ,
  PlazoHasta
 FROM VIEW_LINEA_TRANSACCION_DETALLE
 WHERE  Id_Sistema  = @cSistema
 AND NumeroOperacion  = @nNumoper
 AND NumeroDocumento  = @nNumdocu
 AND NumeroCorrelativo  = @nCorrela
 OPEN cursor_Rev 
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_Rev 
  INTO @cTranssaccion  ,
   @Contador  ,
   @cTipo_Detalle  ,
   @cActualizo_Linea ,
   @nMontoTransaccion ,
   @cTipo_Movimiento ,
   @nRutcli  ,
   @nCodigo  ,
   @nPlazoDesde  ,
   @nPlazoHasta  
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT @nRutcasamatriz  = rutcasamatriz  ,
   @nCodigocasamatriz = codigocasamatriz
         FROM VIEW_LINEA_GENERAL
  WHERE rut_cliente  = @nRutcli 
  AND  codigo_cliente  = @nCodigo
  IF @cTipo_Movimiento = 'S'
   SELECT @nMontoTransaccion = @nMontoTransaccion * (-1)
  SELECT @nMontoTransaccion = @nMontoTransaccion * @nFactor
  IF @cTipo_Detalle = 'L' AND @cActualizo_Linea = 'S'
  BEGIN
   IF @cTranssaccion = 'MATRIZ'
   BEGIN
    UPDATE VIEW_LINEA_AFILIADO
    SET totalocupado  = totalocupado        + @nMontoTransaccion
    WHERE rutcasamatriz   = @nRutcasamatriz
    AND  codigocasamatriz = @nCodigocasamatriz
   END
   IF @cTranssaccion = 'MAT_SR'
   BEGIN
    UPDATE VIEW_LINEA_AFILIADO
    SET Sinriesgoocupado = Sinriesgoocupado    + @nMontoTransaccion
    WHERE rutcasamatriz   = @nRutcasamatriz
    AND  codigocasamatriz = @nCodigocasamatriz
   END
   IF @cTranssaccion = 'MAT_CR'
   BEGIN
    UPDATE VIEW_LINEA_AFILIADO
    SET Conriesgoocupado = Conriesgoocupado    + @nMontoTransaccion
    WHERE rutcasamatriz   = @nRutcasamatriz
    AND  codigocasamatriz = @nCodigocasamatriz
   END
  
   IF @cTranssaccion = 'LINGEN'
   BEGIN
    UPDATE VIEW_LINEA_GENERAL
    SET totalocupado = totalocupado  + @nMontoTransaccion
    WHERE rut_cliente = @nRutcli
    AND codigo_cliente = @nCodigo
   END
   IF @cTranssaccion = 'LINSIS'
   BEGIN
    UPDATE VIEW_LINEA_SISTEMA
    SET totalocupado = totalocupado  + @nMontoTransaccion
    WHERE rut_cliente = @nRutcli
    AND codigo_cliente = @nCodigo
    AND id_sistema = @cSistema
   END
   IF @cTranssaccion = 'LINPZO'
   BEGIN
    UPDATE VIEW_LINEA_POR_PLAZO
    SET totalocupado = totalocupado  + @nMontoTransaccion
    WHERE rut_cliente = @nRutcli
    AND codigo_cliente = @nCodigo
    AND id_sistema = @cSistema
    AND plazodesde     <= @nPlazoDesde
   END
  END
 END
 CLOSE cursor_rev
 DEALLOCATE cursor_rev
 UPDATE VIEW_LINEA_TRANSACCION
 SET MontoTransaccion = MontoTransaccion - (MontoTransaccion * @nFactor),
  MontoOriginal    = MontoOriginal    - (MontoTransaccion * @nFactor)
 WHERE  Id_Sistema  = @cSistema
 AND NumeroOperacion  = @nNumoper
 AND NumeroDocumento  = @nNumdocu
 AND NumeroCorrelativo  = @nCorrela
 UPDATE VIEW_LINEA_TRANSACCION_DETALLE
 SET MontoTransaccion = MontoTransaccion - (MontoTransaccion * @nFactor)
 WHERE  Id_Sistema  = @cSistema
 AND NumeroOperacion  = @nNumoper
 AND NumeroDocumento  = @nNumdocu
 AND NumeroCorrelativo  = @nCorrela
 EXECUTE Sp_Lineas_Actualiza
 SET NOCOUNT OFF
END
--  select * from view_LINEA_TRANSACCION
-- select * from  VIEW_LINEA_TRANSACCION_DETALLE

GO
