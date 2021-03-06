USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_BALANCE_TRADER_ALE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_BALANCE_TRADER_ALE]

AS BEGIN
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
	 ,@Cod_Evento    CHAR(3)
         ,@TipoLinea     CHAR(03)
	 ,@tipo		 CHAR(03)
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
       ,monto_origen NUMERIC(18,2)
       ,Cod_Evento   CHAR(3)
       ,TipoLinea    CHAR(03)
       ,monto_oper   NUMERIC(18,2)
       ,tipo	     CHAR(03)
      )

CREATE TABLE #CARTERA_VI
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
       ,campo_26     DATETIME     -- 14  
       ,interes NUMERIC(19,4)
      ,monto_origen NUMERIC(18,2)
       ,Cod_Evento   CHAR(3)
       ,TipoLinea    CHAR(03)
       ,monto_oper   NUMERIC(18,2)
       ,tipo	     CHAR(03)
      )


CREATE TABLE #CARTERA_CI
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
       ,monto_origen NUMERIC(18,2)
       ,Cod_Evento   CHAR(3)
       ,TipoLinea    CHAR(1)
       ,monto_oper   NUMERIC(18,2)
       ,tipo	     CHAR(03)
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
      ,MDA_CTBLE     NUMERIC(5) --670 56 67
   )      

DECLARE @PrimerDiaMes	CHAR(12),
	@UltimoDiaMes	CHAR(12),
        @FECHAFINMES    DATETIME,     
        @FINMES         CHAR(1)


 SELECT @fecpro     = acfecproc ,
        @acfecprox  = acfecprox ,
        @FECHAFINMES= acfecproc 
 FROM MDAC

        SELECT @FINMES ='N'

 IF  MONTH ( @FECHAFINMES )<> MONTH( @acfecprox ) BEGIN
	SELECT @PrimerDiaMes   = SUBSTRING( ( convert(char(8), @acfecprox , 112))  ,1,6)  + '01'

        SELECT @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)

        SELECT @FECHAFINMES = CONVERT(DATETIME,  @UltimoDiaMes ,112)

        IF @FECHAFINMES <> @fecpro BEGIN -- FIN DE MES ESPECIAL
                 SELECT @FINMES ='S'
        END 
 END 

-------**********   CARTERA PROPIA ***************
---------------------- MONTO CAPITAL CARTERA PROPIA -----------------------------------

IF @FINMES ='N' BEGIN

-------**********   CARTERA PROPIA ***************
---------------------- MONTO CAPITAL CARTERA PROPIA -----------------------------------

 INSERT #CARTERA 
 SELECT 
         'MDIR'
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
        ,cpvptirc  --monto
	,'0'
        ,TipoLinea
        ,cpvptirc
	,'CP'
 FROM MDCP  ,CARTERA_CUENTA , mdac
 WHERE cpnominal   > 0 AND cprutcart > 0
 AND   t_operacion = 'CP'
 AND   NumDocu     = cpnumdocu
 AND   Correla = cpcorrela
 AND NumOper     = cpnumdocu 
 AND   CASE WHEN cpcodigo = 20  THEN 'valor_tasa_emision' ELSE 'valor_compra' END  = variable
AND 1=2

-------************* VENTAS CON PACTO *****************
---------------------- MONTO CAPITAL CARTERA VENTA CON PACTO -----------------------------------
 INSERT #CARTERA_VI 
 SELECT  
        'MDIR' 
        ,vimascara
        ,vinumdocu 
        ,vinumoper
        ,vicorrela 
        ,vicodigo  
        ,vivptirV 
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDVI'    
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,vivalinip-- viinteresv
        ,vivalinip --monto
	,'0'
        ,TipoLinea
        ,vivalinip-- vivalcomu
	,''
   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE  vinominal > 0 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND CASE WHEN vicodigo in (4,31,32,33,300,301) THEN 'valor_venta' ELSE 'valor_compra'  END  = variable --  variable = 'valor_venta' 
