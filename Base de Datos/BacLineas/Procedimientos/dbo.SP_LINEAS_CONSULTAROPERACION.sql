USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CONSULTAROPERACION]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_CONSULTAROPERACION]
       (  
         @cSistema        CHAR(03),  
         @cProducto       CHAR(05),  
         @nNumPantalla    NUMERIC(10),  
         @cTipoper        CHAR(01),  
         @cValidaCheque   CHAR(01),  
         @nMercadoLocal   CHAR(01),  
         @mContraMoneda   NUMERIC(03) = 0  
       )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @cCheckEmi     CHAR(01)  
   DECLARE @cCheckChq     CHAR(01)  
   DECLARE @cCheckCli     CHAR(01)  
   DECLARE @cCheckLimOPER CHAR(01)  
   DECLARE @cCheckLimInst CHAR(01)  
   DECLARE @dFecPro       DATETIME  
   DECLARE @nRutcli       NUMERIC(09,0)  
   DECLARE @nCodigo       NUMERIC(09,0)  
   DECLARE @dFecvctop     DATETIME  
   DECLARE @cUsuario      CHAR(15)  
   DECLARE @nMonto        NUMERIC(19,4)  
   DECLARE @cTipo_Riesgo  CHAR(01)  
   DECLARE @nNumdocu      NUMERIC(10,0)  
   DECLARE @nCorrela      NUMERIC(10,0)  
   DECLARE @dFeciniop     DATETIME  
   DECLARE @fTipcambio    NUMERIC(19,4)  
   DECLARE @nMonedaOp     NUMERIC(05,00)  
   DECLARE @nInCodigo     NUMERIC(05,0)  
   DECLARE @nFactor       NUMERIC(19,8)  
  
-- PRD8800
   DECLARE @nResultado     FLOAT        
   DECLARE @nMetodoLCR     NUMERIC(5)   
   DECLARE @nGarantia      FLOAT        
-- PRD8800

   DECLARE @Aux_Id        INTEGER  
   DECLARE @nRutCOPR      NUMERIC(9)  
   DECLARE @nRutBCCH      NUMERIC(9)  
   SET     @nRutCOPR      = 97023000  
   SET     @nRutBCCH      = 97029000  
  
  
   CREATE TABLE #Tmp_Error  
   (   Tipo_Error     CHAR(3),  
       Correlativo    NUMERIC(19),  
       Mensaje_Error  VARCHAR(255),  
       MontoExceso    NUMERIC(19,4)  
   )  
  
   /*===============================================*/  
   /* CHEQUEA LINEAS                                */  
   /*===============================================*/  
   SET @cCheckCli = 'S'  
   SET @cCheckEmi = 'N'  
   SET @cCheckChq = 'N'  
  
   IF @cSistema = 'BTR' AND @cProducto = 'CP'  
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'S'  
      SET @cCheckChq = 'N'  
  
   END  
  
   IF @cSistema = 'BTR' AND @cProducto = 'FLI'  
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'S'  
  
   END  
  
   IF @cSistema = 'BEX' AND @cProducto = 'CP'  
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'S'  
      SET @cCheckChq = 'N'  
  
   END  
  
   IF @cSistema = 'BEX' AND @cProducto = 'VP'  
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
  
   END  
  
   IF @cSistema = 'BTR' AND @cProducto IN ( 'VI', 'VP' )  
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'S'  
  
   END  
  
   IF @cSistema = 'BTR' AND @cProducto = 'ICAP'  
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
  
   END  
  
   IF @cSistema = 'BTR' AND @cProducto IN ( 'RCA', 'RVA' )  
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
  
   END  
  
   IF @cSistema = 'BCC'   
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
  
   END  
  
   IF @cSistema = 'BCC' AND @cProducto IN ( 'PTAS', 'EMPR', 'ARBI', 'OVER', 'WEEK' ) -- AND @cTipoper = 'C'  
   BEGIN  
      SET @cCheckCli = 'S'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
  
   END  
  
   IF @cSistema = 'BCC' AND ( @cProducto = 'EMPR' ) AND @cValidaCheque = 'S' -- AND @cTipoper = 'C'   
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
  
   IF @cSistema = 'BFW' AND @cProducto in ( '1','2','3','7','12','10','11' ,'14') 
   BEGIN  
      SET @cCheckCli = 'S'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
   END  
  
 IF @cSistema = 'BFW' AND @cProducto = '13' BEGIN  
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

