USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_LINEAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_LINEAS]
    (
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nRutcli NUMERIC (09,0) ,
    @nCodigo NUMERIC (09,0) ,
    @nNumdocu NUMERIC (10,0) ,
    @nNumoper NUMERIC (10,0) ,
    @nCorrela NUMERIC (10,0) ,
    @dFeciniop DATETIME ,
    @nMontoorg NUMERIC (19,4) ,
    @nMontoum NUMERIC (19,4) ,
    @fTipcambio NUMERIC (08,4) ,
    @dFecvctop DATETIME ,
    @cUsuario CHAR (10)
    )
AS
BEGIN
 DECLARE @dFecPro  DATETIME
 DECLARE @cNombre CHAR(60)
 SET NOCOUNT ON
 DECLARE @nCorrDet Integer,
  @cMensaje VARCHAR(255),
  @cTipoMov   VARCHAR(1),
  @cTipoLinea  VARCHAR(1),
  @cTipoControl  VARCHAR(1),
  @cError  VARCHAR(1)
 DECLARE @iFound   INTEGER  ,
  @cCtrlplazo  CHAR (01) ,
  @cCompartido  CHAR (01) ,
  @nRutcasamatriz  NUMERIC (09,0) ,
  @nCodigocasamatriz NUMERIC (09,0) ,
  @nMatrizriesgo  NUMERIC (08,4) ,
  @nTotalasignado  NUMERIC (19,4) ,
  @nTotalocupado  NUMERIC (19,4) ,
  @nTotaldisponible NUMERIC (19,4) ,
  @nTotalexceso  NUMERIC (19,4) ,
  @nTotaltraspaso  NUMERIC (19,4) ,
  @nTotalrecibido  NUMERIC (19,4) ,
  @nSinriesgoasignado NUMERIC (19,4) ,
  @nSinriesgoocupado NUMERIC (19,4) ,
  @nSinriesgodisponible NUMERIC (19,4) ,
  @nSinriesgoexceso NUMERIC (19,4) ,
  @nConriesgoasignado NUMERIC (19,4) ,
  @nConriesgoocupado NUMERIC (19,4) ,
  @nConriesgodisponible NUMERIC (19,4) ,
  @nConriesgoexceso NUMERIC (19,4) ,
  @nMonedalin  NUMERIC (05,0) ,
  @nValmonlin  NUMERIC (10,4) ,
  @nMontolin  NUMERIC (19,4) ,
  @nPlazoDesde   NUMERIC (05,0) ,
  @nPlazoHasta  NUMERIC (05,0)  ,
  @nExceso   NUMERIC (19,4) ,
  @nDisponible  NUMERIC (19,4) ,
  @dFecvctolinea  DATETIME ,
  @cBloqueado  CHAR (01)
 SELECT @dFecPro = acfecproc FROM mdac
 IF @nCodigo = 0
  SELECT  @cNombre = clnombre,
   @nCodigo = clcodigo
  FROM  view_cliente
  WHERE clrut  = @nRutcli
 ELSE
  SELECT  @cNombre = clnombre
  FROM  view_cliente
  WHERE clrut  = @nRutcli
  AND clcodigo = @nCodigo
 SELECT  @nCorrDet  = 0,
  @cTipoMov   = 'S',   -- S.suma R.resta
  @cTipoLinea  = 'L',   -- L.linea
  @cTipoControl  = 'C'    -- C.control
 SELECT @nMonedalin = monedacontrol    ,
  @nValmonlin = valormoneda    ,
  @nMontolin = ROUND(@nMontoorg/valormoneda,4)
 FROM VIEW_CONTROL_FINANCIERO
 SELECT @iFound  = 0
