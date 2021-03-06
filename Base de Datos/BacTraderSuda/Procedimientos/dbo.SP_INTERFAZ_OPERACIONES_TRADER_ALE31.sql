USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_OPERACIONES_TRADER_ALE31]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_OPERACIONES_TRADER_ALE31]
AS
BEGIN

SET NOCOUNT ON

DECLARE @tipopro              CHAR(4)   
       ,@tipoper              CHAR(4)               
       ,@rut                  NUMERIC(9)
       ,@dig                  CHAR(1)                  
       ,@n_operacion          CHAR(20)
       ,@fecha_inic           DATETIME
       ,@fecha_vcto           DATETIME
       ,@cod_inter_mda        NUMERIC(5)
       ,@s_mto_cap_ori        CHAR(1)
       ,@mto_cap_origen       NUMERIC(19,4)
       ,@s_mto_cap_loc        CHAR(1)
       ,@mto_cap_local        NUMERIC(19,4)
       ,@s_reaj_mda_loc       CHAR(1)
       ,@mto_reaj_loc         NUMERIC(19,4)
       ,@valor_en_pesos       NUMERIC(19,4)
       ,@nomin_en_pesos       NUMERIC(24,0)
       ,@mto_opc_compra       float
       ,@indicador            CHAR(1)
       ,@crediticio           CHAR(1)
       ,@n_oper_orig          CHAR(5)
       ,@f_ult_deveng         DATETIME
       ,@s_int_mda_or         CHAR(1)
       ,@int_mda_or           NUMERIC(19,4)
       ,@s_int_mda_loc        CHAR(1)
       ,@int_mda_loc          NUMERIC(19,4)
       ,@cod_tasa_base        NUMERIC(5)
       ,@tasa_interes         NUMERIC(9,4)
       ,@seriado              CHAR(1)
       ,@cuotas_rmtes         NUMERIC(5)
       ,@total_cuotas         NUMERIC(5)
       ,@f_ultimo_pago        DATETIME
       ,@mto_ini_mda_o        NUMERIC(19,4)
       ,@col_mda_efe          NUMERIC(19,4)
       ,@tipo_cartera         CHAR(1)
       ,@periocidad           CHAR(4)
       ,@i_tipo_isnmto        CHAR(5)
       ,@i_del_e_isnmto       CHAR(15)
       ,@correla              CHAR(5)
       ,@codigo               NUMERIC(5)
       ,@p_vcto_cupon         NUMERIC(5)
       ,@f_emision            DATETIME
       ,@mascara              CHAR(12)
       ,@cal_intereses        NUMERIC(1)
       ,@rutemisor            NUMERIC(9)
       ,@mto_opc_compra_x     NUMERIC(19,2)
       ,@vDolar_obs           NUMERIC(19,4)
       ,@registros            INTEGER
       ,@FECHA                DATETIME
       ,@tdcupon              NUMERIC(04)
       ,@Svalor               CHAR(1)
       ,@valor                NUMERIC(19,4)
       ,@dias                 NUMERIC(19)
       ,@nIntasb              NUMERIC(5)
       ,@tip_tasa             CHAR(3)
       ,@inst_variable        CHAR(1)
       ,@acfecprox            DATETIME
       ,@dias_dife            NUMERIC(4)                
       ,@campo_26             DATETIME                  
       ,@destino              NUMERIC(3)
       ,@t_tasa		      CHAR(1)
       ,@NUMOPERORIG          NUMERIC(8)
       ,@valorUF              NUMERIC(19,4)
       ,@tasamercado          NUMERIC(16,8)  
       ,@FECHAvaloriza        DATETIME     
      , @FECHAdolar           DATETIME     
      
DECLARE @PrimerDiaMes	CHAR(12),
	@UltimoDiaMes	CHAR(12),
	@valordolarant  numeric(12,2)


  SELECT @FECHA     = acfecproc ,
         @acfecprox = acfecprox,
         @FECHAvaloriza =acfecproc 
  FROM MDAC

 IF  MONTH (@FECHAvaloriza )<> MONTH( @acfecprox ) BEGIN

	SELECT @PrimerDiaMes   = SUBSTRING( ( convert(char(8), @acfecprox , 112))  ,1,6)  + '01'
	SELECT @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)
        SELECT @FECHAvaloriza = CONVERT(DATETIME,  @UltimoDiaMes ,112)

	SELECT @FECHAdolar = @FECHA 
	SELECT @valordolarant = vmvalor from view_valor_moneda where vmfecha = @FECHAdolar and vmcodigo = 994
 END 
 ELSE BEGIN
--select @FECHA
	EXEC    sp_ultimohabil_mes_p15 @FECHA , @FECHAdolar 
        SELECT	@valordolarant	= ISNULL( dolarObsFinMes , 0 ) FROM bacbonosextsuda..text_arc_ctl_dri			
 END 

 --SELECT @valordolarant = vmvalor from view_valor_moneda where vmfecha = @FECHAdolar and vmcodigo = 994

select @valordolarant, @FECHAdolar

CREATE TABLE #CARTERA
   (
       tipopro              CHAR(4)              --1
      ,tipoper              CHAR(4)            --2 
      ,rut                  NUMERIC(9)		 --3
      ,dig                  CHAR(1)              --4    
      ,n_operacion          CHAR(20)             --5
      ,fecha_inic           DATETIME             --6
      ,fecha_vcto           DATETIME             --7
      ,cod_inter_mda        NUMERIC(5)           --8
      ,s_mto_cap_ori        CHAR(1)              --9
      ,mto_cap_origen       NUMERIC(19,4)        --10
      ,s_mto_cap_loc        CHAR(1)              --11
      ,mto_cap_local        NUMERIC(19,4)        --12
      ,s_reaj_mda_loc       CHAR(1)              --13
      ,mto_reaj_loc         NUMERIC(19,4)        --14
      ,valor_en_pesos       NUMERIC(19,4)        --15
      ,nomin_en_pesos       NUMERIC(19,0)        --16
      ,mto_opc_compra       float                --17   
      ,indicador            CHAR(1)              --18
      ,crediticio           CHAR(1)              --19
      ,n_oper_orig          CHAR(5)              --20
      ,f_ult_deveng         DATETIME     --21
      ,s_int_mda_or         CHAR(1)              --22
      ,int_mda_or NUMERIC(19,4)        --23
      ,s_int_mda_loc        CHAR(1)              --24
      ,int_mda_loc          NUMERIC(19,4)        --25
      ,cod_tasa_base        NUMERIC(5)           --26
      ,tasa_interes         NUMERIC(9,4)         --27
      ,seriado              CHAR(1)              --28
      ,cuotas_rmtes         NUMERIC(5)           --29
      ,total_cuotas         NUMERIC(5)           --30
      ,f_ultimo_pago        DATETIME             --31
      ,mto_ini_mda_o        NUMERIC(19,4)        --32
      ,col_mda_efe          NUMERIC(19,4)        --33
      ,tipo_cartera         CHAR(1)              --34
      ,periocidad           CHAR(4)              --35
      ,i_tipo_isnmto        CHAR(5)              --36
      ,i_del_e_isnmto       CHAR(15)             --37
      ,correla              CHAR(5)              --38
      ,codigo               NUMERIC(5)           --39
      ,p_vcto_cupon         NUMERIC(5)           --40
      ,f_emision            DATETIME             --41
      ,mascara              CHAR(12)             --42
      ,cal_intereses        NUMERIC(1)           --43
      ,rutemisor            NUMERIC(9)           --44
      ,dias_dife            NUMERIC(6)           --45
      ,campo_26             DATETIME             --46                     
      ,destino              NUMERIC(3)           --47
      ,NUMOPERORIG           NUMERIC(8)            
   )