--AND 1=2

---------------------- MONTO REAJUSTE CARTERA VENTA CON PACTO -----------------------------------
 INSERT #CARTERA_VI
 SELECT  
        'MDIR' 
        ,vimascara
        ,vinumdocu 
        ,vinumoper
        ,vicorrela 
        ,vicodigo  
        ,vivptirV 
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDVI'    
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,viinteresv
        ,monto
	,'1'
        ,TipoLinea
        ,vireajustv
	,''
   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE  vinominal > 0 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND Variable  = 'Reajuste_papel'
--AND 1=2
---------------------- MONTO INTERES CARTERA VENTA CON PACTO -----------------------------------
 INSERT #CARTERA_VI
 SELECT  
        'MDIR' 
        ,vimascara
        ,vinumdocu 
        ,vinumoper
        ,vicorrela 
        ,vicodigo  
        ,viinteresv 
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDVI'    
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
	 ,viinteresvi-- viinteresv
        ,viinteresvi-- viinteresv -- monto
	,'2'
        ,TipoLinea
        ,viinteresvi -- viinteresv
	,''
   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE vinominal > 0 
    AND NumDocu = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND Variable  = 'Interes_papel'
    AND t_operacion = 'dvvi'

--AND 1=2
---------------------- MONTO CAPITAL CARTERA INTERMEDIADA -----------------------------------
 INSERT #CARTERA 
 SELECT 
         'MDIR' 
         ,vimascara
        ,vinumdocu    
        ,vinumoper 
        ,vicorrela 
        ,vicodigo  
        ,vivalcomp     
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
	END  
       ,viseriado 
        ,'MD01' 
        ,'MDCP'  
        ,CtaContable
	,0      
	,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,viinteresv
        ,vivptirv  --monto
	,'0'
        ,TipoLinea
        ,vivalcomu
	,''
   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE vinominal > 0 
    AND  NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND variable  = 'valor_presente'
--AND 1=2

---------------------- MONTO REAJUSTE CARTERA INTERMEDIADA -----------------------------------
 INSERT #CARTERA 
 SELECT 
         'MDIR' 
         ,vimascara
        ,vinumdocu    
        ,vinumoper 
        ,vicorrela 
        ,vicodigo  
        ,vivalcomp     
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDCP'  
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,viinteresv
        ,monto
	,'1'
        ,TipoLinea
        ,vireajustv
	,''
   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE vinominal > 0 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND variable  = 'reajuste_papel'
--AND 1=2
---------------------- MONTO INTERES CARTERA INTERMEDIADA -----------------------------------

 INSERT #CARTERA 
 SELECT distinct
         'MDIR' 
         ,vimascara
        ,vinumdocu 
        ,vinumoper 
        ,vicorrela 
        ,vicodigo  
        ,vivalcomp     
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDCP'  
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,vivalinip-- viinteresv
        ,viinteresv + vivalcomu --monto
	,'0'
        ,TipoLinea
        ,vivalinip-- vivalcomu
	,''
   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND variable  = 'interes_papel'
    and t_operacion = 'DVIT'

--AND 1=2
---------------------- MONTO CAPITAL CARTERA COMPRAS CON PACTO -----------------------------------
	--INTERBANCARIOS
 INSERT #CARTERA 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,civptirc     
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,ciinteresc
        ,monto
	,'0'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,civalcomp
	,''
 FROM MDCI,CARTERA_CUENTA , mdac
 WHERE cinominal > 0
 AND t_operacion  = 'CP' 
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'MOV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'valor_compra'
 AND ( ciinstser='ICOL' OR ciinstser='ICAP' ) 	
and 1=2
-- SELECT * FROM MDCI
---------------------- MONTO REAJUSTE CARTERA COMPRAS CON PACTO -----------------------------------
 INSERT #CARTERA 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,civptirc     
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END
	,monto
	,'1'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END
	,''
 FROM MDCI,CARTERA_CUENTA , mdac
 WHERE cinominal > 0
 AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end) AND cicodigo       = CodigoInst
 AND t_movimiento   = 'DEV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'reajuste_papel'
 AND ( ciinstser='ICOL' OR ciinstser='ICAP' ) 	
