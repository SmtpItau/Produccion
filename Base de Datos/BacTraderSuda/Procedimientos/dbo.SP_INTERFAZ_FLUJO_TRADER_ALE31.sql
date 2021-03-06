USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_FLUJO_TRADER_ALE31]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_FLUJO_TRADER_ALE31]
AS
BEGIN

SET NOCOUNT ON 

DECLARE @VALORX NUMERIC(19,4),
         @xx15 NUMERIC(19,4),
         @nmone NUMERIC(3),
         @campo_26 datetime

DECLARE @CCMOR CHAR(3)
DECLARE @CCMON CHAR(2)
DECLARE @c                CHAR (1) ,
        @c1               CHAR (1) ,
        @mascara          CHAR (12) ,
        @instrumento      CHAR (12) ,
        @codigo           NUMERIC (5) ,
        @nominal          NUMERIC (19,4) ,
        @tir              NUMERIC (19,4) ,
        @taspact          NUMERIC (19,4) ,
        @fecvenpact       DATETIME ,
        @moneda           NUMERIC (5) ,
        @seriado          CHAR (1) ,
        @tipoper          CHAR (3) ,
        @valinip          NUMERIC (19,4) ,
        @valvenp          NUMERIC (19,4) ,
        @valcomp          NUMERIC (19,4) ,
        @rutcli           NUMERIC (9) ,
        @codcli           NUMERIC (5) ,
        @rutemi           NUMERIC (9) ,
        @tabla            CHAR (4) ,
        @numero           NUMERIC (9) ,
        @cuenta           CHAR (20) ,
        @tipo_tasa        NUMERIC (1) ,
        @inversion        NUMERIC (5) ,
        @tipo_cuenta      CHAR (2) ,
        @fecha            DATETIME ,
        @fecpro           DATETIME ,
        @periodo          INTEGER  ,
        @fecvenp          DATETIME,
        @cliente          NUMERIC (9) ,
        @estado           NUMERIC (9) ,
        @emtipo           CHAR (5) ,
        @nmes             CHAR (2) ,
        @nmes_a           CHAR (2) ,
        @nano             CHAR (4) ,
        @cano             CHAR (4) ,
        @nNumdocu         NUMERIC (10,0) ,
        @nNumoper         NUMERIC (10,0) ,
        @nCorrela         NUMERIC (03,0)  ,
        @fec_comp         DATETIME , 
        @CTTAS            CHAR (3) ,
        @dias_dife        NUMERIC(4),
        @tran_perm        CHAR (10) ,
        @tirc             NUMERIC(19,4),
        @DIAS             NUMERIC(19),
        @max_fecha        DATETIME,
        @cope             NVARCHAR(20),
        @corr             NUMERIC(2),
        @ntoc             NUMERIC(19) ,--- char(3),   --3
        @sepa             CHAR(1),
        @vcuo             NUMERIC(19,4),
        @svca             NUMERIC(19),
        @tasa             NUMERIC(19,4),
        @rut              CHAR(10),
        @cant             NUMERIC(19),
        @contador         NUMERIC(19),
        @val_presen       NUMERIC(19,4),
        @tdmascara        CHAR(10)       ,
        @tdcupon          NUMERIC (5)    ,
        @tdcupon2         NUMERIC (5)    ,
        @tdamort          NUMERIC (25,10),
        @tdamort2         NUMERIC (19),
        @tdfecven         DATETIME       ,
        @tdinteres        NUMERIC(19,10) ,-- NUMERIC(19,10) ,
        @tdinteres2       NUMERIC(19,10) ,-- NUMERIC(19,10) ,
        @tdflujo          NUMERIC(19,10) ,
        @tdsaldo          NUMERIC(19,10) ,
        @cuenta_flu       CHAR(20),
        @valcomu          NUMERIC(19,4),
        @nsnumdocu        numeric(9),
        @nsfecven         datetime,
        @nsfecemi         datetime,
        @fecha_ami        datetime,
        @inte             numeric(19,4),
        @valmoneda        numeric(19,4),
        @valmoneda_ori    numeric(19,4),
        @valmoneda_comp   numeric(19,4),
        @valmoneda_dia    numeric(19,4),
        @ref              NVARCHAR(20)   ,
        @cont_reg         NUMERIC(19)    ,
        @valorpresente    NUMERIC(19,4) ,
        @mas_paso         CHAR (12)   ,
        @Peri_cupon       numeric(19) ,--numeric(5) ,
        @dfecfmes         datetime   ,
        @dFecFMesProx     datetime   ,
	@acfecprox        datetime   ,
        @fecucup          datetime ,
        @interes          numeric(19,4),
        @reajuste         numeric(19,4),
        @valUFhoy         numeric(19,4),
        @valUSDhoy        numeric(19,4) 


