USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[OP15]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	

CREATE PROC [dbo].[OP15] (@dFechaProceso DateTime=Null)
AS
BEGIN
SET NOCOUNT ON
         DECLARE @tipopro              CHAR(4)   
         ,	 @tipoper              CHAR(4)   
            
         ,	 @rut                  NUMERIC(9)		
         ,	 @dig                  CHAR(1)                  
         ,	 @n_operacion          CHAR(20)               
         ,	 @fecha_inic           DATETIME
         ,	 @fecha_vcto           DATETIME
         ,	 @cod_inter_mda        NUMERIC(5)
         ,	 @s_mto_cap_ori        CHAR(1)
         ,	 @mto_cap_origen       NUMERIC(19,4)
         ,	 @s_mto_cap_loc        CHAR(1)
         ,	 @mto_cap_local        NUMERIC(19,4)
         ,	 @s_reaj_mda_loc       CHAR(1)
         ,	 @mto_reaj_loc         NUMERIC(19,4)
         ,	 @valor_en_pesos       NUMERIC(19,4)
         ,	 @nomin_en_pesos       NUMERIC(24,0)
         ,	 @mto_opc_compra       float
         ,	 @indicador            CHAR(1)
         ,	 @crediticio           CHAR(1)
         ,	 @n_oper_orig          CHAR(20)
         ,	 @n_oper_orig2         CHAR(5)
         ,	 @f_ult_deveng         DATETIME
         ,	 @s_int_mda_or         CHAR(1)
         ,	 @int_mda_or           NUMERIC(19,4)
         ,	 @s_int_mda_loc        CHAR(1)
         ,	 @int_mda_loc          NUMERIC(19,4)
         ,	 @cod_tasa_base        NUMERIC(5)
         ,	 @tasa_interes         NUMERIC(9,4)
         ,	 @seriado              CHAR(1)
         ,	 @cuotas_rmtes         NUMERIC(5)
         ,	 @total_cuotas         NUMERIC(5)
         ,	 @f_ultimo_pago        DATETIME
         ,	 @mto_ini_mda_o        NUMERIC(19,4)
         ,	 @col_mda_efe          NUMERIC(19,4)
         ,	 @tipo_cartera         CHAR(1)
         ,	 @periocidad           CHAR(4)
         ,	 @i_tipo_isnmto        CHAR(5)
         ,	 @i_del_e_isnmto       CHAR(15)
         ,	 @correla              CHAR(5)
         ,	 @codigo               NUMERIC(5)
         ,	 @p_vcto_cupon         NUMERIC(5)
         ,	 @f_emision            DATETIME
         ,	 @mascara              CHAR(12)
         ,	 @cal_intereses        NUMERIC(1)
         ,	 @rutemisor            NUMERIC(9)
         ,	 @mto_opc_compra_x     NUMERIC(19,2)
         ,	 @vDolar_obs           NUMERIC(19,4)
         ,	 @registros            INTEGER
         ,	 @FECHA                DATETIME
         ,	 @tdcupon              NUMERIC(04)
         ,	 @Svalor               CHAR(1)
         ,	 @valor                NUMERIC(19,4)
         ,	 @dias                 NUMERIC(19)
         ,	 @nIntasb              NUMERIC(5)
         ,	 @tip_tasa             CHAR(3)
         ,	 @inst_variable        CHAR(1)
         ,	 @acfecprox            DATETIME
         ,	 @dias_dIFe            NUMERIC(6)                
		 ,	 @campo_26             DATETIME                  
         ,	 @destino              NUMERIC(3)
         ,	 @t_tasa			  CHAR(1)
         ,	 @NUMOPERORIG          NUMERIC(8)
         ,	 @valorUF              NUMERIC(19,4)
         ,	 @tasamercado		   NUMERIC(16,8)  
         ,	 @FECHAvaloriza        DATETIME     
         ,	 @FECHAdolar           DATETIME     
         ,	 @FECHA_MX  	       DATETIME
         ,	 @EstPacteado	       CHAR(1)
         ,	 @c_Riesgo			   CHAR(3)

         DECLARE @PrimerDiaMes	       CHAR(12)
		,	 @UltimoDiaMes	       CHAR(12)
         ,	 @valordolarant        NUMERIC(12,2)
         ,	 @valor_142            NUMERIC(12,2)
         ,	 @valor_72             NUMERIC(12,2)
         ,	 @valor_102            NUMERIC(12,2)
		
         SELECT	 @fecha            =acfecproc-- '20220329'--acfecproc 
         ,	 @acfecprox            =acfecprox-- '20220330'--acfecprox
         ,	 @FECHAvaloriza        =acfecproc-- '20220329'--acfecproc 
         FROM	 BACTRADERSUDA..MDAC
		Where acfecproc=@dFechaProceso

         IF MONTH(@FECHAvaloriza) <> MONTH(@acfecprox)
         BEGIN
            SELECT @PrimerDiaMes  = SUBSTRING((CONVERT(CHAR(8),@acfecprox,112)),1,6) + '01'
            SELECT @UltimoDiaMes  = CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)
            SELECT @FECHAvaloriza = CONVERT(DATETIME,@UltimoDiaMes,112)

            SELECT @FECHAdolar    = @fecha
	END ELSE
        BEGIN
            EXECUTE BACTRADERSUDA..SP_ULTIMOHABIL_MES_P15 @FECHA , @FECHAdolar 
            SELECT  @valordolarant= ISNULL(dolarObsFinMes,0) FROM BacBonosExtSuda..TEXT_ARC_CTL_DRI
            SELECT @PrimerDiaMes  = SUBSTRING((CONVERT(CHAR(8),@fecha,112)),1,6) + '01'
            SELECT @UltimoDiaMes  = CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(DAY,-1,@PrimerDiaMes)),112)
            SELECT @FECHA_MX      = CONVERT(DATETIME,@UltimoDiaMes ,112)
         END

         --> UTILIZACION DE TIPO DE CAMBIO CONTABLE <--
         SELECT vmcodigo      = vmcodigo
         ,      vmvalor       = vmvalor
         INTO   #VALOR_TC_CONTABLE
         FROM   BacParamSuda..VALOR_MONEDA
         WHERE  vmfecha       = @fecha
         AND    vmcodigo     IN(994,995)

         IF MONTH(@FECHAvaloriza) <> MONTH(@acfecprox)
         BEGIN
            DECLARE @dFechaFinMes   DATETIME
            SELECT  @dFechaFinMes   = DATEADD(DAY,DATEPART(DAY,DATEADD(MONTH,1,@fecha))*-1,DATEADD(MONTH,1,@fecha))

            IF @dFechaFinMes = @FECHAvaloriza
            BEGIN
               INSERT INTO #VALOR_TC_CONTABLE
               SELECT vmcodigo      = vmcodigo
               ,      vmvalor       = vmvalor
               FROM   BacParamSuda..VALOR_MONEDA
    WHERE  vmfecha       = @UltimoDiaMes
               AND    vmcodigo      IN(997,998)
            END ELSE
            BEGIN
               INSERT INTO #VALOR_TC_CONTABLE
               SELECT vmcodigo      = vmcodigo
               ,      vmvalor       = vmvalor
               FROM   BacParamSuda..VALOR_MONEDA
               WHERE  vmfecha       = @fecha
               AND    vmcodigo      IN(997,998)
            END
         END ELSE
         BEGIN
            INSERT INTO #VALOR_TC_CONTABLE
         
   SELECT vmcodigo      = vmcodigo
            ,      vmvalor       = vmvalor
            FROM   BacParamSuda..VALOR_MONEDA
            WHERE  vmfecha       = @fecha
            AND    vmcodigo      IN(997,998)
         END

         INSERT INTO #VALOR_TC_CONTABLE
         SELECT vmcodigo      = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
         ,      vmvalor       = Tipo_Cambio
         FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
         WHERE  Fecha         = @fecha 
         AND    Codigo_Moneda NOT IN(13,995,997,998,999)

         INSERT INTO #VALOR_TC_CONTABLE
         SELECT 999 , 1.0

         SELECT @valordolarant   = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 13 -- 994
         SELECT @valor_142       = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 142 
         SELECT @valor_72        = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 72
         SELECT @valor_102       = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 102

	 SELECT @vDolar_obs      = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 13 -- 994
	 SELECT @valorUF         = vmvalor FROM #VALOR_TC_CONTABLE WHERE vmcodigo = 998
         --> UTILIZACION DE TIPO DE CAMBIO CONTABLE <--

CREATE TABLE #CARTERA
	(	tipopro              CHAR(4)              --1

	,	tipoper              CHAR(4)              --2 
	,	rut                  NUMERIC(9)           --3
	,	dig                  CHAR(1)    	  --4    
	,	n_operacion          CHAR(20) 		  --5
	,	fecha_inic           DATETIME             --6
	,	fecha_vcto           DATETIME             --7
	,	cod_inter_mda        NUMERIC(5)           --8
	,	s_mto_cap_ori        CHAR(1)              --9
	,	mto_cap_origen       NUMERIC(19,4)        --10
	,	s_mto_cap_loc        CHAR(1)              --11
	,	mto_cap_local        NUMERIC(19,4)        --12
	,	s_reaj_mda_loc       CHAR(1)              --13
	,	mto_reaj_loc         NUMERIC(19,4)        --14
	,	valor_en_pesos       NUMERIC(19,4)        --15
	,	nomin_en_pesos       NUMERIC(19,0)        --16
	,	mto_opc_compra       FLOAT    
            --17   
	,	indicador            CHAR(1)              --18
	,	crediticio           CHAR(1)              --19
	,	n_oper_orig          VARCHAR(20)          --20
	,	f_ult_deveng         DATETIME             --21
	,	s_int_mda_or         CHAR(1)    
          --22
	,	int_mda_or           NUMERIC(19,4)        --23
	,	s_int_mda_loc        CHAR(1)              --24
	,	int_mda_loc          NUMERIC(19,4)        --25
	,	cod_tasa_base        NUMERIC(5)           --26
	,	tasa_interes         NUMERIC(9,4)    
     --27
	,	seriado              CHAR(1)              --28
	,	cuotas_rmtes         NUMERIC(5)           --29
	,	total_cuotas         NUMERIC(5)           --30
	,	f_ultimo_pago        DATETIME             --31
	,	mto_ini_mda_o        NUMERIC(19,4)        
--32
	,	col_mda_efe          NUMERIC(19,4)        --33
	,	tipo_cartera         CHAR(10)             --34
	,	periocidad           CHAR(4)              --35

	,	i_tipo_isnmto        CHAR(5)              --36

	,	i_del_e_isnmto       CHAR(15)             --37
	,	correla              CHAR(5)              --38
	,	codigo               NUMERIC(5)           --39
	,	p_vcto_cupon         NUMERIC(5)           --40
	,	f_emision            DATETIME             --41
	,	mascara              CHAR(12)             --42
	,	cal_intereses        NUMERIC(1)           --43
	,	rutemisor            NUMERIC(9)           --44
	,	dias_dIFe            NUMERIC(6)           --45
	,	campo_26             DATETIME             --46                     
	,	destino              NUMERIC(3)   
        --47
	,	NUMOPERORIG          NUMERIC(8)           --48
	,	EstPacteado	     CHAR(1)		  --49
	,	c_Riesgo			 CHAR(3)			  -->50
	)

CREATE TABLE #CARTERA_VI
	(	tipopro              CHAR(4)              --1
	,	tipoper              CHAR(4)              --2 
	,	rut                  NUMERIC(9)		  --3
	,	dig                  CHAR(1)              --4    
	,	n_operacion          CHAR(20)             --5
	,	fecha_inic           DATETIME             --6
	,	fecha_vcto           DATETIME             --7
	,	cod_inter_mda        NUMERIC(5)       
    --8
	,	s_mto_cap_ori        CHAR(1)              --9
	,	mto_cap_origen       NUMERIC(19,4)        --10
	,	s_mto_cap_loc        CHAR(1)              --11
	,	mto_cap_local        NUMERIC(19,4)        --12
	,	s_reaj_mda_loc       CHAR(1)              --13
	,	mto_reaj_loc         NUMERIC(19,4)        --14
	,	valor_en_pesos       NUMERIC(19,4)        --15
	,	nomin_en_pesos       NUMERIC(19,0)        --16
	,	mto_opc_compra       float                --17   
	,	indicador            CHAR(1)              --18

	,	crediticio           CHAR(1)              --19
	,	n_oper_orig          VARCHAR(20)          --20
	,	f_ult_deveng         DATETIME             --21
	,	s_int_mda_or         CHAR(1)              --22
	,	int_mda_or           NUMERIC(19,4)        --23
	,	s_int_mda_loc        CHAR(1)              --24
	,	int_mda_loc          NUMERIC(19,4)        --25
	,	cod_tasa_base        NUMERIC(5)           --26
	,	tasa_interes         NUMERIC(9,4)         --27
	,	seriado              CHAR(1)              --28
	,	cuotas_rmtes         NUMERIC(5)           --29
	,	total_cuotas         NUMERIC(5)           --30
	,	f_ultimo_pago        DATETIME             --31
	,	mto_ini_mda_o        NUMERIC(19,4)        --32
	,	col_mda_efe          NUMERIC(19,4)        --33
	,	tipo_cartera         CHAR(10)             --34
	,	periocidad           CHAR(4)              --35
	,	i_tipo_isnmto        CHAR(5)              --36
	,	i_del_e_isnmto       CHAR(15)             --37
	,	correla              CHAR(5)              --38
	,	codigo               NUMERIC(5)           --39
	,	p_vcto_cupon         NUMERIC(5)           --40
	,	f_emision            DATETIME             --41
	,	mascara              CHAR(12)             --42
	,	cal_intereses        NUMERIC(1)       --43
	,	rutemisor            NUMERIC(9)    --44
	,	dias_dIFe            NUMERIC(6)           --45
	,	campo_26             DATETIME             --46                     
	,	destino              NUMERIC(3)           --47
	,	NUMOPERORIG          NUMERIC(8)           --48 
	,	EstPacteado	     CHAR(1)		  --49
	,	c_Riesgo			 CHAR(3)			  -->50
	)

