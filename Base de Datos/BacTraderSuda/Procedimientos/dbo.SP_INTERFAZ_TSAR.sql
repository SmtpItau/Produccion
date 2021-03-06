USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_TSAR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_TSAR]
               ( @tipo  CHAR(1) )
AS
BEGIN  	
         SET NOCOUNT ON
DECLARE @regs           integer       ,
        @cont           integer       ,
        @ndocumento     numeric(10)   ,
        @operacion      numeric(10)   ,
        @correla        numeric(5)    ,
        @fecha_vcto     datetime      ,
        @serie          char(10)      ,
        @seriado        char(1)       ,
        @moneda         char(3)       ,
        @security       char(4)       ,
        @instrum        numeric(5)    ,
        @nominal        float         ,
        @pvc            float         ,
        @tir            float         ,
        @vpresente      float         ,
        @vmoneda        float         ,
        @fecha_hoy      datetime      ,
        @fecha_liq      datetime      ,
        @trader         char(20)      ,
        @cliente        char(20)      ,
        @rut_cliente    numeric(10)   ,
        @codigo_rut     numeric(5)    ,
        @status         char(5)       ,
        @broker         char(20)      ,
        @tipo_opera     char(4)       ,
        @cod_moneda     numeric(4)    ,
        @cod_moneda2    numeric(4)    ,
        @dias           numeric(2)    ,
        @forma_pago     numeric(2)    ,
        @estado         char(1)
