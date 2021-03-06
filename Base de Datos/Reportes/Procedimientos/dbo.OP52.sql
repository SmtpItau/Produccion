USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[OP52]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--OP52 '20211005'
CREATE PROCEDURE [dbo].[OP52] (@dFechaProceso DateTime=Null)
AS
BEGIN

--declare @dFechaProceso DateTime
--set  @dFechaProceso ='20220329'


   SET NOCOUNT ON
   
   DECLARE @Max    INTEGER
   DECLARE @Fecha  DATETIME
   

	--SET @dFechaProceso ='20210722'  
	


	if @dFechaProceso is null  
	begin   
	 set @dFechaProceso = (select fechaproc from BacSwapSuda..SWAPGENERAL)  
	end  

	Set @Fecha=@dFechaProceso
	declare @dFechaValorizacion datetime=@dFechaProceso 
	--SELECT @Fecha  = fechaproc
 --   FROM   SWAPGENERAL

   DECLARE @iFound      INTEGER
   SELECT  @iFound      = -1
   SELECT  @iFound      = 0
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE ,  BacSwapSuda..SWAPGENERAL
   WHERE   Fecha        = @dFechaProceso
   AND     Tipo_Cambio <> 0

   IF @iFound = -1
   BEGIN
      RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
      RETURN
   END

   CREATE TABLE #NEOSOFT
   (   codigo_pais			VARCHAR(3)
   ,   fecha_contable		CHAR(8)	
   ,   fecha_interfaz		CHAR(8)	
   ,   ident_interfaz 		VARCHAR(14)
   ,   cod_empresa			VARCHAR(3)
   ,   cod_sucursal			VARCHAR(4)
   ,   status_contrato		VARCHAR(3)
   ,   status_crediticio	VARCHAR(1)
   ,   fam_producto			CHAR(4)
   ,   T_producto			CHAR(4)
   ,   C_interno			VARCHAR(16)
   ,   Clase_Producto 		VARCHAR(1)
   ,   Tipologia_producto   VARCHAR(1)
   ,   F_operacion          CHAR(8)	
   ,   F_devengamiento      CHAR(8)	
   ,   rut					VARCHAR(12)
   ,   dig                  VARCHAR(1)
   ,   costo				VARCHAR(10)
   ,   n_operacion			CHAR(20)
   ,   fecha_inic			CHAR(8)	
   ,   fecha_vcto			CHAR(8)	
   ,   fecha_renovacion     VARCHAR(8)
   ,   indicador			VARCHAR(1)
   ,   cod_inter_mda		VARCHAR(3)
   ,   s_mto_cap_ori		CHAR(1)
   ,   mto_cap_origen		NUMERIC(19,4)
   ,   s_mto_cap_loc		CHAR(1)
   ,   mto_cap_local		NUMERIC(19,4)
   ,   mto_linea_credito	NUMERIC(19,4)
   ,   s_reaj_mda_loc		CHAR(1)
   ,   mto_reaj_loc			NUMERIC(19,4)
   ,   s_int_mda_orig		CHAR(1)
   ,   mto_int_mda_orig	    NUMERIC(19,4)
   ,   s_int_mda_loc		CHAR(1)
   ,   mto_int_mda_loc		NUMERIC(19,4)
   ,   tasa_f_v		        CHAR(1)
   ,   tasa_base            CHAR(4)
   ,   tasa_interes			NUMERIC(16,8)
   ,   tasa_penalidad		NUMERIC(16,8)
   ,   calc_interes         VARCHAR(1)
   ,   c_operacion			NUMERIC(16,8)
   ,   c_fondo_oper			VARCHAR(5)
   ,   c_penalidad			VARCHAR(4)
   ,   spread				NUMERIC(16,8)
   ,   spread_pool			NUMERIC(16,8)
   ,   spread_tasa_penalidad	NUMERIC(16,8)
   ,   indicador_p_a        VARCHAR(1)
   ,   s_mto_vencido        VARCHAR(1)
   ,   d_vencidas   		NUMERIC(18,2)
   ,   t_tasa				NUMERIC(3)
   ,   p_transfronterizo	NUMERIC(2)
   ,   t_oper_transfronterizo   NUMERIC(1)
   ,   s_comision               VARCHAR(1)
   ,   mto_comision   		NUMERIC(18,2)
   ,   fec_otorgamiento     VARCHAR(8)
   ,   fec_cartera	        VARCHAR(8)
   ,   fec_mora		        VARCHAR(8)
   ,   fec_cartera_castigada    VARCHAR(8)
   ,   n_operacion_orig	        VARCHAR(20)
   ,   n_cuotas		        NUMERIC(4)
   ,   n_cuotas_mora		NUMERIC(4)
   ,   n_cuotas_total		NUMERIC(4)
   ,   destino				NUMERIC(3)
   ,   f_suspension			VARCHAR(8)
   ,   f_u_pago		        VARCHAR(8)
   ,   indicador_renovacion     VARCHAR(1)
   ,   f_renovacion             VARCHAR(8)
   ,   f_cambio	                VARCHAR(8)
   ,   f_ultimo_cambio		VARCHAR(8)
   ,   nomin_en_pesos		NUMERIC(18,2)
   ,   s_mda_local			NUMERIC(18,2)
   ,   m_mora1				NUMERIC(18,2)
   ,   m_mora2				NUMERIC(18,2)
   ,   m_mora3				NUMERIC(18,2)
   ,   colocacion			NUMERIC(18,2)
   ,   l_credito            NUMERIC(18,2)
   ,   p_minimo		        NUMERIC(18,2)
   ,   i_cobranza		VARCHAR(1)
   ,   v_mercado		NUMERIC(18,2)
   ,   v_pesos			NUMERIC(18,2)
   ,   t_cartera		CHAR(10)
   ,   n_renegociacion		NUMERIC(3)
   ,   p_cuotas		 NUMERIC(4)
   ,   m_pagado		        NUMERIC(18,2)
   ,   t_contrato		VARCHAR(1)
   ,   t_operacion              VARCHAR(1)
   ,   t_entrega  		VARCHAR(1)
   ,   mto_op_compra		NUMERIC(19,4)
   ,   i_instrumento		VARCHAR(5)
   ,   i_emisor		        VARCHAR(15)
   ,   s_instrumento		VARCHAR(4)
   ,   s_registrada		VARCHAR(4)
   ,   c_riesgo				VARCHAR(3)	-->	VARCHAR(4)
   ,   registros		NUMERIC(5)
   ,   tipoflujo		NUMERIC(5)
   ,   numero_armado	CHAR(20)
   ,   numeroflujo		NUMERIC(5)
   ,   dias_flujo		NUMERIC(5)
   ,   dias_corr		NUMERIC(5)
   )

   Declare @OP52_SALIDA Table ( REG_SALIDA  Varchar(1240))  

   DECLARE @OP52 TABLE 
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
, sbif_no_rep_ind			    VARCHAR(1)				--		94	
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
, bidding_dt				    CHAR(8)				--		109	
, loan_disbursement_dt		CHAR(8)					--		110	
, Accounting_dt				CHAR(8)					--		111	
, last_payment_dt			    CHAR(8)				--		112	
, last_amount_paid			NUMERIC(19,2)			--		113	
, credit_line_approved_dt	    CHAR(8)				--		114	
, Amount_instalment			NUMERIC(19,2)			--		115	
, Amount_revolving			NUMERIC(19,2)			--		116	
, Ind_credit_line_duration	Varchar (1)				--		117	
, nat_con_no				Varchar (4)				--		118	
, dest_finan				Varchar (1)				--		119
, no_post_coup				NUMERIC(3,0)			--		120
, giro						Varchar (2)				--		121
)

  

   SELECT vmcodigo ,vmvalor INTO #VALMON FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFechaProceso
                     INSERT INTO #VALMON VALUES(999, 1.0)
                     INSERT INTO #VALMON SELECT 13, vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @dFechaProceso

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo
   ,      vmvalor
   INTO   #VALOR_TC_CONTABLE
   FROM   #VALMON
   WHERE  vmcodigo IN(994,995,998,997,999)

   INSERT INTO #VALOR_TC_CONTABLE
   SELECT CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      Tipo_Cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   
   WHERE  Fecha         = @Fecha
   AND    Codigo_Moneda NOT IN(13,995,998,997,999)


   -- DOCUMENTAR COMO ESTANDAR
   -- GENERAR UNA LISTA DE LAS OPERACIONES QUE DEBEN SER INCLUIDAS EN LA INTERFAZ
   -- Se ponen todos los conceptos que nunca serán diferentes por          
   -- Pata para luego agregar los datos que corresponden a cada pata.  
   SELECT DISTINCT 
          'OpNumero_Operacion' = C.Numero_Operacion
   ,      'OpRut_cliente'      = C.Rut_cliente
   ,      'OpCodigo_cliente'   = C.Codigo_cliente
   ,      'OpFecha_Cierre'     = C.Fecha_Cierre
   ,      'OpT_cartera'        = ISNULL((SELECT top 1 ccn_codigo_nuevo FROM BacParamSuda..TBL_CODIFICACION_CARTERA_NORMATIVA WHERE ccn_codigo_cartera = C.car_Cartera_Normativa),4)
   INTO   #Operaciones
   FROM    BacSwapSuda..CARTERA              C 
   WHERE  ( ( Fecha_Termino        > @Fecha and tipo_swap <> 3 ) or ( Tipo_swap = 3 and fechaliquidacion > @Fecha ) )
          and Compra_Saldo + Compra_Amortiza + Compra_Flujo_Adicional > 0 -- MAP 20081115 Corrige problema NEOSOFT
          and estado_Flujo = 1                                            -- MAP 20081115 Corrige problema NEOSOFT
          and Estado <> 'N'                                               -- MAP 20081115 Corrige problema NEOSOFT
          and Estado <> 'C'

 
   INSERT INTO #NEOSOFT
   SELECT DISTINCT
       'codigo_pais'           = 'CL'
   ,   'fecha_contable'	       = convert(char(08),@Fecha,112)	
   ,   'fecha_interfaz'	       = convert(char(08),@dFechaProceso,112)	
   ,   'ident_interfaz'	       = 'OPC2'
   ,   'cod_empresa'           = '001'
   ,   'cod_sucursal'          = '0011'
   ,   'status_contrato'       = 'A'
   ,   'status_crediticio'     = '1'
   ,   'fam_producto'	       = 'MD02'--'MD02'
   ,   'T_producto'	       = 'MD02'--'MD02'
   ,   'C_interno'	       = 'MD02'
   ,   'Clase_Producto'        = ''
   ,   'Tipologia_producto'    = 'M'
   ,   'F_operacion'	       = convert(char(08),OpFecha_Cierre,112)
   ,   'F_devengamiento'       = convert(char(08),@Fecha,112)	
   ,   'rut'		       = clrut--CONVERT(CHAR(9),clrut)
   ,   'dig'                   = CONVERT(CHAR(1),cldv)
   ,   'costo'		       = SPACE(1)
   ,   'n_operacion'           = OpNumero_Operacion
   ,   'fecha_inic'            = convert(char(08),OpFecha_Cierre,112)  
   ,   'fecha_vcto'	       = (SELECT MAX( case when c1.Tipo_swap <> 3 then convert(char(08),Fecha_Termino,112)   else convert(char(08),FechaLiquidacion,112) end) FROM  BacSwapSuda..CARTERA C1 WHERE C1.Numero_operacion = OpNumero_Operacion)
   ,   'fecha_renovacion'      = SPACE(8)
   ,   'indicador'	       = 'V'
   ,   'cod_inter_mda'	       = ''
   ,   's_mto_cap_ori'	       = '+'
   ,   'mto_cap_origen'	       = 0
   ,   's_mto_cap_loc'	       = '+'
   ,   'mto_cap_local'	       = 0
   ,   'mto_linea_credito'   = 0
   , 's_reaj_mda_loc'	       = '+'
   ,   'mto_reaj_loc'	       = 0
   , 's_int_mda_orig'	       = '+'
   ,   'mto_int_mda_orig'      = 0
   ,   's_int_mda_loc'	       = '+'
   ,   'mto_int_mda_loc'       = 0
   ,   'tasa_f_v'	       = 'F'
   ,   'tasa_base'             = ''
   ,   'tasa_interes'	       = 0
   ,   'tasa_penalidad'	       = 0
   ,   'calc_interes'	       = 0
   ,   'C_operacion'	       = 0
   ,   'c_fondo_oper'	       = SPACE(5)
   ,   'c_penalidad'	       = SPACE(4)
   ,   'spread'		       = 0
   ,   'spread_pool'	       = 0
   ,   'spread_tasa_penalidad' = 0
   ,   'indicador_p_a'         = 'A'
   ,   's_mto_vencido'         = '+'
   ,   'd_vencidas'   	       = 0
   ,   't_tasa'		       = '101'
   ,   'p_transfronterizo'     = 0
   ,   't_oper_transfronterizo'= 0
   ,   's_comision'            = '+'
   ,   'mto_comision'          = 0
   ,   'fec_otorgamiento'      = SPACE(8)
   ,   'fec_cartera'	       = SPACE(8)
   ,   'fec_mora'              = SPACE(8)
   ,   'fec_cartera_castigada' = SPACE(8)
   ,   'n_operacion_orig'      = OpNumero_Operacion
   ,   'n_cuotas'	       = 1 --> Aca
   ,   'n_cuotas_mora'	       = 0 --> Aca
   ,   'n_cuotas_total'	       = 0
   ,   'destino'	       = CASE WHEN rcrut 	 = Oprut_cliente THEN 211
                                      WHEN Oprut_cliente = 97030000      THEN 212
				      ELSE				      221
				 END
   ,   'f_suspension'	       = SPACE(8)
   ,   'f_u_pago'	       = SPACE(8)
   ,   'indicador_renovacion'  = SPACE(1)
   ,   'f_renovacion'	       = SPACE(8)
   ,   'f_cambio'	       = SPACE(8)
   ,   'f_ultimo_cambio'       = SPACE(8)
   ,   'nomin_en_pesos'	       = 0
   ,   's_mda_local'	       = 0
   ,   'm_mora1'	       = 0
   ,   'm_mora2'	       = 0
   ,   'm_mora3'	       = 0
   ,   'colocacion'	       = 0
   ,   'l_credito'             = 0
   ,   'p_minimo'	       = 0
   ,   'i_cobranza'	       = SPACE(1)
   ,   'v_mercado'	       = 0
   ,   'v_pesos'	       = 0
   ,   't_cartera'	       = OpT_cartera 
   ,   'n_renegociacion'       = 000
   ,   'p_cuotas'	       = 0
   ,   'm_pagado'	       = 0
   ,   't_contrato'            = '1'
   ,   't_operacion'	       = SPACE(1) 
   ,   't_entrega'	       = SPACE(1) 
   ,   'mto_op_compra'	       = 0	
   ,   'i_instrumento'	       = SPACE(5) 
   ,   'i_emisor'	       = SPACE(15) 
   ,   's_instrumento'	       = SPACE(4) 
   ,   's_registrada'	       = SPACE(4) 