---------------------- MONTO INTERES CARTERA COMPRAS CON PACTO -----------------------------------
 INSERT #CARTERA 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END
        ,monto
	,'2'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END
	,''
 FROM MDCI,CARTERA_CUENTA , mdac
 WHERE cinominal > 0
 AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'DEV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'interes_papel'
 AND ( ciinstser='ICOL' OR ciinstser='ICAP' ) 	
and 1=2

 INSERT #CARTERA_CI 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,civptirci --civptirc cm 25-11-2003    
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,ciinteresci --ciinteresc cm 25-11-2003
        ,monto  --aqui
	,'0'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,civalcomp   
	,''          
  FROM MDCI,CARTERA_CUENTA , mdac
 WHERE cinominal > 0
 AND t_operacion  = 'CI' 
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'MOV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'valor_compra'
 AND ( ciinstser<>'ICOL' AND ciinstser<>'ICAP' ) 	
and 1=2

 INSERT #CARTERA_CI 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,civptirc     
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END
	,monto
	,'1'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then cireajustc ELSE cireajustci END
	,''
 FROM MDCI,CARTERA_CUENTA , mdac
 WHERE cinominal > 0
 AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end) AND cicodigo       = CodigoInst
 AND t_movimiento   = 'DEV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'reajuste_papel'
 AND ( ciinstser<>'ICOL' AND ciinstser<>'ICAP' ) 	
and 1=2

---------------------- MONTO INTERES CARTERA COMPRAS CON PACTO -----------------------------------
 INSERT #CARTERA_CI 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
	,cicodigo  
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
	,cifecvenp  
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END
        ,monto
	,'2'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,CASE WHEN ciinstser = 'ICOL' OR ciinstser = 'ICAP' Then ciinteresc ELSE ciinteresci END
	,''
 FROM MDCI,CARTERA_CUENTA , mdac
 WHERE cinominal > 0
 AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'DEV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'interes_papel'
 AND ( ciinstser<>'ICOL' AND ciinstser<>'ICAP' ) 	
and 1=2

UPDATE #CARTERA_CI 
SET corre = 1

INSERT #CARTERA 
SELECT  tip_oper                                        
       ,'' -- mascara      
       ,numdocu      
       ,numoper      
       ,corre        
       ,codigo       
       ,SUM(tir)          
       ,moneda       
       ,seriado      
       ,tipoper      
       ,tabla        
       ,cuenta       
       ,fecha_compra 
       ,dias_dife    
       ,campo_26     
       ,SUM(interes)      
       ,SUM(monto_origen) 
       ,Cod_Evento   
       ,TipoLinea    
       ,SUM(monto_oper)   
      ,tipo
FROM #CARTERA_CI 
GROUP BY tip_oper --,mascara      
       ,numdocu ,numoper      
       ,corre   ,codigo       
       ,moneda  ,seriado      
       ,tipoper ,tabla        
       ,cuenta  ,fecha_compra 
       ,dias_dife,campo_26     
       ,Cod_Evento,TipoLinea    
       ,tipo


UPDATE #CARTERA_VI SET numdocu = numoper WHERE tabla='MDVI'   --OJO

-- select * from #CARTERA_VI 

INSERT #CARTERA 
SELECT  tip_oper                                        
       ,'' -- mascara      
       ,numdocu      
       ,numoper      
       ,corre        
       ,codigo       
       ,SUM(tir)          
       ,moneda       
       ,seriado      
       ,tipoper      
       ,tabla        
       ,cuenta       
       ,fecha_compra 
       ,dias_dife    
       ,campo_26     
       ,SUM(interes)      
       ,SUM(monto_origen) 
       ,Cod_Evento   
       ,TipoLinea    
       ,SUM(monto_oper)   
      ,tipo
