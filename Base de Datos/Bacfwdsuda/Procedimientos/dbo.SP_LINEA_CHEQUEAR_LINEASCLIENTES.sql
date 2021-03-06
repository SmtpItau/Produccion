USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_LINEASCLIENTES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_LINEASCLIENTES](
       @cSistema CHAR(03) ,
       @dFecPro DATETIME ,
       @nRutcli NUMERIC (09,0) ,
       @nCodigo NUMERIC (09,0) ,
       @dFecvctop DATETIME ,
       @nMonto  NUMERIC (19,4) ,
       @cTipo_Riesgo CHAR (1) )
AS
BEGIN
 DECLARE @cNombre  CHAR(60)
 DECLARE @cNombreCMatriz CHAR(60)
 DECLARE @iFound    INT  ,
  @nRutcasamatriz NUMERIC (09,0) ,
  @nCodigocasamatriz NUMERIC (09,0) ,
  @cCtrlplazo  CHAR (01) ,
  @nTotalDisponible NUMERIC (19,4) ,
  @nTotalOcu  NUMERIC (19,4) ,
  @nSinriesgoOcup  NUMERIC (19,4) ,
  @nConriesgoOcup  NUMERIC (19,4) ,
  @nMontoconriesgo NUMERIC (19,4) ,
  @nMontosinriesgo NUMERIC (19,4)
 IF @nCodigo = 0   -- Generalmente cuando se envia a Chequear un emisor
  SELECT  @nCodigo = clcodigo
  FROM   view_cliente
  WHERE  clrut  = @nRutcli
  SELECT  @cNombre = clnombre
  FROM   view_cliente
  WHERE  clrut  = @nRutcli
   AND clcodigo = @nCodigo
 --*************** LINEA GENERAL
 SELECT  @iFound   = 0
 SELECT  @iFound   = 1   ,
  @nRutcasamatriz  = rutcasamatriz  ,
  @nCodigocasamatriz = codigocasamatriz
 FROM  VIEW_LINEA_GENERAL
 WHERE  rut_cliente  = @nRutcli
  AND  codigo_cliente  = @nCodigo
 IF @iFound = 1
  BEGIN
  --*************** LINEA CASA MATRIZ
   IF @nRutcasamatriz > 0
    BEGIN
     SELECT  @cNombreCMatriz = clnombre
     FROM   view_cliente
     WHERE  clrut   = @nRutcasamatriz
      AND clcodigo  = @nCodigocasamatriz
     SELECT  @iFound   = 0
     SELECT  @iFound   = 1    ,
      @nTotalOcu  = TotalOcupado + @nMonto ,
      @nSinriesgoOcup   = SinriesgoOcupado + @nMonto ,
      @nConriesgoOcup   = ConriesgoOcupado + @nMonto
     FROM  VIEW_LINEA_AFILIADO
     WHERE  rutcasamatriz  = @nRutcasamatriz
      AND  codigocasamatriz= @nCodigocasamatriz
     IF @iFound = 0
      INSERT INTO #TEMP1 SELECT 'No Existe Linea Para Filiales de ' + @cNombreCMatriz
     IF @nTotalOcu > @nMontosinriesgo
      INSERT INTO #TEMP1 SELECT 'Monto Sobrepasa Porcentaje Cartera para Filiales de ' + @cNombreCMatriz
     IF @nSinriesgoOcup > @nMontosinriesgo
      INSERT INTO #TEMP1 SELECT 'Monto Sobrepasa Porcentaje Cartera Sin Riesgo para Filiales de ' + @cNombreCMatriz
     IF @cTipo_Riesgo = 'C'
     IF @nConriesgoOcup > @nMontoConriesgo
      INSERT INTO #TEMP1 SELECT 'Monto Sobrepasa Porcentaje Cartera Con Riesgo para Filiales de ' + @cNombreCMatriz
    END
     --*************** LINEA SISTEMA
   SELECT  @iFound = 0
   SELECT  @iFound  = 1  ,
    @cCtrlplazo = controlaplazo
   FROM  VIEW_LINEA_SISTEMA
   WHERE  rut_cliente = @nRutcli 
    AND codigo_cliente = @nCodigo
    AND id_sistema = @cSistema
   IF @iFound = 0
    BEGIN
     INSERT INTO VIEW_LINEA_SISTEMA( Rut_Cliente  ,
         Codigo_Cliente  ,
         Id_Sistema  ,
         FechaAsignacion  ,
         FechaVencimiento ,
         FechaFinContrato ,
         RealizaTraspaso  ,
         Bloqueado  ,
         Compartido  ,
         ControlaPlazo  ,
         TotalAsignado  ,
         TotalOcupado  ,
         TotalDisponible  ,
         TotalExceso  ,
         TotalTraspaso  ,
         TotalRecibido  ,
         SinRiesgoAsignado ,
         SinRiesgoOcupado ,
         SinRiesgoDisponible ,
         SinRiesgoExceso  ,
         ConRiesgoAsignado ,
         ConRiesgoOcupado ,
         ConRiesgoDisponible ,
         ConRiesgoExceso  )
     SELECT  @nRutcli  ,
      @nCodigo  ,
      @cSistema  ,
      @dFecPro  ,
      @dFecPro  ,
      @dFecPro  ,
      'S'   ,
      'N'   ,
      'N'   ,
      'N'   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0   ,
      0 
    END
  END
 ELSE
  BEGIN
   INSERT INTO VIEW_LINEA_GENERAL( Rut_Cliente  ,
       Codigo_Cliente  ,
       FechaAsignacion  ,
       FechaVencimiento ,
       FechaFinContrato ,
       Bloqueado  ,
       TotalAsignado  ,
       TotalOcupado  ,
       TotalDisponible  ,
       TotalExceso  ,
       TotalTraspaso  ,
       TotalRecibido  ,
       RutCasaMatriz  ,
       CodigoCasaMatriz ,
       remuneracion_linea )
   SELECT  @nRutcli  ,
    @nCodigo  ,
    @dFecPro  ,
    @dFecPro  ,
    @dFecPro  ,
    'S'   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   
   INSERT INTO VIEW_LINEA_SISTEMA( Rut_Cliente  ,
       Codigo_Cliente  ,
       Id_Sistema  ,
       FechaAsignacion  ,
       FechaVencimiento ,
       FechaFinContrato ,
       RealizaTraspaso  ,
       Bloqueado  ,
       Compartido  ,
       ControlaPlazo  ,
       TotalAsignado  ,
       TotalOcupado  ,
       TotalDisponible  ,
       TotalExceso  ,
       TotalTraspaso  ,
       TotalRecibido  ,
       SinRiesgoAsignado ,
       SinRiesgoOcupado ,
       SinRiesgoDisponible ,
       SinRiesgoExceso  ,
       ConRiesgoAsignado ,
       ConRiesgoOcupado ,
       ConRiesgoDisponible ,
       ConRiesgoExceso  )
   SELECT  @nRutcli  ,
    @nCodigo  ,
    @cSistema  ,
    @dFecPro  ,
    @dFecPro  ,
    @dFecPro  ,
    'S'   ,
    'N'   ,
    'N'   ,
    'N'   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,
    0   ,   
    0
  END
END

GO