--		,	'c_riesgo'				= SPACE(3) 
		,	'c_riesgo'				= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( clrut, clcodigo, 'PCS' )

   ,   'registros'	       = 0
   ,   'tipoflujo'	       = 0 -- Tipo_Flujo   -- Por la nueva estrategia no deberia ser necesario retener esto !!
   ,   'numero_armado'	       = CONVERT(VARCHAR(10),OpNumero_Operacion)
   ,   'numeroflujo'	       = 0 -- Numero_Flujo -- Por la nueva estrategia no deberia ser necesario retener esto !!
   ,   'dias_flujo'	       = 0 -- <-- Poner el del concepto del flujo vigente de compra y si no hay el de venta, más abajo
   ,   'dias_corr'	       = 0 -- <-- Poner el del concepto del flujo vigente de compra y si no hay el de venta, más abajo
   FROM  #Operaciones
         LEFT JOIN BacParamSuda..CLIENTE  ON Oprut_cliente = clrut  AND Opcodigo_cliente = clcodigo	
   ,	  BacSwapSuda..VIEW_ENTIDAD  

   -- SELECICONAR FLUJOS VIENTES DE LA CARTERA
   -- Seleccion de flujos vigentes de la cartera
   SELECT * 
   INTO   #FluCarVig -- select * from #FluCarVig
   FROM    BacSwapSuda..CARTERA As C2 
			
			INNER JOIN
			(	SELECT	CONTRATO		= NUMERO_OPERACION
					,	TIPO			= TIPO_FLUJO
					,	FLUJO			= MIN( NUMERO_FLUJO )
				FROM	 BacSwapSuda..CARTERA			WITH(NOLOCK)
				WHERE (	Estado_Flujo	= 1	)   
				AND     Fecha_Termino	> @Fecha      
				AND     Estado			<> 'N'
				AND     Estado			<> 'C'
				GROUP 
				BY		NUMERO_OPERACION
					,	TIPO_FLUJO
			)	GRP		ON	GRP.CONTRATO	= C2.NUMERO_OPERACION
						AND	GRP.TIPO		= C2.TIPO_FLUJO
						AND	GRP.FLUJO		= C2.NUMERO_FLUJO


   WHERE ( /* Cambia definición de Flujo Vigente 
          (@Fecha >= C2.fecha_cierre       AND C2.numero_flujo = 1                    AND @Fecha          <= C2.fecha_vence_flujo)
       OR (@Fecha >  C2.fecha_Inicio_flujo AND @Fecha         <= C2.fecha_vence_flujo AND C2.numero_flujo <> 1)
           */
           Estado_Flujo = 1
         )   
   AND     Fecha_Termino > @Fecha      
   AND     Estado <> 'N'
   AND     Estado <> 'C'

   -- CARGA DE INFORMACION 
   -- Si no hay flujo de compra (tipo1) , poner valores de flujo de venta (tipo2)
   -- según la definición stándar

   UPDATE #NEOSOFT
   SET    n_cuotas      =	(	SELECT	COUNT(1) 
								FROM	 BacSwapSuda..CARTERA 
								WHERE	numero_operacion	= n_operacion 
								AND		fecha_vence_flujo	> @Fecha 
								AND		tipo_flujo			= 1
							)

   ,      n_cuotas_mora =	(	SELECT	COUNT(1) 
								FROM	 BacSwapSuda..CARTERA 
								WHERE	numero_operacion	= n_operacion 
								AND		fecha_vence_flujo	> @Fecha 
								AND		tipo_flujo			= 2
							) 
   ,      dias_flujo    = ISNULL((SELECT DATEDIFF(DAY,Fecha_Inicio_Flujo, Fecha_Vence_Flujo) FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                        , ISNULL((SELECT DATEDIFF(DAY,Fecha_Inicio_Flujo, Fecha_Vence_Flujo) FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))
   ,      dias_corr     = ISNULL((SELECT DATEDIFF(DAY,Fecha_Inicio_Flujo, @Fecha)      FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                        , ISNULL((SELECT DATEDIFF(DAY,Fecha_Inicio_Flujo, @Fecha)            FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))


   UPDATE #NEOSOFT
   SET    cod_inter_mda  = ISNULL((SELECT Compra_Moneda  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                         , ISNULL((SELECT Venta_Moneda   FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))             
   ,	  mto_cap_origen = ISNULL((SELECT Compra_Capital FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                         , ISNULL((SELECT Venta_Capital  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))             
   ,	  mto_cap_local	 = ROUND(ISNULL((SELECT Compra_Capital FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                                      * (SELECT vmvalor        FROM #VALOR_TC_CONTABLE /*#VALMON*/ WHERE vmcodigo = (SELECT Compra_Moneda FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1))
                                ,ISNULL((SELECT Venta_Capital  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2) 
                                      * (SELECT vmvalor        FROM #VALOR_TC_CONTABLE /*#VALMON*/ WHERE vmcodigo = (SELECT Venta_Moneda  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2)),0)),0)
   ,	  mto_reaj_loc   = 0
   ,	  mto_int_mda_orig= 0.0 
   ,	  mto_int_mda_loc= 0.0 
   ,	  nomin_en_pesos = 0.0             
   ,	  mto_op_compra	 = 0.0             
   ,	  colocacion	 = 0.0        
   ,	  tasa_base      = (SELECT B.Base        FROM  BacSwapSuda..BASE B WHERE B.codigo = ISNULL((SELECT Compra_base FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                                                                            , ISNULL((SELECT Venta_base  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0)))

   ,	  tasa_interes	 = ISNULL((SELECT CASE WHEN Compra_Valor_Tasa < 0 THEN 0.0 ELSE Compra_Valor_Tasa END FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1),0)

   ,	  calc_interes   = (SELECT B.Cod_Neosoft FROM  BacSwapSuda..BASE B WHERE B.codigo = ISNULL((SELECT Compra_base FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                                                                            , ISNULL((SELECT Venta_base  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0)))
   ,	  spread         = ISNULL((SELECT Compra_Spread FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                         , ISNULL((SELECT Venta_Spread  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))
   ,	  n_cuotas_total = ISNULL((SELECT COUNT(1)      FROM  BacSwapSuda..CARTERA    WHERE fecha_vence_flujo > @Fecha AND n_operacion = numero_operacion),0)

   ,      v_pesos        = 0.0 -- UPDATE PENDIENTE: proximo comando con <-- mto_cap_local -- ROUND(compra_capital * (SELECT vmvalor FROM #VALMON WHERE vmcodigo = compra_moneda), 0)

   ,	  p_cuotas	 = ISNULL((SELECT dias FROM BacParamSuda..PERIODO_AMORTIZACION WHERE tabla = 1044 and sistema = 'PCS' and codigo = ISNULL((SELECT Compra_CodAmo_interes FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 1)
                     , ISNULL((SELECT Venta_CodAmo_interes  FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0))), 0.0)

	UPDATE #NEOSOFT SET spread = 0.0 WHERE spread < 0                                                                                                                                     
                                                                                                                                         
   UPDATE #NEOSOFT
   SET    nomin_en_pesos  = mto_cap_local
   ,	  mto_op_compra	  = mto_cap_origen
   ,	  v_pesos      = mto_cap_local -- ROUND(compra_capital * (SELECT vmvalor FROM #VALMON WHERE vmcodigo = compra_moneda), 0)
   ,	  tasa_penalidad  = ISNULL((SELECT CASE WHEN Venta_Valor_Tasa < 0 THEN 0.0 ELSE Venta_Valor_Tasa END FROM #FluCarVig WHERE Numero_operacion = n_operacion AND Tipo_Flujo = 2),0)
   ,	  dias_corr       = CASE WHEN dias_corr < 0 THEN 0.0 ELSE dias_corr END 

   SELECT @max            = COUNT(1) 
   FROM	  #NEOSOFT

   UPDATE #NEOSOFT
   SET    registros       = @max
   ,      mto_op_compra   = ISNULL((SELECT ROUND(MAX(Monto),0) FROM BacTraderSuda..MARGEN_ARTICULO84 WHERE Numdocu = n_operacion),0) 
   
   INSERT INTO @OP52
   SELECT n.CODIGO_PAIS, FECHA_CONTABLE, FECHA_INTERFAZ, IDENT_INTERFAZ,COD_EMPRESA,COD_SUCURSAL, STATUS_CONTRATO, STATUS_CREDITICIO, FAM_PRODUCTO, F_OPERACION
		 ,F_DEVENGAMIENTO, 			right(replicate('0',12)+convert(varchar(10),rut)+dig,12)	,REPLICATE('0',10)	, N_OPERACION, FECHA_INIC, FECHA_VCTO, FECHA_RENOVACION, INDICADOR
		 , m.mncodbkb	
		 , s_mto_cap_ori
		 ,mto_cap_origen, s_mto_cap_loc, mto_cap_local, mto_linea_credito, s_reaj_mda_loc, mto_reaj_loc, s_int_mda_orig, mto_int_mda_orig,s_int_mda_loc,mto_int_mda_loc
		 ,tasa_f_v, tasa_base, tasa_interes, tasa_penalidad, calc_interes, c_operacion, c_fondo_oper, c_penalidad, spread, spread_pool 
		 ,spread_tasa_penalidad, indicador_p_a,s_mto_vencido, d_vencidas, t_tasa, p_transfronterizo, t_oper_transfronterizo, s_comision, mto_comision, fec_otorgamiento
		 ,fec_cartera,fec_mora,fec_cartera_castigada, n_operacion_orig, n_cuotas, n_cuotas_mora, n_cuotas_total, destino, f_suspension, f_u_pago
		 ,indicador_renovacion, f_renovacion, f_cambio, f_ultimo_cambio, nomin_en_pesos, s_mda_local, m_mora1, m_mora2, m_mora3, colocacion
		 ,l_credito, p_minimo, i_cobranza, v_mercado, v_pesos, t_cartera,n_renegociacion, p_cuotas, m_pagado, t_contrato
		 ,t_operacion, t_entrega, mto_op_compra, i_instrumento, i_emisor, s_instrumento, s_registrada, c_riesgo
		 ,		0															as			limit_rate											--		89
		 ,		0															as			pdc_after_fix_per									--		90	
		 ,		0															as			lcy_pdo4_amt										--		91	
		 ,		0															as			lcy_pdo5_amt										--		92	
		 ,		0															as			lcy_pdo6_amt										--		93	
		 ,		'S'															as			sbif_no_rep_ind 									--		94	
		 ,		0															as			Lcy_otr_cont_amt									--		95	
		,		0															as			lcy_pdo7_amt 										--		96	
		,		0															as			lcy_pdo8_amt 										--		97	
		,		0															as			lcy_pdo9_amt 										--		98	
		,		0															as			assets_origin										--		99	
		,		''															as			first_expiry_dt										--		100	
		,		''															as			tip_otorg											--		101	
		,		0															as			price_viv											--		102	
		,		''															as			tip_op_reneg										--		103	
		,		0															as			mon_pie_pag_reneg									--		104	
		,		''															as			seg_rem_cred_hip									--		105	
		,		0															as			pdue_from_oldest    								--		106	
		,		0															as			mon_prev_rng										--		107	
		,		''															as			exig_pago											--		108	
		,		''															as			bidding_dt											--		109	
		,		''															as			loan_disbursement_dt								--		110	
		,		convert(char(08),@dFechaProceso,112)						as			Accounting_dt										--		111	
		,		''															as			last_payment_dt										--		112	
		,		0															as			last_amount_paid									--		113	
		,		''															as			credit_line_approved_dt								--		114	
		,		0															as			Amount_instalment									--		115	
		,		0															as			Amount_revolving									--		116	
		,      ''															as			Ind_credit_line_duration							--		117	
		,	   ''															as			nat_con_no											--		118	
		,	   ''															as			dest_finan											--		119
		,	   0															as			no_post_coup										--		120
		,	   ''															as			giro												--		121
   FROM #NEOSOFT n
   inner join BacParamSuda..MONEDA m with(nolock) On m.mncodmon	= n.COD_INTER_MDA

   Declare @Pie_Archivo Varchar(20) = ''
Declare @iCantidadRegistros int = 0

set @iCantidadRegistros = (select count(1) from @OP52)
set @Pie_Archivo		= '99'+LTRIM(RTRIM(CONVERT(CHAR(10),@dFechaProceso,112)))+REPLICATE('0', 10 - len(LTRIM(RTRIM(@iCantidadRegistros))))+RTRIM(RTRIM(@iCantidadRegistros))


Declare @TipoSalida bit = 0

if @TipoSalida != 0
BEGIN
   	select 
				  convert(char(03),ctry)				as ctry --20220214 ctry																																						--		1					
				, (case when book_dt='19000101' then '00000000' else book_dt end) as book_dt	-- convert(char(08),book_dt,112)																																						--		2	
				, (case when intf_dt='19000101' then '00000000' else intf_dt end) as intf_dt	--convert(char(08),intf_dt,112)																																						--		3	
				, convert(char(14),src_id) as src_id--20220214 src_id																																					--		4	
				, convert(char(3),cem)as cem--20220214 cem																																						--		5	
				, convert(char(4),br) as br--20220214 br																																						--		6	
				, convert(char(3),con_sta)as con_sta--20220214 con_sta																																					--		7	
				, convert(char(1),Dlnq_sta) as Dlnq_sta--20220214 Dlnq_sta																																					--		8	
				, convert(char(16),prod)as prod--20220214 prod																																						--		9	
				, (case when open_dt='19000101' then '00000000' when  open_dt	=	'' then '00000000' else open_dt end) as open_dt--convert(char(8),open_dt)--20220214 open_dt																																					--		10	
				, (case when lst_accr_dt='19000101' then '00000000' when  lst_accr_dt	=	'' then '00000000'else lst_accr_dt end) as lst_accr_dt--convert(char(8),lst_accr_dt)--20220214 lst_accr_dt																																				--		11	
				, convert(char(12),Ident_cli) as Ident_cli--20220214 Ident_cli																																					--		12	
				, convert(char(10),cc)as cc--20220214 cc																																						--		13	
				, left(con_no+space(20), 20)	as con_no--REPLICATE('0',20-LEN(LTRIM(RTRIM(con_no))))+LTRIM(RTRIM(con_no))--20220214 con_no																																					--		14	
				, (case when strt_dt='19000101' then '00000000'  when  strt_dt	=	'' then '00000000' else strt_dt end) as strt_dt-- convert(char(8),strt_dt)--20220214 strt_dt																																					--		15	
				, (case when end_dt='19000101' then '00000000'  when  end_dt	=	'' then '00000000' else end_dt end) as end_dt--convert(char(8),end_dt)--20220214 end_dt																																					--		16	
				, CASE WHEN next_rset_rt_dt		= '19000101' THEN '00000000'  when  next_rset_rt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rset_rt_dt,112)	END		AS next_rset_rt_dt --convert(char(8),next_rset_rt_dt)--20220214 next_rset_rt_dt																																			--		17	
				, convert(char(1),int_pymt_arrs_ind) as int_pymt_arrs_ind--20220214 int_pymt_arrs_ind																																			--		18	
				, LEFT(ccy,4)	as ccy																		--		19	
				, convert(char(1),ocy_nom_amt_sign) as ocy_nom_amt_sign--20220214 ocy_nom_amt_sign																																			--		20	
	
			
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_nom_amt*10000))),19) as ocy_nom_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(ocy_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(ocy_nom_amt),19)))  							--		21	
				, convert(char(1),lcy_nom_amt_sign) as lcy_nom_amt_sign--20220214 lcy_nom_amt_sign																																			--		22	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_nom_amt*100))),19) as lcy_nom_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_nom_amt),19)))  							--		23	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(fcy_lc_amt*10000))),19)as fcy_lc_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(fcy_lc_amt),19)))),19) + LTRIM(RTRIM(STR(abs(fcy_lc_amt),19)))  							--		24	
				, convert(char(1),Lcy_reaj_amt_sing)as Lcy_reaj_amt_sing--20220214 Lcy_reaj_amt_sing																																			--		25	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_reaj_amt*100))),19)as Lcy_reaj_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_reaj_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_reaj_amt),19)))  						--		26			
				, convert(char(1),Ocy_int_amt_sing) as Ocy_int_amt_sing--20220214 Ocy_int_amt_sing																																			--		27	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Ocy_int_amt*10000))),19) as Ocy_int_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Ocy_int_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Ocy_int_amt),19)))  							--		28		
				, convert(char(1),Lcy_int_amt_sing) as Lcy_int_amt_sing--20220214 Lcy_int_amt_sing																																			--		29	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_int_amt*100))),19) as Lcy_int_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_int_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_int_amt),19)))  							--		30					
			


				, convert(char(2),fix_flting_ind) as fix_flting_ind--20220214 fix_flting_ind																																			--		31	
				, REPLICATE('0', 4 - DATALENGTH(LTRIM(RTRIM(STR(int_rt_cod))))) + LTRIM(RTRIM(STR(int_rt_cod)))		as int_rt_cod														--		32	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt*100000000))),16) as int_rt--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(int_rt),16)))),16) + LTRIM(RTRIM(STR(abs(int_rt),16)))  										--		33		
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt*100000000))),16)as pnlt_rt--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pnlt_rt),16)))),16) + LTRIM(RTRIM(STR(abs(pnlt_rt),16)))  									--		34				
				, convert(char(1),rt_meth) as rt_meth--20220214 rt_meth																																					--		35	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt*100000000))),16)as pool_rt--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pool_rt),16)))),16) + LTRIM(RTRIM(STR(abs(pool_rt),16)))  									--		36						
				, REPLICATE('0', 5 - DATALENGTH(LTRIM(RTRIM(STR(pool_rt_cod))))) + LTRIM(RTRIM(STR(pool_rt_cod))) as pool_rt_cod															--		37	
				, REPLICATE('0', 4 - DATALENGTH(LTRIM(RTRIM(STR(pnlt_rt_cod))))) + LTRIM(RTRIM(STR(pnlt_rt_cod)))	as pnlt_rt_cod														--		38	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt_sprd*100000000))),16) as int_rt_sprd--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(int_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(int_rt_sprd),16)))  							--		39	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pool_rt_sprd*100000000))),16) as pool_rt_sprd--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pool_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(pool_rt_sprd),16)))  							--		40	


				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt_sprd*100000000))),16)as pnlt_rt_sprd--20220214 SUBSTRING('0000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pnlt_rt_sprd),16)))),16) + LTRIM(RTRIM(STR(abs(pnlt_rt_sprd),16)))  							--		41	
				, convert(char(1),aset_liab_ind)as aset_liab_ind--20220214 aset_liab_ind																																				--		42	
				, convert(char(1),sbif_bal_no_rep_sign) as sbif_bal_no_rep_sign--20220214 sbif_bal_no_rep_sign																																		--		43	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(sbif_bal_no_rep*100))),19)as sbif_bal_no_rep--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_bal_no_rep),19)))),19) + LTRIM(RTRIM(STR(abs(sbif_bal_no_rep),19)))  					--		44							
				, right(replicate(0,3)+convert(varchar(3),convert(numeric(3),(sbif_tipo_tasa*1))),3)as sbif_tipo_tasa--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_tipo_tasa),3)))),3) + LTRIM(RTRIM(STR(abs(sbif_tipo_tasa),3)))  										--		45	
				, right(replicate(0,2)+convert(varchar(2),convert(numeric(2),(sbif_prod_trans*1))),2)as sbif_prod_trans--20220214 SUBSTRING('00',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_prod_trans),2)))),2) + LTRIM(RTRIM(STR(abs(sbif_prod_trans),2)))  										--		46	
				, right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(sbif_tipo_oper_trans*1))),1)as sbif_tipo_oper_trans--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_tipo_oper_trans),1)))),1) + LTRIM(RTRIM(STR(abs(sbif_tipo_oper_trans),1)))  							--		47	
				, convert(char(1),lcy_fee_amt_sign)as lcy_fee_amt_sign--20220214 lcy_fee_amt_sign																																			--		48	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_fee_amt*100))),19) as lcy_fee_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_fee_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_fee_amt),19)))  							--		49							
				, CASE WHEN orig_strt_dt		= '19000101' THEN '00000000'  when  orig_strt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),orig_strt_dt,112)	END		AS orig_strt_dt--convert(char(8),orig_strt_dt)--20220214 orig_strt_dt																																				--		50	
				,  CASE WHEN nacc_from_dt		= '19000101' THEN '00000000'  when  nacc_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),nacc_from_dt,112)	END		AS nacc_from_dt--convert(char(8),nacc_from_dt)--20220214 nacc_from_dt																																				--		51	
				,  CASE WHEN pdue_from_dt		= '19000101' THEN '00000000'  when  pdue_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),pdue_from_dt,112)	END		AS pdue_from_dt--convert(char(8),pdue_from_dt)--20220214 pdue_from_dt																																				--		52	
				,  CASE WHEN wrof_from_dt		= '19000101' THEN '00000000'  when  wrof_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),wrof_from_dt,112)	END		AS wrof_from_dt--convert(char(8),wrof_from_dt)--20220214 wrof_from_dt																																				--		53	
				, convert(char(20),orig_con_no)--20220214 orig_con_no																																				--		54	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_remn_coup*1))),4) as no_of_remn_coup--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_remn_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_remn_coup),4)))  									--		55	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_pdo_coup*1))),4) as no_of_pdo_coup--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_pdo_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_pdo_coup),4)))  										--		56	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_tot_coup*1))),4) as no_of_tot_coup--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_tot_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_tot_coup),4)))  										--		57	
				, right(replicate(0,3)+convert(varchar(3),convert(numeric(4),(sbif_dest_coloc*1))),3) as sbif_dest_coloc--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_dest_coloc),3)))),3) + LTRIM(RTRIM(STR(abs(sbif_dest_coloc),3)))  									--		58		
				,  CASE WHEN stop_accr_dt		= '19000101' THEN '00000000'  when  stop_accr_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),stop_accr_dt,112)	END		AS stop_accr_dt--convert(char(8),stop_accr_dt)--20220214 stop_accr_dt																																				--		59	
				,  CASE WHEN lst_int_pymt_dt	= '19000101' THEN '00000000'  when  lst_int_pymt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_int_pymt_dt,112)	END		AS lst_int_pymt_dt --convert(char(8),lst_int_pymt_dt)--20220214 lst_int_pymt_dt																																			--		60	


				, convert(char(1),ren_ind) as ren_ind--20220214 ren_ind																																					--		61	
				,  CASE WHEN lst_rset_dt		= '19000101' THEN '00000000'  when  lst_rset_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rset_dt,112)	END		AS lst_rset_dt--convert(char(8),lst_rset_dt)--20220214 lst_rset_dt																																				--		62	
				,  CASE WHEN next_rt_ch_dt		= '19000101' THEN '00000000'  when  next_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rt_ch_dt,112)	END		AS next_rt_ch_dt --convert(char(8),next_rt_ch_dt)--20220214 next_rt_ch_dt																																				--		63	
				,  CASE WHEN lst_rt_ch_dt		= '19000101' THEN '00000000'  when  lst_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rt_ch_dt,112)	END		AS lst_rt_ch_dt--convert(char(8),lst_rt_ch_dt)--20220214 lst_rt_ch_dt																																				--		64	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_orig_nom_amt*10000))),19) as ocy_orig_nom_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(ocy_orig_nom_amt),19)))),19) + LTRIM(RTRIM(STR(abs(ocy_orig_nom_amt),19)))  	--		65										
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_avl_bal*100))),19)as lcy_avl_bal--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_avl_bal),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_avl_bal),19)))  				--		66							
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo1_amt*100))),19)as lcy_pdo1_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo1_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo1_amt),19)))  			--		67								
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo2_amt*100))),19)as lcy_pdo2_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo2_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo2_amt),19)))  			--		68								
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_pdo3_amt*100))),19)as Lcy_pdo3_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_pdo3_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_pdo3_amt),19)))  			--		69								
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_oper_amt*100))),19)as lcy_oper_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_oper_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_oper_amt),19)))  			--		70												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(loc*100))),19) as loc--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(loc),19)))),19) + LTRIM(RTRIM(STR(abs(loc),19)))  								--		71			
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_mnpy*100))),19)as lcy_mnpy--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_mnpy),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_mnpy),19)))  					--		72						


				, convert(char(1),lgl_actn_ind) as lgl_actn_ind--20220214 lgl_actn_ind																																	--		73	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_mv*100))),19) as Lcy_mv--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_mv),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_mv),19)))  						--		74					
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_par_val*100))),19)as Lcy_par_val--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_par_val),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_par_val),19)))  				--		75										
				, right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(Port_typ*1))),1)as Port_typ--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(Port_typ),1)))),1) + LTRIM(RTRIM(STR(abs(Port_typ),1)))  										--		76	
				, right(replicate(0,3)+convert(varchar(3),convert(numeric(3),(No_rng*1))),3) as No_rng--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(No_rng),3)))),3) + LTRIM(RTRIM(STR(abs(No_rng),3))) 											--		77	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(Pdc_coup*1))),4)as Pdc_coup--20220214 REPLICATE('0', 4 - LEN(Pdc_coup)) + CAST(Pdc_coup AS varchar)																					--		78	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Pgo_amt*100))),19)as Pgo_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Pgo_amt),1)))),19) + LTRIM(RTRIM(STR(abs(Pgo_amt),19))) 						--		79	
				, convert(char(1),con_no_typ) as con_no_typ--20220214 con_no_typ																																	--		80	
				, convert(char(1),ope_typ) as ope_typ--20220214 ope_typ																																		--		81	


				, REPLICATE(' ', 2 - DATALENGTH(LTRIM(RTRIM(STR(mod_entr_bs))))) + LTRIM(RTRIM(STR(mod_entr_bs)))	 as mod_entr_bs											--		82	
				, right(replicate(0,12)+convert(varchar(12),convert(numeric(12),(opc_compra*100))),12) as opc_compra--20220214 SUBSTRING('000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(opc_compra),1)))),12) + LTRIM(RTRIM(STR(abs(opc_compra),12))) 						--		83	
				, REPLICATE(' ', 5 - LEN(LTRIM(RTRIM(ident_instr)))) + LTRIM(RTRIM(ident_instr))	as ident_instr															--		84	
				, REPLICATE(' ', 15 - DATALENGTH(LTRIM(RTRIM(ident_emi_instr)))) + LTRIM(RTRIM(ident_emi_instr))	as ident_emi_instr											--		85	--20220214 25
				, REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(serie_instr)))) + LTRIM(RTRIM(serie_instr))	as serie_instr															--		86	
				, REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(subserie_instr)))) + LTRIM(RTRIM(subserie_instr))	as subserie_instr														--		87	--20220214 2
				, REPLICATE(' ', 8 - LEN(LTRIM(RTRIM(cat_risk_instr)))) + LTRIM(RTRIM(cat_risk_instr))		as cat_risk_instr													--		88	
				, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(limit_rate*100000000))),16) as limit_rate--20220214 SUBSTRING('000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(limit_rate),1)))),16) + LTRIM(RTRIM(STR(abs(limit_rate),16)))						--		89	
				, right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(pdc_after_fix_per*1))),4) as pdc_after_fix_per--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdc_after_fix_per),1)))),4) + LTRIM(RTRIM(STR(abs(pdc_after_fix_per),4))) 					--		90	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo4_amt*1))),19) as lcy_pdo4_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo4_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo4_amt),19)))  			--		91												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo5_amt*1))),19) as lcy_pdo5_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo5_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo5_amt),19)))  			--		92												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo6_amt*1))),19) as lcy_pdo6_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo6_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo6_amt),19)))  			--		93												
				, convert(char(1),sbif_no_rep_ind) as sbif_no_rep_ind--20220214 sbif_no_rep_ind																																--		94

	

				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_otr_cont_amt*1))),19) as Lcy_otr_cont_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Lcy_otr_cont_amt),19)))),19) + LTRIM(RTRIM(STR(abs(Lcy_otr_cont_amt),19)))  	--		95														
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo7_amt*1))),19) as lcy_pdo7_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo7_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo7_amt),19)))  			--		96												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo8_amt*1))),19)as lcy_pdo8_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo8_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo8_amt),19)))  			--		97												
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo9_amt*1))),19) as lcy_pdo9_amt--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(lcy_pdo9_amt),19)))),19) + LTRIM(RTRIM(STR(abs(lcy_pdo9_amt),19)))  			--		98															
				, right(replicate(0,1)+convert(varchar(1),convert(numeric(1),(assets_origin*1))),1) as assets_origin--20220214 SUBSTRING('0',DATALENGTH(LTRIM(RTRIM(STR(abs(assets_origin),1)))),1) + LTRIM(RTRIM(STR(abs(assets_origin),1)))  								--		99		
				, CASE WHEN first_expiry_dt		= '19000101' THEN '00000000'  when  first_expiry_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),first_expiry_dt,112)	END		AS first_expiry_dt--convert(char(8),first_expiry_dt)--20220214 first_expiry_dt																																--		100	
				, convert(char(1),tip_otorg) as tip_otorg--20220214 tip_otorg																																		--		101	



				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(price_viv*1))),19) as price_viv--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(price_viv),19)))),19) + LTRIM(RTRIM(STR(abs(price_viv),19)))  					--		102																	
				, convert(char(1),tip_op_reneg) as tip_op_reneg--20220214 tip_op_reneg																																	--		103	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(mon_pie_pag_reneg*1))),19) as mon_pie_pag_reneg--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(mon_pie_pag_reneg),19)))),19) + LTRIM(RTRIM(STR(abs(mon_pie_pag_reneg),19)))  	--		104																								
				, convert(char(1),seg_rem_cred_hip) as seg_rem_cred_hip--20220214 seg_rem_cred_hip																																--		105	
				, right(replicate(0,8)+convert(varchar(8),convert(numeric(8),(pdue_from_oldest*1))),8) as pdue_from_oldest--20220214 SUBSTRING('00000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdue_from_oldest),1)))),8) + LTRIM(RTRIM(STR(abs(pdue_from_oldest),8))) 					--		106	
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(mon_prev_rng*100))),19) as mon_prev_rng--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(mon_prev_rng),19)))),19) + LTRIM(RTRIM(STR(abs(mon_prev_rng),19)))  			--		107																		
				, convert(char(1),exig_pago)as exig_pago--20220214 exig_pago																																		--		108	
				, CASE WHEN bidding_dt		= '19000101' THEN '00000000'  when  bidding_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),bidding_dt,112)	END		AS bidding_dt --convert(char(8),bidding_dt)--20220214 bidding_dt																																	--		109
				, CASE WHEN loan_disbursement_dt		= '19000101' THEN '00000000'  when  loan_disbursement_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),loan_disbursement_dt,112)	END		AS loan_disbursement_dt--convert(char(8),loan_disbursement_dt)--20220214 loan_disbursement_dt																															--		110		
				, CASE WHEN Accounting_dt		= '19000101' THEN '00000000'  when  Accounting_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),Accounting_dt,112)	END		AS Accounting_dt--convert(char(8),Accounting_dt)--20220214 Accounting_dt																																	--		111	
				, CASE WHEN last_payment_dt		= '19000101' THEN '00000000'  when  last_payment_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),last_payment_dt,112)	END	AS last_payment_dt--convert(char(8),last_payment_dt)--20220214 last_payment_dt																																--		112	

		
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(last_amount_paid*100))),19) as last_amount_paid--20220214 SSUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(last_amount_paid),19)))),19) + LTRIM(RTRIM(STR(abs(last_amount_paid),19)))  	--		113																						
				, CASE WHEN credit_line_approved_dt		= '19000101' THEN '00000000'  when  credit_line_approved_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),credit_line_approved_dt,112)	END		AS credit_line_approved_dt--convert(char(8),credit_line_approved_dt)--20220214 credit_line_approved_dt																														--		114		
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Amount_instalment*100))),19) as Amount_instalment--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Amount_instalment),19)))),19) + LTRIM(RTRIM(STR(abs(Amount_instalment),19)))  	--		115																						
				, right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Amount_revolving*100))),19) as Amount_revolving--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Amount_revolving),19)))),19) + LTRIM(RTRIM(STR(abs(Amount_revolving),19)))  	--		116																								
				, convert(char(1),Ind_credit_line_duration) as Ind_credit_line_duration--20220214 Ind_credit_line_duration																														--		117	
				, REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(nat_con_no)))) + LTRIM(RTRIM(nat_con_no))	as nat_con_no																--		118
		
				--20220214 + dest_finan																																	--		119
				--20220214 + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_post_coup),3)))),3) + LTRIM(RTRIM(STR(abs(no_post_coup),3))) 								--		120
				--20220214 + REPLICATE(' ', 2 - LEN(LTRIM(RTRIM(giro)))) + cast(giro as Varchar (2)	)																	--		121

				from @OP52
				order by cem, prod, con_no
   END