FROM #CARTERA_VI 
GROUP BY tip_oper --,mascara      
       ,numdocu ,numoper      
       ,corre   ,codigo       
       ,moneda  ,seriado      
       ,tipoper ,tabla        
       ,cuenta  ,fecha_compra 
       ,dias_dife,campo_26     
       ,Cod_Evento,TipoLinea    
       ,tipo


END ELSE BEGIN -- DBO,Sp_interfaz_Balance_Trader

	INSERT #CARTERA 
	SELECT 
        	 'MDIR'
		,cpmascara
	 	,cpnumdocu 
	        ,cpnumdocu 
        	,cpcorrela 
	        ,cpcodigo  
        	,RSVPPRESENx--  , RSVPPRESEN,RSVPPRESENX, RSINTERES, RSVPPRESEN + RSINTERES
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
        	,RSINTERES_ACUM  
	        ,RSVPPRESENx
		,'0'
	        ,TipoLinea
        	,RSVPPRESENx 
		,'CP'
	FROM  MDCP, CARTERA_CUENTA, mdac       , mdrs 
	WHERE cpnominal   > 0 AND cprutcart > 0
	AND   t_operacion = 'CP'
	AND   NumDocu   = cpnumdocu
	AND   Correla   = cpcorrela
	AND   NumOper     = cpnumdocu 
	AND   CASE WHEN cpcodigo = 20  THEN 'valor_tasa_emision' ELSE 'valor_compra' END  = variable
	AND rsfecha = @FECHAFINMES
	AND rsnumdocu = cpnumdocu
	AND rscorrela = cpcorrela
	AND rsnumoper = cpnumdocu
	and rsTIPOPER = 'DEV' -------************* VENTAS CON PACTO *****************

---------------------- MONTO CAPITAL CARTERA VENTA CON PACTO -----------------------------------
	 INSERT #CARTERA_VI 
	 SELECT 
        	'MDIR' 
	        ,vimascara
        	,vinumdocu 
	        ,vinumoper
        	,vicorrela 
	        ,vicodigo  
        	,RSVPPRESEN            -- vivptirV ,rsvppresen            ,rsvppresenx  
	        ,CASE
        	WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
	         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        	END      
	        ,viseriado 
        	,'MD01' 
	        ,'MDVI'    
        	,CtaContable
	        ,0      
	        ,datediff(day,acfecproc,vifecvenp)
        	,vifecvenp  
        	,rsvalinip
	        ,rsvalinip
		,'0'
	        ,TipoLinea
        	,rsvalinip
		,''
	   FROM MDVI,CARTERA_CUENTA , mdac   ,MDRS
	   WHERE  vinominal > 0 
	    AND NumDocu   = vinumdocu
	    AND Correla   = vicorrela
	    AND NumOper   = vinumoper 
	    AND CASE WHEN vicodigo in (4,31,32,33,300,301) THEN 'valor_venta' ELSE 'valor_compra'  END  = variable --  variable = 'valor_venta' 
 	    AND rsfecha = @FECHAFINMES
	    AND rsnumdocu = vinumdocu
	    AND rscorrela = vicorrela
	    AND rsnumoper = vinumoper
	    and rsTIPOPER = 'DEV' 
	    AND rscartera = 114

---------------------- MONTO REAJUSTE CARTERA VENTA CON PACTO -----------------------------------
 INSERT #CARTERA_VI
 SELECT  
        'MDIR' 
        ,vimascara
        ,vinumdocu 
        ,vinumoper
        ,vicorrela 
        ,vicodigo  
        ,vivptirV 
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDVI'    
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,RSINTERES_ACUM 
        ,RSREAJUSTE_ACUM
	,'1'
        ,TipoLinea
        ,RSREAJUSTE_ACUM 
	,''
   FROM MDVI,CARTERA_CUENTA , mdac, MDRS
   WHERE  vinominal > 0 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND Variable  = 'Reajuste_papel'
 AND rsfecha = @FECHAFINMES
