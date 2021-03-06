USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_interfaz_Balance_Trader]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_interfaz_Balance_Trader]
AS
BEGIN
 SET NOCOUNT ON

DECLARE   @tip_oper      CHAR(4)
         ,@mascara       CHAR (12)         
         ,@numdocu       NUMERIC (10,0)    
         ,@numoper       NUMERIC (10,0)    
         ,@corre         NUMERIC (03,0)    
         ,@codigo        NUMERIC (5)       
         ,@tir           NUMERIC (19,4)    
         ,@moneda        NUMERIC (5)       
         ,@seriado       CHAR (1)          
         ,@tipoper       CHAR (4)          
         ,@tabla         CHAR (4)                  
         ,@cuenta        CHAR(20) 
         ,@fecha_compra  DATETIME                  
         ,@dias_dife     NUMERIC(6)                
         ,@campo_26      DATETIME                  
         ,@interes       NUMERIC(19,4)
         ,@vDolar_obs    NUMERIC(19,4)     
         ,@dias          NUMERIC(1)
         ,@nIntasb       NUMERIC(5)
         ,@tip_tasa      CHAR(3)
         ,@inst_variable CHAR(1)
         ,@Ccuenta       CHAR(5)
         ,@dfecfmes      DATETIME
         ,@dFecFMesProx  DATETIME
         ,@acfecprox     DATETIME
         ,@fecpro        DATETIME 
         ,@NumCuenta     CHAR(1)
         ,@monto_origen  NUMERIC(19,4)
         ,@indicador     CHAR(1)
         ,@NumValor      CHAR(1)
         ,@NumReajuste   CHAR(1)
         ,@NumInteres    CHAR(1)
         ,@Max           INTEGER
         ,@Monto         NUMERIC(18,2)
         ,@cMoneda       NUMERIC(5)
         ,@monto_oper    NUMERIC(18,2)

CREATE TABLE #CARTERA
    (
        tip_oper     CHAR(4)                                   --  0
       ,mascara      CHAR (12)                                 --  1    
       ,numdocu      NUMERIC (10,0)                            --  2
       ,numoper      NUMERIC (10,0)                            --  3
       ,corre        NUMERIC (03,0)                            --  4
       ,codigo       NUMERIC (5)                               --  5
       ,tir          NUMERIC (19,4)                            --  6
       ,moneda       NUMERIC (5)                               --  7
       ,seriado      CHAR (1)                                  --  8
       ,tipoper      CHAR (4)                                  --  9
       ,tabla        CHAR (4)                                  --  10
       ,cuenta       CHAR(20) NULL DEFAULT ('')                --  11
       ,fecha_compra DATETIME                                  --  12
       ,dias_dife    NUMERIC(6)                                --  13
       ,campo_26     DATETIME                                  --  14  
       ,interes      NUMERIC(19,4)
       ,cMoneda      NUMERIC(5)
       ,monto_oper   NUMERIC(18,2)
      )


CREATE TABLE #TABLA_INTERFAZ2
   (
       COD_PAIS      CHAR(3)
      ,NRO_IDEN      CHAR(4)
      ,FAM_PROD      CHAR(4)
      ,TIP_PROD      CHAR(4)
      ,COD_PRO       CHAR(4)
      ,NRO_OPER      CHAR(20)
      ,FEC_CTBL      CHAR(8)
      ,COD_CTAC      CHAR(20)
      ,IND_DECR      CHAR(1)
      ,COD_CTBL      CHAR(3)
      ,SIG_MDO       CHAR(1)
      ,MDA_ORI       NUMERIC(19,4)
      ,SIG_MDL       CHAR(1)
      ,MDA_LOC       NUMERIC(19,4)
      ,SIG_LAG       CHAR(1)
      ,MDA_AGR       NUMERIC(19,4)
      ,MDA_CTBLE    NUMERIC(5)
   )      

 SELECT @fecpro  = acfecproc ,
        @acfecprox = acfecprox
 FROM MDAC

set @vDolar_obs = isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @fecpro),0)