CREATE TABLE #CARTERA_VI
   (
       tipopro              CHAR(4)              --1
      ,tipoper              CHAR(4)              --2 
      ,rut                  NUMERIC(9)		 --3
      ,dig                  CHAR(1)              --4    
      ,n_operacion          CHAR(20)             --5
      ,fecha_inic           DATETIME             --6
      ,fecha_vcto           DATETIME             --7
      ,cod_inter_mda        NUMERIC(5)           --8
      ,s_mto_cap_ori        CHAR(1)              --9
      ,mto_cap_origen       NUMERIC(19,4)        --10
      ,s_mto_cap_loc        CHAR(1)              --11
      ,mto_cap_local        NUMERIC(19,4)        --12
      ,s_reaj_mda_loc       CHAR(1)              --13
      ,mto_reaj_loc         NUMERIC(19,4)        --14
      ,valor_en_pesos       NUMERIC(19,4)        --15
      ,nomin_en_pesos       NUMERIC(19,0)        --16
      ,mto_opc_compra       float                --17   
      ,indicador            CHAR(1)              --18
      ,crediticio           CHAR(1)              --19
      ,n_oper_orig    CHAR(5)              --20
      ,f_ult_deveng         DATETIME             --21
      ,s_int_mda_or         CHAR(1)              --22
      ,int_mda_or   NUMERIC(19,4)        --23
      ,s_int_mda_loc        CHAR(1)              --24
      ,int_mda_loc  NUMERIC(19,4)        --25
      ,cod_tasa_base        NUMERIC(5)           --26
      ,tasa_interes        NUMERIC(9,4)         --27
      ,seriado              CHAR(1)              --28
      ,cuotas_rmtes         NUMERIC(5)           --29
      ,total_cuotas         NUMERIC(5)           --30
      ,f_ultimo_pago        DATETIME             --31
      ,mto_ini_mda_o  NUMERIC(19,4)        --32
      ,col_mda_efe          NUMERIC(19,4)        --33
      ,tipo_cartera         CHAR(1)              --34
      ,periocidad           CHAR(4)              --35
      ,i_tipo_isnmto        CHAR(5)              --36
      ,i_del_e_isnmto       CHAR(15)             --37
      ,correla              CHAR(5)              --38
      ,codigo               NUMERIC(5)           --39
      ,p_vcto_cupon         NUMERIC(5)           --40
      ,f_emision            DATETIME             --41
      ,mascara              CHAR(12)             --42
      ,cal_intereses        NUMERIC(1)           --43
      ,rutemisor            NUMERIC(9)           --44
      ,dias_dife            NUMERIC(6)   --45
      ,campo_26         DATETIME --46                     
      ,destino              NUMERIC(3)           --47
      ,NUMOPERORIG          NUMERIC(8)            
   )

CREATE TABLE #CARTERACI
   (
       tipopro              CHAR(4)              --1
      ,tipoper              CHAR(4)              --2 
      ,rut                  NUMERIC(9)		 --3
      ,dig                  CHAR(1)              --4    
      ,n_operacion          CHAR(20)             --5
      ,fecha_inic           DATETIME             --6
      ,fecha_vcto           DATETIME             --7
      ,cod_inter_mda        NUMERIC(5)           --8
      ,s_mto_cap_ori        CHAR(1)              --9
      ,mto_cap_origen       NUMERIC(19,4)        --10
      ,s_mto_cap_loc        CHAR(1)              --11
      ,mto_cap_local        NUMERIC(19,4)        --12
      ,s_reaj_mda_loc       CHAR(1)              --13
      ,mto_reaj_loc         NUMERIC(19,4)        --14
      ,valor_en_pesos       NUMERIC(19,4)        --15
      ,nomin_en_pesos       NUMERIC(19,0)        --16
      ,mto_opc_compra       float                --17   
      ,indicador            CHAR(1)              --18
      ,crediticio           CHAR(1)              --19
      ,n_oper_orig          CHAR(5)              --20
      ,f_ult_deveng         DATETIME     --21
      ,s_int_mda_or         CHAR(1)              --22
      ,int_mda_or NUMERIC(19,4)        --23
      ,s_int_mda_loc        CHAR(1)              --24
      ,int_mda_loc          NUMERIC(19,4)        --25
      ,cod_tasa_base        NUMERIC(5)           --26
      ,tasa_interes         NUMERIC(9,4)         --27
      ,seriado              CHAR(1)              --28
      ,cuotas_rmtes         NUMERIC(5)           --29
      ,total_cuotas         NUMERIC(5)           --30
      ,f_ultimo_pago        DATETIME             --31
      ,mto_ini_mda_o        NUMERIC(19,4)        --32
      ,col_mda_efe          NUMERIC(19,4)        --33
      ,tipo_cartera         CHAR(1)              --34
      ,periocidad           CHAR(4)              --35
      ,i_tipo_isnmto        CHAR(5)              --36
      ,i_del_e_isnmto       CHAR(15)             --37
      ,correla              CHAR(5)              --38
      ,codigo               NUMERIC(5)           --39
      ,p_vcto_cupon         NUMERIC(5)           --40
      ,f_emision            DATETIME             --41
      ,mascara              CHAR(12)             --42
      ,cal_intereses        NUMERIC(1)           --43
      ,rutemisor            NUMERIC(9)           --44
      ,dias_dife   NUMERIC(6)           --45
      ,campo_26             DATETIME             --46   
      ,destino              NUMERIC(3)           --47
      ,NUMOPERORIG           NUMERIC(8)            
   )


   -------------------------------------------------------------------------------------------

   CREATE TABLE #TABLA_INTERFAZ
      (
         fecha_contable   CHAR(8)          --1
        ,status           CHAR(1)          --2
        ,cod_producto     CHAR(4)          --3
        ,t_operac         CHAR(4)          --4
        ,rut_int          CHAR(9)          --5        
        ,dig_int          CHAR(1)          --6
        ,costo            CHAR(1)          --7
        ,operacion        CHAR(20)         --8
        ,finic            CHAR(8)          --9
        ,fvcto            CHAR(8)          --10
        ,cintermda        CHAR(3)          --11
     ,signo_mto1       CHAR(1)          --12
        ,mto1             NUMERIC(18,2)    --13
        ,signo_mto2       CHAR(1)          --14
        ,mto2             NUMERIC(18,2)    --15
        ,signo_mto3       CHAR(1)          --16
        ,mto3             NUMERIC(18,2)    --17
        ,tasa_f_v         CHAR(1)          --18                                                                                                       --20
        ,spread           NUMERIC(1)       --19                                                                                                        --21
        ,valor            NUMERIC(18,2)    --20
        ,nomin            NUMERIC(18,2)    --21
        ,t_cartera        CHAR(1)          --22
        ,mto_o_compra    float             --23
        ,total            INTEGER         --24
        ,indicador_inter  CHAR(2)         --25
        ,crediticio_inter VARCHAR(1)      --26
        ,oper_orig        VARCHAR(20)     --27
        ,fec_ult_deveng   CHAR(8)         --28
        ,signo_mto4       CHAR(1)         --29
        ,mto4             NUMERIC(18,2)   --30
        ,signo5           CHAR(1)         --31
        ,monto5           NUMERIC(18,2)   --32
        ,tasa_base        CHAR(4)         --33
        ,interes          NUMERIC(18,2)   --34
        ,cuotas_rmtes     NUMERIC(4)      --35
        ,total_cuotas     NUMERIC(4)      --36
        ,fec_ultimo_pago  CHAR(8)         --37
        ,monto_inicio     NUMERIC(18,2)   --38
        ,colocacion       NUMERIC(18,2)   --39
        ,cartera          CHAR(1)         --40
        ,perido           NUMERIC(4)      --41
        ,tipo_isnmto      CHAR(5)         --42
        ,emisor_isnmto    CHAR(15)        --43
        ,f_emision        CHAR(8)         --44
        ,cal_intereses    CHAR(1)         --45
        ,tipo_tasa        CHAR(3)         --46
        ,destino          NUMERIC(3)      --47
        ,tasamercado      NUMERIC(16,8) 
       )

   SET @vDolar_obs = isnull((select vmvalor from view_valor_moneda where vmcodigo = 994 and vmfecha = @FECHA),0)
   SET @valorUF    = isnull((select vmvalor from view_valor_moneda where vmcodigo = 998 and vmfecha = @FECHA),0)
   ---------------------------------------------------------------------------------------------

 INSERT #CARTERA 
 SELECT 'CP'
        ,'MDIR'