--sp_help view_tabla_desarrollo

 SELECT @fecpro  = acfecproc ,
        @cliente = acrutprop ,
   @acfecprox = acfecprox
 FROM MDAC


 SELECT @estado = emrut FROM VIEW_EMISOR WHERE emgeneric='EST'

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

 CREATE TABLE #CARTERA
    (
    mascara              CHAR (12)    ,                                 
    numdocu              NUMERIC (10,0)    ,         --4
    numoper              NUMERIC (10,0)    ,         --4
    corre                NUMERIC (03,0)    ,         --4
    instrumento          CHAR (12)    ,
    codigo               NUMERIC (5)    ,
    nominal              NUMERIC (19,4)    ,
    tir                  NUMERIC (19,4)    ,
    taspact              NUMERIC (19,4) NULL DEFAULT (0) ,
    fecvenpact           DATETIME NULL   ,
    moneda               NUMERIC (5)    ,
    seriado              CHAR (1)    ,
    tipoper              CHAR (3)    ,
    valinip              NUMERIC (19,4) NULL DEFAULT (0) ,
    rutcli               NUMERIC (9)    ,
    codcli               NUMERIC (5)    ,
    rutemi               NUMERIC (9)    ,
    tabla                CHAR (4)    ,
    periodo              INTEGER     ,
    fecvenp              DATETIME NULL   ,      --20
    valvenp              NUMERIC (19,4) NULL DEFAULT (0) ,
    valcomp              NUMERIC (19,4) NULL DEFAULT (0) ,
    correla              NUMERIC (9) IDENTITY (1,1) ,
    cuenta               CHAR(20) NULL DEFAULT ('')  ,
    fecha_compra         datetime,
    fec_ven              datetime,
    amortizacion         numeric(19,4),
    saldo                numeric(19,4),
    invers               NUMERIC (5) ,
    cttas                char(3),
    dias_dife            numeric(4),    
    tran_perm            CHAR (10) ,
    tirc                 numeric(19,4),
    campo_26             datetime ,                     --- fecha proximo cupon 
    valorpresente        numeric(19,4),
    cuenta2              char(20) ,
    valcomu              numeric(19,4),
    fecha_ami            datetime  ,
    fecucup              datetime  ,                     --- fecha corte cupon     
    interes              numeric(19,4),
    reajuste             numeric(19,4)
)
	
 CREATE TABLE #CARTERAVI
    (
    mascara              CHAR (12)    ,                                 
    numdocu              NUMERIC (10,0)    ,         --4
    numoper              NUMERIC (10,0)    ,         --4
    corre                NUMERIC (03,0)    ,         --4
    instrumento          CHAR (12)    ,
    codigo               NUMERIC (5)    ,
    nominal              NUMERIC (19,4)    ,
    tir                  NUMERIC (19,4)    ,
    taspact              NUMERIC (19,4) NULL DEFAULT (0) ,
    fecvenpact           DATETIME NULL   ,
    moneda               NUMERIC (5)    ,
    seriado              CHAR (1)    ,
    tipoper              CHAR (3)    ,
    valinip              NUMERIC (19,4) NULL DEFAULT (0) ,
    rutcli               NUMERIC (9)    ,
    codcli               NUMERIC (5)    ,
    rutemi               NUMERIC (9)    ,
    tabla                CHAR (4)    ,
    periodo              INTEGER     ,
    fecvenp              DATETIME NULL   ,      --20
    valvenp              NUMERIC (19,4) NULL DEFAULT (0) ,
    valcomp              NUMERIC (19,4) NULL DEFAULT (0) ,
    --correla              NUMERIC (9) IDENTITY (1,1) ,
    cuenta               CHAR(20) NULL DEFAULT ('')  ,
    fecha_compra         datetime,
    fec_ven              datetime,
    amortizacion         numeric(19,4),
    saldo                numeric(19,4),
    invers               NUMERIC (5) ,
    cttas                char(3),
    dias_dife            numeric(4),    
    tran_perm            CHAR (10) ,
    tirc                 numeric(19,4),
    campo_26 datetime ,          --- fecha proximo cupon 
    valorpresente        numeric(19,4),
    cuenta2              char(20) ,
    valcomu              numeric(19,4),
    fecha_ami            datetime  ,
    fecucup              datetime  ,                     --- fecha corte cupon     
    interes              numeric(19,4),
    reajuste             numeric(19,4)
)

 CREATE TABLE #CARTERACI
    (
    mascara              CHAR (12)    ,                                 
    numdocu              NUMERIC (10,0)    ,         --4
    numoper              NUMERIC (10,0)    ,         --4
    corre                NUMERIC (03,0)    ,         --4
    instrumento          CHAR (12)    ,
    codigo               NUMERIC (5)    ,
    nominal              NUMERIC (19,4)    ,
    tir                  NUMERIC (19,4)    ,
    taspact              NUMERIC (19,4) NULL DEFAULT (0) ,
    fecvenpact           DATETIME NULL   ,
    moneda               NUMERIC (5)    ,
    seriado              CHAR (1)    ,
    tipoper              CHAR (3)    ,
    valinip              NUMERIC (19,4) NULL DEFAULT (0) ,
    rutcli               NUMERIC (9)    ,
    codcli               NUMERIC (5)    ,
    rutemi               NUMERIC (9)    ,
    tabla                CHAR (4)    ,
    periodo              INTEGER     ,
    fecvenp              DATETIME NULL   ,      --20
    valvenp              NUMERIC (19,4) NULL DEFAULT (0) ,
    valcomp              NUMERIC (19,4) NULL DEFAULT (0) ,
    --correla              NUMERIC (9) IDENTITY (1,1) ,
    cuenta               CHAR(20) NULL DEFAULT ('')  ,
    fecha_compra         datetime,
    fec_ven              datetime,
    amortizacion         numeric(19,4),
    saldo                numeric(19,4),
    invers               NUMERIC (5) ,
    cttas                char(3),
    dias_dife            numeric(4),    
    tran_perm            CHAR (10) ,
    tirc                 numeric(19,4),
    campo_26 datetime ,                     --- fecha proximo cupon 
    valorpresente        numeric(19,4),
    cuenta2              char(20) ,
    valcomu              numeric(19,4),
    fecha_ami            datetime  ,
    fecucup              datetime  ,                     --- fecha corte cupon     
    interes              numeric(19,4),
    reajuste             numeric(19,4)
)