AND rsnumdocu = vinumdocu
AND rscorrela = vicorrela
AND rsnumoper = vinumoper
and rsTIPOPER = 'DEV' 
AND rscartera = 114


---------------------- MONTO INTERES CARTERA VENTA CON PACTO -----------------------------------
 INSERT #CARTERA_VI
 SELECT  
        'MDIR' 
        ,vimascara
        ,vinumdocu 
        ,vinumoper
        ,vicorrela 
        ,vicodigo  
        ,viinteresv 
	,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDVI'    
        ,CtaContable
        ,0      
    	,datediff(day,acfecproc,vifecvenp)
	,vifecvenp  
	,viinteresvi 
        ,viinteresvi 
	,'2'
        ,TipoLinea
        ,viinteresvi 
	,''

   FROM MDVI,CARTERA_CUENTA , mdac,MDRS
   WHERE vinominal > 0 
    AND NumDocu   = vinumdocu
    AND Correla  = vicorrela
    AND NumOper   = vinumoper 
    AND Variable  = 'Interes_papel'
    and t_operacion = 'dvvi' --     
    AND rsfecha = @FECHAFINMES
    AND rsnumdocu = vinumdocu
   AND rscorrela = vicorrela
   AND rsnumoper = vinumoper
   and rsTIPOPER = 'DEV' 
   AND rscartera = 114
---------------------- MONTO CAPITAL CARTERA INTERMEDIADA -----------------------------------


 INSERT #CARTERA 
 SELECT DISTINCT
         'MDIR' 
         ,vimascara
        ,vinumdocu    
        ,vinumoper 
        ,vicorrela 
        ,vicodigo  
        ,vivalcomp     
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDCP'  
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,RSINTERES_ACUM 
        , rsvppresenx 
	,'0'
        ,TipoLinea
        , rsvppresenx 
	,''
   FROM MDVI,CARTERA_CUENTA , mdac, MDRS
   WHERE vinominal > 0 
    AND  NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND variable  = 'valor_presente'
    AND rsfecha = @FECHAFINMES
    AND rsnumdocu = vinumdocu
    AND  rscorrela = vicorrela
    and rsTIPOPER = 'DEV' 
    AND RSCARTERA = 114


---------------------- MONTO REAJUSTE CARTERA INTERMEDIADA -----------------------------------
 INSERT #CARTERA 

 SELECT DISTINCT
         'MDIR' 
         ,vimascara
        ,vinumdocu    
        ,vinumoper 
        ,vicorrela 
        ,vicodigo  
        ,vivalcomp     
        ,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDCP'  
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,RSINTERES_ACUM 
        ,RSREAJUSTE_ACUM
	,'1'
        ,TipoLinea
        ,RSREAJUSTE_ACUM
	,''
   FROM MDVI,CARTERA_CUENTA , mdac,MDRS
   WHERE vinominal > 0 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND variable  = 'reajuste_papel'
AND rsfecha = @FECHAFINMES
AND rsnumdocu = vinumdocu
AND rscorrela = vicorrela
and rsTIPOPER = 'DEV' 
AND RSCARTERA = 114
---------------------- MONTO INTERES CARTERA INTERMEDIADA -----------------------------------

 INSERT #CARTERA 
 SELECT distinct
         'MDIR' 
         ,vimascara
        ,vinumdocu 
        ,vinumoper 
        ,vicorrela 
        ,vicodigo  
        ,vivalcomp  --   , RSVALCOMP
	,CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
         ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,viseriado 
        ,'MD01' 
        ,'MDCP'  
        ,CtaContable
        ,0      
        ,datediff(day,acfecproc,vifecvenp)
        ,vifecvenp  
        ,RSINTERES_ACUM
        , RSINTERES_ACUM + RSVALCOMU 
	,'0'
        ,TipoLinea
      ,RSINTERES_ACUM 
	,''
   FROM MDVI,CARTERA_CUENTA , mdac,MDRS
   WHERE NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND variable  = 'interes_papel'
    AND t_operacion = 'dvit'
    AND rsfecha = @FECHAFINMES
    AND rsnumdocu = vinumdocu
    AND rscorrela = vicorrela
