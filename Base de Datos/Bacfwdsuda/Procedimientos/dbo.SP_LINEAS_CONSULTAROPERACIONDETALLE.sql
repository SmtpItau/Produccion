USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CONSULTAROPERACIONDETALLE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_CONSULTAROPERACIONDETALLE]
    (
    @dFecPro  DATETIME ,
    @cSistema CHAR (03) ,
    @cProducto CHAR (05) ,
    @nRutcli NUMERIC (09,0) ,
    @nCodigo NUMERIC (09,0) ,
    @dFeciniop DATETIME ,
    @nMonto  NUMERIC (19,4) ,
    @fTipcambio NUMERIC (08,4) ,
    @dFecvctop DATETIME ,
    @cUsuario CHAR (15) ,
    @cMonedaOp NUMERIC (05,00) ,
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
  @cBloqueado  CHAR (01) ,
  @nMontLimIni  NUMERIC (19,4) ,
  @nMontLimVen  NUMERIC (19,4)
  
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
 IF @fTipcambio > 0  SELECT @nMontolin = ROUND(@nMonto/@fTipcambio,4)
 ELSE    SELECT @nMontolin = ROUND(@nMonto,4)
 SELECT @nMatrizriesgo = 0
 IF @cSistema  = 'BFW'
 BEGIN
  SELECT @iFound  = 0
  SELECT @iFound   = 1  ,
   @nMatrizriesgo  = porcentaje
  FROM VIEW_MATRIZ_RIESGO_CLIENTE
  WHERE rut_cliente  = @nRutcli
  AND  codigo_cliente  = @nCodigo
  AND codigo_producto  = @cProducto
  AND moneda    = @cMonedaOp
  AND diasdesde         <= DATEDIFF(day, @dFecPro, @dFecvctop)
  AND diashasta    > DATEDIFF(day, @dFecPro, @dFecvctop)
  IF @iFound = 0
  BEGIN
   SELECT @iFound  = 0
   SELECT @iFound   = 1  ,
    @nMatrizriesgo  = porcentaje
   FROM VIEW_MATRIZ_RIESGO
   WHERE codigo_producto  = @cProducto
   AND moneda    = @cMonedaOp
   AND diasdesde         <= DATEDIFF(day, @dFecPro, @dFecvctop)
   AND diashasta    > DATEDIFF(day, @dFecPro, @dFecvctop)
  END
  IF @nMatrizriesgo > 0 SELECT @nMontolin = ROUND(@nMontolin/100*@nMatrizriesgo,4)
 END
 SELECT @iFound  = 0
 SELECT @iFound   = 1   ,
  @nRutcasamatriz  = rutcasamatriz  ,
  @nCodigocasamatriz = codigocasamatriz ,
  @nDisponible  = totaldisponible ,
  @cBloqueado   = bloqueado  ,
  @dFecvctolinea   = fechavencimiento
        FROM VIEW_LINEA_GENERAL
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
   FROM  view_cliente
   WHERE clrut   = @nRutcasamatriz
   AND clcodigo  = @nCodigocasamatriz
   SELECT @iFound   = 0
   SELECT @iFound   = 1   ,
    @nDisponible  = TotalDisponible ,
    @nSinriesgodisponible  = Sinriesgodisponible ,
    @nConriesgodisponible  = Conriesgodisponible
          FROM VIEW_LINEA_AFILIADO
   WHERE rutcasamatriz  = @nRutcasamatriz
   AND  codigocasamatriz= @nCodigocasamatriz
   --LINEA TOTAL **********************
   If @nDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
   ELSE   SELECT @nExceso = @nDisponible - @nMontolin
   IF @nExceso < 0
    SELECT  @cMensaje = 'Limite Grupo Exedido Para ' + @cNombreCMatriz ,
     @cError   = 'S'       ,
     @nExceso  = @nExceso * (-1)
   ELSE
    SELECT  @cMensaje = '' ,
     @cError   = 'N' ,
     @nExceso  = 0
   SELECT @nCorrDet = @nCorrDet + 1
   IF @cError   = 'S' INSERT INTO #Tmp_Error
      SELECT 'LIN'  ,
       @nCorrDet ,
       @cMensaje ,
       @nExceso
   --SIN RIESGO **********************
   If @nSinriesgoDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
   ELSE    SELECT @nExceso = @nSinriesgoDisponible - @nMontolin
   IF @nExceso < 0
    SELECT  @cMensaje = 'Limite Grupo (Sin Riesgo) Exedido Para ' + @cNombreCMatriz ,
     @cError   = 'S'        ,
     @nExceso  = @nExceso * (-1)
   ELSE
    SELECT  @cMensaje = '' ,
     @cError   = 'N' ,
     @nExceso  = 0
   SELECT @nCorrDet = @nCorrDet + 1
   IF @cError   = 'S' INSERT INTO #Tmp_Error
      SELECT 'LIN'  ,
       @nCorrDet ,
       @cMensaje ,
       @nExceso
   --CON RIESGO **********************
   IF @cTipo_Riesgo = 'C'
   BEGIN
    If @nConriesgoDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
    ELSE    SELECT @nExceso = @nConriesgoDisponible - @nMontolin
    IF @nExceso < 0
     SELECT  @cMensaje = 'Limite Grupo (Con Riesgo) Exedido Para ' + @cNombreCMatriz ,
      @cError   = 'S'        ,
      @nExceso  = @nExceso * (-1)
    ELSE
     SELECT  @cMensaje = '' ,
      @cError   = 'N' ,
      @nExceso  = 0
    SELECT @nCorrDet = @nCorrDet + 1
    IF @cError   = 'S' INSERT INTO #Tmp_Error
       SELECT 'LIN'  ,
        @nCorrDet ,
        @cMensaje ,
        @nExceso
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
    @cError   = 'S'      ,
    @nExceso  = 0      ,
    @nCorrDet = @nCorrDet + 1
   IF @cError   = 'S' INSERT INTO #Tmp_Error
      SELECT 'LIN'  ,
       @nCorrDet ,
       @cMensaje ,
       @nExceso
  END
 
  IF @dFecPro>@dFecvctolinea
  BEGIN
   SELECT  @cMensaje = 'Linea General Vencida Para ' + @cNombre  ,
    @cError   = 'S'      ,
    @nExceso  = 0      ,
    @nCorrDet = @nCorrDet + 1
   IF @cError   = 'S' INSERT INTO #Tmp_Error
      SELECT 'LIN'  ,
       @nCorrDet ,
       @cMensaje ,
       @nExceso
  END
  If @nDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
  ELSE   SELECT @nExceso = @nDisponible - @nMontolin
  IF @nExceso < 0
   SELECT  @cMensaje = 'Limite General Exedido Para ' + @cNombre  ,
    @cError   = 'S'      ,
    @nExceso  = @nExceso * (-1)
  ELSE
   SELECT  @cMensaje = '' ,
    @cError   = 'N' ,
    @nExceso  = 0
  SELECT @nCorrDet = @nCorrDet + 1
  IF @cError   = 'S' INSERT INTO #Tmp_Error
     SELECT 'LIN'  ,
      @nCorrDet ,
      @cMensaje ,
      @nExceso
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
    @cError   = 'S'      ,
    @nExceso  = 0      ,
    @nCorrDet = @nCorrDet + 1
   IF @cError   = 'S' INSERT INTO #Tmp_Error
      SELECT 'LIN'  ,
       @nCorrDet ,
       @cMensaje ,
       @nExceso
  END
 
  IF @dFecPro>@dFecvctolinea
  BEGIN
   SELECT  @cMensaje = 'Linea Sistema Vencida Para ' + @cNombre  ,
    @cError   = 'S'      ,
    @nExceso  = 0      ,
    @nCorrDet = @nCorrDet + 1
   IF @cError   = 'S' INSERT INTO #Tmp_Error
      SELECT 'LIN'  ,
       @nCorrDet ,
       @cMensaje ,
       @nExceso
  END
  If @nDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
  ELSE   SELECT @nExceso = @nDisponible - @nMontolin
  IF @nExceso < 0
   SELECT  @cMensaje = 'Limite Sistema Exedido Para ' + @cNombre  ,
    @cError   = 'S'      ,
    @nExceso  = @nExceso * (-1)
  ELSE
   SELECT  @cMensaje = '' ,
    @cError   = 'N' ,
    @nExceso  = 0
  SELECT @nCorrDet = @nCorrDet + 1
  IF @cError   = 'S' INSERT INTO #Tmp_Error
     SELECT 'LIN'  ,
      @nCorrDet ,
      @cMensaje ,
      @nExceso
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
   If @nDisponible < 0 SELECT @nExceso = @nMontolin * (-1)
   ELSE   SELECT @nExceso = @nDisponible - @nMontolin
   SELECT  @nCorrDet  = @nCorrDet + 1
   IF @cError   = 'S' INSERT INTO #Tmp_Error
      SELECT 'LIN'  ,
       @nCorrDet ,
       @cMensaje ,
       @nExceso
  END
 END
 ELSE
 BEGIN
  RETURN
 END
  
 SET NOCOUNT OFF
END
-- select * from VIEW_CONTROL_FINANCIERO
-- select * from control_financiero
-- select * from moneda
-- select * from VIEW_LINEA_AFILIADO
-- select * from VIEW_LINEA_TRANSACCION_detalle
-- sp_help VIEW_LINEA_TRANSACCION_detalle
-- select * from VIEW_MATRIZ_ATRIBUCION
-- select * from VIEW_MATRIZ_ATRIBUCION_INSTRUMENTO
-- update control_financiero set monedacontrol=999,valormoneda=1
-- select * from VIEW_MATRIZ_RIESGO
-- select * from VIEW_MATRIZ_RIESGO_CLIENTE

GO