---------------------------------------------------------------------------------------------
CREATE TABLE #TABLA_INTERFAZ

      (    
	   Cod_Pais         VARCHAR(3)
          ,Num_Fuente       VARCHAR(14)
          ,Cod_Emp          VARCHAR(3)
          ,Cod_Interno      VARCHAR(16)
          ,Numero_Operacion VARCHAR(20)
          ,F_Pago_Cuota     DATETIME
          ,Mto_Moneda_Local NUMERIC(18,2)
          ,Mto_A_Mda_local  NUMERIC(18,2)
          ,Mto_I_Mda_local  NUMERIC(19,2) 
      )

---------------------------------------------------------------------------------------------

 INSERT #CARTERA 
 SELECT cpmascara ,
        cpnumdocu ,
        cpnumdocu ,
        cpcorrela ,
        cpinstser ,
        cpcodigo  ,
        cpnominal ,
        cptircomp ,
        0         ,
        ''        ,
        CASE
         WHEN cpseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=cpmascara)
  	END       ,
        cpseriado ,
        'CP'      ,
        0         ,
        cprutcli  ,
        cpcodcli  ,
        CASE
            WHEN cpseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=cpcodigo AND nsrutcart=cprutcart AND nsnumdocu=cpnumdocu AND nscorrela=cpcorrela)
            ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=cpmascara)
        END      ,
        'MDCP'   ,
       ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=cpmascara),0) ,
	cpfecven   ,    --25
       cpnominal  ,
       cpvalcomp ,  --14
       CtaContable,
       cpfeccomp  ,    --13
       ''         ,
       0          ,
       0          ,
       0          ,
       ''         ,
       datediff(day,@fecpro,cpfecven),
       codigo_carterasuper,
       0                  ,
       cpfecpcup          ,   -- 26
       cpvptirc           ,
       CtaContable        ,
       cpvalcomu          ,
       cpfecemi           ,
       cpfecucup          ,
       cpinteresc         ,
       cpreajustc
FROM MDCP  ,CARTERA_CUENTA  -- SELECT * FROM MDCP  WHERE cpnumdocu = 41847cpnominal > 0
 WHERE cpnominal   > 0 AND cprutcart > 0
 AND   t_operacion = 'CP'
 AND   NumDocu  = cpnumdocu
 AND   Correla     = cpcorrela
 AND   NumOper     = cpnumdocu 
 AND   CASE WHEN cpcodigo = 20  THEN 'valor_tasa_emision' ELSE 'valor_compra' END  = variable
and cpnumdocu = 4777777


 INSERT #CARTERA 
 SELECT DISTINCT vimascara ,
        vinumdocu ,  --4
        vinumoper ,  --4
        vicorrela ,  --4
        viinstser ,   
        vicodigo  ,
        vinominal ,
        vitircomp ,
        0         ,
        vifecvenp ,   --25
        vimonemi  ,
        viseriado ,
        'CP'      ,
        0         ,
        virutcli  ,
        vicodcli  ,
        virutcli, --CASE
        'MDCP'    ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=vimascara),0) ,
        vifecvenp  ,
        vinominal ,
        vivalcomp , 
        CtaContable ,
        0         ,
        ''        ,
        0         ,
        0         ,
        0         ,
        ''        ,
       datediff(day,@fecpro,vifecvenp),
       codigo_carterasuper,
        0          ,
        vifecvenp  ,  --26
       vivptirc    ,
       CtaContable ,
       vivalcomu   ,
       vifecemi    ,
       vifecucup   ,
       viinteresv   ,
       vireajustv 
   FROM MDVI,CARTERA_CUENTA
  WHERE  NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND variable  = 'valor_presente'