IF @cSistema = 'PCS' AND @cProducto IN ( '1', '2', '3' )  
   BEGIN  
      SET @cCheckCli = 'S'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
  
   END  
   

   IF @cSistema = 'PCS' AND @cProducto = '4'  
   BEGIN  
      SET @cCheckCli = 'S'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
  
   END  
  
   /*=================================================================================================================*/  
   /* ACTUALIZA LINEAS: GRABAR LINEA EMISOR                                                                           */  
   /*=================================================================================================================*/  
   IF @cCheckEmi = 'S'  
   BEGIN  
  
       SELECT  'Id'             = Identity(INT),  
               'Fecha'          = FechaOperacion,  
               'RutEmisor'      = Rut_Emisor,  
               'CodEmisor'      = Cod_Emisor,  
               'NumDocumento'   = NumeroDocumento,  
               'NumCorrelativo' = NumeroCorrelativo,  
               'Monto'          = SUM(MontoTransaccion),  
               'TipoCambio'     = TipoCambio,  
               'Vencimiento'    = FechaVctoInst,  
               'Operador'       = Operador,  
               'Moneda'         = MonedaOperacion,  
               'TipoRiesgo'     = Tipo_Riesgo,
-- PRD8800
               'Resultado'      = Resultado     ,    
               'MetodoLCR'      = MetodoLCR     ,
               'Garantia'       = Garantia
-- PRD8800
         INTO  #LINEA_CHEQUEAR_CurEmi  
         FROM  LINEA_CHEQUEAR   --	with(nolock)  
        WHERE  NumeroOperacion  = @nNumPantalla  
          AND  Id_Sistema       = @cSistema  
          AND  Rut_Emisor      NOT IN( @nRutBCCH , @nRutCOPR )       --  AND  Rut_Emisor  NOT IN(97029000, 97018000 )  
        GROUP BY FechaOperacion,  
               Rut_Emisor,  
               Cod_Emisor,  
               NumeroDocumento,  
               NumeroCorrelativo,  
               TipoCambio,  
               FechaVctoInst,  
               Operador,  
               MonedaOperacion,  
               Tipo_Riesgo,
-- PRD8800
               Resultado  ,    
               MetodoLCR  ,
               Garantia
-- PRD8800
  
      CREATE INDEX #ix_LINEA_CHEQUEAR_CurEmi ON #LINEA_CHEQUEAR_CurEmi ( Id )  
  
      WHILE (1 = 1)  
      BEGIN  
         SET @Aux_Id = 0  
         SELECT TOP 1  
                @Aux_Id       = Id,  
                @dFecPro      = Fecha,  
                @nRutcli      = RutEmisor,  
                @nCodigo      = CodEmisor,  
                @nNumdocu     = NumDocumento,  
                @nCorrela     = NumCorrelativo,  
                @nMonto       = Monto,  
                @fTipcambio   = TipoCambio,  
                @dFecvctop    = Vencimiento,  
                @cUsuario     = Operador,  
                @nMonedaOp    = Moneda,  
                @cTipo_Riesgo = TipoRiesgo,
-- PRD8800
                @nResultado   = Resultado  ,    
                @nMetodoLCR   = MetodoLCR  ,
                @nGarantia    = Garantia
-- PRD8800
         FROM   #LINEA_CHEQUEAR_CurEmi  
         WHERE  Id            > @Aux_Id  
  
         IF @@ROWCOUNT = 0  
         BEGIN  
            BREAK  
         END  
  
         DELETE #LINEA_CHEQUEAR_CurEmi   
         WHERE  Id = @Aux_Id  
  
         EXECUTE Sp_Lineas_ConsultarOperacionDetalle @dFecPro,  
                                @cSistema,  
                                                     @cProducto,  
                                                     @nRutcli,  
                                                     @nCodigo,  
                                                     @dFecPro,  
                                                     @nMonto,  
                                                     @fTipcambio,  
                                                     @dFecvctop,  
                                                     @cUsuario,  
                                                     @nMonedaOp,  
                                                     @cTipo_Riesgo,  
                                                     @mContraMoneda, 
                                                     @nNumdocu,
												-- PRD8800
                                                     @nResultado,
                                                     @nMetodoLCR,
                                                     @nGarantia
												-- PRD8800
  
      END --> While   
  
   END --> @cCheckEmi = 'S'  
    
   /*=================================================================================================================*/  
   /* GRABAR LINEA CLIENTE                                                                                            */  
   /*=================================================================================================================*/  
   IF @cCheckCli = 'S'  
   BEGIN  
      SELECT 'Id'        = Identity(INT),  
             'Fecha'         = FechaOperacion,  
             'RutCliente'    = Rut_Cliente,  
             'CodigoCliente' = Codigo_Cliente,  
             'NumDocumento'  = NumeroDocumento,    -- PRD8800
             'Monto'         = SUM(MontoTransaccion),  
             'TipoCambio'    = TipoCambio,  
             'Vencimiento'   = FechaVencimiento,  
             'Operador'      = Operador,  
             'Moneda'        = MonedaOperacion,  
             'TipoRiesgo'    = Tipo_Riesgo   ,
