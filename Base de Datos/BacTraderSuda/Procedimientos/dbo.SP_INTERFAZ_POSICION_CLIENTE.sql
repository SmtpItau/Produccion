USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_POSICION_CLIENTE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_INTERFAZ_POSICION_CLIENTE]
AS
BEGIN 

 SET NOCOUNT ON

DECLARE 
      @moneda       NUMERIC (5)                           --1
     ,@cuenta       CHAR(20)                              --2
     ,@tipprod      CHAR(4)                               --3
     ,@tipproc      CHAR(2)        -- C=a 70   V=p 71     --4
     ,@codprod      CHAR(4)                               --5
     ,@clscontble   CHAR(3)                               --6
     ,@acteconomica CHAR(4)                               --7
     ,@desproducto  CHAR(35)                              --8
     ,@mesproceso   NUMERIC(2)                            --9
     ,@diaproceso   NUMERIC(2)                            --10
     ,@anoproceso   NUMERIC(4)                            --11
     ,@nrooper      CHAR(16)                              --12
     ,@rutcliente   CHAR(9)                               --13
     ,@digcliente   CHAR(1)                               --14
     ,@mesapertura  NUMERIC(2)                            --15
     ,@diaapertura  NUMERIC(2)                            --16
     ,@anoapertura  NUMERIC(4)                            --17
     ,@tasabase     NUMERIC(9,6)                          --18
     ,@plazotasa    NUMERIC(4)                            --19
     ,@tasaoperac   NUMERIC(9,6)                          --20
     ,@mtoorigen    NUMERIC(18,2)                         --21
     ,@mtocapital   NUMERIC(18,2)                         --22
     ,@sdomdaorig   NUMERIC(18,2)                         --23 
     ,@sdomdanaci   NUMERIC(18,2)                         --24 
     ,@intmdaorigen NUMERIC(18,2)                         --25
     ,@intmdanacio  NUMERIC(18,2)                         --26
     ,@reajustes    NUMERIC(18,2)                         --27
     ,@sdodeuda     NUMERIC(18,2)                         --28
     ,@sdovcto      NUMERIC(18,2)                         --29
     ,@fechainicio  DATETIME                              --30   
     ,@producto     CHAR(02)                              --31
     ,@fechavcto    DATETIME                              --32
     ,@acfecprox    DATETIME
     ,@fecpro       DATETIME 
     ,@indicador    CHAR(1)
     ,@Max          INTEGER
     ,@vDolar_obs   NUMERIC(18,2)
     ,@valor        NUMERIC(18,2)
     ,@tipo_cuenta  NUMERIC(2)
     ,@tasa         NUMERIC(11,6)
     ,@tasaint      NUMERIC(18,2)
     ,@suma         NUMERIC(18,2)
     ,@dFinmesAntDo DATETIME
     ,@vDolar_obsFinMes NUMERIC(18,2)
     ,@cMnMx	    CHAR(01)

CREATE TABLE #CARTERA
    (
      moneda       NUMERIC (5)                           --1
     ,cuenta       CHAR(20)                              --2
     ,tipprod      CHAR(4)                               --3
     ,tipproc      CHAR(2)        -- C=a 70   V=p 71     --4
     ,codprod      CHAR(4)                               --5
     ,clscontble   CHAR(3)                               --6
     ,acteconomica CHAR(4)                               --7
     ,desproducto  CHAR(35)                              --8
     ,mesproceso   NUMERIC(2)                            --9
     ,diaproceso   NUMERIC(2)                            --10
     ,anoproceso   NUMERIC(4)                            --11
     ,nrooper      CHAR(16)                              --12
     ,rutcliente   CHAR(9)                               --13
     ,digcliente   CHAR(1)                               --14
     ,mesapertura  NUMERIC(2)                            --15
     ,diaapertura  NUMERIC(2)                            --16
     ,anoapertura  NUMERIC(4)                            --17
     ,tasabase     NUMERIC(9,6)                          --18
     ,plazotasa    NUMERIC(4)                            --19
     ,tasaoperac   NUMERIC(9,6)                          --20
     ,mtoorigen    NUMERIC(18,2)                         --21
     ,mtocapital   NUMERIC(18,2)                         --22
     ,sdomdaorig   NUMERIC(18,2)                         --23 
     ,sdomdanaci   NUMERIC(18,2)                         --24 
   ,intmdaorigen NUMERIC(18,2)                         --25
     ,intmdanacio  NUMERIC(18,2)                         --26
     ,reajustes    NUMERIC(18,2)                         --27
     ,sdodeuda     NUMERIC(18,2)                         --28
     ,sdovcto      NUMERIC(18,2)                         --29
     ,fechainicio  DATETIME                              --30   
     ,producto     CHAR(02)                              --31
     ,fechavcto    DATETIME                              --32
     ,tasa            NUMERIC(11,6)                     --33
    )