/*
 SELECT @iFound   = 1    ,
  @cCtrlplazo  = LinSis.controlaplazo  ,
  @cCompartido  = LinSis.compartido  ,
  @nRutcasamatriz  = LinGen.rutcasamatriz  ,
  @nCodigocasamatriz = LinGen.codigocasamatriz ,
  @nTotalasignado  = LinSis.totalasignado  ,
  @nTotalocupado  = LinSis.totalocupado  ,
  @nTotaldisponible = LinSis.totaldisponible ,
  @nTotalexceso  = LinSis.totalexceso  ,
  @nTotaltraspaso  = LinSis.totaltraspaso  ,
  @nTotalrecibido  = LinSis.totalrecibido  ,
  @nSinriesgoasignado = LinSis.sinriesgoasignado ,
  @nSinriesgoocupado = LinSis.sinriesgoocupado ,
  @nSinriesgodisponible = LinSis.sinriesgodisponible ,
  @nSinriesgoexceso = LinSis.sinriesgoexceso ,
  @nConriesgoasignado = LinSis.conriesgoasignado ,
  @nConriesgoocupado = LinSis.conriesgoocupado ,
  @nConriesgodisponible = LinSis.conriesgodisponible ,
  @nConriesgoexceso = LinSis.conriesgoexceso ,
  @nMatrizriesgo  = 0
        FROM VIEW_LINEA_SISTEMA LinSis, VIEW_LINEA_GENERAL LinGen
 WHERE (LinSis.rut_cliente=@nRutcli AND LinSis.codigo_cliente=@nCodigo AND LinSis.id_sistema=@cSistema) AND
  (LinGen.rut_cliente=@nRutcli AND LinGen.codigo_cliente=@nCodigo)
*/
 SELECT @iFound   = 1   ,
  @nRutcasamatriz  = rutcasamatriz  ,
  @nCodigocasamatriz = codigocasamatriz ,
  @nDisponible  = totaldisponible ,
  @cBloqueado   = bloqueado  ,
  @dFecvctolinea   = fechavencimiento ,
  @nMatrizriesgo  = 0
        FROM VIEW_LINEA_GENERAL
 WHERE rut_cliente  = @nRutcli 
 AND  codigo_cliente  = @nCodigo
 IF @iFound = 1
 BEGIN
  INSERT INTO 
  VIEW_LINEA_TRANSACCION
   (
   numerodocumento  ,
   numerooperacion  ,
   numerocorrelativo ,
   rut_cliente  ,
   codigo_cliente  ,
   id_sistema  ,
   codigo_producto  ,
   tipo_operacion  ,
   tipo_riesgo  ,
   fechainicio  ,
   fechavencimiento ,
   montooriginal  ,
   tipocambio  ,
   matrizriesgo  ,
   montotransaccion ,
   operador  ,
   activo
   )
  SELECT
   @nNumdocu  ,
   @nNumoper  ,
   @nCorrela  ,
   @nRutcli  ,
   @nCodigo  ,
   @cSistema  ,
   @cProducto  ,
   ''   , --descripcion  ,
   ''   ,
   @dFeciniop  ,
   @dFecvctop  ,
   @nMontoum  ,
   @fTipcambio  ,
   @nMatrizriesgo  ,
   @nMontoorg  ,
   @cUsuario  ,
   'S'
  FROM VIEW_PRODUCTO
  WHERE @cProducto=codigo_producto
  --*************************************
  --*************** 
  --*************** LINEA GENERAL
  --*************** 
  --*************************************
  IF @cBloqueado='S'  --** Linea General Bloqueada para operar **--
  BEGIN
   SELECT  @cMensaje = 'Linea General Bloqueada Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = 0
   INSERT INTO VIEW_LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoControl  , @cTipoMov      , 'LINGEN'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  END
 
  IF @dFecPro>@dFecvctolinea
  BEGIN
   SELECT  @cMensaje = 'Linea General Vencida Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = 0
   INSERT INTO VIEW_LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoControl  , @cTipoMov      , 'LINGEN'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  END
  SELECT @nExceso = @nDisponible - @nMontolin
  SELECT @nCorrDet = @nCorrDet + 1
  UPDATE VIEW_LINEA_GENERAL
  SET totalocupado = totalocupado    + @nMontolin ,
   totaldisponible = totaldisponible - @nMontolin
  WHERE rut_cliente = @nRutcli 
  AND codigo_cliente = @nCodigo
  IF @nExceso < 0
   SELECT  @cMensaje = 'Limite General Exedido Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = @nExceso * (-1)
  ELSE
   SELECT  @cMensaje = '' ,
    @cError   = 'N' ,
    @nExceso  = 0
  INSERT INTO VIEW_LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
  SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoLinea  , @cTipoMov      , 'LINGEN'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  --*************************************
  --*************** 
  --*************** LINEA SISTEMA
  --*************** 
  --*************************************
  SELECT @nDisponible  = 0
  SELECT @cCtrlplazo = controlaplazo  ,
   @nDisponible = totaldisponible ,
   @cBloqueado  = bloqueado  ,
   @dFecvctolinea  = fechavencimiento
         FROM VIEW_LINEA_SISTEMA
  WHERE rut_cliente = @nRutcli 
  AND codigo_cliente = @nCodigo
  AND id_sistema = @cSistema
  IF @cBloqueado='S'  --** Linea Sistema Bloqueada para operar **--
  BEGIN
   SELECT  @cMensaje = 'Linea Sistema Bloqueada Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = 0
   INSERT INTO VIEW_LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoControl  , @cTipoMov      , 'LINGEN'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  END
 
  IF @dFecPro>@dFecvctolinea
  BEGIN
   SELECT  @cMensaje = 'Linea Sistema Vencida Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = 0
   INSERT INTO VIEW_LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoControl  , @cTipoMov      , 'LINGEN'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  END
  SELECT @nExceso = @nDisponible - @nMontolin
  SELECT @nCorrDet = @nCorrDet + 1
  UPDATE VIEW_LINEA_SISTEMA
  SET totalocupado = totalocupado    + @nMontolin ,
   totaldisponible = totaldisponible - @nMontolin
  WHERE rut_cliente = @nRutcli
  AND  codigo_cliente = @nCodigo
  AND  id_sistema = @cSistema
  IF @nExceso < 0
   SELECT  @cMensaje = 'Limite Sistema Exedido Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = @nExceso * (-1)
  ELSE
   SELECT  @cMensaje = '' ,
    @cError   = 'N' ,
    @nExceso  = 0
  INSERT INTO VIEW_LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
  SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoLinea  , @cTipoMov      , 'LINSIS'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  --*************************************
  --*************** 
  --*************** LINEA POR PLAZO
  --*************** 
  --*************************************
  IF @cCtrlplazo='S'
  BEGIN
   SELECT @ndisponible = 0
   SELECT @nPlazoDesde = PlazoDesde,
    @nPlazoHasta = PlazoHasta,
    @ndisponible = Totaldisponible
          FROM VIEW_LINEA_POR_PLAZO
   WHERE rut_cliente=@nRutcli
   AND codigo_cliente=@nCodigo
   AND id_sistema=@cSistema
   AND plazodesde <= DATEDIFF(day, @dFecPro, @dFecvctop)
   AND plazohasta  > DATEDIFF(day, @dFecPro, @dFecvctop)
   SELECT  @nExceso  = @nDisponible - @nMontolin
   SELECT  @nCorrDet  = @nCorrDet + 1
   UPDATE  VIEW_LINEA_POR_PLAZO
   SET  totalocupado = totalocupado    + @nMontolin ,
    totaldisponible = totaldisponible - @nMontolin
   WHERE rut_cliente=@nRutcli
   AND codigo_cliente=@nCodigo
   AND id_sistema=@cSistema