-- PRD8800
             'Resultado'     = Resultado     ,    
             'MetodoLCR'     = MetodoLCR     ,
             'Garantia'      = Garantia
-- PRD8800
         INTO #LINEA_CHEQUEAR_CurCli  
         FROM LINEA_CHEQUEAR --	with (nolock)  
        WHERE NumeroOperacion  = @nNumPantalla  
          AND Id_Sistema  = @cSistema  
        GROUP BY FechaOperacion,  
              Rut_Cliente,  
              Codigo_Cliente,  
              TipoCambio,  
              FechaVencimiento,  
              Operador,  
              MonedaOperacion,  
              Tipo_Riesgo,
              NumeroDocumento,
-- PRD8800
              Resultado      ,    
              MetodoLCR      ,
              Garantia
-- PRD8800
  
      CREATE INDEX #ix_LINEA_CHEQUEAR_CurCli ON #LINEA_CHEQUEAR_CurCli ( Id )  
  
      WHILE (1 = 1)  
      BEGIN  
         SET @Aux_Id = 0  
         SELECT TOP 1  
                @Aux_Id       = Id,  
                @dFecPro      = Fecha,  
                @nRutcli      = RutCliente,  
                @nCodigo      = CodigoCliente,  
                @nNumdocu     = NumDocumento,
                @nMonto       = Monto,  
                @fTipcambio   = TipoCambio,  
                @dFecvctop    = Vencimiento,  
                @cUsuario     = Operador,  
                @nMonedaOp    = Moneda,  
                @cTipo_Riesgo = TipoRiesgo , 
-- PRD8800
                @nResultado   = Resultado  ,    
                @nMetodoLCR   = MetodoLCR  ,
                @nGarantia    = Garantia
-- PRD8800
 
         FROM   #LINEA_CHEQUEAR_CurCli  
         WHERE  Id            > @Aux_Id  
        
         IF @@ROWCOUNT = 0  
         BEGIN  
            BREAK  
         END  
  
         DELETE #LINEA_CHEQUEAR_CurCli  
           WHERE Id = @Aux_Id  
  
         EXECUTE Sp_Lineas_ConsultarOperacionDetalle @dFecPro,  
                                                     @cSistema,  
                                                     @cProducto,  
                                                     @nRutcli,  
                                                     @nCodigo,  
                                                     @dFecPro,  
                                                     @nMonto,  
                                                     @fTipcambio,  
                                                     @dFecvctop,  
                                                     @cUsuario,  
                                                     @nMonedaOp,  
                                                     @cTipo_Riesgo,
                                                     @mContraMoneda,
                                                     @nNumdocu,
												-- PRD8800
                                                     @nResultado,
                                                     @nMetodoLCR,
                                                     @nGarantia
												-- PRD8800
  
      END --> While  
  
   END --> @cCheckCli = 'S'  
  
  
   /*=================================================================================================================*/  
   /* GRABAR LINEA CHEQUE                                                                                             */  
   /*=================================================================================================================*/  
   IF @cCheckChq = 'S'  
   BEGIN  
  
       SELECT 'Id'          = Identity(INT),  
              'Fecha'       = FechaOperacion,  
              'Rut'         = Rut_Cheque,  
              'Monto'       = SUM(MontoTransaccion),  
              'TipoCambio'  = TipoCambio,  
              'Vencimiento' = FechaVctoCheque,  
              'Operador'    = Operador,  
              'Moneda'      = MonedaOperacion,  
              'TipoRiesgo'  = Tipo_Riesgo,
