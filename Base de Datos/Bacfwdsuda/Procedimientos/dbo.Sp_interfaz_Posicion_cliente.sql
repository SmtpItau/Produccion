USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_interfaz_Posicion_cliente]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_interfaz_Posicion_cliente]
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
    )


CREATE TABLE #TABLA_INTERFAZ
   (   
       EXPBNK      CHAR(02)            --1
      ,EXPBRN      CHAR(03)            --2
      ,EXPCCY      CHAR(03)            --3
      ,EXPGLN      NUMERIC(16)         --4
      ,EXPATY      CHAR(04)            --5
      ,EXPACD      CHAR(02)            --6
      ,EXPRO       CHAR(04)            --7
      ,EXPCLS      NUMERIC(3)          --8
      ,EXPIND      CHAR(4)             --9
      ,EXPUC1      CHAR(04)            --10
      ,EXPDSC      CHAR(35)            --11
      ,EXPRDM      NUMERIC(02)         --12
      ,EXPRDD      NUMERIC(02)         --13
      ,EXPRDY      NUMERIC(04)         --14
      ,EXPPRC      CHAR(04)            --15
      ,EXPNRF      CHAR(16)            --16
      ,EXPNID      CHAR(9)            --17
      ,DIG         CHAR(1)            
      ,EXPSDU      CHAR(01)            --18
      ,EXPFAM      NUMERIC(02)         --19
      ,EXPFAD      NUMERIC(02)         --20   
      ,EXPFAY      NUMERIC(04)         --21
      ,EXPFVM      NUMERIC(02)         --22
      ,EXPFVD      NUMERIC(02)         --23
      ,EXPFVY      NUMERIC(04)         --24
      ,EXPTBS      NUMERIC(9,6)        --25
      ,EXPPTB      NUMERIC(04)         --26
      ,EXPTOP      NUMERIC(9,6)        --27
      ,EXPCPO      NUMERIC(18,2)       --28
      ,EXPCPON     NUMERIC(18,2)       --29
      ,EXPBAL      NUMERIC(18,2)       --30
      ,EXPBALN     NUMERIC(18,2)       --31
      ,EXPIAL      NUMERIC(18,2)       --32
      ,EXPIALN     NUMERIC(18,2)       --33
      ,EXPRAL      NUMERIC(18,2)       --34
      ,EXPSDE      NUMERIC(18,2)       --35
      ,EXPSAV      NUMERIC(18,2)       --36
      ,EXPAC1      CHAR(2)             --37
      ,EXPFL1      CHAR(1)             --38
      ,EXPSTS      CHAR(1)             --39  
   )      

 SELECT @fecpro  = acfecproc ,
        @acfecprox = acfecprox
 FROM MDAC


set @vDolar_obs = isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @fecpro),0)

