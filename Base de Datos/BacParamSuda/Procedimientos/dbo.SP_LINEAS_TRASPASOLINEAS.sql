USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_TRASPASOLINEAS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_TRASPASOLINEAS] ( @dFecPro  DATETIME ,
      @cSistema CHAR (03) ,
      @cGloProd CHAR (50) ,
      @nRutcli NUMERIC (09,0) ,
      @nCodigo NUMERIC (09,0) ,
      @nNumoper NUMERIC (10,0) ,
      @nNumdocu NUMERIC (10,0) ,
      @nCorrela NUMERIC (10,0) ,
      @cSistemaTras CHAR (03) ,
      @nMonto  NUMERIC (19,4) ,
      @dFeciniop DATETIME ,
      @dFecvctop DATETIME ,
      @cUsuario CHAR (15) ,
      @cUsuAutori CHAR (15)
)
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nNumTras  NUMERIC(09,0) ,
  @ccontrolaplazo CHAR(01) ,
  @cProducto  CHAR(05)
 SELECT @cProducto = codigo_producto
 FROM PRODUCTO
 WHERE descripcion = @cGloProd
 SELECT  @nNumTras = MAX(numerotraspaso)
 FROM LINEA_TRASPASO
 SELECT  @nNumTras = ISNULL(@nNumTras,0)+1
 INSERT INTO LINEA_TRASPASO (
  NumeroTraspaso,
  NumeroOperacion,
  NumeroDocumento,
  NumeroCorrelativo,
  Rut_Cliente,
  Codigo_Cliente,
  Id_Sistema,
  Codigo_Producto,
  SistemaRecibio,
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
  @cSistemaTras ,
  @cProducto ,
  @cSistema ,
  ''  , -- tipooperacion
  @dFeciniop ,
  @dFecvctop ,
  @cUsuario ,
  @nMonto  ,
  @cUsuAutori ,
  'S'  ,
  CONVERT(CHAR(10),GETDATE(),108)
    )
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
  AND plazodesde  <=DATEDIFF(day, @dFecPro, @dFecvctop)
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
  AND plazodesde  <=DATEDIFF(day, @dFecPro, @dFecvctop)
 END
 EXECUTE SP_LINEAS_ACTUALIZA
 SET NOCOUNT OFF
END
-- sp_help producto
-- select * from producto
-- sp_help LINEA_TRASPASO
GO