else
begin
	--SALIDAAQUI
	insert into @OP52_SALIDA
   		select 
				  convert(char(03),ctry)--20220214 ctry																																						--		1					
				+ (case when book_dt='19000101' then '00000000' else book_dt end) 	-- convert(char(08),book_dt,112)																																						--		2	
				+ (case when intf_dt='19000101' then '00000000' else intf_dt end)  	--convert(char(08),intf_dt,112)																																						--		3	
				+ convert(char(14),src_id)--20220214 src_id																																					--		4	
				+ convert(char(3),cem)--20220214 cem																																						--		5	
				+ convert(char(4),br)--20220214 br																																						--		6	
				+ convert(char(3),con_sta)--20220214 con_sta																																					--		7	
				+ convert(char(1),Dlnq_sta)--20220214 Dlnq_sta																																					--		8	
				+ convert(char(16),prod)--20220214 prod																																						--		9	
				+ (case when open_dt='19000101' then '00000000' when  open_dt	=	'' then '00000000' else open_dt end) --convert(char(8),open_dt)--20220214 open_dt																																					--		10	
				+ (case when lst_accr_dt='19000101' then '00000000' when  lst_accr_dt	=	'' then '00000000'else lst_accr_dt end) --convert(char(8),lst_accr_dt)--20220214 lst_accr_dt																																				--		11	
				+ convert(char(12),Ident_cli)--20220214 Ident_cli																																					--		12	
				+ convert(char(10),cc)--20220214 cc																																						--		13	
				+ left(con_no+space(20), 20)	--REPLICATE('0',20-LEN(LTRIM(RTRIM(con_no))))+LTRIM(RTRIM(con_no))--20220214 con_no																																					--		14	
				+ (case when strt_dt='19000101' then '00000000'  when  strt_dt	=	'' then '00000000' else strt_dt end) -- convert(char(8),strt_dt)--20220214 strt_dt																																					--		15	
				+ (case when end_dt='19000101' then '00000000'  when  end_dt	=	'' then '00000000' else end_dt end)--convert(char(8),end_dt)--20220214 end_dt																																					--		16	
				+ CASE WHEN next_rset_rt_dt		= '19000101' THEN '00000000'  when  next_rset_rt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rset_rt_dt,112)	END	--convert(char(8),next_rset_rt_dt)--20220214 next_rset_rt_dt																																			--		17	
				+ convert(char(1),int_pymt_arrs_ind)--20220214 int_pymt_arrs_ind																																			--		18	
				+ LEFT(ccy,4)																			--		19	
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
				+ CASE WHEN orig_strt_dt		= '19000101' THEN '00000000'  when  orig_strt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),orig_strt_dt,112)	END		--convert(char(8),orig_strt_dt)--20220214 orig_strt_dt																																				--		50	
				+  CASE WHEN nacc_from_dt		= '19000101' THEN '00000000'  when  nacc_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),nacc_from_dt,112)	END		--convert(char(8),nacc_from_dt)--20220214 nacc_from_dt																																				--		51	
				+  CASE WHEN pdue_from_dt		= '19000101' THEN '00000000'  when  pdue_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),pdue_from_dt,112)	END		--convert(char(8),pdue_from_dt)--20220214 pdue_from_dt																																				--		52	
				+  CASE WHEN wrof_from_dt		= '19000101' THEN '00000000'  when  wrof_from_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),wrof_from_dt,112)	END		--convert(char(8),wrof_from_dt)--20220214 wrof_from_dt																																				--		53	
				+ convert(char(20),orig_con_no)--20220214 orig_con_no																																				--		54	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_remn_coup*1))),4)--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_remn_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_remn_coup),4)))  									--		55	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_pdo_coup*1))),4)--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_pdo_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_pdo_coup),4)))  										--		56	
				+ right(replicate(0,4)+convert(varchar(4),convert(numeric(4),(no_of_tot_coup*1))),4)--20220214 SUBSTRING('0000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_of_tot_coup),4)))),4) + LTRIM(RTRIM(STR(abs(no_of_tot_coup),4)))  										--		57	
				+ right(replicate(0,3)+convert(varchar(3),convert(numeric(4),(sbif_dest_coloc*1))),3)--20220214 SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(sbif_dest_coloc),3)))),3) + LTRIM(RTRIM(STR(abs(sbif_dest_coloc),3)))  									--		58		
				+  CASE WHEN stop_accr_dt		= '19000101' THEN '00000000'  when  stop_accr_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),stop_accr_dt,112)	END		--convert(char(8),stop_accr_dt)--20220214 stop_accr_dt																																				--		59	
				+  CASE WHEN lst_int_pymt_dt	= '19000101' THEN '00000000'  when  lst_int_pymt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_int_pymt_dt,112)	END	--convert(char(8),lst_int_pymt_dt)--20220214 lst_int_pymt_dt																																			--		60	
				+ convert(char(1),ren_ind)--20220214 ren_ind																																					--		61	
				+  CASE WHEN lst_rset_dt		= '19000101' THEN '00000000'  when  lst_rset_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rset_dt,112)	END		--convert(char(8),lst_rset_dt)--20220214 lst_rset_dt																																				--		62	
				+  CASE WHEN next_rt_ch_dt		= '19000101' THEN '00000000'  when  next_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rt_ch_dt,112)	END		 --convert(char(8),next_rt_ch_dt)--20220214 next_rt_ch_dt																																				--		63	
				+  CASE WHEN lst_rt_ch_dt		= '19000101' THEN '00000000'  when  lst_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rt_ch_dt,112)	END		--convert(char(8),lst_rt_ch_dt)--20220214 lst_rt_ch_dt																																				--		64	
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
				+ CASE WHEN first_expiry_dt		= '19000101' THEN '00000000'  when  first_expiry_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),first_expiry_dt,112)	END		--convert(char(8),first_expiry_dt)--20220214 first_expiry_dt																																--		100	
				+ convert(char(1),tip_otorg)--20220214 tip_otorg																																		--		101	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(price_viv*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(price_viv),19)))),19) + LTRIM(RTRIM(STR(abs(price_viv),19)))  					--		102																	
				+ convert(char(1),tip_op_reneg)--20220214 tip_op_reneg																																	--		103	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(mon_pie_pag_reneg*1))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(mon_pie_pag_reneg),19)))),19) + LTRIM(RTRIM(STR(abs(mon_pie_pag_reneg),19)))  	--		104																								
				+ convert(char(1),seg_rem_cred_hip)--20220214 seg_rem_cred_hip																																--		105	
				+ right(replicate(0,8)+convert(varchar(8),convert(numeric(8),(pdue_from_oldest*1))),8)--20220214 SUBSTRING('00000000',DATALENGTH(LTRIM(RTRIM(STR(abs(pdue_from_oldest),1)))),8) + LTRIM(RTRIM(STR(abs(pdue_from_oldest),8))) 					--		106	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(mon_prev_rng*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(mon_prev_rng),19)))),19) + LTRIM(RTRIM(STR(abs(mon_prev_rng),19)))  			--		107																		
				+ convert(char(1),exig_pago)--20220214 exig_pago																																		--		108	
				+ CASE WHEN bidding_dt		= '19000101' THEN '00000000'  when  bidding_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),bidding_dt,112)	END		--convert(char(8),bidding_dt)--20220214 bidding_dt																																	--		109
				+ CASE WHEN loan_disbursement_dt		= '19000101' THEN '00000000'  when  loan_disbursement_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),loan_disbursement_dt,112)	END		--convert(char(8),loan_disbursement_dt)--20220214 loan_disbursement_dt																															--		110		
				+ CASE WHEN Accounting_dt		= '19000101' THEN '00000000'  when  Accounting_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),Accounting_dt,112)	END		--convert(char(8),Accounting_dt)--20220214 Accounting_dt																																	--		111	
				+ CASE WHEN last_payment_dt		= '19000101' THEN '00000000'  when  last_payment_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),last_payment_dt,112)	END	--convert(char(8),last_payment_dt)--20220214 last_payment_dt																																--		112	
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(last_amount_paid*100))),19)--20220214 SSUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(last_amount_paid),19)))),19) + LTRIM(RTRIM(STR(abs(last_amount_paid),19)))  	--		113																						
				+ CASE WHEN credit_line_approved_dt		= '19000101' THEN '00000000'  when  credit_line_approved_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),credit_line_approved_dt,112)	END		--convert(char(8),credit_line_approved_dt)--20220214 credit_line_approved_dt																														--		114		
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Amount_instalment*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Amount_instalment),19)))),19) + LTRIM(RTRIM(STR(abs(Amount_instalment),19)))  	--		115																						
				+ right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Amount_revolving*100))),19)--20220214 SUBSTRING('0000000000000000000',DATALENGTH(LTRIM(RTRIM(STR(abs(Amount_revolving),19)))),19) + LTRIM(RTRIM(STR(abs(Amount_revolving),19)))  	--		116																								
				+ convert(char(1),Ind_credit_line_duration)--20220214 Ind_credit_line_duration																														--		117	
				+ REPLICATE(' ', 4 - LEN(LTRIM(RTRIM(nat_con_no)))) + LTRIM(RTRIM(nat_con_no))																	--		118
		
				--20220214 + dest_finan																																	--		119
				--20220214 + SUBSTRING('000',DATALENGTH(LTRIM(RTRIM(STR(abs(no_post_coup),3)))),3) + LTRIM(RTRIM(STR(abs(no_post_coup),3))) 								--		120
				--20220214 + REPLICATE(' ', 2 - LEN(LTRIM(RTRIM(giro)))) + cast(giro as Varchar (2)	)																	--		121

				from @OP52

--				union
--				select @Pie_Archivo

				select * from @OP52_SALIDA order by len(reg_salida) desc 
				
				drop table #NEOSOFT
				drop table #VALMON
				drop table #VALOR_TC_CONTABLE
				drop table #Operaciones
				drop table #FluCarVig
END
   SET NOCOUNT OFF
END

GO