and vinumdocu = 477777

/* EN EL CASO DE OPERACIONES DE CARTERA VENTA CON PACTO */

/* SE PASAN LOS DATOS DE LA CARTERA INTERMEDIADA A OTRO TEMP PARA PODER INSERTAR LOS DATOS AGRUPADOS PUES SE DEBE 
   INFORMAR SIN REPETIR NUMERO DE OPERACION  **/

 INSERT #CARTERAVI 
 SELECT vimascara ,
        vinumdocu ,
        vinumoper ,
        vicorrela ,
        viinstser ,
        vicodigo  ,
        vinominal ,
        0, ---vitirvent , NO ES NECESARIO INFORMAR TASA, PARA ESTE CASO SE INSERTA 0 PARA AGRUPACION
        vitaspact ,
        vifecvenp ,    --25
        CASE
            WHEN viseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END       ,
        viseriado ,
        vitipoper ,
        vivalinip ,
        virutcli  ,
        vicodcli  ,
        CASE
         WHEN viseriado='N' THEN (SELECT DISTINCT nsrutemi FROM VIEW_NOSERIE WHERE nscodigo=vicodigo AND nsrutcart=virutcart AND nsnumdocu=vinumdocu AND nscorrela=vicorrela)
         ELSE (SELECT DISTINCT serutemi FROM VIEW_SERIE WHERE semascara=vimascara)
        END       ,
        'MDVI'    ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE SEMASCARA = VIMASCARA),0) ,
        ''        ,
        vivalvenp ,   --26
        vivptirv ,
        CtaContable ,
        0         ,
        ''        ,
        0         ,
        0         ,
        0         ,
        ''        ,
       datediff(day,@fecpro,vifecvenp),
       codigo_carterasuper,
       vivalvenp   ,
       vifecvenp   ,    --26
       vivptirc    ,
       CtaContable ,
       vivalcomu   ,
       vifecemi    ,
       vifecucup   ,
       viinteresv  ,
       vireajustv 
 FROM MDVI,CARTERA_CUENTA -- select * from   MDVI
 WHERE NumDocu  = vinumdocu
 	AND Correla  = vicorrela
 	AND NumOper  = vinumoper 
	AND CASE WHEN vicodigo in (4,31,32,33,300,301) THEN 'valor_venta' ELSE 'valor_compra'  END  = variable --  variable = 'valor_venta' 
and vinumdocu = 7777777

--select * from #CARTERAVI

 UPDATE #CARTERAVI SET numdocu = numoper WHERE tabla='MDVI'    -- SE REEMPLAZA NUMERO PARA INFORMAR

/* SE INSERTAN REGISTROS AGRUPADOS POR NUMERO DE OPERACION EN #CARTERA   */
 INSERT #CARTERA 
 SELECT  '', -- mascara,
         numdocu,
         numoper,
         corre,
         '' , -- instrumento,
         codigo,
         SUM(nominal),
         tir,
         taspact,
         fecvenpact,
         moneda,
         seriado,
         tipoper,
         SUM(valinip),
         rutcli,
         codcli,
         rutemi,
         tabla,
         periodo,
         fecvenp,
         SUM(valvenp),
         SUM(valcomp),
         cuenta,
         fecha_compra,
         fec_ven,
         SUM(amortizacion),
         SUM(saldo),
         invers,
         cttas,
         dias_dife,
         tran_perm,
         SUM(tirc),
         campo_26,
         SUM(valorpresente),
         cuenta2,
         SUM(valcomu),
         fecha_ami,
         fecucup,
         SUM(interes),
         SUM(reajuste)
 FROM #CARTERAVI 
 GROUP BY -- mascara,
          numdocu,numoper,
          corre,
          --instrumento,
          codigo,tir,taspact,fecvenpact,
          moneda,seriado,tipoper,
          rutcli,codcli,rutemi,
          tabla,periodo,fecvenp,
          cuenta,fecha_compra,
          fec_ven,invers,cttas,
          dias_dife,tran_perm,campo_26,
          cuenta2,fecha_ami,fecucup

/********** FIN OPERACIONES VENTAS CON PACTO *********************/


