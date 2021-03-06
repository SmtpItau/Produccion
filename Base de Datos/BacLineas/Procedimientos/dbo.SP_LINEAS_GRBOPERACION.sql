USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_GRBOPERACION]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_GRBOPERACION]
   (   @cSistema CHAR(03)    
   ,   @cProducto CHAR(05)    
   ,   @nNumPantalla NUMERIC(10)
   ,   @nNumoper NUMERIC(10)    
   ,   @cTipoper CHAR(01)    
   ,   @cValidaCheque CHAR(01)    
   ,   @nMercadoLocal CHAR(01)    
   ,   @nContraMoneda NUMERIC(03) = 0    
   ,   @nMonedaOpera NUMERIC(03) = 0    
   ,   @SwithEjecucion  INTEGER     = 1 --> 0 = Normal ; 1 = Inicio de Día    
   )    
AS    
BEGIN    
  
   SET NOCOUNT ON    
    
   SET @cProducto = LTRIM(RTRIM(@cProducto))    
    
   DECLARE @cCheckEmi            CHAR(1)    
   DECLARE @cCheckChq            CHAR(1)    
   DECLARE @cCheckCli            CHAR(1)    
   DECLARE @cCheckLimOPER        CHAR(1)    
   DECLARE @cCheckLimInst        CHAR(1)    
   DECLARE @dFecPro              DATETIME    
   DECLARE @nRutcli              NUMERIC(09,0)    
   DECLARE @nCodigo              NUMERIC(09,0)    
   DECLARE @dFecvctop            DATETIME    
   DECLARE @cUsuario             CHAR(15)    
   DECLARE @nMonto               NUMERIC(19,4)    
   DECLARE @cTipo_Riesgo         CHAR(1)    
   DECLARE @nNumdocu             NUMERIC(10,0)    
   DECLARE @nCorrela             NUMERIC(10,0)    
   DECLARE @dFeciniop            DATETIME    
   DECLARE @fTipcambio           NUMERIC(19,4)    
   DECLARE @nMonedaOp            NUMERIC(05,00)    
   DECLARE @nInCodigo            NUMERIC(05,0)    
   DECLARE @FormaPago            NUMERIC(03,0)    
   DECLARE @nFactor              NUMERIC(19,8)    
   DECLARE @rut_banco            NUMERIC(09)    
   DECLARE @cCtrlGrpEmisor       CHAR(01)    
   DECLARE @nTasPact             FLOAT    
   DECLARE @nTir                 FLOAT    
   DECLARE @cCheckTasa           CHAR(01)    
   DECLARE @cIntser              CHAR(12)    
   DECLARE @cSeriado             CHAR(01)    
   DECLARE @NumeroCorrelativo    INTEGER    
   DECLARE @LimParidadMultiplica FLOAT    
   DECLARE @LimUSDObs            FLOAT    
    
   DECLARE @RELA INTEGER    
   DECLARE @SW INTEGER    
   DECLARE @AfecLi integer    
   --DECLARE @nRutcli NUMERIC(09,0)    
   DECLARE @nConta NUMERIC(1)    
   DECLARE @nRut NUMERIC(09,0)    
   -- PRD8800
   DECLARE @Resultado            FLOAT
   DECLARE @MetodoLCR            NUMERIC(05)
   DECLARE @Garantia             FLOAT
   SET @RELA = 1    
   SET @SW = 0    
       
    
   SET @rut_banco = ( SELECT rcrut FROM BacParamSuda.dbo.ENTIDAD with(nolock) )    
    
   IF @cSistema <> 'OPT'    
      EXECUTE SP_EXPOSICION_MAXIMA_EN_LINEA @cSistema, @nNumoper    
      
      
    
    
   --************************************************    
   --************************************************    
   --**********                     *****************    
   --**********    CHEQUEA LINEAS   *****************    
   --**********                     *****************    
   --************************************************    
   --************************************************    
    
   SET @cCheckCli  = 'S'    
   SET @cCheckEmi  = 'N'    
   SET @cCheckChq  = 'N'    
   SET @cCheckTasa = 'N'    
    
   IF @cSistema = 'BTR' AND @cProducto = 'CP'    
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'S'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'BTR' AND (@cProducto = 'VI' OR @cProducto = 'VP')    
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'S'    
   END    
    
   IF @cSistema = 'BTR' AND (@cProducto = 'ICAP')    
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'BTR' AND (@cProducto = 'RCA' OR @cProducto = 'RVA')    
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'BTR' AND  @cProducto = 'FLI'      
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'S'    
   END    
   --+++20160505 jcamposd captaciones 
   IF @cSistema = 'BTR' AND  (@cProducto = 'IC' OR @cProducto = 'RIC')
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END       
   -----20160505 jcamposd captaciones  
   IF @cSistema = 'BCC'    
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'BCC' AND (@cProducto = 'PTAS' OR @cProducto = 'EMPR' OR @cProducto = 'ARBI' OR @cProducto = 'OVER' OR @cProducto = 'WEEK')    
   BEGIN    
      SET @cCheckCli = 'S'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'BCC' AND (@cProducto = 'EMPR' OR @cProducto = 'ARBI' OR @cProducto = 'OVER' OR @cProducto = 'WEEK') AND @cValidaCheque = 'S'    
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'S'    
   END    
    
   IF @cSistema = 'BFW'     
   BEGIN    
      SET @cCheckCli = 'N'    
  SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'BFW' AND ( @cProducto = '1' OR @cProducto = '2'  OR @cProducto = '3'  OR @cProducto = '7' OR @cProducto = '12' OR @cProducto = '13' OR @cProducto = '11' OR @cProducto = '14')     
   BEGIN    
      SET @cCheckCli = 'S'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'BFW' AND (@cProducto = 10 or @cProducto = 11)    
   BEGIN    
      SET @cCheckCli = 'S'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema  = 'BFW' AND @cProducto = '13'     
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
             
   IF @cSistema = 'PCS'     
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'PCS' AND (RTRIM(LTRIM(@cProducto)) = '1' OR RTRIM(LTRIM(@cProducto)) = '2'  OR RTRIM(LTRIM(@cProducto)) = '3')    
   BEGIN    
      SET @cCheckCli = 'S'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'PCS' AND (RTRIM(LTRIM(@cProducto)) = '4')    
   BEGIN    
      SET @cCheckCli = 'S'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   -- PROYECTO OPCIONES    
   IF @cSistema = 'OPT'     
   BEGIN    
      SET @cCheckCli = 'S'    
      SET @cCheckEmi = 'N'    
      SET @cCheckChq = 'N'    
   END    
    
   SET @cCtrlGrpEmisor = 'N'    
   IF @cSistema = 'BTR' AND (@cProducto = 'CP' OR @cProducto = 'VP' OR @cProducto = 'FLI')    
      SET @cCtrlGrpEmisor = 'S'    
    
   IF @cSistema = 'BTR' AND (@cProducto = 'CI' OR @cProducto = 'VI' OR @cProducto = 'ICOL' OR @cProducto = 'ICAP')     
   BEGIN    
      SET @cCheckCli = 'S'    
      IF @cProducto <> 'ICOL' AND @cProducto <> 'ICAP'    
         SET @cCheckTasa = 'S'    
   END    
    
   IF @cSistema = 'BTR' AND (@cProducto = 'CP' OR @cProducto = 'VP' OR @cProducto = 'FLI')    
      SET @cCheckTasa = 'S'    
    
    
   IF @cSistema = 'BEX' AND (@cProducto = 'CP' OR @cProducto = 'CPX')    
   BEGIN    
      SET @cCheckCli = 'N'    
      SET @cCheckEmi = 'S'    
      SET @cCheckChq = 'N'    
   END    
    
   IF @cSistema = 'BEX' AND (@cProducto = 'VP' OR @cProducto = 'VPX')    
   BEGIN    
      SET @cCheckCli  = 'N'    
      SET @cCheckEmi  = 'N'    
      SET @cCheckChq  = 'N'    
      SET @cCheckTasa = 'S'    
   END    
    
   SET @cProducto = CASE WHEN @cProducto = '1'  AND @cSistema = 'PCS' THEN '1' --'ST'    
                         WHEN @cProducto = '2'  AND @cSistema = 'PCS' THEN '2' --'SM'    
                         WHEN @cProducto = '3'  AND @cSistema = 'PCS' THEN '3' --'FR'    
                         WHEN @cProducto = '4'  AND @cSistema = 'PCS' THEN '4' --'SP'    
                         WHEN @cProducto = 'CP' AND @cSistema = 'BEX' THEN 'CPX'    
                 WHEN @cProducto = 'VP' AND @cSistema = 'BEX' THEN 'VPX'    
                         ELSE @cProducto    
                    END    
    
    
   --************************************************    
   --************************************************    
   --**********                     *****************    
   --**********   ACTUALIZA LINEAS  *****************    
   --**********                     *****************    
   --************************************************    
   --************************************************    
   --********** GRABAR LINEA EMISOR *****************    
    
   IF @cCheckEmi = 'S'     
   BEGIN    
   
      DECLARE Cursor_LINEAS_EMISOR SCROLL CURSOR FOR    
      SELECT  FechaOperacion    
         ,    Rut_Emisor    
         ,    NumeroDocumento    
         ,    NumeroCorrelativo    
         ,    SUM(MontoTransaccion)    
         ,    TipoCambio    
         ,    FechaVctoInst    
         ,    Operador    
         ,    Moneda_Emision    
         ,    Tipo_Riesgo    
         ,    InCodigo    
         ,    FormaPago    
         ,    Resultado						-- PRD8800
         ,    MetodoLCR						-- PRD8800
         ,    Garantia						-- PRD8800
      FROM    LINEA_CHEQUEAR   --	with(nolock)    
      WHERE   NumeroOperacion  = @nNumPantalla     
      AND     Id_Sistema       = @cSistema       
      AND     Rut_Emisor      <> 97029000       
      AND     Rut_Emisor      <> @rut_banco    
     GROUP BY FechaOperacion      
    ,    Rut_Emisor    
         ,    NumeroDocumento    
         ,    NumeroCorrelativo    
         ,    TipoCambio    
         ,    FechaVctoInst    
         ,    Operador    
         ,    Moneda_Emision    
         ,    Tipo_Riesgo    
         ,    InCodigo    
         ,    FormaPago    
         ,    Resultado						-- PRD8800
         ,    MetodoLCR						-- PRD8800
         ,    Garantia						-- PRD8800
    
      OPEN Cursor_LINEAS_EMISOR    
    
      WHILE (1 = 1)    
      BEGIN    
         FETCH NEXT FROM Cursor_LINEAS_EMISOR    
         INTO @dFecPro    
         ,    @nRutcli    
         ,    @nNumdocu    
         ,    @nCorrela    
         ,    @nMonto    
         ,    @fTipcambio    
         ,    @dFecvctop    
         ,    @cUsuario    
         ,    @nMonedaOp    
         ,    @cTipo_Riesgo    
         ,    @nInCodigo    
         ,    @FormaPago    
         ,    @Resultado					-- PRD8800
         ,    @MetodoLCR					-- PRD8800
         ,    @Garantia		
         IF (@@FETCH_STATUS <> 0)    
         BEGIN    
            BREAK    
         END    
			--para revisar
		/*select @dFecPro    
                                , @cSistema    
                                , @cProducto    
                                , @nRutcli    
                                , 1    
                                , @nNumoper    
                                , @nNumdocu    
                                , @nCorrela    
                                , @dFecPro    
                                , @nMonto    
                                , @fTipcambio    
                                , @dFecvctop    
                                , @cUsuario    
                                , @nMonedaOp    
                                , @cTipo_Riesgo    
                                , @nInCodigo    
                                , @FormaPago    
                                , @nContraMoneda    
                                , @nMonedaOpera    
								, @SW*/
    
         EXECUTE dbo.SVC_IMPUTACION_LINEAS    
                                  @dFecPro    
                                , @cSistema    
                                , @cProducto    
                                , @nRutcli    
                                , 1    
                                , @nNumoper    
                                , @nNumdocu    
                                , @nCorrela    
                                , @dFecPro    
                                , @nMonto    
                                , @fTipcambio    
                                , @dFecvctop    
                                , @cUsuario    
                                , @nMonedaOp    
                                , @cTipo_Riesgo    
                                , @nInCodigo    
                                , @FormaPago    
                                , @nContraMoneda    
                                , @nMonedaOpera    
								, @SW    
    
      END    
    
      CLOSE Cursor_LINEAS_EMISOR    
      DEALLOCATE Cursor_LINEAS_EMISOR    
    
   END    
    
    
   --********** GRABAR LINEA CLIENTE *****************    
   IF @cCheckCli = 'S'    
   BEGIN    
    
      DECLARE Cursor_LINEAS_CLIENTE SCROLL CURSOR FOR    
    
     SELECT  FechaOperacion    
         ,    Rut_Cliente    
         ,    Codigo_Cliente    
         ,    SUM(MontoTransaccion)    
         ,    TipoCambio    
         ,    FechaVencimiento    
         ,    Operador    
         ,    MonedaOperacion    
         ,    Tipo_Riesgo    
         ,    FormaPago    
         ,    MAX(TasaPacto)    
         ,    InCodigo    
         ,    NumeroCorrelativo    
         ,    Resultado						-- PRD8800
         ,    MetodoLCR						-- PRD8800
         ,    Garantia						-- PRD8800
      FROM    LINEA_CHEQUEAR   --	with(nolock)    
      WHERE   NumeroOperacion  = @nNumPantalla    
      AND     Id_Sistema  = @cSistema    
     GROUP BY FechaOperacion    
         ,    Rut_Cliente    
         ,    Codigo_Cliente    
         ,    TipoCambio    
         ,    FechaVencimiento    
         ,    Operador    
         ,    MonedaOperacion    
         ,    Tipo_Riesgo    
         ,    FormaPago    
         ,    InCodigo    
         ,    NumeroCorrelativo    
         ,    Resultado						-- PRD8800
         ,    MetodoLCR						-- PRD8800
         ,    Garantia						-- PRD8800
      OPEN Cursor_LINEAS_CLIENTE    
      WHILE (1 = 1)    
      BEGIN    
         FETCH NEXT FROM Cursor_LINEAS_CLIENTE    
         INTO @dFecPro    
         ,    @nRutcli    
         ,    @nCodigo    
         ,    @nMonto    
         ,    @fTipcambio    
         , @dFecvctop    
         ,    @cUsuario    
         ,    @nMonedaOp    
         ,    @cTipo_Riesgo    
         ,    @FormaPago    
         ,    @nTasPact    
         ,    @nInCodigo    
         ,    @NumeroCorrelativo    
         ,    @Resultado					-- PRD8800
         ,    @MetodoLCR					-- PRD8800
         ,    @Garantia						-- PRD8800
         IF (@@FETCH_STATUS <> 0)    
         BEGIN    
            BREAK    
         END    
    
         IF @cProducto <> 'VP' AND @cProducto <> 'ICAP'     
         BEGIN    
            SET @nInCodigo = CASE WHEN @nInCodigo = 992 THEN @nInCodigo     
                                  WHEN @nInCodigo = 993 THEN @nInCodigo     
                                  ELSE CASE WHEN @cProducto = 'CI' THEN 0 ELSE @nInCodigo END    
                              END    
    
            IF @cProducto <> 'VI'    
     BEGIN     
     
         
          EXECUTE dbo.SVC_IMPUTACION_LINEAS @dFecPro    
                                     ,  @cSistema    
                                     ,  @cProducto    
                                     ,  @nRutcli    
                                     ,  @nCodigo    
                                     ,  @nNumoper    
                                     ,  @nNumPantalla    
                                     ,  @NumeroCorrelativo    
                                     ,  @dFecPro    
                                     ,  @nMonto    
                                     ,  @fTipcambio    
                                     ,  @dFecvctop    
                                     ,  @cUsuario    
                                     ,  @nMonedaOp    
                                     ,  @cTipo_Riesgo    
                                     ,  @nInCodigo    
                                     ,  @FormaPago    
                                     ,  @nContraMoneda    
                                     ,  @nMonedaOpera    
                                   --,  @SwithEjecucion    
                                     ,  @SW    
                                     ,  @Resultado						-- PRD8800
                                     ,  @MetodoLCR						-- PRD8800
									 ,  @Garantia						-- PRD8800
            END    
    
            IF @@ERROR <> 0    
            BEGIN    
               RAISERROR('Error en Lineas por Plazo, Revisar Plazos Definidos',16,1,'Error en Lineas por Plazo, Revisar Plazos Definidos')    
               RETURN -1    
            END    
 
          IF @cProducto = 'ICOL'    
            BEGIN    
               EXECUTE SP_CHK_TASAS @dFecPro    
                                  , @cSistema    
                                  , 'CI'    
                                  , @FormaPago    
                                  , @nMonedaOp    
                                  , @nNumPantalla    
                                  , @dFecvctop    
                                  , @nTasPact    
                                  , 0    
                                  , 'P'    
                                  , ''    
                                  , ''    
                                  , @nNumoper    
            END    
    
            IF @cProducto = 'CI' OR @cProducto = 'VI'     
            BEGIN    
               EXECUTE SP_CHK_TASAS @dFecPro    
                                  , @cSistema    
                                  , @cProducto    
                                  , @FormaPago    
                                  , @nMonedaOp    
                                  , @nNumPantalla    
                                  , @dFecvctop    
                                  , @nTasPact    
                                  , 0    
                                  , 'P'    
                                  , ''    
                                  , ''    
                                  , @nNumoper    
            END    
    
         END ELSE     
         BEGIN  -- Solo chequea CI - ICAP - VI - VP    
            IF @cProducto = 'ICAP'    
            BEGIN    
               EXECUTE SP_CHK_TASAS @dFecPro    
                                  , @cSistema    
                                  , 'VI'    
                                  , @FormaPago    
                                  , @nMonedaOp    
                                  , @nNumPantalla    
            , @dFecvctop    
                                  , @nTasPact    
                                  , 0    
                                  , 'P'    
                                  , ''    
                                  , ''    
                                  , @nNumoper    
            END ELSE    
            BEGIN    
               EXECUTE SP_CHK_TASAS @dFecPro    
                                  , @cSistema    
                                  , @cProducto    
                                  , @FormaPago    
                                  , @nMonedaOp    
                                  , @nNumPantalla    
                                  , @dFecvctop    
                                  , @nTasPact    
                                  , 0    
                                  , 'P'    
                                  , ''    
                                  , ''    
                                  , @nNumoper    
  END    
 END  
      END  
    
      CLOSE Cursor_LINEAS_CLIENTE    
      DEALLOCATE Cursor_LINEAS_CLIENTE    
   END    
    
    
   --********** GRABAR LINEA CHEQUE *****************    
   IF @cCheckChq = 'S' AND @cProducto <> 'VP' AND @cProducto <> 'FLI'    
   BEGIN    
      DECLARE Cursor_LINEAS_CHEQUE SCROLL CURSOR FOR    
      SELECT  FechaOperacion    
         ,    Rut_Cheque    
         ,    SUM(MontoTransaccion)    
         ,    TipoCambio    
         ,    FechaVctoCheque    
         ,    Operador    
         ,    MonedaOperacion    
         ,    Tipo_Riesgo    
         ,    InCodigo    
         ,    FormaPago    
         ,    Resultado						-- PRD8800
         ,    MetodoLCR						-- PRD8800
         ,    Garantia						-- PRD8800
      FROM    LINEA_CHEQUEAR   --	with(nolock)    
      WHERE   NumeroOperacion  = @nNumPantalla    
      AND     Id_Sistema       = @cSistema    
      AND     Pago_Cheque      = @cCheckChq    
    GROUP BY  FechaOperacion    
         ,    Rut_Cheque    
         , TipoCambio    
         ,    FechaVctoCheque    
         ,    Operador    
         ,    MonedaOperacion    
         ,    Tipo_Riesgo    
         ,    InCodigo    
         ,    FormaPago    
         ,    Resultado						-- PRD8800
         ,    MetodoLCR						-- PRD8800
         ,    Garantia	 
      OPEN Cursor_LINEAS_CHEQUE    
    
      WHILE (1 = 1)    
      BEGIN    
         FETCH NEXT FROM Cursor_LINEAS_CHEQUE    
         INTO @dFecPro    
         ,    @nRutcli    
         ,    @nMonto    
         ,    @fTipcambio    
         ,    @dFecvctop    
         ,    @cUsuario    
         ,    @nMonedaOp    
         ,    @cTipo_Riesgo    
         ,    @nInCodigo    
         ,    @FormaPago    
         ,    @Resultado					-- PRD8800
         ,    @MetodoLCR					-- PRD8800
         ,    @Garantia						-- PRD8800
    
         IF (@@FETCH_STATUS <> 0)    
         BEGIN    
            BREAK    
         END    
    
         EXECUTE dbo.SVC_IMPUTACION_LINEAS    
                                  @dFecPro    
                                , @cSistema    
                                , @cProducto    
                                , @nRutcli    
                                , 0    
                                , @nNumoper    
                                , 0    
                                , 0    
                                , @dFecPro    
                                , @nMonto    
                                , @fTipcambio    
                                , @dFecvctop    
                                , @cUsuario    
                                , @nMonedaOp    
                                , @cTipo_Riesgo    
                                , @nInCodigo    
                                , @FormaPago    
                                , @nContraMoneda    
                                , @nMonedaOpera    
                                , @SW    
                                , @Resultado						-- PRD8800
                                , @MetodoLCR						-- PRD8800
 				,  @Garantia		  				    -- PRD8800

      END    
    
      CLOSE Cursor_LINEAS_CHEQUE    
      DEALLOCATE Cursor_LINEAS_CHEQUE    
   END    
    
   --+++CONTROL IDD, jcamposd, no debe rebajar líneas que no será utilizadas
    
   ------********** REBAJA LINEA EN VENTA PROPIA *****************    
   ----IF (@cSistema = 'BTR' OR @cSistema = 'BEX') AND (@cProducto = 'VP' OR @cProducto = 'VPX' OR @cProducto = 'FLI')    
   ----BEGIN    
    
   ----   SET @cCtrlGrpEmisor = 'N'    
    
   ----   DECLARE Cursor_LINEAS_REBAJA SCROLL CURSOR FOR    
   ----   SELECT  FechaOperacion    
   ----      ,    NumeroDocumento    
   ---- ,    NumeroCorrelativo    
   ----    ,    FactorVenta    
   ----      ,    InCodigo    
   ----   FROM    LINEA_CHEQUEAR   --	with (nolock)    
   ----   WHERE   NumeroOperacion  = @nNumPantalla    
   ----   AND     Id_Sistema  = @cSistema    
    
   ----   OPEN Cursor_LINEAS_REBAJA    
    
   ----   WHILE (1=1)    
   ----   BEGIN    
   ----      FETCH NEXT FROM Cursor_LINEAS_REBAJA    
   ----      INTO @dFecPro    
   ----      ,    @nNumdocu    
   ----      ,    @nCorrela    
   ----      ,    @nFactor    
   ----      ,    @nInCodigo    
             
   ----      IF (@@FETCH_STATUS <> 0)    
   ----      BEGIN    
   ----         BREAK    
   ----      END    
             
   ----      EXECUTE SP_LINEAS_REBAJA @dFecPro    
   ----                             , @cSistema    
   ----                             , @nNumdocu    
   ----                             , @nNumdocu    
   ----                             , @nCorrela    
   ----                             , @nFactor    
   ----                             , @nInCodigo  --> Incodigo    
   ----   END    
    
   ----   CLOSE Cursor_LINEAS_REBAJA    
   ----   DEALLOCATE Cursor_LINEAS_REBAJA    
   ----END    
    
   ------********** REBAJA LINEA EN ANTICIPOS *****************    
   ----IF @cSistema = 'BTR' AND (@cProducto = 'RCA' OR @cProducto = 'RVA')    
   ----BEGIN    
   ----   DECLARE Cursor_LINEAS_REBAJA SCROLL CURSOR FOR    
   ---- SELECT  FechaOperacion    
   ----   FROM    LINEA_CHEQUEAR   --	with(nolock)    
   ----   WHERE   NumeroOperacion  = @nNumPantalla    
   ----   AND     Id_Sistema       = @cSistema    
    
   ----   OPEN Cursor_LINEAS_REBAJA    
    
   ----   WHILE (1=1)    
   ----   BEGIN    
   ----      FETCH NEXT FROM Cursor_LINEAS_REBAJA    
   ----      INTO  @dFecPro      
    
   ----      IF (@@FETCH_STATUS <> 0)    
   ----      BEGIN    
   ----         BREAK    
   ----      END    
    
   ----      EXECUTE SP_LINEAS_REBAJA @dFecPro    
   ----                             , @cSistema    
   ----                             , @nNumoper    
   ----                             , 0    
   ----        , 0    
   ----                             , 1    
   ----                             , 0 --> Incodigo    
   ----   END    
    
   ----   CLOSE Cursor_LINEAS_REBAJA    
   ----   DEALLOCATE Cursor_LINEAS_REBAJA    
   ----END    
    
	-----CONTROL IDD, jcamposd, no debe rebajar líneas que no será utilizadas    
    
   --************************************************    
   --************************************************    
   --**********    *****************    
   --********** LIMITES DE OPERADOR *****************    
   --**********                     *****************    
   --************************************************    
   --************************************************    
    
   SET @cCheckLimOPER = 'S'    
   SET @cCheckLimInst = 'S'    
    
   IF @cSistema = 'BTR' AND @cProducto = 'CP'    
      SET @cCheckLimInst = 'S'    
    
   --********** GRABAR LIMITE POR OPERACION *****************    
   IF @cCheckLimOPER = 'S'    
   BEGIN    
      DECLARE Cursor_LIMITES_OPERACION SCROLL CURSOR FOR    
      SELECT  FechaOperacion    
         ,    SUM(MontoTransaccion)    
         ,    FechaVencimiento    
         ,    Operador    
         ,    MonedaOperacion    
      FROM    LINEA_CHEQUEAR   --	with(nolock)    
      WHERE   NumeroOperacion  = @nNumPantalla    
      AND     Id_Sistema       = @cSistema    
     GROUP BY FechaOperacion    
         ,    FechaVencimiento    
         ,    Operador    
         ,    MonedaOperacion    
    
      OPEN Cursor_LIMITES_OPERACION    
    
      WHILE (1=1)    
      BEGIN    
         FETCH NEXT FROM Cursor_LIMITES_OPERACION    
         INTO @dFecPro     
         ,    @nMonto    
         ,    @dFecvctop    
         ,    @cUsuario    
         ,    @nMonedaOp    
    
         IF (@@FETCH_STATUS <> 0)    
         BEGIN    
            BREAK    
         END    
    
         IF @cSistema = 'PCS'    
         BEGIN    
            SELECT @LimParidadMultiplica = isnull(vmvalor,0)    
            FROM   BacParamSuda..VALOR_MONEDA with(nolock)    
            WHERE  vmfecha               = @dFecPro     
            AND    vmcodigo              = CASE WHEN @nMonedaOp = 13 THEN 994 ELSE @nMonedaOp END    
                
            SET    @LimUSDObs = 1    
            SELECT @LimUSDObs = isnull(vmvalor,0)    
            FROM   BacParamSuda..VALOR_MONEDA with(nolock)    
            WHERE  vmfecha    = @dFecPro    
            AND    vmcodigo   = 994    
                
            SET @LimParidadMultiplica = ROUND( @LimParidadMultiplica / @LimUSDObs, 4 )    
                
            IF @nMonedaOp = 999    
               SET @nMonto = @nMonto / @LimUSDObs    
            ELSE    
               SET @nMonto = @nMonto * @LimParidadMultiplica    
         END    
    
         EXECUTE SP_LIMITES_GRABAR @dFecPro    
                                 , @cSistema    
                                 , @cProducto    
                                 , 0    
                                 , @nNumoper    
                                 , @nMonto    
                                 , @dFecvctop    
                                 , @cUsuario    
                                 , @cCheckLimOPER    
                                 , 'N'    
      END    
    
      CLOSE Cursor_LIMITES_OPERACION    
      DEALLOCATE Cursor_LIMITES_OPERACION    
   END    
    
    
   --********** GRABAR LIMITE POR OPERACION e INSTRUMENTO *****************    
   IF @cCheckLimInst = 'S'    
   BEGIN    
      DECLARE Cursor_LIMITES_OPERACION_INSTRUMENTO SCROLL CURSOR FOR    
      SELECT  FechaOperacion    
         ,    InCodigo    
         ,    SUM(MontoTransaccion)    
         ,    FechaVencimiento    
         ,    Operador    
         ,    MonedaOperacion    