--   AND plazodesde <= DATEDIFF(day, @dFecPro, @dFecvctop)
   AND plazohasta  > DATEDIFF(day, @dFecPro, @dFecvctop)
   IF @nExceso < 0
    SELECT  @cMensaje = 'Limite Plazo desde ' + RTRIM(LTRIM((CONVERT(CHAR(06),@nplazodesde)))) + ' Hasta ' +  RTRIM(LTRIM((CONVERT(CHAR(06),@nplazohasta)))) + ' Exedido Para ' + @cNombre  ,
     @cError   = 'S'    ,
     @nExceso  = @nExceso * (-1)
   ELSE
    SELECT  @cMensaje = '' ,
     @cError   = 'N' ,
     @nExceso  = 0
   INSERT INTO VIEW_LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde  , PlazoHasta  , Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoLinea  , @cTipoMov      , 'LINPZO'      , @nMontolin      , @nExceso   , @nPlazoDesde, @nPlazoDesde, 'S'            , @cError , @cMensaje
  END
/*
  --** Linea por Producto **--
  IF EXISTS(SELECT * FROM VIEW_LINEA_PRODUCTO WHERE rut_cliente=@nRutcli AND codigo_cliente=@nCodigo AND id_sistema=@cSistema AND codigo_producto=@cProducto)
   UPDATE VIEW_LINEA_PRODUCTO
   SET totalocupado = totalocupado    + @nMontolin ,
    totaldisponible = totaldisponible - @nMontolin
   WHERE rut_cliente = @nRutcli 
   AND  codigo_cliente = @nCodigo 
   AND id_sistema = @cSistema 
   AND codigo_producto = @cProducto
  ELSE
   INSERT INTO
   VIEW_LINEA_PRODUCTO
    (
    rut_cliente   ,
    codigo_cliente   ,
    id_sistema   ,
    codigo_producto   ,
    totalasignado   ,
    totalocupado   ,
    totaldisponible   ,
    totalexceso   ,
    totaltraspaso   ,
    totalrecibido   ,
    sinriesgoasignado  ,
    sinriesgoocupado  ,
    sinriesgodisponible  ,
    sinriesgoexceso   ,
    conriesgoasignado  ,
    conriesgoocupado  ,
    conriesgodisponible  ,
    conriesgoexceso
    )
   VALUES
    (
    @nRutcli   ,
    @nCodigo   ,
    @cSistema   ,
    @cProducto   ,
    @nTotalasignado   ,
    @nTotalocupado+@nMontolin ,
    @nTotaldisponible-@nMontolin ,
    @nTotalexceso   ,
    @nTotaltraspaso   ,
    @nTotalrecibido   ,
    @nSinriesgoasignado  ,
    @nSinriesgoocupado  ,
    @nSinriesgodisponible  ,
    @nSinriesgoexceso  ,
    @nConriesgoasignado  ,
    @nConriesgoocupado  ,
    @nConriesgodisponible  ,
    @nConriesgoexceso
    )
*/
 END
 ELSE
 BEGIN
  SELECT 'NO','ERROR: No Existe Linea Definida'
  RETURN
 END
 SELECT 'SI','Lineas Actalizada'
  
 SET NOCOUNT OFF
END

GO