AND rsNUMOPER  = viNUMOPER
and rsTIPOPER = 'DEV' 
AND RSCARTERA = 114

---------------------- MONTO CAPITAL CARTERA COMPRAS CON PACTO -----------------------------------
 INSERT #CARTERA 

 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,RSVPPRESEN 
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,RSINTERES_ACUM
        ,CIVALCOMP 
	,'0'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,CIVALCOMP 
	,''
 FROM MDCI,CARTERA_CUENTA , mdac,mdrs
 WHERE cinominal > 0
 AND   t_operacion  = (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'MOV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'valor_compra'
 AND rsfecha = @FECHAFINMES
AND rsnumdocu = cinumdocu
AND rscorrela = cicorrela
and rsTIPOPER = 'DEV' 
AND ( ciinstser='ICOL' OR ciinstser='ICAP' ) 	

-- SELECT * FROM MDCI
---------------------- MONTO REAJUSTE CARTERA COMPRAS CON PACTO -----------------------------------
 INSERT #CARTERA 
SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,rsvppresen    
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,rsreajuste_acum
        ,rsreajuste_acum
	,'1'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,rsreajuste_acum
	,''
 FROM MDCI,CARTERA_CUENTA , mdac,MDRS
 WHERE cinominal > 0
 AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end) AND cicodigo       = CodigoInst
 AND t_movimiento   = 'DEV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'reajuste_papel'
AND rsfecha = @FECHAFINMES
AND rsnumdocu = cinumdocu
AND rscorrela = cicorrela
and rsTIPOPER = 'DEV' 
 AND ( ciinstser='ICOL' OR ciinstser='ICAP' ) 	


---------------------- MONTO INTERES CARTERA COMPRAS CON PACTO -----------------------------------
 INSERT #CARTERA 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,RSINTERES_ACUM 
        ,cimonpact
	,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,RSINTERES_ACUM
        ,RSINTERES_ACUM
	,'2'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,RSINTERES_ACUM 
	,''
 FROM MDCI,CARTERA_CUENTA , mdac,MDRS
 WHERE cinominal > 0
 AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'DEV'
 AND NumDocu      = cinumdocu
 AND Correla = cicorrela
 AND variable       = 'interes_papel'
AND rsfecha = @FECHAFINMES
AND rsnumdocu = cinumdocu
AND rscorrela = cicorrela
and rsTIPOPER = 'DEV' 
AND ( ciinstser='ICOL' OR ciinstser='ICAP' ) 	



 INSERT #CARTERA_CI 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,RSVPPRESEN 
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        , RSINTERES_ACUM
        ,CIVALCOMP 
	,'0'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,CIVALCOMP 
	,''
 FROM MDCI,CARTERA_CUENTA , mdac,mdrs
 WHERE cinominal > 0
 AND   t_operacion  = (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'MOV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'valor_compra'
AND rsfecha = @FECHAFINMES
AND rsnumdocu = cinumdocu
AND rscorrela = cicorrela
and rsTIPOPER = 'DEV' 
AND ( ciinstser<>'ICOL' AND ciinstser<>'ICAP' ) 	

-- SELECT * FROM MDCI
---------------------- MONTO REAJUSTE CARTERA COMPRAS CON PACTO -----------------------------------
INSERT #CARTERA_CI 
SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,rsvppresen    
        ,cimonpact
        ,ciseriado 
        ,'MD01'
        ,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,rsreajuste_acum
        ,rsreajuste_acum
	,'1'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,rsreajuste_acum
	,''
 FROM MDCI,CARTERA_CUENTA , mdac,MDRS
 WHERE cinominal > 0
 AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end) AND cicodigo       = CodigoInst
 AND t_movimiento   = 'DEV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'reajuste_papel'