----
 INSERT #CARTERA 
 SELECT 
         'MDIR'--isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = "BTR" and codigo_bac = 'CP'),'')
        ,cpmascara
        ,cpnumdocu 
        ,cpnumdocu 
        ,cpcorrela 
        ,cpcodigo  
        ,cpvptirc  
        ,CASE
        WHEN cpseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
        END      
        ,cpseriado 
        ,'MD01' --'CP'      
        ,'MDCP'    
        ,CtaContable
        ,cpfeccomp      
        ,datediff(day,acfecproc,cpfecven)
        ,cpfecpcup  
        ,cpinteresc
        ,(SELECT mncodfox FROM view_moneda WHERE moneda = mncodmon)
        ,monto

 FROM MDCP  ,CARTERA_CUENTA , mdac
 WHERE cpnominal   > 0 AND cprutcart > 0
 AND   t_operacion = "CP"
 AND   NumDocu     = cpnumdocu
 AND   Correla     = cpcorrela
 AND   NumOper     = cpnumdocu 
 AND   variable    = 'valor_compra'


------- 
 INSERT #CARTERA 
 SELECT  
         'MDIR' --isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = "BTR" and codigo_bac = 'CP'),'')
         ,vimascara
        ,vinumdocu 
        ,vinumoper
        ,vicorrela 
        ,vicodigo  
        ,vivptirc     
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' --'CP'      
        ,'MDCP'    
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,viinteresv
        ,(SELECT mncodfox FROM view_moneda WHERE moneda = mncodmon)
        ,monto

   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND variable  = 'valor_compra'


-----
 INSERT #CARTERA 
 SELECT 
         'MDIR' --isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = "BTR" and codigo_bac = vitipoper),'')
         ,vimascara
        ,vinumdocu    
        ,vinumoper
        ,vicorrela 
        ,vicodigo  
        ,vivptirc     
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' --vitipoper      
        ,'MDVI'  
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,viinteresv
        ,(SELECT mncodfox FROM view_moneda WHERE moneda = mncodmon)
        ,monto

   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND variable  = 'valor_compra'


---
 INSERT #CARTERA 
 SELECT  'MDIR' --CASE
                --WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = "BTR" and codigo_bac = ciinstser),'')
                --ELSE isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = "BTR" and codigo_bac = 'CI'),'')
                --END  
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,civptirc     
        ,CASE
        WHEN ciseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cinumdocu AND nscorrela=cicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=cimascara),0)
        END      
        ,ciseriado 
        ,'MD01'--CASE
               --WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
               --ELSE 'CI'
              --END  
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,ciinteresc
        ,(SELECT mncodfox FROM view_moneda WHERE moneda = mncodmon)
        ,monto

 FROM MDCI,CARTERA_CUENTA , mdac
 WHERE t_operacion  = (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'MOV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'valor_compra'


DECLARE CURSOR_INTER CURSOR FOR 
SELECT     tip_oper      ,mascara       ,  numdocu   , numoper , corre   ,codigo
         , tir           ,moneda        ,  seriado   , tipoper , tabla   ,cuenta
         , fecha_compra  ,dias_dife     ,  campo_26  , interes,cmoneda   ,monto_oper
  FROM #CARTERA

OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO       @tip_oper      , @mascara      , @numdocu    , @numoper , @corre   , @codigo
         , @tir           , @moneda       , @seriado    , @tipoper , @tabla   , @cuenta
         , @fecha_compra  , @dias_dife    , @campo_26   , @interes, @cMoneda  , @monto_oper
WHILE @@FETCH_STATUS  = 0
BEGIN 
   
   if @tipoper = 'CP' or  @tipoper = 'CI' 
      select @indicador = 'D'
   else
      select @indicador = 'C'

   select @NumCuenta    = ''
   select @Ccuenta      = '0'
   select @Monto        = 0
   select @NumValor     = ''    
   select @NumReajuste  = ''
   select @NumInteres   = ''  


-- DBO.Sp_interfaz_Balance_Trader

   IF @cuenta <>'0' and @cuenta <>''
   BEGIN
      IF @vDolar_obs = 0
         select @monto_origen = @Monto_oper/1
      else
         select @monto_origen = @Monto_oper/@vDolar_obs
      IF @cuenta <> '0' AND @cuenta <> ''
         BEGIN
      INSERT #TABLA_INTERFAZ2 VALUES ( "CL",    "BO15",   "MDIR",    @tip_oper  ,@tipoper

                              ,RIGHT("00000000000000000000"+ CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5) ) ,20)

                              ,convert(char(8),@fecpro,112),  @cuenta , @indicador, '0'

                              ,'+', @monto_origen,'+', @monto, '+',@interes,@cMoneda )

      END
  END    