SELECT @fecha_hoy = acfecproc FROM MDAC
/* GENERA POSITION -------------------------------------------------------------------- */
IF @tipo = 'P'
BEGIN
   CREATE TABLE #POSITION( type          char(5)       null default '',
                           book          char(20)      null default '',
                           posdate       char(8)       null default '',
                           asset_name    char(40)      null default '',
                           amount        numeric(20,5) null default 0 ,
                           last_prc      numeric(20,5) null default 0 ,
                           subtype       char(5)       null default '')
   /* CARTERA PROPIA TRADER ----------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM MDCP WHERE cpnominal > 0.0
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @ndocumento  = cpnumdocu,
             @correla     = cpcorrela,
             @serie       = cpinstser,
             @nominal     = cpnominal,
             @fecha_vcto  = cpfecven,  
             @instrum     = cpcodigo,
             @seriado     = cpseriado,
             @vpresente   = cpvptirc
        FROM MDCP
       WHERE cpnominal > 0.0
      SET ROWCOUNT 0
      SELECT @pvc = 0.0
      IF @seriado = 'N'
      BEGIN
         SELECT @cod_moneda = nsmonemi
           FROM VIEW_NOSERIE
          WHERE nsnumdocu = @ndocumento
            and nscorrela = @correla
         IF @cod_moneda <> 999
         BEGIN
            SELECT @vmoneda = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @cod_moneda and vmfecha = @fecha_hoy
            IF @vmoneda = 0.0 OR @vmoneda IS NULL
               SELECT @vmoneda = 1.0
            SELECT @vpresente = ROUND(@vpresente / @vmoneda, 2)
         END
         SELECT @pvc = ROUND((@vpresente / @nominal) * 100.0,4)
      END
      ELSE
         SELECT @pvc = ISNULL(mmpvp,0.0)
           FROM MDMM
          WHERE mminstser = @serie
            and mmnumdocu = @ndocumento
            and mmnumoper = @ndocumento
            and mmcorrela = @correla
      SELECT @security = insecuritytype2
        FROM VIEW_INSTRUMENTO
       WHERE incodigo = @instrum
      INSERT #POSITION( type,
                        book,
                        posdate,
                        asset_name,
                        amount,
                        last_prc,
                        subtype )
                VALUES( 'FI',
                        'SANTIAGO',
                        CONVERT(CHAR(8),@fecha_vcto,112),
                        @serie,
                        @nominal,
                        @pvc,
                        @security )
      SELECT @cont = @cont + 1
   END  
   /* CARTERA INTERMEDIADA TRADER ----------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM MDVI
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @ndocumento  = vinumdocu,
             @operacion   = vinumoper,
             @correla     = vicorrela,
             @serie       = viinstser,
             @nominal     = vinominal,
             @fecha_vcto  = vifecven,
             @instrum     = vicodigo,
             @vpresente   = vivptirc
        FROM MDVI
      SET ROWCOUNT 0
      SELECT @pvc = 0.0
      IF @seriado = 'N'
      BEGIN
         SELECT @cod_moneda = nsmonemi
           FROM VIEW_NOSERIE
          WHERE nsnumdocu = @ndocumento
            and nscorrela = @correla
         IF @cod_moneda <> 999
         BEGIN
            SELECT @vmoneda = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @cod_moneda AND vmfecha = @fecha_hoy
            IF @vmoneda = 0.0 or @vmoneda IS NULL
               SELECT @vmoneda = 1.0
            SELECT @vpresente = ROUND( @vpresente / @vmoneda, 2)
         END
         SELECT @pvc = ROUND((@vpresente / @nominal) * 100.0,4)
      END
      ELSE
         SELECT @pvc = ISNULL(mmpvp,0.0)
           FROM MDMM
          WHERE mminstser = @serie
            and mmnumdocu = @ndocumento
            and mmnumoper = @ndocumento
            and mmcorrela = @correla
      SELECT @security = insecuritytype2
        FROM VIEW_INSTRUMENTO
       WHERE incodigo = @instrum
      INSERT #POSITION( type,
                        book,
                        posdate,
                        asset_name,
                        amount,
                        last_prc,
                        subtype )
                VALUES( 'FI',
                        'SANTIAGO',
                        CONVERT(CHAR(8),@fecha_vcto,112),
                        @serie,
                        @nominal,
                        @pvc,
                        @security )
      SELECT @cont = @cont + 1
   END  
   /* COMPRAS CON PACTO --------------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM MDCI
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @serie       = ciinstser,
             @nominal     = (CASE WHEN ciinstser = 'ICAP' OR ciinstser = 'ICOL' THEN civalvenp ELSE cinominal END),
             @fecha_vcto  = cifecvenp,
             @pvc         = citaspact
        FROM MDCI
      SET ROWCOUNT 0
      IF @serie = 'ICOL'
         SELECT @security = 'MM'
      ELSE
      BEGIN
         IF @serie = 'ICAP' 
            SELECT @security = 'DEP'
         ELSE
            SELECT @security = 'REPO'
      END
      INSERT #POSITION( type,
                        book,
                        posdate,
                        asset_name,
                        amount,
                        last_prc,
                        subtype )
                VALUES( 'FI',
                        'SANTIAGO',
                        CONVERT(CHAR(8),@fecha_vcto,112),
                        @serie,
                        @nominal,
                        @pvc,
                        @security )
      SELECT @cont = @cont + 1
   END  
   /* VENTAS CON PACTO ---------------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM MDVI
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @serie       = viinstser,
             @nominal     = vinominal,
             @fecha_vcto  = vifecvenp,
             @pvc         = vitaspact
        FROM MDVI
      SET ROWCOUNT 0
      SELECT @security = 'REPO'
      INSERT #POSITION( type,
                        book,
                        posdate,
                        asset_name,
                        amount,
                        last_prc,
                        subtype )
                VALUES( 'FI',
                        'SANTIAGO',
                        CONVERT(CHAR(8),@fecha_vcto,112),
                        @serie,
                        @nominal,
                        @pvc,
                        @security )
      SELECT @cont = @cont + 1
   END  
   /* CAPTACIONES --------------------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM GEN_CAPTACION WHERE estado = ' '
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @serie       = (CASE moneda 
                             WHEN 999 THEN 'CLP' 
                             WHEN 998 THEN 'CLF'
                             ELSE          'USD'
                            END),
             @nominal     = monto_final,
             @fecha_vcto  = fecha_vencimiento,
             @pvc         = tasa
        FROM GEN_CAPTACION
       WHERE estado = ' '
      SET ROWCOUNT 0
      SELECT @security = 'DEP'
      INSERT #POSITION( type,
                        book,
                        posdate,
                        asset_name,
                        amount,
                        last_prc,
                        subtype )
                VALUES( 'FI',
                        'SANTIAGO',
                        CONVERT(CHAR(8),@fecha_vcto,112),
                        @serie,
                        @nominal,
                        @pvc,
                        @security )
      SELECT @cont = @cont + 1
   END
   /* FORWARD ------------------------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM VIEW_MFCA WHERE cafecvcto > @fecha_hoy
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @cod_moneda = cacodmon1,
             @nominal    = camtomon1,
             @pvc        = catipcam
        FROM VIEW_MFCA
       WHERE cafecvcto > @fecha_hoy
      SET ROWCOUNT 0
      SELECT @serie = mnsimbol
        FROM VIEW_MONEDA 
       WHERE mncodmon = @cod_moneda
      SELECT @security = 'NDF'
      INSERT #POSITION( type,
                        book,
                        posdate,
                        asset_name,
                        amount,
                        last_prc,
                        subtype )
                VALUES( 'FX',
                        'SANTIAGO',
                        CONVERT(CHAR(8),@fecha_hoy,112),
                        @serie,
                        @nominal,
                        @pvc,
                        @security )
      SELECT @cont = @cont + 1
   END  
   /* SPOT ---------------------------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM VIEW_MEPOS WHERE vmfecha = @fecha_hoy and vmposic <> 0.0
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @serie      = vmcodigo,
             @nominal    = vmposic
        FROM VIEW_MEPOS
       WHERE vmfecha  = @fecha_hoy
         and vmposic <> 0.0
      SET ROWCOUNT 0
      SELECT @pvc = 0.0
      SELECT @pvc = vmvalor
        FROM VIEW_VALOR_MONEDA
       WHERE vmcodigo = 988
         and vmfecha  = @fecha_hoy
      SELECT @security = 'PHYS'
      INSERT #POSITION( type,
                        book,
                        posdate,
                        asset_name,
                        amount,
                        last_prc,
                        subtype )
                VALUES( 'FX',
                        'SANTIAGO',
                        CONVERT(CHAR(8),@fecha_hoy,112),
                        @serie,
                        @nominal,
                        @pvc,
                        @security )
      SELECT @cont = @cont + 1
   END  
   /* RETORNA INFORMACION ------------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM #POSITION
   SELECT @regs, * FROM #POSITION
END
/* GENERA TRADES ---------------------------------------------------------------------- */
IF @tipo = 'T'
BEGIN
   CREATE TABLE #TRADES( deal          numeric(8)    null default 0 ,
                         type          char(5)       null default '',
                         asset_name    char(40)      null default '',
                         ccy1          char(3)       null default '',
                         ccy2          char(3)       null default '',
                         amount        numeric(20,5) null default 0 ,
                         price         numeric(20,5) null default 0 ,
                         counterpart   char(20)      null default '' ,
                         trader        char(20)      null default '',
                         broker        char(20)      null default '',
                         status        char(5)       null default '',
                         trade_date    char(8)       null default '',
                         settle_date   char(8)       null default '',
                         start_date    char(8)       null default '',
                         maturity_date char(8)       null default '',
                         premium       char(20)      null default '',
                         premium_ccy   char(3)       null default '',
                         subtype       char(5)       null default '')
   SELECT @broker = ''
   /* MOVIMIENTOS TRADER -------------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM MDMO
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @operacion   = monumoper,
             @correla     = mocorrela,
             @serie       = moinstser,
             @fecha_vcto  = (CASE WHEN motipoper = 'CP' OR motipoper = 'VP' THEN mofecven ELSE mofecvenp END),
             @nominal     = monominal,
             @pvc         = (CASE WHEN motipoper = 'CP' OR motipoper = 'VP' THEN mopvp ELSE motaspact END),
             @trader      = mousuario,
             @cod_moneda  = momonemi,
             @rut_cliente = morutcli,
             @codigo_rut  = mocodcli,
             @instrum     = mocodigo,
             @tipo_opera  = motipoper,
             @forma_pago  = moforpagi,
             @vpresente   = movpresen,
             @estado      = mostatreg,
             @seriado     = moseriado
        FROM MDMO
      SET ROWCOUNT 0
      SELECT @moneda = mnsimbol
        FROM VIEW_MONEDA 
       WHERE mncodmon = @cod_moneda
      SELECT @cliente = ISNULL(clnombre,'')
        FROM VIEW_CLIENTE
       WHERE clrut    = @rut_cliente
         and clcodigo = @codigo_rut
      SELECT @dias = 0
      SELECT @dias = ISNULL(diasvalor,0) FROM VIEW_FORMA_DE_PAGO WHERE codigo = @forma_pago
      EXECUTE Sp_Busca_Fecha_Habil @fecha_hoy, @dias, @fecha_liq OUTPUT
      IF @tipo_opera = 'CP' OR @tipo_opera = 'VP' OR @tipo_opera = 'IB'
         SELECT @security = insecuritytype2
           FROM VIEW_INSTRUMENTO
          WHERE incodigo = @instrum
      ELSE
      BEGIN
         IF @tipo_opera = 'IC'
            SELECT @security = 'DEP'
         ELSE
            SELECT @security = 'REPO'
      END
      IF @estado = 'A'
         SELECT @status = 'CANCEL'
      ELSE
         SELECT @status = 'NEW'
      IF @seriado = 'N'
      BEGIN
         IF @cod_moneda <> 999
         BEGIN
            SELECT @vmoneda = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @cod_moneda and vmfecha = @fecha_hoy
            IF @vmoneda = 0.0 or @vmoneda IS NULL
               SELECT @vmoneda = 1.0
            SELECT @vpresente = ROUND(@vpresente / @vmoneda, 2)
         END
         SELECT @pvc = ROUND((@vpresente / @nominal) * 100.0,4)
 END
      SELECT @ndocumento = CONVERT(NUMERIC(8), LTRIM(STR(@operacion)) + LTRIM(STR(@correla))) 
     
      INSERT #TRADES( deal,
                      type,
                      asset_name,
                      ccy1,
                      ccy2,
                      amount,
                      price,
                      counterpart,
                      trader,
                      broker,
                      status,
                      trade_date,
                      settle_date,
                      start_date,
                      maturity_date,
                      premium,
                      premium_ccy,
                      subtype )
              VALUES( @ndocumento,
                      'fi',
                      @serie,
                      @moneda,
                      '',
                      @nominal,
                      @pvc,
                      @cliente,
                      @trader,
                      @broker,
                      @status,
                      CONVERT(CHAR(8),@fecha_hoy,112),
                      CONVERT(CHAR(8),@fecha_liq,112),
                      CONVERT(CHAR(8),@fecha_hoy,112),
                      CONVERT(CHAR(8),@fecha_vcto,112),
                      '',
                      '',
                      @security )
      SELECT @cont = @cont + 1
   END  
   /* MOVIMIENTOS FORWARD ------------------------------------------------------------- */
   SELECT @regs = COUNT(*) FROM VIEW_MFCA WHERE cafecha = @fecha_hoy
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @operacion   = canumoper,
             @rut_cliente = cacodigo,
             @codigo_rut  = cacodcli,
             @fecha_vcto  = cafecvcto,
             @forma_pago  = cafpagomn,
             @cod_moneda  = cacodmon1,
             @cod_moneda2 = cacodmon2,
             @nominal     = camtomon1,
             @pvc         = catipcam,
             @trader      = caoperador
        FROM VIEW_MFCA
       WHERE cafecha = @fecha_hoy
      SET ROWCOUNT 0
      SELECT @cliente = ISNULL(clnombre,'')
        FROM VIEW_CLIENTE
       WHERE clrut    = @rut_cliente
         and clcodigo = @codigo_rut
      SELECT @serie = mnsimbol
        FROM VIEW_MONEDA 
       WHERE mncodmon = @cod_moneda
      SELECT @moneda = mnsimbol
        FROM VIEW_MONEDA 
       WHERE mncodmon = @cod_moneda2
      SELECT @dias = 0
      SELECT @dias = ISNULL(diasvalor,0) FROM VIEW_FORMA_DE_PAGO WHERE codigo = @forma_pago
      EXECUTE Sp_Busca_Fecha_Habil @fecha_vcto, @dias, @fecha_liq OUTPUT
      SELECT @security = 'NDF'
      SELECT @status   = 'NEW'
      INSERT #TRADES( deal,
                      type,
                      asset_name,
                      ccy1,
                      ccy2,
                      amount,
                      price,
                      counterpart,
                      trader,
                      broker,
                      status,
                      trade_date,
                      settle_date,
                      start_date,
                      maturity_date,
                      premium,
                      premium_ccy,
                      subtype )
              VALUES( @operacion,
                      'FX',
                      @serie,
                      @moneda,
                      '',
                      @nominal,
                      @pvc,
                      @cliente,
                      @trader,
                      @broker,
                      @status,
                      convert(char(8),@fecha_hoy,112),
                      convert(char(8),@fecha_liq,112),
                      convert(char(8),@fecha_hoy,112),
                      convert(char(8),@fecha_vcto,112),
                      '',
                      '',
                      @security )
      SELECT @cont = @cont + 1
   END  
   /* MOVIMIENTOS PUNTA Y EMPRESAS SPOT ----------------------------------------------- */
   SELECT @regs = COUNT(*) FROM VIEW_MEMO
   SELECT @cont = 1
   WHILE @cont <= @regs
   BEGIN
      SET ROWCOUNT @cont
      SELECT @operacion   = monumope,
             @rut_cliente = morutcli,
             @codigo_rut  = mocodcli,
             @serie       = mocodmon,
             @moneda      = mocodcnv,
             @dias        = datediff(day, @fecha_hoy, movaluta1),
             @nominal     = momonmo,
             @pvc         = moticam,
             @trader      = mooper
        FROM VIEW_MEMO
      SET ROWCOUNT 0
      SELECT @cliente = ISNULL(clnombre,'')
        FROM VIEW_CLIENTE
       WHERE clrut    = @rut_cliente
         and clcodigo = @codigo_rut
      SELECT @fecha_liq = DATEADD(day, @dias, @fecha_hoy)
      SELECT @security = 'PHYS'
      SELECT @status   = 'NEW'
      INSERT #TRADES( deal,
                      type,
                      asset_name,
                      ccy1,
                      ccy2,
                      amount,
                      price,
                      counterpart,
                      trader,
                      broker,
                      status,
                      trade_date,
                      settle_date,
                      start_date,
                      maturity_date,
                      premium,
                      premium_ccy,
                      subtype )
              VALUES( @operacion,
                      'FX',
                      @serie,
                      @moneda,
                      '',
                      @nominal,
                      @pvc,
                      @cliente,
                      @trader,
                      @broker,
                      @status,
                      convert(char(8),@fecha_hoy,112),
                      convert(char(8),@fecha_liq,112),
                      convert(char(8),@fecha_hoy,112),
                      convert(char(8),@fecha_hoy,112),
                      '',
                      '',
                      @security )
      SELECT @cont = @cont + 1
   END  
   /* RETORNA INFORMACION ------------------------------------------------------------- */
    SET NOCOUNT OFF
   SELECT @regs = COUNT(*) FROM #TRADES
   SELECT @regs, * FROM #TRADES
END
END   /* FIN PROCEDIMIENTO */
--SP_INTERFAZ_TSAR 'T'
--SELECT * FROM MDMO


GO