CREATE TABLE #CARTERACI
	(	tipopro              CHAR(4)              --1
	,	tipoper              CHAR(4)              --2 
	,	rut                  NUMERIC(9)		  --3
	,	dig                  CHAR(1)              --4    
	,	n_operacion          CHAR(20)             --5
	,	fecha_inic           DATETIME             --6
	,	fecha_vcto           DATETIME             --7
	,	cod_inter_mda        NUMERIC(5)           --8
	,	s_mto_cap_ori        CHAR(1)              --9
	,	mto_cap_origen       NUMERIC(19,4)        --10
	,	s_mto_cap_loc        CHAR(1)              --11
	,	mto_cap_local        NUMERIC(19,4)        --12
	,	s_reaj_mda_loc       CHAR(1)              --13
	,	mto_reaj_loc         NUMERIC(19,4)        --14
	,	valor_en_pesos       NUMERIC(19,4)        --15
	,	nomin_en_pesos       NUMERIC(19,0)        --16
	,	mto_opc_compra       float                --17   
	,	indicador            CHAR(1)              --18
	,	crediticio           CHAR(1)              --19
	,	n_oper_orig          VARCHAR(20)          --20
	,	f_ult_deveng         DATETIME             --21
	,	s_int_mda_or         CHAR(1)              --22
	,	int_mda_or           NUMERIC(19,4)        --23
	,	s_int_mda_loc        CHAR(1)              --24
	,	int_mda_loc          NUMERIC(19,4)        --25
	,	cod_tasa_base        NUMERIC(5)           --26
	,	tasa_interes         NUMERIC(9,4)         --27
	,	seriado              CHAR(1)              --28
	,	cuotas_rmtes         NUMERIC(5)           --29
	,	total_cuotas         NUMERIC(5)     
      --30
	,	f_ultimo_pago        DATETIME             --31
	,	mto_ini_mda_o        NUMERIC(19,4)        --32
	,	col_mda_efe          NUMERIC(19,4)        --33
	,	tipo_cartera         CHAR(10)             --34
	,	periocidad           CHAR(4)             
 --35
	,	i_tipo_isnmto        CHAR(5)              --36
	,	i_del_e_isnmto       CHAR(15)             --37
	,	correla              CHAR(5)              --38
	,	codigo               NUMERIC(5)           --39
	,	p_vcto_cupon         NUMERIC(5)           --40

	,	f_emision            DATETIME             --41
	,	mascara              CHAR(12)             --42
	,	cal_intereses        NUMERIC(1)           --43
	,	rutemisor            NUMERIC(9)           --44
	,	dias_dIFe	     NUMERIC(6)           --45
	,	campo_26             DATETIME             --46   
	,	destino              NUMERIC(3)           --47
	,	NUMOPERORIG          NUMERIC(8)           --48
	,	EstPacteado	     CHAR(1)		  --49
	,	c_Riesgo			 CHAR(3)			  -->50
	)

        ----------------------------------------------------------------
---------------------------
--00097036000K

--97036000   K

CREATE TABLE #TABLA_INTERFAZ
	(	fecha_contable   CHAR(8)          --1
 	,	status		 CHAR(1)          --2
	,	cod_producto     CHAR(4)          --3
 	,	t_operac         CHAR(4)          --4
 	,	rut_int          CHAR(11)          --5   
 	,	dig_int          CHAR(1)          --6
 	,	costo            CHAR(1)          --7
 	,	operacion        CHAR(20)         --8
 	,	finic            CHAR(8)          --9
 	,	fvcto            CHAR(8)          --10
 	,	cintermda        CHAR(3)          --11
     	,	signo_mto1       CHAR(1)          --12
 	,	mto1             NUMERIC(18,2)    --13
 	,	signo_mto2       CHAR(1)          --14
 	,	mto2             NUMERIC(18,2)    --15
 	,	signo_mto3       CHAR(1)          --16
 	,	mto3             NUMERIC(18,2)    --17
 	,	tasa_f_v         CHAR(1)          --18                                                                                                       --20
 	,	spread           NUMERIC(1)       --19                     
                                          --21
 	,	valor            NUMERIC(18,2)  --20
 	,	nomin         NUMERIC(18,2)    --21
 	,	t_cartera        CHAR(10)         --22
 	,	mto_o_compra     float            --23
 	,	total            INTEGER  
        --24
 	,	indicador_inter  CHAR(2)          --25
 	,	crediticio_inter VARCHAR(1)       --26
 	,	oper_orig        VARCHAR(20)      --27
 	,	fec_ult_deveng   CHAR(8)          --28
 	,	signo_mto4       CHAR(1)          --29
 	,	mto4             NUMERIC(18,2)    --30
 	,	signo5           CHAR(1)          --31
 	,	monto5           NUMERIC(18,2)    --32
 	,	tasa_base        CHAR(4)          --33
 	,	interes          NUMERIC(18,4)    --34
 	,	cuotas_rmtes     NUMERIC(4)       --35
 	,	total_cuotas     NUMERIC(4)       --36
 	,	fec_ultimo_pago  CHAR(8)          --37
 	,	monto_inicio     NUMERIC(18,2)    --38
 	,	colocacion       NUMERIC(18,2)    --39
 	,	cartera          CHAR(1)          --40
 	,	perido           NUMERIC(4)       --41
 	,	tipo_isnmto      CHAR(5)          --42
 	,	emisor_isnmto    CHAR(15)         --43
 	,	f_emision        CHAR(8)          --44
 	,	cal_intereses    CHAR(1)          --45
 	,	tipo_tasa        CHAR(3)          --46
 	,	destino          NUMERIC(3)       --47
 	,	tasamercado   
   NUMERIC(16,8)    --48
	,	EstPacteado	 CHAR(1)	  --49
	,	c_riesgo			char(3)				--50
	)
		
   ---------------------------------------------------------------------------------------------
	
	
DECLARE @OP15 TABLE 
(
  ctry					VARCHAR(3)					--		1	
, book_dt				CHAR(8)						--		2	
, intf_dt				CHAR(8)						--		3	
, src_id				VARCHAR(14)					--		4	
, cem					VARCHAR(03)					--		5	
, br					VARCHAR(04)					--		6	
, con_sta				VARCHAR(03)					--		7	
, Dlnq_sta				VARCHAR(1)					--		8	
, prod					VARCHAR(16)					--		9	
, open_dt				CHAR(8)						--		10	
, lst_accr_dt			CHAR(8)						--		11	
, Ident_cli				VARCHAR(12)					--		12	
, cc					VARCHAR(10)					--		13	
, con_no				VARCHAR(20)					--		14	
, strt_dt				CHAR(8)						--		15	
, end_dt				CHAR(8)						--		16	
, next_rset_rt_dt		CHAR(8)						--		17	
, int_pymt_arrs_ind		VARCHAR(1)					--		18	
, ccy					VARCHAR(4)					--		19	
, ocy_nom_amt_sign		VARCHAR(1)					--		20	
, ocy_nom_amt			NUMERIC(19,4)				--		21	
, lcy_nom_amt_sign		VARCHAR(1)					--		22	
, lcy_nom_amt			NUMERIC(19,2)			    --		23	
, fcy_lc_amt			NUMERIC(19,4) 				--		24	
, Lcy_reaj_amt_sing		VARCHAR(1)					--		25	
, Lcy_reaj_amt			NUMERIC(19,2)  				--		26	
, Ocy_int_amt_sing		VARCHAR(1)					--		27	
, Ocy_int_amt			NUMERIC(19,4)				--		28	
, Lcy_int_amt_sing		VARCHAR(1)					--		29	
, Lcy_int_amt			NUMERIC(19,2)				--		30	
, fix_flting_ind		VARCHAR(2)					--		31	
, int_rt_cod			VARCHAR(4)					--		32	
, int_rt				NUMERIC(16,8)				--		33	
, pnlt_rt				NUMERIC(16,8)				--		34	
, rt_meth				VARCHAR(1)					--		35	
, pool_rt				NUMERIC(16,8)				--		36	
, pool_rt_cod			VARCHAR(5)					--		37	
, pnlt_rt_cod			VARCHAR(4)					--		38	
, int_rt_sprd			NUMERIC(16,8)				--		39	
, pool_rt_sprd			NUMERIC(16,8)				--		40	
, pnlt_rt_sprd			NUMERIC(16,8)				--		41	
, aset_liab_ind			VARCHAR(1)					--		42	
, sbif_bal_no_rep_sign	VARCHAR(1)					--		43	
, sbif_bal_no_rep			NUMERIC(19,2)			--		44	
, sbif_tipo_tasa			NUMERIC(3,0)			--		45	
, sbif_prod_trans			NUMERIC(2,0)			--		46	
, sbif_tipo_oper_trans		NUMERIC(1,0)			--		47	
, lcy_fee_amt_sign			VARCHAR(1)				--		48	
, lcy_fee_amt				NUMERIC(19,2)			--		49	
, orig_strt_dt				CHAR(8)					--		50	
, nacc_from_dt				CHAR(8)					--		51	
, pdue_from_dt				CHAR(8)					--		52	
, wrof_from_dt				CHAR(8)					--		53	
, orig_con_no				VARCHAR(20)				--		54	
, no_of_remn_coup			NUMERIC(4,0)			--		55	
, no_of_pdo_coup			NUMERIC(4,0)			--		56	
, no_of_tot_coup			NUMERIC(4,0)			--		57	
, sbif_dest_coloc			NUMERIC(3,0)			--		58	
, stop_accr_dt				CHAR(8)					--		59	
, lst_int_pymt_dt			CHAR(8)					--		60	
, ren_ind					VARCHAR(1)				--		61	
, lst_rset_dt				CHAR(8)					--		62	
, next_rt_ch_dt				CHAR(8)					--		63	
, lst_rt_ch_dt				CHAR(8)					--		64	
, ocy_orig_nom_amt			NUMERIC(19,4)			--		65	
, lcy_avl_bal				NUMERIC(19,2)			--		66	
, lcy_pdo1_amt				NUMERIC(19,2)			--		67	
, lcy_pdo2_amt				NUMERIC(19,2)			--		68	
, Lcy_pdo3_amt				NUMERIC(19,2)			--		69	
, lcy_oper_amt				NUMERIC(19,2)			--		70	
, loc						NUMERIC(19,2)			--		71	
, lcy_mnpy					NUMERIC(19,2)			--		72	
, lgl_actn_ind				VARCHAR(1)				--		73	
, Lcy_mv					NUMERIC(19,2)			--		74	
, Lcy_par_val				NUMERIC(19,2)			--		75	
, Port_typ					NUMERIC(1,0)			--		76	
, No_rng					NUMERIC(3,0)			--		77	
, Pdc_coup					NUMERIC (4,0)			--		78	
, Pgo_amt					NUMERIC(19,2)			--		79	
, con_no_typ				VARCHAR(1)				--		80	
, ope_typ					VARCHAR(1)				--		81	
, mod_entr_bs				VARCHAR(2)				--		82	
, opc_compra				NUMERIC(12,2)			--		83	
, ident_instr				VARCHAR(5)				--		84	
, ident_emi_instr			VARCHAR(15)				--		85	
, serie_instr				VARCHAR(4)				--		86	
, subserie_instr			VARCHAR(4)				--		87	
, cat_risk_instr			VARCHAR(8)				--		88	
, limit_rate				NUMERIC(16,8)			--		89	
, pdc_after_fix_per			NUMERIC (4,0)			--		90	
, lcy_pdo4_amt				NUMERIC(19)				--		91	
, lcy_pdo5_amt				NUMERIC(19)				--		92	
, lcy_pdo6_amt				NUMERIC(19)				--		93	
, sbif_no_rep_ind			VARCHAR(1)				--		94	
, Lcy_otr_cont_amt			NUMERIC(19)				--		95	
, lcy_pdo7_amt				NUMERIC(19)				--		96	
, lcy_pdo8_amt				NUMERIC(19)				--		97	
, lcy_pdo9_amt				NUMERIC(19)				--		98	
, assets_origin				NUMERIC(1,0)			--		99	
, first_expiry_dt			CHAR(8)					--		100	
, tip_otorg					CHAR (1)				--		101	
, price_viv					NUMERIC(19)				--		102	
, tip_op_reneg				CHAR (1)				--		103	
, mon_pie_pag_reneg			NUMERIC(19)				--		104	
, seg_rem_cred_hip			CHAR (1)				--		105	
, pdue_from_oldest    		NUMERIC(8)				--		106	
, mon_prev_rng				NUMERIC(19,2)			--		107	
, exig_pago					Varchar (1)				--		108	
, bidding_dt				CHAR(8)					--		109	
, loan_disbursement_dt		CHAR(8)					--		110	
, Accounting_dt				CHAR(8)					--		111	
, last_payment_dt			CHAR(8)					--		112	
, last_amount_paid			NUMERIC(19,2)			--		113	
, credit_line_approved_dt	CHAR(8)					--		114	
, Amount_instalment			NUMERIC(19,2)			--		115	
, Amount_revolving			NUMERIC(19,2)			--		116	
, Ind_credit_line_duration	char(1)					--		117	
, nat_con_no				char(4)					--		118	
, dest_finan				Varchar (1)				--		119
, no_post_coup				NUMERIC(3,0)			--		120
, giro						Varchar (2)				--		121
)


Declare @OP15_SALIDA Table ( REG_SALIDA  Varchar(1240))  

	INSERT INTO #CARTERA 