/*   select @Ccuenta = CtaContable  , @Monto = Monto  from cartera_cuenta where NumDocu = @numdocu and Correla = @Corre  and NumOper = @numoper and  Variable  = 'valor_compra'
   if @vDolar_obs = 0
      select @monto_origen = @Monto/1
   else
      select @monto_origen = @Monto/@vDolar_obs
    select @Ccuenta,@numdocu,@Corre

   IF @Ccuenta <> '0' AND @Ccuenta <> ''
   BEGIN
      INSERT #TABLA_INTERFAZ2 VALUES ( "CL",    "BO15",   "MDIR",    @tip_oper  ,@tipoper

                              ,RIGHT("00000000000000000000"+ CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5) ) ,20)

                              ,convert(char(8),@fecpro,112),  @Ccuenta , @indicador, '0'

                              ,'+', @monto_origen,'+', @monto, '+',@interes,@cMoneda )

   END*/


   select @Ccuenta = CtaContable  , @Monto = Monto  from cartera_cuenta where NumDocu = @numdocu and Correla = @Corre  and NumOper = @numoper and  Variable  = 'Reajuste_papel'

   if @vDolar_obs = 0
      select @monto_origen = @Monto/1
   else
   select @monto_origen = @Monto/@vDolar_obs

   IF @Ccuenta <> '0' AND @Ccuenta <> ''
   BEGIN
      INSERT #TABLA_INTERFAZ2 VALUES ( "CL",    "BO15",   "MDIR",    @tip_oper  ,@tipoper

                              ,RIGHT("00000000000000000000"+ CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5) ) ,20)

                              ,convert(char(8),@fecpro,112),  @Ccuenta , @indicador, '1'

                              ,'+', @monto_origen,'+', @monto, '+',@interes,@cMoneda)

   END   

   select @Ccuenta = CtaContable  , @Monto = Monto  from cartera_cuenta where NumDocu = @numdocu and Correla = @Corre  and NumOper = @numoper and  Variable  = 'Interes_papel'

   if @vDolar_obs = 0
      select @monto_origen = @Monto/1
   else
      select @monto_origen = @Monto/@vDolar_obs
   IF @Ccuenta <> '0' AND @Ccuenta <> ''
   BEGIN
      INSERT #TABLA_INTERFAZ2 VALUES ( "CL",    "BO15",   "MDIR",    @tip_oper  ,@tipoper

                              ,RIGHT("00000000000000000000"+ CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5) ) ,20)

                              ,convert(char(8),@fecpro,112),  @Ccuenta , @indicador, '2'

                              ,'+', @monto_origen,'+', @monto, '+',@interes,@cMoneda)

   END         

                       
FETCH NEXT FROM CURSOR_INTER
INTO       @tip_oper      , @mascara      , @numdocu    , @numoper , @corre   , @codigo
         , @tir           , @moneda       , @seriado    , @tipoper , @tabla   , @cuenta
         , @fecha_compra  , @dias_dife    , @campo_26   , @interes,@cMoneda   , @monto_oper
      
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER

SELECT @Max = COUNT(*) FROM #TABLA_INTERFAZ2
SELECT @Max,* FROM #TABLA_INTERFAZ2

END

--sp_help cartera_cuenta

--SELECT * FROM  mdcp where cpnumdocu = 32028
-- SELECT * FROM cartera_cuenta where numdocu = 32290 and correla = 8
--38954238954
--(SELECT mncodfox FROM view_moneda WHERE mncodmon = 994 )
--select * from view_moneda
-- SELECT * FROM CARTERA_CUENTA WHERE NumDocu = 40096
-- SELECT * FROM MDCP WHERE CPNUMDOCU = 37634


--SELECT tdmascara , tdcupon , tdfecven , tdinteres , tdamort , tdflujo , tdsaldo 
--   FROM view_tabla_desarrollo  
--      WHERE tdmascara = 'COR18R' and tdcupon > 2 
--             and (CASE WHEN 20=20 THEN DATEADD( MONTH, tdcupon * 3, '20010101' ) 
--                  ELSE tdfecven END ) > '20020821' 




GO
