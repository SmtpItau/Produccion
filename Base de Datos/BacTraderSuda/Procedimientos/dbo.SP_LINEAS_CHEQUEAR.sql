USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CHEQUEAR]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_CHEQUEAR]
    (
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nNumoper NUMERIC(10) ,
    @cTipoper  Char(01) ,
    @cValidaCheque Char(01) ,
    @nMercadoLocal Char(01)
    )
AS
BEGIN
 SET NOCOUNT ON
 SELECT @cProducto = LTRIM(RTRIM(@cProducto))
 DECLARE @cCheckEmi  CHAR(1),
  @cCheckChq  CHAR(1),
  @cCheckCli  CHAR(1)
 DECLARE @cCheckLimOPER  CHAR(1),
  @cCheckLimInst  CHAR(1)
 DECLARE @dFecPro  DATETIME ,
  @nRutcli  NUMERIC (09,0) ,
  @nCodigo  NUMERIC (09,0) ,
  @dFecvctop  DATETIME ,
  @cUsuario  CHAR (15) ,
  @nMonto   NUMERIC (19,4) ,
  @cTipo_Riesgo  CHAR (1) ,
  @nNumdocu  NUMERIC (10,0) ,
  @nCorrela  NUMERIC (10,0) ,
  @dFeciniop  DATETIME ,
  @fTipcambio  NUMERIC (19,4) ,
  @nMonedaOp  NUMERIC (05,00) ,
  @nInCodigo  NUMERIC (05,0) ,
  @nFactor  NUMERIC (19,8)
 CREATE TABLE #temp1( mensaje CHAR(255) )
 --************************************************
 --************************************************
 --**********                     *****************
 --**********CHEQUEA OTRAS LINEAS *****************
 --**********                     *****************
 --************************************************
 --************************************************
