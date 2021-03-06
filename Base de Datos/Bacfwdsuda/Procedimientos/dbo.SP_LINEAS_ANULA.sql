USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ANULA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_ANULA] ( @dFecPro DATETIME ,
     @cSistema CHAR (03) ,
     @nNumoper NUMERIC (10,0) )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Contador  INT,
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
  @nCodigocasamatriz NUMERIC (09,0) ,
  @cProducto  CHAR (05) ,
  @nMontoSpo  NUMERIC(19,4) ,
  @nMontoFwd  NUMERIC(19,4) ,
  @nPlazo   NUMERIC(10) ,
  @nCodigo_pais  NUMERIC(05)
 DECLARE cursor_grb SCROLL CURSOR FOR
 SELECT  Rut_Cliente,
  Codigo_Cliente,
  Id_Sistema,
  FechaVencimiento,
  MontoTraspasado
 FROM VIEW_LINEA_TRASPASO
 WHERE SistemaRecibio = @cSistema
 AND NumeroOperacion = @nNumoper
 OPEN cursor_grb
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_grb
  INTO @nRutcli ,
   @nCodigo ,
   @cSistemaTras ,
   @dFecvctop ,
   @nMonto
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT @nMonto = @nMonto * (-1)
  UPDATE VIEW_LINEA_SISTEMA
  SET totaltraspaso = totaltraspaso + @nMonto ,
   totalocupado = totalocupado + @nMonto
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistemaTras
  SELECt @ccontrolaplazo = 'N'
  SELECT @ccontrolaplazo = controlaplazo
  FROM VIEW_LINEA_SISTEMA
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistemaTras
  IF @ccontrolaplazo = 'S'
  BEGIN
   UPDATE VIEW_LINEA_POR_PLAZO
   SET totaltraspaso = totaltraspaso + @nMonto ,
    totalocupado = totalocupado + @nMonto
   WHERE rut_cliente = @nRutcli
   AND  codigo_cliente = @nCodigo
   AND  id_sistema = @cSistemaTras
   AND plazodesde  <=DATEDIFF(day, @dFecPro, @dFecvctop)
  END
  SELECt @ccontrolaplazo = 'N'
  UPDATE VIEW_LINEA_SISTEMA
  SET totalrecibido = totalrecibido + @nMonto
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistema
  SELECT @ccontrolaplazo = controlaplazo
  FROM VIEW_LINEA_SISTEMA
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistema
  IF @ccontrolaplazo = 'S'
  BEGIN
   UPDATE VIEW_LINEA_POR_PLAZO
   SET totalrecibido = totalrecibido + @nMonto
   WHERE rut_cliente = @nRutcli
   AND  codigo_cliente = @nCodigo
   AND  id_sistema = @cSistema
   AND plazodesde  <=DATEDIFF(day, @dFecPro, @dFecvctop)
  END
 END
 CLOSE cursor_grb
 DEALLOCATE cursor_grb
 DELETE VIEW_LINEA_TRASPASO
 WHERE SistemaRecibio = @cSistema
 AND NumeroOperacion = @nNumoper
 EXECUTE Sp_Lineas_Actualiza
 DECLARE cursor_INVERSION_EXTERIOR SCROLL CURSOR FOR
 SELECT  Rut_Cliente  ,
  Codigo_Cliente  ,
  TipodeOperacion  ,
  MontoOperacion  ,
  DATEDIFF(DAY,FechaInicio,FechaFinal)
 FROM VIEW_INVERSION_EXTERIOR_DETALLE
 WHERE  ( @cSistema = 'BCC' OR @cSistema = 'BFW' )
 AND Numero_Operacion  = @nNumoper
 OPEN cursor_INVERSION_EXTERIOR
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_INVERSION_EXTERIOR
  INTO @nRutcli  ,
   @nCodigo  ,
   @cProducto  ,
   @nMontoTransaccion ,
   @nPlazo
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT  @nMontoSpo = 0
  SELECT  @nMontoFwd = 0
  IF @cProducto = 'ARBI'
   SELECT  @nMontoSpo = @nMontoTransaccion
  IF @cProducto = '1'
   SELECT  @nMontoFwd = @nMontoTransaccion
  UPDATE VIEW_INVERSION_EXTERIOR
  SET InvExt_Ocupado  = InvExt_Ocupado - @nMontoTransaccion ,
   InvExt_Disponible = InvExt_Disponible + @nMonto ,
   ArbFwd_Ocupado  = ArbFwd_Ocupado - @nMontoFwd  ,
   ArbFwd_Disponible = ArbFwd_Disponible + @nMontoFwd ,
   ArbSpo_Ocupado  = ArbSpo_Ocupado - @nMontoSpo ,
   ArbSpo_Disponible = ArbSpo_Disponible + @nMontoSpo
  WHERE Rut_Cliente   = @nRutcli
  AND Codigo_Cliente   = @nCodigo
  AND Plazo   = @nPlazo
 END
 CLOSE cursor_INVERSION_EXTERIOR
 DEALLOCATE cursor_INVERSION_EXTERIOR
 DECLARE cursor_RIESGO_PAIS SCROLL CURSOR FOR
 SELECT  codigo_pais  ,
  montooperacion
 FROM VIEW_RIESGO_PAIS_DETALLE
 WHERE  @cSistema  = 'BCC'
 AND Numero_Operacion  = @nNumoper
 OPEN cursor_RIESGO_PAIS
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_RIESGO_PAIS
  INTO @nCodigo_pais  ,
   @nMontoTransaccion
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
         UPDATE VIEW_RIESGO_PAIS
  SET TotalOcupado = TotalOcupado    - @nMontoTransaccion,
   TotalDisponible = TotalDisponible + @nMontoTransaccion
  WHERE Codigo_pais = @nCodigo_pais
 END
 CLOSE cursor_RIESGO_PAIS
 DEALLOCATE cursor_RIESGO_PAIS
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
 DELETE VIEW_LINEA_TRANSACCION_DETALLE
 WHERE  Id_Sistema  = @cSistema
 AND NumeroOperacion  = @nNumoper
 DELETE VIEW_LINEA_TRANSACCION
 WHERE  Id_Sistema  = @cSistema
 AND NumeroOperacion  = @nNumoper
 EXECUTE Sp_Lineas_Actualiza
 SET NOCOUNT OFF
END
--  select * from view_LINEA_TRANSACCION
-- select * from VIEW_INVERSION_EXTERIOR
-- select * from VIEW_INVERSION_EXTERIOR_DETALLE
-- select * from VIEW_RIESGO_PAIS
-- select * from VIEW_RIESGO_PAIS_DETALLE

GO
