USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[OP51]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--OP51 '20210422'
CREATE PROC [dbo].[OP51] (@dFechaProceso DateTime=Null)
AS
BEGIN


--declare @dFechaProceso DateTime
--set  @dFechaProceso ='20210422'
 SET NOCOUNT ON    
    
 DECLARE @VALORX    NUMERIC(19,4)  
 ,  @xx15    NUMERIC(19,4)  
 ,  @nmone    NUMERIC(3)  
 ,  @campo_26   DATETIME  
 ,  @xproducto   NUMERIC(10)  
 ,  @nncup    NUMERIC(5)  
 ,  @nintel    NUMERIC(19,4)  
 ,  @reajustes   NUMERIC(19,4)  
 ,  @cuentaI   CHAR(20)  
 ,  @cuentaR   CHAR(20)  
 ,  @cod_instru   NUMERIC(3)  
 ,  @valor_compra  NUMERIC(19,4)  
 ,  @valor_compra_X  NUMERIC(19,4)  
 ,  @vDolar_obs   NUMERIC(19,4)  
 ,  @nvori    NUMERIC(19,4)  
 ,  @barra    NUMERIC(19)  
 ,  @tip_tasa   CHAR(3)  
 ,  @inst_variable  CHAR(1)  
 ,  @XX     CHAR(3)  
 ,  @crut    NUMERIC(9)  
 ,  @DIG    CHAR(1)  
 ,  @ccmor    CHAR(3)  
 ,  @CCMON    CHAR(2)  
 ,  @var_tasa   CHAR(15)  
 ,  @saldo    NUMERIC(19,4)  
 ,  @saldopeso   NUMERIC(19)  
  
 DECLARE @c     CHAR(1)  
 ,  @c1     CHAR(1)  
 ,  @mascara   CHAR(20)  
 ,  @instrumento  CHAR(12)  
 ,  @codigo    NUMERIC(5)  
 ,  @nominal   NUMERIC(19,4)  
 ,  @tir    NUMERIC(19,4)  
 ,  @taspact   NUMERIC(19,4)  
 ,  @fecvenpact   DATETIME  
 ,  @moneda    NUMERIC(5)  
 ,  @tipoper   CHAR(3)  
 ,  @valinip   NUMERIC(19,4)  
 ,  @valvenp   NUMERIC(19,4)  
 ,  @valcomp   NUMERIC(19,4)  
 ,  @valcomp2   NUMERIC(19,4)  
 ,  @rutcli    NUMERIC(9)  
 ,  @codcli    CHAR(2)  
 ,  @rutemi    NUMERIC(9)  
 ,  @tabla    CHAR(4)  
 ,  @numero    NUMERIC(9)  
 ,  @cuenta    CHAR(20)  
 ,  @tipo_tasa   NUMERIC(1)  
 ,  @tdfecven   DATETIME  
 ,  @tdamort   NUMERIC(19,4)  
 ,  @tdsaldo   NUMERIC(19,4)  
 ,  @inversion   NUMERIC(5)  
 ,  @tipo_cuenta  CHAR(2)  
 ,  @fecha    DATETIME  
 ,  @fecpro    DATETIME  
 ,  @periodo   INT  
 ,  @tdcupon   CHAR(3)  
 ,  @fecvenp   DATETIME  
 ,  @cliente   NUMERIC(9)  
 ,  @estado    NUMERIC(9)  
 ,  @emtipo    CHAR(5)  
 ,  @nmes    CHAR(2)  
 ,  @nmes_a    CHAR(2)  
 ,  @nano    CHAR(4)  
 ,  @cano    CHAR(4)  
 ,  @nNumdocu   NUMERIC(10,0)  
 ,  @nNumoper   NUMERIC(10,0)  
 ,  @fec_comp   DATETIME  
 ,  @CTTAS    CHAR(3)  
 ,  @dias_dife   NUMERIC(6)  
 ,  @tran_perm   CHAR(10)  
 ,  @tirc    NUMERIC(19,4)  
 ,  @DIAS    NUMERIC(19)  
 ,  @sum_capi   NUMERIC(15)  
 ,  @nIntasb   NUMERIC(5)  
 ,  @nIncodigo   NUMERIC(5)  
 ,  @tasa    NUMERIC(19,4)  
 ,  @dfecfmes   DATETIME  
 ,  @dFecFMesProx  DATETIME  
 ,  @acfecprox   DATETIME  
 ,  @fecha_emi   DATETIME  
 ,  @fec_ven   DATETIME  
 ,  @valpres   NUMERIC(19,4)  
 ,  @valdolarant  NUMERIC(19,4)  
 ,  @mto_opc_compra_x NUMERIC(10,2)  
 ,  @mto_opc_compra  FLOAT  
 ,  @valor    NUMERIC(19,4)  
 ,  @interes_or   NUMERIC(19,4)  
 ,  @base    NUMERIC(3)  
 ,  @tasa_int   NUMERIC(20,8)  -- MAP 2016-06-16 NUMERIC(16,8) Monto o tasa   
 ,  @destino   NUMERIC(3)  
 ,  @nomin_en_pesos  NUMERIC(19,4)  
 ,  @cuotas_rmtes  NUMERIC(5)  
 ,  @nombre    CHAR(15)  
 ,  @nomInstr   CHAR(10)  
 ,  @digito    CHAR(1)  
 ,  @valormecado  NUMERIC(19,4)  
 ,  @valormecadopeso NUMERIC(19,4)  
 ,  @tasamercado  NUMERIC(19,4)--> se cambia a 19,4 desde 16,8  
 ,  @codemi    CHAR(1)  
 ,  @c_riesgo   VARCHAR(3)  
 --+++jcamposd CDTCOP  
 ,  @ciclo    NUMERIC(5)  
 --+++jcamposd CDTCOP  
 , @p_transfronterizo  NUMERIC(2)  
 , @t_oper_transfronterizo NUMERIC(1)    

 DECLARE @PrimerDiaMes  CHAR(12)    
 ,  @UltimoDiaMes  CHAR(12)    
 ,  @vTipo_Cambio  NUMERIC(19,4)    
  

  
 
if @dFechaProceso is null  
begin   
 select
    @fecpro    = acfecproc--'20220328'   
 ,  @cliente   = acrutprop  
 ,  @acfecprox   = acfecprox--'20220329' 
 ,  @valdolarant  = dolarObsFinMes  
 FROM BacBonosExtSuda..TEXT_ARC_CTL_DRI with(nolock) 
 WHERE acfecproc = @dFechaProceso
end  
else
begin
 select
    @fecpro       = @dFechaProceso-- acfecproc  
 ,  @cliente	  = acrutprop  
 ,  @acfecprox    = acfecprox  
 ,  @valdolarant  = dolarObsFinMes  
 FROM BacBonosExtSuda..TEXT_ARC_CTL_DRI with(nolock)  