CREATE TABLE #TABLA_INTERFAZ
   (   
       EXPBNK      CHAR(02)            	--2
      ,EXPBRN      CHAR(03)            	--3
      ,EXPCCY      CHAR(03)            	--4
      ,EXPGLN      NUMERIC(16)      	--5
      ,EXPATY      CHAR(04)            	--6
      ,EXPACD      CHAR(02)            	--7
      ,EXPRO       CHAR(04)             --8
      ,EXPCLS      NUMERIC(3)        	--9
      ,EXPIND      CHAR(4)              --10
      ,EXPUC1      CHAR(04)            	--11
      ,EXPDSC      CHAR(35)            	--12
      ,EXPRDM      NUMERIC(02)      	--13
      ,EXPRDD      NUMERIC(02)      	--14
      ,EXPRDY      NUMERIC(04)      	--15
      ,EXPPRC      CHAR(04)            	--16
      ,EXPNRF      CHAR(16)            	--17
      ,EXPNID      CHAR(9)              --18
      ,DIG         CHAR(1)              --19
      ,EXPSDU      CHAR(01)            	--20
      ,EXPFAM      NUMERIC(02)      	--21
      ,EXPFAD      NUMERIC(02)      	--22   
      ,EXPFAY      NUMERIC(04)      	--23
      ,EXPFVM      NUMERIC(02)     	--24
      ,EXPFVD      NUMERIC(02)      	--25
      ,EXPFVY      NUMERIC(04)      	--26
      ,EXPTBS      NUMERIC(9,6)     	--27
      ,EXPPTB      NUMERIC(04)      	--28
      ,EXPTOP      NUMERIC(9,6)     	--29
      ,EXPCPO      NUMERIC(18,2)   	--30
      ,EXPCPON     NUMERIC(18,2)  	--31
      ,EXPBAL      NUMERIC(18,2)    	--32
      ,EXPBALN     NUMERIC(18,2)   	--33
      ,EXPIAL      NUMERIC(18,2)     	--34
      ,EXPIALN     NUMERIC(18,2)    	--35
      ,EXPRAL      NUMERIC(18,2)    	--36
      ,EXPSDE      NUMERIC(18,2)    	--37
      ,EXPSAV      NUMERIC(18,2)    	--38
      ,EXPAC1      CHAR(2)              --39
      ,EXPFL1      CHAR(1)              --40
      ,EXPSTS      CHAR(1)              --41  
      ,EXPEXR      NUMERIC(11,6)    	--42
      ,suma        NUMERIC(18,2)	--43
   )      

 SELECT @fecpro  = acfecproc ,
        @acfecprox = acfecprox
 FROM MDAC

 set @vDolar_obs = isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @fecpro),0)

 SELECT @dFinmesAntDo = (@fecpro - Day(@fecpro))
 select @dFinmesAntDo = max(vmfecha) from view_valor_moneda where month(vmfecha) = month(@dFinmesAntDo) AND
								  year(vmfecha) = year(@dFinmesAntDo)   AND
								  vmvalor <> 0

 IF MONTH(@acfecprox) <> MONTH(@fecpro)
	SELECT @dFinmesAntDo = @fecpro

 set @vDolar_obsFinMes = isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @dFinmesAntDo),0)


 INSERT #CARTERA 
 SELECT     
        CASE
        WHEN cpseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
           ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
        END      
        ,CASE WHEN CtaContable ='' THEN '0' ELSE CtaContable END
        ,'MDIR'            --SP_HELP VIEW_PLAN_DE_CUENTA
        ,'70'          
        ,'MD01' --isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = 'CP'),'')
        ,isnull((select tipo_cuenta from VIEW_PLAN_DE_CUENTA where cuenta = CtaContable),'')
        ,isnull(CONVERT(CHAR(4),(select clactivida from VIEW_CLIENTE where Clrut = cprutcli AND Clcodigo= cpcodcli)),'')
