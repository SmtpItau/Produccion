USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_BACMETRICS_IRF]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_BACMETRICS_IRF]
       (
        @fecha1      DATETIME
       )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @fecha        DATETIME
   DECLARE @dFecProc     DATETIME
   DECLARE @dFecProx     DATETIME
   DECLARE @dFecAnte     DATETIME
   DECLARE @dFechaDev    DATETIME
   DECLARE @ValorUfAyer  FLOAT
   SELECT @fecha = CONVERT(DATETIME, @fecha1, 121)
   ------------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------------
   SELECT      @dFecProc = acfecproc,
               @dFecProx = acfecprox,
               @dFecAnte = acfecante
          FROM mdac
   ------------------------------------------------------------------------------------------
   -- INICIALIZA ARCHIVO DE CARTERA Y FLUJOS
   ------------------------------------------------------------------------------------------
   DELETE bmportafolio       WHERE sistema = 'BTR' AND fecha = @fecha
   DELETE bmportafolioflujos WHERE sistema = 'BTR' AND fecha = @fecha
   ------------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------------
   SELECT       @ValorUfAyer = vmvalor 
          FROM  VIEW_VALOR_MONEDA
          WHERE vmcodigo = 998 AND vmfecha = @dFecAnte
   ------------------------------------------------------------------------------------------
   -- Genera la fecha de cierre de mes.
   ------------------------------------------------------------------------------------------
   SELECT @dFechaDev = DATEADD( DAY, DATEPART( DAY, @dFecProx ) * -1, @dFecProx )
   ------------------------------------------------------------------------------------------
   -- Revisa que no sea un cierre de mes especial.
   ------------------------------------------------------------------------------------------
   IF @dFecProc < @dFechaDev AND @dFecProx > @dFechaDev BEGIN
      ------------------------------------------------------------------------------------------
      -- CARTERA DE COMPRAS PROPIAS
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolio
             SELECT       @fecha          , --1
                          rsrutcart          , --2
                          'BTR'           , --3
                          'RF'           , --4
                          'CP'                                                      , --5
                          CONVERT(CHAR(8),rsnumdocu)+'-'+CONVERT(CHAR(2),rscorrela) , --6       
                          inserie                                                   , --7
                          rsinstser                                                 , --8
                          MDRS.codigo_carterasuper                            , --9
                          rsnominal                                                 , --10
                          rstir                                                     , --11
                          ISNULL( CASE
                                       WHEN inmdse='S' THEN (SELECT sebasemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                       ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                                  END,0)                                                                        , --12
                          0                                                                                            , --13
                          ISNULL(CASE
                                       WHEN inmdse='S' THEN (SELECT semonemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                       ELSE (SELECT nsmonemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                                 END,0),                    -- 14
                          999,                              -- 15 Faltan DPX otras monedas
                          0,                                -- 16
                          rsfeccomp,                        -- 17
                          rsfecvcto,                        -- 18
                          rsvalcomp,                        -- 19
                          0,                                -- 20
                          '0',                              -- 21 Falta Cuenta Contable
                          rsvalcomu,                        -- 22
                          rsvalcomp,                        -- 23
                          rsinteres_acum,                   -- 24 Interes UM
                          rsinteres_acum,                   -- 25
                          rsreajuste_acum,                  -- 26
                          rsvppresenx,                      -- 27
                          'NA',                             -- 28
                          0,                                -- 29
                          rsfecemis,                        -- 30
                          ISNULL(CASE
                                      WHEN inmdse='S' THEN (SELECT setasemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                      ELSE (SELECT nstasemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                                 END,0.0)                                                                     , --31
                          ISNULL(CASE
                                      WHEN inmdse='S' THEN (SELECT sebasemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                      ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                                 END,0)                                                                                            , --32
                          ISNULL(CASE
                                     WHEN inmdse='S' THEN (SELECT serutemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                     ELSE (SELECT nsrutemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                                END,0)                                                                                            , --33
                          digenemi                              , --34
                          rsrutcli                              , --35
                          rscodcli                              , --36
                          rsmascara                             , --37
                          inmdse                                , --38
                          0                                     , --39
                          rsdurmod                              , --40
                          ''                                    , --41
                          ''                                    , --42
                          ''                                    ,   --43
     0,
     0
                    FROM  MDRS, MDDI, VIEW_INSTRUMENTO
                    WHERE rsfecha    = @dFechaDev   AND
                          rscartera  = '111'        AND
          rstipoper  = 'DEV'        AND
                          rsnominal  > 0            AND
                          rsrutcart  > 0            AND
                          rsfecvcto >= @fecha       AND
                          incodigo   = rscodigo     AND
                          dirutcart  = rsrutcart    AND
                          dinumdocu  = rsnumdocu    AND
                          dicorrela  = rscorrela    AND
                          ditipoper  = 'CP'
      ------------------------------------------------------------------------------------------
      -- INSTRUMENTOS SERIADOS DE LA CARTERA PROPIA. 'DISPONIBLES'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolioflujos
             SELECT       fffecha   = @fecha,
                          ffrutcart = rsrutcart,
                          ffsistema = 'BTR',
                          ffproducto= 'RF',
                          fftipoper = 'CP',
                          ffnumoper = CONVERT(CHAR(8),rsnumdocu)+'-'+CONVERT(CHAR(2),rscorrela),
                          ffcupon   = tdcupon,
                          fffecven  =(CASE WHEN secodigo=20 THEN DATEADD(mm, tdcupon*sepervcup, rsfecemis ) ELSE tdfecven END),
                          ffamort   = tdamort  /100.0 * rsnominal,
                          ffinteres = tdinteres/100.0 * rsnominal,
                          ffmoneda  = semonemi,
                          ffactpas  = 'A',
                          fftipoflu = MDRS.codigo_carterasuper,
                          fftasaper = setasemi,
                          ffbaseper = sebasemi,
     0,
     0
                    FROM  mdrs, VIEW_TABLA_DESARROLLO mdtd, VIEW_SERIE mdse, VIEW_INSTRUMENTO mdin
                    WHERE rsfecha    = @dFechaDev   AND
                          rscartera  = '111'        AND
                          rstipoper  = 'DEV'        AND
                          rsnominal  > 0            AND
                          rsrutcart  > 0            AND
                          rsfecvcto >= @fecha       AND
                          incodigo   = rscodigo     AND
                          inmdse     =  'S'         AND
                          semascara  = rsmascara    AND
                          tdmascara  = rsmascara    AND
                          (CASE WHEN secodigo=20 THEN DATEADD(mm, tdcupon*sepervcup, rsfecemis ) ELSE tdfecven END) >= @fecha
      ------------------------------------------------------------------------------------------
      -- MDCP: INSTRUMENTOS NO SERIADOS DE LA CARTERA PROPIA. 'DISPONIBLES'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolioflujos
             SELECT       fffecha   = @fecha                       ,
                          ffrutcart = rsrutcart                       ,
                          ffsistema = 'BTR'                       ,
                          ffproducto= 'RF'                       ,
                          fftipoper = 'CP'                       ,
                          ffnumoper = CONVERT(CHAR(8),rsnumdocu)+'-'+CONVERT(CHAR(2),rscorrela) ,
                          ffcupon                         = 1                                              ,
                          fffecven  = rsfecvcto                      ,
                          ffamort   = (CASE WHEN inprog='MD0550C' THEN (rsvppresenx/@ValorUfAyer) ELSE rsnominal END),
                          ffinteres = 0                                              ,
                          ffmoneda  = nsmonemi                       ,
                          ffactpas  = 'A'                                              ,
                          fftipoflu = MDRS.codigo_carterasuper,
                          fftasaper = nstasemi                       ,
                          ffbaseper = nsbasemi
   ,0,0
                    FROM  mdrs, VIEW_NOSERIE mdns, VIEW_INSTRUMENTO mdin
                    WHERE rsfecha    = @dFechaDev   AND
                          rscartera  = '111'        AND
                          rstipoper  = 'DEV'        AND
                          rsnominal  > 0            AND
                          rsrutcart  > 0            AND
                          rsfecvcto >= @fecha       AND
                          incodigo   = rscodigo     AND
                          inmdse     =  'N'         AND
                          nsrutcart  = rsrutcart    AND
                          nsnumdocu  = rsnumdocu    AND
                          nscorrela  = rscorrela
      ------------------------------------------------------------------------------------------
      -- MDVI : CARTERA DE INSTRUMENTOS DE LA CARTERA PROPIA. 'VENDIDOS CON PACTO'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolio
             SELECT       @fecha                                                                                            , --1
                          rsrutcart                                                                     , --2
                          'BTR'                                                                                            , --3
                          'RF'                                                                                            , --4
                          'VI'                                                                                            , --5
                          CONVERT(CHAR(8),rsnumdocu)+'-'+CONVERT(CHAR(2),rscorrela)+'-'+CONVERT(CHAR(8),rsnumoper) , --6
                          inserie                                                                                            , --7
                          rsinstser                                                                     , --8
                          MDRS.codigo_carterasuper                       , --9
                          rsnominal                                                                     , --10
                          rstir                                                                         , --11
                          ISNULL(CASE
                                                 WHEN inmdse='S' THEN (SELECT sebasemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                                 ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                          END,0)                                                                                            , --12
                          0                                                                                            , --13
                          ISNULL(CASE
                                                 WHEN inmdse='S' THEN (SELECT semonemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                                 ELSE (SELECT nsmonemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                          END,0)                                                                                            , --14
                          999                                                                                            , --15 Faltan DPX otras monedas
                          0                                                                                            , --16
                          rsfeccomp                                                                     , --17
                          rsfecvcto                                                                    , --18
                          rsvalcomp                                                                     , --19
                          rsvalvtop                                                                                   , --20
                          '0'                                                                                            , --21 Falta Cuenta Contable
                          rsvalcomu                                                                     , --22
                          rsvalcomp                                                                     , --23
                          rsinteres_acum                                                                 , --24 Interes UM
                          rsinteres_acum                                                                 , --25
                          rsreajuste_acum                                                                , --26
                          rsvppresenx                                                                  , --27
                          'NA'                                                                                            , --28
                          0                                                                                            , --29
                          rsfecemis                                                                     , --30
                          ISNULL(CASE
                                                 WHEN inmdse='S' THEN (SELECT setasemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                                 ELSE (SELECT nstasemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                          END,0.0)                                                                                            , --31
                          ISNULL(CASE
                                                 WHEN inmdse='S' THEN (SELECT sebasemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                                 ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                          END,0)                                                                                            , --32
                          ISNULL(CASE
                                      WHEN inmdse='S' THEN (SELECT serutemi FROM VIEW_SERIE WHERE rsmascara=semascara)
                                      ELSE (SELECT nsrutemi FROM VIEW_NOSERIE WHERE rsrutcart=nsrutcart AND rsnumdocu=nsnumdocu AND rscorrela=nscorrela)
                                 END,0)                                                                                            , --33
                          digenemi                                                                     , --34
                          rsrutcli                                                                     , --35
                          rscodcli                                                                     , --36
                          rsmascara                                                                     , --37
                          inmdse                                                                        , --38
                          0                                                                                            , --39
                          rsdurmod                                                                     , --40
                          ''                                                                                            , --41
                          ''                                                                                            , --42
                          ''   ,0,0                                                                                                 --43
                    FROM  MDRS, MDDI, VIEW_INSTRUMENTO
                    WHERE rsfecha    = @dFechaDev   AND
         rscartera  = '114'        AND
                          rstipoper  = 'DEV'        AND
                          rsnominal  > 0            AND
                          rsrutcart  > 0            AND
                          rsfecvtop >= @fecha       AND
                          incodigo   = rscodigo     AND
                          dirutcart  = rsrutcart    AND
                          dinumdocu  = rsnumdocu    AND
                          dicorrela  = rscorrela    AND
                          ditipoper  = 'CP'
      ------------------------------------------------------------------------------------------
      -- INSTRUMENTOS SERIADOS DE LA CARTERA PROPIA. 'VENDIDOS CON PACTO'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolioflujos
             SELECT       fffecha   = @fecha                       ,
                          ffrutcart = rsrutcart                       ,
                          ffsistema = 'BTR'                       ,
                          ffproducto= 'RF'                       ,
                          fftipoper = 'VI'                       ,
                          ffnumoper = CONVERT(CHAR(8),rsnumdocu)+'-'+CONVERT(CHAR(2),rscorrela)+'-'+CONVERT(CHAR(8),rsnumoper) ,
                          ffcupon   = tdcupon  ,
                          fffecven  =(CASE WHEN secodigo=20 THEN DATEADD(mm, tdcupon*sepervcup, rsfecemis ) ELSE tdfecven END),
                          ffamort   = tdamort  /100.0 * rsnominal ,
                          ffinteres = tdinteres/100.0 * rsnominal ,
                          ffmoneda  = semonemi,
                          ffactpas  = 'A',
                          fftipoflu = MDRS.codigo_carterasuper,
                          fftasaper = setasemi,
                          ffbaseper = sebasemi
   ,0,0
                    FROM  mdrs, mdcp, VIEW_TABLA_DESARROLLO mdtd, VIEW_SERIE mdse, VIEW_INSTRUMENTO mdin
                    WHERE rsfecha    = @dFechaDev   AND
                          rscartera  = '114'        AND
                          rstipoper  = 'DEV'        AND
                          rscodigo   = incodigo     AND
                          rsnominal  > 0            AND
                          rsrutcart  > 0            AND
                          rsfecvtop >= @fecha            AND
                          rsnumdocu = rsnumdocu          AND
                          rscorrela = rscorrela          AND
                          inmdse    = 'S'                AND
                          sefecven >= rsfecvcto          AND
                          semascara = rsmascara          AND
                          tdmascara = rsmascara          AND
                          (CASE WHEN secodigo=20 THEN DATEADD(mm, tdcupon*sepervcup, rsfecemis ) ELSE tdfecven END) >= @fecha
      ------------------------------------------------------------------------------------------
      -- INSTRUMENTOS NO SERIADOS DE LA CARTERA PROPIA. 'VENDIDOS CON PACTO'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolioflujos
             SELECT       fffecha   = @fecha                       ,
                          ffrutcart = rsrutcart                       ,
                          ffsistema = 'BTR'                       ,
                          ffproducto= 'RF'                       ,
                          fftipoper = 'VI'                       ,
                          ffnumoper = CONVERT(CHAR(8),rsnumdocu)+'-'+CONVERT(CHAR(2),rscorrela)+'-'+CONVERT(CHAR(8),rsnumoper) ,
                          ffcupon                         = 1                                              ,
                          fffecven  = cpfecven                       ,
                          ffamort   = rsnominal                       ,
                          ffinteres = 0                                   ,
                          ffmoneda  = nsmonemi,
                          ffactpas  = 'A',
                          fftipoflu = MDCP.codigo_carterasuper,
                          fftasaper = nstasemi,
                          ffbaseper = nsbasemi
   ,0,0
                    FROM  mdrs, mdcp, VIEW_NOSERIE mdns
                    WHERE rsfecha    = @dFechaDev   AND
                          rscartera  = '114'        AND
                          rstipoper  = 'DEV'        AND
                          rsnominal  > 0            AND
                          rsrutcart  > 0            AND
                          rsfecvtop >= @fecha         AND
                          cpnumdocu  = rsnumdocu      AND
                          cpcorrela  = rscorrela      AND
                          cpseriado  = 'N'            AND
                          nsrutcart  = cprutcart      AND
                          nsnumdocu  = cpnumdocu      AND
                          nscorrela  = cpcorrela      AND
                          nsfecven  >= @fecha
   END ELSE BEGIN
      ------------------------------------------------------------------------------------------
      -- CARTERA DE COMPRAS PROPIAS
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolio
             SELECT       @fecha, --1
                          cprutcart, --2
                          'BTR', --3
                          'RF', --4
                          'CP'                                                                                            , --5
                          CONVERT(CHAR(8),cpnumdocu)+'-'+CONVERT(CHAR(2),cpcorrela) , --6       
                          inserie                                                                                            , --7
                          cpinstser                                                                     , --8
                          MDCP.codigo_carterasuper                       , --9
                          cpnominal                                                                     , --10
                          cptircomp                                                                     , --11
                          ISNULL( CASE
                                       WHEN cpseriado='S' THEN (SELECT sebasemi FROM VIEW_SERIE WHERE cpmascara=semascara)
                                       ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND cpnumdocu=nsnumdocu AND cpcorrela=nscorrela)
                                  END,0)                                                                        , --12
                          0                                                                                            , --13
                          ISNULL(CASE
                                       WHEN cpseriado='S' THEN (SELECT semonemi FROM VIEW_SERIE WHERE cpmascara=semascara)
                                       ELSE (SELECT nsmonemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND cpnumdocu=nsnumdocu AND cpcorrela=nscorrela)
                                 END,0),                    -- 14
                          999,                              -- 15 Faltan DPX otras monedas
                          0,                                -- 16
                          cpfeccomp,                        -- 17
                          cpfecven,                         -- 18
                          cpvalcomp,                        -- 19
                          0,                                -- 20
                          '0',                              -- 21 Falta Cuenta Contable
                          cpvalcomu,                        -- 22
                          cpvalcomp,                        -- 23
                          cpinteresc,                       -- 24 Interes UM
                 cpinteresc,                       -- 25
                          cpreajustc,                       -- 26
                          cpvptirc,                         -- 27
                          'NA',                             -- 28
                          0,                                -- 29
                          cpfecemi,                         -- 30
                          ISNULL(CASE
                                      WHEN cpseriado='S' THEN (SELECT setasemi FROM VIEW_SERIE WHERE cpmascara=semascara)
                                      ELSE (SELECT nstasemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND cpnumdocu=nsnumdocu AND cpcorrela=nscorrela)
                                 END,0.0)                                                                     , --31
                          ISNULL(CASE
                                      WHEN cpseriado='S' THEN (SELECT sebasemi FROM VIEW_SERIE WHERE cpmascara=semascara)
                                      ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND cpnumdocu=nsnumdocu AND cpcorrela=nscorrela)
                                 END,0)                                                                                            , --32
                          ISNULL(CASE
                                     WHEN cpseriado='S' THEN (SELECT serutemi FROM VIEW_SERIE WHERE cpmascara=semascara)
                                     ELSE (SELECT nsrutemi FROM VIEW_NOSERIE WHERE cprutcart=nsrutcart AND cpnumdocu=nsnumdocu AND cpcorrela=nscorrela)
                                END,0)                                                                                            , --33
                          digenemi                                                                     , --34
                          cprutcli                                                                     , --35
                          cpcodcli                                                                     , --36
                          cpmascara                                                                     , --37
                          cpseriado                                                                     , --38
                          0                                                                                            , --39
                          cpdurmod                                                                     , --40
                          ''                                                                                            , --41
                          ''                                                                                            , --42
                          ''                                                                                              --43
   ,0,0
                    FROM  MDCP, MDDI, VIEW_INSTRUMENTO
                    WHERE cpnominal  > 0            AND
                          cprutcart  > 0            AND
                          cpfecven  >= @fecha                        AND
                          incodigo   = cpcodigo     AND
                          dirutcart  = cprutcart    AND
                          dinumdocu  = cpnumdocu    AND
                          dicorrela  = cpcorrela    AND
                          ditipoper  = 'CP'
      ------------------------------------------------------------------------------------------
      -- INSTRUMENTOS SERIADOS DE LA CARTERA PROPIA. 'DISPONIBLES'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolioflujos
             SELECT       fffecha   = @fecha,
                          ffrutcart = cprutcart,
                          ffsistema = 'BTR',
                          ffproducto= 'RF',
                          fftipoper = 'CP',
                          ffnumoper = CONVERT(CHAR(8),cpnumdocu)+'-'+CONVERT(CHAR(2),cpcorrela),
                          ffcupon   = tdcupon,
                          fffecven  =(CASE WHEN secodigo=20 THEN DATEADD(mm, tdcupon*sepervcup, cpfecemi ) ELSE tdfecven END),
                          ffamort   = tdamort  /100.0 * cpnominal,
                          ffinteres = tdinteres/100.0 * cpnominal,
                          ffmoneda  = semonemi,
                          ffactpas  = 'A',
                          fftipoflu = MDCP.codigo_carterasuper,
                          fftasaper = setasemi,
                          ffbaseper = sebasemi
   ,0,0
                    FROM  mdcp, VIEW_TABLA_DESARROLLO mdtd, VIEW_SERIE mdse
                    WHERE cpseriado  =  'S'                AND
                          cpnominal  >  0                  AND
                          cprutcart  >  0                  AND
                          cpfecven  >= @fecha              AND
                          semascara  = cpmascara           AND
                          tdmascara  = cpmascara           AND
                          (CASE WHEN secodigo=20 THEN DATEADD(mm, tdcupon*sepervcup, cpfecemi ) ELSE tdfecven END) >= @fecha
      ------------------------------------------------------------------------------------------
      -- MDCP: INSTRUMENTOS NO SERIADOS DE LA CARTERA PROPIA. 'DISPONIBLES'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolioflujos
             SELECT       fffecha   = @fecha                       ,
                          ffrutcart = cprutcart                       ,
                          ffsistema = 'BTR'                       ,
                          ffproducto= 'RF'                       ,
                          fftipoper = 'CP'                       ,
                          ffnumoper = CONVERT(CHAR(8),cpnumdocu)+'-'+CONVERT(CHAR(2),cpcorrela) ,
                          ffcupon                         = 1                                              ,
                          fffecven  = cpfecven                       ,
                          ffamort   = (CASE WHEN inprog='MD0550C' THEN (cpvptirc/@ValorUfAyer) ELSE  cpnominal END),
                          ffinteres = 0                                              ,
                          ffmoneda  = nsmonemi                       ,
                          ffactpas  = 'A'                                              ,
                          fftipoflu = MDCP.codigo_carterasuper,
                          fftasaper = nstasemi                       ,
                          ffbaseper = nsbasemi
   ,0,0
                    FROM  mdcp, VIEW_NOSERIE mdns, VIEW_INSTRUMENTO mdin
                    WHERE cpseriado  = 'N'                 AND
                          cpnominal  >  0                  AND
                          cprutcart  >  0                  AND
                          cpfecven  >= @fecha              AND
                          nsrutcart  = cprutcart           AND
                          nsnumdocu  = cpnumdocu           AND
                          nscorrela  = cpcorrela           AND
                          incodigo   = nscodigo
      ------------------------------------------------------------------------------------------
      -- MDVI : CARTERA DE INSTRUMENTOS DE LA CARTERA PROPIA. 'VENDIDOS CON PACTO'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolio
             SELECT       @fecha                                                                                            , --1
                          virutcart                                                                     , --2
                          'BTR'                                                                                            , --3
                          'RF'                                                                                    , --4
                          'VI'                                                                                            , --5
                          CONVERT(CHAR(8),vinumdocu)+'-'+CONVERT(CHAR(2),vicorrela)+'-'+CONVERT(CHAR(8),vinumoper) , --6
                          inserie                                                                                            , --7
                          viinstser                                                                     , --8
                          MDVI.codigo_carterasuper                       , --9
                          vinominal                                                                     , --10
                          vitircomp                                                                     , --11
                          ISNULL(CASE
                                                 WHEN viseriado='S' THEN (SELECT sebasemi FROM VIEW_SERIE WHERE vimascara=semascara)
                                                 ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND vinumdocu=nsnumdocu AND vicorrela=nscorrela)
                          END,0)                                                                                            , --12
                          0                                                                                            , --13
                          ISNULL(CASE
                                                 WHEN viseriado='S' THEN (SELECT semonemi FROM VIEW_SERIE WHERE vimascara=semascara)
                                                 ELSE (SELECT nsmonemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND vinumdocu=nsnumdocu AND vicorrela=nscorrela)
                          END,0)                                                                                            , --14
                          999                                                                                            , --15 Faltan DPX otras monedas
                          0                                                                                            , --16
                          vifeccomp                                                                     , --17
                          vifecven                                                                     , --18
                          vivalcomp                                                                     , --19
                          vivalvenp                                                                                            , --20
                          '0'                                                                                            , --21 Falta Cuenta Contable
                          vivalcomu                                                                     , --22
                          vivalcomp                                                                     , --23
                          viinteresv                                                                     , --24 Interes UM
                          viinteresv                                                                     , --25
                          vireajustv                                                                     , --26
                          vivptirc                                                                     , --27
                          'NA'                                                                                            , --28
                          0                                                                                            , --29
                          vifecemi                                                                     , --30
                          ISNULL(CASE
                                                 WHEN viseriado='S' THEN (SELECT setasemi FROM VIEW_SERIE WHERE vimascara=semascara)
                                                 ELSE (SELECT nstasemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND vinumdocu=nsnumdocu AND vicorrela=nscorrela)
                          END,0.0)                                                                                            , --31
                          ISNULL(CASE
                                                 WHEN viseriado='S' THEN (SELECT sebasemi FROM VIEW_SERIE WHERE vimascara=semascara)
                                                 ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND vinumdocu=nsnumdocu AND vicorrela=nscorrela)
                          END,0)                                                                                            , --32
                          ISNULL(CASE
                                      WHEN viseriado='S' THEN (SELECT serutemi FROM VIEW_SERIE WHERE vimascara=semascara)
                                      ELSE (SELECT nsrutemi FROM VIEW_NOSERIE WHERE virutcart=nsrutcart AND vinumdocu=nsnumdocu AND vicorrela=nscorrela)
                                 END,0)                                                                                            , --33
                          digenemi                                                                     , --34
                          virutcli                                                                     , --35
                          vicodcli                                                                     , --36
                          vimascara                                                                     , --37
                          viseriado                                                                     , --38
                          0                                                                                            , --39
                          vidurmod                                                                     , --40
                          ''                                                                                            , --41
                          ''                                                                                            , --42
                          ''
   ,0,0                                                                                                 --43
                    FROM  MDVI, MDDI, VIEW_INSTRUMENTO
                    WHERE vinominal  > 0                    AND 
                          virutcart  > 0                    AND 
                          vifecvenp >= @fecha               AND
                          vitipoper  = 'CP'                 AND
                          incodigo   = vicodigo             AND
                          dirutcart  = virutcart            AND
                          dinumdocu  = vinumdocu            AND
                          dicorrela  = vicorrela            AND
                          ditipoper  = 'CP'
      ------------------------------------------------------------------------------------------
      -- INSTRUMENTOS SERIADOS DE LA CARTERA PROPIA. 'VENDIDOS CON PACTO'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolioflujos
             SELECT       fffecha   = @fecha                       ,
                          ffrutcart = cprutcart                       ,
                          ffsistema = 'BTR'                       ,
                          ffproducto= 'RF'                       ,
                          fftipoper = 'VI'                       ,
                          ffnumoper = CONVERT(CHAR(8),vinumdocu)+'-'+CONVERT(CHAR(2),vicorrela)+'-'+CONVERT(CHAR(8),vinumoper) ,
                          ffcupon                         = tdcupon  ,
                          fffecven  =(CASE WHEN secodigo=20 THEN DATEADD(mm, tdcupon*sepervcup, cpfecemi ) ELSE tdfecven END),
                          ffamort   = tdamort  /100.0 * vinominal ,
                          ffinteres = tdinteres/100.0 * vinominal ,
                          ffmoneda  = semonemi,
                          ffactpas  = 'A',
                          fftipoflu = MDCP.codigo_carterasuper,
                          fftasaper = setasemi,
                          ffbaseper = sebasemi
   ,0,0
                    FROM  mdvi, mdcp, VIEW_TABLA_DESARROLLO mdtd, VIEW_SERIE mdse
                    WHERE vifecvenp >= @fecha            AND
                          cpnumdocu = vinumdocu          AND
                          cpcorrela = vicorrela          AND
                          cpseriado = 'S'                AND
                          sefecven >= cpfecven           AND
                          semascara = cpmascara          AND
                          tdmascara = cpmascara          AND
                          (CASE WHEN secodigo=20 THEN DATEADD(mm, tdcupon*sepervcup, cpfecemi ) ELSE tdfecven END) >= @fecha
      ------------------------------------------------------------------------------------------
      -- INSTRUMENTOS NO SERIADOS DE LA CARTERA PROPIA. 'VENDIDOS CON PACTO'
      ------------------------------------------------------------------------------------------
      INSERT INTO bmportafolioflujos
             SELECT       fffecha   = @fecha                       ,
                          ffrutcart = virutcart                       ,
                          ffsistema = 'BTR'                       ,
                          ffproducto= 'RF'                       ,
                          fftipoper = 'VI'                       ,
                          ffnumoper = CONVERT(CHAR(8),vinumdocu)+'-'+CONVERT(CHAR(2),vicorrela)+'-'+CONVERT(CHAR(8),vinumoper) ,
                          ffcupon                         = 1                                              ,
                          fffecven  = cpfecven                       ,
                          ffamort   = vinominal                       ,
                          ffinteres = 0                                              ,
                          ffmoneda  = nsmonemi,
                          ffactpas  = 'A',
                          fftipoflu = MDCP.codigo_carterasuper,
                          fftasaper = nstasemi,
                          ffbaseper = nsbasemi
   ,0,0
                    FROM  mdvi, mdcp, VIEW_NOSERIE mdns
                    WHERE vifecvenp >= @fecha         AND
                          cpnumdocu  = vinumdocu      AND
                          cpcorrela  = vicorrela      AND
                          cpseriado  = 'N'            AND
                          nsrutcart  = cprutcart      AND
                          nsnumdocu  = cpnumdocu      AND
                          nscorrela  = cpcorrela      AND
                          nsfecven  >= @fecha
   END
   ------------------------------------------------------------------------------------------
   SET NOCOUNT OFF
END
-- SELECT * FROM VIEW_INSTRUMENTO
-- sp_interfaz_bacmetrics_irf '20011129'
-- SELECT * FROM BMPORTAFOLIO WHERE fecha = '20011129'
-- SELECT * FROM BMPORTAFOLIOFLUJOS WHERE NUMOPER = '48253   -9'
-- SELECT * FROM MDCP WHERE CPNOMINAL > 0
-- SELECT cpdurat,CPFECCOMP,* FROM MDCP WHERE CPNOMINAL > 0 ORDER BY cpdurat DESC
-- SELECT VIdurat,VIFECCOMP,* FROM MDVI WHERE VINOMINAL > 0 ORDER BY VIdurat DESC
-- UPDATE MDCP SET CPDU


GO