-- PRD8800
             'Resultado'     = Resultado     ,    
             'MetodoLCR'     = MetodoLCR     ,
             'Garantia'      = Garantia
-- PRD8800

         INTO #LINEA_CHEQUEAR_CurChq  
         FROM LINEA_CHEQUEAR   --	with (nolock)  
        WHERE NumeroOperacion  = @nNumPantalla  
          AND Id_Sistema       = @cSistema  
          AND Pago_Cheque      = @cCheckChq  
        GROUP BY FechaOperacion,  
              Rut_Cheque,  
              TipoCambio,  
              FechaVctoCheque,  
              Operador,  
              MonedaOperacion,  
              Tipo_Riesgo,
-- PRD8800
              Resultado      ,    
              MetodoLCR      ,
              Garantia
-- PRD8800

  
      CREATE INDEX #ix_LINEA_CHEQUEAR_CurChq ON #LINEA_CHEQUEAR_CurChq ( Id )  
  
      WHILE(1=1)  
      BEGIN  
         SET @Aux_Id = 0  
         SELECT TOP 1  
                @Aux_Id       = Id,  
                @dFecPro      = Fecha,  
                @nRutcli      = Rut,  
                @nMonto       = Monto,  
                @fTipcambio   = TipoCambio,  
                @dFecvctop    = Vencimiento,  
                @cUsuario     = Operador,  
                @nMonedaOp    = Moneda,  
                @cTipo_Riesgo = TipoRiesgo,
-- PRD8800
                @nResultado   = Resultado  ,    
                @nMetodoLCR   = MetodoLCR  ,
                @nGarantia    = Garantia