/********** OPERACIONES COMPRAS CON PACTO 'ICOL' - 'ICAP'  *********************/
 INSERT #CARTERA
 SELECT cimascara ,
        cinumdocu ,
        cinumdocu ,
        cicorrela ,
        ciinstser ,
        cicodigo  ,
        cinominal ,
        citircomp ,
        citaspact ,
        cifecvenp ,  --25 
        CASE
         WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cimonpact
         ELSE (CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
                nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
               ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara = cimascara )
               END)
        END       , 
        ciseriado ,
        CASE
               WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
            ELSE 'CI'
        END       ,
        civalinip ,
        cirutcli  ,
        cicodcli  ,
        cirutcli, --E
        'MDCI'     ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0) ,
        ''       ,
      	civalvenp  ,  --26
      	civalcomp  ,
      	ctacontable,
      	cifeccomp  ,
      	''         ,
      	0          ,
      	0          ,
      	0          ,
      	''         ,
       	datediff(day,@fecpro,cifecvenp),
      	codigo_carterasuper,
      	0           ,
      	cifecvenp   ,   --26
      	civptirci   ,
      	CtaContable ,
      	civalcomu   ,
      	cifecemi    ,
      	cifecucup   ,
      	ciinteresc  ,
        CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END --cireajustc  

 FROM MDCI,CARTERA_CUENTA -- select * from   MDCI
 WHERE t_operacion =  (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo = CodigoInst
 AND t_movimiento = 'MOV'
 AND NumDocu = cinumdocu
 AND Correla = cicorrela
 AND (ciinstser = 'ICOL' or ciinstser = 'ICAP' )
 AND variable = 'valor_compra'
---and cinumdocu = 444444


 INSERT #CARTERACI
 SELECT LEFT(cimascara ,3),
        cinumdocu ,
        cinumdocu ,
        1,--cicorrela ,
        LEFT(cimascara ,3),-- ciinstser ,
        cicodigo  ,
       (cinominal) ,
        0 ,--citircomp ,
        citaspact ,
        cifecvenp ,  --25 
	(CASE WHEN ciseriado='N' THEN (SELECT DISTINCT nsmonemi FROM VIEW_NOSERIE WHERE nscodigo=cicodigo AND
                nsrutcart=cirutcart AND nsnumdocu=cinumdocu AND nscorrela=cicorrela)
               ELSE (SELECT DISTINCT semonemi FROM VIEW_SERIE WHERE semascara = cimascara )
               END)       , 
        ciseriado ,
        'CI'        ,
        (civalinip ),
        cirutcli  ,
        cicodcli  ,
        cirutcli, --E
        'MDCI'     ,
        ISNULL((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara=cimascara),0) ,
        ''       ,
      	CASE WHEN cimonpact = 999  THEN (civalvenp  ) 
				   ELSE   ROUND(civalvenp  * ( select vmvalor from view_valor_moneda  where vmcodigo = cimonpact and vmfecha =  @fecpro ),0) END ,  --26
      	(civalcomp  ),
      	ctacontable,
      	cifeccomp  ,
      	''         ,
      	0          ,
      	0          ,
      	0          ,
      	''         ,
       	datediff(day,@fecpro,cifecvenp),
      	codigo_carterasuper,
      	0           ,
      	cifecvenp   ,   --26
    	(civptirci   ),
      	CtaContable ,
      	(civalcomu   ),
      	cifeccomp , -- cifecemi    ,
      	cifecvenp ,--cifecucup   ,
      	(ciinteresc  ),
        (cireajustci  )--cireajustc  

 FROM MDCI,CARTERA_CUENTA -- select * from   MDCI
 WHERE t_operacion =  'CI' 
 AND cicodigo = CodigoInst
 AND t_movimiento = 'MOV'
 AND NumDocu = cinumdocu
 AND Correla = cicorrela
 AND (ciinstser <> 'ICOL' AND  ciinstser <> 'ICAP' )
 AND variable = 'valor_compra'


 INSERT #CARTERA 
 SELECT   mascara,
         numdocu,
         numoper,
         corre,
          instrumento,
         codigo,
         SUM(nominal),
         tir,
         taspact,
         fecvenpact,
         moneda,
         seriado,
         tipoper,
         SUM(valinip),
         rutcli,
         codcli,
         rutemi,
         tabla,
         periodo,
         fecvenp,
         SUM(valvenp),
         SUM(valcomp),
         cuenta,
         fecha_compra,
         fec_ven,
         SUM(amortizacion),
         SUM(saldo),
         invers,
         cttas,
         dias_dife,
         tran_perm,
         SUM(tirc),
         campo_26,
         SUM(valorpresente),
         cuenta2,
         SUM(valcomu),
         fecha_ami,
         fecucup,
         SUM( valvenp - valinip ),
         SUM(reajuste)
 FROM #CARTERACI 
 GROUP BY  mascara,
          numdocu,numoper,
          corre,
          instrumento,
          codigo,tir,taspact,fecvenpact,
          moneda,seriado,tipoper,
          rutcli,codcli,rutemi,
          tabla,periodo,fecvenp,
          cuenta,fecha_compra,
          fec_ven,invers,cttas,
          dias_dife,tran_perm,campo_26,
          cuenta2,fecha_ami,fecucup


---and cinumdocu = 444444


SELECT @valUFhoy         =  ROUND (ISNULL(vmvalor ,0),4) FROM view_valor_moneda WHERE vmcodigo = 998 and vmfecha = @fecpro 
SELECT @valUSDhoy        =  ROUND (ISNULL(vmvalor ,0),2) FROM view_valor_moneda WHERE vmcodigo = 994 and vmfecha = @fecpro 


SET @contador = 1

DECLARE CURSOR_CARTERA CURSOR FOR 
  SELECT   mascara    , instrumento    , codigo  , nominal , tir    , taspact , fecvenpact 
         , moneda     , seriado        , tipoper , valinip , rutcli , codcli  , rutemi 
         , tabla      , CONVERT(CHAR(9),correla) ,'1'      , periodo, fecvenp , valvenp , valcomp 
         , numdocu    , numoper        , corre   , cuenta  , fecha_compra     , dias_dife 
         , tran_perm  , campo_26       , cuenta2 , valcomu , fecha_ami        , fecucup  , interes
         , valorpresente, reajuste
  FROM #CARTERA

OPEN CURSOR_CARTERA
FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara   , @instrumento, @codigo    , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda    , @seriado    , @tipoper   , @valinip , @rutcli   , @codcli    , @rutemi ,
      @tabla     , @numero     , @c         , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu  , @nNumoper   , @nCorrela  , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm , @campo_26   , @cuenta_flu, @valcomu , @fecha_ami, @fecucup   , @interes    , @val_presen,
      @reajuste

WHILE @@FETCH_STATUS  = 0
BEGIN 


   IF @moneda = 900 OR @moneda = 995 OR @moneda = 13 BEGIN 
      SET @valmoneda_dia  = @valUSDhoy --ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 994 and vmfecha = @fecpro ),4),0)
     -- SET @valmoneda_comp = ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = 994 and vmfecha = @fec_comp ),4),0)
   END
   ELSE IF @moneda = 999 BEGIN 
      SET @valmoneda_dia  = 1.0
      SET @valmoneda_comp = 1.0
   END
   ELSE IF @moneda = 998 BEGIN 
      SET @valmoneda_dia  = @valUFhoy
     -- SET @valmoneda_comp = ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fec_comp ),4), 0)

   END ELSE BEGIN 
      SET @valmoneda_dia  = ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fecpro ),4),0)
     -- SET @valmoneda_comp = ISNULL(round( ( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fec_comp ),4), 0)
   END 