--        ,cprutcli 
        ,CASE
               WHEN cpseriado='N' THEN isnull((SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
               ELSE isnull((SELECT top 1 serutemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
             END  
 
      ,ISNULL((select Cldv FROM VIEW_CLIENTE where cprutcli = Clrut AND cpcodcli = Clcodigo),0)                 --6
        ,CAST(cpnumdocu AS VARCHAR(5)) +  cast(cpcorrela AS VARCHAR(3))+ CAST( cpnumdocu AS VARCHAR(5))   --8
        ,cpfeccomp                                --9
    	,cpfecven              --10
        ,CASE WHEN cpmascara = 'BR' or cpmascara = 'BD'  or cpmascara = 'BE'  or cpmascara = 'BF' or cpmascara = 'CBR' THEN 995 
        ELSE
          CASE
            WHEN cpseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
            ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
          END  
         end
        ,case when cpvalcomu < 0 then '-' else '+' end                                       --12
      ,cpvalcomu                                                                                                  --13
        ,case when cpvalcomp < 0 then '-' else '+' end                                                                --14
        ,cpvalcomp                                                                                                  --15
        ,case when cpreajustc < 0 then '-' else '+' end                  --16   
        ,cpreajustc                                                                                                 --17
        ,cpvptirc                                                                                                  --22
        ,0 -- --23
        ,0
        ,'A'                
        ,0 
        ,CAST(cpnumdocu AS VARCHAR(5))                                                                              --29
        ,@FECHA
        ,''
        ,0 
        ,case when cpinteresc < 0 then '-' else '+' end                                                             --33     
        ,cpinteresc                                                                                                 --34                                                         
        ,CASE 
            WHEN cpseriado='N' THEN isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
            ELSE isnull((SELECT top 1  sebasemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
        END
        ,cptircomp           
        ,cpseriado                                                                                                 --37
        ,0--                                   --38
        ,ISNULL(case when cpmascara = 'PRC' or cpmascara = 'DPL' then 1 else (select DISTINCT secupones from view_serie where cpmascara = semascara) end,0) --39
        ,cpfecucup                                                                                                 --31
        ,cpnominal                                                                                                 --32
        ,cpvalcomp                                                                                                 --42
        ,case when MDCP.codigo_carterasuper = 'P' then '1' else '2' end                                                                             --43
        ,RIGHT('0000'+cast(datediff(day,cpfeccomp,cpfecven) AS VARCHAR(4)),4)                                                           --44
        ,ISNULL((select inserie from view_instrumento where incodigo = cpcodigo),'')                               --45
        ,'' -- --46
        ,cast(cpcorrela AS VARCHAR(3))
        ,cpcodigo
        ,isnull((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara = cpmascara),0) 
        ,cpfecemi
        ,cpmascara
        ,0 --
        ,CASE
           WHEN cpseriado='N' THEN isnull((SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
           ELSE isnull((SELECT top 1  serutemi FROM VIEW_SERIE WHERE semascara=cpmascara),0)
         END  
        ,datediff(day,@fecha,cpfecven)
        ,cpfecpcup  
        ,CASE  WHEN cprutcli = 97029000 THEN 211 
                    WHEN cprutcli = 97030000 THEN 212
         ELSE
                    221 
         END
         ,cpnumdocu
       FROM MDCP
      WHERE (cpnominal   > 0 AND cprutcart > 0)
-- and cpnumdocu = 7777777
   ------------------------------------
   INSERT #CARTERA 
   SELECT CASE
           WHEN ciinstser='ICOL' OR ciinstser='ICAP' THEN 'IB'
           ELSE 'CI'
          END  
         ,'MDIR'
       ,cirutcli 
         ,ISNULL((select Cldv FROM VIEW_CLIENTE where cirutcli = Clrut AND cicodcli = Clcodigo),0)                 --6
         ,CAST(cinumdocu AS VARCHAR(5)) +  cast(cicorrela AS VARCHAR(3))+ CAST( cinumdocu AS VARCHAR(5))   --8
         ,cifeccomp  --9
         ,cifecvenp        --10
         ,cimonpact--CASE
         ,case when civalcomu < 0 then '-' else '+' end                                                              --12
         ,civalcomu                                                                                                  --13
         ,case when civalcomp < 0 then '-' else '+' end                                                                --14
         ,civalcomp                                                                     --15
         ,case when cireajustc < 0 then '-' else '+' end                                                             --16   
         ,cireajustc                                                                                                 --17
         ,civptirc                                                                                                  --22
         ,case when cimonemi = 999 then cinominal 
               when cimonemi = 13 then cinominal 
          else
               (cinominal*(select vmvalor from view_valor_moneda where vmcodigo = cimonemi and vmfecha = cifeccomp)) end --23
         ,0
         ,CASE  WHEN ciinstser='ICAP' THEN 'P' ELSE 'A' END -- ACTIVO / PASIVO                                      'A'                                       --27
         ,case when cimascara <> 'PRC' then '1' else '' END
         ,CAST(cinumdocu AS VARCHAR(5))                                                                              --29
         ,@FECHA                                                                                  --30
         ,'' --isnull(case when (ciinteresc/(select vmvalor from view_valor_moneda where vmcodigo = cimonemi and vmfecha = cifeccomp )) < 0 then '-' else '+' end,0)                 --31
         ,0  --isnull((ciinteresc/(select vmvalor from view_valor_moneda where vmcodigo = cimonemi and vmfecha = cifeccomp)),0)                                                     --32
         ,case when ciinteresc < 0 then '-' else '+' end                                                   --33     
         ,ciinteresc           --34                                                         
         ,cibaspact   --35
         ,citaspact
         ,ciseriado          --37
         ,0--                                   --38
         ,ISNULL(case when cimascara = 'PRC' or cimascara = 'DPL' then 1 else (select secupones from view_serie where cimascara = semascara) end,0) --39
         ,cifecven                                                                                         --40
         ,cinominal                                      --41
         ,civalinip
         ,case when MDCI.codigo_carterasuper = 'P' then '1' else '2' end                                                                             --43
         ,RIGHT('0000'+cast(datediff(day,cifeccomp,cifecven) AS VARCHAR(4)),4)                                                           --44
         ,ISNULL((select inserie from view_instrumento where incodigo = cicodigo),'')                               --45
         ,ISNULL((select emgeneric from view_emisor where emrut = cirutemi),'')           --46
         ,cast(cicorrela AS VARCHAR(3))
         ,cicodigo
        ,isnull((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara = cimascara),0) 
         ,cifecemi
         ,cimascara
         ,case when cimonemi = 998 then 1 
                                 when cimonemi = 13  then 3
                                 when cimonemi = 999 then 4 
                             else
                                 0
                  end
         ,0
         ,datediff(day,@fecha,cifecvenp)
         ,cifecvenp  
         ,CASE  WHEN cirutcli = 97029000 THEN 211 
                    WHEN cirutcli = 97030000 THEN 212
          ELSE
    221 
   END
         ,CInumdocu
       FROM MDCI
       WHERE (cinominal > 0 AND cirutcart > 0)
       AND ( ciinstser='ICOL' OR ciinstser='ICAP' ) 	


   INSERT #CARTERACI 
   SELECT 'CI'
          ,'MDIR'
         ,cirutcli 
         ,ISNULL((select Cldv FROM VIEW_CLIENTE where cirutcli = Clrut AND cicodcli = Clcodigo),0)                 --6
--         ,CAST(cinumdocu AS VARCHAR(5)) +  cast(cicorrela AS VARCHAR(3))+ CAST( cinumdocu AS VARCHAR(5))   --8
--         ,CAST(cinumdocu AS VARCHAR(5)) +  cast(1  AS VARCHAR(3))+ CAST( cinumdocu AS VARCHAR(5))   --8
         ,CAST(cinumdocu AS VARCHAR(5)) +  cast(0  AS VARCHAR(3))+   CAST( cinumdocu AS VARCHAR(5))   --8
         ,cifeccomp  --9
         ,cifecvenp        --10
         ,cimonpact--CASE
         ,case when civalcomu < 0 then '-' else '+' end                                                              --12
         ,civalcomu                                                                                                  --13
         ,case when civalcomp < 0 then '-' else '+' end                                                                --14
         ,civalcomp                                                                                                  --15
         ,case when cireajustc < 0 then '-' else '+' end                                                             --16   
         ,cireajustc                                                                                                 --17
         ,civptirc                                                                                                  --22
         ,case when cimonemi = 999 then cinominal 
               when cimonemi = 13 then cinominal 
          else
               (cinominal*(select vmvalor from view_valor_moneda where vmcodigo = cimonemi and vmfecha = cifeccomp)) end --23
         ,0
         ,'A'                                       --27
         ,case when cimascara <> 'PRC' then '1' else '' END
         ,CAST(cinumdocu AS VARCHAR(5))                                                                              --29
         ,@FECHA                                                                                  --30
         ,'' --isnull(case when (ciinteresc/(select vmvalor from view_valor_moneda where vmcodigo = cimonemi and vmfecha = cifeccomp )) < 0 then '-' else '+' end,0)                 --31
         ,0  --isnull((ciinteresc/(select vmvalor from view_valor_moneda where vmcodigo = cimonemi and vmfecha = cifeccomp)),0)                                                     --32
         ,case when ciinteresc < 0 then '-' else '+' end                                                   --33     
         ,ciinteresc           --34                                                         
         ,cibaspact   --35
         ,citaspact
         ,ciseriado          --37
         ,0--                                   --38
         ,1--ISNULL(case when cimascara = 'PRC' or cimascara = 'DPL' then 1 else (select secupones from view_serie where cimascara = semascara) end,0) --39
         ,cifecinip --cifecven                                                                                         --40
         ,cinominal                                      --41
         ,civalinip
         ,case when MDCI.codigo_carterasuper = 'P' then '1' else '2' end                                                                             --43
         ,RIGHT('0000'+cast(datediff(day,cifeccomp,cifecvenp) AS VARCHAR(4)),4)                                                           --44
         ,ISNULL((select inserie from view_instrumento where incodigo = cicodigo),'')                               --45
         ,ISNULL((select emgeneric from view_emisor where emrut = cirutemi),'')           --46
         ,cast(1 AS VARCHAR(3)) -- cast(cicorrela AS VARCHAR(3))
         ,cicodigo
        ,isnull((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara = cimascara),0) 
         , cifeccomp --cifecemi
         ,LEFT(cimascara,3)
         ,case when cimonemi = 998 then 1 
         when cimonemi = 13  then 3
                                 when cimonemi = 999 then 4 
                             else
                                 0
                              end
         ,0
         ,datediff(day,@fecha,cifecvenp)
         ,cifecvenp  
         ,CASE  WHEN cirutcli = 97029000 THEN 211 
                    WHEN cirutcli = 97030000 THEN 212
          ELSE
    221 
   END
         ,CInumdocu
       FROM MDCI
       WHERE (cinominal > 0 AND cirutcart > 0)
       AND ( ciinstser<>'ICOL' AND ciinstser<>'ICAP' ) 	


      INSERT INTO #CARTERA 
      SELECT 
         tipopro,
         tipoper,
         rut,
         dig,
         n_operacion,
         fecha_inic,
         fecha_vcto,
         cod_inter_mda,
         s_mto_cap_ori,
         SUM(mto_cap_origen),
         s_mto_cap_loc,
         SUM(mto_cap_local),
         s_reaj_mda_loc,
         SUM(mto_reaj_loc),
         SUM(valor_en_pesos),
         SUM(nomin_en_pesos),
         SUM(mto_opc_compra),
         indicador,
         crediticio,
         n_oper_orig,
         f_ult_deveng,
         s_int_mda_or,
         SUM(int_mda_or),
         s_int_mda_loc,
         SUM(int_mda_loc),
         cod_tasa_base,
         tasa_interes,
         seriado,
         cuotas_rmtes,
         total_cuotas,
         f_ultimo_pago,
         SUM(mto_ini_mda_o),
         SUM(col_mda_efe),
         tipo_cartera,
         periocidad,
         i_tipo_isnmto,
         i_del_e_isnmto,
         correla,
         codigo,
         p_vcto_cupon,
         f_emision,
         ''  ,--  mascara,
         cal_intereses,
         rutemisor,
         dias_dife,
         campo_26,
         destino,
          NUMOPERORIG
      FROM #CARTERACI 
 	GROUP BY          tipopro,
         tipoper,         rut,         dig,         n_operacion,         fecha_inic,         fecha_vcto,
         cod_inter_mda,         s_mto_cap_ori,          s_mto_cap_loc,          s_reaj_mda_loc,         indicador,
         crediticio,         n_oper_orig,         f_ult_deveng,         s_int_mda_or,          s_int_mda_loc,
          cod_tasa_base,         tasa_interes,         seriado,         cuotas_rmtes,         total_cuotas,
         f_ultimo_pago,         tipo_cartera,         periocidad,         i_tipo_isnmto,         i_del_e_isnmto,
         correla,         codigo,         p_vcto_cupon,         f_emision,         mascara,         cal_intereses,
         rutemisor,         dias_dife,         campo_26,         destino,          NUMOPERORIG
--and          CInumdocu = 999999


   ----------------------------- select * from mdvi where vinumoper = 43071

/* EN ESTAS OPERACIONES SE TRABAJA CON OTRO TEMPORAL PARA AGRUPAR LOS DATOS PUES SE DEBE INFORMAR UN REGISTRO 
   POR NUMERO DE OPERACION (+ CORRELATIVO) **/
   INSERT #CARTERA_VI  -- insersion del Pacto
   SELECT 'VI' --vitipoper 
         ,'MDIR'
         ,virutcli 
         ,ISNULL((select Cldv FROM VIEW_CLIENTE where virutcli = Clrut AND vicodcli = Clcodigo),0)                    --6
         ,CAST(vinumoper AS VARCHAR(5)) +  cast(vicorrela AS VARCHAR(3))+ CAST( vinumoper AS VARCHAR(5))               --8
         ,vifecinip --ojo vifeccomp
         ,vifecvenp --ojo vifecven                                                                                            --10
         ,CASE
            WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
            ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
         END  
         ,case when vivalcomu < 0 then '-' else '+' end                                      --12
         ,vivalcomu                                                                                                  --13
         ,case when vivalcomp < 0 then '-' else '+' end                                                                --14
         ,vivalcomp             --15
         ,case when vireajustv < 0 then '-' else '+' end                                                             --16   
         ,vireajustv                                                                                                 --17
         ,vivptirc                                                                                                  --22
         ,case when vimonemi = 999 then vinominal else (vinominal*(select vmvalor from view_valor_moneda where vmcodigo = vimonemi and vmfecha = vifecvenp)) end --23
         ,round(( (vivalvenp * isnull(( select vmvalor from view_valor_moneda where vmcodigo = vimonemi and vmfecha = vifecinip) , 0 ) )/@vDolar_obs  ),2)--0
         ,'P'                                       --27
         ,0
/* OJO, SOLO EN ESTE TIPO DE OPERACIONES SE MANDA VINUMOPER PARA PODER ENVIAR INFORMACION AGRUPADA Y ASI NO SE VEA DUPLICIDAD DE INFORMACION (POR ESO SE
  CALCULA MONTOS EN SELECT Y NO DENTRO DEL CURSOR (MONTO OPERACION ORIGINAL, COLUMNA 17) */
         ,CAST(vinumoper AS VARCHAR(5)) -- CAST(vinumdocu AS VARCHAR(5))           
         ,@FECHA                                                                                  --30
         ,0 
         ,0 
         ,case when viinteresv < 0 then '-' else '+' end                                                             --33     
         ,viinteresv    --34                                                         
         ,vibaspact              --35 ojo buscar el tabal de serie o noserie  
         ,vitaspact              -- ojo     vitircomp
         ,viseriado                               --37
         ,1  --                29
         ,1 
         ,vifecvenp                               --40
         ,vinominal                                                                                                 --41
         ,0                                                                                                 --42
         ,case when MDVI.codigo_carterasuper = 'P' then '1' else '2' end    --43
         ,RIGHT('0000'+cast(datediff(day,vifecinip,vifecvenp) AS VARCHAR(4)),4)  -- vifeccomp - vifecven                                                           --44
         ,ISNULL((select inserie from view_instrumento where incodigo = vicodigo),'')
                         --45
         ,ISNULL((select emgeneric from view_emisor where emrut = virutemi),'')           --46
         ,cast(vicorrela AS VARCHAR(3))
         ,vicodigo
         ,isnull((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara = vimascara),0) 
         ,vifecemi
         ,vimascara
         ,case when vimonemi = 998 then 1 
                                 when vimonemi = 13  then 3
                                 when vimonemi = 999 then 4 
                             else
                                 0
                              end
         ,virutemi
        ,datediff(day,@fecha,vifecvenp) -- ojo  - @fecha,vifecven
        ,vifecvenp                      -- ojo   vifecven
        ,CASE  WHEN virutcli = 97029000 THEN 211  -- ojo
               WHEN virutcli = 97030000 THEN 212
         ELSE
                     221 
         END
         ,vinumoper
       FROM MDVI
       WHERE (vinominal > 0 AND virutcart > 0)
--and vinumoper = 999999

/* SE INSERTAN DATOS AGRUPADOS A #CARTERA PARA TRABAJAR DATOS EN CURSOR */
      INSERT INTO #CARTERA 
      SELECT 
         tipopro,
         tipoper,
         rut,
         dig,
         n_operacion,
         fecha_inic,
         fecha_vcto,
         cod_inter_mda,
         s_mto_cap_ori,
         SUM(mto_cap_origen),
         s_mto_cap_loc,
         SUM(mto_cap_local),
         s_reaj_mda_loc,
         SUM(mto_reaj_loc),
         SUM(valor_en_pesos),
         SUM(nomin_en_pesos),
         SUM(mto_opc_compra),
         indicador,
         crediticio,
         n_oper_orig,
      f_ult_deveng,
         s_int_mda_or,
         SUM(int_mda_or),
      s_int_mda_loc,
         SUM(int_mda_loc),
         cod_tasa_base,
         tasa_interes,
         seriado,
         cuotas_rmtes,
         total_cuotas,
         f_ultimo_pago,
         SUM(mto_ini_mda_o),
         col_mda_efe,
         tipo_cartera,
         periocidad,
         i_tipo_isnmto,
         i_del_e_isnmto,
         correla,
         codigo,
         p_vcto_cupon,
         f_emision,
         ''  ,--  mascara,
         cal_intereses,
         rutemisor,
         dias_dife,
         campo_26,
         destino,
          NUMOPERORIG
      FROM #CARTERA_VI 
      GROUP BY tipopro,tipoper, rut,dig,
         n_operacion, fecha_inic,fecha_vcto,
         cod_inter_mda, s_mto_cap_ori,s_mto_cap_loc,
         s_reaj_mda_loc,indicador,crediticio,
         n_oper_orig,f_ult_deveng,s_int_mda_or,
         s_int_mda_loc,cod_tasa_base,tasa_interes,
         seriado,cuotas_rmtes,total_cuotas,
         f_ultimo_pago, col_mda_efe,tipo_cartera,
         periocidad,i_tipo_isnmto,i_del_e_isnmto,
         correla,codigo,p_vcto_cupon,f_emision,
         -- mascara,
         cal_intereses,rutemisor,dias_dife,
         campo_26,destino ,          NUMOPERORIG

--  dbo.Sp_Interfaz_operaciones_trader_ALE


   INSERT #CARTERA  -- insersion de la Parte Intermdiada
   SELECT vitipoper 
         ,'MDIR'
         ,virutcli 
         ,ISNULL((select Cldv FROM VIEW_CLIENTE where virutcli = Clrut AND vicodcli = Clcodigo),0)                    --6
         ,CAST(vinumdocu AS VARCHAR(5)) +  cast(vicorrela AS VARCHAR(3))+ CAST( vinumoper AS VARCHAR(5))               --8
         ,vifeccomp
    ,vifecven                                                                 --10
         ,CASE
            WHEN viseriado='N' THEN isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
            ELSE isnull((SELECT top 1  semonemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
         END  
         ,case when vivalcomu < 0 then '-' else '+' end                                                            --12
         ,vivalcomu             --13
         ,case when vivalcomp < 0 then '-' else '+' end                                     --14
         ,vivalcomp                                                           --15
         ,case when vireajustv < 0 then '-' else '+' end                                                             --16   
         ,vireajustv                                                                                                 --17
         ,vivptirc                                                                                                  --22
         ,case when vimonemi = 999 then vinominal else (vinominal*(select vmvalor from view_valor_moneda where vmcodigo = vimonemi and vmfecha = vifecvenp)) end --23
         ,0
         ,'A'                                       --27
         ,0 
         ,CAST(vinumdocu AS VARCHAR(5))           
         ,@FECHA                                                                                  --30
         ,0 
         ,0 
         ,case when viinteresv < 0 then '-' else '+' end                                                             --33     
         ,viinteresv                                                                                                 --34                                                         
         --,vibaspact              --35 sebasemi nsbasemi ojo buscar el tabal de serie o noserie  
        ,CASE
            WHEN viseriado='N' THEN isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
            ELSE isnull((SELECT top 1  sebasemi FROM VIEW_SERIE WHERE semascara=vimascara),0)
         END
         ,vitircomp
         ,viseriado                                                                        --37
    ,0--                    --38
         ,ISNULL(case when vimascara = 'PRC' or vimascara = 'DPL' then 1 else (select secupones from view_serie where vimascara = semascara) end,0) --39
         ,vifecven                                                                                                  --40
         ,vinominal                                                                                                 --41
         ,0                                                                                                 --42
         ,case when MDVI.codigo_carterasuper = 'P' then '1' else '2' end                                                                             --43
         ,RIGHT('0000'+cast(datediff(day,vifeccomp,vifecven) AS VARCHAR(4)),4)                                                            --44
         ,ISNULL((select inserie from view_instrumento where incodigo = vicodigo),'')                               --45
         ,ISNULL((select emgeneric from view_emisor where emrut = virutemi),'')           --46
         ,cast(vicorrela AS VARCHAR(3))
         ,vicodigo
         ,isnull((SELECT DISTINCT sepervcup FROM VIEW_SERIE WHERE semascara = vimascara),0) 
         ,vifecemi
         ,vimascara
         ,case when vimonemi = 998 then 1 
               when vimonemi = 13  then 3
                                 when vimonemi = 999 then 4 
                             else
                                 0
                              end
         ,virutemi 
        ,datediff(day,@fecha,vifecven) -- ojo  - @fecha,vifecven
        ,vifecven                      -- ojo   vifecven
        ,CASE  WHEN virutemi = 97029000 THEN 211  -- ojo
                   WHEN virutemi = 97030000 THEN 212
         ELSE
                     221 
         END
        ,  vinumoper
       FROM MDVI
       WHERE (vinominal > 0 AND virutcart > 0)
--and vinumoper = 99999


select * into #VALORIZACION_MERCADO_DIARIA from VALORIZACION_MERCADO_DIARIA
where 
fecha_valorizacion =  @FECHAvaloriza 


select * into #VALORIZACION_MERCADO from VALORIZACION_MERCADO
where 
fecha_valorizacion =  @FECHAvaloriza 

DECLARE CURSOR_INTER CURSOR FOR 
SELECT tipopro              , tipoper        , rut  , dig   , n_operacion   , fecha_inic    , fecha_vcto ,
      cod_inter_mda  , s_mto_cap_ori  , mto_cap_origen   , s_mto_cap_loc , mto_cap_local , s_reaj_mda_loc,
      mto_reaj_loc          , valor_en_pesos , nomin_en_pesos   , mto_opc_compra, indicador     , crediticio    , n_oper_orig,
      f_ult_deveng          , s_int_mda_or   , int_mda_or       , s_int_mda_loc , int_mda_loc   , cod_tasa_base ,
      tasa_interes          , seriado        , cuotas_rmtes     , total_cuotas  , f_ultimo_pago , mto_ini_mda_o ,
      col_mda_efe           , tipo_cartera   , periocidad       , i_tipo_isnmto , i_del_e_isnmto, correla       ,
      codigo                , p_vcto_cupon   , f_emision        , mascara       , cal_intereses , rutemisor,
      dias_dife             , campo_26       , destino          ,NUMOPERORIG 
  FROM #CARTERA


OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO  @tipopro               , @tipoper        , @rut              , @dig           , @n_operacion   , @fecha_inic      , @fecha_vcto ,
      @cod_inter_mda         , @s_mto_cap_ori  , @mto_cap_origen   , @s_mto_cap_loc , @mto_cap_local , @s_reaj_mda_loc  ,
      @mto_reaj_loc  ,        @valor_en_pesos , @nomin_en_pesos   , @mto_opc_compra, @indicador     , @crediticio      , @n_oper_orig,
      @f_ult_deveng          , @s_int_mda_or   , @int_mda_or       , @s_int_mda_loc , @int_mda_loc   , @cod_tasa_base   ,
      @tasa_interes          , @seriado        , @cuotas_rmtes     , @total_cuotas  , @f_ultimo_pago , @mto_ini_mda_o   ,
      @col_mda_efe           , @tipo_cartera   , @periocidad       , @i_tipo_isnmto , @i_del_e_isnmto, @correla,
      @codigo                , @p_vcto_cupon   , @f_emision        , @mascara       , @cal_intereses , @rutemisor,
      @dias_dife             , @campo_26       , @destino , @NUMOPERORIG 
WHILE @@FETCH_STATUS  = 0
BEGIN 
 
IF @tipopro = 'CP'
 SELECT @DIG = Cldv FROM VIEW_CLIENTE WHERE Clrut = @rut


select @mto_opc_compra=0
select @mto_opc_compra_x = 0
select @valor = 0

-- select vmvalor from view_valor_moneda where vmcodigo=999
select @valor = ISNULL((select vmvalor from view_valor_moneda where vmcodigo=@cod_inter_mda and vmfecha =  @fecha_inic),0)


if @tipopro = 'CP' or (@tipopro = 'CI' OR @tipopro = 'IB') or  @tipopro = 'VI'
begin
   if @valor < 0 
      select @s_int_mda_or = '-'
   else
      select @s_int_mda_or = '+'
   if @valor = 0
      set @int_mda_or = @int_mda_loc/1
   else
      set @int_mda_or = @int_mda_loc/@valor
end


IF @tipopro = 'CP'
BEGIN

   IF @cod_inter_mda = 999 BEGIN -- 995 porque los br que tienen moneda de emision 999 se debe informar con 995 a pedido del bco
      SET @nomin_en_pesos = @mto_ini_mda_o
   END
   ELSE IF @cod_inter_mda = 998 BEGIN         
      SET @nomin_en_pesos = ROUND( ( @mto_ini_mda_o * @valorUF ) ,0)
   END  
   ELSE IF  ( @cod_inter_mda = 995  and ( @mascara = 'BR' or @mascara = 'BD'  or @mascara = 'BE'  or @mascara = 'BF' or @mascara = 'CBR' )) BEGIN
      SET @nomin_en_pesos = @mto_ini_mda_o  
   END
   ELSE BEGIN
select @cod_inter_mda,@fecha_inic, @n_operacion   
      SET @nomin_en_pesos = ISNULL((@mto_ini_mda_o * (select vmvalor from view_valor_moneda where vmcodigo = @cod_inter_mda and vmfecha = @fecha_inic)),0)

      SELECT @mto_cap_local 	= ROUND(@mto_cap_origen* @valordolarant  ,0) 

   END


   if @cod_inter_mda = 998 
      set @cal_intereses= 1
   else
      if @cod_inter_mda = 13
      set @cal_intereses= 3
   else 
      if @cod_inter_mda = 999 or ( @cod_inter_mda = 995  and @mascara = 'BR')
         set @cal_intereses= 4
   else 
         set @cal_intereses= 0
end

SELECT @valor_en_pesos = 0
 select @tasamercado =  0.0




IF  @tipopro <> 'VI' BEGIN  --select * from  VALORIZACION_MERCADO where fecha_valorizacion = '20030831'
--select 'b',  @mascara , @FECHAvaloriza ,@NUMOPERORIG ,@correla ,@n_oper_orig 
 
      IF EXISTS(SELECT valor_mercado FROM #VALORIZACION_MERCADO   WHERE tmmascara = @mascara and  fecha_valorizacion =  @FECHAvaloriza and rmnumoper = @NUMOPERORIG and rmcorrela = @correla AND rmnumdocu = @n_oper_orig ) BEGIN
         SELECT @valor_en_pesos =  isnull( valor_mercado  ,0.0),
                @tasamercado    =  isnull( tasa_mercado  ,0.0)
         FROM #VALORIZACION_MERCADO   
         WHERE tmmascara = @mascara and fecha_valorizacion = @FECHAvaloriza and rmnumoper = @NUMOPERORIG  and rmcorrela = @correla and     rmnumdocu = @n_oper_orig

      END  ELSE IF EXISTS(SELECT valor_mercado FROM #VALORIZACION_MERCADO_DIARIA  WHERE tmmascara = @mascara and  fecha_valorizacion =  @FECHAvaloriza and  rmnumoper = @NUMOPERORIG  and rmcorrela = @correla and    rmnumdocu = @n_oper_orig ) BEGIN
         SELECT @valor_en_pesos = isnull((  valor_mercado  ),0.0),
                @tasamercado    =  isnull( tasa_mercado  ,0.0)
         FROM #VALORIZACION_MERCADO_DIARIA  
         WHERE tmmascara = @mascara and fecha_valorizacion = @FECHAvaloriza and rmnumoper = @NUMOPERORIG  and rmcorrela = @correla and    rmnumdocu = @n_oper_orig

      END  ELSE BEGIN  -- sino tasa compra 
         SELECT @valor_en_pesos = 0
         IF  @tipopro = 'CI'  BEGIN
             select @tasamercado =  @tasa_interes
    
         END
         ELSE BEGIN
            select @tasamercado =  0.0
         END

      END 

END ELSE BEGIN
   -- si es 'VI'


    IF @NUMOPERORIG = @n_oper_orig BEGIN

      IF EXISTS(SELECT valor_mercado FROM VALORIZACION_MERCADO   WHERE fecha_valorizacion =  @FECHAvaloriza and rmnumoper = @NUMOPERORIG  ) BEGIN
         SELECT @valor_en_pesos = isnull( sum ( valor_mercado), 0.0 ) ,
                @tasamercado    = isnull( tasa_mercado , 0.0 ) 
         FROM VALORIZACION_MERCADO   
         WHERE fecha_valorizacion =  @FECHAvaloriza
          and rmnumoper = @NUMOPERORIG 
       GROUP BY tasa_mercado


      END  ELSE IF EXISTS(SELECT valor_mercado FROM VALORIZACION_MERCADO_DIARIA  WHERE fecha_valorizacion =  @FECHAvaloriza and rmnumoper = @NUMOPERORIG  ) BEGIN
         SELECT @valor_en_pesos = isnull( sum ( valor_mercado), 0.0 ) ,
                @tasamercado    = isnull( tasa_mercado , 0.0 )
   FROM VALORIZACION_MERCADO_DIARIA  
         WHERE fecha_valorizacion =  @FECHAvaloriza
          and rmnumoper = @NUMOPERORIG 
         GROUP BY tasa_mercado

      END  ELSE BEGIN  -- sino tasa compra 
         SELECT @tasamercado =  0.0
       
      END 
   END

--select 'a'
END


--emisor_isnmto   mto_o_compra nomin
IF @tipopro  = 'CP'
      set @i_del_e_isnmto = ISNULL((select emgeneric from view_emisor where emrut = @rutemisor),'')

IF @tipopro  = 'CP' BEGIN
  IF @cod_inter_mda = 900 or (@cod_inter_mda = 995 AND (@mascara <> 'BR' and @mascara <> 'BD'  and @mascara <> 'BE'  and @mascara <>'BF' or @mascara <> 'CBR'  )) or @cod_inter_mda = 13 or @cod_inter_mda = 142 begin 
       select  @mto_opc_compra_x = ISNULL((SELECT CPVPTIRC FROM MDCP WHERE cpnumdocu =@n_oper_orig and cpcorrela =  @correla),0)
       SET @mto_opc_compra =( @mto_opc_compra_x / @vDolar_obs )
  END 
  ELSE BEGIN
   SELECT  @mto_opc_compra = round((SELECT CPVALCOMP/@vDolar_obs FROM MDCP WHERE cpnumdocu =@n_oper_orig and cpcorrela =  @correla),2)
  END 

END

/* PARA EL CASO DE LAS VI ESTE MONTO SE CALCULO EN EL SELECT PARA PODER AGRUPAR LOS DATOS PUES SE DEBE INFORMAR REGISTROS UNICOS POR NUMERO DE OPERACION
IF @tipopro  = 'VI' 
   SET @mto_opc_compra= round((SELECT (vivalvenp* @valor)/@vDolar_obs  FROM MDVI WHERE VInumdocu = @n_oper_orig and VIcorrela =  @correla),2)
*/

IF @tipopro ='ICOL' or @tipoper = 'ICAP'
   SET @mto_opc_compra = round((SELECT CIVALCOMP/@vDolar_obs  FROM MDCI WHERE cInumdocu =@n_oper_orig and cIcorrela =  @correla),2)

IF @tipopro ='CI'
   SET @mto_opc_compra=round((SELECT (CIVALVENP* @valor) / @vDolar_obs FROM MDCI WHERE cInumdocu =@n_oper_orig and cIcorrela =  @correla),2)


 select @tdcupon = 0   
 IF @seriado = 'S' and ( @tipopro <> 'VI' and @tipopro <> 'CI') 
 BEGIN
   IF @codigo <> 20 BEGIN
      select @tdcupon =ISNULL((select count(*)  from view_tabla_desarrollo where tdfecven > @FECHA and tdmascara = @mascara),0)
   END ELSE BEGIN
      select @tdcupon = ISNULL((select count(*)  from view_tabla_desarrollo where  tdmascara = @mascara AND DATEADD( MONTH, tdcupon * @p_vcto_cupon, @f_emision ) > @FECHA ),0)
   END
   SET    @cuotas_rmtes =  convert(numeric(4),@tdcupon)  
 END ELSE
      SET    @cuotas_rmtes = 1


-----------------------
   set @dias =  @dias_dife
   set @nIntasb   = ( select intasest from mdin  where incodigo  =  @codigo  ) 
   set @inst_variable  = 'N'
   set @tip_tasa       = '0'
 
   IF @nIntasb > 0  BEGIN 
     IF ( @codigo > 800 and @codigo < 900 ) BEGIN 
      
     SET @inst_variable = 'S'
     SET @tip_tasa = CASE WHEN SUBSTRING(@mascara,1,3) = 'PCD' OR SUBSTRING(@mascara,1,3) ='PTF' THEN 
                              '2' 
                          WHEN  SUBSTRING(@mascara,1,8) = 'BCAPS-A1'  THEN
                              '3'
                          ELSE 
                              '9'
                 END
    END 
  END   

   IF @inst_variable= 'N'      -- fija  
     BEGIN 
 SELECT @t_tasa = 'F'
      if @dias < 30 
         set @tip_tasa =  '101' 
      if @dias >= 30 and @dias < 90   -- cpfecven
         set @tip_tasa = '102' 
      if @dias >= 90 and  @dias < 180 
         set @tip_tasa = '103'
       if @dias >= 180  and  @dias < 365 
         set @tip_tasa = '104'
      if @dias >= 365 and  @dias < 1095 
        set @tip_tasa = '105' 
 if @dias >= 1095 
         set @tip_tasa = '106'
 END 

      ELSE IF @inst_variable = 'S' BEGIN 
      SELECT @t_tasa = 'V'
      if datediff(day,@fecha, @campo_26 ) < 30         -- cpfecpcup
         set @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '1'
      if datediff(day,@fecha, @campo_26 ) >= 30 and  datediff(day,@fecha,@campo_26) < 90
         set @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '2'
      if datediff(day,@fecha,@campo_26) >= 90 and datediff(month,@fecha,@campo_26) < 6
         set @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '3'
     if datediff(month,@fecha,@fecha_vcto) >= 6  and  datediff(year,@fecha,@campo_26) < 1
         set @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '4'
      if datediff(year,@fecha,@campo_26) >= 1  and  datediff(year,@fecha,@campo_26) < 3
         set @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '5'
  if datediff(year,@fecha,@campo_26) >= 3  
         set @tip_tasa = '2'  + SUBSTRING(@tip_tasa,1,1) + '6'
       end 


 select @registros = (select count(*) from #CARTERA)

                           --           1                   2     3          4       5     6      7     8      
INSERT #TABLA_INTERFAZ VALUES (convert(char(8),@FECHA,112),'A',@tipopro , @tipoper, @rut, @dig , '0',@n_operacion,
                           --       9                                            10                     11               12             13               14 
                              convert(char(8),@fecha_inic,112), convert(char(8),@fecha_vcto,112), @cod_inter_mda, @s_mto_cap_ori, @mto_cap_origen,@s_mto_cap_loc,
                           --       15              16              17       18 19       20               21        22  23 
                              @mto_cap_local, @s_reaj_mda_loc, @mto_reaj_loc,@t_tasa,0,@valor_en_pesos, @nomin_en_pesos,'2',@mto_opc_compra,
                           --      24         25         26            27                28                              29             30         31            32
                              @registros ,@indicador,@crediticio,@n_oper_orig, convert(char(08),@f_ult_deveng,112),@s_int_mda_or,@int_mda_or,@s_int_mda_loc,@int_mda_loc,
                           --      33            34             35               36               37    				38            39
                              @cod_tasa_base, @tasa_interes, @cuotas_rmtes, @total_cuotas, convert(char(08),@f_ultimo_pago,112),@mto_ini_mda_o,@col_mda_efe,
                           --       40            41     42               43            44         			45     46   47
              @tipo_cartera, @periocidad, @i_tipo_isnmto, @i_del_e_isnmto,convert(char(08),@f_emision,112),@cal_intereses,@tip_tasa,@destino, 
      
                             @tasamercado    
                        )

FETCH NEXT FROM CURSOR_INTER
INTO  @tipopro               , @tipoper        , @rut              , @dig           , @n_operacion   , @fecha_inic    , @fecha_vcto ,
      @cod_inter_mda         , @s_mto_cap_ori  , @mto_cap_origen   , @s_mto_cap_loc , @mto_cap_local , @s_reaj_mda_loc ,
      @mto_reaj_loc          , @valor_en_pesos , @nomin_en_pesos   , @mto_opc_compra, @indicador     , @crediticio    , @n_oper_orig,
      @f_ult_deveng          , @s_int_mda_or   , @int_mda_or       , @s_int_mda_loc , @int_mda_loc   , @cod_tasa_base,
      @tasa_interes          , @seriado        , @cuotas_rmtes     , @total_cuotas  , @f_ultimo_pago , @mto_ini_mda_o,
      @col_mda_efe           , @tipo_cartera   , @periocidad       , @i_tipo_isnmto , @i_del_e_isnmto, @correla,
      @codigo                , @p_vcto_cupon   , @f_emision        , @mascara       , @cal_intereses , @rutemisor,
      @dias_dife             , @campo_26       , @destino         , @NUMOPERORIG
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER
SET NOCOUNT OFF
SELECT * FROM #TABLA_INTERFAZ order by operacion

END

GO
