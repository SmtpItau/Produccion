USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_SORTEO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GENERA_SORTEO]
   (   @FechaArchivo   DATETIME    = '' 
   ,   @MiUsuario      VARCHAR(12) = 'ADMINISTRA'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @MiEstado   INTEGER

   DELETE  MdGestion..SORTEOS_LETRAS_L043
   WHERE   FechaCarga = @FechaArchivo

CREATE TABLE #Valorizacion
   (   Error      INTEGER
   ,   Mascara    VARCHAR(15)
   ,   Codigo     INTEGER
   ,   Serie      VARCHAR(15)
   ,   RutEmi     NUMERIC(10)
   ,   Monemi     INTEGER
   ,   Tasemi     FLOAT
   ,   Basemi     INTEGER
   ,   FecEmi     CHAR(10)
   ,   FecVen     CHAR(10)
   ,   RefNomi    CHAR(1)
   ,   Genemi     VARCHAR(10)
   ,   NemoMon    VARCHAR(5)
   ,   Corte      NUMERIC(21,4)
   ,   Seriado    CHAR(1)
   ,   Lecemi     VARCHAR(10)
   ,   FecPro     CHAR(10)
   )

CREATE TABLE #Res_Valorizacion
   (   fError      INTEGER
   ,   fNominal    FLOAT
   ,   fTir        FLOAT
   ,   fPvp        FLOAT
   ,   fMT         FLOAT
   ,   fMTUM       FLOAT
   ,   fMT_cien    FLOAT
   ,   fVan        FLOAT
   ,   fVpar       FLOAT
   ,   nNumucup    FLOAT
   ,   cFecucup    CHAR(10)
   ,   fIntucup    FLOAT
   ,   fAmoucup    FLOAT
   ,   fSalucup    FLOAT
   ,   nNumpcup    FLOAT
   ,   cFecpcup    CHAR(10)
   ,   fIntpcup    FLOAT
   ,   fAmopcup    FLOAT
   ,   fSalpcup    FLOAT
   ,   fDurat      FLOAT
   ,   fConvx      FLOAT
   ,   fDurmo      FLOAT
   )

   DECLARE @CtaBanco   VARCHAR(50)
   ,       @iNumOper   NUMERIC(10)

   DECLARE @modcal     INTEGER
   ,       @cFeccal    CHAR(10)
   ,       @nCodigo    INTEGER
   ,       @cMascara   CHAR(12)
   ,       @nMonemi    INTEGER
   ,       @cFecemi    CHAR(10)
   ,       @cFecven    CHAR(10)
   ,       @fTasemi    FLOAT
   ,       @fBasemi    FLOAT
   ,       @fTasest    FLOAT
   ,       @fNominal   FLOAT
   ,       @fTir       FLOAT
   ,       @fPvp       FLOAT
   ,       @fMT        FLOAT

   DECLARE @Series     INTEGER
   ,       @Serie      INTEGER
   ,       @Documentos INTEGER
   ,       @Documento  INTEGER
   ,       @iSorteo    NUMERIC(21,4)
   ,       @Nominal    NUMERIC(21,4)
   ,       @Pesos      NUMERIC(21,0)
   ,       @NomInf     NUMERIC(21,4)

   SELECT @CtaBanco  = Cuenta_Dcv
   FROM   MdGestion..CUENTAS_DCV 
   WHERE  RutCliente = 97023000
   AND    CodCliente = 1
   AND    CtaBac     = 'S'

   DECLARE @iFound       INTEGER
   ,       @FecCalculo   DATETIME

   SELECT  @iFound       = -1
   SELECT  DISTINCT 
           @iFound       = 0
   ,       @FecCalculo   = feceve
   FROM    MdGestion..L043
   WHERE   FecCar        = @FechaArchivo
   AND     NomBac        > 0.0
   AND     CtaDcv        = @CtaBanco

   IF @iFound = -1
   BEGIN
      SELECT -1 , 'No Existen Sorteos a Partir de la Fecha Enviada o bién no Existe Cuenta Dcv Relacionada'
      RETURN -1
   END

   SELECT  SerIns        as SerieSorteo
   ,       SUM(NomSor)   as NominalSorteo
   ,       SUM(MtoPos)   as PesosSorteo
   ,       Identity(Int) as Sorteo
   INTO    #SeriesSorteadas
   FROM    MdGestion..L043
   WHERE   FecCar        = @FechaArchivo
   AND     NomBac        > 0.0
   AND     CtaDcv        = @CtaBanco
   GROUP BY SerIns

   IF NOT EXISTS(SELECT 1 FROM #SeriesSorteadas)
   BEGIN
      SELECT -1 , 'No hay sorteos a la fecha.'
      RETURN -1
   END

   -- Proceso de Anulación de Operaciones                --
   -- En el caso de que el Proceso se haya corrido antes --
   DECLARE @iRegis   INTEGER
   ,       @iConta   INTEGER
   ,       @iNum     NUMERIC(10)

   UPDATE BacTraderSuda..MDAC
   SET    acint_rcc   = 0 --> Indica que se subio el Archivo L043

   SELECT DISTINCT monumoper as Operacion
   ,      identity(Int)      as Correlativo
   INTO   #ANULAR
   FROM   BacTraderSuda..MDMOPM 
   WHERE  mofecpro   = @FecCalculo
   AND    moterminal = 'MDGEST' 
   AND    mostatreg <> 'A'
  
   SELECT  @iRegis   = MAX(Correlativo)
   ,       @iConta = MIN(Correlativo)
   FROM    #ANULAR

   WHILE   @iRegis >= @iConta
   BEGIN
      SELECT  @iNum = Operacion FROM #ANULAR WHERE Correlativo = @iConta
      EXECUTE BacTraderSuda..SP_LLAMAPROCESO @iNum , 'VP' , 97023000
   
      SET @iConta = @iConta + 1
   END

   SELECT Sorteo                     as OrdenSeries
   ,      d.diinstser                as cSerie
   ,      NominalSorteo              as NominalSorteado
   ,      PesosSorteo                as PesosSorteados
   ,      d.dinominal                as iNominal
   ,      d.divptirc                 as iPesos
   ,      d.ditircomp                as iTirCom
   ,      d.dinumdocu                as iDocu
   ,      d.dicorrela                as iCorrela
   ,      p.cpfeccomp                as cFecComp
   ,      CASE WHEN d.codigo_carterasuper = 'P' THEN 1
               WHEN d.codigo_carterasuper = 'T' THEN 2
               WHEN d.codigo_carterasuper = 'A' THEN 3
          END                        as cCartera
   ,      CONVERT(NUMERIC(21,4),0.0) as NominalOcupado 
   ,      CONVERT(NUMERIC(21,0),0.0) as PesosReferenciales
   ,      CONVERT(NUMERIC(21,4),0.0) as TirSorteo
   ,      'N'                        as Diferencias
   ,      CONVERT(INTEGER,0)         as CorrVenta
   INTO   #PASO_DETALLE_SORTEO
   FROM   BacTraderSuda..MDDI            d
          RIGHT JOIN #SeriesSorteadas       ON SerieSorteo = d.diinstser
          LEFT  JOIN BacTraderSuda..MDCP p  ON p.cpnumdocu = d.dinumdocu and p.cpcorrela = d.dicorrela
   WHERE  d.dinominal           > 0
   AND    d.ditipoper           = 'CP'
   AND    d.codigo_carterasuper IN('P','T','A')
   ORDER BY CASE WHEN d.codigo_carterasuper = 'P' THEN 1
                 WHEN d.codigo_carterasuper = 'T' THEN 2
                 WHEN d.codigo_carterasuper = 'A' THEN 3
            END
   ,        d.ditircomp DESC
   ,        d.dinominal DESC

   SELECT identity(int) AS Puntero , * INTO #DETALLE_SORTEO 
   FROM   #PASO_DETALLE_SORTEO

   SELECT  @Series     = MAX(OrdenSeries)
   ,       @Serie      = MIN(OrdenSeries)
   ,       @Documentos = 0
   ,       @Documento  = 0
   FROM    #DETALLE_SORTEO

   DECLARE @CorrVenta   INTEGER

   WHILE   @Series >= @Serie
   BEGIN
      SELECT @Documentos = MAX(Puntero)
      ,      @Documento  = MIN(Puntero)
      ,      @cMascara   = MIN(cSerie)
      ,      @CorrVenta  = 0
      FROM   #DETALLE_SORTEO
      WHERE  OrdenSeries = @Serie
      
      WHILE @Documentos >= @Documento
      BEGIN
         SELECT @CorrVenta  = @CorrVenta + 1

         SELECT @iSorteo    = NominalSorteado 
         ,      @Nominal    = iNominal
         FROM   #DETALLE_SORTEO
         WHERE  OrdenSeries = @Serie
         AND    Puntero     = @Documento

         UPDATE #DETALLE_SORTEO 
         SET    NominalOcupado     = CASE WHEN @iSorteo < @Nominal THEN @iSorteo
                                          ELSE                          @Nominal
                                     END
         ,      CorrVenta          = @CorrVenta
         WHERE  OrdenSeries        = @Serie and Puntero  = @Documento

         UPDATE #DETALLE_SORTEO 
         SET    PesosReferenciales = ((NominalOcupado/NominalSorteado) * PesosSorteados)
         WHERE  OrdenSeries        = @Serie and Puntero  = @Documento         

         SELECT @Nominal       = SUM(NominalOcupado)
         FROM   #DETALLE_SORTEO
         WHERE  OrdenSeries    = @Serie
         AND    Puntero       <= @Documento

         IF @Nominal >= @iSorteo
            DELETE #DETALLE_SORTEO WHERE  OrdenSeries = @Serie and Puntero > @Documento

         IF @Nominal > @iSorteo
         BEGIN
            UPDATE #DETALLE_SORTEO 
            SET    NominalOcupado     = CASE WHEN @iSorteo = @Nominal THEN @iSorteo
                                             WHEN @iSorteo < @Nominal THEN iNominal- (@Nominal - @iSorteo)
                                        END
            WHERE  OrdenSeries        = @Serie and Puntero = @Documento

            UPDATE #DETALLE_SORTEO  
            SET    PesosReferenciales = ((NominalOcupado / NominalSorteado ) * PesosSorteados)
            WHERE  OrdenSeries        = @Serie and Puntero = @Documento

            SELECT @Documento     = @Documentos + 1
         END

         SET @Documento = @Documento + 1
      END

      IF @cMascara <> ''
      BEGIN
         INSERT INTO #Valorizacion EXECUTE BacTraderSuda..SP_CHKINSTSER @cMascara
      
         IF @@ERROR <> 0
         BEGIN
            SELECT -2 , 'Problemas al traer los datos para valorizar ' + @cMascara
            RETURN -2
         END

         SELECT @iSorteo = SUM(NominalOcupado)
         ,      @Pesos   = SUM(PesosReferenciales)
         ,      @NomInf  = MIN(NominalSorteado)
         FROM   #DETALLE_SORTEO
         WHERE  cSerie   = @cMascara
         GROUP BY cSerie

         IF @iSorteo <> @NomInf 
            UPDATE #DETALLE_SORTEO SET Diferencias = 'S' WHERE OrdenSeries = @Serie

         SELECT @modcal     = 3
         ,      @cFeccal    = convert(char(10),@FecCalculo,112)
         ,      @nCodigo    = Codigo
         ,      @cMascara   = Mascara
         ,      @nMonemi    = Monemi
         ,      @cFecemi    = FecEmi
         ,      @cFecven    = FecVen
         ,      @fTasemi    = Tasemi
         ,      @fBasemi    = Basemi
         ,      @fTasest    = 0.0
         ,      @fNominal   = @iSorteo
         ,      @fTir       = 0.0
         ,      @fPvp       = 0.0
         ,      @fMT        = @Pesos
         FROM   #Valorizacion

         INSERT INTO #Res_Valorizacion
         EXECUTE BacTraderSuda..SP_VALORIZAR_CLIENT @modcal   , @cFeccal , @nCodigo , @cMascara , @nMonemi 
                                                  , @cFecemi  , @cFecven , @fTasemi , @fBasemi  , @fTasest
                                                  , @fNominal , @fTir    , @fPvp    , @fMT

         UPDATE #DETALLE_SORTEO 
         SET    TirSorteo = fTir 
         FROM   #Res_Valorizacion
         WHERE  cSerie    = @cMascara

         UPDATE BacTraderSuda..MDAC
         SET    acnumoper = acnumoper + 1

         SELECT @iNumOper = 0
         SELECT @iNumOper = acnumoper 
         FROM   BacTraderSuda..MDAC

         INSERT INTO MdGestion..SORTEOS_LETRAS_L043
         SELECT FechaCarga          = @FechaArchivo
         ,      nNumOper   	    = @iNumOper
         ,      nRutCart   	    = 97023000
         ,      nTipCart   	    = 1
         ,      nNumDocu   	    = S.iDocu
         ,      nCorrela   	    = S.iCorrela
         ,      nNominal   	    = S.NominalOcupado -- @iSorteo
         ,      nTir       	    = S.TirSorteo
         ,      nPvp       	    = V.fPvp
         ,      nVpar      	    = V.fVpar
         ,      nVptirv    	    = PesosReferenciales -- @Pesos
         ,      nNumuCup   	    = V.nNumucup
         ,      nRutCli    	    = 97023000
         ,      nCodCli    	    = 1
         ,      cFecPro    	    = @FechaArchivo
         ,      nTasEst    	    = 0.0
         ,      nMonemi    	    = @nMonemi
         ,      nRutEmi    	    = se.serutemi
         ,      nTasEmi    	    = @fTasemi
         ,      nBasemi    	    = @fBasemi
         ,      cTipCust   	    = 'D'
         ,      nForPagi   	    = 128
         ,      cRetiro    	    = 'I'
         ,      cUsuario   	    = @MiUsuario
         ,      cTerminal  	    = 'MDGEST'
         ,      cMascara   	    = SUBSTRING(@cMascara,1,6)
         ,      cInstser   	    = @cMascara
         ,      cGenemi   	    = em.emgeneric
         ,      cNemoMon   	    = mn.mnnemo
         ,      cFecEmi   	    = CONVERT(DATETIME,@cFecemi,103)
         ,      cFecVen   	    = CONVERT(DATETIME,@cFecven,103)
         ,      nCodigo   	    = 20
         ,      nCorrVent           = CorrVenta
         ,      ClaveDcv            = ' '
         ,      nCarteraSuper       = 'T'
,      nCarteraFinanciera  = 1
         ,      nMercado   	    = 'S'
         ,      Sucursal   	    = 'VICUÑ'
         ,      Sistema             = 6
         ,      FechaPagoMañana     = @FechaArchivo
         ,      Laminas   	    = 'N'
         ,      TipoInversion       = ' '
         ,      Observ    	    = ' '
         ,      IdLibro		    = 1
         ,      FechaSorteo         = @cFeccal
         ,      VctoReal            = @cFeccal
         ,      nNominalInf         = NominalSorteado
         ,      nPesosInf           = PesosSorteados
         ,      VtaCompleta         = S.Diferencias
         ,      Enviado             = 'N'
         FROM   #DETALLE_SORTEO   S
         ,      #Res_Valorizacion V
                LEFT JOIN BacParamSuda..SERIE  se ON se.semascara = substring(@cMascara,1,6)
                LEFT JOIN BacParamSuda..EMISOR em ON em.emrut     = se.serutemi
                LEFT JOIN bacParamSuda..MONEDA mn ON mn.mncodmon  = @nMonemi
         WHERE  S.cSerie  = @cMascara

         DELETE FROM #Res_Valorizacion
         DELETE FROM #Valorizacion

      END

      SET @Serie = @Serie + 1
   END

   SELECT  @MiEstado   = 0
   EXECUTE BacTraderSuda..APLICAR_SORTEO @FechaArchivo , @MiUsuario 

   IF @MiEstado = 0
   BEGIN
      SELECT 0, 'Traspaso de Sorteos de Letras ha Finalizado Correctamente.'
   END ELSE
   BEGIN
      SELECT -1 , 'Problemas en en Traspaso de los Sorteos Generados.'
   END

   UPDATE BacTraderSuda..MDAC
   SET    acint_rcc   = 1 --> Indica que se subio el Archivo L043

END

GO