END

 SET  @vDolar_obs   = isnull( (SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = 994 AND Fecha = @fecpro),0)  
 SET  @estado    = (SELECT top 1 emrut FROM BacBonosExtSuda..VIEW_EMISOR with(nolock) WHERE emgeneric = 'EST')  
   
 DECLARE @Fecha_Contable  DATETIME  
  SET @Fecha_Contable  = @fecpro  
    
 IF MONTH(@fecpro) <> MONTH(@acfecprox)  
 BEGIN  
  SET @PrimerDiaMes  = SUBSTRING((CONVERT(CHAR(8), @acfecprox, 112)),1,6)  + '01'    
  SET @UltimoDiaMes  = CONVERT(CHAR(8),CONVERT(DATETIME,DATEADD(DAY, -1, @PrimerDiaMes)), 112)    
  SET @fecpro    = CONVERT(DATETIME, @UltimoDiaMes, 112)  
 END  
    
    
 declare @CARTERA   table
 ( mascara     CHAR(20)       --   1        
 , numdocu     CHAR(12)       --   2    
 , numoper     CHAR(12)       --   3    
 , instrumento    CHAR(20)       --   4    
 , codigo     NUMERIC(5)       --   5    
 , nominal     NUMERIC(19,4)      --   6    
 , tir      NUMERIC(19,4)      --   7    
 , taspact     NUMERIC(19,4) NULL DEFAULT(0) --   8    
 , fecvenpact    CHAR(8)  NULL    --   9    
 , moneda     NUMERIC(5)       --   10    
 , tipoper     CHAR(3)        --   11    
 , valinip     NUMERIC(19,4) NULL DEFAULT(0) --   14    
 , rutcli     NUMERIC(9)       --   15    
 , codcli     CHAR(2)        --   16    
 , rutemi     NUMERIC(9)       --   17    
 , tabla     CHAR(4)        --   18    
 , periodo     INT         --   19    
 , fecvenp     CHAR(8)  NULL    --   20    
 , valpres     NUMERIC(19,4) NULL DEFAULT(0) --   21    
 , valvenp     NUMERIC(19,4) NULL DEFAULT(0) --   22    
 , cuenta     CHAR(20)  NULL DEFAULT('') --   23    
 , fecha_compra   CHAR(8)       --   24    
 , fec_ven     CHAR(8)       --   25    
 , amortizacion   NUMERIC(19,4)      --   26    
 , saldo     NUMERIC(19,4)      --   27    
 , invers     NUMERIC(5)       --   28    
 , cttas     CHAR(3)        --   29    
 , dias_dife    NUMERIC(6)       --   30    
 , tran_perm    CHAR(10)       --   31     
 , tirc     NUMERIC(19,4)      --   32     
 , campo_26    CHAR(8)       --   33      
 , interes     NUMERIC(19,4)      --   34    
 , reajustes    NUMERIC(19,4)      --   35    
 , fecha_emi    CHAR(8)       --   36    
 , valcomp     NUMERIC(19,4) NULL DEFAULT(0) --   37    
 , interes_or    NUMERIC(19,4)      --   38    
 , base     NUMERIC(3)       --   39    
 , tasa_int    NUMERIC(20,8)      --   40    -- MAP 2016-06-16 NUMERIC(16,8) -- monto o tasa ...  
 , destino     NUMERIC(3)       --   41    
 , valormecado    NUMERIC(19,4)      --   42    
 , tasamercado    NUMERIC(19,4) NOT NULL DEFAULT(0) --   43--> se cambia a 19,4 desde 16,8    
 , c_riesgo    VARCHAR(3)       -->  45 --> Riesgo Pais PRD-21996  
 , correla     NUMERIC(9)  identity(1,1)  --   44    
   )    
  
 ---------------------------------------------------------------------------------------------    
 declare  @NEOSOFT    table
 ( codigo_pais    VARCHAR(3)    
 , fecha_contable   CHAR(8)    
 , fecha_interfaz   CHAR(8)    
 , ident_interfaz   VARCHAR(14)    
 , cod_empresa    VARCHAR(3)    
 , cod_sucursal   VARCHAR(3)    
 , status_contrato   VARCHAR(3)    
 , status_crediticio  VARCHAR(1)    
 , fam_producto   CHAR(4)    
 , T_producto    CHAR(4)      --10    
 , C_interno    VARCHAR(16)    
 , Clase_Producto   VARCHAR(1)    
 , Tipologia_producto  VARCHAR(1)    
 , F_operacion    CHAR(8)    
 , F_devengamiento   CHAR(8)    
 , rut      VARCHAR(12)    
 , dig      VARCHAR(1)    
 , costo     VARCHAR(10)    
 , n_operacion    CHAR(20)    
 , fecha_inic    CHAR(8)     --20    
 , fecha_vcto    CHAR(8)    
 , fecha_renovacion  VARCHAR(8)    
 , indicador    VARCHAR(1)    
 , cod_inter_mda   VARCHAR(3)    
 , s_mto_cap_ori   CHAR(1)    
 , mto_cap_origen   NUMERIC(19,4)    
 , s_mto_cap_loc   CHAR(1)    
 , mto_cap_local   NUMERIC(19,4)    
 , mto_linea_credito  NUMERIC(19,4)    
 , s_reaj_mda_loc   CHAR(1)  --30    
 , mto_reaj_loc   NUMERIC(19,4)    
 , s_int_mda_orig   CHAR(1)    
 , mto_int_mda_orig  NUMERIC(19,4)    
 , s_int_mda_loc   CHAR(1)    
 , mto_int_mda_loc   NUMERIC(19,4) --35    
 , tasa_f_v    CHAR(1)    
 , tasa_base    CHAR(4)    
 , tasa_interes   NUMERIC(19,4) --> se cambia a 19,4 desde 16,8   
 , tasa_penalidad   NUMERIC(16,8)    
 , calc_interes   VARCHAR(1) --40    
 , c_operacion    NUMERIC(16,8)    
 , c_fondo_oper   VARCHAR(5)    
 , c_penalidad    VARCHAR(4)    
 , spread     NUMERIC(16,8)    
 , spread_pool    NUMERIC(16,8)    
 , spread_tasa_penalidad NUMERIC(16,8)    
 , indicador_p_a   VARCHAR(1)    
 , s_mto_vencido   VARCHAR(1)    
 , d_vencidas    NUMERIC(18,2)    
 , t_tasa     NUMERIC(3) --50    
 , p_transfronterizo  NUMERIC(2)  
 , t_oper_transfronterizo NUMERIC(1)    
 , s_comision    VARCHAR(1)    
 , mto_comision   NUMERIC(18,2)    
 , fec_otorgamiento  VARCHAR(8)     , fec_cartera    VARCHAR(8)    
 , fec_mora    VARCHAR(8)    
 , fec_cartera_castigada VARCHAR(8)    
 , n_operacion_orig  VARCHAR(20)    
 , n_cuotas    NUMERIC(4) --60    
 , n_cuotas_mora   NUMERIC(4)    
 , n_cuotas_total   NUMERIC(4)    
 , destino     NUMERIC(3)    
 , f_suspension   VARCHAR(8)    
 , f_u_pago    VARCHAR(8)    
 , indicador_renovacion VARCHAR(1)    
 , f_renovacion   VARCHAR(8)    
 , f_cambio    VARCHAR(8)    
 , f_ultimo_cambio   VARCHAR(8)    
 , nomin_en_pesos   NUMERIC(18,2) --70    
 , s_mda_local    NUMERIC(18,2)    
 , m_mora1     NUMERIC(18,2)    
 , m_mora2     NUMERIC(18,2)    
 , m_mora3     NUMERIC(18,2)    
 , colocacion    NUMERIC(18,2)    
 , l_credito    NUMERIC(18,2)    
 , p_minimo    NUMERIC(18,2)    
 , i_cobranza    VARCHAR(1)    
 , v_mercado    NUMERIC(18,2)    
 , v_pesos     NUMERIC(18,2) --80    
 , t_cartera    CHAR(10)    
 , n_renegociacion   NUMERIC(3)    
 , p_cuotas    NUMERIC(4)    
 , m_pagado    NUMERIC(18,2)    
 , t_contrato    VARCHAR(1)    
 , t_operacion    VARCHAR(1)    
 , t_entrega    VARCHAR(1)    
 , mto_op_compra   NUMERIC(19,4)    
 , i_instrumento   VARCHAR(5)    
 , i_emisor    VARCHAR(15) --90    
 , s_instrumento   VARCHAR(4)    
 , s_registrada   VARCHAR(4)    
 , c_riesgo    VARCHAR(3)  
 )  
DECLARE @OP51 TABLE 
(
  ctry					VARCHAR(3)					--		1	
, book_dt				CHAR(8)						--		2	
, intf_dt				CHAR(8)						--		3	
, src_id				VARCHAR(14)					--		4	
, cem					VARCHAR(3)					--		5	
, br					VARCHAR(10)					--		6	
, con_sta				VARCHAR(10)					--		7	
, Dlnq_sta				VARCHAR(1)					--		8	
, prod					VARCHAR(16)					--		9	
, open_dt				CHAR(8)						--		10	
, lst_accr_dt			CHAR(8)						--		11	
, Ident_cli				VARCHAR(12) --20220103	VARCHAR(25)					--		12	
, cc					VARCHAR(10)					--		13	
, con_no				VARCHAR(30)					--		14	
, strt_dt				CHAR(8)						--		15	
, end_dt				CHAR(8)						--		16	
, next_rset_rt_dt		CHAR(8)						--		17	
, int_pymt_arrs_ind		VARCHAR(1)					--		18	
, ccy					CHAR(4)						--		19	
, ocy_nom_amt_sign		VARCHAR(1)					--		20	
, ocy_nom_amt			NUMERIC(19,4)				--		21	
, lcy_nom_amt_sign		VARCHAR(1)					--		22	
, lcy_nom_amt			NUMERIC(19,2)				--		23	
, fcy_lc_amt			NUMERIC(19,4)				--		24	
, Lcy_reaj_amt_sing		VARCHAR(1)					--		25	
, Lcy_reaj_amt			NUMERIC(19,2)				--		26	
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
, orig_con_no				VARCHAR(30)				--		54	
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
, ident_emi_instr			VARCHAR(25)				--		85	
, serie_instr				VARCHAR(4)				--		86	
, subserie_instr			VARCHAR(5)				--		87	
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
, Ind_credit_line_duration	Varchar (1)				--		117	
, nat_con_no				Varchar (4)				--		118	
, dest_finan				Varchar (1)				--		119
, no_post_coup				NUMERIC(3,0)			--		120
, giro						Varchar (2)				--		121
)


