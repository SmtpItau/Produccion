USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_OPACTUALIZAGRABAR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_OPACTUALIZAGRABAR]
    (
    @dFecPro  DATETIME ,
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nRutcli NUMERIC (09,0) ,
    @nCodigo NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @nNumdocu NUMERIC (10,0) ,
    @nCorrela NUMERIC (10,0) ,
    @dFeciniop DATETIME ,
    @nMonto  NUMERIC (19,4) ,
    @fTipcambio NUMERIC (08,4) ,
    @dFecvctop DATETIME ,
    @cUsuario CHAR (10) ,
    @nMatrizriesgo NUMERIC (08,4) ,
    @cTipo_Riesgo CHAR (1)
    )
AS
BEGIN
 DECLARE @cNombre CHAR(60)
 DECLARE @cNombreCMatriz CHAR(60)
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
  @nTotalasignado  NUMERIC (19,4) ,
  @nTotalocupado  NUMERIC (19,4) ,
  @nTotaldisponible NUMERIC (19,4) ,
  @nTotalexceso  NUMERIC (19,4) ,
  @nTotaltraspaso  NUMERIC (19,4) ,
  @nTotalrecibido  NUMERIC (19,4) ,
  @nMontolin  NUMERIC (19,4) ,
  @nPlazoDesde   NUMERIC (05,0) ,
  @nPlazoHasta  NUMERIC (05,0)  ,
  @nExceso   NUMERIC (19,4) ,
  @nDisponible  NUMERIC (19,4) ,
  @dFecvctolinea  DATETIME ,
  @cBloqueado  CHAR (01) ,
  @nSinriesgoasignado NUMERIC (19,4) ,
  @nSinriesgoocupado NUMERIC (19,4) ,
  @nSinriesgodisponible NUMERIC (19,4) ,
  @nSinriesgoexceso NUMERIC (19,4) ,
  @nConriesgoasignado NUMERIC (19,4) ,
  @nConriesgoocupado NUMERIC (19,4) ,
  @nConriesgodisponible NUMERIC (19,4) ,
  @nConriesgoexceso NUMERIC (19,4)
 IF @nCodigo = 0
  SELECT  @cNombre = clnombre,
   @nCodigo = clcodigo
  FROM  cliente
  WHERE clrut  = @nRutcli
 ELSE
  SELECT  @cNombre = clnombre
  FROM  cliente
  WHERE clrut  = @nRutcli
  AND clcodigo = @nCodigo
 SELECT  @nCorrDet  = 0,
  @cTipoMov   = 'S',   -- S.suma R.resta
  @cTipoLinea  = 'L',   -- L.linea
  @cTipoControl  = 'C'    -- C.control
 IF @fTipcambio > 0  SELECT @nMontolin = ROUND(@nMonto/@fTipcambio,4)
 ELSE    SELECT @nMontolin = ROUND(@nMonto,4)
-- SELECT @nMontolin = ROUND(@nMonto/valormoneda,4)
-- FROM CONTROL_FINANCIERO
 IF @nMatrizriesgo <> 0    SELECT @nMontolin = ROUND(@nMontolin/100*@nMatrizriesgo,4)
 SELECT @iFound  = 0
 SELECT @iFound   = 1   ,
  @nRutcasamatriz  = rutcasamatriz  ,
  @nCodigocasamatriz = codigocasamatriz ,
  @nDisponible  = totaldisponible ,
  @cBloqueado   = bloqueado  ,
  @dFecvctolinea   = fechavencimiento 
        FROM LINEA_GENERAL
 WHERE rut_cliente  = @nRutcli 
 AND  codigo_cliente  = @nCodigo
 IF @iFound = 1
 BEGIN
  --*************************************
  --***************
  --*************** LINEA CASA MATRIZ
  --***************
  --*************************************
  IF @nRutcasamatriz > 0
  BEGIN
   SELECT  @cNombreCMatriz = clnombre
   FROM  cliente
   WHERE clrut   = @nRutcasamatriz
   AND clcodigo  = @nCodigocasamatriz
   SELECT @iFound   = 0
   SELECT @iFound   = 1   ,
    @nDisponible  = TotalDisponible ,
    @nSinriesgodisponible  = Sinriesgodisponible ,
    @nConriesgodisponible  = Conriesgodisponible
          FROM LINEA_AFILIADO
   WHERE rutcasamatriz  = @nRutcasamatriz
   AND  codigocasamatriz= @nCodigocasamatriz
   If @nDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
   ELSE   SELECT @nExceso = @nDisponible - @nMontolin
   UPDATE LINEA_AFILIADO
   SET totalocupado = totalocupado    + @nMontolin ,
    totaldisponible = totaldisponible - @nMontolin
   WHERE rutcasamatriz  = @nRutcasamatriz
   AND  codigocasamatriz= @nCodigocasamatriz
   IF @nExceso < 0
    SELECT  @cMensaje = 'Limite Grupo Exedido Para ' + @cNombreCMatriz ,
     @cError   = 'S'       ,
     @nExceso  = @nExceso * (-1)
   ELSE
    SELECT  @cMensaje = '' ,
     @cError   = 'N' ,
     @nExceso  = 0
   SELECT @nCorrDet = @nCorrDet + 1
   INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso
, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT      @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoLinea  , @cTipoMov      , 'MATRIZ'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'  
          , @cError , @cMensaje
   --SIN RIESGO **********************
   If @nSinriesgoDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
   ELSE    SELECT @nExceso = @nSinriesgoDisponible - @nMontolin
   UPDATE VIEW_LINEA_AFILIADO
   SET Sinriesgoocupado = Sinriesgoocupado    + @nMontolin ,
    Sinriesgodisponible = Sinriesgodisponible - @nMontolin
   WHERE rutcasamatriz   = @nRutcasamatriz
   AND  codigocasamatriz = @nCodigocasamatriz
   IF @nExceso < 0
    SELECT  @cMensaje = 'Limite Grupo (Sin Riesgo) Exedido Para ' + @cNombreCMatriz ,
     @cError   = 'S'        ,
     @nExceso  = @nExceso * (-1)
   ELSE
    SELECT  @cMensaje = '' ,
     @cError   = 'N' ,
     @nExceso  = 0
   SELECT @nCorrDet = @nCorrDet + 1
   INSERT INTO VIEW_LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoLinea  , @cTipoMov      , 'MAT_SR'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
   --CON RIESGO **********************
   IF @cTipo_Riesgo = 'C'
   BEGIN
    If @nConriesgoDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
    ELSE    SELECT @nExceso = @nConriesgoDisponible - @nMontolin
    UPDATE LINEA_AFILIADO
    SET Conriesgoocupado = Conriesgoocupado    + @nMontolin ,
     Conriesgodisponible = Conriesgodisponible - @nMontolin
    WHERE rutcasamatriz   = @nRutcasamatriz
    AND  codigocasamatriz = @nCodigocasamatriz
    IF @nExceso < 0
     SELECT  @cMensaje = 'Limite Grupo (Con Riesgo) Exedido Para ' + @cNombreCMatriz ,
      @cError   = 'S'        ,
      @nExceso  = @nExceso * (-1)
    ELSE
     SELECT  @cMensaje = '' ,
      @cError   = 'N' ,
      @nExceso  = 0
    SELECT @nCorrDet = @nCorrDet + 1
    INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
    SELECT      @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoLinea  , @cTipoMov      , 'MAT_CR'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
   END
  END
  --*************************************
  --*************** 
  --*************** LINEA GENERAL
  --*************** 
  --*************************************
  IF @cBloqueado='S'  --** Linea General Bloqueada para operar **--
  BEGIN
   SELECT  @cMensaje = 'Linea General Bloqueada Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = 0    ,
    @nCorrDet = @nCorrDet + 1
   INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoControl  , @cTipoMov      , 'LINGEN'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  END
 
  IF @dFecPro>@dFecvctolinea
  BEGIN
   SELECT  @cMensaje = 'Linea General Vencida Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = 0    ,
    @nCorrDet = @nCorrDet + 1
   INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoControl  , @cTipoMov      , 'LINGEN'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  END
  If @nDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
  ELSE   SELECT @nExceso = @nDisponible - @nMontolin
  UPDATE LINEA_GENERAL
  SET totalocupado = totalocupado    + @nMontolin
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
  SELECT @nCorrDet = @nCorrDet + 1
  INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
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
         FROM LINEA_SISTEMA
  WHERE rut_cliente = @nRutcli 
  AND codigo_cliente = @nCodigo
  AND id_sistema = @cSistema
  IF @cBloqueado='S'  --** Linea Sistema Bloqueada para operar **--
  BEGIN
   SELECT  @cMensaje = 'Linea Sistema Bloqueada Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = 0    ,
    @nCorrDet = @nCorrDet + 1
   INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoControl  , @cTipoMov      , 'LINSIS'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  END
 
  IF @dFecPro>@dFecvctolinea
  BEGIN
   SELECT  @cMensaje = 'Linea Sistema Vencida Para ' + @cNombre  ,
    @cError   = 'S'    ,
    @nExceso  = 0    ,
    @nCorrDet = @nCorrDet + 1
   INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoControl  , @cTipoMov      , 'LINSIS'      , @nMontolin      , @nExceso   , 0         , 0         , 'S'            , @cError , @cMensaje
  END
  If @nDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
  ELSE   SELECT @nExceso = @nDisponible - @nMontolin
  UPDATE LINEA_SISTEMA
  SET totalocupado = totalocupado    + @nMontolin
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
  SELECT @nCorrDet = @nCorrDet + 1
  INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde, PlazoHasta, Actualizo_Linea, Error   , Mensaje_Error)
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
          FROM LINEA_POR_PLAZO
   WHERE rut_cliente=@nRutcli
   AND codigo_cliente=@nCodigo
   AND id_sistema=@cSistema
   AND plazodesde <= DATEDIFF(day, @dFecPro, @dFecvctop)
   AND plazohasta  > DATEDIFF(day, @dFecPro, @dFecvctop)
   If @nDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
   ELSE   SELECT @nExceso = @nDisponible - @nMontolin
   UPDATE  LINEA_POR_PLAZO
   SET  totalocupado = totalocupado    + @nMontolin
   WHERE rut_cliente=@nRutcli
   AND codigo_cliente=@nCodigo
   AND id_sistema=@cSistema
   AND plazodesde <= DATEDIFF(day, @dFecPro, @dFecvctop)