-- PRD8800
         FROM   #LINEA_CHEQUEAR_CurChq  
         WHERE  Id            > @Aux_Id  
  
         IF @@ROWCOUNT <> 0  
         BEGIN  
            BREAK  
         END  
        
         DELETE #LINEA_CHEQUEAR_CurChq  
         WHERE  Id = @Aux_Id  
  
         EXECUTE Sp_Lineas_ConsultarOperacionDetalle @dFecPro,  
                                                     @cSistema,  
                                                     @cProducto,  
                                                     @nRutcli,  
                                                     0,  
                                                     @dFecPro,  
                                                     @nMonto,  
                                                     @fTipcambio,  
                                                     @dFecvctop,  
                                                     @cUsuario,  
                                                     @nMonedaOp,  
                                                     @cTipo_Riesgo, 
                                                     @mContraMoneda, 
                                                     @nNumdocu, 
												-- PRD8800
                                                     @nResultado,
                                                     @nMetodoLCR,
                                                     @nGarantia
												-- PRD8800

  
      END --> @cCheckChq = 'S'  
  
   END --> While  
  
   /*=================================================================================================================*/  
   /* LIMITES DE OPERADOR                                                                                             */  
   /*=================================================================================================================*/  
  
   CREATE TABLE #Temp_LIMITE_TRANSACCION  
   (   FechaOperacion      DATETIME,  
       NumeroOperacion     NUMERIC(10)   NOT NULL,  
       Id_Sistema          CHAR(03)      NOT NULL,  
       Codigo_Producto     CHAR(05)      NOT NULL,  
       InCodigo            NUMERIC(05)   NOT NULL,  
       MontoTransaccion    NUMERIC(19,4) NOT NULL DEFAULT(0),  
       FechaVencimiento    DATETIME,  
       Operador            CHAR(15)      NOT NULL,  
       Check_Operacion     VARCHAR(01)   NOT NULL DEFAULT(''),  
       Check_Instrumento   VARCHAR(01)   NOT NULL DEFAULT('')  
   )  
  
   SET @cCheckLimOPER = 'S'  
   SET @cCheckLimInst = 'N'  
  
   IF @cSistema = 'BTR' AND @cProducto = 'CP'  
   BEGIN  
      SET @cCheckLimInst = 'S'  
  
   END  
  
   IF @cSistema = 'BTR' AND @cProducto IN ( 'ICOL', 'ICAP' )  
   BEGIN  
      SET @cCheckLimInst = 'S'  
  
   END  
  
   /*=================================================================================================================*/  
   /* GRABAR LIMITE POR OPERACION                                                                                     */  
   /*=================================================================================================================*/  
   IF @cCheckLimOPER = 'S'  
   BEGIN  
  
       SELECT 'Id'          = Identity(INT),  
              'Fecha'       = FechaOperacion,  
              'Monto'       = SUM(MontoTransaccion),  
              'Vencimiento' = FechaVencimiento,  
              'Operador'    = Operador  
         INTO #LINEA_CHEQUEAR_Operador  
         FROM LINEA_CHEQUEAR   --	with (nolock)   

        WHERE NumeroOperacion  = @nNumPantalla  
          AND Id_Sistema  = @cSistema  
        GROUP BY FechaOperacion,  
              FechaVencimiento,  
              Operador  
  
      CREATE INDEX #ix_LINEA_CHEQUEAR_Operador ON #LINEA_CHEQUEAR_Operador ( Id )  
  
      WHILE(1=1)  
      BEGIN  
         SET @Aux_Id = 0  
         SELECT TOP 1  
                @Aux_Id    = Id,  
                @dFecPro   = Fecha,  
                @nMonto    = Monto,  
                @dFecvctop = Vencimiento,  
                @cUsuario  = Operador  
           FROM #LINEA_CHEQUEAR_Operador  
         WHERE Id         > @Aux_Id  
  
         IF @@ROWCOUNT = 0  
         BEGIN  
            BREAK  
  
         END  
  
         DELETE #LINEA_CHEQUEAR_Operador WHERE Id = @Aux_Id  
  
         INSERT INTO #Temp_LIMITE_TRANSACCION  
                VALUES  
              (  
                       @dFecPro,  
                       @nNumPantalla,  
                       @cSistema,  
                       @cProducto,  
                       0,  
                       @nMonto,  
                       @dFecvctop,  
                       @cUsuario,  
                       @cCheckLimOPER,  
                       'N'   
                     )  
  
      END  
  
   END  
  
   /*=================================================================================================================*/  
   /* GRABAR LIMITE POR OPERACION e INSTRUMENTO                                                                       */  
   /*=================================================================================================================*/  
   IF @cCheckLimInst = 'S'  
   BEGIN  
       SELECT 'Id'          = Identity(INT),  
              'Fecha'       = FechaOperacion,  
              'Codigo'      = InCodigo,  
              'Monto'       = SUM(MontoTransaccion),  
              'Vencimiento' = FechaVencimiento,  
              'Operador'    = Operador  
         INTO #LINEA_CHEQUEAR_INST  
         FROM LINEA_CHEQUEAR  --	with (nolock)  
        WHERE NumeroOperacion = @nNumPantalla  
          AND Id_Sistema      = @cSistema  
        GROUP BY FechaOperacion,  
              InCodigo,  
              FechaVencimiento,  
              Operador  
  
      CREATE INDEX #ix_LINEA_CHEQUEAR_INST ON #LINEA_CHEQUEAR_INST ( Id )  
  
      WHILE(1=1)  
      BEGIN  
         SET @Aux_Id = 0  
         SELECT TOP 1   
                @Aux_Id    = Id,  
                @dFecPro   = Fecha,  
                @nInCodigo = Codigo,  
                @nMonto    = Monto,  
                @dFecvctop = Vencimiento,  
                @cUsuario  = Operador  
           FROM #LINEA_CHEQUEAR_INST  
           WHERE Id        > @Aux_Id  
  
         IF @@ROWCOUNT = 0  
         BEGIN  
            BREAK  
  
         END  
  
         DELETE #LINEA_CHEQUEAR_INST WHERE Id = @Aux_Id  
  
         INSERT INTO #Temp_LIMITE_TRANSACCION  
                VALUES  
                     (  
                       @dFecPro,  
                       @nNumPantalla,  
                       @cSistema,  
                       @cProducto,  
                       @nInCodigo,  
                       @nMonto,  
                       @dFecvctop,  
                       @cUsuario,  
                       'N',  
                       @cCheckLimInst  
                     )  
  
      END  
  
   END  
  
  
   /*=================================================================================================================*/  
   /* GRABAR LIMITE DE OPERADOR                                                                                       */  
   /*=================================================================================================================*/  
  
   EXECUTE Sp_Limites_ConsultaOperacion  
  
   SELECT * FROM #Tmp_Error  
  
   SET NOCOUNT OFF  
  
END
GO