----
 INSERT #CARTERA 
 SELECT     
        CASE
        WHEN cpseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
           ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
        END      
        ,CASE WHEN CtaContable ='' THEN '0' ELSE CtaContable END
        ,'MDIR'            --SP_HELP VIEW_PLAN_DE_CUENTA
        ,'70'          
        ,isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = 'CP'),'')
        ,isnull((select tipo_cuenta from VIEW_PLAN_DE_CUENTA where cuenta = CtaContable),'')
        ,isnull(CONVERT(CHAR(4),(select clactivida from VIEW_CLIENTE where Clrut = cprutcli AND Clcodigo= cpcodcli)),'')
        ,isnull((select descripcion from  Bacparamsuda..PRODUCTO where codigo_producto= 'CP'  and  id_sistema = 'BTR'),'')
        ,CONVERT(NUMERIC(2),MONTH(@fecpro))
        ,CONVERT(NUMERIC(2),DAY(@fecpro))
        ,CONVERT(NUMERIC(4),YEAR(@fecpro))
        ,CAST(cpnumdocu AS VARCHAR(5)) +  cast(cpcorrela AS VARCHAR(3))+ CAST( cpnumdocu AS VARCHAR(5))
        ,CONVERT(NUMERIC(9),cprutcli)
        ,ISNULL((select Cldv FROM VIEW_CLIENTE where Clrut = cprutcli AND Clcodigo = cpcodcli),'')
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

 FROM MDCP  ,CARTERA_CUENTA , mdac
 WHERE cpnominal   > 0 AND cprutcart > 0
 AND   t_operacion = "CP"
 AND   NumDocu     = cpnumdocu
 AND   Correla     = cpcorrela
 AND   NumOper     = cpnumdocu 
 AND   variable    = "valor_compra"

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
        ,isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = 'CP'),'')
        ,isnull((select tipo_cuenta from VIEW_PLAN_DE_CUENTA where cuenta = CtaContable),'') 
        ,isnull(CONVERT(CHAR(5),(select clactivida from VIEW_CLIENTE where Clrut = virutcli AND Clcodigo= vicodcli)),'')
        ,isnull((select descripcion from  Bacparamsuda..PRODUCTO where codigo_producto= 'CP'  and  id_sistema = 'BTR'),'')
        ,CONVERT(NUMERIC(2),MONTH(@fecpro))
        ,CONVERT(NUMERIC(2),DAY(@fecpro))
        ,CONVERT(NUMERIC(4),YEAR(@fecpro))
        ,CAST(vinumdocu AS VARCHAR(5)) +  cast(vicorrela AS VARCHAR(3))+ CAST( vinumdocu AS VARCHAR(5))
        ,CONVERT(NUMERIC(9),virutcli )
        ,ISNULL((select Cldv FROM VIEW_CLIENTE where  Clrut = virutcli AND  Clcodigo = vicodcli),0)                 --6
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
         ,vivalvenp
         ,vifecinip
         ,'CP'
         ,vifecvenp

   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND variable  = "valor_compra"


-----SP_HELP  CARTERA_CUENTA
 INSERT #CARTERA 
 SELECT 
        CASE
        WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
           ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
        END      
        ,CASE WHEN CtaContable ='' THEN '0' ELSE CtaContable END
        ,'MDIR'
        ,'71'
        ,isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = "BTR" and codigo_bac = vitipoper),'')
        ,isnull((select tipo_cuenta from VIEW_PLAN_DE_CUENTA where cuenta = CtaContable),'') 
        ,isnull(CONVERT(CHAR(5),(select clactivida from VIEW_CLIENTE where Clrut = virutcli AND Clcodigo= vicodcli)),'')
        ,isnull((select descripcion from  Bacparamsuda..PRODUCTO where codigo_producto= 'CP'  and  id_sistema = 'BTR'),'')
        ,CONVERT(NUMERIC(2),MONTH(@fecpro))
        ,CONVERT(NUMERIC(2),DAY(@fecpro))
        ,CONVERT(NUMERIC(4),YEAR(@fecpro))
        ,CAST(vinumdocu AS VARCHAR(5)) +  cast(vicorrela AS VARCHAR(3))+ CAST( vinumdocu AS VARCHAR(5))
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

   FROM MDVI,CARTERA_CUENTA , mdac
   WHERE  vitipoper = t_operacion 
    AND NumDocu   = vinumdocu
    AND Correla   = vicorrela
    AND NumOper   = vinumoper 
    AND variable  = "valor_compra"


