USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZACION_CARTERA_IBS]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALORIZACION_CARTERA_IBS]
   (   @iProceso  INTEGER
   ,   @dFecpro   DATETIME
   ,   @iNumDocu  INTEGER   = 0
   )
AS
BEGIN

   SET NOCOUNT ON

CREATE TABLE #VALORIZACION_IBS_TMP
   (   Fecha         DATETIME      NOT NULL DEFAULT('')
   ,   Serie         VARCHAR(12)   NOT NULL DEFAULT('')
   ,   Codigo        INTEGER       NOT NULL DEFAULT(0)
   ,   RutCartera    NUMERIC(10)   NOT NULL DEFAULT(0)
   ,   NumDocu       NUMERIC(10)   NOT NULL DEFAULT(0)
   ,   NumCorrela    INTEGER       NOT NULL DEFAULT(0)
   ,   RutEmisor     NUMERIC(10)   NOT NULL DEFAULT(0)
   ,   Moneda        INTEGER       NOT NULL DEFAULT(0)
   ,   Nominal       NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   Tasa          NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   vPresente     NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   TasaMTM1      NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   vMercado1     NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   DifMTM1       NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   TasaMTM2      NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   vMercado2     NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   DifMTM2       NUMERIC(21,4) NOT NULL DEFAULT(0.0)
   ,   FechaEmision  DATETIME      NOT NULL DEFAULT('')
   ,   FechaVcto     DATETIME      NOT NULL DEFAULT('')
   ,   Procediminto  VARCHAR(50)   NOT NULL DEFAULT('')
   ,   Puntero       INTEGER Identity(1,1)
   )

   DECLARE @acfecproc    DATETIME
   ,       @acfecprox    DATETIME
   ,       @dfecfmes     DATETIME
   ,       @dFecFMesProx DATETIME

   SELECT  @acfecproc   = acfecproc
   ,	   @acfecprox   = acfecprox
   FROM	   MDAC

   SELECT @dfecfmes     = DATEADD(DAY,DATEPART(DAY,@acfecprox)    * -1,@acfecprox)
   SELECT @dFecFMesProx = DATEADD(MONTH,1,@acfecprox)
   SELECT @dFecFMesProx = DATEADD(DAY,DATEPART(DAY,@dFecFMesProx) * -1,@dFecFMesProx)

   IF EXISTS(SELECT 1 FROM VALORIZACION_IBS WHERE Fecha = @dFecpro)
   BEGIN
      IF @iProceso = 1
         DELETE FROM VALORIZACION_IBS WHERE Fecha = @dFecpro
   END

   INSERT INTO #VALORIZACION_IBS_TMP
   SELECT /*01*/ 'Fecha'         = @dFecpro
   ,      /*02*/ 'Serie'         = car.Serie
   ,      /*03*/ 'Codigo'        = ins.incodigo
   ,      /*04*/ 'RutCartera'    = 97023000
   ,      /*05*/ 'NumDocu'       = car.NumeroDeposito
   ,      /*06*/ 'NumCorrela'    = 1
   ,      /*07*/ 'RutEmisor'     = 97023000
   ,      /*08*/ 'Moneda'        = car.Moneda
   ,      /*09*/ 'Nominal'       = car.MontoInicial
   ,      /*10*/ 'Tasa'          = car.TasaInteres
   ,      /*11*/ 'vPresente'     = 0.0
   ,      /*12*/ 'TasaMTM1'      = ISNULL(cur.Tasa,0.0)
   ,      /*13*/ 'vMercado1'     = 0.0
   ,      /*14*/ 'DifMTM1'       = 0.0
   ,      /*15*/ 'TasaMTM2'      = 0.0
   ,      /*16*/ 'vMercado2'     = 0.0
   ,      /*17*/ 'DifMTM2'       = 0.0
   ,      /*18*/ 'FechaEmision'  = car.FechaEmisión
   ,      /*19*/ 'FechaVcto'     = car.FechaVencimiento
   ,      /*20*/ 'Procediminto'  = 'SP_' + LTRIM(RTRIM(ins.inprog))
   FROM    CARTERA_DEPOSITOS_IBS               car 
           LEFT JOIN BacParamSuda..INSTRUMENTO ins ON inserie    = SUBSTRING(Serie,1,3)
           LEFT JOIN CURVA_CAPTACIONES_IBS     cur ON car.Moneda = cur.Moneda 
                                                 AND (DATEDIFF(DAY,@dFecpro,car.FechaVencimiento) BETWEEN cur.PlazoDesde and cur.PlazoHasta)
           -- Falta Incluir Tabla de Relación Cobertura, Para Generar Registros Solo de Operaciones Asociadas.-
   WHERE   car.NumeroDeposito    = @iNumDocu or @iNumDocu = 0

   DECLARE @iRegistro   INTEGER
   ,       @iContador   INTEGER

   SELECT  @iRegistro   = MAX(Puntero)
   ,       @iContador   = MIN(Puntero)
   FROM    #VALORIZACION_IBS_TMP

   IF @iProceso = 1
   BEGIN
      SELECT @iRegistro 
      ,      Serie
      ,      RutEmisor
      ,      FechaVcto
      ,      TasaMTM1
      ,      NumDocu
      ,      Moneda
      ,      DATEDIFF(DAY,@dFecpro,FechaVcto)
      FROM   #VALORIZACION_IBS_TMP

      RETURN
   END

