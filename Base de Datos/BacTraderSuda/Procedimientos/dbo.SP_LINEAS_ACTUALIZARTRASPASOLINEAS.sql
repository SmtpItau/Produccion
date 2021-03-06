USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ACTUALIZARTRASPASOLINEAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_ACTUALIZARTRASPASOLINEAS] ( @dFecPro  DATETIME ,
      @cSistema CHAR (03) ,  --recibido
      @cProducto  CHAR(05) ,
      @nRutcli NUMERIC (09,0) ,
      @nCodigo NUMERIC (09,0) ,
      @nNumoper NUMERIC (10,0) ,
      @nNumdocu NUMERIC (10,0) ,
      @nCorrela NUMERIC (10,0) ,
      @cSistemaTras CHAR (03) ,  --traspasado
      @nMonto  NUMERIC (19,4) ,
      @dFeciniop DATETIME ,
      @dFecvctop DATETIME ,
      @cUsuario CHAR (10) ,
      @cUsuAutori CHAR (10)
)
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nNumTras  NUMERIC(09,0) ,
  @ccontrolaplazo CHAR(01) 
--  @cProducto  CHAR(05)
 SELECT  @nNumTras = MAX(numerotraspaso)
 FROM VIEW_LINEA_TRASPASO
 SELECT  @nNumTras = ISNULL(@nNumTras,0)+1
 INSERT INTO VIEW_LINEA_TRASPASO (
  NumeroTraspaso,
  NumeroOperacion,
  NumeroDocumento,
  NumeroCorrelativo,
  Rut_Cliente,
  Codigo_Cliente,
  Id_Sistema,  --traspasado
  Codigo_Producto,
  SistemaRecibio,  --recibido
  TipoOperacion,
  FechaInicio,
  FechaVencimiento,
  Operador,
  MontoTraspasado,
  UsuarioAutorizo,
  Activo,
  Hora_Traspaso)
 VALUES( @nNumTras ,
  @nNumoper ,
  @nNumdocu ,
  @nCorrela ,
  @nRutcli ,
  @nCodigo ,
  @cSistemaTras , --traspasado
  @cProducto ,
  @cSistema , --recibido
  ''  , -- tipooperacion
  @dFeciniop ,
  @dFecvctop ,
  @cUsuario ,
  @nMonto  ,
  @cUsuAutori ,
  'S'  ,
  CONVERT(CHAR(10),GETDATE(),108)
    )
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
 EXECUTE SP_LINEAS_ACTUALIZA
 SET NOCOUNT OFF
END
-- sp_help producto
-- select * from VIEW_LINEA_TRASPASO
-- drop view VIEW_LINEA_TRASPASO
-- create view  VIEW_LINEA_TRASPASO as select * from bacparamsuda..LINEA_TRASPASO

GO