---
 INSERT #CARTERA 
 SELECT  
        CASE
        WHEN ciseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cinumdocu AND nscorrela=cicorrela),0)
           ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=cimascara),0)
        END      
        ,CASE WHEN CtaContable ='' THEN '0' ELSE CtaContable END
        ,'MDIR'
        ,'70'
        ,CASE
            WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = "BTR" and codigo_bac = ciinstser),'')
            ELSE isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = "BTR" and codigo_bac = 'CI'),'')
         END  
        ,isnull((select tipo_cuenta from VIEW_PLAN_DE_CUENTA where cuenta = CtaContable),'') 
        ,isnull(CONVERT(CHAR(5),(select clactivida from VIEW_CLIENTE where Clrut = cirutcli AND Clcodigo= cicodcli)),'')
        ,isnull((select descripcion from  Bacparamsuda..PRODUCTO where codigo_producto= 'CP'  and  id_sistema = 'BTR'),'')
        ,CONVERT(NUMERIC(2),MONTH(@fecpro))
        ,CONVERT(NUMERIC(2),DAY(@fecpro))
        ,CONVERT(NUMERIC(4),YEAR(@fecpro))
        ,CAST(cinumdocu AS VARCHAR(5)) +  cast(cicorrela AS VARCHAR(3))+ CAST( cinumdocu AS VARCHAR(5))
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
         ,civalcomp
         ,civalcomu
         ,civalcomp
         ,0
         ,ciinteresc
         ,cireajustc
         ,civptirc
         ,civalvenp
         ,cifecinip
         ,CASE
             WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
             ELSE 'CI'
          END  
         ,cifecvenp

 FROM MDCI,CARTERA_CUENTA , mdac
 WHERE t_operacion  = (case when ciinstser = 'ICOL' or ciinstser = 'ICAP' Then 'CP' else 'CI' end)
 AND cicodigo       = CodigoInst
 AND t_movimiento   = 'MOV'
 AND NumDocu        = cinumdocu
 AND Correla        = cicorrela
 AND variable       = 'valor_compra'

DECLARE CURSOR_INTER CURSOR FOR 
SELECT     moneda      ,cuenta          ,tipprod      ,tipproc       ,codprod      ,clscontble   ,acteconomica
         ,desproducto  ,mesproceso      ,diaproceso   ,anoproceso    ,nrooper      ,rutcliente   ,digcliente
         ,mesapertura  ,diaapertura     ,anoapertura  ,tasabase      ,plazotasa    ,tasaoperac   ,mtoorigen
         ,mtocapital   ,sdomdaorig      ,sdomdanaci   ,intmdaorigen  ,intmdanacio  ,reajustes    ,sdodeuda
         ,sdovcto      ,fechainicio     ,producto     ,fechavcto
FROM #CARTERA

OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO      @moneda         ,@cuenta          ,@tipprod      ,@tipproc      ,@codprod     ,@clscontble   ,@acteconomica
         ,@desproducto    ,@mesproceso      ,@diaproceso   ,@anoproceso   ,@nrooper     ,@rutcliente   ,@digcliente
         ,@mesapertura    ,@diaapertura     ,@anoapertura  ,@tasabase     ,@plazotasa   ,@tasaoperac   ,@mtoorigen   
         ,@mtocapital     ,@sdomdaorig      ,@sdomdanaci   ,@intmdaorigen ,@intmdanacio ,@reajustes   ,@sdodeuda    
         ,@sdovcto        ,@fechainicio     ,@producto     ,@fechavcto
WHILE @@FETCH_STATUS  = 0
BEGIN 
----

IF  @producto = 'CP'
   select @valor = 0
   select @valor = ISNULL((select vmvalor from view_valor_moneda where vmcodigo=@moneda and vmfecha = @fechainicio),0.0)
   set @intmdaorigen = @intmdanacio
   if @valor <> 0
      set @intmdaorigen = @intmdanacio/@valor

if @producto = 'VI'
   select @valor = 0
   select @valor = ISNULL((select vmvalor from view_valor_moneda where vmcodigo=@moneda and vmfecha = @fechainicio),0.0)
   set @intmdaorigen = @intmdanacio
   set @mtoorigen    = @mtocapital

   if @valor <> 0
   begin
       set @intmdaorigen = @intmdanacio/@valor
       set @mtoorigen    = @mtocapital/@valor
   end

if @producto = 'CI' or  @producto = 'IB'
   select @valor = 0
   select @valor = ISNULL((select vmvalor from view_valor_moneda where vmcodigo = @moneda and vmfecha = @fechainicio),0.0)
   set @intmdaorigen = @intmdanacio
   if @valor <> 0
      set @intmdaorigen = @intmdanacio/@valor


if @clscontble = 'ACT' begin
   select @tipo_cuenta = 01
end 
else begin
   if @clscontble = 'PAS'
      select  @tipo_cuenta = 02