--   IF @nExceso < 0
--    SELECT  @cMensaje = 'Limite Plazo desde ' + RTRIM(LTRIM((CONVERT(CHAR(06),@nplazodesde)))) + ' Hasta ' +  RTRIM(LTRIM((CONVERT(CHAR(06),@nplazohasta)))) + ' Exedido Para ' + @cNombre  ,
--     @cError   = 'S'    ,
--     @nExceso  = @nExceso * (-1)
--   ELSE
    SELECT  @cMensaje = '' ,
     @cError   = 'N' ,
     @nExceso  = 0
   SELECT  @nCorrDet  = @nCorrDet + 1
   INSERT INTO LINEA_TRANSACCION_DETALLE(  NumeroOperacion, NumeroDocumento, NumeroCorrelativo, NumeroCorre_Detalle, Rut_Cliente, Codigo_Cliente, Id_Sistema, Codigo_Producto, Tipo_Detalle, Tipo_Movimiento, Linea_Transsaccion, MontoTransaccion, MontoExceso, PlazoDesde  , PlazoHasta  , Actualizo_Linea, Error   , Mensaje_Error)
   SELECT       @nNumoper      , @nNumdocu      , @nCorrela        , @nCorrDet          , @nRutcli   , @nCodigo      , @cSistema , @cProducto     , @cTipoLinea  , @cTipoMov      , 'LINPZO'      , @nMontolin      , @nExceso   , @nPlazoDesde, @nPlazoHasta, 'S'            , @cError , @cMensaje
  END
  EXECUTE SP_LINEAS_ACTUALIZA
 END
 ELSE
 BEGIN
  RETURN
 END
 SET NOCOUNT OFF
END

GO