AND rsfecha = @FECHAFINMES
AND rsnumdocu = cinumdocu
AND rscorrela = cicorrela
and rsTIPOPER = 'DEV' 
AND ( ciinstser<>'ICOL' AND ciinstser<>'ICAP' ) 	

---------------------- MONTO INTERES CARTERA COMPRAS CON PACTO -----------------------------------

 INSERT #CARTERA_CI 
 SELECT  'MDIR' 
        ,cimascara
        ,cinumdocu 
        ,cinumdocu 
        ,cicorrela 
        ,cicodigo  
        ,RSINTERES_ACUM 
        ,cimonpact
        ,ciseriado 
        ,'MD01'
	,'MDCI'
        ,CtaContable
        ,cifeccomp      
        ,datediff(day,acfecproc,cifecvenp)
        ,cifecvenp  
        ,RSINTERES_ACUM
        ,RSINTERES_ACUM
	,'2'
        ,CASE WHEN ciinstser = 'ICAP'  THEN 'H' ELSE 'D' END
        ,RSINTERES_ACUM 
	,''
 FROM MDCI,CARTERA_CUENTA , mdac
,MDRS
 WHERE cinominal > 0
 AND t_operacion  = (CASE WHEN ciinstser = 'ICOL' THEN 'DICO' WHEN ciinstser = 'ICAP' Then 'DICA' else 'DVCI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'DEV'
 AND NumDocu      = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'interes_papel'
AND rsfecha = @FECHAFINMES
AND rsnumdocu = cinumdocu
AND rscorrela = cicorrela
and rsTIPOPER = 'DEV' 
AND ( ciinstser<>'ICOL' AND ciinstser<>'ICAP' ) 	


UPDATE #CARTERA_CI 
SET corre = 1

INSERT #CARTERA 
SELECT  tip_oper                                        
       ,'' -- mascara      
       ,numdocu      
       ,numoper      
       ,corre        
       ,codigo       
       ,SUM(tir)          
       ,moneda       
       ,seriado      
       ,tipoper      
       ,tabla        
       ,cuenta       
       ,fecha_compra 
       ,dias_dife    
       ,campo_26     
       ,SUM(interes)      
       ,SUM(monto_origen) 
       ,Cod_Evento   
       ,TipoLinea    
       ,SUM(monto_oper)   
      ,tipo
FROM #CARTERA_CI 
GROUP BY tip_oper --,mascara      
       ,numdocu ,numoper      
       ,corre   ,codigo       
       ,moneda  ,seriado      
       ,tipoper ,tabla        
       ,cuenta  ,fecha_compra 
       ,dias_dife,campo_26     
       ,Cod_Evento,TipoLinea    
       ,tipo

UPDATE #CARTERA_VI SET numdocu = numoper WHERE tabla='MDVI'   --OJO


INSERT #CARTERA 
SELECT  tip_oper                                        
       ,'' -- mascara      
       ,numdocu      
       ,numoper      
       ,corre        
       ,codigo       
       ,SUM(tir)          
       ,moneda       
       ,seriado      
       ,tipoper      
       ,tabla        
       ,cuenta       
       ,fecha_compra 
       ,dias_dife    
       ,campo_26     
       ,SUM(interes)      
       ,SUM(monto_origen) 
       ,Cod_Evento   
       ,TipoLinea    
       ,SUM(monto_oper)   
      ,tipo
FROM #CARTERA_VI 
GROUP BY tip_oper --,mascara      
       ,numdocu ,numoper      
       ,corre   ,codigo       
       ,moneda  ,seriado      
       ,tipoper ,tabla        
       ,cuenta  ,fecha_compra 
       ,dias_dife,campo_26     
       ,Cod_Evento,TipoLinea    
       ,tipo
END

        UPDATE #CARTERA SET tipolinea = convert(CHAR(3) ,b.tipo_cuenta)
	FROM #CARTERA			AS A
	INNER JOIN VIEW_PLAN_DE_CUENTA	AS B ON
		B.cuenta = A.cuenta


DECLARE CURSOR_INTER CURSOR FOR 
SELECT     tip_oper      ,mascara       ,  numdocu   , numoper , corre   ,codigo
         , tir           ,moneda        ,  seriado   , tipoper , tabla   ,cuenta
         , fecha_compra  ,dias_dife     ,  campo_26  , interes ,monto_oper,Cod_Evento
         , monto_origen  ,TipoLinea	,  tipo
  FROM #CARTERA

OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO       @tip_oper      , @mascara      , @numdocu    , @numoper , @corre   , @codigo
         , @tir           , @moneda       , @seriado    , @tipoper , @tabla   , @cuenta
         , @fecha_compra  , @dias_dife    , @campo_26   , @interes , @monto_oper,@Cod_Evento
         , @monto_origen  , @TipoLinea    , @tipo
WHILE @@FETCH_STATUS  = 0
BEGIN 

   
IF @Moneda = 998 or @Moneda = 997 or @Moneda = 994 or @Moneda = 995 or @Moneda = 999
BEGIN
    SELECT @cMoneda = '00'
end else begin
if @moneda = 13
    select @cMoneda = '11'

end
-- select * from view_plan_de_cuenta

   IF @TipoLinea = 'ACT'  
       SELECT @indicador = 'D'
   ELSE IF @TipoLinea = 'PER'  
      SELECT @indicador = 'D'
   ELSE IF @TipoLinea = 'PAS'  
       SELECT @indicador = 'C'
   ELSE IF @TipoLinea = 'UTI'  
      SELECT @indicador = 'C'


   select @NumCuenta    = ''
   select @Ccuenta      = '0'
   select @Monto        = 0
   select @NumValor     = ''    
   select @NumReajuste  = ''
   select @NumInteres   = ''  


IF @moneda <> 999
BEGIN
   SELECT @vDolar_obs=0
   SELECT @vDolar_obs = isnull((select vmvalor from view_valor_moneda where vmcodigo = @moneda and vmfecha = @fecpro),0)

   IF @moneda =13 BEGIN
      SELECT @vDolar_obs = 1
   END 

   SELECT @monto_oper = @Monto_oper/@vDolar_obs
   SELECT @interes    = @interes/@vDolar_obs
END
  ELSE SELECT @monto_oper = @Monto_oper /1

 IF @cuenta <> '0' AND @cuenta <> ''
      BEGIN

      IF @monto_origen < 0 BEGIN
         IF @indicador = 'D' BEGIN
            SELECT @indicador = 'C'
END ELSE IF @indicador = 'C' BEGIN
            SELECT @indicador = 'D'
         END

      END

      INSERT #TABLA_INTERFAZ2 VALUES (  'CL'
				       	,'BO15'
				       	,'MDIR'
					,@tip_oper  
					,@tipoper
                              		,CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5))
                              		,convert(char(8),@fecpro,112)
					,  @cuenta 
					, @indicador
					, @Cod_Evento
                              		,CASE WHEN @Monto_oper < 0 THEN '-' ELSE '+' END
					,@Monto_oper
					,CASE WHEN @monto_origen < 0 THEN '-' ELSE '+' END
					,@monto_origen 
					,CASE WHEN @monto_origen < 0 THEN '-' ELSE '+' END
					,@interes
					,@cMoneda )
				
      END

                      
FETCH NEXT FROM CURSOR_INTER
INTO       @tip_oper      , @mascara      , @numdocu    , @numoper , @corre   , @codigo
         , @tir           , @moneda       , @seriado    , @tipoper , @tabla   , @cuenta
         , @fecha_compra  , @dias_dife    , @campo_26   , @interes , @monto_oper,@Cod_Evento
         , @monto_origen  , @TipoLinea    , @tipo
      
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER

SELECT @Max = COUNT(*) FROM #TABLA_INTERFAZ2
SELECT @Max,* FROM #TABLA_INTERFAZ2

END

-- 8650


GO