CREATE TABLE #VALINS
   (      fError      INTEGER
   ,      fNominal    FLOAT
   ,      fTir        FLOAT
   ,      fPvp        FLOAT
   ,      fMT         FLOAT
   ,      fMTUM       FLOAT
   ,      fMT_cien    FLOAT
   ,      fVan        FLOAT
   ,      fVpar       FLOAT
   ,      nNumucup    INTEGER
   ,      cFecucup    CHAR(10)
   ,      fIntucup    FLOAT
   ,      fAmoucup    FLOAT
   ,      fSalucup    FLOAT
   ,      nNumpcup    INTEGER
   ,      cFecpcup    CHAR(10)
   ,      fIntpcup    FLOAT
   ,      fAmopcup    FLOAT
   ,      fSalpcup    FLOAT
   ,      fDurat      FLOAT
   ,      fConvx      FLOAT
   ,      fDurmo      FLOAT
   )

   DECLARE @modcal      INTEGER
   ,       @cFeccal     CHAR(10)
   ,       @nCodigo     INTEGER
   ,       @cMascara    CHAR(12)
   ,       @nMonemi     INTEGER
   ,       @cFecemi     CHAR(10)
   ,       @cFecven     CHAR(10)
   ,       @fTasemi     FLOAT
   ,       @fBasemi     FLOAT
   ,       @fTasest     FLOAT
   ,       @fNominal    FLOAT
   ,       @fTir        FLOAT
   ,       @fPvp        FLOAT
   ,       @fMT         FLOAT
   ,       @iTasMer     FLOAT
 
   WHILE @iRegistro >= @iContador --> 01
   BEGIN

      SELECT @modcal      = 2
      ,      @cFeccal     = CONVERT(CHAR(10),@dFecpro,112)
      ,      @nCodigo     = Codigo
      ,      @cMascara    = Serie
      ,      @nMonemi     = Moneda
      ,      @cFecemi     = CONVERT(CHAR(10),FechaEmision,112)
      ,      @cFecven     = CONVERT(CHAR(10),FechaVcto,112)
      ,      @fTasemi     = 0.0
      ,      @fBasemi     = CASE WHEN Moneda = 999 THEN 30 ELSE 360 END
      ,      @fTasest     = 0.0
      ,      @fNominal    = Nominal
      ,      @fTir        = Tasa
      ,      @fPvp        = 0.0
      ,      @fMT         = 0.0
      ,      @iTasMer     = TasaMTM1
      FROM   #VALORIZACION_IBS_TMP 
      WHERE  Puntero      = @iContador

      INSERT INTO #VALINS
      EXECUTE BacTraderSuda..SP_VALORIZAR_CLIENT @modcal
                                 ,               @cFeccal
                                 ,               @nCodigo
                                 ,               @cMascara
                                 ,               @nMonemi
                                 ,               @cFecemi
                                 ,               @cFecven
                                 ,               @fTasemi
                                 ,               @fBasemi
                                 ,               @fTasest
                                 ,               @fNominal
                                 ,               @fTir
                                 ,               @fPvp
                                 ,               @fMT

      UPDATE #VALORIZACION_IBS_TMP
      SET    vPresente           = fMT
      FROM   #VALINS

      DELETE #VALINS

      INSERT INTO #VALINS
      EXECUTE BacTraderSuda..SP_VALORIZAR_CLIENT @modcal
                                 ,               @cFeccal
                                 ,               @nCodigo
                                 ,               @cMascara
                                 ,               @nMonemi
                                 ,               @cFecemi
                                 ,               @cFecven
                                 ,               @fTasemi
                                 ,               @fBasemi
                                 ,               @fTasest
                                 ,               @fNominal
                                 ,               @iTasMer
                                 ,               @fPvp
                                 ,               @fMT

      UPDATE #VALORIZACION_IBS_TMP
      SET    vMercado1           = fMT
      FROM   #VALINS

      UPDATE #VALORIZACION_IBS_TMP
      SET    DifMTM1             = (vPresente  - vMercado1)
      FROM   #VALINS

      SELECT @iContador = @iContador + 1
   END                              --> 01

   INSERT INTO VALORIZACION_IBS
   SELECT 'Fecha'         = Fecha
   ,      'Serie'         = Serie
   ,      'Codigo'        = Codigo
   ,      'RutCartera'    = RutCartera
   ,      'NumDocu'       = NumDocu
   ,      'NumCorrela'    = NumCorrela
   ,      'RutEmisor'     = RutEmisor
   ,      'Moneda'        = Moneda
   ,      'Nominal'       = Nominal
   ,      'Tasa'          = Tasa
   ,      'vPresente'     = vPresente
   ,      'TasaMTM1'      = TasaMTM1
   ,      'vMercado1'     = vMercado1
   ,      'DifMTM1'       = DifMTM1
   ,      'TasaMTM2'      = TasaMTM2
   ,      'vMercado2'     = vMercado2
   ,      'DifMTM2'       = DifMTM2
   ,      'FechaEmision'  = FechaEmision
   ,      'FechaVcto'     = FechaVcto
   FROM   #VALORIZACION_IBS_TMP

END



GO