/*1*/	SELECT	'CP'												--1
/*2*/ 	, 'MD01'--	'MD01'												--2
/*3*/ 	,	CASE WHEN cpseriado = 'N' THEN ISNULL((SELECT       nsrutemi FROM BacParamSuda..NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
		     ELSE                      ISNULL((SELECT top 1 serutemi FROM BacParamSuda..SERIE   WHERE semascara=cpmascara),0) 
                END	--3
/*4*/ 	,	ISNULL((SELECT Cldv FROM BacParamSuda..CLIENTE WHERE cprutcli = Clrut AND cpcodcli = Clcodigo),0)--04

--			Error en largo de Folios
		,	CAST(cpnumdocu AS VARCHAR(8)) +  cast(cpcorrela AS VARCHAR(4))+ CAST( cpnumdocu AS VARCHAR(8))	 -- 05
--		,	CAST(cpnumdocu AS VARCHAR(5)) +  cast(cpcorrela AS VARCHAR(3))+ CAST( cpnumdocu AS VARCHAR(5))	 -- 05
--			Error en largo de Folios

/*6*/ 	,	cpfeccomp											 -- 06
/*7*/   ,	cpfecven											 -- 07
/*8*/ 	,	CASE WHEN cpmascara = 'BR' or cpmascara = 'BD'  or cpmascara = 'BE'  or cpmascara = 'BF' or cpmascara = 'CBR' THEN 995 
		     ELSE CASE	WHEN cpseriado='N' THEN ISNULL((SELECT       nsmonemi FROM BacParamSuda..NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
						ELSE                    ISNULL((SELECT top 1 semonemi FROM BacParamSuda..SERIE   WHERE semascara=cpmascara),0) 
					END  
			END                                                                                             -- 08
/*9*/	,	CASE WHEN cpvalcomu < 0 THEN '-' ELSE '+' END							-- 09
/*10*/ 	,	cpvalcomu											-- 10
/*11*/	,	CASE WHEN cpvalcomp < 0 THEN '-' ELSE '+' END                                                   -- 11
/*12*/	,	cpvalcomp											-- 12
/*13*/	,	CASE WHEN cpreajustc < 0 THEN '-' ELSE '+' END							-- 13
/*14*/	,	cpreajustc                                                          
                            -- 17
/*15*/	,	cpvptirc                                                                                        -- 22
/*16*/	,	0 												-- 23
/*17*/	,	cpvptirc
/*18*/	,	'A'                
/*19*/	,	0 
/*20*/	,	' '          
                                                                                   --29
/*21*/	,	@FECHA
/*22*/	,	''
/*23*/	,	0 
/*24*/	,	CASE WHEN cpinteresc < 0 THEN '-' ELSE '+' END                                                             --33     
/*25*/	,	cpinteresc                                                                                                 --34      
/*26*/	,	CASE	WHEN cpseriado='N' THEN ISNULL((SELECT       nsbasemi FROM BacParamSuda..NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
					ELSE                    ISNULL((SELECT top 1 sebasemi FROM BacParamSuda..SERIE   WHERE semascara=cpmascara),0) 
				END
/*27*/	,	cptircomp           
/*28*/	,	cpseriado --37
/*29*/	,	0--                                   --38
/*30*/	,	ISNULL(CASE WHEN cpmascara = 'PRC' or cpmascara = 'DPL' THEN 1 ELSE (SELECT DISTINCT secupones FROM BacParamSuda..SERIE WHERE cpmascara = semascara) END,0) --39
/*31*/	,	cpfecucup                        
                                                                         --31
/*32*/	,	CASE	WHEN cpseriado='N' THEN cpnominal
			ELSE             ROUND((cpnominal * (cppvpcomp / 100.0)),2) END
/*33*/	,	cpvalcomp                                                                                                 --42
/*34*/	,	ISNULL((SELECT ccn_codigo_nuevo FROM BacParamSuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = MDCP.codigo_carterasuper),4)
/*35*/	,	CASE WHEN datedIFf(day,cpfeccomp,cpfecven)>9999 THEN '0000' ELSE RIGHT('0000'+cast(datedIFf(day,cpfeccomp,cpfecven) AS VARCHAR(4)),4) END                                                           --44
/*36*/	,	ISNULL((SELECT SUBSTRING(inserie,1,5) FROM BacParamSuda..INSTRUMENTO WHERE incodigo = cpcodigo),'')                               --45
/*37*/	,	'' -- --46
/*38*/	,	cast(cpcorrela AS VARCHAR(3))
/*39*/	,	cpcodigo
/*40*/	,	ISNULL((SELECT DISTINCT sepervcup FROM BacParamSuda..SERIE WHERE semascara = cpmascara),0) 
/*41*/	,	cpfecemi
/*42*/	,	cpmascara
/*43*/	,	0 --
/*44*/	,	CASE	WHEN cpseriado='N' THEN ISNULL((SELECT       nsrutemi FROM BacParamSuda..NOSERIE WHERE nsnumdocu=cpnumdocu AND nscorrela=cpcorrela),0)
			ELSE                    ISNULL((SELECT top 1 serutemi FROM BacParamSuda..SERIE   WHERE semascara=cpmascara),0) 
                END  
/*45*/	,	datedIFf(day,@fecha,cpfecven)
/*46*/		,	cpfecpcup  
/*47*/	,	CASE	WHEN cprutcli = 97029000 THEN 211 
					WHEN cprutcli = 97030000 THEN 212
					ELSE                          221 
				END
/*48*/	,	cpnumdocu
/*49*/	,	' '
        ,	c_Riesgo	= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( emis.emrut, emis.emcodigo, 'BTR' )
	FROM	BACTRADERSUDA..MDCP
            inner join BACTRADERSUDA..mddi on dinumdocu = cpnumdocu and dicorrela = cpcorrela
			left  join	(	select	emgeneric, emrut, emcodigo 
							from	BacParamSuda.dbo.Emisor with(nolock)
							where	emcodigo	= 1
						)	emis	On emis.emgeneric = digenemi
	WHERE	(cpnominal   > 0 AND cprutcart > 0)


        ------------------------------------ 
	INSERT INTO #CARTERA 
	SELECT CASE	WHEN ciinstser = 'ICOL' OR ciinstser='ICAP' THEN 'IB'
			ELSE 'CI' END  
  	,	'MD01'--	'MD01'
  	,	cirutcli 
  	,	ISNULL((SELECT Cldv FROM BacParamSuda..CLIENTE WHERE cirutcli = Clrut AND cicodcli = Clcodigo),0)                 --6

	--			Error en largo de Folios
	--,	CAST(cinumdocu AS VARCHAR(5)) +  cast(cicorrela AS VARCHAR(3))+ CAST( cinumdocu AS VARCHAR(5))
	,	CAST(cinumdocu AS VARCHAR(8)) +  cast(cicorrela AS VARCHAR(4))+ CAST( cinumdocu AS VARCHAR(8))
	--			Error en largo de Folios
  	
  	,	cIFecinip  --9
  	,	cIFecvenp        --10
  	,	cimonpact
  	,	CASE WHEN civalcomu < 0 THEN '-' ELSE '+' END       --12
  	,	civalcomu                                               --13
  	,	CASE WHEN civalcomp < 0 THEN '-' ELSE '+' END                   
                                             --14
  	,	CASE	WHEN cimonemi= 13  THEN ROUND(civalcomp * @valordolarant,0)
			WHEN cimonemi= 142 THEN ROUND(civalcomp * @valor_142,0)
			WHEN cimonemi= 102 THEN ROUND(civalcomp * @valor_102,0)
			WHEN cimonemi= 72  THEN ROUND(civalcomp * @valor_72,0)             
			ELSE civalcomp 
                END                     --15
  	,	CASE WHEN cireajustc < 0 THEN '-' ELSE '+' END                           --16   
  	,	cireajustc                                    
                                       --17
  	,	civptirc                                                   --22
  	,	CASE	WHEN cimonemi = 999 THEN cinominal 
			WHEN cimonemi = 13  THEN ROUND(cinominal * @valordolarant,0) 
			WHEN cimonemi = 142 THEN ROUND(cinominal * @valor_142,0)
			WHEN cimonemi = 102 THEN ROUND(cinominal * @valor_102,0)
			WHEN cimonemi = 72  THEN ROUND(cinominal * @valor_72,0)             
			ELSE ISNULL((cinominal * (SELECT vmvalor FROM #VALOR_TC_CONTABLE /*BacParamSuda..VALOR_MONEDA*/ WHERE vmcodigo = cimonemi /*and vmfecha = cIFecinip*/)),0) END --23
  	,	civptirc
  	,	CASE WHEN ciinstser='ICAP' THEN 'P' ELSE 'A' END -- ACTIVO / PASIVO         
                             'A'   --27
  	,	CASE WHEN cimascara <> 'PRC' THEN '1' ELSE '' END
  	,	' '                       --29
  	,	@FECHA                                                             --30
  	,	''                 --31
  	,	0            
   --32
  	,	CASE WHEN ciinteresc < 0 THEN '-' ELSE '+' END                                                   --33     
  	,	CASE	WHEN cimonemi = 13 THEN  ROUND(ciinteresc*@valordolarant,0) --34
			WHEN cimonemi= 142 THEN ROUND(ciinteresc*@valor_142,0)
		
	WHEN cimonemi= 102 THEN ROUND(ciinteresc*@valor_102,0)
			WHEN cimonemi= 72  THEN ROUND(ciinteresc*@valor_72,0)             
			ELSE                          ciinteresc 
                END
  	,	CASE WHEN cimonpact = 999 THEN 30 ELSE cibaspact END  --35 
 
	,	CASE WHEN cimonpact = 999 THEN CASE WHEN cibaspact = 30 THEN citaspact ELSE (citaspact / 12)END ELSE citaspact END --36
  	,	ciseriado          --37
  	,	0--                                   --38
  	,	1   --39
  	,	cIFecvenp                    --40

  	,	cinominal                                      --41
  	,	CASE	WHEN cimonemi = 13 THEN  ROUND(civalinip*@valordolarant,0) --42
			WHEN cimonemi = 142 THEN ROUND(civalinip*@valor_142,0)
			WHEN cimonemi = 102 THEN ROUND(civalinip*@valor_102,0)
			WHEN cimonemi = 72  THEN ROUND(civalinip*@valor_72,0)             
			ELSE                           civalinip 
                END
  	,	'4'                                                                       --43
  	,	RIGHT('0000'+cast(datedIFf(day,cIFecinip,cIFecven) AS VARCHAR(4)),4)                                                           --44
  	,	ISNULL((SELECT inserie FROM BacParamSuda..INSTRUMENTO WHERE incodigo = cicodigo),'')                               --45
  	,	ISNULL((SELECT emgeneric FROM BacParamSuda..EMISOR WHERE emrut = cirutemi),'')           --46
  	,	cast(cicorrela AS VARCHAR(3))
  	,	cicodigo
  	,	ISNULL((SELECT DISTINCT sepervcup FROM BacParamSuda..SERIE WHERE semascara = cimascara),0) 
  	,	cIFecinip
  	,	cimascara
  	,	CASE	WHEN cimonemi = 998 THEN 1 
			WHEN cimonemi = 13  THEN 3
			WHEN cimonemi = 999 THEN 4 
			ELSE 0 END
  	,	0
  	,	datedIFf(day,@fecha,cIFecvenp)
  	,	cIFecvenp  
  	,	CASE	WHEN cirutcli = 97029000 THEN 211 
			WHEN cirutcli = 97030000 THEN 212
			ELSE 221 END
 
 	,	CInumdocu
	,	' '
        ,	c_Riesgo	= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais ( emis.emrut, emis.emcodigo, 'BTR')
	from	BACTRADERSUDA..MDCI
			left join	(	select	emrut, emcodigo 
							from	BacParamSuda.dbo.Emisor with(nolock) 
							where	emcodigo = 1 
						)	emis On emis.emrut = cirutemi and emis.emcodigo = 1
	where  (cinominal > 0 AND cirutcart > 0	)
	and		ciinstser IN('ICOL','ICAP')


	INSERT INTO #CARTERACI 
	SELECT	'CI'
   	,	'MD01'--	'MD01'
   	,	cirutcli 
   	,	ISNULL((SELECT Cldv FROM BacParamSuda..CLIENTE WHERE cirutcli = Clrut AND cicodcli = Clcodigo),0)                 --6

	--			Error en largo de Folios
	,	CAST(cinumdocu AS VARCHAR(8)) + cast(1 AS VARCHAR(4)) + CAST(cinumdocu AS VARCHAR(8)) --8
--	,	CAST(cinumdocu AS VARCHAR(5)) + cast(1 AS VARCHAR(3)) + CAST(cinumdocu AS VARCHAR(5)) --8
	--			Error en largo de Folios
  		
  	,	cIFecinip  --9
  	,	cIFecvenp        --10
  	,	cimonpact
  	,	CASE WHEN civalcomu < 0 THEN '-' ELSE '+' END                 --12
  	,	civalinip	     --13
  	,	CASE WHEN civalcomp < 0 THEN '-' ELSE '+' END                                                               --14
  	,	civalcomp                                                                 
                                 --15
  	,	CASE WHEN cireajustc < 0 THEN '-' ELSE '+' END                                                             --16   
  	,	cireajustci                                                                    --17
  	,	civptirci                                                                                                   --22
  	,	CASE	WHEN cimonemi = 999 THEN cinominal 
			WHEN cimonemi = 13  THEN cinominal 
			ELSE ISNULL((cinominal*(SELECT vmvalor FROM #VALOR_TC_CONTABLE  /*BacParamSuda..VALOR_MONEDA*/ WHERE vmcodigo = cimonemi /*and vmfecha = cIFecinip*/)),0) END --23
  	,	civptirci
  	,	'A'                                       --27
  	,	''   
  	,	' '                                                               
                 --29
  	,	@FECHA        --30
  	,	''                 --31
	,	0                 --32
  	,	CASE WHEN ciinteresci < 0 THEN '-' ELSE '+' END                 --33     
  	,	CASE	WHEN cimonpact = 13  THEN ROUND(ciinteresci*@valordolarant,0) --34
				WHEN cimonpact = 142 THEN ROUND(ciinteresci*@valor_142,0)
				WHEN cimonpact = 102 THEN ROUND(ciinteresci*@valor_102,0)
				WHEN cimonpact = 72  THEN ROUND(ciinteresci*@valor_72,0)             
				ELSE                            ciinteresci 
			END            --34                                                         
  	,	CASE WHEN cimonpact = 999 THEN 30 ELSE cibaspact END --35
  	,	CASE WHEN cimonpact = 999 THEN CASE WHEN cibaspact = 30 THEN citaspact ELSE (citaspact / 12) END ELSE citaspact END --36
  	,	ciseriado          --37
  	,	0                                   --38
  	,	1
  	,	cIFecinip 
  	,	cinominal                                      --41
  	,	CASE	WHEN cimonpact = 13  THEN ROUND(civalinip*@valordolarant,0) --34
			WHEN cimonpact = 142 THEN ROUND(civalinip*@valor_142,0)
			WHEN cimonpact = 102 THEN ROUND(civalinip*@valor_102,0)
			WHEN cimonpact = 72  THEN ROUND(civalinip*@valor_72,0)             
			ELSE                            civalinip 
                END 
  	,	'4'
  	,	RIGHT('0000'+cast(datedIFf(day,cIFecinip,cIFecvenp) AS VARCHAR(4)),4)                                                           --44
  	,	ISNULL((SELECT inserie   FROM BacParamSuda..INSTRUMENTO WHERE incodigo = cicodigo),'')                        
       --45
  	,	ISNULL((SELECT emgeneric FROM BacParamSuda..EMISOR      WHERE emrut = cirutemi),'')           --46
  	,	cast(1 AS VARCHAR(3)) -- cast(cicorrela AS VARCHAR(3))
  	,	cicodigo
  	,	ISNULL((SELECT DISTINCT sepervcup FROM BacParamSuda..SERIE WHERE semascara = cimascara),0) 
  	,	cIFecinip --cIFecemi
  	,	LEFT(cimascara,3)
  	,	CASE	WHEN cimonpact = 998 THEN 1 
			WHEN cimonpact = 13  THEN 3
			WHEN cimonpact = 999 THEN 4 
			ELSE 0 END
  	,	0
  	,	datedIFf(day,@fecha,cIFecvenp)
  	,	cIFecvenp 
 
	,	CASE	WHEN cirutcli = 97029000 THEN 211 
			WHEN cirutcli = 97030000 THEN 212
			ELSE 221 END
	,	CInumdocu
	,	' '
        ,	c_Riesgo	= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais ( emis.emrut, emis.emcodigo, 'BTR') 
	FROM	BACTRADERSUDA..MDCI
			left join	(	select	emrut, emcodigo 
							from	BacParamSuda.dbo.Emisor with(nolock) 
							where	emcodigo = 1 
						)	emis	On emis.emrut = cirutemi and emis.emcodigo = 1
	WHERE	(cinominal	>  0	AND cirutcart	> 0	)
	AND	ciinstser	NOT IN('ICOL' , 'ICAP')



	INSERT INTO #CARTERA 
/*01*/	SELECT	tipopro
/*02*/	,	tipoper
/*03*/	,	rut
/*04*/	,	dig
/*05*/	,	n_operacion
/*06*/	,	fecha_inic
/*07*/	,	fecha_vcto
/*08*/	,	cod_inter_mda
/*09*/	,	s_mto_cap_ori
/*10*/	,	SUM(mto_cap_origen)
/*11*/	,	s_mto_cap_loc
/*12*/	,	SUM(mto_cap_local)
/*13*/	,	s_reaj_mda_loc

/*14*/	,	SUM(mto_reaj_loc)
/*15*/	,	SUM(valor_en_pesos)
/*16*/	,	SUM(nomin_en_pesos)
/*17*/	,	SUM(mto_opc_compra)
/*18*/	,	indicador
/*19*/	,	crediticio
/*20*/	,	n_oper_orig
/*21*/	,	f_ult_deveng
/*22*/	,	s_int_mda_or
/*23*/	,	SUM(int_mda_or)
/*24*/	,	s_int_mda_loc
/*25*/	,	SUM(int_mda_loc)
/*26*/	,	cod_tasa_base
/*27*/	,	tasa_interes
/*28*/	,	''     
/*29*/	,	cuotas_rmtes
/*30*/	,	total_cuotas
/*31*/	,	f_ultimo_pago
/*32*/	,	SUM(mto_ini_mda_o)
/*33*/	,	SUM(col_mda_efe)
/*34*/	,	tipo_cartera
/*35*/	,	periocidad
/*36*/	,	'CPACT'
/*37*/	,	''
/*38*/	,	correla
/*39*/	,	0
/*40*/	,	0
/*41*/	,	f_emision
/*42*/	,	''
/*43*/	,	cal_intereses
/*44*/	,	0
/*45*/	,	dias_dIFe
/*46*/	,	campo_26
/*47*/	,	destino
/*48*/	,	NUMOPERORIG
/*49*/	,	EstPacteado
/*50*/	,	c_Riesgo
	FROM	#CARTERACI 

	GROUP
	BY	tipopro
	,	tipoper
	,	rut
	,	dig
	,	n_operacion
	,	fecha_inic
	,	fecha_vcto
	,	cod_inter_mda
	,	s_mto_cap_ori
	,	s_mto_cap_loc
	,	s_reaj_mda_loc
	,	indicador
	,	crediticio
	,	n_oper_orig
	,	f_ult_deveng
	,	s_int_mda_or
	,	s_int_mda_loc
	,	cod_tasa_base
	,	tasa_interes
	,	cuotas_rmtes
	,	total_cuotas
	,	f_ultimo_pago
	,	tipo_cartera
	,	periocidad
	,	correla
	,	f_emision
	,	cal_intereses
	,	dias_dIFe
	,	campo_26
	,	destino
	,	NUMOPERORIG
/*49*/	,	EstPacteado
/*50*/	,	c_Riesgo


	----------------------------- SELECT * FROM MDVI WHERE vinumoper = 43071
	/* EN ESTAS OPERACIONES SE TRABAJA CON OTRO TEMPORAL PARA AGRUPAR LOS DATOS PUES SE DEBE INFORMAR UN REGISTRO 
	   POR NUMERO DE OPERACION (+ CORRELATIVO) **/
	INSERT INTO #CARTERA_VI  -- insersion del Pacto
	SELECT  'VI' 
	,	'MD01'--	'MD01'
  	,	virutcli 
  	,	ISNULL((SELECT Cldv FROM BacParamSuda..CLIENTE WHERE virutcli = Clrut AND vicodcli = Clcodigo),0)                    --6

	--			Error en largo de Folios
	,	CAST(vinumoper AS VARCHAR(8)) +  cast(1 AS VARCHAR(4)) + CAST( vinumoper AS VARCHAR(8))
--	,	CAST(vinumoper AS VARCHAR(5)) +  cast(1 AS VARCHAR(3)) + CAST( vinumoper AS VARCHAR(5))
	--			Error en largo de Folios

          --8
  	,	vIFecinip 
  	,	vIFecvenp 
	,	vimonpact         
  	,	' ' 
  	,	vivalinip                                                                                                  --13
  	,	' ' 
  	,	CASE	WHEN vimonpact = 13  THEN ROUND(vicapitalvi*@valordolarant,0) --34
				WHEN vimonpact = 142 THEN ROUND(vicapitalvi*@valor_142,0)
				WHEN vimonpact = 102 THEN ROUND(vicapitalvi*@valor_102,0)
				WHEN vimonpact = 72  THEN ROUND(vicapitalvi*@valor_72,0)
				ELSE                            vicapitalvi 
			END 
  	,	' '
	,	vireajustvi                  --17
  	,	vivptirc                     --22
  	,	CASE WHEN vimonemi = 999 THEN vinominal ELSE ISNULL((vinominal*(SELECT vmvalor FROM #VALOR_TC_CONTABLE /*BacParamSuda..VALOR_MONEDA*/ WHERE vmcodigo = vimonemi /*and vmfecha = vIFecvenp*/)),0) END --23
  	,	ROUND(( (vivalvenp * ISNULL(( SELECT vmvalor FROM #VALOR_TC_CONTABLE /*BacParamSuda..VALOR_MONEDA*/ WHERE vmcodigo = vimonemi /*and vmfecha = vIFecinip*/) , 0 ) )/@vDolar_obs  ),2)--0
  	,	'P'                                       --27
  	,	'' 
  	,	' '   
	,	@FECHA                                                        --30
  	,	0 
  	,	0 
  	,	' ' 
  	,	CASE	WHEN vimonpact  = 13 THEN  ROUND(viinteresvi*@valordolarant,0) 
--34
			WHEN vimonpact = 142 THEN  ROUND(viinteresvi*@valor_142,0)
			WHEN vimonpact = 102 THEN  ROUND(viinteresvi*@valor_102,0)
			WHEN vimonpact = 72  THEN  ROUND(viinteresvi*@valor_72,0)             
			ELSE viinteresvi END 
  	,	CASE WHEN vimonpact = 999 THEN 30 ELSE vibaspact END --35
  	,	CASE WHEN vimonpact = 999 THEN CASE WHEN vibaspact = 30 THEN vitaspact ELSE (vitaspact / 12)END  ELSE vitaspact END
  	,	viseriado                               --37
  	,	1 
  	,	1 
  	,	vIFecvenp                  
             --40
  	,	vinominal                                                                                                 --41
  	,	(CASE WHEN vitipoper = 'CP' THEN vivalcomp ELSE vivalinip END)
  	,	'4'
  	,	RIGHT('0000' + CAST(DATEDIFF(DAY,vIFecinip,vIFecvenp) AS VARCHAR(4)),4)  
	,	ISNULL((SELECT inserie FROM BacParamSuda..INSTRUMENTO WHERE incodigo = vicodigo),'')                         --45
  	,	ISNULL((SELECT emgeneric FROM BacParamSuda..EMISOR    WHERE emrut = virutemi),'')           --46
  	,	cast(vicorrela AS VARCHAR(3))
  	,	vicodigo
  	,	ISNULL((SELECT DISTINCT sepervcup FROM BacParamSuda..SERIE WHERE semascara = vimascara),0) 
  	,	vIFecinip  
  	,	vimascara
  	,	CASE	WHEN vimonpact = 998 THEN 1  
			WHEN vimonpact = 13  THEN 3
			WHEN vimonpact = 999 THEN 4 
			ELSE 0 END
  	,	virutemi
 	,	DATEDIFF(DAY,@fecha,vIFecvenp) 
 	,	vIFecvenp                      
 	,	CASE	WHEN virutcli = 97029000 THEN 211  
			WHEN virutcli = 97030000 THEN 212
			ELSE 221 END
  	,	vinumoper
	,	' '
        ,	c_Riesgo	= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais ( emis.emrut, emis.emcodigo, 'BTR')
	FROM	BACTRADERSUDA..MDVI
			left join	(	select	emrut, emcodigo 
							from	BacParamSuda.dbo.Emisor with(nolock) 
							where	emcodigo = 1 
						)	emis	On emis.emrut = virutemi and emis.emcodigo = 1
	WHERE	(vinominal > 0 AND virutcart > 0)


	/* SE INSERTAN DATOS AGRUPADOS A #CARTERA PARA TRABAJAR DATOS EN CURSOR */
	INSERT INTO #CARTERA 
/*01*/	SELECT	tipopro
/*02*/	,	tipoper
/*03*/	,	rut
/*04*/	,	dig
/*05*/	,	n_operacion
/*06*/	,	fecha_inic
/*07*/	,	fecha_vcto
/*08*/	,	cod_inter_mda
/*09*/	,	' '
/*10*/	,	SUM(mto_cap_origen)
/*11*/	,	' '
/*12*/	,	SUM(mto_cap_local)
/*13*/	,	' '
/*14*/	,	SUM(mto_reaj_loc)
/*15*/	,	SUM(valor_en_pesos)
/*16*/	,	SUM(nomin_en_pesos)
/*17*/	,	SUM(mto_opc_compra)
/*18*/	,indicador
/*19*/	,	crediticio
/*20*/	,	n_oper_orig
/*21*/	,	f_ult_deveng
/*22*/	,	s_int_mda_or
/*23*/	,	SUM(int_mda_or)
/*24*/	,	' ' 
/*25*/	,	SUM(int_mda_loc)
/*26*/	,	cod_tasa_base
/*27*/	,	tasa_interes
/*28*/	,	' ' 
/*29*/	,	cuotas_rmtes
/*20*/	,	total_cuotas
/*31*/	,	f_ultimo_pago
/*32*/	,	SUM(mto_ini_mda_o)
/*33*/	,	SUM(col_mda_efe)
/*34*/	,	tipo_cartera --MIN(tipo_cartera)
/*35*/	,	periocidad
/*36*/	,	'VPACT' 
/*37*/	,	'' 
/*38*/	,	0
/*39*/	,	0
/*40*/	,	0
/*41*/	,	''
/*42*/	,	''
/*43*/	,	cal_intereses
/*44*/	,	0
/*45*/	,	dias_dIFe
/*46*/	,	campo_26
/*47*/	,	destino
/*48*/	,	NUMOPERORIG
	,	' '
/*50*/	,	c_Riesgo
	FROM	#CARTERA_VI 
	GROUP 
	BY	tipopro
	,	tipoper
	,	rut
	,	dig
	,	n_operacion
	,	fecha_inic
	,	fecha_vcto
	,	cod_inter_mda
	,	indicador,crediticio
	,	n_oper_orig
	,	f_ult_deveng
	,	s_int_mda_or
	,	cod_tasa_base
	,	tasa_interes
	,	cuotas_rmtes
	,	total_cuotas
	,	f_ultimo_pago
	,	tipo_cartera
	,	periocidad
	,	cal_intereses
	,	dias_dIFe
	,	campo_26
	,	destino
	,	NUMOPERORIG
	,	EstPacteado
/*50*/	,	c_Riesgo

	UPDATE	#CARTERA  
	SET
	s_mto_cap_ori	= CASE WHEN (mto_cap_origen)	>= 0 THEN '+' ELSE '-' END
	,	s_mto_cap_loc	= CASE WHEN (mto_cap_local)	>= 0 THEN '+' ELSE '-' END
	,	s_reaj_mda_loc	= CASE WHEN (mto_reaj_loc)	>= 0 THEN '+' ELSE '-' END
	,	s_int_mda_loc	= CASE WHEN (int_mda_loc)	>= 0 THEN '+' ELSE '-' END
	WHERE	tipopro = 'VI'


	INSERT INTO #CARTERA  -- insersion de la Parte Intermdiada
	SELECT	vitipoper 
	,	'MD01'--	'MD01'
	,	virutemi  --,virutcli 
	,	ISNULL((SELECT DISTINCT Cldv FROM BacParamSuda..CLIENTE WHERE virutemi = Clrut),0)  
                  --6

		--	error en largos de folios  	
	,	CAST(vinumdocu AS VARCHAR(8)) +  cast(vicorrela AS VARCHAR(4))+ CAST( vinumoper AS VARCHAR(8))               --8
--	,	CAST(vinumdocu AS VARCHAR(5)) +  cast(vicorrela AS VARCHAR(3))+ CAST( vinumoper AS VARCHAR(5))               --8
		--	error en largos de folios  	
	
	,	(CASE WHEN vIFeccomp IS NULL THEN vIFecinip ELSE vIFeccomp END)
	,	(CASE WHEN vIFecven  IS NULL THEN vIFecvenp ELSE vIFecven END)                    --10
	,	CASE	WHEN viseriado='N' THEN ISNULL((SELECT       nsmonemi FROM BacParamSuda..NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
			ELSE               ISNULL((SELECT top 1 semonemi FROM BacParamSuda..SERIE   WHERE semascara=vimascara),0) 
        END  
	,	CASE WHEN vivalcomu < 0 THEN '-' ELSE '+' END                                                            --12
	,	vivalcomu             --13
	,	CASE WHEN vivalcomp < 0 THEN '-' ELSE '+' END                                     --14
	,	vivalcomp                         --15
	,	CASE WHEN vireajustv < 0 THEN '-' ELSE '+' END                                                             --16   
	,	vireajustv                                       
                                                          --17
	,	vivptirc                                                                                                  --22
	,	CASE WHEN vimonemi = 999 THEN vinominal ELSE ISNULL((vinominal*(SELECT vmvalor FROM #VALOR_TC_CONTABLE /*BacParamSuda..VALOR_MONEDA*/ WHERE vmcodigo = vimonemi /*and vmfecha = vIFecvenp*/)),0) END --23
	,	vivptirc
	,	'A'                                       --27
	,	0 
	,	CAST(vinumoper AS VARCHAR(6)) + '1' + CAST( vinumoper AS VARCHAR(6)) --
	,	@FECHA        --30
	,	0 
	,	0 
	,	CASE WHEN viinteresv < 0 THEN '-' ELSE '+' END                                                             --33     
	,	viinteresv                                                                         
                        --34          
	,	CASE	WHEN viseriado='N' THEN ISNULL((SELECT       nsbasemi FROM BacParamSuda..NOSERIE WHERE nsnumdocu=vinumdocu AND nscorrela=vicorrela),0)
			ELSE                    ISNULL((SELECT top 1 sebasemi FROM BacParamSuda..SERIE   WHERE semascara=vimascara),0) 
                END
	,	vitircomp
	,	viseriado                                                                        --37
	,	0				
	,	ISNULL(CASE WHEN vimascara = 'PRC' or vimascara = 'DPL' THEN 1 
					ELSE (SELECT secupones FROM BacParamSuda..SERIE WHERE vimascara = semascara) END,0) --39
	,	(CASE WHEN vIFecven IS NULL THEN vIFecvenp ELSE vIFecven END)      --40
	,	CASE	WHEN viseriado='N' THEN vinominal ELSE ROUND((vinominal * (vipvpvent / 100.0)),2)  END
	,	(CASE WHEN vitipoper = 'CP' THEN vivalcomp ELSE vivalinip END)       --42  VGS
/*34*/	,	ISNULL((SELECT ccn_codigo_nuevo FROM BacParamSuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = MDVI.codigo_carterasuper),4)
	,	RIGHT('0000'+cast(datedIFf(day,(CASE WHEN vIFeccomp IS NULL THEN vIFecinip ELSE vIFeccomp END),vIFecven) AS VARCHAR(4)),4)                                                        --44
	,	ISNULL((SELECT inserie   FROM BacParamSuda..INSTRUMENTO WHERE incodigo = vicodigo),'')                               --45
	,	ISNULL((SELECT emgeneric FROM BacParamSuda..EMISOR      WHERE emrut = virutemi),'')           --46
	,	cast(vicorrela AS VARCHAR(3))
	,	vicodigo
	,	ISNULL((SELECT DISTINCT sepervcup FROM BacParamSuda..SERIE WHERE semascara = vimascara),0) 
	,	(CASE WHEN vIFecemi IS NULL THEN vIFecinip ELSE vIFecemi END)
	,	CASE WHEN vitipoper = 'CI' THEN 'CPACT' ELSE vimascara END --vimascara GLCF
	,	CASE	WHEN vimonemi = 998 THEN 1 
              	WHEN vimonemi = 13  THEN 3
		WHEN vimonemi = 999 THEN 4 
		ELSE       0
		END
	,	virutemi 
	,	datedIFf(day,@fecha,vIFecven) 
	,	(CASE WHEN vIFecven IS NULL THEN vIFecvenp ELSE vIFecven END)     
	,	CASE	WHEN virutemi = 97029000 THEN 211  
			WHEN virutemi = 97030000 THEN 212
			ELSE 221 END
 	,	vinumoper
	,	'9'
        ,	c_Riesgo	= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais ( emis.emrut, emis.emcodigo, 'BTR')
       FROM	BACTRADERSUDA..MDVI
			left join	(	select emrut, emcodigo 
							from   BacParamSuda.dbo.Emisor with(nolock) 
							where  emcodigo = 1 
						)	emis   On emis.emrut = virutemi and emis.emcodigo = 1

       WHERE	(vinominal > 0 AND virutcart > 0) AND vitipoper = 'CP' -- MAP 20070111 


/*
	SELECT * 
	INTO	#VALORIZACION_MERCADO 
	FROM	VALORIZACION_MERCADO
	WHERE	fecha_valorizacion =
  @FECHAvaloriza 
*/


   SELECT Documento   = rmnumdocu
       ,  Operacion   = rmnumoper
       ,  Correlativo = rmcorrela
       ,  TOperacion  = tipo_operacion
       ,  DFVM        = isnull(diferencia_mercado - difme, diferencia_mercado)
     INTO #tmp_valoriza_cp_vi
     FROM BACTRADERSUDA..VALORIZACION_MERCADO  VM
          LEFT JOIN (SELECT numdocu = rmnumdocu, correla = rmcorrela, vpres = isnull(SUM(valor_presente),0)
                          , vmerc   = isnull(SUM(valor_mercado),      0)
							, difme   = isnull(SUM(diferencia_mercado), 0)
                       FROM BACTRADERSUDA..VALORIZACION_MERCADO 
                      WHERE fecha_valorizacion = @FECHAvaloriza
                        AND tipo_operacion     = 'VI'
                   GROUP BY rmnumdocu, rmcorrela, tipo_operacion) VM1 ON VM1.numdocu = VM.RMNUMDOCU AND VM1.correla = VM.RMCORRELA
                      WHERE fecha_valorizacion = @FECHAvaloriza 
                        AND tipo_operacion     = 'CP'


   SELECT *    
   INTO   #VALORIZACION_MERCADO   --> #tmp_valorizacion_mercado
   FROM   BACTRADERSUDA..VALORIZACION_MERCADO
   WHERE  fecha_valorizacion = @FECHAvaloriza



   UPDATE #VALORIZACION_MERCADO   --> #tmp_valorizacion_mercado
      SET diferencia_mercado = DFVM
     FROM #tmp_valoriza_cp_vi
    WHERE tipo_operacion     = 'CP'
      and rmnumdocu          = Documento
      and rmnumoper          = Operacion
      and rmcorrela          = Correlativo

  -- MAP Emergencia
  update #CARTERA
     set periocidad = '9999' 
	 where periocidad = '000*'


	DECLARE CURSOR_INTER CURSOR FOR 
	SELECT	tipopro   
	,	tipoper
	,	rut  
	,	dig   
	,	n_operacion
   
	,	fecha_inic    
	,	fecha_vcto 
	,	cod_inter_mda  
	,	s_mto_cap_ori  
	,	mto_cap_origen   --10
	,	s_mto_cap_loc 
	,	mto_cap_local 	
	,	s_reaj_mda_loc
	,	mto_reaj_loc   	
	,	valor_en_pesos 
	,	nomin_en_pesos   
	,	mto_opc_compra
	,	indicador     
	,	crediticio    
	,	n_oper_orig	--20
	,	f_ult_deveng   	
	,	s_int_mda_or   
	,	int_mda_or	
	,	s_int_mda_loc 
	,	int_mda_loc   
	,	cod_tasa_base 
	,	tasa_interes   	
	,	seriado 	
	,	cuotas_rmtes     
	,	total_cuotas	--30
	,	f_ultimo_pago 
	,	mto_ini_mda_o 
	,	col_mda_efe    	
	,	tipo_cartera   
	,	periocidad	
	,	i_tipo_isnmto 
	,	i_del_e_isnmto
	,	correla	
	,	codigo         	
	,	p_vcto_cupon	--40
	,	f_emision 	
	,	mascara	
	,	cal_intereses 
	,	rutemisor
	,	dias_dIFe      	
	,	campo_26	
	,	destino 	
	,	NUMOPERORIG 
	,	EstPacteado
	,   c_Riesgo			-->	50
	FROM	#CARTERA

	OPEN	CURSOR_INTER
	FETCH NEXT FROM CURSOR_INTER
	INTO	@tipopro        
	,	@tipoper 		
	,	@rut			
	,	@dig			--04
	,	@n_operacion	
	,	@fecha_inic		
	,	@fecha_vcto		
	,	@cod_inter_mda		--08
	,	@s_mto_cap_ori  
	,	@mto_cap_origen	
	,	@s_mto_cap_loc	
	,	@mto_cap_local		--12
	,	@s_reaj_mda_loc	
	,	@mto_reaj_loc		
	,	@valor_en_pesos	
	,	@nomin_en_pesos		--16
	,	@mto_opc_compra	
	,	@indicador		
	,	@crediticio		
	,	@n_oper_orig		--20
	,	@f_ult_deveng   
	,	@s_int_mda_or		
	,	@int_mda_or		
	,	@s_int_mda_loc		--24
	,	@int_mda_loc	
	,	@cod_tasa_base	
	,	@tasa_interes		
	,	@seriado		--28
	,	@cuotas_rmtes	
	,	@total_cuotas		
	,	@f_ultimo_pago	
	,	@mto_ini_mda_o		--32
	,	@col_mda_efe    
	,	@tipo_cartera		
	,	@periocidad		
	,	@i_tipo_isnmto		--36
	,	@i_del_e_isnmto	
	,	@correla		
	,	@codigo		
	,	@p_vcto_cupon		--40
	,	@f_emision	
	,	@mascara		
	,	@cal_intereses	
	,	@rutemisor		--44
	,	@dias_dIFe      
	,	@campo_26		
	,	@destino		
	,	@NUMOPERORIG		--48
	,	@EstPacteado
	,	@c_Riesgo			-->	50

      WHILE @@FETCH_STATUS  = 0 
      BEGIN 

         IF @tipopro = 'CP'
            SELECT @DIG = Cldv FROM BacParamSuda..CLIENTE WHERE Clrut = @rut

         SELECT @n_oper_orig2=LEFT(@n_operacion,5)
	 SELECT @mto_opc_compra=0
	 SELECT @mto_opc_compra_x = 0
	 SELECT @valor = 0

         SELECT @valor = ISNULL((SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmcodigo=@cod_inter_mda and vmfecha = @fecha_inic),0)

         IF @tipopro = 'CP' or (@tipopro = 'CI' OR @tipopro = 'IB') or  @tipopro = 'VI' 
         BEGIN
            IF @int_mda_loc < 0 
          BEGIN      
               SELECT @s_int_mda_or = '-'
            END ELSE 
            BEGIN
               SELECT @s_int_mda_or = '+'
            END

            IF @valor = 0 
            BEGIN
        
       SET @int_mda_or = @int_mda_loc/1
            END ELSE 
            BEGIN
               SET @int_mda_or = @int_mda_loc/@valor
            END

            IF @cod_inter_mda = 13
            BEGIN
               SET @int_mda_or = ROUND(@int_mda_loc/@valordolarant,2)
            END ELSE 
            BEGIN
               IF @cod_inter_mda = 142 
               BEGIN
                  SET @int_mda_or = ROUND(@int_mda_loc/@valor_142,2)
               END ELSE 
               BEGIN
                  IF @cod_inter_mda = 102 
                  BEGIN
                     SET @int_mda_or = ROUND(@int_mda_loc/@valor_102,2)
                  END ELSE 
                  BEGIN
                     IF @cod_inter_mda = 72 
                     BEGIN
             
           SET @int_mda_or = ROUND(@int_mda_loc/@valor_72,2)
                     END      
                  END
               END
            END         
         END

         IF @tipopro = 'CP' 
         BEGIN
            IF @cod_inter_mda = 999 
  
          BEGIN 
               SET @nomin_en_pesos = @mto_ini_mda_o
            END ELSE 

            IF @cod_inter_mda = 998 
            BEGIN
               SET @nomin_en_pesos = ROUND( ( @mto_ini_mda_o * @valorUF ) ,0)
            END ELSE 

       
     IF (@cod_inter_mda = 995  and ( @mascara IN('BR','BD','BE','BF','CBR' ))) 
            BEGIN
               SET @nomin_en_pesos = @mto_ini_mda_o  
            END ELSE 
            BEGIN
               IF @cod_inter_mda = 994 
               BEGIN 
 
                 SET    @nomin_en_pesos = ROUND ( ISNULL((@mto_ini_mda_o * @valordolarant),0),0)
                  SELECT @mto_cap_local  = ROUND(@mto_cap_origen * @valor  ,0)  --@valordolarant
               END ELSE 

               IF @cod_inter_mda = 142 
               BEGIN
                  SET    @nomin_en_pesos = ROUND ( ISNULL((@mto_ini_mda_o * @valor_142),0),0)
                  SELECT @mto_cap_local  = ROUND(@mto_cap_origen * @valor_142  ,0) 
	       END ELSE 

               IF @cod_inter_mda = 102 
               BEGIN
                  SET    @nomin_en_pesos = ROUND ( ISNULL((@mto_ini_mda_o * @valor_102),0),0)
                  SELECT @mto_cap_local  = ROUND(@mto_cap_origen * @valor_102  ,0) 
               END ELSE 

               IF @cod_inter_mda = 72 
               BEGIN
                  SET    @nomin_en_pesos = ROUND ( ISNULL((@mto_ini_mda_o * @valor_72),0),0)
                  SELECT @mto_cap_local  = ROUND(@mto_cap_origen * @valor_72  ,0) 
               END ELSE 
               BEGIN
                  SET    @nomin_en_pesos = ISNULL((@mto_ini_mda_o * (SELECT vmvalor FROM #VALOR_TC_CONTABLE  /*BacParamSuda..VALOR_MONEDA*/ WHERE vmcodigo = @cod_inter_mda /*and vmfecha = @fecha_inic*/)),0)
                  SELECT @mto_cap_local  = ROUND(@mto_cap_origen * @valor  ,0) --@valordolarant
               END
            END

            IF @cod_inter_mda = 998 
               SET @cal_intereses= 1
            ELSE
               IF @cod_inter_mda = 13
                  SET @cal_intereses= 3
               ELSE 
                  IF @cod_inter_mda = 999 or ( @cod_inter_mda = 995  and @mascara = 'BR')
                     SET @cal_intereses= 4
                  ELSE 
                     SET @cal_intereses= 0
         END

         SELECT @valor_en_pesos = 0
         SELECT @tasamercado =  0.0
			
         IF  @tipopro <> 'VI' 
         BEGIN  
            IF EXISTS(SELECT valor_mercado FROM #VALORIZACION_MERCADO   WHERE tmmascara = @mascara and  fecha_valorizacion =  @FECHAvaloriza and rmnumoper = @NUMOPERORIG and rmcorrela = @correla AND rmnumdocu = @n_oper_orig2 ) 
            BEGIN
             SELECT	@valor_en_pesos =  ISNULL( valor_mercado ,0.0)
               ,	@tasamercado    =  ISNULL( tasa_mercado  ,0.0)
               FROM	#VALORIZACION_MERCADO   
	       WHERE	tmmascara		= @mascara 
               AND	fecha_valorizacion	= @FECHAvaloriza 
               AND	rmnumoper		= @NUMOPERORIG  
               AND	rmcorrela		= @correla 
               AND	rmnumdocu		= @n_oper_orig2
      
      END ELSE 
            BEGIN  -- sino tasa compra 
               SELECT	@valor_en_pesos = 0
				
               IF  @tipopro = 'CI'  
               BEGIN
                  SELECT @tasamercado =  @tasa_interes   
               END ELSE 
           
    BEGIN
                  SELECT @tasamercado =  0.0
               END
            END 
         END ELSE 
         BEGIN
            -- si es 'VI'
            SELECT @valor_en_pesos = 0 
            SELECT @tasamercado =  0.0
         END

         IF @tipopro  = 'CP'
            SET @i_del_e_isnmto = ISNULL((SELECT emgeneric FROM BacParamSuda..EMISOR WHERE emrut = @rutemisor),'')

	IF @tipopro  = 'CP' 
        BEGIN
	   IF @cod_inter_mda = 900 or (@cod_inter_mda = 995 AND (@mascara NOT IN('BR','BD','BE','BF','CBR' ) )) or @cod_inter_mda = 13 or @cod_inter_mda = 142 BEGIN 
               SELECT  @mto_opc_compra_x = ISNULL((SELECT CPVPTIRC FROM BACTRADERSUDA..MDCP WHERE cpnumdocu =@n_oper_orig2 and cpcorrela =  @correla),0)
           SET @mto_opc_compra =( @mto_opc_compra_x / @vDolar_obs )
         END ELSE 
         BEGIN
            SELECT  @mto_opc_compra = ROUND((SELECT CPVALCOMP/@vDolar_obs FROM BACTRADERSUDA..MDCP WHERE cpnumdocu =@n_oper_orig2 and cpcorrela =  @correla),2)
         END 
      END
		
      IF @tipopro = 'ICOL' or @tipoper = 'ICAP'
         IF @cod_inter_mda = 142 
         BEGIN
            SET @mto_opc_compra = ROUND((SELECT civalcomp/@valor_142  FROM BACTRADERSUDA..MDCI WHERE cinumdocu =@n_oper_orig2 and cicorrela =  @correla),2)
         END

      IF @cod_inter_mda = 102 
      BEGIN
         SET @mto_opc_compra = ROUND((SELECT civalcomp/@valor_102  FROM BACTRADERSUDA..MDCI WHERE cinumdocu =@n_oper_orig2 and cicorrela =  @correla),2)
      END
		
      IF @cod_inter_mda = 72  
      BEGIN
         SET @mto_opc_compra = ROUND((SELECT civalcomp/@valor_72   FROM BACTRADERSUDA..MDCI WHERE cinumdocu =@n_oper_orig2 and cicorrela =  @correla),2)
      END ELSE 
      BEGIN 
         SET @mto_opc_compra = ROUND((SELECT civalcomp/@vDolar_obs FROM BACTRADERSUDA..MDCI WHERE cinumdocu =@n_oper_orig2 and cicorrela =  @correla),2)
      END
			
      IF @tipopro = 'CI'
         SET @mto_opc_compra=ROUND((SELECT (civalvenp * @valor) / @vDolar_obs FROM BACTRADERSUDA..MDCI WHERE cinumdocu =@n_oper_orig2 and cicorrela =  @correla),2)

      SELECT @tdcupon = 0   
			
      IF @seriado = 'S' and ( @tipopro <> 'VI' and @tipopro <> 'CI') 
      BEGIN
         IF @codigo <> 20 
         BEGIN
            SELECT @tdcupon = ISNULL((SELECT COUNT(1) FROM BacParamSuda..TABLA_DESARROLLO WHERE tdfecven > @FECHA and tdmascara = @mascara),0)
         END ELSE 
         BEGIN
            SELECT @tdcupon = ISNULL((SELECT COUNT(1) FROM BacParamSuda..TABLA_DESARROLLO WHERE tdmascara = @mascara AND DATEADD( MONTH, tdcupon * @p_vcto_cupon, @f_emision ) > @FECHA ),0)
         END

         SET    @cuotas_rmtes =  CONVERT(numeric(4),@tdcupon)  
      END ELSE
         SET    @cuotas_rmtes = 1

      SET @mto_opc_compra=ISNULL(@mto_opc_compra,0)
      SET @nomin_en_pesos=ISNULL(@nomin_en_pesos,0)
      -----------------------
      SET @dias =  @dias_dIFe
      SET @nIntasb   = (SELECT intasest FROM BacParamSuda..INSTRUMENTO WHERE incodigo = @codigo) 
      SET @inst_variable  = 'N'
      SET @tip_tasa       = '0'

      IF @nIntasb > 0  
      BEGIN   
         IF (@codigo = 1 OR @codigo =2 OR @codigo =5 OR SUBSTRING(@mascara,1,8) = 'BCAPS-A1' ) 
         BEGIN 
            SET @inst_variable = 'S'
            SET @tip_tasa = CASE WHEN SUBSTRING(@mascara,1,3) = 'PCD' OR SUBSTRING(@mascara,1,3) ='PTF' THEN '2' 
                                 WHEN SUBSTRING(@mascara,1,8) = 'BCAPS-A1'  THEN '3'
				 ELSE '9' 
                            END
         END  
      END   

      IF @inst_variable= 'N' 
      BEGIN -- fija  
         SELECT @t_tasa = 'F '

         IF @dias < 30 
            SET @tip_tasa =  '101' 
       
  IF @dias >= 30   and @dias < 90   -- cpfecven
            SET @tip_tasa = '102' 
         IF @dias >= 90   and  @dias < 180 
            SET @tip_tasa = '103'
         IF @dias >= 180  and  @dias < 365 
            SET @tip_tasa = '104'
         IF @dias >= 365  and  @dias < 1095 
            SET @tip_tasa = '105' 
         IF @dias >= 1095 
            SET @tip_tasa = '106'
      END ELSE 

      IF @inst_variable = 'S' 
      BEGIN 
         SELECT @t_tasa = 'V'
         IF DATEDIFF(DAY,@fecha, @campo_26 ) < 30
            SET @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '1'
         IF DATEDIFF(DAY,@fecha, @campo_26 ) >= 30 and  datedIFf(day,@fecha,@campo_26) < 90
            SET @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '2'
         IF DATEDIFF(DAY,@fecha,@campo_26) >= 90 and datedIFf(month,@fecha,@campo_26) < 6
            SET @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '3'
         IF DATEDIFF(MONTH,@fecha,@fecha_vcto) >= 6  and  datedIFf(year,@fecha,@campo_26) < 1
            SET @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '4'
         IF DATEDIFF(YEAR,@fecha,@campo_26) >= 1  and  datedIFf(year,@fecha,@campo_26) < 3
            SET @tip_tasa = '2' + SUBSTRING(@tip_tasa,1,1) + '5'
         IF DATEDIFF(YEAR,@fecha,@campo_26) >= 3  
           
 SET @tip_tasa = '2'  + SUBSTRING(@tip_tasa,1,1) + '6'
      END 

     SELECT @registros = (SELECT COUNT(1) FROM #CARTERA)
		
                     INSERT INTO #TABLA_INTERFAZ 
                                    VALUES	(	CONVERT(CHAR(8),@FECHA,112) 			--1
						,	'A'                                             --2
						,	@tipopro                                        --3
						,	@tipoper                                        --4
						,	convert(varchar(10),@rut)                                            --5
						,	convert(varchar(1),@dig)                                            --6 
						,	'0'                                             --7
						,	@n_operacion                                    --8
						,	CONVERT(CHAR(8),@fecha_inic,112)                --9
						,	CONVERT(CHAR(8),@fecha_vcto,112)                --10
						,	@cod_inter_mda					--11
						,	@s_mto_cap_ori					--12
						,	@mto_cap_origen					--13
						,	@s_mto_cap_loc					--14                  
						,	@mto_cap_local                                  --15
						,	@s_reaj_mda_loc                                 --16
						,	@mto_reaj_loc                                   --17
						,	@t_tasa                                         --18
						,	0                                               --19
						,	@valor_en_pesos                                 --20
						,	@nomin_en_pesos                                 --21
						,	'2'                                             --22
						,	CONVERT (numeric(19,2), @mto_opc_compra )       --23
						,	@registros                                      --24
						,	@indicador                                      --25
						,	@crediticio                                     --26
						,	@n_oper_orig                                    --27
						,	CONVERT(CHAR(08),@f_ult_deveng,112)             --28
						,	@s_int_mda_or                                   --29
						,	@int_mda_or                                     --30
						,	@s_int_mda_loc                                  --21
						,	@int_mda_loc                     
               --32
						,	@cod_tasa_base                                  --33
						,	@tasa_interes                                   --34
						,	@cuotas_rmtes                                   --35
						,	@total_cuotas      --36
						,	CONVERT(CHAR(08),@f_ultimo_pago,112)       --37
						,	@mto_ini_mda_o                 --38
						,	@col_mda_efe                                    --39
						,	@tipo_cartera                                   --40
						,	@periocidad                             
        --41

						,	CASE WHEN @i_tipo_isnmto = 'BONOS' THEN 'BE' ELSE @i_tipo_isnmto END --42 
  					     -->,	@i_tipo_isnmto                                  --42 


						,	@i_del_e_isnmto                                 --43
						,	CONVERT(CHAR(08),@f_emision,112)                --44
						,	@cal_intereses                                  --45
						,	@tip_tasa                                       --46
						,	@destino                                        --47
						,	ABS(@tasamercado)          
                     --48
						,	@EstPacteado					
                        ,	@c_Riesgo
						)
		FETCH NEXT FROM CURSOR_INTER
		INTO	@tipopro        , @tipoper 		, @rut			, @dig			--04
		,	@n_operacion	, @fecha_inic		, @fecha_vcto		, @cod_inter_mda	--08
		,	@s_mto_cap_ori  , @mto_cap_origen	, @s_mto_cap_loc	, @mto_cap_local	--12
		,	@s_reaj_mda_loc	, @mto_reaj_loc		, @valor_en_pesos	, @nomin_en_pesos	--16
		,	@mto_opc_compra	, @indicador		, @crediticio		, @n_oper_orig		--20
		,	@f_ult_deveng   , @s_int_mda_or		, @int_mda_or		, @s_int_mda_loc	--24
		,	@int_mda_loc	, @cod_tasa_base	, @tasa_interes		, @seriado		--28
		,	@cuotas_rmtes	, @total_cuotas		, @f_ultimo_pago	, @mto_ini_mda_o	--32
		,	@col_mda_efe    , @tipo_cartera		, @periocidad		, @i_tipo_isnmto	--36
		,	@i_del_e_isnmto	, @correla	
		, @codigo		, @p_vcto_cupon		--40
		,	@f_emision	, @mascara		, @cal_intereses	, @rutemisor		--44
		,	@dias_dIFe      , @campo_26		, @destino		, @NUMOPERORIG		--48
		,	@EstPacteado    , @c_Riesgo
	END
	
	CLOSE CURSOR_INTER
	DEALLOCATE  CURSOR_INTER

	DECLARE @FECHAFILTRO CHAR(8)
	SELECT  @fechaFiltro = CONVERT(CHAR,@fecha,112)

	UPDATE #TABLA_INTERFAZ 
	SET	Colocacion  = (CASE WHEN finic <> @fechaFiltro THEN 0 
				    ELSE (CASE WHEN Cod_Producto in ('CI') THEN Colocacion 
                                             
  ELSE (CASE WHEN tipo_isnmto = 'ICOL' THEN Colocacion ELSE 0 END) 
                                          END) 
                               END)
	,	interes     = (CASE WHEN interes < 0 THEN 0 ELSE interes END)


INSERT INTO @OP15 (
			 ctry						--		1	
			, book_dt					--		2	
			, intf_dt					--		3	
			, src_id					--		4	
			, cem						--		5	
			, br						--		6	
			, con_sta					--		7	
			, Dlnq_sta					--		8	
			, prod						--		9	
			, open_dt							--		10	
			, lst_accr_dt				--		11	
			, Ident_cli					--		12	
			, cc						--		13	
			, con_no					--		14	
			, strt_dt					--		15	
			, end_dt					--		16	
			, next_rset_rt_dt			--		17	
			, int_pymt_arrs_ind			--		18	
			, ccy						--		19	
			, ocy_nom_amt_sign					--		20	
			, ocy_nom_amt				--		21	
			, lcy_nom_amt_sign			--		22	
			, lcy_nom_amt			    --		23	
			, fcy_lc_amt				--		24	
			, Lcy_reaj_amt_sing			--		25	
			, Lcy_reaj_amt				--		26	
			, Ocy_int_amt_sing			--		27	
			, Ocy_int_amt				--		28	
			, Lcy_int_amt_sing			--		29	
			, Lcy_int_amt						--		30	
			, fix_flting_ind			--		31	
			, int_rt_cod				--		32	
			, int_rt					--		33	
			, pnlt_rt					--		34	
			, rt_meth					--		35	
			, pool_rt					--		36	
			, pool_rt_cod				--		37	
			, pnlt_rt_cod				--		38	
			, int_rt_sprd				--		39	
			, pool_rt_sprd						--		40	
			, pnlt_rt_sprd				--		41	
			, aset_liab_ind				--		42	
			, sbif_bal_no_rep_sign		--		43	
			, sbif_bal_no_rep			--		44	
			, sbif_tipo_tasa			--		45	
			, sbif_prod_trans			--		46	
			, sbif_tipo_oper_trans		--		47	
			, lcy_fee_amt_sign			--		48	
			, lcy_fee_amt				--		49	
			, orig_strt_dt						--		50	
			, nacc_from_dt				--		51	
			, pdue_from_dt				--		52	
			, wrof_from_dt				--		53	
			, orig_con_no				--		54	
			, no_of_remn_coup			--		55	
			, no_of_pdo_coup			--		56	
			, no_of_tot_coup			--		57	
			, sbif_dest_coloc			--		58	
			, stop_accr_dt				--		59	
			, lst_int_pymt_dt					--		60	
			, ren_ind					--		61	
			, lst_rset_dt				--		62	
			, next_rt_ch_dt				--		63	
			, lst_rt_ch_dt				--		64	
			, ocy_orig_nom_amt			--		65	
			, lcy_avl_bal				--		66	
			, lcy_pdo1_amt				--		67	
			, lcy_pdo2_amt				--		68	
			, Lcy_pdo3_amt				--		69	
			, lcy_oper_amt						--		70	
			, loc						--		71	
			, lcy_mnpy					--		72	
			, lgl_actn_ind				--		73	
			, Lcy_mv					--		74	
			, Lcy_par_val				--		75	
			, Port_typ					--		76	
			, No_rng					--		77	
			, Pdc_coup					--		78	
			, Pgo_amt					--		79	
			, con_no_typ						--		80	
			, ope_typ					--		81	
			, mod_entr_bs				--		82	
			, opc_compra				--		83	
			, ident_instr				--		84	
			, ident_emi_instr			--		85	
			, serie_instr				--		86	
			, subserie_instr			--		87	
			, cat_risk_instr			--		88	
			, limit_rate				--		89	
			, pdc_after_fix_per					--		90	
			, lcy_pdo4_amt				--		91	
			, lcy_pdo5_amt				--		92	
			, lcy_pdo6_amt				--		93	
			, sbif_no_rep_ind			--		94	
			, Lcy_otr_cont_amt			--		95	
			, lcy_pdo7_amt				--		96	
			, lcy_pdo8_amt				--		97	
			, lcy_pdo9_amt				--		98	
			, assets_origin				--		99	
			, first_expiry_dt			--		100	
			, tip_otorg					--		101	
			, price_viv					--		102	
			, tip_op_reneg				--		103	
			, mon_pie_pag_reneg			--		104	
			, seg_rem_cred_hip			--		105	
			, pdue_from_oldest    		--		106	
			, mon_prev_rng				--		107	
			, exig_pago					--		108	
			, bidding_dt				--		109	
			, loan_disbursement_dt		--		110	
			, Accounting_dt				--		111	
			, last_payment_dt			--		112	
			, last_amount_paid			--		113	
			, credit_line_approved_dt	--		114	
			, Amount_instalment			--		115	
			, Amount_revolving			--		116	
			, Ind_credit_line_duration	--		117	
			, nat_con_no				--		118	
			, dest_finan				--		119
			, no_post_coup				--		120
			, giro						--		121
)

	select
			'CL '																	--		1	
		,	LTRIM(CONVERT(CHAR(10),fecha_contable,112))								--		2	
		,	LTRIM(CONVERT(CHAR(10),fecha_contable,112))								--		3	
 		,	'OP15' + SPACE(10)														--		4	
		,	'001'																	--		5	
 		,	'0011'																	--		6	
 		,	'A'	   + SPACE(02)														--		7	
 		,	'1'																		--		8	
 		,	'MD01'+ SPACE(12)--	'MD01'	+ SPACE(12)														--		9	
 		,	fecha_contable															--		10	
 		,	fecha_contable															--		11	
		,	right(replicate('0',13)+replace(convert(varchar(9),rut_int)+dig_int,' ',''),12)	--		12	
		--,    RIGHT(rut_int+CONVERT(CHAR(1),dig_int),12)

	
 		,	REPLICATE('0',10)														--		13	
		,   ltrim(rtrim(operacion))													--		14	
		,	finic						 											--		15	
		,	fvcto																	--		16	
		,	''																		--		17	
		,	''																		--		18	
		,	m.mncodbkb																--		19	
		,	signo_mto1				--		20										--		20	
		,	mto1																	--		21	
 		,	signo_mto2																--		22	
 		,	mto2																	--		23	
		,	0						--	fcy_lc_amt	24								--		24	
 		,	signo_mto3																--		25	
 		,	mto3																	--		26	
		,	signo_mto4																--		27	
 		,	mto4																	--		28	
		,	signo5																	--		29	
 		,	monto5																	--		30	
		,	tasa_f_v+' '															--		31	
		,	tasa_base																--		32	
		,	interes					--int_rt  33									--		33	
		,	0						--pnlt_rt 34									--		34	
		,   cal_intereses			--rt_meth										--		35	
		,	0						--pool_rt										--		36	
		,	'0'						--pool_rt_cod									--		37	
		,   space(4)				--pnlt_rt_cod									--		38	
		,	0																		--		39	
		,	0																		--		40	
		,	0																		--		41	
		,	status																	--		42	
		,	case when 0 >= 0 then '+' else '-' end									--		43	
		,	0																		--		44	
		,   tipo_tasa				-- sbif_tipo_tasa	45							--		45	
		,		0																	--		46	
		,		1																	--		47	
		,		'+'																	--		48	
		,		0																	--		49	
		,		''																	--		50	
		,		''																	--		51	
		,		''																	--		52	
		,		''					-- wrof_from_dt	53								--		53	
		,	oper_orig				-- orig_con_no  54								--		54	
		,	cuotas_rmtes															--		55	
		,	0																		--		56	
		,	total_cuotas															--		57	
		,	0--destino																	--		58
		,	''																		--		59	
		,	fec_ultimo_pago			-- lst_int_pymt_dt								--		60	
		,		' '																	--		61	
		,		''																	--		62	
		,		''																	--		63	
		,		''																	--		64
		,   nomin																	--	ocy_orig_nom_amt	65							
		,		0																	--		66	
		,		0																	--		67	
		,		0																	--		68	
		,		0																	--		69	
		,   monto_inicio			--	lcy_oper_amt		70						--		70	
		,		0																	--		71	
		,		0																	--		72	
		,		' '																	--		73	
		,		0																	--		74	
		,	mto2									--	Lcy_par_val			75						--		75	
		,		case   when indicador_inter = 'P'  then 1
			   when indicador_inter = 'T'  then 2
			   when indicador_inter = 'A'  then 3
		end																			--		76	
		,		0																	--		77	
		,   tasa_base																--		78	
		,	0																		--		79	
		,	''																		--		80	
		,   case when EstPacteado =  '' then '1' ELSE '9' END	--ope_typ 81		--		81	
		,	'  '																	--		82	
		,	0																		--		83	
		,   tipo_isnmto																--		84	
		,   emisor_isnmto															--		85	
		,	SPACE(4)																--		86	
		,	SPACE(5)																--		87	
		,	c_riesgo																--		88	
		,		0																	--		89	
		,		0																	--		90	
		,		0																	--		91	
		,		0																	--		92	
		,		0																	--		93	
		,		'S'																	--		94	
		,		0																	--		95	
		,		0																	--		96	
		,		0																	--		97	
		,		0																	--		98	
		,		0																	--		99	
		,		''																	--		100	
		,		''																	--		101	
		,		0																	--		102	
		,		''																	--		103
		,		0																	--		104	
		,		''																	--		105
		,		0																	--		106	
		,		0																	--		107	
		,		''																	--		108	
		,		''																	--		109
		,		''																	--		110	
		,		fecha_contable														--		111	
		,		''																	--		112	
		,		0																	--		113	
		,		''																	--		114	
		,		0																	--		115	
		,		0																	--		116	
		,      space(1)																--		117	
		,	   space(4)																--		118	
		,	   ''																	--		119	
		,	   0																	--		120
		,	   ''																	--		121
		FROM	#TABLA_INTERFAZ	
		inner join BacParamSuda..MONEDA m				with(nolock) On			m.mncodmon	= cintermda
	ORDER
	BY		operacion
/*
	select 
	  fecha_contable	As  fecha_contable_01
, status	As  status_02
, cod_producto    	As  cod_producto_03    
, t_operac    	As  t_operac_04    
, rut_int    	As  rut_int_05    
, dig_int    	As  dig_int_06    
, costo    	As  costo_07    
, operacion    	As  operacion_08    
, finic    	As  finic_09    
, fvcto     --> 10    	As  fvcto_10     --> 10   
, cintermda  	As  cintermda_11  
, signo_mto1	As  signo_mto1_12
, mto1    	As  mto1_13    
, signo_mto2    	As  signo_mto2_14    
, mto2    	As  mto2_15    
, signo_mto3    	As  signo_mto3_16    
, mto3   	As  mto3_17   
, tasa_f_v    	As  tasa_f_v_18  
, spread  	As  spread_19  
, valor     --> 20    	As  valor_20     --> 20   
, nomin    	As  nomin_21    
, t_cartera    	As  t_cartera_22    
, mto_o_compra    	As  mto_o_compra_23    
, total     --> 24    	As  total_24     --> 24   
, indicador_inter    	As  indicador_inter_25    
, crediticio_inter    	As  crediticio_inter_26   
, oper_orig    	As  oper_orig_27    
, fec_ult_deveng    	As  fec_ult_deveng_28    
, signo_mto4    	As  signo_mto4_29    
, mto4     --> 30    	As  mto4_30     --> 30    
, signo5    	As  signo5_31    
, monto5    	As  monto5_32    
, tasa_base    	As  tasa_base_33    
, interes 	As  interes_34 
, cuotas_rmtes    	As  cuotas_rmtes_35    
, total_cuotas    	As  total_cuotas_36    
, fec_ultimo_pago    	As  fec_ultimo_pago_37    
, monto_inicio    	As  monto_inicio_38    
, colocacion    	As  colocacion_39    
, cartera     --> 40    	As  cartera_40     --> 40 
, perido    	As  perido_41    
, tipo_isnmto    	As  tipo_isnmto_42    
, emisor_isnmto    	As  emisor_isnmto_43    
, f_emision    	As  f_emision_44    
, cal_intereses    	As  cal_intereses_45    
, tipo_tasa    	As  tipo_tasa_46    
, destino    	As  destino_47    
, tasamercado   	As  tasamercado_48   
, EstPacteado   	As  EstPacteado_49   
, c_riesgo	As  c_riesgo 

	FROM	#TABLA_INTERFAZ	
		inner join BacParamSuda..MONEDA m				with(nolock) On			m.mncodmon	= cintermda
	ORDER
	BY		operacion
	*/
	drop table #CARTERA
	drop table #VALOR_TC_CONTABLE
	drop table #TABLA_INTERFAZ
	drop table #CARTERA_VI
	drop table #CARTERACI
	drop table #tmp_valoriza_cp_vi
	drop table #VALORIZACION_MERCADO

	
Declare @TipoSalida bit = 0

if @TipoSalida != 0
	  select 	 
				distinct
				 ctry																																						--		1					
				, book_dt																																					--		2	
				, intf_dt																																					--		3	
				, src_id																																					--		4	
				, cem																																						--		5	
				, br																																						--		6	
				, con_sta																																					--		7	
				, Dlnq_sta																																					--		8	
				, prod																																						--		9	
				, (case when open_dt='19000101' then '00000000' else open_dt end) as open_dt																																					--		10	
				, (case when lst_accr_dt='19000101' then '00000000' else lst_accr_dt end) as lst_accr_dt																																				--		11	
				, Ident_cli																																					--		12	
				, cc																																						--		13	
				, left(con_no+space(20), 20) as con_no--con_no + replicate(char(160), 20 - len(con_no)) 		as con_no																																	--		14	
				, (case when strt_dt='19000101' then '00000000' else strt_dt end) as strt_dt																																					--		15	
				, (case when end_dt='19000101' then '00000000' else end_dt end) as end_dt																																					--		16	
				, replicate('0',8) next_rset_rt_dt--next_rset_rt_dt																														--		17	
				, replicate(' ',1) int_pymt_arrs_ind--int_pymt_arrs_ind																														--		18	
				, left(ccy,4)	ccy																																			--		19	
				, ocy_nom_amt_sign		 																																	--		20	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_nom_amt*10000))),19)	ocy_nom_amt																		--		21	
				, lcy_nom_amt_sign			 																																--		22	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_nom_amt*100))),19)			lcy_nom_amt																--		23	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(fcy_lc_amt*10000))),19)		fcy_lc_amt															--		24	
				, Lcy_reaj_amt_sing			 																																--		25	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_reaj_amt*100))),19)	Lcy_reaj_amt																	--		26
				, Ocy_int_amt_sing		 																																	--		27	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Ocy_int_amt*10000))),19)	Ocy_int_amt																		--		28
				, Lcy_int_amt_sing			 																																--		29	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_int_amt*100))),19)		Lcy_int_amt																	--		30
				, fix_flting_ind																																			--		31	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(int_rt_cod))),4)		int_rt_cod																		--		32
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt*100000000))),16)	int_rt																--		33	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt*100000000))),16)		pnlt_rt															--		34	
				, rt_meth																																					--		35	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt*100000000))),16)	pool_rt																--		36	
				, left(replicate('0',5) + pool_rt_cod,5)	pool_rt_cod																												--		37
				, left(replicate('0',4) + pnlt_rt_cod,4)	pnlt_rt_cod																												--		38
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt_sprd*100000000))),16)			int_rt_sprd													--		39	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt_sprd*100000000))),16)			pool_rt_sprd													--		40	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt_sprd*100000000))),16)			pnlt_rt_sprd													--		41	
				, aset_liab_ind																																				--		42	
				, sbif_bal_no_rep_sign																																		--		43	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(sbif_bal_no_rep)*100))),19)	sbif_bal_no_rep														--		44
				, right(replicate('0',3) + convert(varchar(3),abs(sbif_tipo_tasa)),3)		sbif_tipo_tasa																				--		45
				, right(replicate('0',2) + convert(varchar(2),abs(sbif_prod_trans)),2)			sbif_prod_trans																			--		46
				, right(replicate('0',1) + convert(varchar(1),abs(sbif_tipo_oper_trans)),1)		sbif_tipo_oper_trans																			--		47
				, lcy_fee_amt_sign																																			--		48	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_fee_amt)*100))),19)	lcy_fee_amt															--		49
				, (case when orig_strt_dt='19000101' then '00000000' when  orig_strt_dt='' then '00000000' else right(replicate('0',8) + orig_strt_dt,8) end) as orig_strt_dt																																				--		50	
				, (case when nacc_from_dt='19000101' then '00000000' when  nacc_from_dt='' then '00000000' else right(replicate('0',8) + nacc_from_dt,8) end) as nacc_from_dt																																				--		51	
				, (case when pdue_from_dt='19000101' then '00000000' when  pdue_from_dt='' then '00000000' else right(replicate('0',8) + pdue_from_dt,8) end) as pdue_from_dt																																				--		52	
				, (case when wrof_from_dt='19000101' then '00000000' when  wrof_from_dt='' then '00000000' else right(replicate('0',8) + wrof_from_dt,8) end) as wrof_from_dt																																				--		53	
				, orig_con_no																																				--		54	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(abs(no_of_remn_coup)))),4)	no_of_remn_coup																--		55
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(abs(no_of_pdo_coup)))),4)		no_of_pdo_coup																--		56
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(abs(no_of_tot_coup)))),4)		no_of_tot_coup																--		57
				, right(replicate(0,3)+convert(varchar(3),convert(numeric(3),(abs(sbif_dest_coloc)))),3)	sbif_dest_coloc
				--, (case when stop_accr_dt='19000101' then '00000000' when  stop_accr_dt='' then '00000000' else right(replicate('0',8) + stop_accr_dt,8) end)			stop_accr_dt										--		58
				, (case when lst_int_pymt_dt='19000101' then '00000000' when  lst_rset_dt='' then '00000000' else right(replicate('0',8) + stop_accr_dt,8) end)			stop_accr_dt
				, (case when lst_int_pymt_dt='19000101' then '00000000' when  lst_int_pymt_dt='' then '00000000' else right(replicate('0',8) + lst_int_pymt_dt,8) end) 		lst_int_pymt_dt										--		59
				, left(ren_ind,1)	ren_ind																																		--		61	
				, (case when lst_rset_dt='19000101' then '00000000' when  lst_rset_dt='' then '00000000' else right(replicate('0',8) + lst_rset_dt,8) end) as lst_rset_dt	--		62	
				, (case when next_rt_ch_dt='19000101' then '00000000' when  next_rt_ch_dt='' then '00000000' else right(replicate('0',8) + next_rt_ch_dt,8) end) as next_rt_ch_dt	--		63	
				, (case when lst_rt_ch_dt='19000101' then '00000000' when  lst_rt_ch_dt='' then '00000000' else right(replicate('0',8) + lst_rt_ch_dt,8) end) as lst_rt_ch_dt																																				--		64	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(ocy_orig_nom_amt)*10000))),19)		ocy_orig_nom_amt													--		65
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_avl_bal)*100))),19)			lcy_avl_bal												--		66
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo1_amt)*100))),19)			lcy_pdo1_amt												--		67
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo2_amt)*100))),19)				lcy_pdo2_amt											--		68
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Lcy_pdo3_amt)*100))),19)			Lcy_pdo3_amt												--		69
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_oper_amt)*100))),19)				lcy_oper_amt											--		70
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(loc)*100))),19)		loc													--		71
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_mnpy)*100))),19)				lcy_mnpy										--		72
				, lgl_actn_ind																																	--		73	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Lcy_mv)*100))),19)					Lcy_mv										--		74
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Lcy_par_val)*100))),19)			Lcy_par_val										--		75
				, right(replicate('0',1) + convert(varchar(1),Port_typ),1)	Port_typ																					--		76
				, right(replicate('0',3) + convert(varchar(3),No_rng),3)	No_rng																					--		77
				, right(replicate('0',4) + convert(varchar(4),Pdc_coup),4)	Pdc_coup																					--		78
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Pgo_amt)*100))),19)	Pgo_amt													--		79
				, ' ' con_no_typ 																															--		80	
				, ope_typ 																																--		81	
				, left(replicate(' ',2) + mod_entr_bs,2)		mod_entr_bs																								--		82
				, right(replicate(0,12)+convert(varchar(12),convert(numeric(12),(abs(opc_compra)*100))),12)		opc_compra												--		83
				, left(ident_instr + replicate(' ',5),5)		ident_instr																								--		84
				, left(replicate(' ',15) + ident_emi_instr,15)	ident_emi_instr																								--		85
				, REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(serie_instr)))) + LTRIM(RTRIM(serie_instr))	serie_instr															--		86	
				, left(replicate(' ',4) + subserie_instr,4)		subserie_instr																							    --		87
				, REPLICATE(' ', 8 - LEN(LTRIM(RTRIM(cat_risk_instr)))) + LTRIM(RTRIM(cat_risk_instr)) cat_risk_instr															--		88	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(limit_rate*100000000))),16)	limit_rate												--		89	
				, right(replicate(0,4)+convert(varchar(4),(abs(pdc_after_fix_per))),4)		pdc_after_fix_per																	--		90
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo4_amt)))),19)	lcy_pdo4_amt													--		91
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo5_amt)))),19)	lcy_pdo5_amt													--		92
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo6_amt)))),19)		lcy_pdo6_amt												--		93
				, sbif_no_rep_ind																																--		94
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Lcy_otr_cont_amt)))),19) Lcy_otr_cont_amt													--		95
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo7_amt)))),19)	lcy_pdo7_amt													--		96
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo8_amt)))),19)		lcy_pdo8_amt												--		97
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo9_amt)))),19)		lcy_pdo9_amt												--		98
				, convert(varchar(1),assets_origin)		assets_origin																										--		99
				, (case when first_expiry_dt='19000101' then '00000000' when  first_expiry_dt='' then '00000000' else right(replicate('0',8) + first_expiry_dt,8) end) as first_expiry_dt																																--		100	
				, tip_otorg																																		--		101	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(price_viv)))),19)		price_viv													--		102
				, tip_op_reneg																																	--		103	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(mon_pie_pag_reneg)))),19)	mon_pie_pag_reneg												--		104
				, seg_rem_cred_hip																																--		105	
				, SUBSTRING('00000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdue_from_oldest),1)))),8) + LTRIM(RTRIM(STR(abs(pdue_from_oldest),8))) 	pdue_from_oldest				--		106	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(mon_prev_rng)*100))),19) mon_prev_rng													--		107
				, exig_pago																																		--		108	
				, (case when bidding_dt='19000101' then '00000000' when  bidding_dt='' then '00000000' else right(replicate('0',8) + bidding_dt,8) end) as bidding_dt																																	--		109
				, (case when loan_disbursement_dt='19000101' then '00000000' when  loan_disbursement_dt='' then '00000000' else right(replicate('0',8) + loan_disbursement_dt,8) end) as loan_disbursement_dt																															--		110		
				, (case when Accounting_dt='19000101' then '00000000' when  Accounting_dt='' then '00000000' else right(replicate('0',8) + Accounting_dt,8) end) as Accounting_dt																																	--		111	
				, (case when last_payment_dt='19000101' then '00000000' when  last_payment_dt='' then '00000000' else right(replicate('0',8) + last_payment_dt,8) end)	as last_payment_dt	--		112	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(last_amount_paid)*100))),19)	last_amount_paid											--		113
				, (case when credit_line_approved_dt='19000101' then '00000000' when  credit_line_approved_dt='' then '00000000' else right(replicate('0',8) + credit_line_approved_dt,8) end)	as credit_line_approved_dt	--		114		
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Amount_instalment)*100))),19)	Amount_instalment											--		115
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Amount_revolving)*100))),19)	Amount_revolving											--		116
				, Ind_credit_line_duration																														--		117	
				, nat_con_no						
	
	 FROM @OP15 
	 order by cem, prod, con_no