FROM    LINEA_CHEQUEAR   --	with(nolock)    
      WHERE   NumeroOperacion  = @nNumPantalla    
      AND     Id_Sistema       = @cSistema    
     GROUP BY FechaOperacion    
         ,    InCodigo    
         ,    FechaVencimiento    
         ,    Operador    
         ,    MonedaOperacion    
    
      OPEN Cursor_LIMITES_OPERACION_INSTRUMENTO    
    
      WHILE (1 = 1)    
      BEGIN    
         FETCH NEXT FROM Cursor_LIMITES_OPERACION_INSTRUMENTO    
         INTO @dFecPro    
            , @nInCodigo    
            , @nMonto    
            , @dFecvctop    
            , @cUsuario    
            , @nMonedaOp    
    
         IF (@@FETCH_STATUS <> 0)    
         BEGIN    
            BREAK    
 END    
    
         IF @cSistema = 'PCS'    
         BEGIN    
            SELECT @LimParidadMultiplica = isnull(vmvalor,0)    
            FROM   BacParamSuda..VALOR_MONEDA with(nolock)    
            WHERE  vmfecha               = @dFecPro     
            and    vmcodigo              = CASE WHEN @nMonedaOp = 13 THEN 994 ELSE @nMonedaOp END    
    
            SET    @LimUSDObs = 1    
            SELECT @LimUSDObs = ISNULL( vmvalor,0)    
            FROM   BacParamSuda..VALOR_MONEDA with(nolock)    
            WHERE  vmfecha    = @dFecPro    
            AND    vmcodigo   = 994    
    
            SET @LimParidadMultiplica = ROUND(@LimParidadMultiplica / @LimUSDObs, 4 )    
    
            IF @nMonedaOp = 999    
               SET @nMonto = @nMonto / @LimUSDObs    
            ELSE    
               SET @nMonto = @nMonto * @LimParidadMultiplica    
         END    
    
         EXECUTE SP_LIMITES_GRABAR @dFecPro    
                                 , @cSistema    
                                 , @cProducto    
                                 , @nInCodigo    
                                 , @nNumoper    
                                 , @nMonto    
                                 , @dFecvctop    
                                 , @cUsuario    
                                 , 'S'    
                                 , @cCheckLimInst    
      END    
    
      CLOSE Cursor_LIMITES_OPERACION_INSTRUMENTO    
      DEALLOCATE Cursor_LIMITES_OPERACION_INSTRUMENTO    
   END    
    
   IF @cCtrlGrpEmisor = 'S'    
   BEGIN    
      DECLARE Cursor_LIMITES_GRUPO_EMISOR SCROLL CURSOR FOR    
      SELECT  FechaOperacion    
         ,    Rut_Emisor    
         ,    SUM(MontoTransaccion)    
      FROM    LINEA_CHEQUEAR   --	with(nolock)    
      WHERE   NumeroOperacion  = @nNumPantalla    
      AND     Id_Sistema       = @cSistema    
     GROUP BY FechaOperacion    
         ,    Rut_Emisor    
    
      OPEN Cursor_LIMITES_GRUPO_EMISOR    
    
      WHILE (1 = 1)    
      BEGIN    
         FETCH NEXT FROM Cursor_LIMITES_GRUPO_EMISOR    
         INTO @dFecPro    
         ,    @nRutcli    
         ,    @nMonto    
    
         IF (@@FETCH_STATUS <> 0)    
         BEGIN    
            BREAK    
         END    
             
      END    
    
      CLOSE Cursor_LIMITES_GRUPO_EMISOR    
      DEALLOCATE Cursor_LIMITES_GRUPO_EMISOR    
    
      --  Control para Letras Emision propia porcentaje Capital Basico     
      DECLARE Cursor_LIMITES_GRUPO_EMISOR SCROLL CURSOR FOR    
      SELECT  FechaOperacion    
         ,    Rut_Emisor    
         ,    SUM(MontoTransaccion)    
      FROM    LINEA_CHEQUEAR  -- with(nolock)    
      WHERE   NumeroOperacion = @nNumPantalla    
      AND     Id_Sistema      = @cSistema    
      AND     incodigo        = 20    
      AND     Rut_Emisor      = 97023000    
     GROUP BY FechaOperacion    
         ,    Rut_Emisor    
    
      OPEN Cursor_LIMITES_GRUPO_EMISOR    
    
      WHILE (1 = 1)    
      BEGIN    
         FETCH NEXT FROM Cursor_LIMITES_GRUPO_EMISOR    
         INTO @dFecPro     
         ,    @nRutcli    
         ,    @nMonto    
    
         IF (@@FETCH_STATUS <> 0)    
         BEGIN    
            BREAK    
         END    
      END    
    
      CLOSE Cursor_LIMITES_GRUPO_EMISOR    
      DEALLOCATE Cursor_LIMITES_GRUPO_EMISOR    
   END    
    
   IF @cCheckTasa = 'S'    
   BEGIN    
      DECLARE Cursor_LINEAS_TASA SCROLL CURSOR FOR    
      SELECT  FechaOperacion    
      ,       Rut_Cliente    
      ,       Codigo_Cliente    
      ,       Codigo_Producto    
      ,       Tir    
      ,       FechaVctoInst    
   ,       Moneda_Emision    
    ,       Incodigo    
      ,       FormaPago    
      ,       Instser    
      ,       Seriado    
      FROM    LINEA_CHEQUEAR   --	with(nolock)    
      WHERE   NumeroOperacion  = @nNumPantalla    
      AND     Id_Sistema       = @cSistema    
    
      OPEN Cursor_LINEAS_TASA    
    
      WHILE (1 = 1)    
      BEGIN    
         FETCH NEXT FROM Cursor_LINEAS_TASA    
         INTO @dFecPro       
         ,    @nRutcli    
         ,    @nCodigo    
         ,    @cProducto    
         ,    @nTir    
         ,    @dFecvctop    
         ,    @nMonedaOp    
         ,    @nInCodigo    
         ,    @FormaPago    
         ,    @cIntser    
         ,    @cSeriado    
    
         IF (@@FETCH_STATUS <> 0)    
         BEGIN    
            BREAK    
         END    
    
         IF SUBSTRING(@cIntser,1,6) <> 'FMUTUO'     
         BEGIN    
            EXECUTE SP_CHK_TASAS @dFecPro    
                               , @cSistema    
                               , @cProducto    
                               , @FormaPago    
                               , @nMonedaOp    
                               , @nNumPantalla    
                               , @dFecvctop    
                               , @nTir    
                               , @nInCodigo    
                               , 'I'    
                               , @cIntser    
                               , @cSeriado    
                               , @nNumoper    
         END    
    
      END    
    
      CLOSE Cursor_LINEAS_TASA    
      DEALLOCATE Cursor_LINEAS_TASA    
   END    
    
    

   --insert into debug_valores select  Variable01 = '@cSistema', 0, '@nNumoper', @nNumoper  --- select * from debug_valores

   declare @SisNetting varchar(5) 
   select @SisNetting = Id_Grupo from TBL_AGRPROD where Id_Sistema = @cSistema  
   if       @SisNetting = 'DRV'          -- Si sistema es Derivado          
        and @MetodoLCR in ( 2, 3, 5,6 )    -- Es metodologia Drv      '  PRD 21119 - Consumo de Línea derivados ComDer (se agrego metodologia 6)
        and @nMonto < 0                  -- Se esta anulando la Operacion
     Begin
           select @cSistema = @cSistema 

           -- sp_Helptext SP_LINEAS_ANULA
           -- Hay que hacer algo específico que contemple ingreso - modificacion y anulación 
		   --********** GRABAR LIMITE DE OPERADOR *****************
		   --EXECUTE SP_LIMITES_CHEQUEAR   @cSistema, @nNumoper
          -- insert into debug_valores select  Variable01 = '@cSistema', 0, '@nNumoper', @nNumoper 
		   EXECUTE SP_LIMITES_RECHEQUEAR_ANULA_MET_DRV @dFecPro, @cSistema, @nNumoper   --- sp_helptext SP_LIMITES_RECHEQUEAR
       
     end
   ELSE
      Begin
   --********** GRABAR LIMITE DE OPERADOR *****************    
   EXECUTE SP_LIMITES_CHEQUEAR   @cSistema, @nNumoper    
   EXECUTE SP_LIMITES_RECHEQUEAR @cSistema, @nNumoper, @cUsuario, 'I'    
    

      End

   DELETE  LINEA_CHEQUEAR    
   WHERE   NumeroOperacion = @nNumPantalla    
   AND     Id_Sistema     = @cSistema    
--   AND     Codigo_Producto = @cProducto    

END
GO
