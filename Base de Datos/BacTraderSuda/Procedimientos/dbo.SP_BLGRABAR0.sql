USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLGRABAR0]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BLGRABAR0]
        (
        @rutcart1 NUMERIC(09,0) ,
        @numdocu1 NUMERIC(10,0) ,
        @correla1 NUMERIC(03,0) ,
        @hwnd1    NUMERIC(10,0) ,
        @usuario1 CHAR   (20)   ,
        @tipven1  CHAR   (02)           -- Tipo de Ventana VP,VI
        )
AS
BEGIN
--Datos de Bloqueo
DECLARE @nError   NUMERIC (02,0)
DECLARE @usuario  CHAR    (20)
DECLARE @usuario2 CHAR    (20)
DECLARE @hwnd2    NUMERIC (09,0)
--Datos de Disponibilidad
DECLARE @rutcart        NUMERIC(09,0)
DECLARE @tipcart        NUMERIC(05,0)
DECLARE @numdocu        NUMERIC(10,0)
DECLARE @correla        NUMERIC(03,0)
DECLARE @numdocuo       NUMERIC(10,0)   -- 'Utilizado para accesar a VIEW_NOSERIE
DECLARE @correlao       NUMERIC(03,0)   -- 'Utilizado para accesar a VIEW_NOSERIE
DECLARE @tipoper        CHAR(03)
DECLARE @serie          CHAR(12)
DECLARE @instser        CHAR(12)
DECLARE @genemi         CHAR(10)
DECLARE @nemmon         CHAR(05)
DECLARE @nominal        NUMERIC(19,4)
DECLARE @tircomp        NUMERIC(19,4)
DECLARE @pvpcomp        NUMERIC(19,2)
DECLARE @vptirc         NUMERIC(19,4)
DECLARE @pvpmcd         NUMERIC(19,2)
DECLARE @tirmcd         NUMERIC(19,4)
DECLARE @vpmcd100       REAL
DECLARE @vpmcd          NUMERIC(19,4)
DECLARE @vptirci        NUMERIC(19,4)
DECLARE @fecsal         CHAR(10)
DECLARE @numucup        NUMERIC(03,0)
DECLARE @interesc       NUMERIC(19,4)
DECLARE @reajustc       NUMERIC(19,4)
DECLARE @intereci       NUMERIC(19,4)
DECLARE @reajusci       NUMERIC(19,4)
DECLARE @capitalc       NUMERIC(19,4)
DECLARE @capitaci       NUMERIC(19,4)
DECLARE @codigo         NUMERIC(03,0)
DECLARE @mascara        CHAR(12)
DECLARE @tasest         NUMERIC(09,4)
DECLARE @rutemi         NUMERIC(09,0)
DECLARE @monemi         NUMERIC(03,0)
DECLARE @tasemi         NUMERIC(09,4)
DECLARE @basemi         NUMERIC(03,0)
DECLARE @fecemi         CHAR(10)
DECLARE @fecven         CHAR(10)
DECLARE @cseriado       CHAR(01)
DECLARE @fecpcup        CHAR(10)
DECLARE @xfecpcup       DATETIME
SELECT @xfecpcup = ' '
--  Selecciona datos de disponibilidad
-- Se hace primero la consulta para saber el tipo de operaci½n
--*************************************************************
BEGIN
        SELECT @rutcart  = dirutcart    ,
               @tipcart  = ditipcart    ,
               @numdocu  = dinumdocu    ,
               @correla  = dicorrela    ,
               @numdocuo = dinumdocuo   ,
               @correlao = dicorrelao   ,
               @tipoper  = ditipoper    ,
               @serie    = diserie      ,
               @instser  = diinstser    ,
               @genemi   = digenemi     ,
               @nemmon   = dinemmon     ,
               @nominal  = dinominal    ,
               @tircomp  = ditircomp    ,
               @pvpcomp  = dipvpcomp    ,
               @vptirc   = divptirc     ,
               @pvpmcd   = dipvpmcd     ,
               @tirmcd   = ditirmcd     ,
               @vpmcd100 = divpmcd100   ,
               @vpmcd    = divpmcd      ,
               @vptirci  = divptirci    ,
               @fecsal   = CONVERT(CHAR(10),difecsal,103),
               @numucup  = dinumucup    ,
               @interesc = diinteresc   ,
               @reajustc = direajustc   ,
               @intereci = diintereci   ,
               @reajusci = direajusci   ,
               @capitalc = dicapitalc   ,
               @capitaci = dicapitaci
               FROM MDDI
               WHERE dirutcart = @rutcart1 AND dinumdocu = @numdocu1 AND dicorrela = @correla1
        END
        -- *************************************************************
        -- Solo para Ventas Definitivas
        -- Validar que el tipo de operaci½n sea Compra Propia
        -- *************************************************************
        IF @tipven1 = 'VP'
                IF @tipoper <> 'CP'
                BEGIN
                        -- Retorna Error
    SELECT 1,0,''
                        RETURN
                END
        -- *************************************************************
        -- Recupera datos adicionales
        -- *************************************************************
 SELECT @fecpcup = CONVERT(CHAR(10),@xfecpcup,103)
        IF @tipoper = 'CP'
                SELECT  @codigo         = cpcodigo      ,
                        @mascara        = cpmascara     ,
                        @tasest         = cptasest      ,
                        @fecemi         = CONVERT(CHAR(10),cpfecemi,103),
                        @fecven         = CONVERT(CHAR(10),cpfecven,103),
                        @cseriado       = cpseriado,
   @fecpcup = CONVERT(CHAR(10),cpfecpcup,103)
                FROM MDCP
                WHERE   cprutcart       = @rutcart1     AND
                        cpnumdocu       = @numdocu1     AND
                        cpcorrela       = @correla1
        ELSE
        IF @tipoper = 'CI'
                SELECT  @codigo         = cicodigo      ,
                        @mascara        = cimascara     ,
                        @tasest         = citasest      ,
                        @fecemi         = CONVERT(CHAR(10),cifecemi,103),
                        @fecven         = CONVERT(CHAR(10),cifecven,103),
                        @cseriado       = ciseriado,
   @fecpcup = CONVERT(CHAR(10),cifecpcup,103)
                FROM MDCI
                WHERE   cirutcart       = @rutcart1     AND
                        cinumdocu       = @numdocu1     AND
                        cicorrela       = @correla1
        SET ROWCOUNT 1
        -- Pregunta si el instrumento es seriado o no seriado
        IF @cseriado = 'S'
            -- Si es seriado recupera datos del MDSE
                SELECT  @rutemi = serutemi      ,
                        @monemi = semonemi      ,
                        @tasemi = setasemi      ,
                        @basemi = sebasemi
                FROM VIEW_SERIE
                WHERE semascara = @mascara
        ELSE
                -- Si es no seriado recupera datos de varias partes
                SELECT  @rutemi = nsrutemi    ,
                        @monemi = nsmonemi      ,
                        @tasemi = nstasemi      ,
                        @basemi = nsbasemi
                FROM VIEW_NOSERIE
                WHERE nsrutcart = @rutcart AND nsnumdocu = @numdocuo AND nscorrela = @correlao
                SELECT @monemi=mncodmon FROM VIEW_MONEDA  WHERE mnnemo=@nemmon 
        SET ROWCOUNT 0
        -- *************************************************************
        -- Chequea que si esta bloqueado el registro
        SELECT  @usuario2 = blusuario ,
                @hwnd2    = blhwnd
        FROM MDBL
        WHERE blrutcart = @rutcart1 AND blnumdocu = @numdocu1 AND blcorrela = @correla1
        IF @@ROWCOUNT >= 1
        -- Registro Bloqueado retorna
        BEGIN
          SELECT @nError = 2
          SELECT @nError, @hwnd2, @usuario2
          RETURN
        END
        ELSE
        -- Registro no estÿ bloqueado
        BEGIN
          INSERT MDBL (blrutcart, blnumdocu, blcorrela, blhwnd, blusuario )
          VALUES      (@rutcart1, @numdocu1, @correla1, @hwnd1, @usuario1 )
          SELECT @nError = 0, @hwnd2 = 0, @usuario2 = ''
        END
        -- SALIDA :
        SELECT  'nerror'  = @nError     ,       --01
                'hwnd2'   = @hwnd2      ,       --02
                'usuario2'= @usuario2   ,       --03
                'rutcart' = @rutcart    ,       --04
                'tipcart' = @tipcart    ,       --05
                'numdocu' = @numdocu    ,       --06
                'correla' = @correla    ,       --07
                'numdocuo'= @numdocuo   ,       --08
                'correlao'= @correlao   ,       --09
                'tipoper' = @tipoper    ,       --10
                'serie'   = @serie      ,       --11
                'instser' = @instser    ,       --12
                'genemi'  = @genemi     ,       --13
                'nemmon'  = @nemmon     ,       --14
                'nominal' = @nominal    ,       --15
                'tircomp' = @tircomp    ,       --16
                'pvpcomp' = @pvpcomp    ,       --17
                'vptirc'  = @vptirc     ,       --18
                'pvpmcd'  = @pvpmcd     ,       --19
                'tirmcd'  = @tirmcd     ,       --20
                'vpmcd100'= @vpmcd100   ,       --21
                'vpmcd'   = @vpmcd      ,       --22
                'vptirci' = @vptirci    ,       --23
                'fecsal'  = @fecsal     ,       --24
                'numucup' = @numucup    ,       --25
                'interesc'= @interesc   ,       --26
                'reajustc'= @reajustc   ,       --27
                'intereci'= @intereci   ,       --28
                'reajusci'= @reajusci   ,       --29
                'capitalc'= @capitalc   ,       --30
                'capitaci'= @capitaci   ,       --31
                'codigo'  = @codigo     ,       --32
                'mascara' = @mascara    ,       --33
                'tasest'  = @tasest     ,       --34
                'rutemi'  = @rutemi     ,       --35
                'monemi'  = @monemi     ,       --36
                'tasemi'  = @tasemi     ,       --37
                'basemi'  = @basemi     ,       --38
                'fecemi'  = @fecemi     ,       --39
                'fecven'  = @fecven     ,       --40
  'fecpcup' = @fecpcup  --41
END


GO