Declare @OP51_SALIDA Table ( REG_SALIDA  Varchar(1240))  
    
 INSERT  INTO @CARTERA  
 SELECT TEXT_RSU.cod_nemo  
  , rsnumdocu  
  , rsnumdocu  
  , id_instrum  
  , cod_familia  
  , rsnominal * (rsvpcomp / 100.0)  
  , rstir  
  , 0  
  , ''  
  , rsmonemi -- 10  
  , 'CP'  
  , 0  
  , rsrutcli  
  , ISNULL((SELECT  Cldv FROM BacBonosExtSuda..VIEW_CLIENTE WHERE Clrut = rsrutcli AND Clcodigo = rscodcli),0)  
  , rsrutemis  
  , 'MDCP'  
  , CASE WHEN cod_familia = 2001 THEN DATEDIFF(DAY, TEXT_RSU.rsfeccomp,TEXT_RSU.rsfecvcto)     
     ELSE         ISNULL((SELECT  per_cupones FROM BacBonosExtSuda..TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_RSU.cod_nemo),0)  
    END  
  , rsfecvcto  
  , rsvalcomu  
  , PrincipalDiaPeso -- 20  
  , CtaContable  
  , rsfeccomp  
  , ''  
  , 0  
  , 0  
  , 0  
  , ''  
  , DATEDIFF (DAY ,@fecpro,rsfecvcto)  
  , ISNULL((SELECT ccn_codigo_nuevo FROM BACPARAMSUDA..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = codigo_carterasuper),4)  
  , 0                -- 30  
  , rsfecpcup  
  , rsinteres_acum  
  , 0  
  , rsfecemis  
  , rsvppresen  
  , InteresPesoAcum  
  , rsbasemi  
  , rsinteres  
  , CASE WHEN rsrutcli = 97029000 THEN 211  
     WHEN rsrutcli = 97030000 THEN 212  
     ELSE        221  
    END  
  , rsvalmerc  
  , rstirmerc  
        ,   c_riesgo = BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( rsrutemis, rscodemi, 'BEX' )  
 FROM BacBonosExtSuda..TEXT_RSU  
 ,  BacBonosExtSuda..CARTERA_CUENTA  
 WHERE rsnominal   > 0  
 AND  rsrutcart > 0  
 AND  Correla  = rscorrelativo -- 1  
 AND  NumOper  = rsnumdocu  
 AND  rsfecpro = @fecpro  
 AND  rsfecpago < @fecpro  
 AND  variable = 'valor_compra'  
 AND  t_operacion = 'CP'  
 AND  rstipoper = 'DEV'  
  
 INSERT  INTO @CARTERA  
 SELECT DISTINCT     
   TEXT_CTR_INV.cod_nemo    
  , monumdocu    
  , monumdocu    
  , TEXT_CTR_INV.id_instrum    
  , TEXT_CTR_INV.cod_familia    
  , monominal * (movpar/100.0)    
  , motir    
  , 0    
  , ''    
  , momonemi    
  , 'CP'    
  , 0    
  , morutcli    
  , ISNULL((SELECT cldv FROM BacBonosExtSuda..VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli),0)    
  , morutemi    
  , 'MDCP'    
  , CASE WHEN TEXT_CTR_INV.cod_familia = 2001 THEN DATEDIFF(DAY,mofecpago,mofecven)  
     ELSE            ISNULL((SELECT  per_cupones FROM BacBonosExtSuda..TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_MVT_DRI.cod_nemo),0)  
   END  
  , mofecven    
  , movalcomu    
  , capitalpeso    
  , CtaContable    
  , mofecpro    
  , ''    
  , 0    
  , 0    
  , 0    
  , ''    
  , DATEDIFF(DAY,@fecpro,mofecven)    
  , ISNULL((SELECT ccn_codigo_nuevo FROM BacParamSuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = TEXT_MVT_DRI.codigo_carterasuper),4)    
  , 0    
  , mofecpcup    
  , CASE WHEN TEXT_CTR_INV.cod_familia <> 2001 THEN moint_compra    
     ELSE                         (SELECT rsinteres_acum FROM BacBonosExtSuda..TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV')    
    END    
  , moreajuste    
  , mofecemi    
  , movpresen    
  , interespeso    
  , mobasemi    
  , mointeres    
  , CASE WHEN morutcli = 97029000 THEN 211  
     WHEN morutcli = 97030000 THEN 212  
     ELSE               221  
    END    
  , ISNULL((SELECT rsvalmerc FROM BacBonosExtSuda..TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV'),0)    
  , ISNULL((SELECT rstirmerc FROM BacBonosExtSuda..TEXT_RSU WHERE rsnumoper = monumoper AND rsnumdocu = monumdocu AND rscorrelativo = mocorrelativo AND rscartera = 333 AND rsfecpro = @fecpro AND rstipoper = 'DEV'),0)    
  
  ,       c_riesgo = BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( cprutemi, cpcodemi, 'BEX' )  
 FROM BacBonosExtSuda..TEXT_MVT_DRI    
 ,  BacBonosExtSuda..CARTERA_CUENTA    
 ,  BacBonosExtSuda..TEXT_CTR_INV    
 WHERE monominal     > 0.0    
 AND  morutcart     > 0.0    
 AND  numdocu       = monumdocu    
 AND  Correla       = mocorrelativo    
 AND  NumOper       = monumoper    
 AND  variable      = 'valor_compra'    
 AND  motipoper     = 'CP'    
 AND  mofecpago     = @fecpro    
 AND  mofecpro      = @fecpro    
 AND  mostatreg    <> 'A'    
 AND  cpnumdocu     = monumoper    
 AND  cpcorrelativo = mocorrelativo    
 AND  cpnominal     > 0.0    
  
 INSERT  INTO @CARTERA  
 SELECT cod_nemo  
  , monumdocu  
  , monumdocu  
  , id_instrum  
  , cod_familia  
  , monominal  
  , motir  
  , 0  
  , ''  
  , momonemi  
  , 'VP'  
  , 0  
  , morutcli  
  , ISNULL((SELECT  Cldv        FROM BacBonosExtSuda..VIEW_CLIENTE WHERE Clrut = morutcli AND Clcodigo = mocodcli),0)  
  , morutemi  
  , 'MDCP'  
  , CASE WHEN cod_familia = 2001 THEN DATEDIFF(DAY,mofecpago,mofecven)  
     ELSE        ISNULL((SELECT  per_cupones FROM BacBonosExtSuda..TEXT_SER WHERE TEXT_SER.cod_nemo = TEXT_MVT_DRI.cod_nemo),0)  
    END  
  , mofecven  
  , movalcomu  
  , capitalpeso  
  , CtaContable  
  , mofecpro  
  , ''  
  , 0  
  , 0  
  , 0  
  , ''  
  , DATEDIFF (DAY ,@fecpro,mofecven)  
  , ISNULL((SELECT ccn_codigo_nuevo FROM BacParamSuda.dbo.TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = codigo_carterasuper),4)  
  , 0  
  , mofecpcup  
  , moint_compra  
  , moreajuste  
  , mofecemi  
  , movalcomp  
  , interespeso  
  , mobasemi  
  , mointeres  
  , CASE WHEN morutcli = 97029000 THEN 211  
     WHEN morutcli = 97030000 THEN 212  
     ELSE       221   
    END  
  , 0  
  , 0  
  
                , c_riesgo = BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( morutemi, cod_emi, 'BEX' )  
 FROM BacBonosExtSuda..TEXT_MVT_DRI  
  , BacBonosExtSuda..CARTERA_CUENTA  
 WHERE monominal   > 0  
 AND  morutcart > 0  
 AND  NumDocu  = monumdocu  
 AND  Correla  = mocorrelativo  
 AND  NumOper  = monumoper  
 AND  variable = 'valor_venta'  
 AND  motipoper = 'VP'  
 AND  mofecpago = @fecpro  
 AND  mostatreg  <> 'A'  
  
  
 DECLARE CURSOR_INTER CURSOR FOR     
 SELECT mascara,  instrumento, codigo,      nominal       
  , tir,   taspact,  fecvenpact,     moneda          
  , tipoper,  valinip,  rutcli,      codcli           
  , rutemi,   tabla,   CONVERT(CHAR(9),correla)     ,'1'                
  , periodo,  fecvenp,  valpres,     valvenp      
  , numdocu,  numoper,  cuenta,      fecha_compra      
  , dias_dife,  tran_perm,  campo_26,     interes    
  , reajustes,  fecha_emi,  fec_ven,     valcomp    
  , interes_or,  base,   tasa_int,     destino           
  , valormecado, tasamercado                      
                , c_riesgo  
 FROM @CARTERA
  
 OPEN CURSOR_INTER    
 FETCH NEXT FROM CURSOR_INTER  
 INTO @mascara,  @instrumento, @codigo,     @nominal    
  , @tir,   @taspact,  @fecvenpact,    @moneda    
  , @tipoper,  @valinip,  @rutcli,     @codcli    
  , @rutemi,  @tabla,   @numero,     @c    
  , @periodo,  @fecvenp,  @valpres,     @valvenp    
  , @nNumdocu,  @nNumoper,  @cuenta,     @fec_comp    
  , @dias_dife,  @tran_perm,  @campo_26,     @nintel  
  , @reajustes,  @fecha_emi,  @fec_ven,     @valcomp    
  , @interes_or, @base,   @tasa_int,     @destino    
  , @valormecado, @tasamercado  
       , @c_riesgo  
  
 WHILE @@FETCH_STATUS  = 0  
 BEGIN  
  SET  @nombre  = ISNULL((SELECT  nom_emi  FROM BacBonosExtSuda..text_emi_itl WHERE  rut_emi  = @rutemi),'')    
  SET  @digito  = ISNULL((SELECT  digito_ver FROM BacBonosExtSuda..text_emi_itl WHERE  rut_emi  = @rutemi),'')    
  SET  @nomInstr = ISNULL((SELECT  nom_familia FROM BacBonosExtSuda..TEXT_FML_INM WHERE  cod_familia = @codigo),'')    
  SET  @codemi  = ISNULL((SELECT  emtipo  FROM BacBonosExtSuda..view_emisor WHERE  emrut  = @rutemi),'')    
  
  IF @moneda IN(994, 13)  
  BEGIN    
   SET @nomin_en_pesos  = ROUND(@nominal  * @vDolar_obs, 0)    
   SET @valormecadopeso = ROUND(@valormecado * @vDolar_obs, 0)    
   SET @valcomp   = CASE WHEN @moneda = 13 THEN @valcomp  
           ELSE                   ROUND(@valcomp * @valdolarant,0)  
          END  
  
          -- MAP EMERGENCIA  
   SET @vTipo_Cambio    = ISNULL((SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @fecpro),0)  
  
  END ELSE  
        BEGIN  
   SET @nomin_en_pesos  = ISNULL((@nominal     * (SELECT Tipo_Cambio from BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @Fecha_Contable)),0)  
   SET @valormecadopeso = ISNULL((@valormecado * (SELECT Tipo_Cambio from BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @Fecha_Contable)),0)  
  -- SET @vDolar_obs      = ISNULL((SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @fecpro),0)  
   SET @vTipo_Cambio    = ISNULL((SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @moneda AND Fecha = @fecpro),0)  
  END  
  
  SET @dias           = @dias_dife  
  SET @inst_variable  = 'N'  
  SET @tip_tasa       = '0'  
  
  SELECT @nIntasb = tipo_tasa     
   , @CTTAS  = CASE WHEN tasa_fija = 'F' THEN 'FLO' ELSE 'FIJ' END  
  FROM  BacBonosExtSuda..TEXT_SER  
  WHERE cod_nemo = @MASCARA  
    
  IF @nIntasb > 1  
  BEGIN      
   SELECT @var_tasa  = (SELECT tbglosa FROM BacBonosExtSuda..VIEW_TABLA_GENERAL_DETALLE WHERE TBCODIGO1 = @nIntasb AND TBCATEG = 1042)  
  
   SELECT @inst_variable = 'S'     
    , @tip_tasa  = CASE WHEN @var_tasa = 'LIBOR' OR @var_tasa = ' LIBOR 90' OR @var_tasa = ' LIBOR 30' OR @var_tasa = 'LIBOR 180' THEN '3'     
           WHEN @var_tasa = 'TIP'                       THEN '2'  
           WHEN @var_tasa = 'TAB'  OR @var_tasa = 'TAB 90'  OR @var_tasa = 'TAB 30'  OR @var_tasa = 'TAB 180' THEN '1'  
           ELSE '9'  
          END     
  
   IF DATEDIFF (DAY ,@fecpro, @campo_26 ) < 30        -- cpfecpcup    
    SET @tip_tasa = '2' + @tip_tasa + '1'  
  
   IF DATEDIFF (DAY ,@fecpro, @campo_26 ) >= 30 AND  DATEDIFF (DAY ,@fecpro,@campo_26)< 90    
    SET @tip_tasa = '2' + @tip_tasa + '2'  
  
   IF DATEDIFF (DAY ,@fecpro,@campo_26) >= 90 AND  DATEDIFF (MONTH ,@fecpro,@campo_26) < 6    
    SET @tip_tasa = '2' + @tip_tasa + '3'  
  
   IF DATEDIFF (MONTH ,@fecpro,@fecvenp) >= 6  AND  DATEDIFF (YEAR ,@fecpro,@campo_26) < 1    
    SET @tip_tasa = '2' + @tip_tasa + '4'  
  
   IF DATEDIFF (YEAR ,@fecpro,@campo_26) >= 1  AND  DATEDIFF (YEAR ,@fecpro,@campo_26) < 3    
    SET @tip_tasa = '2' + @tip_tasa + '5'  
  
   IF DATEDIFF (YEAR ,@fecpro,@campo_26) >= 3      
    SET @tip_tasa = '2'  + @tip_tasa + '6'  
  
  END  
  
  IF @inst_variable = 'N'   
  BEGIN -- fija  --N    
   IF @dias < 30     
    SET @tip_tasa =  '101'     
   IF @dias >= 30 AND @dias < 90       
    SET @tip_tasa =  '102'     
   IF @dias >= 90 AND  @dias < 180     
    SET @tip_tasa =  '103'    
   IF @dias >= 180  AND  @dias < 365      
    SET @tip_tasa =  '104'     
   IF @dias >= 365 AND  @dias < 1095   -- DE UN AÑO A MENOS 3 AÑOS    
    SET @tip_tasa =  '105'     
   IF @dias >= 1095     -- MAS DE TRES AÑOS     
    SET @tip_tasa =  '106'    
  END  
  
  IF @codigo = 2001  
   SELECT @tdcupon = ISNULL(CASE WHEN (SELECT COUNT(1) FROM BacBonosExtSuda..text_dsa WHERE  fecha_vcto_cupon > @fecpro AND cod_nemo = @mascara )=0 THEN 1 END,1)  
  ELSE  
   SELECT @tdcupon = isnull((SELECT COUNT(1) FROM BacBonosExtSuda..text_dsa WHERE  fecha_vcto_cupon > @fecpro AND cod_nemo = @mascara ),0)  
  
  IF @tdcupon > 0  
  BEGIN  
   SELECT @cuotas_rmtes = 1  
  END  
  
  SELECT @nncup = convert(numeric(4),@tdcupon)  
  
  
 SET @p_transfronterizo=0

 SET @p_transfronterizo=(SELECT  Tabla.Transfronterizo FROM bacbonosextsuda..Tbl_Clasificacion_Instrumento Clasificacion  
    inner join ( select IdAgencia  
         , Id  
         , CortoPlazo  
         , LargoPlazo  
         , Transfronterizo  
        from BacParamSuda.dbo.Clasificaciones_Agencia   
       ) Tabla ON Tabla.IdAgencia  = Clasificacion.Agencia  
          and Tabla.LargoPlazo = Clasificacion.Clasificacion  
  WHERE Clasificacion.Nemo = @mascara)  

  SET @p_transfronterizo=ISNULL(@p_transfronterizo,0)



 SET @t_oper_transfronterizo=1

  INSERT INTO @NEOSOFT     
  VALUES    
/*01*/ ( 'CL'  
  , convert(char(08),@fecha_Contable,112)	    
  , convert(char(08),@fecha_Contable,112) -- GETDATE()    
  , 'OP51'    
  , '001'    
  , '1'    
  , 'A'    
  , SPACE(1)    
  , 'MD01'    
/*10*/ , 'MD01'--'MDIR'     
  , 'MD01'    
  , SPACE(1)    
  , 'M'    
  , convert(char(08),@fec_comp,112)    
  , convert(char(08),@fecpro,112)      
  , CONVERT(VARCHAR(9),@rutemi)    
  , CONVERT(VARCHAR(1),@digito)    
  , SPACE(1)    
  , CAST(@nNumdocu AS VARCHAR(5)) + CAST(1 AS VARCHAR(2)) + cast(@nNumoper AS VARCHAR(5))    
/*20*/ , convert(char(08),@fec_comp,112)       
  ,  convert(char(08),@fecvenp,112)     
  , SPACE(8)    
  , 'V'    
  , @moneda    
  , CASE WHEN @valpres < 0 THEN '-' ELSE  '+' END    
  , ABS(@valpres)    
  , CASE WHEN @valvenp < 0 THEN '-' ELSE  '+' END    
 -- , ABS(@valpres * @vDolar_obs)     
  , CASE WHEN @moneda IN (994,13) THEN ABS(@valpres * @vDolar_obs)     
     ELSE ABS(@valpres * @vTipo_Cambio)   
    END  --ABS(@valvenp) Contingencia Rastrear origen de datos incongruencia en estos.     
  , 0    
/*30*/ , CASE WHEN @reajustes < 0 THEN '-' ELSE  '+' END     
  , ABS(@reajustes)    
  , CASE WHEN @nintel < 0 THEN '-' ELSE  '+' END    
  , ABS(@nintel)    
  , CASE WHEN @interes_or < 0 THEN '-' ELSE  '+' END    
  --+++jcamposd 20180418 COLTES para la colocación debe informar intereses en moneda local  
  --, ABS(@interes_or)    
  , CASE WHEN ABS(@interes_or)  = 0 THEN ABS(@nintel * @vTipo_Cambio) ELSE  ABS(@interes_or) END     
  -----jcamposd 20180418 COLTES para la colocación debe informar intereses en moneda local    
  , CASE WHEN @CTTAS = 'FLO' THEN 'V' ELSE  'F' END    
  , @base    
  , @tir    
  , 0    
/*40*/ , (CASE WHEN @moneda = 998 THEN 1    
     WHEN @moneda IN(13,129) THEN 3  --COLTES jcamposd, se suma moneda COL  
     WHEN @moneda = 999 THEN 4    
     ELSE 0   
    END)    
  , 0  
  , 0  
  , 0  
  , 0  
  , 0  
  , @tasamercado  
  , CASE WHEN @tipoper = 'CP' THEN 'A' ELSE  'P' END  
  , '+'  
  , 0  
/*50*/ , @tip_tasa  
  , @p_transfronterizo-- BacBonosExtSuda.dbo.Fx_Load_Transfronterizo(@mascara, 1) -->  51 ( Producto Transfronterizo )  
  , @t_oper_transfronterizo-- BacBonosExtSuda.dbo.Fx_Load_Transfronterizo(@mascara, 2) -->  52 ( Tipo de Operacion Transfronterizo )  
  , '+'  
  , 0  
  , SPACE(8)  
  , SPACE(8)  
  , SPACE(8)  
  , SPACE(8)  
  , ' '  
  , @tdcupon  
  , 0  
  , @tdcupon  
  , @destino  
  , SPACE(8)  
  , SPACE(8)  
  , SPACE(1)  
  , SPACE(8)  
  , SPACE(8)  
  , SPACE(8)  
  , @nominal  
  , 0  
  , 0  
  , 0  
  , 0  
  , case when @fec_comp = @fecpro THEN @valpres ELSE  0 END  
  , 0  
  , 0  
  , SPACE(1)  
  , @valormecadopeso  
  , @nomin_en_pesos  
  , @tran_perm  
  , 0  
  , @periodo  
  , 0  
  , '1'  
  , SPACE(1)  
  , SPACE(1)  
    , CASE WHEN @nomInstr <> 'CDTCOP' THEN @valcomp ELSE 0 END  
  /* 20090305 - Cambio solicitado por Margarita Salas    
      Para la Familia BONEX colocar en el campo 88 lo siguiente:    
      Si el BONEX es Federal o Soberano identificarlo como 'BS'.    
      Si el BONEX es Empresa e Instituciones Financieras  identificarlo como 'BE'.     
      Para la familia DPEX identificar en el campo 88 de la interfaz como 'DPX'     
      Para las Familias CD y NOTEX dejar como el sistema lo identifica , es decir    
      rescatar los 5 caracteres.     
  */  
  -- Ahora    
  , CASE WHEN @codigo = 2000 and (@codemi = 1 or @codemi = 2) THEN 'BE   '  
     WHEN @codigo = 2000 and (@codemi = 3 or @codemi = 4) THEN 'BS   '  
     WHEN @codigo = 2003          THEN 'DPX  '  
     ELSE               SUBSTRING(@nomInstr,1,5)  
    END  
  -- Antes    
  /*    
  , CASE WHEN @codemi =1  AND @codigo <> 2001 THEN 'BE   '    
     WHEN @codemi =3  AND @codigo <> 2001 THEN 'BS   '    
     ELSE          SUBSTRING(@nomInstr,1,5) END      
  */    
  , @nombre  
  , SPACE(4)  
  , SPACE(4)  
                , @c_riesgo  --> SPACE(3)  
  )  
  FETCH NEXT FROM CURSOR_INTER  
  INTO @mascara  , @instrumento , @codigo  , @nominal    
  ,  @tir   , @taspact  , @fecvenpact , @moneda    
  ,  @tipoper  , @valinip  , @rutcli  , @codcli    
  ,  @rutemi   , @tabla  , @numero  , @c    
  ,  @periodo  , @fecvenp  , @valpres  , @valvenp    
  ,  @nNumdocu  , @nNumoper  , @cuenta  , @fec_comp    
  ,  @dias_dife  , @tran_perm , @campo_26  , @nintel    
  ,  @reajustes  , @fecha_emi , @fec_ven  , @valcomp    
  ,  @interes_or  , @base   , @tasa_int  , @destino    
  ,  @valormecado , @tasamercado    
  ,  @c_riesgo  
 END    
  
 CLOSE CURSOR_INTER    
 DEALLOCATE  CURSOR_INTER    



 INSERT INTO @OP51
 SELECT 
	codigo_pais																				as ctry					--		1				
  , convert(char(08),fecha_contable,112)													AS book_dt				--		2
  , fecha_interfaz																			AS intf_dt				--		3
  , ident_interfaz																			AS src_id				--		4
  , cod_empresa																				AS cem					--		5
  , cod_sucursal																			AS br					--		6
  , status_contrato																			AS con_sta				--		7
  , status_crediticio																		AS Dlnq_sta				--		8
  , fam_producto																			AS prod					--		9
  , F_operacion																				as open_dt				--		10
  , F_devengamiento																			as lst_accr_dt			--		11
  , rut+dig																					as Ident_cli			--		12
  , costo																					as cc					--		13
  , n_operacion																				AS con_no				--		14
  , fecha_inic																				as strt_dt				--		15
  , fecha_vcto																				as end_dt				--		16
  , fecha_renovacion																		as next_rset_rt_dt		--		17
  , indicador																				as int_pymt_arrs_ind	--		18
  , cod_inter_mda																			AS ccy					--		19
  , s_mto_cap_ori																			as ocy_nom_amt_sign		--		20
  , mto_cap_origen																			as ocy_nom_amt			--		21
  , s_mto_cap_loc																			as lcy_nom_amt_sign		--		22
  , mto_cap_local																			as lcy_nom_amt			--		23
  , mto_linea_credito																		as fcy_lc_amt			--		24
  , s_reaj_mda_loc																			as Lcy_reaj_amt_sing	--		25
  , mto_reaj_loc																			as Lcy_reaj_amt			--		26
  , s_int_mda_orig																			as Ocy_int_amt_sing		--		27
  , mto_int_mda_orig																		as Ocy_int_amt			--		28
  , s_int_mda_loc																			as Lcy_int_amt_sing		--		29
  , mto_int_mda_loc																			as Lcy_int_amt			--		30
  ,	tasa_f_v																				AS fix_flting_ind		--		31
  , tasa_base																				as int_rt_cod			--		32
  , tasa_interes																			as int_rt				--		33
  , tasa_penalidad																			as pnlt_rt				--		34
  , calc_interes																			as rt_meth				--		35
  , c_operacion																				as pool_rt				--		36
  , c_fondo_oper																			AS pool_rt_cod			--		37
  , c_penalidad  																			AS pnlt_rt_cod			--		38
  , spread																					AS int_rt_sprd			--		39
  , spread_pool																				as pool_rt_sprd			--		40
  , spread_tasa_penalidad																	as pnlt_rt_sprd			--		41
  , indicador_p_a																			as aset_liab_ind		--		42
  , s_mto_vencido																			as sbif_bal_no_rep_sign	--		43
  , d_vencidas																				as sbif_bal_no_rep		--		44
  , t_tasa																					as sbif_tipo_tasa		--		45
  , p_transfronterizo																		as sbif_prod_trans		--		46
  , t_oper_transfronterizo																	as sbif_tipo_oper_trans	--		47
  , s_comision																				as lcy_fee_amt_sign		--		48
  , mto_comision																			as lcy_fee_amt			--		49
  , fec_otorgamiento																		as orig_strt_dt			--		50
  , fec_cartera																				as nacc_from_dt			--		51
  , fec_mora																				as pdue_from_dt			--		52
  , fec_cartera_castigada																	as wrof_from_dt			--		53
  , n_operacion_orig																		as orig_con_no			--		54
  , n_cuotas																				as no_of_remn_coup		--		55
  , n_cuotas_mora																			as no_of_pdo_coup		--		56
  , n_cuotas_total																			as no_of_tot_coup		--		57
  , destino																					as sbif_dest_coloc		--		58	
  , f_suspension																			as stop_accr_dt			--		59	
  , f_u_pago																				as lst_int_pymt_dt		--		60
  , indicador_renovacion																	as ren_ind				--		61	
  , f_renovacion																			as lst_rset_dt			--		62	
  , f_cambio																				as next_rt_ch_dt		--		63	
  , f_ultimo_cambio																			as lst_rt_ch_dt			--		64	
  , nomin_en_pesos																			as ocy_orig_nom_amt		--		65	
  , s_mda_local																				as lcy_avl_bal			--		66	
  , m_mora1																					as lcy_pdo1_amt			--		67	
  , m_mora2																					as lcy_pdo2_amt			--		68	
  , m_mora3																					as Lcy_pdo3_amt			--		69	
  , colocacion																				as lcy_oper_amt			--		70	
  , l_credito																				as loc					--		71	
  , p_minimo																				as lcy_mnpy				--		72	
  , i_cobranza																				as lgl_actn_ind			--		73	
  , v_mercado																				as Lcy_mv				--		74
  , v_pesos																					as Lcy_par_val			--		75
  , t_cartera																				as Port_typ				--		76
  , n_renegociacion																			as No_rng				--		77
  , p_cuotas																				as Pdc_coup				--		78
  , m_pagado																				as Pgo_amt				--		79
  , t_contrato																				as con_no_typ			--		80
  , t_operacion																				as ope_typ				--		81
  , t_entrega																				as mod_entr_bs			--		82
  , mto_op_compra																			AS opc_compra			--		83
  , i_instrumento																			AS ident_instr			--		84
  , i_emisor																				as ident_emi_instr	  	--		85
  , s_instrumento																			AS serie_instr			--		86
  , s_registrada																			AS subserie_instr		--		87
  , c_riesgo																				AS cat_risk_instr		--		88
	,		0															as			limit_rate						--		89	
	,		0															as			pdc_after_fix_per				--		90		
	,		0															as			lcy_pdo4_amt					--		91	
	,		0															as			lcy_pdo5_amt					--		92	
	,		0															as			lcy_pdo6_amt					--		93	
	,		'S'															as			sbif_no_rep_ind 				--		94	
	,		0															as			Lcy_otr_cont_amt				--		95	
	,		0															as			lcy_pdo7_amt 					--		96	
	,		0															as			lcy_pdo8_amt 					--		97	
	,		0															as			lcy_pdo9_amt 					--		98	
	,		0															as			assets_origin					--		99	
	,		''															as			first_expiry_dt					--		100	
	,		''															as			tip_otorg						--		101	
	,		0															as			price_viv						--		102	
	,		''															as			tip_op_reneg					--		103	
	,		0															as			mon_pie_pag_reneg				--		104	
	,		''															as			seg_rem_cred_hip				--		105	
	,		0															as			pdue_from_oldest    			--		106	
	,		0															as			mon_prev_rng					--		107	
	,		''															as			exig_pago						--		108	
	,		''															as			bidding_dt						--		109	
	,		''															as			loan_disbursement_dt			--		110	
	,		convert(char(08),fecha_interfaz,112)						as			Accounting_dt					--		111	
	,		''															as			last_payment_dt					--		112	
	,		0															as			last_amount_paid				--		113	
	,		''															as			credit_line_approved_dt			--		114	
	,		0															as			Amount_instalment				--		115	
	,		0															as			Amount_revolving				--		116	
	,      ''															as			Ind_credit_line_duration		--		117	
	,	   ''															as			nat_con_no						--		118	
	,	   ''															as			dest_finan						--		119
	,	   0															as			no_post_coup					--		120
	,	   ''															as			giro							--		121
         FROM @NEOSOFT  
          


 Declare @TipoSalida bit = 0

if @TipoSalida != 0
	SELECT 
				  convert(char(03),ctry)				AS ctry--20220214 ctry																																						--		1					
				, convert(char(08),book_dt,112)			AS book_dt																																			--		2	
				, convert(char(08),intf_dt,112)			AS intf_dt																																			--		3	
				, convert(char(14),src_id)				AS src_id--20220214 src_id																																					--		4	
				, convert(char(3),cem)					AS cem--20220214 cem																																						--		5	
				, convert(char(4),br)					AS br--20220214 br																																						--		6	
				, convert(char(3),con_sta)				AS con_sta--20220214 con_sta																																					--		7	
				, convert(char(1),Dlnq_sta)				AS Dlnq_sta--20220214 Dlnq_sta																																					--		8	
				, convert(char(16),prod)				AS prod--20220214 prod																																						--		9	
				, CASE WHEN open_dt		= '19000101' THEN '00000000'  when  open_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),open_dt,112)	END	as open_dt--convert(char(8),open_dt)--20220214 open_dt																																					--		10	
				, CASE WHEN lst_accr_dt		= '19000101' THEN '00000000'  when  lst_accr_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_accr_dt,112)	END	as lst_accr_dt--convert(char(8),lst_accr_dt)--20220214 lst_accr_dt																																				--		11	
				, convert(char(12),Ident_cli)			AS Ident_cli--20220214 Ident_cli																																					--		12	
				, convert(char(10),cc)					AS CC--20220214 cc																																						--		13	
				, left(con_no+space(20), 20)				AS con_no--20220214 con_no																																					--		14	
				, CASE WHEN strt_dt		= '19000101' THEN '00000000'  when  strt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),strt_dt,112)	END	as strt_dt--convert(char(8),strt_dt)--20220214 strt_dt																																					--		15	
				, CASE WHEN end_dt		= '19000101' THEN '00000000'  when  end_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),end_dt,112)	END	as end_dt--convert(char(8),end_dt)--20220214 end_dt																																					--		16	
				, CASE WHEN next_rset_rt_dt		= '19000101' THEN '00000000'  when  next_rset_rt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rset_rt_dt,112)	END	as next_rset_rt_dt--convert(char(8),next_rset_rt_dt)--20220214 next_rset_rt_dt																																			--		17	
				, convert(char(1),int_pymt_arrs_ind)	AS int_pymt_arrs_ind--20220214 int_pymt_arrs_ind																																			--		18	
				, left(ccy,4)							AS ccy																--		19	
				, convert(char(1),ocy_nom_amt_sign)		AS ocy_nom_amt_sign--20220214 ocy_nom_amt_sign																																			--		20	
			
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_nom_amt*10000))),19) AS ocy_nom_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(ocy_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(ocy_nom_amt),19)))  							--		21	
				, convert(char(1),lcy_nom_amt_sign)	AS lcy_nom_amt_sign--20220214 lcy_nom_amt_sign																																			--		22	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_nom_amt*100))),19) AS lcy_nom_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_nom_amt),19)))  							--		23	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(fcy_lc_amt*10000))),19) AS fcy_lc_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(fcy_lc_amt),19)))),19) + LTRIM(RTRIM(STR(abs(fcy_lc_amt),19)))  							--		24	
				, convert(char(1),Lcy_reaj_amt_sing) AS Lcy_reaj_amt_sing--20220214 Lcy_reaj_amt_sing																																			--		25	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_reaj_amt*100))),19) AS Lcy_reaj_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_reaj_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_reaj_amt),19)))  						--		26			
				, convert(char(1),Ocy_int_amt_sing) AS Ocy_int_amt_sing--20220214 Ocy_int_amt_sing																																			--		27	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Ocy_int_amt*10000))),19) AS Ocy_int_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Ocy_int_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Ocy_int_amt),19)))  							--		28		
				, convert(char(1),Lcy_int_amt_sing)AS Lcy_int_amt_sing--20220214 Lcy_int_amt_sing																																			--		29	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_int_amt*100))),19) AS Lcy_int_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_int_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_int_amt),19)))  							--		30					

				, convert(char(2),fix_flting_ind) AS fix_flting_ind--20220214 fix_flting_ind																																			--		31	
				, REPLICATE('0', 4 - DATALENGTH(LTRIM(RTRIM(STR(int_rt_cod))))) + LTRIM(RTRIM(STR(int_rt_cod)))		AS int_rt_cod														--		32	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt*100000000))),16)AS int_rt--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(int_rt),16)))),16) + LTRIM(RTRIM(STR(abs(int_rt),16)))  										--		33		
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt*100000000))),16)AS pnlt_rt--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pnlt_rt),16)))),16) + LTRIM(RTRIM(STR(abs(pnlt_rt),16)))  									--		34				
				, convert(char(1),rt_meth) AS rt_meth--20220214 rt_meth																																					--		35	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt*100000000))),16) AS pool_rt--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pool_rt),16)))),16) + LTRIM(RTRIM(STR(abs(pool_rt),16)))  									--		36						
				, REPLICATE('0', 5 - DATALENGTH(LTRIM(RTRIM(STR(pool_rt_cod))))) + LTRIM(RTRIM(STR(pool_rt_cod)))	AS pool_rt_cod														--		37	
				, REPLICATE('0', 4 - DATALENGTH(LTRIM(RTRIM(STR(pnlt_rt_cod))))) + LTRIM(RTRIM(STR(pnlt_rt_cod)))		AS pnlt_rt_cod													--		38	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt_sprd*100000000))),16) AS int_rt_sprd--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(int_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(int_rt_sprd),16)))  							--		39	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt_sprd*100000000))),16) AS pool_rt_sprd--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pool_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(pool_rt_sprd),16)))  							--		40	

				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt_sprd*100000000))),16) AS pnlt_rt_sprd--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pnlt_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(pnlt_rt_sprd),16)))  							--		41	
				, convert(char(1),aset_liab_ind) AS aset_liab_ind--20220214 aset_liab_ind																																				--		42	
				, convert(char(1),sbif_bal_no_rep_sign) AS sbif_bal_no_rep_sign--20220214 sbif_bal_no_rep_sign																																		--		43	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(sbif_bal_no_rep*100))),19) AS sbif_bal_no_rep--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_bal_no_rep),19)))),19) + LTRIM(RTRIM(STR(abs(sbif_bal_no_rep),19)))  					--		44							
				, right(replicate(0,3)+convert(varchar(3),convert(numeric(3),(sbif_tipo_tasa*1))),3) AS sbif_tipo_tasa--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_tipo_tasa),3)))),3) + LTRIM(RTRIM(STR(abs(sbif_tipo_tasa),3)))  										--		45	
				, right(replicate(0,2)+convert(varchar(2),convert(numeric(2),(sbif_prod_trans*1))),2) AS sbif_prod_trans--20220214 SUBSTRING('00',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_prod_trans),2)))),2) + LTRIM(RTRIM(STR(abs(sbif_prod_trans),2)))  										--		46	
				, right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(sbif_tipo_oper_trans*1))),1)AS sbif_tipo_oper_trans--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_tipo_oper_trans),1)))),1) + LTRIM(RTRIM(STR(abs(sbif_tipo_oper_trans),1)))  							--		47	
				, convert(char(1),lcy_fee_amt_sign) AS lcy_fee_amt_sign--20220214 lcy_fee_amt_sign																																			--		48	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_fee_amt*100))),19) AS lcy_fee_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_fee_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_fee_amt),19)))  							--		49							
				, CASE WHEN orig_strt_dt		= '19000101' THEN '00000000'  when  orig_strt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),orig_strt_dt,112)	END	as orig_strt_dt--convert(char(8),orig_strt_dt)--20220214 orig_strt_dt																																				--		50	
				, CASE WHEN nacc_from_dt		= '19000101' THEN '00000000'  when  nacc_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),nacc_from_dt,112)	END	as nacc_from_dt--convert(char(8),nacc_from_dt)--20220214 nacc_from_dt																																				--		51	
				, CASE WHEN pdue_from_dt		= '19000101' THEN '00000000'  when  pdue_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),pdue_from_dt,112)	END	as pdue_from_dt--convert(char(8),pdue_from_dt)--20220214 pdue_from_dt																																				--		52	
				, CASE WHEN wrof_from_dt		= '19000101' THEN '00000000'  when  wrof_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),wrof_from_dt,112)	END	as wrof_from_dt --convert(char(8),wrof_from_dt)--20220214 wrof_from_dt																																				--		53	
				, convert(char(20),orig_con_no) AS orig_con_no--20220214 orig_con_no																																				--		54	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_remn_coup*1))),4) AS no_of_remn_coup--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_remn_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_remn_coup),4)))  									--		55	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_pdo_coup*1))),4) AS no_of_pdo_coup--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_pdo_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_pdo_coup),4)))  										--		56	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_tot_coup*1))),4) AS no_of_tot_coup--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_tot_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_tot_coup),4)))  										--		57	
				, right(replicate(0,3)+convert(varchar(3),convert(numeric(4),(sbif_dest_coloc*1))),3) AS sbif_dest_coloc--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_dest_coloc),3)))),3) + LTRIM(RTRIM(STR(abs(sbif_dest_coloc),3)))  									--		58		
				, CASE WHEN stop_accr_dt		= '19000101' THEN '00000000'  when  stop_accr_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),stop_accr_dt,112)	END	as stop_accr_dt -- convert(char(8),stop_accr_dt)--20220214 stop_accr_dt																																				--		59	
				, CASE WHEN lst_int_pymt_dt		= '19000101' THEN '00000000'  when  lst_int_pymt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_int_pymt_dt,112)	END	as lst_int_pymt_dt--convert(char(8),lst_int_pymt_dt)--20220214 lst_int_pymt_dt																																			--		60	

				, convert(char(1),ren_ind) AS ren_ind--20220214 ren_ind																																					--		61	
				,  CASE WHEN lst_rset_dt		= '19000101' THEN '00000000'  when  lst_rset_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rset_dt,112)	END	as lst_rset_dt--convert(char(8),lst_rset_dt)--20220214 lst_rset_dt																																				--		62	
				,  CASE WHEN next_rt_ch_dt		= '19000101' THEN '00000000'  when  next_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rt_ch_dt,112)	END	as next_rt_ch_dt--convert(char(8),next_rt_ch_dt)--20220214 next_rt_ch_dt																																				--		63	
				,  CASE WHEN lst_rt_ch_dt		= '19000101' THEN '00000000'  when  lst_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rt_ch_dt,112)	END	as lst_rt_ch_dt --convert(char(8),lst_rt_ch_dt)--20220214 lst_rt_ch_dt																																				--		64	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_orig_nom_amt*10000))),19) AS ocy_orig_nom_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(ocy_orig_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(ocy_orig_nom_amt),19)))  	--		65										
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_avl_bal*100))),19) AS lcy_avl_bal--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_avl_bal),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_avl_bal),19)))  				--		66							
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo1_amt*100))),19)AS lcy_pdo1_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo1_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo1_amt),19)))  			--		67								
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo2_amt*100))),19) AS lcy_pdo2_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo2_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo2_amt),19)))  			--		68								
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_pdo3_amt*100))),19) AS Lcy_pdo3_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_pdo3_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_pdo3_amt),19)))  			--		69								
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_oper_amt*100))),19) AS lcy_oper_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_oper_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_oper_amt),19)))  			--		70												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(loc*100))),19) AS loc--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(loc),19)))),19) + LTRIM(RTRIM(STR(abs(loc),19)))  								--		71			
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_mnpy*100))),19) AS lcy_mnpy--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_mnpy),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_mnpy),19)))  					--		72						

				, convert(char(1),lgl_actn_ind) AS lgl_actn_ind--20220214 lgl_actn_ind																																	--		73	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_mv*100))),19) AS Lcy_mv--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_mv),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_mv),19)))  						--		74					
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_par_val*100))),19) AS Lcy_par_val--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_par_val),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_par_val),19)))  				--		75										
				, right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(Port_typ*1))),1) AS Port_typ--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(Port_typ),1)))),1) + LTRIM(RTRIM(STR(abs(Port_typ),1)))  										--		76	
				, right(replicate(0,3)+convert(varchar(3),convert(numeric(3),(No_rng*1))),3) AS No_rng--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(No_rng),3)))),3) + LTRIM(RTRIM(STR(abs(No_rng),3))) 											--		77	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(Pdc_coup*1))),4) AS Pdc_coup--20220214 REPLICATE('0', 4 - LEN(Pdc_coup)) + CAST(Pdc_coup AS varchar)																					--		78	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Pgo_amt*100))),19) AS Pgo_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Pgo_amt),1)))),19) + LTRIM(RTRIM(STR(abs(Pgo_amt),19))) 						--		79	
				, convert(char(1),con_no_typ) AS con_no_typ--20220214 con_no_typ																																	--		80	
				, convert(char(1),ope_typ) AS ope_typ--20220214 ope_typ																																		--		81	

				, REPLICATE(' ', 2 - DATALENGTH(LTRIM(RTRIM(STR(mod_entr_bs))))) + LTRIM(RTRIM(STR(mod_entr_bs))) AS mod_entr_bs												--		82	
				, right(replicate(0,12)+convert(varchar(12),convert(numeric(12),(opc_compra*100))),12) AS opc_compra--20220214 SUBSTRING('000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(opc_compra),1)))),12) + LTRIM(RTRIM(STR(abs(opc_compra),12))) 						--		83	
				, REPLICATE(' ', 5 - LEN(LTRIM(RTRIM(ident_instr)))) + LTRIM(RTRIM(ident_instr))	 AS ident_instr															--		84	
				, REPLICATE(' ', 15 - DATALENGTH(LTRIM(RTRIM(ident_emi_instr)))) + LTRIM(RTRIM(ident_emi_instr))	 AS ident_emi_instr											--		85	--20220214 25
				, REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(serie_instr)))) + LTRIM(RTRIM(serie_instr))	AS serie_instr															--		86	
				, REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(subserie_instr)))) + LTRIM(RTRIM(subserie_instr))		AS subserie_instr													--		87	--20220214 2
				, REPLICATE(' ', 8 - LEN(LTRIM(RTRIM(cat_risk_instr)))) + LTRIM(RTRIM(cat_risk_instr))		AS cat_risk_instr	
																--		88	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(limit_rate*100000000))),16) AS limit_rate--20220214 SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(limit_rate),1)))),16) + LTRIM(RTRIM(STR(abs(limit_rate),16)))						--		89	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(pdc_after_fix_per*1))),4) AS pdc_after_fix_per--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdc_after_fix_per),1)))),4) + LTRIM(RTRIM(STR(abs(pdc_after_fix_per),4))) 					--		90	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo4_amt*1))),19) AS lcy_pdo4_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo4_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo4_amt),19)))  			--		91												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo5_amt*1))),19) AS lcy_pdo5_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo5_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo5_amt),19)))  			--		92												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo6_amt*1))),19) AS lcy_pdo6_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo6_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo6_amt),19)))  			--		93												
				, convert(char(1),sbif_no_rep_ind) AS sbif_no_rep_ind--20220214 sbif_no_rep_ind																																--		94

				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_otr_cont_amt*1))),19) AS Lcy_otr_cont_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_otr_cont_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_otr_cont_amt),19)))  	--		95														
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo7_amt*1))),19) AS lcy_pdo7_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo7_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo7_amt),19)))  			--		96												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo8_amt*1))),19) AS lcy_pdo8_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo8_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo8_amt),19)))  			--		97												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo9_amt*1))),19) AS lcy_pdo9_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo9_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo9_amt),19)))  			--		98															
				, right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(assets_origin*1))),1) AS assets_origin--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(assets_origin),1)))),1) + LTRIM(RTRIM(STR(abs(assets_origin),1)))  								--		99		
				, CASE WHEN first_expiry_dt		= '19000101' THEN '00000000'  when  first_expiry_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),first_expiry_dt,112)	END	as first_expiry_dt--convert(char(8),first_expiry_dt)--20220214 first_expiry_dt																																--		100	
				, convert(char(1),tip_otorg) AS tip_otorg--20220214 tip_otorg																																		--		101	

				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(price_viv*1))),19) AS price_viv--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(price_viv),19)))),19) + LTRIM(RTRIM(STR(abs(price_viv),19)))  					--		102																	
				, convert(char(1),tip_op_reneg) AS tip_op_reneg--20220214 tip_op_reneg																																	--		103	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(mon_pie_pag_reneg*1))),19) AS mon_pie_pag_reneg--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(mon_pie_pag_reneg),19)))),19) + LTRIM(RTRIM(STR(abs(mon_pie_pag_reneg),19)))  	--		104																								
				, convert(char(1),seg_rem_cred_hip) AS seg_rem_cred_hip--20220214 seg_rem_cred_hip																																--		105	
				, right(replicate(0,8)+convert(varchar(8),convert(numeric(8),(pdue_from_oldest*1))),8) AS pdue_from_oldest--20220214 SUBSTRING('00000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdue_from_oldest),1)))),8) + LTRIM(RTRIM(STR(abs(pdue_from_oldest),8))) 					--		106	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(mon_prev_rng*100))),19) AS mon_prev_rng--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(mon_prev_rng),19)))),19) + LTRIM(RTRIM(STR(abs(mon_prev_rng),19)))  			--		107																		
				, convert(char(1),exig_pago) AS exig_pago--20220214 exig_pago																																		--		108	
				,  CASE WHEN bidding_dt		= '19000101' THEN '00000000'  when  bidding_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),bidding_dt,112)	END	as bidding_dt--convert(char(8),bidding_dt)--20220214 bidding_dt																																	--		109
				,  CASE WHEN loan_disbursement_dt		= '19000101' THEN '00000000'  when  loan_disbursement_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),loan_disbursement_dt,112)	END	as loan_disbursement_dt-- convert(char(8),loan_disbursement_dt)--20220214 loan_disbursement_dt																															--		110		
				,  CASE WHEN Accounting_dt		= '19000101' THEN '00000000'  when  Accounting_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),Accounting_dt,112)	END	as Accounting_dt--convert(char(8),Accounting_dt)--20220214 Accounting_dt																																	--		111	
				,  CASE WHEN last_payment_dt		= '19000101' THEN '00000000'  when  last_payment_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),last_payment_dt,112)	END	as last_payment_dt--convert(char(8),last_payment_dt)--20220214 last_payment_dt																																--		112	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(last_amount_paid*100))),19) AS last_amount_paid--20220214 SSUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(last_amount_paid),19)))),19) + LTRIM(RTRIM(STR(abs(last_amount_paid),19)))  	--		113																						
				, CASE WHEN credit_line_approved_dt		= '19000101' THEN '00000000'  when  credit_line_approved_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),credit_line_approved_dt,112)	END	as credit_line_approved_dt --convert(char(8),credit_line_approved_dt)--20220214 credit_line_approved_dt																														--		114		
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Amount_instalment*100))),19) AS Amount_instalment--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Amount_instalment),19)))),19) + LTRIM(RTRIM(STR(abs(Amount_instalment),19)))  	--		115																						
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Amount_revolving*100))),19) AS Amount_revolving--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Amount_revolving),19)))),19) + LTRIM(RTRIM(STR(abs(Amount_revolving),19)))  	--		116																								
				, convert(char(1),Ind_credit_line_duration) AS Ind_credit_line_duration--20220214 Ind_credit_line_duration																														--		117	
				, REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(nat_con_no)))) + LTRIM(RTRIM(nat_con_no)) AS nat_con_no
	FROM @OP51 order by cem, prod, con_no
