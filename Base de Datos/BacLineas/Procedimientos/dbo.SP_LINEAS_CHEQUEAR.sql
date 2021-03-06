USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CHEQUEAR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_CHEQUEAR]
   (   @cSistema        VARCHAR(03)  
   ,   @cProducto       VARCHAR(05)  
   ,   @nNumoper        NUMERIC(10)  
   ,   @cTipoper        CHAR(01)  
   ,   @cValidaCheque   CHAR(01)  
   ,   @nMercadoLocal   CHAR(01)  
   )  
AS  
BEGIN  
  
   -->+++CONTROL IDD, jcamposd no debe chequear lineas sistema / producto / general
  RETURN
   -->---CONTROL IDD, jcamposd no debe chequear lineas sistema / producto / general
  
  
   SET NOCOUNT ON  
  
   DECLARE @cCheckEmi     CHAR(1)  
   DECLARE @cCheckChq     CHAR(1)  
   DECLARE @cCheckCli     CHAR(1)  
   DECLARE @cCheckLimOPER CHAR(1)  
   DECLARE @cCheckLimInst CHAR(1)  
   DECLARE @dFecPro       DATETIME  
   DECLARE @nRutcli       NUMERIC(09,0)  
   DECLARE @nCodigo       NUMERIC(09,0)  
   DECLARE @dFecvctop     DATETIME  
   DECLARE @cUsuario      CHAR(15)  
   DECLARE @nMonto        NUMERIC(19,4)  
   DECLARE @cTipo_Riesgo  CHAR(1)  
   DECLARE @nNumdocu      NUMERIC(10,0)  
   DECLARE @nCorrela      NUMERIC(10,0)  
   DECLARE @dFeciniop     DATETIME  
   DECLARE @fTipcambio    NUMERIC(19,4)  
   DECLARE @nMonedaOp     NUMERIC(05,0)  
   DECLARE @nInCodigo     NUMERIC(05)  
   DECLARE @FormaPago     NUMERIC(03,0)  
   DECLARE @nFactor       NUMERIC(19,8)  
   DECLARE @nTasPact      FLOAT  
   DECLARE @nTir          FLOAT  
   DECLARE @nMonemi       NUMERIC(05,0)  
   DECLARE @dFecVenc      DATETIME  
   DECLARE @Id            INTEGER  
   DECLARE @nRutCOPR      NUMERIC(9)  
   DECLARE @nRutBCCH      NUMERIC(9)  
   DECLARE @MetodoLCR     NUMERIC(5)   -- PRD8800
  
   CREATE TABLE #TEMP1  
   (   mensaje   CHAR(255)   )  
  
   SET @nRutCOPR  = 97023000  
   SET @nRutBCCH  = 97029000  
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
  
   IF @cSistema = 'BTR' AND @cProducto IN('VI','VP')  
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
  
   IF @cSistema = 'BTR' AND @cProducto IN('RCA','RVA')  
   BEGIN  
      SET @cCheckCli = 'N'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
   END  

   --+++20160505 jcamposd captaciones
   IF @cSistema = 'BTR' AND @cProducto IN('IC', 'RIC')  
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
  
   IF @cSistema = 'BCC' AND @cProducto IN('PTAS','EMPR','ARBI','OVER','WEEK')  
   BEGIN  
      SET @cCheckCli = 'S'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
   END  
  
   IF @cSistema = 'BCC' AND (@cProducto = 'EMPR') AND @cTipoper = 'C' AND @cValidaCheque = 'S'  
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
  
   IF @cSistema = 'BFW' AND @cProducto IN('1','2','3','7','10','12', '11', '14' )  
   BEGIN  
      SET @cCheckCli = 'S'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
   END  
  
 IF @cSistema  = 'BFW' AND @cProducto = '13' BEGIN  
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
  
   IF @cSistema = 'PCS' AND @cProducto IN('1','2','3')  
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
  
 -- PROYECTO OPCIONES FX  
   IF @cSistema = 'OPT'   
   BEGIN  
      SET @cCheckCli = 'S'  
      SET @cCheckEmi = 'N'  
      SET @cCheckChq = 'N'  
   END  
  
   DECLARE @nRegistros   NUMERIC(9)  
   DECLARE @nContador    NUMERIC(9)  
  
   --********** CHEQUEA LINEA EMISOR *****************  
	IF @cCheckEmi = 'S'  
	BEGIN
		SELECT 'id'            = identity(INT)  
		,      'Fecha'         = FechaOperacion  
		,      'RutEmisor'     = Rut_Emisor  
		,      'FechaVctoInst' = FechaVctoInst  
		,      'Monto'         = SUM(MontoTransaccion)  
		,      'TipoRiesgo'    = Tipo_Riesgo  
		,      'Codigo'        = InCodigo  
		,      'Moneda'        = MonedaOperacion  
		,      'FormaPago'     = FormaPago  
		,      'MetodologiaLCR' = MetodoLCR    -- PRD8800
		INTO   #TMPLINEA_CHEQUEAR_EMISOR  
		FROM   LINEA_CHEQUEAR  --	with(nolock)  
		WHERE  NumeroOperacion = @nNumoper     
		AND    Id_Sistema      = @cSistema  
		AND    Rut_Emisor      NOT IN( @nRutBCCH , @nRutCOPR )  
		GROUP BY FechaOperacion, Rut_Emisor, FechaVctoInst, Tipo_Riesgo, InCodigo, MonedaOperacion, FormaPago, MetodoLCR   -- PRD8800
  
      CREATE INDEX #TMPLINEA_CHEQUEAR_EMISOR_ID ON #TMPLINEA_CHEQUEAR_EMISOR (id)  
  
      SET @nRegistros   = ISNULL((SELECT MAX(id) FROM #TMPLINEA_CHEQUEAR_EMISOR),0)  
      SET @nContador    = ISNULL((SELECT MIN(id) FROM #TMPLINEA_CHEQUEAR_EMISOR),0)  
  
      WHILE (@nRegistros >= @nContador)  
      BEGIN  
  
         SELECT @Id           = id  
         ,      @dFecPro      = Fecha  
         ,      @nRutcli      = RutEmisor  
         ,      @dFecvctop    = FechaVctoInst  
         ,      @nMonto       = Monto  
         ,      @cTipo_Riesgo = TipoRiesgo  
         ,      @nInCodigo    = Codigo  
         ,      @nMonedaOp    = Moneda  
         ,      @FormaPago    = FormaPago  
         ,      @MetodoLCR    = MetodologiaLCR   -- PRD8800
         FROM   #TMPLINEA_CHEQUEAR_EMISOR  
         WHERE  Id            = @nContador  
  
         IF @@ROWCOUNT = 0  
         BEGIN  
            BREAK  
         END  
  
         SET @nContador = @nContador + 1  
  
         EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cSistema  
                                                , @dFecPro  
                                                , @nRutcli  
                                                , 1  
                                                , @dFecvctop  
                                                , @nMonto  
                                                , @cTipo_Riesgo  
                                                , @cProducto  
                                                , @nInCodigo  
                                                , @nMonedaOp  
                                                , @FormaPago  
												, @MetodoLCR   -- PRD8800
      END --> While  
   END  
  
  
   --********** CHEQUEA LINEA CLIENTE *****************  
   IF @cCheckCli = 'S'  
   BEGIN  
      SELECT 'id'            = identity(INT)  
      ,      'Fecha'         = FechaOperacion  
      ,      'RutCliente'    = Rut_Cliente  
      ,      'CodCliente'    = Codigo_Cliente  
      ,      'FechaVcto'     = FechaVencimiento  
      ,      'Monto'         = SUM(MontoTransaccion)  
      ,      'TipoRiesgo'    = Tipo_Riesgo  
      ,      'Codigo'        = InCodigo  
      ,      'Moneda'        = MonedaOperacion  
      ,      'FormaPago'     = FormaPago  
      ,      'MetodologiaLCR' = MetodoLCR  -- PRD8800
      INTO   #TMPLINEA_CHEQUEAR_CLIENTE  
      FROM   LINEA_CHEQUEAR  --	with (nolock)  
      WHERE  NumeroOperacion = @nNumoper     
      AND    Id_Sistema      = @cSistema  
      GROUP BY  FechaOperacion, Rut_Cliente, Codigo_Cliente, FechaVencimiento, Tipo_Riesgo, InCodigo, MonedaOperacion, FormaPago, MetodoLCR   -- PRD8800
  
      CREATE INDEX #TMPLINEA_CHEQUEAR_CLIENTE_ID ON #TMPLINEA_CHEQUEAR_CLIENTE (id)  
  
      SET @nRegistros   = ISNULL((SELECT MAX(id) FROM #TMPLINEA_CHEQUEAR_CLIENTE),0)  
      SET @nContador    = ISNULL((SELECT MIN(id) FROM #TMPLINEA_CHEQUEAR_CLIENTE),0)  
  
      WHILE (@nRegistros >= @nContador)  
      BEGIN  
         SELECT @Id           = id  
         ,      @dFecPro      = Fecha  
         ,      @nRutcli      = RutCliente  
         ,      @nCodigo      = CodCliente  
         ,      @dFecvctop    = FechaVcto  
         ,      @nMonto       = Monto  
         ,      @cTipo_Riesgo = TipoRiesgo  
         ,      @nInCodigo    = Codigo  
         ,      @nMonedaOp    = Moneda  
         ,      @FormaPago    = FormaPago  
         ,      @MetodoLCR    = MetodologiaLCR   -- PRD8800
         FROM   #TMPLINEA_CHEQUEAR_CLIENTE  
         WHERE  Id            = @nContador  
  
         SET @nContador = @nContador + 1  
  
         IF @@ROWCOUNT = 0  
         BEGIN  
            BREAK  
         END  
  
         SET @nMonedaOp = 0  
         SET @FormaPago = 0  
  
         IF NOT (@cSistema = 'BTR' and @cProducto = 'ICOL')  
         BEGIN  
            SET @nInCodigo = 0  
         END  
  
         EXECUTE SP_LINEA_CHEQUEAR_LINEASCLIENTES @cSistema  
                                                , @dFecPro  
                                                , @nRutcli  
                                                , @nCodigo  
                                                , @dFecvctop  
                                                , @nMonto  
                                                , @cTipo_Riesgo  
                                                , @cProducto  
                                                , @nInCodigo  
                                                , @nMonedaOp  
                                                , @FormaPago  
                                                , @MetodoLCR   -- PRD8800
  
      END --> While  
  
   END  
  
END  
GO