else begin
    select  @tipo_cuenta = 0
end
end


INSERT #TABLA_INTERFAZ VALUES (  '01'                                      --2-codigo banco
                                ,'001'                                     --3-codigo sucursal
                                ,CONVERT(CHAR(3),@moneda)                  --4-codigo moneda
                                ,CONVERT(NUMERIC(16),@cuenta)              --5-cta contable
                                ,@tipprod                                  --6-tipo producto
                                ,@tipproc                                  --7-tipo proceso
                                ,@codprod                                  --8-codigo producto
                                ,@tipo_cuenta                              --9
                                ,@acteconomica                             --10-act economica
                                ,'M'                                       --11
                                ,@desproducto                              --12-descripcion producto
                                ,@mesproceso                               --13-mes proceso
                                ,@diaproceso                               --14-dia proceso
                                ,@anoproceso                               --15-ano proceso
                                ,CONVERT(CHAR(4),@moneda)                  --16-cod moneda
                                ,@nrooper                                  --17-nro operacion
                                ,@rutcliente                               --18-rut cliente
                                ,@digcliente                               --19-digito
                                ,'1'                                      --20
                                ,@mesapertura                              --21-mes apertura
                                ,@diaapertura                              --22-dias apertura
                                ,@anoapertura                              --23-ano apertura
                                ,CONVERT(NUMERIC(2),MONTH(@fechavcto))     --24-mes vencimiento
                                ,CONVERT(NUMERIC(2),DAY(@fechavcto))       --25-dia vencimiento
                                ,CONVERT(NUMERIC(4),YEAR(@fechavcto))      --26-ano vencimiento
                                ,@tasabase                                 --27-tasa base
                                ,@plazotasa                                --28-plazo tasa
                                ,@tasaoperac                               --29-tasa operacion
                                ,@mtoorigen                                --30-mto origen
                                ,@mtocapital                               --31-mto capital
                                ,@sdomdaorig                               --32-sdo mdaorigen 
                                ,@sdomdanaci                               --33-sdomdaorigen
                                ,@intmdaorigen                             --34-intmdaorigen
                                ,@intmdanacio                              --35-intmdanacio
                                ,@reajustes                                --36-rejustes
                                ,@sdodeuda                                 --37-sdodeuda
                                ,@sdovcto                                  --38-sdovcto
                                ,'13'                                      --39
                                ,''                                        --40
                                ,'A'                                       --41
   )

FETCH NEXT FROM CURSOR_INTER
INTO      @moneda         ,@cuenta          ,@tipprod      ,@tipproc      ,@codprod     ,@clscontble   ,@acteconomica
         ,@desproducto    ,@mesproceso      ,@diaproceso   ,@anoproceso   ,@nrooper     ,@rutcliente   ,@digcliente
         ,@mesapertura    ,@diaapertura     ,@anoapertura  ,@tasabase     ,@plazotasa   ,@tasaoperac   ,@mtoorigen   
         ,@mtocapital     ,@sdomdaorig      ,@sdomdanaci   ,@intmdaorigen ,@intmdanacio ,@reajustes   ,@sdodeuda    
         ,@sdovcto        ,@fechainicio     ,@producto     ,@fechavcto
      
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER

SELECT @Max = COUNT(*) FROM #TABLA_INTERFAZ
SELECT @Max,* FROM #TABLA_INTERFAZ

END
-- select * from mdcp
-- select * from mdci
--select CtaContable from cartera_cuenta where NumDocu = @numdocu and Correla = @Corre and Variable  = 'valor_compra' )
-- select * from cartera_cuenta where NumDocu = 38598
-- select * from view_tabla_desarrollo
-- select * from view_noserie
-- select * from view_serie
-- SELECT * FROM CARTERA_CUENTA
-- SELECT * FROM MDCP where cprutcli = 96535720
-- select * from view_cliente where clrut = 96535720

--select clactivida,* from view_cliente where clrut = 97029000

--update view_cliente set clactivida = 81 where clrut = 200000178
GO