else
	begin
		insert into @OP51_SALIDA
		select 
				  convert(char(03),ctry)--20220214 ctry																																						--		1					
				+ convert(char(08),book_dt,112)																																						--		2	
				+ convert(char(08),intf_dt,112)																																						--		3	
				+ convert(char(14),src_id)--20220214 src_id																																					--		4	
				+ convert(char(3),cem)--20220214 cem																																						--		5	
				+ convert(char(4),br)--20220214 br																																						--		6	
				+ convert(char(3),con_sta)--20220214 con_sta																																					--		7	
				+ convert(char(1),Dlnq_sta)--20220214 Dlnq_sta																																					--		8	
				+ convert(char(16),prod)--20220214 prod																																						--		9	
				+ CASE WHEN open_dt		= '19000101' THEN '00000000'  when  open_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),open_dt,112)	END	--convert(char(8),open_dt)--20220214 open_dt																																					--		10	
				+ CASE WHEN lst_accr_dt		= '19000101' THEN '00000000'  when  lst_accr_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_accr_dt,112)	END	--convert(char(8),lst_accr_dt)--20220214 lst_accr_dt																																				--		11	
				+ convert(char(12),Ident_cli)--20220214 Ident_cli																																					--		12	
				+ convert(char(10),cc)--20220214 cc																																						--		13	
				+ left(con_no+space(20), 20)--20220214 con_no																																					--		14	
				+ CASE WHEN strt_dt		= '19000101' THEN '00000000'  when  strt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),strt_dt,112)	END	--convert(char(8),strt_dt)--20220214 strt_dt																																					--		15	
				+ CASE WHEN end_dt		= '19000101' THEN '00000000'  when  end_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),end_dt,112)	END	--convert(char(8),end_dt)--20220214 end_dt																																					--		16	
				+ CASE WHEN next_rset_rt_dt		= '19000101' THEN '00000000'  when  next_rset_rt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rset_rt_dt,112)	END	--convert(char(8),next_rset_rt_dt)--20220214 next_rset_rt_dt																																			--		17	
				+ convert(char(1),int_pymt_arrs_ind)--20220214 int_pymt_arrs_ind																																			--		18	
				+ left(ccy,4)																			--		19	
				+ convert(char(1),ocy_nom_amt_sign)--20220214 ocy_nom_amt_sign																																			--		20	
			
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_nom_amt*10000))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(ocy_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(ocy_nom_amt),19)))  							--		21	
				+ convert(char(1),lcy_nom_amt_sign)--20220214 lcy_nom_amt_sign																																			--		22	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_nom_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_nom_amt),19)))  							--		23	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(fcy_lc_amt*10000))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(fcy_lc_amt),19)))),19) + LTRIM(RTRIM(STR(abs(fcy_lc_amt),19)))  							--		24	
				+ convert(char(1),Lcy_reaj_amt_sing)--20220214 Lcy_reaj_amt_sing																																			--		25	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_reaj_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_reaj_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_reaj_amt),19)))  						--		26			
				+ convert(char(1),Ocy_int_amt_sing)--20220214 Ocy_int_amt_sing																																			--		27	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Ocy_int_amt*10000))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Ocy_int_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Ocy_int_amt),19)))  							--		28		
				+ convert(char(1),Lcy_int_amt_sing)--20220214 Lcy_int_amt_sing																																			--		29	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_int_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_int_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_int_amt),19)))  							--		30					

				+ convert(char(2),fix_flting_ind)--20220214 fix_flting_ind																																			--		31	
				+ REPLICATE('0', 4 - DATALENGTH(LTRIM(RTRIM(STR(int_rt_cod))))) + LTRIM(RTRIM(STR(int_rt_cod)))																--		32	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt*100000000))),16)--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(int_rt),16)))),16) + LTRIM(RTRIM(STR(abs(int_rt),16)))  										--		33		
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt*100000000))),16)--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pnlt_rt),16)))),16) + LTRIM(RTRIM(STR(abs(pnlt_rt),16)))  									--		34				
				+ convert(char(1),rt_meth)--20220214 rt_meth																																					--		35	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt*100000000))),16)--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pool_rt),16)))),16) + LTRIM(RTRIM(STR(abs(pool_rt),16)))  									--		36						
				+ REPLICATE('0', 5 - DATALENGTH(LTRIM(RTRIM(STR(pool_rt_cod))))) + LTRIM(RTRIM(STR(pool_rt_cod)))															--		37	
				+ REPLICATE('0', 4 - DATALENGTH(LTRIM(RTRIM(STR(pnlt_rt_cod))))) + LTRIM(RTRIM(STR(pnlt_rt_cod)))															--		38	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt_sprd*100000000))),16)--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(int_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(int_rt_sprd),16)))  							--		39	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt_sprd*100000000))),16)--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pool_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(pool_rt_sprd),16)))  							--		40	

				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt_sprd*100000000))),16)--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pnlt_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(pnlt_rt_sprd),16)))  							--		41	
				+ convert(char(1),aset_liab_ind)--20220214 aset_liab_ind																																				--		42	
				+ convert(char(1),sbif_bal_no_rep_sign)--20220214 sbif_bal_no_rep_sign																																		--		43	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(sbif_bal_no_rep*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_bal_no_rep),19)))),19) + LTRIM(RTRIM(STR(abs(sbif_bal_no_rep),19)))  					--		44							
				+ right(replicate(0,3)+convert(varchar(3),convert(numeric(3),(sbif_tipo_tasa*1))),3)--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_tipo_tasa),3)))),3) + LTRIM(RTRIM(STR(abs(sbif_tipo_tasa),3)))  										--		45	
				+ right(replicate(0,2)+convert(varchar(2),convert(numeric(2),(sbif_prod_trans*1))),2)--20220214 SUBSTRING('00',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_prod_trans),2)))),2) + LTRIM(RTRIM(STR(abs(sbif_prod_trans),2)))  										--		46	
				+ right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(sbif_tipo_oper_trans*1))),1)--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_tipo_oper_trans),1)))),1) + LTRIM(RTRIM(STR(abs(sbif_tipo_oper_trans),1)))  							--		47	
				+ convert(char(1),lcy_fee_amt_sign)--20220214 lcy_fee_amt_sign																																			--		48	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_fee_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_fee_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_fee_amt),19)))  							--		49							
				+ CASE WHEN orig_strt_dt		= '19000101' THEN '00000000'  when  orig_strt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),orig_strt_dt,112)	END	--convert(char(8),orig_strt_dt)--20220214 orig_strt_dt																																				--		50	
				+ CASE WHEN nacc_from_dt		= '19000101' THEN '00000000'  when  nacc_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),nacc_from_dt,112)	END	--convert(char(8),nacc_from_dt)--20220214 nacc_from_dt																																				--		51	
				+ CASE WHEN pdue_from_dt		= '19000101' THEN '00000000'  when  pdue_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),pdue_from_dt,112)	END	--convert(char(8),pdue_from_dt)--20220214 pdue_from_dt																																				--		52	
				+ CASE WHEN wrof_from_dt		= '19000101' THEN '00000000'  when  wrof_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),wrof_from_dt,112)	END	 --convert(char(8),wrof_from_dt)--20220214 wrof_from_dt																																				--		53	
				+ convert(char(20),orig_con_no)--20220214 orig_con_no																																				--		54	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_remn_coup*1))),4)--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_remn_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_remn_coup),4)))  									--		55	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_pdo_coup*1))),4)--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_pdo_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_pdo_coup),4)))  										--		56	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_tot_coup*1))),4)--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_tot_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_tot_coup),4)))  										--		57	
				+ right(replicate(0,3)+convert(varchar(3),convert(numeric(4),(sbif_dest_coloc*1))),3)--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_dest_coloc),3)))),3) + LTRIM(RTRIM(STR(abs(sbif_dest_coloc),3)))  									--		58		
				+ CASE WHEN stop_accr_dt		= '19000101' THEN '00000000'  when  stop_accr_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),stop_accr_dt,112)	END	-- convert(char(8),stop_accr_dt)--20220214 stop_accr_dt																																				--		59	
				+ CASE WHEN lst_int_pymt_dt		= '19000101' THEN '00000000'  when  lst_int_pymt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_int_pymt_dt,112)	END	--convert(char(8),lst_int_pymt_dt)--20220214 lst_int_pymt_dt																																			--		60	

				+ convert(char(1),ren_ind)--20220214 ren_ind																																					--		61	
				+  CASE WHEN lst_rset_dt		= '19000101' THEN '00000000'  when  lst_rset_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rset_dt,112)	END	--convert(char(8),lst_rset_dt)--20220214 lst_rset_dt																																				--		62	
				+  CASE WHEN next_rt_ch_dt		= '19000101' THEN '00000000'  when  next_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rt_ch_dt,112)	END	--convert(char(8),next_rt_ch_dt)--20220214 next_rt_ch_dt																																				--		63	
				+  CASE WHEN lst_rt_ch_dt		= '19000101' THEN '00000000'  when  lst_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rt_ch_dt,112)	END	 --convert(char(8),lst_rt_ch_dt)--20220214 lst_rt_ch_dt																																				--		64	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_orig_nom_amt*10000))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(ocy_orig_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(ocy_orig_nom_amt),19)))  	--		65										
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_avl_bal*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_avl_bal),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_avl_bal),19)))  				--		66							
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo1_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo1_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo1_amt),19)))  			--		67								
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo2_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo2_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo2_amt),19)))  			--		68								
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_pdo3_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_pdo3_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_pdo3_amt),19)))  			--		69								
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_oper_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_oper_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_oper_amt),19)))  			--		70												
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(loc*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(loc),19)))),19) + LTRIM(RTRIM(STR(abs(loc),19)))  								--		71			
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_mnpy*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_mnpy),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_mnpy),19)))  					--		72						

				+ convert(char(1),lgl_actn_ind)--20220214 lgl_actn_ind																																	--		73	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_mv*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_mv),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_mv),19)))  						--		74					
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_par_val*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_par_val),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_par_val),19)))  				--		75										
				+ right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(Port_typ*1))),1)--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(Port_typ),1)))),1) + LTRIM(RTRIM(STR(abs(Port_typ),1)))  										--		76	
				+ right(replicate(0,3)+convert(varchar(3),convert(numeric(3),(No_rng*1))),3)--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(No_rng),3)))),3) + LTRIM(RTRIM(STR(abs(No_rng),3))) 											--		77	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(Pdc_coup*1))),4)--20220214 REPLICATE('0', 4 - LEN(Pdc_coup)) + CAST(Pdc_coup AS varchar)																					--		78	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Pgo_amt*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Pgo_amt),1)))),19) + LTRIM(RTRIM(STR(abs(Pgo_amt),19))) 						--		79	
				+ convert(char(1),con_no_typ)--20220214 con_no_typ																																	--		80	
				+ convert(char(1),ope_typ)--20220214 ope_typ																																		--		81	

				+ REPLICATE(' ', 2 - DATALENGTH(LTRIM(RTRIM(STR(mod_entr_bs))))) + LTRIM(RTRIM(STR(mod_entr_bs)))												--		82	
				+ right(replicate(0,12)+convert(varchar(12),convert(numeric(12),(opc_compra*100))),12)--20220214 SUBSTRING('000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(opc_compra),1)))),12) + LTRIM(RTRIM(STR(abs(opc_compra),12))) 						--		83	
				+ REPLICATE(' ', 5 - LEN(LTRIM(RTRIM(ident_instr)))) + LTRIM(RTRIM(ident_instr))																--		84	
				+ REPLICATE(' ', 15 - DATALENGTH(LTRIM(RTRIM(ident_emi_instr)))) + LTRIM(RTRIM(ident_emi_instr))												--		85	--20220214 25
				+ REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(serie_instr)))) + LTRIM(RTRIM(serie_instr))																--		86	
				+ REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(subserie_instr)))) + LTRIM(RTRIM(subserie_instr))															--		87	--20220214 2
				+ REPLICATE(' ', 8 - LEN(LTRIM(RTRIM(cat_risk_instr)))) + LTRIM(RTRIM(cat_risk_instr))															--		88	
				+ right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(limit_rate*100000000))),16)--20220214 SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(limit_rate),1)))),16) + LTRIM(RTRIM(STR(abs(limit_rate),16)))						--		89	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(pdc_after_fix_per*1))),4)--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdc_after_fix_per),1)))),4) + LTRIM(RTRIM(STR(abs(pdc_after_fix_per),4))) 					--		90	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo4_amt*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo4_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo4_amt),19)))  			--		91												
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo5_amt*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo5_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo5_amt),19)))  			--		92												
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo6_amt*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo6_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo6_amt),19)))  			--		93												
				+ convert(char(1),sbif_no_rep_ind)--20220214 sbif_no_rep_ind																																--		94

				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_otr_cont_amt*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_otr_cont_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_otr_cont_amt),19)))  	--		95														
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo7_amt*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo7_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo7_amt),19)))  			--		96												
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo8_amt*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo8_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo8_amt),19)))  			--		97												
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo9_amt*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo9_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo9_amt),19)))  			--		98															
				+ right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(assets_origin*1))),1)--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(assets_origin),1)))),1) + LTRIM(RTRIM(STR(abs(assets_origin),1)))  								--		99		
				+ CASE WHEN first_expiry_dt		= '19000101' THEN '00000000'  when  first_expiry_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),first_expiry_dt,112)	END	--convert(char(8),first_expiry_dt)--20220214 first_expiry_dt																																--		100	
				+ convert(char(1),tip_otorg)--20220214 tip_otorg																																		--		101	

				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(price_viv*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(price_viv),19)))),19) + LTRIM(RTRIM(STR(abs(price_viv),19)))  					--		102																	
				+ convert(char(1),tip_op_reneg)--20220214 tip_op_reneg																																	--		103	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(mon_pie_pag_reneg*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(mon_pie_pag_reneg),19)))),19) + LTRIM(RTRIM(STR(abs(mon_pie_pag_reneg),19)))  	--		104																								
				+ convert(char(1),seg_rem_cred_hip)--20220214 seg_rem_cred_hip																																--		105	
				+ right(replicate(0,8)+convert(varchar(8),convert(numeric(8),(pdue_from_oldest*1))),8)--20220214 SUBSTRING('00000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdue_from_oldest),1)))),8) + LTRIM(RTRIM(STR(abs(pdue_from_oldest),8))) 					--		106	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(mon_prev_rng*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(mon_prev_rng),19)))),19) + LTRIM(RTRIM(STR(abs(mon_prev_rng),19)))  			--		107																		
				+ convert(char(1),exig_pago)--20220214 exig_pago																																		--		108	
				+  CASE WHEN bidding_dt		= '19000101' THEN '00000000'  when  bidding_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),bidding_dt,112)	END	--convert(char(8),bidding_dt)--20220214 bidding_dt																																	--		109
				+  CASE WHEN loan_disbursement_dt		= '19000101' THEN '00000000'  when  loan_disbursement_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),loan_disbursement_dt,112)	END	-- convert(char(8),loan_disbursement_dt)--20220214 loan_disbursement_dt																															--		110		
				+  CASE WHEN Accounting_dt		= '19000101' THEN '00000000'  when  Accounting_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),Accounting_dt,112)	END	--convert(char(8),Accounting_dt)--20220214 Accounting_dt																																	--		111	
				+  CASE WHEN last_payment_dt		= '19000101' THEN '00000000'  when  last_payment_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),last_payment_dt,112)	END	--convert(char(8),last_payment_dt)--20220214 last_payment_dt																																--		112	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(last_amount_paid*100))),19)--20220214 SSUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(last_amount_paid),19)))),19) + LTRIM(RTRIM(STR(abs(last_amount_paid),19)))  	--		113																						
				+ CASE WHEN credit_line_approved_dt		= '19000101' THEN '00000000'  when  credit_line_approved_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),credit_line_approved_dt,112)	END	 --convert(char(8),credit_line_approved_dt)--20220214 credit_line_approved_dt																														--		114		
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Amount_instalment*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Amount_instalment),19)))),19) + LTRIM(RTRIM(STR(abs(Amount_instalment),19)))  	--		115																						
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Amount_revolving*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Amount_revolving),19)))),19) + LTRIM(RTRIM(STR(abs(Amount_revolving),19)))  	--		116																								
				+ convert(char(1),Ind_credit_line_duration)--20220214 Ind_credit_line_duration																														--		117	
				+ REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(nat_con_no)))) + LTRIM(RTRIM(nat_con_no))
				from @OP51
				order by cem, prod, con_no

--				union
--				select @Pie_Archivo
		--insert into @OP52_SALIDA
	--	select @Pie_Archivo

		select * from @OP51_SALIDA WHERE reg_salida IS NOT NULL  order by len(reg_salida) desc 

	end 
   
END  

GO