/*
 --********** INVERSION TOTAL POR INSTRUMENTO *****************
 IF @cSistema = 'BTR' AND ( @cProducto = 'CP' OR @cProducto = 'CI' )
 BEGIN
  EXECUTE SP_LINEA_CHEQUEAR_INVERSION_INSTRUMENTO @cSistema, @cProducto, @nNumoper
 END
 --********** INVERSION TOTAL GLOBAL *****************
 IF @cSistema = 'BTR' AND ( @cProducto = 'CP' OR @cProducto = 'CI' )
 BEGIN
  EXECUTE SP_LINEA_CHEQUEAR_INVERSION_GLOBAL @cSistema, @cProducto, @nNumoper
 END
*/
/*
 --********** RIESGO PAIS *****************
 IF @cSistema = 'BCC'
 BEGIN
  EXECUTE SP_LINEA_CHEQUEAR_RIESGO_PAIS @cSistema, @cProducto, @nNumoper
 END
*/
/*
 --********** INVERSION EXTERIOR *****************
 IF ( @cSistema = 'BCC' AND @cProducto = 'ARBI' ) OR ( @cSistema = 'BFW' AND @cProducto = '1' )
 BEGIN
  EXECUTE SP_LINEA_CHEQUEAR_INVERSION_EXTERIOR @cSistema, @cProducto, @nNumoper
 END
*/
 --************************************************
 --************************************************
 --**********                     *****************
 --**********    CHEQUEA LINEAS   *****************
 --**********                     *****************
 --************************************************
 --************************************************
 SELECT @cCheckCli = 'S',
  @cCheckEmi = 'N',
  @cCheckChq = 'N'
 IF @cSistema = 'BTR' AND @cProducto = 'CP'
  SELECT @cCheckCli = 'N', @cCheckEmi = 'S',@cCheckChq = 'N'
 IF @cSistema = 'BTR' AND ( @cProducto = 'VI' OR @cProducto = 'VP' )
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'
 IF @cSistema = 'BTR' AND ( @cProducto = 'ICAP' )
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N', @cCheckChq = 'N'
 IF @cSistema = 'BTR' AND ( @cProducto = 'RCA' OR @cProducto = 'RVA' )
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N', @cCheckChq = 'N'
 IF @cSistema = 'BCC' 
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'
 IF @cSistema = 'BCC' AND ( @cProducto = 'PTAS' OR @cProducto = 'EMPR' ) AND @cTipoper = 'C'
  SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'
 IF @cSistema = 'BCC' AND ( @cProducto = 'EMPR' ) AND @cTipoper = 'C' AND @cValidaCheque = 'S'
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'S'
 IF @cSistema = 'BFW' 
  SELECT @cCheckCli = 'N', @cCheckEmi = 'N',@cCheckChq = 'N'
 IF @cSistema = 'BFW' AND ( @cProducto = '1' OR @cProducto = '2'  OR @cProducto = '3'  OR @cProducto = '7' ) AND @nMercadoLocal = 'S'
  SELECT @cCheckCli = 'S', @cCheckEmi = 'N',@cCheckChq = 'N'
 --********** CHEQUEA LINEA EMISOR *****************
 IF @cCheckEmi = 'S'
 BEGIN
  DECLARE Cursor_LINEAS SCROLL CURSOR FOR
  SELECT FechaOperacion  ,
   Rut_Emisor  ,
   cod_Emisor  ,
   FechaVencimiento ,
   SUM(MontoTransaccion) ,
   Tipo_Riesgo
  FROM VIEW_LINEA_CHEQUEAR
  WHERE NumeroOperacion = @nNumoper
  AND Id_Sistema = @cSistema
  AND Rut_Emisor     <> 97029000
  AND Rut_Emisor     <> 97018000
  GROUP BY
   FechaOperacion  ,
   Rut_Emisor  ,
   cod_Emisor  ,
   FechaVencimiento ,
   Tipo_Riesgo
  OPEN Cursor_LINEAS
  WHILE (1=1)
  BEGIN
   FETCH NEXT FROM Cursor_LINEAS
   INTO @dFecPro ,
    @nRutcli ,
    @nCodigo ,
    @dFecvctop ,
    @nMonto  ,
    @cTipo_Riesgo 
    IF (@@fetch_status <> 0)
    BEGIN
     BREAK
    END
    EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cSistema, @dFecPro, @nRutcli, @nCodigo, @dFecvctop, @nMonto, @cTipo_Riesgo
  END
  CLOSE Cursor_LINEAS
  DEALLOCATE Cursor_LINEAS
 END
 --********** CHEQUEA LINEA CLIENTE *****************
 IF @cCheckCli = 'S'
 BEGIN
  DECLARE Cursor_LINEAS SCROLL CURSOR FOR
  SELECT FechaOperacion  ,
   Rut_Cliente  ,
   Codigo_Cliente  ,
   FechaVencimiento ,
   SUM(MontoTransaccion) ,
   Tipo_Riesgo
  FROM VIEW_LINEA_CHEQUEAR
  WHERE NumeroOperacion = @nNumoper
  AND Id_Sistema = @cSistema
  GROUP BY
   FechaOperacion  ,
   Rut_Cliente  ,
   Codigo_Cliente  ,
   FechaVencimiento ,
   Tipo_Riesgo
  OPEN Cursor_LINEAS
  WHILE (1=1)
  BEGIN
   FETCH NEXT FROM Cursor_LINEAS
   INTO @dFecPro ,
    @nRutcli ,
    @nCodigo ,
    @dFecvctop ,
    @nMonto  ,
    @cTipo_Riesgo 
    IF (@@fetch_status <> 0)
    BEGIN
     BREAK
    END
    EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cSistema, @dFecPro, @nRutcli, @nCodigo, @dFecvctop, @nMonto, @cTipo_Riesgo
  END
  CLOSE Cursor_LINEAS
  DEALLOCATE Cursor_LINEAS
 END
 IF (SELECT COUNT(*) FROM #Temp1) > 0 
 BEGIN
  DELETE  VIEW_LINEA_CHEQUEAR
  WHERE NumeroOperacion = @nNumoper
  AND Id_Sistema = @cSistema
  AND Codigo_Producto = @cProducto
  SELECT * FROM #Temp1
  RETURN
 END
 SET NOCOUNT OFF
END
-- select * from mdcp
-- Sp_Checkea_Lineas 'BTR', 'CP ', 97004000, '20090101', 'ADMINISTRA'
-- select * from view_MARGEN_INVERSION_INSTRUMENTO
-- select * from view_MARGEN_INVERSION_GLOBAL
-- select * from VIEW_LINEA_GENERAL
-- select * from VIEW_LINEA_SISTEMA
-- select * from VIEW_LINEA_TRANSACCION
-- select * from VIEW_LINEA_TRANSACCION_detalle
-- select * from VIEW_LINEA_POR_PLAZO
-- select * from VIEW_LINEA_PRODUCTO
-- select * from VIEW_LINEA_AFILIADO
-- select * from VIEW_LINEA_TRASPASO
-- select * from VIEW_PRODUCTO order by id_sistema
-- select * from VIEW_CLIENTE
-- select * from VIEW_SISTEMA_CNT
-- select * from VIEW_CONTROL_FINANCIERO
-- sp_help VIEW_LINEA_SISTEMA
-- SELECT * from view_cliente
--sp_help
-- select * from  VIEW_LINEA_CHEQUEAR
-- sp_help VIEW_LINEA_CHEQUEAR


GO
