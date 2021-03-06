USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_OPACTUALIZAR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_OPACTUALIZAR] ( @dFecPro DATETIME ,
      @cSistema CHAR (03) ,
      @nNumoper NUMERIC (10,0) )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @Contador  INTEGER,
  @sw   CHAR(1)
 DECLARE @cTranssaccion  CHAR(15) ,
  @cTipo_Detalle  CHAR(1)  ,
  @cActualizo_Linea CHAR(1)  ,
  @nMontoTransaccion NUMERIC(19,4) ,
  @cTipo_Movimiento CHAR(1)  ,
  @nRutcli  NUMERIC(09,0) ,
  @nCodigo  NUMERIC(09,0) ,
  @nPlazoDesde  NUMERIC(09,0) ,
  @nPlazoHasta  NUMERIC(09,0) ,
  @cTipo_Riesgo  CHAR(1)  ,
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
 FROM LINEA_TRANSACCION_DETALLE
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
 CLOSE cursor_rev
 DEALLOCATE cursor_rev
 DELETE LINEA_TRANSACCION_DETALLE
 WHERE  Id_Sistema  = @cSistema
 AND NumeroOperacion  = @nNumoper
 EXECUTE SP_LINEAS_ACTUALIZA
 --*************************************
 --*************** 
 --*************** ACTIALIZA LINEAS
 --*************** 
 --*************************************
 DECLARE @cProducto CHAR (05) ,
  @nNumdocu NUMERIC (10,0) ,
  @nCorrela NUMERIC (10,0) ,
  @dFeciniop DATETIME ,
  @nMontoorg NUMERIC (19,4) ,
  @nMonto  NUMERIC (19,4) ,
  @fTipcambio NUMERIC (08,4) ,
  @dFecvctop DATETIME ,
  @cUsuario CHAR (10) ,
  @nMatrizriesgo NUMERIC (08,4)
 DECLARE cursor_grb SCROLL CURSOR FOR
 SELECT  Codigo_Producto  ,
  Rut_Cliente  ,
  Codigo_Cliente  ,
  NumeroDocumento  ,
  NumeroCorrelativo ,
  NumeroCorrelativo ,
  MontoOriginal  ,
  TipoCambio  ,
  FechaVencimiento ,
  Operador  ,
  MatrizRiesgo  ,
  Tipo_Riesgo
 FROM LINEA_TRANSACCION
 WHERE  Id_Sistema  = @cSistema
 AND NumeroOperacion  = @nNumoper
 OPEN cursor_grb
 WHILE (1=1)
 BEGIN
  FETCH NEXT FROM cursor_grb
  INTO @cProducto ,
   @nRutcli ,
   @nCodigo ,
   @nNumdocu ,
   @nCorrela ,
   @dFeciniop ,
   @nMonto  ,
   @fTipcambio ,
   @dFecvctop ,
   @cUsuario ,
   @nMatrizriesgo ,
   @cTipo_Riesgo
  IF (@@fetch_status <> 0)
  BEGIN
   BREAK
  END
  EXECUTE SP_LINEAS_OPACTUALIZAGRABAR @dFecPro ,
       @cSistema ,
       @cProducto ,
       @nRutcli ,
       @nCodigo ,
       @nNumoper ,
       @nNumdocu ,
       @nCorrela ,
       @dFeciniop ,
       @nMonto  ,
       @fTipcambio ,
       @dFecvctop ,
       @cUsuario ,
       @nMatrizriesgo ,
       @cTipo_Riesgo
 END
 CLOSE cursor_grb
 DEALLOCATE cursor_grb
 SET NOCOUNT OFF
END
--  select * from view_LINEA_TRANSACCION
--  r

GO
