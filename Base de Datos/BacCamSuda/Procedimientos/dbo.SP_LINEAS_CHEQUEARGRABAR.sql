USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CHEQUEARGRABAR]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_CHEQUEARGRABAR]
    (
    @dFecPro DATETIME ,
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nNumoper NUMERIC(10) ,
    @nNumdocu NUMERIC (10,0) ,
    @nCorrela NUMERIC (10,0) ,
    @nRutcli NUMERIC (09,0) ,
    @nCodigo NUMERIC (09,0) ,
    @nMonto  NUMERIC (19,4) ,
    @fTipcambio NUMERIC (08,4) ,
    @dFecvctop DATETIME ,
    @cUsuario CHAR (15) ,
    @nRut_emisor NUMERIC(9) ,
    @nMonedaEmision NUMERIC(3) ,
    @dFecvctoInst DATETIME ,
    @nInCodigo NUMERIC(05) ,
    @cSeriado CHAR(1)  ,
    @nMonedaOp NUMERIC(05) ,
    @cTipo_Riesgo CHAR (1) ,
    @nCodigo_pais NUMERIC(05) ,
    @cPagoCheque CHAR (1) ,
    @nRutCheque NUMERIC (09,0) ,
    @dFecvctoCehque DATETIME ,
    @nFactorVenta NUMERIC (19,8)
    )
AS
BEGIN
 INSERT INTO VIEW_LINEA_CHEQUEAR(
  FechaOperacion  ,
  NumeroOperacion  ,
  Numerodocumento  ,
  NumeroCorrelativo ,
  Rut_Cliente  ,
  Codigo_Cliente  ,
  Id_Sistema  ,
  Codigo_Producto  ,
  MontoTransaccion ,
  TipoCambio  ,
  FechaVencimiento ,
  Operador  ,
  Rut_Emisor  ,
  Moneda_Emision  ,
  FechaVctoInst  ,
  InCodigo  ,
  Seriado   ,
  MonedaOperacion  ,
  Tipo_Riesgo  ,
  codigo_pais  ,
  Pago_Cheque  ,
  Rut_Cheque  ,
  FechaVctoCheque  ,
  FactorVenta  )
 SELECT  @dFecPro  ,
  @nNumoper  ,
  @nNumdocu  ,
  @nCorrela  ,
  @nRutcli  ,
  @nCodigo  ,
  @cSistema  ,
  @cProducto  ,
  @nMonto   ,
  @fTipcambio  ,
  @dFecvctop  ,
  @cUsuario  ,
  @nRut_emisor  ,
  @nMonedaEmision  ,
  @dFecvctoInst  ,
  @nInCodigo  ,
  @cSeriado  ,
  @nMonedaOp  ,
  @cTipo_Riesgo  ,
  @nCodigo_pais  ,
  @cPagoCheque  ,
  @nRutCheque  ,
  @dFecvctoCehque  ,
  @nFactorVenta
END

GO