-- 2
   SET @rut = (SELECT TOP 1 RIGHT('000000000'+CONVERT(VARCHAR(9),CLRUT),9) + Cldv FROM view_cliente where Clrut = @rutemi)

-- 5
   IF @seriado ='S'
      SET @cant = ISNULL(( SELECT COUNT(*) FROM view_tabla_desarrollo  WHERE  tdmascara = @mascara  ),0)

   ELSE 
      SET @cant = ISNULL(( SELECT COUNT(*) FROM view_noserie  WHERE nsserie = @mascara ),0)


   IF @cant  > 1 begin 
      SET @corr = 1
   END ELSE BEGIN 
      SET @corr = 0
   END 
-- 16


   SET @dfecfmes     = DATEADD(DAY,DATEPART(DAY,@acfecprox) * -1,@acfecprox)
   SET @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )
   SET @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx )


-- select cinominal,civalcomp , civalcomu,ciinteresc ,cireajustc* from mdci   
   IF @tabla = 'MDCI' OR @tabla = 'MDVI' begin -- intermediados

         IF DATEDIFF(YEAR, @fec_comp ,@campo_26 ) >= 1  
         BEGIN 
            SET @sepa = 'A'
            SET @contador =  DATEDIFF(YEAR,  @fec_comp ,@campo_26) -- @contador = cada cuanto tiempo 

         END ELSE IF DATEDIFF(MONTH, @fec_comp , @campo_26 ) >= 1 and DATEDIFF(MONTH, @fec_comp ,@campo_26) <= 12 begin  
           SET @sepa = 'M'
           SET @contador = DATEDIFF(MONTH,  @fec_comp ,@campo_26 )
         END 
         ELSE BEGIN  
           SET @sepa = 'D'
           SET @contador = DATEDIFF(DAY, @fec_comp ,@campo_26 )  
         END    
         IF @Cuenta <> '0' AND @Cuenta <> '' AND @tabla = 'MDCI'
         BEGIN

		IF @mascara   = 'ICAP' OR @mascara   = 'ICOL' BEGIN 

		         SET @tdamort   = ROUND(@valcomp,0) + round(@reajuste,0) -- antes @valcomp ojo con este 
		         SET @vcuo      = ROUND((@valcomp + @interes + @reajuste ),0)  --valcomp
		         SET @inte      = ROUND(@vcuo - @tdamort,0)--round((@valcomp+ @interes)- @valcomp ,0)-- ROUND(@vcuo - @tdamort,0)

	            INSERT #TABLA_INTERFAZ 
        	    VALUES ('CL' , 'FL15' , '001', @tipoper , CAST(@nNumdocu AS VARCHAR(5)) + cast(@nCorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5)) , @fecvenpact , @vcuo, @tdamort , @inte)
                	 -- 1   2     3       4         5         6        7       8         9           10        11       12       13    14       15          16     17
		END
		ELSE BEGIN

		         SET @tdamort   = @valvenp -- antes @valcomp ojo con este 
		         SET @vcuo      = @valinip --valcomp
		         SET @inte      = @interes --round((@valcomp+ @interes)- @valcomp ,0)-- ROUND(@vcuo - @tdamort,0)
	            INSERT #TABLA_INTERFAZ 
        	    VALUES ('CL' , 'FL15' , '001', @tipoper , CAST(@nNumdocu AS VARCHAR(5)) + cast(@nCorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5)) , @fecvenpact , @vcuo, @tdamort , @inte)
                	 -- 1   2     3       4         5         6        7       8         9           10        11       12       13    14       15          16     17
		END
         END

         IF @Cuenta <> '0' AND @Cuenta <> '' AND @tabla = 'MDVI'
         BEGIN

	      SET @tdamort   = @valvenp 
	      SET @vcuo      = @valinip 
              SET @inte      = @interes 

            INSERT #TABLA_INTERFAZ 
            VALUES ('CL' , 'FL15' , '001', @tipoper , CAST(@nNumoper AS VARCHAR(5)) + cast(@nCorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5)) , @fecvenpact , @vcuo, @tdamort , @inte)
                 -- 1   2     3       4         5         6        7       8         9           10        11       12       13    14       15          16     17
         END

    END
