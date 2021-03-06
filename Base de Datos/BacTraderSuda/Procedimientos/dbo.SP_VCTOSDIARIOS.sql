USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTOSDIARIOS]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VCTOSDIARIOS]
   (   @entidad     FLOAT
   ,   @tipreporte  FLOAT
   ,   @cTitulo01   VARCHAR(80)
   ,   @cTitulo02   VARCHAR(80)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dfecpro DATETIME
   select @dfecpro = CONVERT(CHAR(10),acfecproc,112) from MDAC --20190708.RCHS.Lentitud reporte Vcto Renta Fija 
   
   SELECT 'acfecproc'   = acfecproc
   ,      'acfecprox'   = acfecprox
   ,      'uf_hoy'      = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 998)
   ,      'uf_man'      = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 998)
   ,      'ivp_hoy'     = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 997)
   ,      'ivp_man'     = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 997)
   ,      'do_hoy'      = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 994)
   ,      'do_man'      = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 994)
   ,      'da_hoy'      = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 995)
   ,      'da_man'      = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 995)
   ,      'acnomprop'   = acnomprop
   ,      'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
   INTO   #PARAMETROS
   FROM   MDAC

   IF @tipreporte = 1 /** Vencimiento de Cupones **/
   BEGIN
      SELECT DISTINCT
             'acfecproc'  = CONVERT(CHAR(10),acfecproc,103)
      ,      'acfecprox'  = CONVERT(CHAR(10),acfecprox,103)
      ,      'uf_hoy'     = uf_hoy
      ,      'uf_man'     = uf_man
      ,      'ivp_hoy'    = ivp_hoy
      ,      'ivp_man'    = ivp_man
      ,      'do_hoy'     = do_hoy
      ,      'do_man'     = do_man
      ,      'da_hoy'     = da_hoy
      ,      'da_man'     = da_man
      ,      'acnomprop'  = acnomprop
      ,      'rut_empresa'= rut_empresa
      ,      'hora'       = CONVERT(VARCHAR(10), GETDATE(), 108)
      ,      'cartera'    = rcnombre
      ,      'numdocu'    = LTRIM(STR(rsnumoper)) + '-' + LTRIM(STR(rscorrela))
      ,      'instser'    = rsinstser
      ,      'nominal'    = rsnominal
      ,      'moneda'     = m1.mnnemo
      ,      'interes'    = rscupint
      ,      'reajuste'   = rscupamo
      ,      'montopago'  = case when rstipoper = 'VC' THEN rsflujo 
                                 else                       rsvppresenx
                            end
      ,      'montoinicio'= rsvppresen
      ,      'familia'    = inserie
      ,      'cliente'    = CONVERT(VARCHAR(40),'')
      ,      'formapago'  = CONVERT(VARCHAR(40),'')
      ,      'fecinic'    = CONVERT(CHAR(10),rsfeccomp,103)
      ,      'tasa'       = 0
      ,      'monpacto'   = m1.mnnemo
      INTO   #PASO1
      FROM   MDRS
             LEFT  JOIN VIEW_MONEDA M1   ON m1.mncodmon = rsmonemi
             INNER JOIN VIEW_ENTIDAD     ON rcrut       = rsrutcart
             LEFT  JOIN VIEW_INSTRUMENTO ON incodigo    = rscodigo 
      ,      #PARAMETROS
      WHERE  rsfecha         = @dfecpro	--20190708.RCHS.Lentitud reporte Vcto Renta Fija acfecproc 
      AND    rsfecvcto       = @dfecpro	--20190708.RCHS.Lentitud reporte Vcto Renta Fija acfecproc
      AND    rstipoper       IN('VC', 'VCP')
      AND    rsinstser  NOT IN('ICOL','ICAP')
      AND    rscartera      IN(111,114)
      AND   (rsrutcart       = @entidad
          OR @entidad        = 0)


      IF NOT EXISTS(SELECT 1 FROM #PASO1)
      BEGIN
         INSERT INTO #PASO1
         SELECT DISTINCT
                'acfecproc'  = CONVERT(CHAR(10),acfecproc,103)
         ,      'acfecprox'  = CONVERT(CHAR(10),acfecprox,103)
         ,      'uf_hoy'     = uf_hoy
         ,      'uf_man'     = uf_man
         ,      'ivp_hoy'    = ivp_hoy
         ,      'ivp_man'    = ivp_man
         ,      'do_hoy'     = do_hoy
         ,      'do_man'     = do_man
         ,      'da_hoy'     = da_hoy
         ,      'da_man'     = da_man
         ,      'acnomprop'  = acnomprop
         ,      'rut_empresa'= rut_empresa
         ,      'hora'       = CONVERT(VARCHAR(10), GETDATE(), 108)
         ,      'cartera'    = ''
         ,      'numdocu'    = ''
         ,      'instser'    = ''
         ,      'nominal'    = 0
         ,      'moneda'     = ''
         ,      'interes'    = 0
         ,      'reajuste'   = 0
         ,      'montopago'  = 0
         ,      'montoinicio'= 0
         ,      'familia'    = ''
         ,      'cliente'    = ''
         ,      'formapago'  = ''
         ,      'fecinic'    = ''
         ,      'tasa'       = 0
         ,      'monpacto'   = ''
         FROM  #PARAMETROS
      END

      SELECT *
      ,      'Titulo01' = @cTitulo01 
      ,      'Titulo02' = @cTitulo02
      FROM #PASO1

      RETURN
   END
   
   IF @tipreporte = 2 /** Vencimiento de Interbancarios **/
   BEGIN
      SELECT 'acfecproc'  = CONVERT(CHAR(10),acfecproc,103)
      ,      'acfecprox'  = CONVERT(CHAR(10),acfecprox,103)
      ,      'uf_hoy'     = uf_hoy
      ,      'uf_man'     = uf_man
      ,      'ivp_hoy'    = ivp_hoy
      ,      'ivp_man'    = ivp_man
      ,      'do_hoy'     = do_hoy
      ,      'do_man'     = do_man
      ,      'da_hoy'     = da_hoy
      ,      'da_man'     = da_man
      ,      'acnomprop'  = acnomprop
      ,      'rut_empresa'= rut_empresa
      ,      'hora'       = CONVERT(VARCHAR(10), GETDATE(), 108)
      ,      'cartera'    = rcnombre
      ,      'numdocu'    = LTRIM(STR(rsnumoper))+'-'+LTRIM(STR(rscorrela))
      ,      'instser'    = rsinstser
      ,      'nominal'    = ROUND(rsnominal,m2.mndecimal)
      ,      'moneda'     = m1.mnnemo
      ,      'interes'    = ROUND(rsinteres,m2.mndecimal)
      ,      'reajuste'   = ROUND(rsreajuste,m2.mndecimal)
      ,      'montopago'  = ROUND(rsvppresenx,m2.mndecimal)
      ,      'montoinicio'= ROUND(rsvppresen,m2.mndecimal)
      ,      'familia'    = rsinstser
      ,      'cliente'    = clnombre
      ,      'FormaPago'  = glosa
      ,      'FecInic'    = CONVERT(CHAR(10),rsfeccomp,103)
      ,      'Tasa'       = rstir
      ,      'MonPacto'   = m2.mnnemo    
      INTO   #PASO2
      FROM   MDRS
             LEFT JOIN VIEW_CLIENTE       ON clrut       = rsrutcli AND clcodigo = rscodcli
             LEFT JOIN VIEW_MONEDA M1     ON m1.mncodmon = rsmonemi
             LEFT JOIN VIEW_MONEDA M2     ON m2.mncodmon = rsmonpact 
            INNER JOIN VIEW_ENTIDAD       ON rcrut       = rsrutcart
             LEFT JOIN VIEW_FORMA_DE_PAGO ON codigo      = rsforpagv
       ,     #PARAMETROS
      WHERE  rsfecha      =  @dfecpro--20190708.RCHS.Lentitud reporte Vcto Renta Fija acfecproc
      AND    rstipoper    = 'VC' 
      AND    rsinstser  IN('ICOL','ICAP')
      AND   (rsrutcart    = @entidad
          OR @entidad     = 0) 

      IF NOT EXISTS(SELECT 1 FROM #PASO2)
      BEGIN
         INSERT INTO #PASO2
         SELECT 'acfecproc'  = CONVERT(CHAR(10),acfecproc,103)
         ,      'acfecprox'  = CONVERT(CHAR(10),acfecprox,103)
         ,      'uf_hoy'     = uf_hoy
         ,      'uf_man'     = uf_man
         ,      'ivp_hoy'    = ivp_hoy
         ,      'ivp_man'    = ivp_man
         ,      'do_hoy'     = do_hoy
         ,      'do_man'     = do_man
         ,      'da_hoy'     = da_hoy
         ,      'da_man'     = da_man
         ,      'acnomprop'  = acnomprop
         ,      'rut_empresa'= rut_empresa
         ,      'hora'       = CONVERT(VARCHAR(10), GETDATE(), 108)
         ,      'cartera'    = ''
         ,      'numdocu'    = ''
         ,      'instser'    = ''
         ,      'nominal'    = 0
         ,      'moneda'     = ''
         ,      'interes'    = 0
         ,      'reajuste'   = 0
         ,      'montopago'  = 0
         ,      'montoinicio'= 0
         ,      'familia'    = ''
         ,      'cliente'    = ''
         ,      'FormaPago'  = ''
         ,      'FecInic'    = ''
         ,      'Tasa'       = 0
         ,      'MonPacto'   = ''
         FROM   #PARAMETROS
      END

      SELECT *    
         ,   'Titulo01' = @cTitulo01 
         ,   'Titulo02' = @cTitulo02
      FROM   #PASO2

      RETURN
   END

   IF @tipreporte = 3 /** Vencimiento de Pactos **/
   BEGIN
         SELECT 'acfecproc'  = CONVERT(CHAR(10),acfecproc,103)
         ,      'acfecprox'  = CONVERT(CHAR(10),acfecprox,103)
         ,      'uf_hoy'     = uf_hoy
         ,      'uf_man'     = uf_man
         ,      'ivp_hoy'    = ivp_hoy
         ,      'ivp_man'    = ivp_man
         ,      'do_hoy'     = do_hoy
         ,      'do_man'     = do_man
         ,      'da_hoy'     = da_hoy
         ,      'da_man'     = da_man
         ,      'acnomprop'  = acnomprop
         ,      'rut_empresa'= rut_empresa
         ,      'hora'       = CONVERT(VARCHAR(10), GETDATE(), 108)
         ,      'cartera'    = rcnombre
         ,      'numdocu'    = LTRIM(STR(monumoper))+'-'+LTRIM(STR(mocorrela))
         ,      'instser'    = moinstser
         ,      'nominal'    = monominal
         ,      'moneda'     = m1.mnnemo
         ,      'interes'    = ROUND(mointpac,  m2.mndecimal)
         ,      'reajuste'   = ROUND(moreapac,  m2.mndecimal)
         ,      'montopago'  = ROUND(movalvenp, m2.mndecimal)
         ,      'montoinicio'= ROUND(movalinip, m2.mndecimal)
         ,      'familia'    = inserie
         ,      'cliente'    = clnombre
         ,      'formapago'  = CASE WHEN moforpagv = 6 THEN Clctacte
                                    WHEN moforpagv = 7 THEN Clctacte
                                    ELSE                    glosa
                               END
         ,      'fecinic'    = CONVERT(CHAR(10),mofecinip,103)
         ,      'Tasa'       = motaspact
         ,      'MonPacto'   = m2.mnnemo
         INTO    #PASO3
         FROM    MDMO
                 INNER JOIN VIEW_CLIENTE       ON clrut       = morutcli AND clcodigo = mocodcli
                 INNER JOIN VIEW_MONEDA    M1  ON m1.mncodmon = momonemi 
                 INNER JOIN VIEW_MONEDA    M2  ON m2.mncodmon = momonpact 
                 INNER JOIN VIEW_INSTRUMENTO   ON incodigo    = mocodigo 
                 INNER JOIN VIEW_ENTIDAD       ON rcrut       = morutcart
                 INNER JOIN VIEW_FORMA_DE_PAGO ON codigo      = moforpagv
         ,       #PARAMETROS
         WHERE   CHARINDEX(motipoper,'RC -RV -RCA-RVA') > 0 
         AND    (@entidad    = 0 OR morutcart = @entidad) 


      IF (SELECT COUNT(*) FROM #PASO3) = 0
      BEGIN
         INSERT INTO #PASO3
         SELECT 'acfecproc'  = CONVERT(CHAR(10),acfecproc,103)
         ,      'acfecprox'  = CONVERT(CHAR(10),acfecprox,103)
         ,      'uf_hoy'     = uf_hoy
         ,      'uf_man'     = uf_man
         ,      'ivp_hoy'    = ivp_hoy
         ,      'ivp_man'    = ivp_man
         ,      'do_hoy'     = do_hoy
         ,      'do_man'     = do_man
         ,      'da_hoy'     = da_hoy
         ,      'da_man'     = da_man
         ,      'acnomprop'  = acnomprop
         ,      'rut_empresa'= rut_empresa
         ,      'hora'       = CONVERT(VARCHAR(10), GETDATE(), 108)
         ,      'cartera'    = ''
         ,      'numdocu'    = ''
         ,      'instser'    = ''
         ,      'nominal'    = 0
         ,      'moneda'     = ''
         ,      'interes'    = 0
         ,      'reajuste'   = 0
         ,      'montopago'  = 0
         ,      'montoinicio'= 0
         ,      'familia'    = ''
         ,      'cliente'    = ''
         ,      'FormaPago'  = ''
         ,      'FecInic'    = ''
         ,      'Tasa'       = 0
         ,      'MonPacto'   = ''
         FROM #PARAMETROS
      END

      SELECT * , 'Titulo01' = @cTitulo01 
               , 'Titulo02' = @cTitulo02
        FROM #PASO3

      RETURN
   END

   IF @tipreporte = 4 /** Vencimiento de Pasivos **/
   BEGIN
      SELECT 'acfecproc'  = CONVERT(CHAR(10),acfecproc,103)
      ,      'acfecprox'  = CONVERT(CHAR(10),acfecprox,103)
      ,      'uf_hoy'     = uf_hoy
      ,      'uf_man'     = uf_man
      ,      'ivp_hoy'    = ivp_hoy
      ,      'ivp_man'    = ivp_man
      ,      'do_hoy'     = do_hoy
      ,      'do_man'     = do_man
      ,      'da_hoy'     = da_hoy
      ,      'da_man'     = da_man
      ,      'acnomprop'  = acnomprop
      ,      'rut_empresa'= rut_empresa
      ,      'hora'       = CONVERT(VARCHAR(10), GETDATE(), 108)
      ,      'cartera'    = rcnombre
      ,      'numdocu'    = LTRIM(STR(rsnumoper))+'-'+LTRIM(STR(rscorrela))
      ,      'instser'    = rsinstser
      ,      'nominal'    = rsnominal
      ,      'moneda'     = m1.mnnemo
      ,      'interes'    = ROUND(rscupint,   m2.mndecimal)
      ,      'reajuste'   = ROUND(rscupamo,   m2.mndecimal)
      ,      'montopago'  = ROUND(rsvppresenx,m2.mndecimal)
      ,      'montoinicio'= ROUND(rsvppresen, m2.mndecimal)
      ,      'familia'    = inserie
      ,      'cliente'    = CONVERT(VARCHAR(40),'')
      ,      'formapago'  = CONVERT(VARCHAR(40),'')
      ,      'fecinic'    = CONVERT(CHAR(10),rsfeccomp,103)
      ,      'tasa'       = 0
      ,      'monpacto'   = m2.mnnemo
      INTO   #PASO4
      FROM MDRS
           INNER JOIN VIEW_MONEDA M1   ON m1.mncodmon = rsmonemi
           INNER JOIN VIEW_MONEDA M2   ON m2.mncodmon = rsmonpact
           INNER JOIN VIEW_INSTRUMENTO ON incodigo    = rscodigo 
           INNER JOIN VIEW_ENTIDAD     ON rcrut       = rsrutcart
         , #PARAMETROS
      WHERE rsfecha     >=  @dfecpro--20190708.RCHS.Lentitud reporte Vcto Renta Fija acfecproc
      AND   rstipoper    = 'VC' 
      AND   rscartera    = '211'
      AND  (@entidad     = 0 OR rsrutcart = @entidad) 

      IF (SELECT COUNT(*) FROM #PASO4)=0
      BEGIN
         INSERT INTO #PASO4
         SELECT 'acfecproc'  = CONVERT(CHAR(10),acfecproc,103)
         ,      'acfecprox'  = CONVERT(CHAR(10),acfecprox,103)
         ,      'uf_hoy'     = uf_hoy
         ,      'uf_man'     = uf_man
         ,      'ivp_hoy'    = ivp_hoy
         ,      'ivp_man'    = ivp_man
         ,      'do_hoy'     = do_hoy
         ,      'do_man'     = do_man
         ,      'da_hoy'     = da_hoy
         ,      'da_man'     = da_man
         ,      'acnomprop'  = acnomprop
         ,      'rut_empresa'= rut_empresa
         ,      'hora'       = CONVERT(VARCHAR(10), GETDATE(), 108)
         ,      'cartera'    = ''
         ,      'numdocu'    = ''
         ,      'instser'    = ''
         ,      'nominal'    = 0
         ,      'moneda'     = ''
         ,      'interes'    = 0
         ,      'reajuste'   = 0
         ,      'montopago'  = 0
         ,      'montoinicio'= 0
         ,      'familia'    = ''
         ,      'cliente'    = ''
         ,      'FormaPago'  = ''
         ,      'FecInic'    = ''
         ,      'Tasa'       = 0
         ,      'MonPacto'   = ''
         FROM #PARAMETROS
      END

      SELECT * , 'Titulo01' = @cTitulo01 
               , 'Titulo02' = @cTitulo02
       FROM #PASO4

      RETURN
   END

END
GO