else
	begin
		insert into @OP15_SALIDA
		select 
				  ctry																																						--		1					
				+ book_dt																																					--		2	
				+ intf_dt																																					--		3	
				+ src_id																																					--		4	
				+ cem																																						--		5	
				+ br																																						--		6	
				+ con_sta																																					--		7	
				+ Dlnq_sta																																					--		8	
				+ prod																																						--		9	
				+ (case when open_dt='19000101' then '00000000' else open_dt end) 																																					--		10	
				+ (case when lst_accr_dt='19000101' then '00000000' else lst_accr_dt end) 																																				--		11	
				+ Ident_cli																																					--		12	
				+ cc																																						--		13	
				+ left(con_no+space(20), 20)--con_no + replicate(char(160), 20 - len(con_no)) 																																				--		14	
				+ (case when strt_dt='19000101' then '00000000' else strt_dt end)																																					--		15	
				+ (case when end_dt='19000101' then '00000000' else end_dt end)																																					--		16	
				+ replicate('0',8) --next_rset_rt_dt																														--		17	
				+ replicate(' ',1) --int_pymt_arrs_ind																														--		18	
				+ left(ccy,4)																																				--		19	
				+ ocy_nom_amt_sign																																			--		20	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_nom_amt*10000))),19)																			--		21	
				+ lcy_nom_amt_sign																																			--		22	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_nom_amt*100))),19)																			--		23	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(fcy_lc_amt*10000))),19)																	--		24	
				+ Lcy_reaj_amt_sing																																			--		25	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_reaj_amt*100))),19)																		--		26
				+ Ocy_int_amt_sing																																			--		27	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Ocy_int_amt*10000))),19)																			--		28
				+ Lcy_int_amt_sing																																			--		29	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_int_amt*100))),19)																			--		30
				+ fix_flting_ind																																			--		31	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(int_rt_cod))),4)																				--		32
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt*100000000))),16)																	--		33	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt*100000000))),16)																	--		34	
				+ rt_meth																																					--		35	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt*100000000))),16)																	--		36	
				+ left(replicate('0',5) + pool_rt_cod,5)																													--		37
				+ left(replicate('0',4) + pnlt_rt_cod,4)																													--		38
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt_sprd*100000000))),16)																--		39	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt_sprd*100000000))),16)																--		40	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt_sprd*100000000))),16)																--		41	
				+ aset_liab_ind																																				--		42	
				+ sbif_bal_no_rep_sign																																		--		43	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(sbif_bal_no_rep)*100))),19)															--		44
				+ right(replicate('0',3) + convert(varchar(3),abs(sbif_tipo_tasa)),3)																						--		45
				+ right(replicate('0',2) + convert(varchar(2),abs(sbif_prod_trans)),2)																						--		46
				+ right(replicate('0',1) + convert(varchar(1),abs(sbif_tipo_oper_trans)),1)																					--		47
				+ lcy_fee_amt_sign																																			--		48	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_fee_amt)*100))),19)																--		49
				+ (case when orig_strt_dt='19000101' then '00000000' when  orig_strt_dt='' then '00000000' else right(replicate('0',8) + orig_strt_dt,8) end)				--		50	
				+ (case when nacc_from_dt='19000101' then '00000000' when  nacc_from_dt='' then '00000000' else right(replicate('0',8) + nacc_from_dt,8) end)				--		51	
				+ (case when pdue_from_dt='19000101' then '00000000' when  pdue_from_dt='' then '00000000' else right(replicate('0',8) + pdue_from_dt,8) end)				--		52	
				+ (case when wrof_from_dt='19000101' then '00000000' when  wrof_from_dt='' then '00000000' else right(replicate('0',8) + wrof_from_dt,8) end)				--		53	
				+ orig_con_no																																				--		54	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(abs(no_of_remn_coup)))),4)																	--		55
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(abs(no_of_pdo_coup)))),4)																		--		56
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(abs(no_of_tot_coup)))),4)																		--		57
				+ right(replicate(0,3)+convert(varchar(3),convert(numeric(3),(abs(sbif_dest_coloc)))),3)																	--		58
				+ '00000000'--(case when stop_accr_dt='19000101' then '00000000' else right(replicate('0',8) + stop_accr_dt,8) end)														--		59
				+ (case when lst_int_pymt_dt='19000101' then '00000000' else right(replicate('0',8) + lst_int_pymt_dt,8) end) 												--		60
				+ left(ren_ind,1)																																			--		61	
				+ (case when lst_rset_dt='19000101' then '00000000' when  lst_rset_dt='' then '00000000' else right(replicate('0',8) + lst_rset_dt,8) end) 					--		62	
				+ (case when next_rt_ch_dt='19000101' then '00000000' when  next_rt_ch_dt='' then '00000000' else right(replicate('0',8) + next_rt_ch_dt,8) end) 			--		63	
				+ (case when lst_rt_ch_dt='19000101' then '00000000' when  lst_rt_ch_dt='' then '00000000' else right(replicate('0',8) + lst_rt_ch_dt,8) end) 				--		64	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(ocy_orig_nom_amt)*10000))),19)															--		65
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_avl_bal)*100))),19)															--		66
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo1_amt)*100))),19)															--		67
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo2_amt)*100))),19)															--		68
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Lcy_pdo3_amt)*100))),19)															--		69
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_oper_amt)*100))),19)															--		70
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(loc)*100))),19)															--		71
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_mnpy)*100))),19)														--		72
				+ lgl_actn_ind																																	--		73	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Lcy_mv)*100))),19)															--		74
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Lcy_par_val)*100))),19)													--		75
				+ right(replicate('0',1) + convert(varchar(1),Port_typ),1)																						--		76
				+ right(replicate('0',3) + convert(varchar(3),No_rng),3)																						--		77
				+ right(replicate('0',4) + convert(varchar(4),Pdc_coup),4)																						--		78
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Pgo_amt)*100))),19)														--		79
				+ ' '--con_no_typ																																--		80	
				+ '1'--ope_typ																																	--		81	
				+ left(replicate(' ',2) + mod_entr_bs,2)																										--		82
				+ right(replicate(0,12)+convert(varchar(12),convert(numeric(12),(abs(opc_compra)*100))),12)														--		83
				+ left(ident_instr + replicate(' ',5),5)																										--		84
				+ left(replicate(' ',15) + ident_emi_instr,15)																									--		85
				+ REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(serie_instr)))) + LTRIM(RTRIM(serie_instr))																--		86	
				+ left(replicate(' ',4) + subserie_instr,4)																									    --		87
				+ REPLICATE(' ', 8 - LEN(LTRIM(RTRIM(cat_risk_instr)))) + LTRIM(RTRIM(cat_risk_instr))															--		88	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(limit_rate*100000000))),16)													--		89	
				+ right(replicate(0,4)+convert(varchar(4),(abs(pdc_after_fix_per))),4)																			--		90
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo4_amt)))),19)														--		91
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo5_amt)))),19)														--		92
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo6_amt)))),19)														--		93
				+ sbif_no_rep_ind																																--		94
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Lcy_otr_cont_amt)))),19)													--		95
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo7_amt)))),19)														--		96
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo8_amt)))),19)														--		97
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(lcy_pdo9_amt)))),19)														--		98
				+ convert(varchar(1),assets_origin)																												--		99
				+ (case when first_expiry_dt='19000101' then '00000000' when  first_expiry_dt='' then '00000000' else right(replicate('0',8) + first_expiry_dt,8) end)																																--		100	
				+ tip_otorg																																		--		101	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(price_viv)))),19)															--		102
				+ tip_op_reneg																																	--		103	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(mon_pie_pag_reneg)))),19)													--		104
				+ seg_rem_cred_hip																																--		105	
				+ SUBSTRING('00000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdue_from_oldest),1)))),8) + LTRIM(RTRIM(STR(abs(pdue_from_oldest),8))) 					--		106	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(mon_prev_rng)*100))),19)													--		107
				+ exig_pago																																		--		108	
				+ (case when bidding_dt='19000101' then '00000000' when  bidding_dt='' then '00000000' else right(replicate('0',8) + bidding_dt,8) end)			--		109
				+ (case when loan_disbursement_dt='19000101' then '00000000' when  loan_disbursement_dt='' then '00000000' else right(replicate('0',8) + loan_disbursement_dt,8) end) --		110		
				+ (case when Accounting_dt='19000101' then '00000000' when  Accounting_dt='' then '00000000' else right(replicate('0',8) + Accounting_dt,8) end) --		111	
				+ (case when last_payment_dt='19000101' then '00000000' when  last_payment_dt='' then '00000000' else right(replicate('0',8) + last_payment_dt,8) end)	--		112	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(last_amount_paid)*100))),19)												--		113
				+ (case when credit_line_approved_dt='19000101' then '00000000' when  rtrim(ltrim(credit_line_approved_dt))='' then '00000000' else right(replicate('0',8) + credit_line_approved_dt,8) end) --		114		
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Amount_instalment)*100))),19)												--		115
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(abs(Amount_revolving)*100))),19)												--		116
				+ Ind_credit_line_duration																														--		117	
				+ nat_con_no																																	--		118
				from @OP15
				order by cem, prod, con_no


		select * from @OP15_SALIDA order by len(reg_salida) desc

	end 

END

GO