--------------------------

   IF @tabla <> 'MDCI' OR @tabla <> 'MDVI' 
   BEGIN   
     IF @seriado = 'N'    -- NO SERIADO
        BEGIN
        SET @ntoc = 1
        DECLARE CURSOR_INTERFAZ CURSOR FOR 
        SELECT nsserie ,nscorrela, nsnumdocu ,nsfecven,nsfecemi 
        FROM view_noserie 
            WHERE nsserie = @instrumento  and  nsnumdocu = @nNumdocu and nscorrela = @nCorrela and nsfecven > @fecpro 
            ORDER BY nsnumdocu


       OPEN CURSOR_INTERFAZ
       FETCH NEXT FROM CURSOR_INTERFAZ
       INTO @tdmascara , @tdcupon , @nsnumdocu , @nsfecven , @nsfecemi   

       WHILE @@FETCH_STATUS  = 0
       BEGIN 


         IF DATEDIFF(YEAR, @fecvenp ,@campo_26 ) >= 1  or DATEDIFF(YEAR, @fecvenp ,@campo_26 ) = 0 begin 
         SET @sepa = 'A'
            SET @contador =  DATEDIFF(YEAR,  @fecvenp ,@campo_26) -- @contador = cada cuanto tiempo 
            END  
         ELSE IF DATEDIFF(MONTH, @fecvenp ,@campo_26 ) >= 1 and DATEDIFF(MONTH, @fecvenp ,@campo_26) <= 12 begin  
            SET @sepa = 'M'
            SET @contador = DATEDIFF(MONTH,  @fecvenp ,@campo_26 )
         END 
         ELSE IF DATEDIFF(DAY, @fecvenp ,@campo_26) >= 1 AND DATEDIFF(DAY, @fecvenp ,@campo_26 ) <= 31   BEGIN  
            SET @sepa = 'D'
            SET @contador = DATEDIFF(DAY,@fecvenp ,@campo_26 )  
         END 


        IF @moneda = 999 begin
           SET @tdamort =  round(@valcomp,0)                   --round(@valcomp - @interes,0)
           SET @vcuo    =  round((@valcomp + @interes  ),0)
           SET @inte    =  ROUND(@vcuo - @tdamort,0)           --round(@interes,0) -- @interes

         END ELSE  BEGIN 
      ---     SET @valmoneda = round(( SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fecpro ),4)
--        SET @inte      = round(( @nominal - @valcomu ) * @valmoneda ,0)
           SET @tdamort   = round(@valcomp,0) + round(@reajuste,0) -- antes @valcomp ojo con este 
           SET @vcuo      = round((@valcomp + @interes + @reajuste ),0)  --valcomp
           SET @inte      = ROUND(@vcuo - @tdamort,0)
      
         END         IF @Cuenta <> '0' AND @Cuenta <> ''
            BEGIN
            INSERT #TABLA_INTERFAZ 
            VALUES ('CL' , 'FL15' , '001', @tipoper , CAST(@nNumdocu AS VARCHAR(5)) + cast(@tdcupon AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5)) , @nsfecven,  @vcuo, @tdamort , @inte)
                 -- 1   2     3       4         5         6        7       8         9           10        11       12       13    14       15          16     17
         END

 
          FETCH NEXT FROM CURSOR_INTERFAZ
          INTO @tdmascara , @tdcupon , @nsnumdocu , @nsfecven , @nsfecemi 
          END 
          CLOSE       CURSOR_INTERFAZ
          DEALLOCATE  CURSOR_INTERFAZ

         END
   END   -- FIN NO SERIADO
 
