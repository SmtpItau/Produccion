USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_VENCIMIENTOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_VENCIMIENTOS] ( @dFecPro DATETIME )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Contador  INTEGER  ,
  @sw   CHAR(1)  
 DECLARE @cSistema  CHAR (03) ,
  @nNumoper  NUMERIC (10,0) ,
  @nNumdocu  NUMERIC (10,0) ,
  @nCorrela  NUMERIC (10,0) ,
  @ctranssaccion  CHAR(15) ,
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
  @dfecInip  DATETIME ,
  @ccontrolaplazo  CHAR(01) ,
  @nRutcasamatriz  NUMERIC (09,0) ,
  @nCodigocasamatriz NUMERIC (09,0)
 DECLARE cursor_TRASPASO SCROLL CURSOR FOR
 SELECT  SistemaRecibio ,
  NumeroOperacion ,
  Rut_Cliente ,
  Codigo_Cliente ,
  Id_Sistema ,
  FechaVencimiento,
  FechaInicio ,
  MontoTraspasado
 FROM LINEA_TRASPASO
 WHERE FechaVencimiento <= @dFecPro
 OPEN cursor_TRASPASO
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_TRASPASO
  INTO @cSistema ,
   @nNumoper ,
   @nRutcli ,
   @nCodigo ,
   @cSistemaTras ,
   @dFecvctop ,
   @dfecInip ,
   @nMonto
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  SELECT @nMonto = @nMonto * (-1)
  UPDATE LINEA_SISTEMA
  SET totaltraspaso = totaltraspaso + @nMonto ,
   totalocupado = totalocupado + @nMonto
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistemaTras
  SELECt @ccontrolaplazo = 'N'
  SELECT @ccontrolaplazo = controlaplazo
  FROM LINEA_SISTEMA
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistemaTras
  IF @ccontrolaplazo = 'S'
  BEGIN
   UPDATE LINEA_POR_PLAZO
   SET totaltraspaso = totaltraspaso + @nMonto ,
    totalocupado = totalocupado + @nMonto
   WHERE rut_cliente = @nRutcli
   AND  codigo_cliente = @nCodigo
   AND  id_sistema = @cSistemaTras
   AND plazodesde  <=DATEDIFF(day, @dfecInip, @dFecvctop)
  END
  SELECt @ccontrolaplazo = 'N'
  UPDATE LINEA_SISTEMA
  SET totalrecibido = totalrecibido + @nMonto
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistema
  SELECT @ccontrolaplazo = controlaplazo
  FROM LINEA_SISTEMA
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistema
  IF @ccontrolaplazo = 'S'
  BEGIN
   UPDATE LINEA_POR_PLAZO
   SET totalrecibido = totalrecibido + @nMonto
   WHERE rut_cliente = @nRutcli
   AND  codigo_cliente = @nCodigo
   AND  id_sistema = @cSistema
   AND plazodesde  <=DATEDIFF(day, @dfecInip, @dFecvctop)
  END
 END
 CLOSE cursor_TRASPASO
 DEALLOCATE cursor_TRASPASO
 DELETE LINEA_TRASPASO
 WHERE FechaVencimiento <= @dFecPro
 EXECUTE SP_LINEAS_ACTUALIZA
 DECLARE cursor_TRANSACCION SCROLL CURSOR FOR
 SELECT  DISTINCT
  NumeroOperacion  ,
  NumeroDocumento  ,
  NumeroCorrelativo ,
  Id_Sistema
 FROM LINEA_TRANSACCION
 WHERE FechaVencimiento <= @dFecPro
 OPEN cursor_TRANSACCION
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_TRANSACCION
  INTO @nNumoper ,
   @nNumdocu ,
   @nCorrela ,
   @cSistema 
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  DECLARE cursor_DETALLE SCROLL CURSOR FOR
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
  FROM LINEA_TRANSACCION_DETALLE
  WHERE  Id_Sistema  = @cSistema
  AND NumeroOperacion  = @nNumoper
  AND NumeroDocumento  = @nNumdocu
  AND NumeroCorrelativo  = @nCorrela
  OPEN cursor_DETALLE 
  WHILE (1=1)
  BEGIN
   FETCH NEXT FROM cursor_DETALLE 
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
          FROM LINEA_GENERAL
   WHERE rut_cliente  = @nRutcli 
   AND  codigo_cliente  = @nCodigo
   IF @cTipo_Movimiento = 'S'
    SELECT @nMontoTransaccion = @nMontoTransaccion * (-1)
   IF @cTipo_Detalle = 'L' AND @cActualizo_Linea = 'S'
   BEGIN
    IF @cTranssaccion = 'MATRIZ'
    BEGIN
     UPDATE LINEA_AFILIADO
     SET totalocupado  = totalocupado        + @nMontoTransaccion
     WHERE rutcasamatriz   = @nRutcasamatriz
     AND  codigocasamatriz = @nCodigocasamatriz
    END
    IF @cTranssaccion = 'MAT_SR'
    BEGIN
     UPDATE LINEA_AFILIADO
     SET Sinriesgoocupado = Sinriesgoocupado    + @nMontoTransaccion
     WHERE rutcasamatriz   = @nRutcasamatriz
     AND  codigocasamatriz = @nCodigocasamatriz
    END
    IF @cTranssaccion = 'MAT_CR'
    BEGIN
     UPDATE LINEA_AFILIADO
     SET Conriesgoocupado = Conriesgoocupado    + @nMontoTransaccion
     WHERE rutcasamatriz   = @nRutcasamatriz
     AND  codigocasamatriz = @nCodigocasamatriz
    END
  
    IF @cTranssaccion = 'LINGEN'
    BEGIN
     UPDATE LINEA_GENERAL
     SET totalocupado = totalocupado  + @nMontoTransaccion
     WHERE rut_cliente = @nRutcli
     AND codigo_cliente = @nCodigo
    END
    IF @cTranssaccion = 'LINSIS'
    BEGIN
     UPDATE LINEA_SISTEMA
     SET totalocupado = totalocupado  + @nMontoTransaccion
     WHERE rut_cliente = @nRutcli
     AND codigo_cliente = @nCodigo
     AND id_sistema = @cSistema
    END
    IF @cTranssaccion = 'LINPZO'
    BEGIN
     UPDATE LINEA_POR_PLAZO
     SET totalocupado = totalocupado  + @nMontoTransaccion
     WHERE rut_cliente = @nRutcli
     AND codigo_cliente = @nCodigo
     AND id_sistema = @cSistema
     AND plazodesde     <= @nPlazoDesde
    END
   END
  END
  CLOSE cursor_DETALLE
  DEALLOCATE cursor_DETALLE
  DELETE LINEA_TRANSACCION_DETALLE
  WHERE  Id_Sistema  = @cSistema
  AND NumeroOperacion  = @nNumoper
  AND NumeroDocumento  = @nNumdocu
  AND NumeroCorrelativo  = @nCorrela
 END
 CLOSE cursor_TRANSACCION
 DEALLOCATE cursor_TRANSACCION
 DELETE LINEA_TRANSACCION
 WHERE FechaVencimiento <= @dFecPro
 EXECUTE SP_LINEAS_ACTUALIZA
 SET NOCOUNT OFF
END
-- select * from LINEA_TRANSACCION
-- select * from LINEA_TRASPASO
-- Sp_Lineas_Vencimientos '20010801'
-- Sp_Lineas_Vencimientos '20030801'
GO