,isnull((select descripcion from  Bacparamsuda..PRODUCTO where codigo_producto= 'CP'  and  id_sistema = 'BTR'),'')
        ,CONVERT(NUMERIC(2),MONTH(@fecpro))
        ,CONVERT(NUMERIC(2),DAY(@fecpro))
        ,CONVERT(NUMERIC(4),YEAR(@fecpro))

        ,CAST(cpnumdocu AS VARCHAR(6)) +  cast(cpcorrela AS VARCHAR(3))+ CAST( cpnumdocu AS VARCHAR(6))

        ,case when cpcodigo <> 15 then CONVERT(NUMERIC(9),cprutcli) 
              else (select CONVERT(NUMERIC(9),serutemi) FROM view_serie where cpinstser = semascara) 
         END
        ,case when cpcodigo <> 15 then ISNULL((select Cldv FROM VIEW_CLIENTE where Clrut = cprutcli AND Clcodigo = cpcodcli),'')
             else isnull((select cldv from view_serie,view_cliente where cpinstser = semascara  and clrut = serutemi),'')
         END
  	,CONVERT(NUMERIC(2),MONTH(cpfecemi))
        ,CONVERT(NUMERIC(2),DAY(cpfecemi))
        ,CONVERT(NUMERIC(4),YEAR(cpfecemi))
        ,CASE 
            WHEN cpseriado='N' THEN isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
            ELSE isnull((SELECT top 1 setasemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
         END --motaspact                                                                                                   --35
         ,CASE 
            WHEN cpseriado='N' THEN isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
            ELSE isnull((SELECT top 1  sebasemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
          END   --mobasemi                                                                                                  --35
         ,cptircomp
         ,cpvalcomu
         ,cpvalcomp
         ,cpvalcomu    
         ,cpvalcomp
         ,0
         ,cpinteresc   
         ,cpreajustc
         ,cpvptirc
         ,cpvalvenc
         ,cpfeccomp
         ,'CP'                 
         ,cpfecven
         ,0
 FROM MDCP  ,CARTERA_CUENTA , mdac
 WHERE cpnominal   > 0 AND cprutcart > 0
 AND   t_operacion = 'CP'
 AND   NumDocu     = cpnumdocu
 AND   Correla     = cpcorrela
 AND   NumOper     = cpnumdocu 
 AND   variable    = 'valor_compra'

-- SELECT CtaContable,* FROM CARTERA_CUENTA
------- 


 INSERT #CARTERA 
 SELECT  
        CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
           ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,CASE WHEN CtaContable ='' THEN '0' ELSE CtaContable END
        ,'MDIR'
        ,'71'
        ,'MD01'--isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = 'CP'),'')
        ,isnull((select tipo_cuenta from VIEW_PLAN_DE_CUENTA where cuenta = CtaContable),'') 
        ,isnull(CONVERT(CHAR(5),(select clactivida from VIEW_CLIENTE where Clrut = virutcli AND Clcodigo= vicodcli)),'')
        ,isnull((select descripcion from  Bacparamsuda..PRODUCTO where codigo_producto= 'CP'  and  id_sistema = 'BTR'),'')
        ,CONVERT(NUMERIC(2),MONTH(@fecpro))
        ,CONVERT(NUMERIC(2),DAY(@fecpro))
        ,CONVERT(NUMERIC(4),YEAR(@fecpro))

        ,CAST(vinumdocu AS VARCHAR(6)) +  cast(vicorrela AS VARCHAR(3))+ CAST( vinumdocu AS VARCHAR(6))
        
        ,CONVERT(NUMERIC(9),virutcli )
        ,ISNULL((select Cldv FROM VIEW_CLIENTE where  Clrut = virutcli AND  Clcodigo = vicodcli),0)                 --6
        ,CONVERT(NUMERIC(2),MONTH(vifecemi))
        ,CONVERT(NUMERIC(2),DAY(vifecemi))
        ,CONVERT(NUMERIC(4),YEAR(vifecemi))
        ,CASE 
            WHEN viseriado='N' THEN isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
            ELSE isnull((SELECT top 1 setasemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
         END --motaspact                       --35
         ,CASE 
            WHEN viseriado='N' THEN isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
            ELSE isnull((SELECT top 1  sebasemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
          END   --mobasemi                                                                           --35
         ,vitircomp
         ,0
         ,vivalinip
         ,0
         ,vivalinip
         ,0
         ,viinteresv  
         ,vireajustv
         ,vivptirc
         ,vivalvenp
         ,vifecinip
         ,'CP'
         ,vifecvenp
         ,0
   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
 AND NumOper   = vinumoper 
    AND variable  = 'valor_compra'


 INSERT #CARTERA 
 SELECT 
        CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
           ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,CASE WHEN CtaContable ='' THEN '0' ELSE CtaContable END
        ,'MDIR'
        ,'71'
        ,'MD01' --isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = vitipoper),'')
        ,isnull((select tipo_cuenta from VIEW_PLAN_DE_CUENTA where cuenta = CtaContable),'') 
        ,isnull(CONVERT(CHAR(5),(select clactivida from VIEW_CLIENTE where Clrut = virutcli AND Clcodigo= vicodcli)),'')
        ,isnull((select descripcion from  Bacparamsuda..PRODUCTO where codigo_producto= 'CP'  and  id_sistema = 'BTR'),'')
        ,CONVERT(NUMERIC(2),MONTH(@fecpro))
        ,CONVERT(NUMERIC(2),DAY(@fecpro))
        ,CONVERT(NUMERIC(4),YEAR(@fecpro))
        
        ,CAST(vinumdocu AS VARCHAR(6)) +  cast(vicorrela AS VARCHAR(3))+ CAST( vinumdocu AS VARCHAR(6))
        
        ,CONVERT(NUMERIC(9),virutcli )
        ,ISNULL((select Cldv FROM VIEW_CLIENTE where  Clrut = virutcli AND  Clcodigo = vicodcli),'')                 --6
        ,CONVERT(NUMERIC(2),MONTH(vifecemi))
        ,CONVERT(NUMERIC(2),DAY(vifecemi))
        ,CONVERT(NUMERIC(4),YEAR(vifecemi))
        ,CASE 
            WHEN viseriado='N' THEN isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
            ELSE isnull((SELECT top 1 setasemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END --motaspact                                                                                                   --35
        ,CASE 
            WHEN viseriado='N' THEN isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
            ELSE isnull((SELECT top 1  sebasemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
         END   --mobasemi                                                                                                  --35
         ,vitircomp
         ,0
         ,vivalinip
         ,0
         ,vivalinip
         ,0
         ,viinteresv
         ,vireajustv
         ,vivptirc
         ,0
         ,vifecinip
         ,vitipoper
         ,vifecvenp
         ,0
   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND variable  = 'valor_compra'


---
 INSERT #CARTERA 
 SELECT  
        cimonpact --debe ser la moneda del pacto
--        CASE
--        WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN cimonpact
--        WHEN ciseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cinumdocu AND nscorrela=cicorrela),0)
--           ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=substring(cimascara,1,6)),0)
--        END      
        ,CASE WHEN CtaContable ='' THEN '0' ELSE CtaContable END
        ,'MDIR'
        ,'70'
        ,'MD01' --CASE
       --WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = ciinstser),'')
                --ELSE isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = 'CI'),'')
                --END  
        ,isnull((select tipo_cuenta from VIEW_PLAN_DE_CUENTA where cuenta = CtaContable),'') 
        ,isnull(CONVERT(CHAR(5),(select clactivida from VIEW_CLIENTE where Clrut = cirutcli AND Clcodigo= cicodcli)),'')
        ,isnull((select descripcion from  Bacparamsuda..PRODUCTO where codigo_producto= 'CI'  and  id_sistema = 'BTR'),'')
        ,CONVERT(NUMERIC(2),MONTH(@fecpro))
        ,CONVERT(NUMERIC(2),DAY(@fecpro))
       ,CONVERT(NUMERIC(4),YEAR(@fecpro))

        ,CAST(cinumdocu AS VARCHAR(6)) +  cast(cicorrela AS VARCHAR(3))+ CAST( cinumdocu AS VARCHAR(6))
		
        ,cirutcli 
        ,ISNULL((select Cldv FROM VIEW_CLIENTE where Clrut = cirutcli AND  Clcodigo = cicodcli),0)                 --6
        ,CONVERT(NUMERIC(2),MONTH(cifecemi))
        ,CONVERT(NUMERIC(2),DAY(cifecemi))
        ,CONVERT(NUMERIC(4),YEAR(cifecemi))
        ,CASE 
           WHEN ciseriado='N' THEN isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsnumdocu=cinumdocu AND nscorrela=cicorrela),0)
           ELSE isnull((SELECT top 1 setasemi FROM VIEW_SERIE WHERE semascara=cimascara),0)
         END --motaspact                                                                                                   --35
        ,CASE 
            WHEN ciseriado='N' THEN isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu=cinumdocu AND nscorrela=cicorrela),0)
            ELSE isnull((SELECT top 1  sebasemi FROM VIEW_SERIE WHERE semascara=cimascara),0)
         END   --mobasemi                                                                                                  --35
        ,citaspact
        ,civalcomu
        ,CASE WHEN cimonpact = 13 THEN ROUND(civalinip*@vDolar_obsFinMes,0) --AND ciinstser in('ICOL','ICAP')
	      WHEN mnmx = 'C' THEN ROUND(civalinip*(Select Isnull(vmvalor,0) From View_Valor_Moneda Where vmcodigo = cimonpact and vmfecha = @dFinmesAntDo),0) 
	      ELSE civalcomp END  --VGS civalcomp -- 22
        ,civalcomu
        ,CASE WHEN cimonpact = 13 THEN ROUND(civalinip*@vDolar_obsFinMes,0)  --AND ciinstser in('ICOL','ICAP')
	      WHEN mnmx = 'C' THEN ROUND(civalinip*(Select Isnull(vmvalor,0) From View_Valor_Moneda Where vmcodigo = cimonpact and vmfecha = @dFinmesAntDo),0) 
	      ELSE civalcomp END  --VGS civalcomp -- 24
        ,0
        ,CASE WHEN cimonpact = 13 AND ciinstser in('ICOL','ICAP') THEN ROUND(ciinteresc*@vDolar_obsFinMes,0) 
              WHEN cimonpact = 13 THEN ROUND(ciinteresci*@vDolar_obsFinMes,0) 
	      WHEN mnmx = 'C' THEN ROUND(ciinteresci*(Select Isnull(vmvalor,0) From View_Valor_Moneda Where vmcodigo = cimonpact and vmfecha = @dFinmesAntDo),0) 
	      ELSE ciinteresc END  --VGS ciinteresc -- 26
        ,cireajustc
        ,CASE WHEN cimonpact = 13 THEN ROUND(civptirc*@vDolar_obsFinMes,0) --AND ciinstser in('ICOL','ICAP')
	      WHEN mnmx = 'C' THEN ROUND(civptirc*(Select Isnull(vmvalor,0) From View_Valor_Moneda Where vmcodigo = cimonpact and vmfecha = @dFinmesAntDo),0) 
	      ELSE civptirc END  --VGS civptirc -- 28
        ,civalvenp
        ,cifecinip
        ,CASE
            WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
            ELSE 'CI'
         END
        ,cifecvenp
        ,0
 FROM MDCI,CARTERA_CUENTA , mdac,View_Moneda
 WHERE t_operacion  = (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'MOV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'valor_compra'
 AND cimonpact	    = mncodmon  -- VGS 

DECLARE CURSOR_INTER CURSOR FOR 
SELECT     moneda      ,cuenta          ,tipprod      ,tipproc       ,codprod      ,clscontble   ,acteconomica
         ,desproducto  ,mesproceso      ,diaproceso   ,anoproceso    ,nrooper      ,rutcliente   ,digcliente
         ,mesapertura  ,diaapertura     ,anoapertura  ,tasabase      ,plazotasa    ,tasaoperac   ,mtoorigen
         ,mtocapital   ,sdomdaorig      ,sdomdanaci   ,intmdaorigen  ,intmdanacio  ,reajustes    ,sdodeuda
         ,sdovcto      ,fechainicio     ,producto     ,fechavcto,tasa
FROM #CARTERA

OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO      @moneda         ,@cuenta          ,@tipprod      ,@tipproc      ,@codprod     ,@clscontble   ,@acteconomica
         ,@desproducto    ,@mesproceso      ,@diaproceso   ,@anoproceso   ,@nrooper     ,@rutcliente   ,@digcliente
         ,@mesapertura    ,@diaapertura     ,@anoapertura  ,@tasabase     ,@plazotasa   ,@tasaoperac   ,@mtoorigen   
         ,@mtocapital     ,@sdomdaorig      ,@sdomdanaci   ,@intmdaorigen ,@intmdanacio ,@reajustes   ,@sdodeuda    
         ,@sdovcto        ,@fechainicio     ,@producto     ,@fechavcto,@tasa
WHILE @@FETCH_STATUS  = 0
BEGIN

----

   SELECT @valor   = 0
   SELECT @tasa   = 0
   SELECT @tasaint = 0

   SELECT @valor = ISNULL((select vmvalor from view_valor_moneda where vmcodigo=@moneda and vmfecha = @fechainicio),0.0)

   -- VGS Validacion MOneda MX y Dolar USD
   SELECT @cMnMx = mnmx FROM View_moneda Where mncodmon = @moneda

   IF @cMnMx = 'C' and @moneda = 13 BEGIN
	SELECT @valor = ISNULL((select vmvalor from view_valor_moneda where vmcodigo=994 and vmfecha = @fechainicio),0.0)
   END ELSE BEGIN
	IF @cMnMx = 'C' and @moneda <> 13
		SELECT @valor = ISNULL((select vmvalor from view_valor_moneda where vmcodigo=@moneda and vmfecha = @fechainicio),0.0)
   END
   ------------------------------------------


   IF @valor = 0
      SET @tasa =  (case when @mtoorigen = 0 then 0 else  @mtocapital /  @mtoorigen  end ) -- MAP20070209
   ELSE
      SET @tasa =  @valor

-- MAP 20070209
-- select 'debug' , '@tasa', @tasa, '@moneda', @moneda,  '@fechainicio', @fechainicio, '@mtocapital', @mtocapital,  '@mtoorigen', @mtoorigen

   IF @producto = 'VI'
   BEGIN
      IF  @moneda <> 999
         BEGIN
            SET @mtoorigen     =  @mtocapital  / @valor
            SET @sdomdaorig    =  @sdomdanaci / @valor
      END ELSE BEGIN
         SET @mtoorigen    =  @mtocapital
         SET @sdomdaorig = @sdomdanaci
      END
   END

   IF @moneda <> 999
   BEGIN
         IF @valor <>  0
            BEGIN
               SET @intmdaorigen = @intmdanacio/@valor
         END ELSE BEGIN
               SET @intmdaorigen =  @intmdanacio
            END
  END ELSE
      SET @intmdaorigen =  @intmdanacio

-------------------------------------------
   IF @clscontble = 'ACT' 
      SELECT @tipo_cuenta = 01

   IF @clscontble = 'PAS'
      SELECT  @tipo_cuenta = 02

   IF @clscontble = 'PER'
      SELECT  @tipo_cuenta = 05

   IF @clscontble = 'UTI'
      SELECT  @tipo_cuenta = 04

   IF @clscontble = 'ORD'
      SELECT  @tipo_cuenta = 09



INSERT #TABLA_INTERFAZ VALUES (  '01'                                --2-codigo banco
                                ,'001'                               --3-codigo sucursal
                                ,CONVERT(CHAR(3),@moneda)            --4-codigo moneda
                                ,CONVERT(NUMERIC(16),@cuenta)        --5-cta contable
                                ,@tipprod                                                   --6-tipo producto
                                ,@tipproc                                                   --7-tipo proceso
                                ,@codprod                                                 --8-codigo producto
                                ,ISNULL(@tipo_cuenta,00)                                   --9 PP
                                ,@acteconomica                                        --10-act economica
                                ,'M'                                                           --11
                                ,@desproducto                                          --12-descripcion producto
   ,@mesproceso                                          --13-mes proceso
                                ,@diaproceso                                            --14-dia proceso
                                ,@anoproceso                                           --15-ano proceso
                  ,CONVERT(CHAR(4),@moneda)                 --16-cod moneda
                                ,@nrooper                                       --17-nro operacion
                                ,@rutcliente                                              --18-rut cliente
                                ,@digcliente                                              --19-digito
                                ,'1'                                                            --20
                                ,@mesapertura                                         --21-mes apertura
                                ,@diaapertura                                           --22-dias apertura
                                ,@anoapertura                                          --23-ano apertura
                                ,CONVERT(NUMERIC(2),MONTH(@fechavcto))     --24-mes vencimiento
                                ,CONVERT(NUMERIC(2),DAY(@fechavcto))   --25-dia vencimiento
                                ,CONVERT(NUMERIC(4),YEAR(@fechavcto)) --26-ano vencimiento
                                ,@tasabase                                                 --27-tasa base
                                ,@plazotasa                                                --28-plazo tasa
                                ,@tasaoperac                                             --29-tasa operacion
                                ,@mtoorigen                                               --30-mto origen
                                ,@mtocapital                                              --31-mto capital
                                ,@sdomdaorig                                            --32-sdomdaorigen 
                                ,@sdomdanaci                                            --33-sdomdaorigen
                                ,@intmdaorigen                                           --34-intmdaorigen
                                ,@intmdanacio                                            --35-intmdanacio
                                ,@reajustes                                                --36-rejustes
                                ,@sdodeuda                                   --37-sdodeuda
                                ,@sdovcto                                --38-sdovcto
                                ,'13'                                                           --39
                                ,'X'                                                            --40
                                ,'A'                                                            --41
                                ,@tasa                                                          --42
                                ,@sdomdanaci+@intmdanacio+@reajustes                            --Val(datos(33)) + Val(datos(35)) + Val(datos(36))

   )

FETCH NEXT FROM CURSOR_INTER
INTO      @moneda         ,@cuenta          ,@tipprod      ,@tipproc      ,@codprod     ,@clscontble   ,@acteconomica
         ,@desproducto    ,@mesproceso      ,@diaproceso   ,@anoproceso   ,@nrooper     ,@rutcliente   ,@digcliente
         ,@mesapertura    ,@diaapertura     ,@anoapertura  ,@tasabase     ,@plazotasa   ,@tasaoperac   ,@mtoorigen   
         ,@mtocapital     ,@sdomdaorig      ,@sdomdanaci   ,@intmdaorigen ,@intmdanacio ,@reajustes   ,@sdodeuda    
         ,@sdovcto        ,@fechainicio     ,@producto     ,@fechavcto    ,@tasa
      
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER

SELECT @Max = COUNT(*) FROM #TABLA_INTERFAZ

SELECT @Max,* FROM #TABLA_INTERFAZ

END
GO