------------------------------------------------------------------------------------------------

 
   IF @SERIADO = 'S' AND (@tabla <> 'MDVI' AND @tabla <> 'MDCI')   -- SERIADO
   BEGIN
      SET @Peri_cupon = isnull( (select top 1  sepervcup from view_serie where  semascara = @mascara  ), 0)

      IF @Peri_cupon > 12  BEGIN 
         SET @sepa = 'A'  -- @fec_comp se cambio  por @fecha_ami 
         SET @contador = round(DATEDIFF(MONTH, @campo_26 , @fecucup ),0) --@Peri_cupon  / 12
      END
      ELSE IF @Peri_cupon >= 1 and @Peri_cupon <= 12  BEGIN 
         SET @sepa = 'M'
         SET @contador = @Peri_cupon  
      END ELSE BEGIN 
         SET @sepa = 'D'
         SET @contador = @Peri_cupon
      END 

      DECLARE CURSOR_INTERFAZ CURSOR FOR 
      SELECT tdmascara , tdcupon , tdfecven , tdinteres , tdamort , tdflujo , tdsaldo 
      FROM view_tabla_desarrollo  
      WHERE tdmascara = @mascara 
        and (CASE WHEN @codigo = 20 THEN DATEADD( MONTH, tdcupon * @Peri_cupon , @fecha_ami )  
                  ELSE tdfecven END ) > @fecpro 

      OPEN CURSOR_INTERFAZ
      FETCH NEXT FROM CURSOR_INTERFAZ
      INTO  @tdmascara , @tdcupon , @tdfecven , @tdinteres , @tdamort , @tdflujo , @tdsaldo 

      WHILE @@FETCH_STATUS  = 0
      BEGIN 

         IF @codigo = 20    BEGIN
            SET @tdfecven = DATEADD( MONTH , @tdcupon * @Peri_cupon, @fecha_ami )
         END 

         SET @nToc =  @cant -- numero total de cupones 


   --      SET @svca = ISNULL( ROUND( ((@TDAMORT   / 100)  * @NOMINAL * @valmoneda_comp ) , 0 ) , 0 )
         SET @tdamort2   = ISNULL( ROUND( ((@TDAMORT   / 100)  * @NOMINAL * @valmoneda_dia ) , 0 ) , 0 )
         SET @tdinteres2 = ROUND ((( @tdinteres / 100 ) * @NOMINAL * @valmoneda_dia  ) ,0 )
         SET @VCUO       = ISNULL( ROUND( @tdamort2 + @tdinteres2 ,0) , 0 )

-------------------------------------------------------------------------------------------------
         INSERT #TABLA_INTERFAZ 
--              1   2       3       4           5         6         7       8         9           10        11           12       13      14       15       16     17     18
         VALUES ('CL' , 'FL15' , '001', @tipoper , CAST(@nNumdocu AS VARCHAR(5)) + cast(@ncorrela AS VARCHAR(3))+ CAST(@nNumoper AS VARCHAR(5)), @tdfecven,  @vcuo, @tdamort2 , @tdinteres2 )
------------------------------------------------------------------------------------------------   

         FETCH NEXT FROM CURSOR_INTERFAZ
         INTO  @tdmascara,@tdcupon,@tdfecven,@tdinteres,@tdamort,@tdflujo,@tdsaldo   
         END  -- fin cursor 
         CLOSE       CURSOR_INTERFAZ
         DEALLOCATE  CURSOR_INTERFAZ

   END  -- fin seriado
     
  
------------------------------------------------------------------------------------------------------

FETCH NEXT FROM CURSOR_CARTERA
INTO  @mascara   , @instrumento , @codigo   , @nominal , @tir      , @taspact   , @fecvenpact ,
      @moneda    , @seriado     , @tipoper  , @valinip , @rutcli   , @codcli    , @rutemi ,
      @tabla     , @numero      , @c        , @periodo , @fecvenp  , @valvenp   , @valcomp    ,
      @nNumdocu  , @nNumoper    , @nCorrela , @cuenta  , @fec_comp , @dias_dife ,
      @tran_perm , @campo_26    , @cuenta_flu ,@valcomu ,@fecha_ami, @fecucup   , @interes    , 
      @val_presen, @reajuste

END
CLOSE CURSOR_CARTERA
DEALLOCATE  CURSOR_CARTERA


SELECT @cont_reg = COUNT(*) FROM #TABLA_INTERFAZ

 SELECT @cont_reg,* FROM  #TABLA_INTERFAZ

END

--- select * from cartera_cuenta where numdocu = 40708
-- select * from view_tabla_desarrollo where tdmascara =  'STGBC1'
-- 40708
-- select * from mdcp where cpnumdocu = 40708

GO
