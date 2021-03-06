USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[OP50]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--dbo.OP50 '20220324'
CREATE PROCEDURE [dbo].[OP50] (   @dFechaProceso DATETIME   )
AS
BEGIN	

--declare @dFechaProceso DateTime
--set  @dFechaProceso ='20220329'

	SET NOCOUNT ON


	/*DECLARACION DE VARIABLES*/

	DECLARE @FecAnt				DATETIME
	---select 1/0
	DECLARE @nValorDolarDia		FLOAT
		SET @nValorDolarDia		=	(	SELECT	TOP 1 vmvalor 
										FROM	MdParPasivo.dbo.Valor_Moneda 
										WHERE	vmfecha		= @dFechaProceso 
										and		vmcodigo	= 994
										and		vmvalor		<> 0
									)

	/*FIN DECLARACION*/
	DECLARE @SALIDA_INT TABLE (REG_SALIDA VARCHAR(1240)	
		,	ORDEN	NUMERIC(21)
		)

	DECLARE @INT_OPE TABLE (	
         /*01*/	ctry					VARCHAR(3),
		/*02*/	book_dt					CHAR(8),
		/*03*/	intf_dt					CHAR(8),
		/*04*/	src_id					VARCHAR(14),
		/*05*/	br						VARCHAR(4),
		/*06*/	cem						VARCHAR(3),--20220214
		/*07*/	con_sta					VARCHAR(3),
		/*08*/	Dlnq_sta				VARCHAR(1),
		/*09*/	prod					VARCHAR(16),
		/*10*/	open_dt					CHAR(8),
		/*11*/	lst_accr_dt				CHAR(8),
		/*12*/	Iden_cli				VARCHAR(12),
		/*13*/	cc						VARCHAR(10),
		/*14*/	con_no					VARCHAR(20),
		/*15*/	strt_dt					CHAR(8),
		/*16*/	end_dt					CHAR(8),
		/*17*/	next_rset_rt_dt			CHAR(8),
		/*18*/	int_pymt_arrs_ind 		VARCHAR(1),
		/*19*/	ccy						CHAR(4),
		/*20*/	ocy_nom_amt_sign		VARCHAR(1),

		/*21*/	ocy_nom_amt				NUMERIC(19,4),--20220214 NUMERIC(19,2)
		/*22*/	lcy_nom_amt_sign		VARCHAR(1),
		
		/*23*/	lcy_nom_amt				NUMERIC(19,2),
		/*24*/	fcy_lc_amt				NUMERIC(19,2),
		/*25*/	Lcy_reaj_amt_sing		VARCHAR(1),
		/*26*/	Lcy_reaj_amt			NUMERIC(19,2),
		/*27*/	Ocy_int_amt_sing		VARCHAR(1),
		/*28*/	Ocy_int_amt				NUMERIC(19,2),
		/*29*/	Lcy_int_amt_sing		VARCHAR(1),
		/*30*/	Lcy_int_amt				NUMERIC(19,2),
		/*31*/	fix_flting_ind			VARCHAR(2),
		/*32*/	int_rt_cod				VARCHAR(4),
		/*33*/	int_rt					NUMERIC(16,8),
		/*34*/	pnlt_rt					DECIMAL(16,8),--NUMERIC(16,8),
		/*35*/	rt_meth					VARCHAR(1),
		/*36*/	pool_rt					NUMERIC(16,8),
		/*37*/	pool_rt_cod				VARCHAR(5),
		/*38*/	pnlt_rt_cod				VARCHAR(4),
		/*39*/	int_rt_sprd				NUMERIC(16,8),
		/*40*/	pool_rt_sprd			NUMERIC(16,8),
		/*41*/	pnlt_rt_sprd			NUMERIC(16,8),
		/*42*/	aset_liab_ind			VARCHAR(1),
		/*43*/	sbif_bal_no_rep_sign	VARCHAR(1),
		/*44*/	sbif_bal_no_rep			NUMERIC(19,2),
		/*45*/	sbif_tipo_tasa			NUMERIC(3,0),
		/*46*/	sbif_prod_trans			NUMERIC(2,0),
		/*47*/	sbif_tipo_oper_trans	NUMERIC(1,0),
		/*48*/	lcy_fee_amt_sign		VARCHAR(1),
		/*49*/	lcy_fee_amt				NUMERIC(19,2),
		/*50*/	orig_strt_dt			CHAR(8),
		/*51*/	nacc_from_dt			CHAR(8),
		/*52*/	pdue_from_dt			CHAR(8),
		/*53*/	wrof_from_dt			CHAR(8),
		/*54*/	orig_con_no				VARCHAR(20),
		/*55*/	no_of_remn_coup			NUMERIC(4,0),
		/*56*/	no_of_pdo_coup			NUMERIC(4,0),
		/*57*/	no_of_tot_coup			NUMERIC(4,0),
		/*58*/	sbif_dest_coloc			CHAR(03),
		/*59*/	stop_accr_dt			CHAR(8),
		/*60*/	lst_int_pymt_dt			CHAR(8),
		/*61*/	ren_ind					VARCHAR(1),
		/*62*/	lst_rset_dt				CHAR(8),
		/*63*/	next_rt_ch_dt			CHAR(8),
		/*64*/	lst_rt_ch_dt			CHAR(8),
		/*65*/	ocy_orig_nom_amt		NUMERIC(19,2),
		/*66*/	lcy_avl_bal				NUMERIC(19,2),
		/*67*/	lcy_pdo1_amt			NUMERIC(19,2),
		/*68*/	lcy_pdo2_amt			NUMERIC(19,2),
		/*69*/	Lcy_pdo3_amt			NUMERIC(19,2),
		/*70*/	lcy_oper_amt			NUMERIC(19,2),
		/*71*/	loc						NUMERIC(19,2),
		/*72*/	lcy_mnpy				NUMERIC(19,2),
		/*73*/	lgl_actn_ind			VARCHAR(1),
		/*74*/	Lcy_mv					NUMERIC(19,2),
		/*75*/	Lcy_par_val				NUMERIC(19,2),
		/*76*/	Port_typ				NUMERIC(1,0),
		/*77*/	No_rng					NUMERIC(3,0),
		/*78*/	Pdc_coup				NUMERIC(4,0),
		/*79*/	Pgo_amt					NUMERIC(19,2),
		/*80*/	con_no_typ				VARCHAR(1),
		/*81*/	ope_typ					VARCHAR(1),
		/*82*/	mod_entr_bs				VARCHAR(2),
		/*83*/	opc_compra				NUMERIC(12,2),
		/*84*/	ident_instr				VARCHAR(5),
		/*85*/	ident_emi_instr			VARCHAR(15),
		/*86*/	serie_instr				VARCHAR(4),
		/*87*/	subserie_instr			VARCHAR(4),
		/*88*/	cat_risk_instr			VARCHAR(3),
		/*89*/ 	limit_rate				NUMERIC(16,8),
		/*90*/ 	pdc_after_fix_per		NUMERIC(4,0),
	
		/*91*/ 	ID_TABLA 				NUMERIC IDENTITY,
		/*92*/ 	mSerie					VARCHAR(20),
		/*93*/ 	mNominal				NUMERIC(19,4),
		/*94*/ 	CodInterProd  			CHAR(16),
		/*95*/  Valor_Moneda            NUMERIC(19,4) -- MNAVARRO 20190304
	)

	select vmcodigo, vmfecha, vmvalor  into #VALOR_MONEDA
	from MDPasivo..VIEW_VALOR_MONEDA where vmfecha = @dFechaProceso
	insert into #VALOR_MONEDA
	select 13, @dFechaProceso, vmvalor from  #VALOR_MONEDA where vmcodigo = 994
	union
	select  1, @dFechaProceso, 1.0     

	--PARA SABER NRO DE OPERACION Y CORRELATIVO DE OPERACION POR SEPARADO
	CREATE TABLE #Operaciones(	Nro_Operacion					NUMERIC (10),	Cor_Operacion					NUMERIC (10),	Operac_SIGIR					VARCHAR(20))

--+ JPL
	IF (SELECT Fecha_Proceso FROM MDPasivo..VIEW_DATOS_GENERALES) = @dFechaProceso BEGIN 
		SELECT   @FecAnt	=  Fecha_Anterior
		FROM     MDPasivo..VIEW_DATOS_GENERALES

		INSERT INTO @INT_OPE
		SELECT
		/*01*/	'ctry'						=	'CL ',
		/*02*/	'book_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
		/*03*/	'intf_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),--(SELECT @dFechaProceso),
		/*04*/	'src_id'					=	'OPC3',
		/*05*/	'br'						=	'0011',
		/*06*/	'cem'						=	'001',
		/*07*/	'con_sta'					=	'A  ',
		/*08*/	'Dlnq_sta'					=	'1',
		/*09*/	'prod'						=	'MD01',
		/*10*/	'open_dt'					=	'',
		/*11*/	'lst_accr_dt'				=	'',
		/*12*/	'Iden_cli'					=	'000970230009',
		/*13*/	'cc'						=	'          ',
		/*14*/	'con_no'				    =	LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
		/*15*/	'strt_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112))	,
		/*16*/	'end_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Vencimiento,112))	,
		/*17*/	'next_rset_rt_dt' 			=	'',
		/*18*/	'int_pymt_arrs_ind' 		=	'A',
		/*19*/	'ccy'						=	m.mncodbkb,
		/*20*/	'ocy_nom_amt_sign'			=	'+',
		/*21*/	'ocy_nom_amt'				=	P.valor_colocacion_um,
		/*22*/	'lcy_nom_amt_sign'			=	'+',
--		/*23*/	'lcy_nom_amt'				=	P.Valor_colocacion_clp,
		/*23*/	'lcy_nom_amt'				=	CASE WHEN P.moneda_emision not in ( 999,998,994,997) THEN ROUND(P.Valor_colocacion_clp * vmValor, 0) ELSE P.Valor_colocacion_clp END,
		/*24*/	'fcy_lc_amt'				=	0,
		/*25*/	'Lcy_reaj_amt_sing'			=	CASE WHEN reajuste_colocacion >= 0 THEN '+' ELSE '-' END, 
		/*26*/	'Lcy_reaj_amt'				=	ABS(reajuste_colocacion) , 
		/*27*/	'Ocy_int_amt_sing'			=	CASE WHEN interes_colocacion >= 0 THEN '+' ELSE '-' END, 
		/*28*/	'Ocy_int_amt'				=	CONVERT(NUMERIC(19,2),(interes_colocacion / ISNULL((	SELECT	CONVERT(NUMERIC(19,2),vmvalor) FROM	MDPasivo..VIEW_VALOR_MONEDA WHERE	vmcodigo = ( case when moneda_emision in ( 994,998,997) then moneda_emision else 0  end ) AND		VMFECHA = @dFechaProceso ) , 1 ))), 
		/*29*/	'Lcy_int_amt_sing'			=	CASE WHEN interes_colocacion >= 0 THEN '+' ELSE '-' END,
		/*30*/	'Lcy_int_amt'				=	ABS(interes_colocacion),
		/*31*/	'fix_flting_ind'			=	'F',
		/*32*/	'int_rt_cod'				=	'',
		/*33*/	'int_rt'					=	P.Tasa_Emision,
		/*34*/	'pnlt_rt'					=	P.Tasa_Colocacion,
		/*35*/	'rt_meth'					=	'0',
		/*36*/	'pool_rt'					=	0,
		/*37*/	'pool_rt_cod'				=	'',
		/*38*/	'pnlt_rt_cod'				=	'',
		/*39*/	'int_rt_sprd'				=	0,
		/*40*/	'pool_rt_sprd'				=	0,
		/*41*/	'pnlt_rt_sprd'				=	0,
		/*42*/	'aset_liab_ind'				=	'P',
		/*43*/	'sbif_bal_no_rep_sign'		=	'',
		/*44*/	'sbif_bal_no_rep'		    =	0,
		/*45*/	'sbif_tipo_tasa'			=	0,
		/*46*/	'sbif_prod_trans'			=	0,
		/*47*/	'sbif_tipo_oper_trans'		=	1,
		/*48*/	'lcy_fee_amt_sign'			=	'+',
		/*49*/	'lcy_fee_amt'				=	0,
		/*50*/	'orig_strt_dt'				=	'', 
		/*51*/	'nacc_from_dt'				=	'',
		/*52*/	'pdue_from_dt'				=	'',
		/*53*/	'wrof_from_dt'				=	'',
		/*54*/	'orig_con_no'				=	'',
		/*55*/	'no_of_remn_coup'			=	(SELECT COUNT(*) FROM MDPasivo..FLUJO_BONOS SB WHERE SB.Nombre_Serie = P.Nombre_Serie AND SB.Fecha_Vencimiento >= @dFechaProceso),
		/*56*/	'no_of_pdo_coup'			=	0,
		/*57*/	'no_of_tot_coup'			=	(SELECT Cupones FROM MDPasivo..SERIE_PASIVO SP WHERE SP.Nombre_Serie = P.Nombre_Serie),
		/*58*/	'sbif_dest_coloc'			=	'000',
		/*59*/	'stop_accr_dt'				=	'',
		/*60*/	'lst_int_pymt_dt'			=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*61*/  'ren_ind'					=	'',
		/*62*/	'lst_rset_dt'				=	'',
		/*63*/	'next_rt_ch_dt'				=	'',
		/*64*/	'lst_rt_ch_dt'				=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*65*/	'ocy_orig_nom_amt'			=	P.Valor_colocacion_UM,
		/*66*/	'lcy_avl_bal'				=	0,
		/*67*/	'lcy_pdo1_amt'				=	0,
		/*68*/	'lcy_pdo2_amt'				=	0,
		/*69*/	'Lcy_pdo3_amt'				=	0,
		/*70*/	'lcy_oper_amt'				=	0,
		/*71*/	'loc'						=	0,
		/*72*/	'lcy_mnpy'					=	0,
		/*73*/	'lgl_actn_ind'				=	'',
		/*74*/	'Lcy_mv'					=	0,
		/*75*/	'Lcy_par_val'				=	0,
		/*76*/	'Port_typ'					=	0,
		/*77*/	'No_rng'					=	0,
		/*78*/	'Pdc_coup'					=	9999,
		/*79*/	'Pgo_amt'					=	0, 
		/*80*/	'con_no_typ'				=	'',
		/*81*/	'ope_typ'					=	'',
		/*82*/	'mod_entr_bs'				=	'',
		/*83*/	'opc_compra'				=	0,
		/*84*/	'ident_instr'				=   '',
		/*85*/	'ident_emi_instr'			=	'',
		/*86*/	'serie_instr'				=	'',
		/*87*/	'subserie_instr'			=	'',
		/*88*/	'cat_risk_instr'			=	'',
		/*89*/ 	'limit_rate'				=	0,
		/*90*/ 	'pdc_after_fix_per'			=	0,
		/*91*/ 	'mSerie'					=	P.Nombre_Serie,
		/*92*/ 	'mNominal'					=	P.Nominal,
		/*93*/ 	'CodInterProd'  			=	'MD01' ,--'BONOS',
		        'Valor_moneda'              = V.vmvalor
		FROM	MDPasivo..CARTERA_PASIVO P
		        left join #VALOR_MONEDA V on v.vmcodigo = P.moneda_emision 
				inner join BacParamSuda..MONEDA m	with(nolock) On m.mncodmon	= P.Moneda_Emision
		,		MDPasivo..VIEW_DATOS_GENERALES
		WHERE	P.Codigo_Instrumento	IN(1,15) 
		AND		estado_operacion		<> 'A'
		AND		fecha_vencimiento		>= @dFechaProceso
		AND		P.nombre_serie			NOT LIKE ('%GAST%')


		/*INGRESO DE DEPOSITOS A PLAZOS*/
		INSERT INTO @INT_OPE
		SELECT
		/*01*/	'ctry'						=	'CL ',
			/*02*/	'book_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
		/*03*/	'intf_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),--(SELECT @dFechaProceso),
		/*04*/	'src_id'					=	'OPC3',
		/*05*/	'br'				        =	'0011',
		/*06*/	'cem'						=	'001',
		/*07*/	'con_sta'					=	'A  ',
		/*08*/	'Dlnq_sta'					=	'1',
		/*09*/	'prod'						=	'MD01',--'BONOS' ,
		/*10*/	'open_dt'					=	'',
		/*11*/	'lst_accr_dt'				=	'',
		/*12*/	'Iden_cli'					=	'000970230009' ,--LTRIM(RTRIM(STR(Rut_Entidad)))+Digito_Entidad , 
		/*13*/	'cc'						=	'          ',
		/*14*/	'con_no'					=	LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
		/*15*/	'strt_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*16*/	'end_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Vencimiento,112)),
		/*17*/	'next_rset_rt_dt' 			=	'',
		/*18*/	'int_pymt_arrs_ind' 		=	'A',
		/*19*/	'ccy'						=	m.mncodbkb,
		/*20*/	'ocy_nom_amt_sign'			=	'+',
		/*21*/	'ocy_nom_amt'				=	P.valor_COLOCACION_um,
		/*22*/	'lcy_nom_amt_sign'			=	'+',
		/*23*/	'lcy_nom_amt'				=	P.Valor_COLOCACION_CLP,
		/*24*/	'fcy_lc_amt'				=	0,
		/*25*/	'Lcy_reaj_amt_sing'			=	CASE WHEN reajuste_COLOCACION >= 0 THEN '+' ELSE '-' END,
 		/*26*/	'Lcy_reaj_amt'				=	ABS(reajuste_COLOCACION), 
		/*27*/	'Ocy_int_amt_sing'			=	CASE WHEN interes_COLOCACION >= 0 THEN '+' ELSE '-' END, 
		/*28*/	'Ocy_int_amt'				=	CONVERT(NUMERIC(19,2),(interes_COLOCACION / ISNULL((SELECT	CONVERT(NUMERIC(19,2),vmvalor) FROM	MDPasivo..VIEW_VALOR_MONEDA WHERE	vmcodigo =  ( case when moneda_emision in ( 994,998,997) then moneda_emision else 0  end )  AND		VMFECHA = @dFechaProceso ) , 1 ))), 
		/*29*/	'Lcy_int_amt_sing'			=	CASE WHEN interes_COLOCACION >= 0 THEN '+' ELSE '-' END,
		/*30*/	'Lcy_int_amt'				=	ABS(interes_COLOCACION),
		/*31*/	'fix_flting_ind'			=	'F',
		/*32*/	'int_rt_cod'				=	'',
		/*33*/	'int_rt'					=	P.Tasa_Emision,
		/*34*/	'pnlt_rt'					=	P.Tasa_Colocacion,
		/*35*/	'rt_meth'					=	'0',
		/*36*/	'pool_rt'					=	0,
		/*37*/	'pool_rt_cod'				=	'',
		/*38*/	'pnlt_rt_cod'				=	'',
		/*39*/	'int_rt_sprd'				=	0,
		/*40*/	'pool_rt_sprd'				=	0,
		/*41*/	'pnlt_rt_sprd'				=	0,
		/*42*/	'aset_liab_ind'				=	'P',
		/*43*/	'sbif_bal_no_rep_sign'		=	'',
		/*44*/	'sbif_bal_no_rep'			=	0,
		/*45*/	'sbif_tipo_tasa'			=	0,
		/*46*/	'sbif_prod_trans'			=	0,
		/*47*/	'sbif_tipo_oper_trans'		=	1,
		/*48*/	'lcy_fee_amt_sign'			=	'+',
		/*49*/	'lcy_fee_amt'				=	0,
		/*50*/	'orig_strt_dt'				=	'', 
		/*51*/	'nacc_from_dt'				=	'',
		/*52*/	'pdue_from_dt'				=	'',
		/*53*/	'wrof_from_dt'				=	'',
		/*54*/	'orig_con_no'				=	'',
		/*55*/	'no_of_remn_coup'			=	1, --> UN SOLO CUPON
		/*56*/	'no_of_pdo_coup'			=	0,
		/*57*/	'no_of_tot_coup'			=	1, --> UN SOLO CUPON
		/*58*/	'sbif_dest_coloc'			=	'000',
		/*59*/	'stop_accr_dt'				=	'',
		/*60*/	'lst_int_pymt_dt'			=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*61*/	'ren_ind'					=	'',
		/*62*/	'lst_rset_dt'				=	'',
		/*63*/	'next_rt_ch_dt'				=	'',
		/*64*/	'lst_rt_ch_dt'				=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*65*/	'ocy_orig_nom_amt'			=	P.Valor_COLOCACION_UM,
		/*66*/	'lcy_avl_bal'				=	0,
		/*67*/	'lcy_pdo1_amt'				=	0,
		/*68*/	'lcy_pdo2_amt'				=	0,
		/*69*/	'Lcy_pdo3_amt'				=	0,
		/*70*/	'lcy_oper_amt'				=	0,
		/*71*/	'loc'						=	0,
		/*72*/	'lcy_mnpy'					=	0,
		/*73*/	'lgl_actn_ind'				=	'',
		/*74*/	'Lcy_mv'					=	0,
		/*75*/	'Lcy_par_val'				=	0,
		/*76*/	'Port_typ'					=	0,
		/*77*/	'No_rng'					=	0,
		/*78*/	'Pdc_coup'					=	9999,
		/*79*/	'Pgo_amt'					=	0, 
		/*80*/	'con_no_typ'				=	'',
		/*81*/	'ope_typ'					=	'',
		/*82*/	'mod_entr_bs'				=	'',
		/*83*/	'opc_compra'				=	0,
		/*84*/	'ident_instr'				=	'',
		/*85*/	'ident_emi_instr'			=	'',
		/*86*/	'serie_instr'				=	'',
		/*87*/	'subserie_instr'			=	'',
		/*88*/	'cat_risk_instr'			=	'',
		/*89*/ 	'limit_rate'				=	0,
		/*90*/ 	'pdc_after_fix_per'			=	0,
		/*91*/ 	'mSerie'					=	P.Nombre_Serie,
		/*92*/ 	'mNominal'					=	P.Nominal,
		/*93*/ 	'CodInterProd'  			=	'MD01' , --'BONOS'
		        'Valor_moneda'              =   V.Vmvalor
		FROM	MDPasivo..CARTERA_PASIVO P
				left join #VALOR_MONEDA V on v.vmcodigo = P.moneda_emision 
				inner join BacParamSuda..MONEDA m	with(nolock) On m.mncodmon	= P.Moneda_Emision
			,	MDPasivo..VIEW_DATOS_GENERALES
		WHERE	P.Codigo_Instrumento	IN(9,11) --> VB+- 29032010 
		AND		estado_operacion		<> 'A'
		AND		fecha_vencimiento		>= @dFechaProceso
		AND		P.nombre_serie			NOT LIKE ('%GAST%')


		/*INGRESO DE CORFOS*/

		INSERT INTO @INT_OPE
		SELECT
		/*01*/	'ctry'						=	'CL ',
		/*02*/	'book_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
		/*03*/	'intf_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),--(SELECT @dFechaProceso),
		/*04*/	'src_id'					=	'OPC3',
		/*05*/	'br'						=	'0011',
		/*06*/	'cem'						=	'001', 
		/*07*/	'con_sta'					=	'A  ',
		/*08*/	'Dlnq_sta'					=	'1',
		/*09*/	'prod'		=	'MD01',
		/*10*/	'open_dt'					=	'',
		/*11*/	'lst_accr_dt'				=	'',
		/*12*/	'Iden_cli'					=	'000607060002' ,
		/*13*/	'cc'						=	'          ',
		/*14*/	'con_no'					=	LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
		/*15*/	'strt_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*16*/	'end_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Vencimiento,112)),
		/*17*/	'next_rset_rt_dt' 			=	'',
		/*18*/	'int_pymt_arrs_ind' 		=	'A',
		/*19*/	'ccy'						=	m.mncodbkb,
		/*20*/	'ocy_nom_amt_sign'			=	'+',
		/*21*/	'ocy_nom_amt'				=	P.valor_emision_um,
		/*22*/	'lcy_nom_amt_sign'			=	'+',
		/*23*/	'lcy_nom_amt'				=	P.Valor_emision_pesos,
		/*24*/	'fcy_lc_amt'				=	0,
		/*25*/	'Lcy_reaj_amt_sing'			=	CASE WHEN reajuste_emision >= 0 THEN '+' ELSE '-' END, 
		/*26*/	'Lcy_reaj_amt'				=	ABS(reajuste_emision) , 
		/*27*/	'Ocy_int_amt_sing'			=	CASE WHEN interes_emision >= 0 THEN '+' ELSE '-' END, 
		/*28*/	'Ocy_int_amt'				=	CONVERT(NUMERIC(19,2),(interes_emision / ISNULL((	SELECT	CONVERT(NUMERIC(19,2),vmvalor) FROM	MDPasivo..VIEW_VALOR_MONEDA WHERE	vmcodigo =  ( case when moneda_emision in ( 994,998,997) then moneda_emision else 0  end )  AND		VMFECHA = @dFechaProceso ) , 1 ))), 
		/*29*/	'Lcy_int_amt_sing'			=	CASE WHEN interes_emision >= 0 THEN '+' ELSE '-' END,
		/*30*/	'Lcy_int_amt'				=	ABS(interes_emision),
		/*31*/	'fix_flting_ind'			=	'F',
		/*32*/	'int_rt_cod'				=	'',
		/*33*/	'int_rt'					=	P.Tasa_Emision,
		/*34*/	'pnlt_rt'					=	P.Tasa_Colocacion,
		/*35*/	'rt_meth'					=	'0',
		/*36*/	'pool_rt'					=	0,
		/*37*/	'pool_rt_cod'				=	'',
		/*38*/	'pnlt_rt_cod'				=	'',
		/*39*/	'int_rt_sprd'				=	0,
		/*40*/	'pool_rt_sprd'				=	0,
		/*41*/	'pnlt_rt_sprd'				=	0,
		/*42*/	'aset_liab_ind'				=	'P', 
		/*43*/	'sbif_bal_no_rep_sign'		=	'',
		/*44*/	'sbif_bal_no_rep'	        =	0,
		/*45*/	'sbif_tipo_tasa'			=	0,
		/*46*/	'sbif_prod_trans'			=	0,
		/*47*/	'sbif_tipo_oper_trans'		=	1,
		/*48*/	'lcy_fee_amt_sign'			=	'+',
		/*49*/	'lcy_fee_amt'				=	0,
		/*50*/	'orig_strt_dt'				=	'', 
		/*51*/	'nacc_from_dt'				=	'',
		/*52*/  'pdue_from_dt'				=	'',
		/*53*/	'wrof_from_dt'				=	'',
		/*54*/	'orig_con_no'				=	'',
		/*55*/	'no_of_remn_coup'			=	(SELECT COUNT(*) FROM MDPasivo..FLUJO_CREDITOS FC WHERE FC.codigo_instrumento = P.codigo_instrumento AND FC.cuota_vencimiento >= @dFechaProceso),
		/*56*/	'no_of_pdo_coup'			=	0,
		/*57*/	'no_of_tot_coup'			=	ISNULL((	SELECT	MAX(FC.cuota_correlativo) FROM	MDPasivo..FLUJO_CREDITOS FC WHERE	FC.numero_operacion = P.Numero_Operacion),0),
		/*58*/	'sbif_dest_coloc'			=	'000',
		/*59*/	'stop_accr_dt'				=	'',
		/*60*/	'lst_int_pymt_dt'			=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*61*/	'ren_ind'					=	'',
		/*62*/	'lst_rset_dt'				=	'',
		/*63*/	'next_rt_ch_dt'				=	'',
		/*64*/	'lst_rt_ch_dt'				=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*65*/	'ocy_orig_nom_amt'		    =	P.Valor_emision_UM,
		/*66*/	'lcy_avl_bal'				=	0,
		/*67*/	'lcy_pdo1_amt'				=	0,
		/*68*/	'lcy_pdo2_amt'				=	0,
		/*69*/	'Lcy_pdo3_amt'				=	0,
		/*70*/	'lcy_oper_amt'				=	0,
		/*71*/	'loc'						=	0,
		/*72*/	'lcy_mnpy'					=	0,
		/*73*/	'lgl_actn_ind'				=	'',
		/*74*/	'Lcy_mv'					=	0,
		/*75*/	'Lcy_par_val'				=	0,
		/*76*/	'Port_typ'					=	0,
		/*77*/	'No_rng'					=	0,
		/*78*/	'Pdc_coup'					=	9999,
		/*79*/	'Pgo_amt'					=	0,
 		/*80*/	'con_no_typ'				=	'',
		/*81*/	'ope_typ'					=	'',
		/*82*/	'mod_entr_bs'				=	'',
		/*83*/	'opc_compra'				=	0,
		/*84*/	'ident_instr'				=	'',
		/*85*/	'ident_emi_instr'			=	'',
		/*86*/	'serie_instr'				=	'',
		/*87*/	'subserie_instr'			=	'',
		/*88*/	'cat_risk_instr'			=	'',
		/*89*/ 	'limit_rate'				=	0,
		/*90*/ 	'pdc_after_fix_per'			=	0,
				'mSerie'					=	P.Nombre_Serie,
				'mNominal'					=	P.Nominal,
				'CodInterProd'  			=	'MD01',
	            'Valor_moneda'              = V.Vmvalor
	FROM	MDPasivo..CARTERA_PASIVO P
       left join #VALOR_MONEDA V on v.vmcodigo = P.moneda_emision 
	   inner join BacParamSuda..MONEDA m	with(nolock) On m.mncodmon	= P.Moneda_Emision
	,	MDPasivo..VIEW_DATOS_GENERALES
		WHERE	P.Codigo_Instrumento		NOT IN (1,15,9,11)  
		AND		estado_operacion			<>	'A' 
		AND		fecha_vencimiento			>=	@dFechaProceso 

	
		INSERT INTO @INT_OPE
		SELECT
		/*01*/	'ctry'						=	'CL ',
		/*02*/	'book_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
		/*03*/	'intf_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),--(SELECT @dFechaProceso),
		/*04*/	'src_id'					=	'OPC3',
		/*05*/	'br'						=	'0011',
		/*06*/	'cem'						=	'001', 
		/*07*/	'con_sta'					=	CASE WHEN @dFechaProceso > P.fecha_movimiento THEN 'C  ' ELSE 'A  '	END,
		/*08*/	'Dlnq_sta'					=	'1',
		/*09*/	'prod'						=	(SELECT Codigo_Producto FROM MDPasivo..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) ,
		/*10*/	'open_dt'					=	'',
	    /*11*/	'lst_accr_dt'				=	'',
		/*12*/	'Iden_cli'					=	right(replicate('0',12)+convert(varchar(10),Rut_Entidad)+Digito_Entidad,12),--LTRIM(RTRIM(STR(Rut_Entidad)))+Digito_Entidad ,
		/*13*/	'cc'						=	'          ',
		/*14*/	'con_no'					=	LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
		/*15*/	'strt_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*16*/	'end_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),
		/*17*/	'next_rset_rt_dt' 			=	'',
		/*18*/	'int_pymt_arrs_ind' 		=	'A',
		/*19*/	'ccy'						=	m.mncodbkb,
		/*20*/	'ocy_nom_amt_sign'			=	'+',
		/*21*/	'ocy_nom_amt'				=	P.valor_colocacion_um,
		/*22*/	'lcy_nom_amt_sign'			=	'+',
		/*23*/	'lcy_nom_amt'				=	P.Valor_colocacion_clp,
		/*24*/	'fcy_lc_amt'				=	0,
		/*25*/	'Lcy_reaj_amt_sing'			=	'+', 
		/*26*/	'Lcy_reaj_amt'				=	0 , 
		/*27*/	'Ocy_int_amt_sing'			=	'+', 
		/*28*/	'Ocy_int_amt'				=	0, 
		/*29*/	'Lcy_int_amt_sing'			=	'+',
		/*30*/	'Lcy_int_amt'				=	0,
		/*31*/	'fix_flting_ind'			=	'F',
		/*32*/	'int_rt_cod'				=	'',
		/*33*/	'int_rt'					=	P.Tasa_Emision,
		/*34*/	'pnlt_rt'					=	P.Tasa_Colocacion,
		/*35*/	'rt_meth'					=	'0',
		/*36*/	'pool_rt'					=	0,
		/*37*/	'pool_rt_cod'				=	'',
		/*38*/	'pnlt_rt_cod'				=	'',
		/*39*/	'int_rt_sprd'				=	0,
		/*40*/	'pool_rt_sprd'				=	0,
		/*41*/	'pnlt_rt_sprd'				=	0,
		/*42*/	'aset_liab_ind'				=	'P',
		/*43*/	'sbif_bal_no_rep_sign'		=	'',
		/*44*/	'sbif_bal_no_rep'			=	0,
		/*45*/	'sbif_tipo_tasa'			=	0,
		/*46*/	'sbif_prod_trans'			=	0,
		/*47*/	'sbif_tipo_oper_trans'		=	1,
		/*48*/	'lcy_fee_amt_sign'			=	'+',
		/*49*/	'lcy_fee_amt'				=	0,
		/*50*/	'orig_strt_dt'				=	'', 
		/*51*/	'nacc_from_dt'				=	'',
		/*52*/	'pdue_from_dt'				=	'',
		/*53*/	'wrof_from_dt'				=	'',
		/*54*/	'orig_con_no'				=	'',
		/*55*/	'no_of_remn_coup'			=	(	SELECT	COUNT(*) FROM	MDPasivo..FLUJO_CREDITOS FC WHERE	FC.codigo_instrumento = P.codigo_instrumento AND		FC.cuota_vencimiento >= @dFechaProceso),
		/*56*/	'no_of_pdo_coup'			=	0,
		/*57*/	'no_of_tot_coup'			=	(SELECT MAX(cuota_correlativo) FROM MDPasivo..FLUJO_CREDITOS FC WHERE FC.numero_operacion = P.Numero_Operacion),
		/*58*/	'sbif_dest_coloc'			=	'000',
		/*59*/	'stop_accr_dt'				=	'',
		/*60*/	'lst_int_pymt_dt'			=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*61*/	'ren_ind'					=	'',
		/*62*/	'lst_rset_dt'				=	'',
		/*63*/	'next_rt_ch_dt'				=	'',
		/*64*/	'lst_rt_ch_dt'				=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*65*/	'ocy_orig_nom_amt'			=	P.Valor_colocacion_UM,
		/*66*/	'lcy_avl_bal'				=	0,
		/*67*/	'lcy_pdo1_amt'				=	0,
		/*68*/	'lcy_pdo2_amt'				=	0,
		/*69*/	'Lcy_pdo3_amt'				=	0,
		/*70*/	'lcy_oper_amt'				=	0,
		/*71*/	'loc'						=	0,
		/*72*/	'lcy_mnpy'					=	0,
		/*73*/	'lgl_actn_ind'				=	'',
		/*74*/	'Lcy_mv'					=	0,
		/*75*/	'Lcy_par_val'				=	0,
		/*76*/	'Port_typ'					=	0,
		/*77*/	'No_rng'					=	0,
		/*78*/	'Pdc_coup'					=	9999,
		/*79*/	'Pgo_amt'					=	0, 
		/*80*/	'con_no_typ'				=	'',
		/*81*/	'ope_typ'					=	'',
		/*82*/	'mod_entr_bs'				=	'',
		/*83*/	'opc_compra'				=	0,
		/*84*/	'ident_instr'				=	'',
		/*85*/	'ident_emi_instr'			=	'',
		/*86*/	'serie_instr'				=	'',
		/*87*/	'subserie_instr'			=	'',
		/*88*/	'cat_risk_instr'			=	'',
		/*89*/ 	'limit_rate'				=	0,
		/*90*/ 	'pdc_after_fix_per'			=	0,
				'mSerie'					=P.Nombre_Serie,
				'mNominal'					=	P.Nominal,
				'CodInterProd'  			=	(SELECT glosa FROM MDPasivo..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) ,
				'Valor_moneda'              = V.VmValor
		FROM	MDPasivo..MOVIMIENTO_PASIVO P
		        left join #VALOR_MONEDA V on v.vmcodigo = P.moneda_emision 
				inner join BacParamSuda..MONEDA m	with(nolock) On m.mncodmon	= P.Moneda_Emision
		,		MDPasivo..VIEW_DATOS_GENERALES 
		WHERE	p.Codigo_Instrumento		NOT IN (1,15,9,11)  
		AND		estado_operacion			<>'A' 
		AND		fecha_vencimiento			>=@dFechaProceso 
		AND		MONTH(fecha_movimiento)		= MONTH(@dFechaProceso) 
		AND		tipo_operacion				= 'VEN'


		INSERT 	INTO #Operaciones
		SELECT	'Nro_Operacion'			= Numero_Operacion	,
				'Cor_Operacion'			= numero_correlativo	,
				'Operac_SIGIR'			= LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo)))

		FROM	MDPasivo..CARTERA_PASIVO
		WHERE	estado_operacion		<>'A' and		fecha_vencimiento		>= @dFechaProceso 
		AND		nombre_serie			NOT LIKE ('%GAST%')


		INSERT INTO  #Operaciones
		SELECT	'Nro_Operacion'			= Numero_Operacion	,
				'Cor_Operacion'			= numero_correlativo	,
				'Operac_SIGIR'			= LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo)))
		FROM	MDPasivo..MOVIMIENTO_PASIVO
		WHERE	estado_operacion		<>	'A' and		fecha_vencimiento		>= @dFechaProceso 	AND     MONTH(fecha_movimiento) = MONTH(@dFechaProceso) AND		tipo_operacion			= 'VEN'
		AND		nombre_serie			NOT LIKE ('%GAST%')

	END 
ELSE BEGIN 
	
		SELECT   @FecAnt  =  Fecha_Anterior
		FROM     MDPasivo..VIEW_DATOS_GENERALES_HISTORICA		
		WHERE    Fecha_Proceso = @dFechaProceso

		INSERT INTO @INT_OPE
		SELECT
		/*01*/	'ctry'						=	'CL ',
		/*02*/	'book_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
		/*03*/	'intf_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),--(SELECT @dFechaProceso),
		/*04*/	'src_id'			        =	'OPC3',
		/*05*/	'br'						=	'0011',
		/*06*/	'cem'						=	'001',
		/*07*/	'con_sta'					=	'A  ',
		/*08*/	'Dlnq_sta'					=	'1',
		/*09*/	'prod'						=	'MD01',--'BONOS' ,
		/*10*/	'open_dt'					=	'',
		/*11*/	'lst_accr_dt'				=	'',
		/*12*/	'Iden_cli'					=	'000970230009',--LTRIM(RTRIM(STR(Rut_Entidad)))+Digito_Entidad , 
		/*13*/	'cc'						=	'          ',
		/*14*/	'con_no'					=	LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
		/*15*/	'strt_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*16*/	'end_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Vencimiento,112)),
		/*17*/	'next_rset_rt_dt' 			=	'',
		/*18*/	'int_pymt_arrs_ind' 		=	'A',
		/*19*/	'ccy'						=	m.mncodbkb,
		/*20*/	'ocy_nom_amt_sign'			=	'+',
		/*21*/	'ocy_nom_amt'				=	P.valor_colocacion_um,
		/*22 */'lcy_nom_amt_sign'				=	'+',
		 --		/*23*/	'lcy_nom_amt'				=	P.Valor_colocacion_clp,
		/*23*/	'lcy_nom_amt'				=	CASE WHEN P.moneda_emision not in ( 999,994,998,997) THEN ROUND(P.Valor_colocacion_clp * @nValorDolarDia, 0) ELSE P.Valor_colocacion_clp END,
		/*24*/	'fcy_lc_amt'                =	0,
		/*25*/	'Lcy_reaj_amt_sing'			=	CASE WHEN reajuste_colocacion >= 0 THEN '+' ELSE '-' END, 
		/*26*/	'Lcy_reaj_amt'				=	ABS(reajuste_colocacion) , 
		/*27*/	'Ocy_int_amt_sing'			=	CASE WHEN interes_colocacion >= 0 THEN '+' ELSE '-' END, 
		/*28*/	'Ocy_int_amt'				=	CONVERT(NUMERIC(19,2),(interes_colocacion / ISNULL((SELECT CONVERT(NUMERIC(19,2),vmvalor) FROM MDPasivo..VIEW_VALOR_MONEDA WHERE vmcodigo =  ( case when moneda_emision in ( 994,998,997) then moneda_emision else 0  end )  AND VMFECHA = @dFechaProceso ) , 1 ))), 
		/*29*/	'Lcy_int_amt_sing'			=	CASE WHEN interes_colocacion >= 0 THEN '+' ELSE '-' END,
		/*30*/	'Lcy_int_amt'				=	ABS(interes_colocacion),
		/*31*/	'fix_flting_ind'			=	'F',
		/*32*/	'int_rt_cod'				=	'',
		/*33*/	'int_rt'					=	P.Tasa_Emision,
		/*34*/	'pnlt_rt'					=	P.Tasa_Colocacion,
		/*35*/	'rt_meth'					=	'0',
		/*36*/	'pool_rt'					=	0,
		/*37*/	'pool_rt_cod'				=	'',
		/*38*/	'pnlt_rt_cod'				=	'',
		/*39*/	'int_rt_sprd'				=	0,
		/*40*/	'pool_rt_sprd'				=	0,
		/*41*/	'pnlt_rt_sprd'				=	0,
		/*42*/	'aset_liab_ind'				=	'P',
		/*43*/	'sbif_bal_no_rep_sign'		=	'',
		/*44*/	'sbif_bal_no_rep'			=	0,
		/*45*/	'sbif_tipo_tasa'			=	0,
		/*46*/	'sbif_prod_trans'			=	0,
		/*47*/	'sbif_tipo_oper_trans'		=	1,
		/*48*/	'lcy_fee_amt_sign'			=	'+',
		/*49*/	'lcy_fee_amt'				=	0,
		/*50*/	'orig_strt_dt'				=	'', 
		/*51*/'nacc_from_dt'				=	'',
		/*52*/	'pdue_from_dt'				=	'',
		/*53*/	'wrof_from_dt'				=	'',
		/*54*/	'orig_con_no'				=	'',
		/*55*/	'no_of_remn_coup'			=	(SELECT COUNT(*) FROM MDPasivo..FLUJO_BONOS SB WHERE SB.Nombre_Serie = P.Nombre_Serie AND SB.Fecha_Vencimiento >= @dFechaProceso),
		/*56*/	'no_of_pdo_coup'			=	0,
		/*57*/	'no_of_tot_coup'			=	(SELECT Cupones FROM MDPasivo..SERIE_PASIVO SP WHERE SP.Nombre_Serie = P.Nombre_Serie),
		/*58*/	'sbif_dest_coloc'			=	'000',
		/*59*/	'stop_accr_dt'				=	'',
		/*60*/	'lst_int_pymt_dt'			=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*61*/	'ren_ind'					=	'',
		/*62*/	'lst_rset_dt'				=	'',
		/*63*/	'next_rt_ch_dt'				=	'',
		/*64*/	'lst_rt_ch_dt'				=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*65*/	'ocy_orig_nom_amt'			=	P.Valor_colocacion_UM,
		/*66*/	'lcy_avl_bal'				=	0,
		/*67*/	'lcy_pdo1_amt'				=	0,
		/*68*/	'lcy_pdo2_amt'				=	0,
		/*69*/	'Lcy_pdo3_amt'				=	0,
		/*70*/	'lcy_oper_amt'				=	0,
		/*71*/	'loc'						=	0,
		/*72*/	'lcy_mnpy'					=	0,
		/*73*/	'lgl_actn_ind'				=	'',
		/*74*/	'Lcy_mv'					=	0,
		/*75*/'Lcy_par_val'				=	0,
		/*76*/	'Port_typ'					=	0,
		/*77*/	'No_rng'					=	0,
		/*78*/	'Pdc_coup'					=	9999,
		/*79*/	'Pgo_amt'					=	0, 
		/*80*/	'con_no_typ'				=	'',
		/*81*/	'ope_typ'					=	'',
		/*82*/	'mod_entr_bs'				=	'',
		/*83*/	'opc_compra'			=	0,
		/*84*/	'ident_instr'				=	'',
		/*85*/	'ident_emi_instr'			=	'',
		/*86*/	'serie_instr'				=	'',
		/*87*/	'subserie_instr'			=	'',
		/*88*/	'cat_risk_instr'			=	'',
		/*89*/ 	'limit_rate'				=	0,
		/*90*/ 	'pdc_after_fix_per'			=	0,
		/*91*/ 	'mSerie'					=	P.Nombre_Serie,
		/*92*/ 	'mNominal'					=	P.Nominal,
		/*93*/ 	'CodInterProd'  			=	'MD01' , --'BONOS'
		        'Valor_moneda'              =  v.vmvalor
		FROM	MDPasivo..CARTERA_PASIVO_HISTORICA P 
	        left join #VALOR_MONEDA V on v.vmcodigo = P.moneda_emision 
			inner join BacParamSuda..MONEDA m	with(nolock) On m.mncodmon	= P.Moneda_Emision
--			,	VIEW_DATOS_GENERALES
    	WHERE	P.Codigo_Instrumento		IN(1,15) 
		AND		estado_operacion			<> 'A'
		AND		fecha_vencimiento			>= @dFechaProceso
		AND		P.nombre_serie				NOT LIKE ('%GAST%')
		AND     P.fecha_cartera				= @dFechaProceso


		/*INGRESO DE DEPOSITOS A PLAZOS*/
		INSERT INTO @INT_OPE
		SELECT
		/*01*/	'ctry'						=	'CL ',
		/*02*/	'book_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
		/*03*/	'intf_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),--(SELECT @dFechaProceso),
		/*04*/	'src_id'					=	'OPC3',
		/*05*/	'br'						=	'0011',
		/*06*/	'cem'						=	'001',
		/*07*/	'con_sta'					=	'A  ',
		/*08*/	'Dlnq_sta'					=	'1',
		/*09*/	'prod'						=	'MD01',--'BONOS' ,
		/*10*/	'open_dt'					=	'',
		/*11*/	'lst_accr_dt'				=	'',
		/*12*/	'Iden_cli'					=	'000970230009' ,--LTRIM(RTRIM(STR(Rut_Entidad)))+Digito_Entidad , 
		/*13*/	'cc'						=	'          ',
		/*14*/	'con_no'					=	LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
		/*15*/	'strt_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*16*/	'end_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Vencimiento,112)),
		/*17*/	'next_rset_rt_dt' 			=	'',
		/*18*/	'int_pymt_arrs_ind' 		=	'A',
		/*19*/	'ccy'						=	m.mncodbkb,
		/*20*/	'ocy_nom_amt_sign'			=	'+',
		/*21*/	'ocy_nom_amt'				=	P.valor_COLOCACION_um,
		/*22*/	'lcy_nom_amt_sign'			=	'+',
		/*23*/	'lcy_nom_amt'				=	P.Valor_COLOCACION_CLP,
		/*24*/	'fcy_lc_amt'				=	0,
		/*25*/	'Lcy_reaj_amt_sing'			=	CASE WHEN reajuste_COLOCACION >= 0 THEN '+' ELSE '-' END, 
		/*26*/	'Lcy_reaj_amt'				=	ABS(reajuste_COLOCACION), 
		/*27*/	'Ocy_int_amt_sing'			=	CASE WHEN interes_COLOCACION >= 0 THEN '+' ELSE '-' END, 
		/*28*/	'Ocy_int_amt'				=	CONVERT(NUMERIC(19,2),(interes_COLOCACION / ISNULL((	SELECT	CONVERT(NUMERIC(19,2),vmvalor) FROM	MDPasivo..VIEW_VALOR_MONEDA WHERE	vmcodigo =  ( case when moneda_emision in ( 994,998,997) then moneda_emision else 0  end )  AND		VMFECHA = @dFechaProceso ) , 1 ))), 
		/*29*/	'Lcy_int_amt_sing'			=	CASE WHEN interes_COLOCACION >= 0 THEN '+' ELSE '-' END,
		/*30*/	'Lcy_int_amt'				=	ABS(interes_COLOCACION),
		/*31*/	'fix_flting_ind'			=	'F',
		/*32*/	'int_rt_cod'				=	'',
		/*33*/	'int_rt'					=	P.Tasa_Emision,
		/*34*/	'pnlt_rt'					=	P.Tasa_Colocacion,
		/*35*/	'rt_meth'					=	'0',
		/*36*/	'pool_rt'					=	0,
		/*37*/	'pool_rt_cod'				=	'',
		/*38*/	'pnlt_rt_cod'				=	'',
		/*39*/	'int_rt_sprd'				=	0,
		/*40*/	'pool_rt_sprd'				=	0,
		/*41*/	'pnlt_rt_sprd'				=	0,
		/*42*/	'aset_liab_ind'				=	'P',
		/*43*/	'sbif_bal_no_rep_sign'		=	'',
		/*44*/	'sbif_bal_no_rep'			=	0,
		/*45*/	'sbif_tipo_tasa'			=	0,
		/*46*/	'sbif_prod_trans'			=	0,
		/*47*/	'sbif_tipo_oper_trans'		=	1,
		/*48*/	'lcy_fee_amt_sign'			=	'+',
		/*49*/	'lcy_fee_amt'				=	0,
		/*50*/	'orig_strt_dt'				=	'', 
		/*51*/	'nacc_from_dt'				=	'',
		/*52*/	'pdue_from_dt'				=	'',
		/*53*/	'wrof_from_dt'				=	'',
		/*54*/	'orig_con_no'				=	'',
		/*55*/	'no_of_remn_coup'			=	1, --> UN SOLO CUPON
		/*56*/	'no_of_pdo_coup'			=	0,
		/*57*/	'no_of_tot_coup'			=	1, --> UN SOLO CUPON
		/*58*/	'sbif_dest_coloc'			=	'000',
		/*59*/	'stop_accr_dt'				=	'',
		/*60*/	'lst_int_pymt_dt'			=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*61*/	'ren_ind'					=	'',
		/*62*/	'lst_rset_dt'				=	'',
		/*63*/	'next_rt_ch_dt'				=	'',
		/*64*/	'lst_rt_ch_dt'				=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*65*/	'ocy_orig_nom_amt'			=	P.Valor_COLOCACION_UM,
		/*66*/	'lcy_avl_bal'				=	0,
		/*67*/	'lcy_pdo1_amt'				=	0,
		/*68*/	'lcy_pdo2_amt'				=	0,
		/*69*/	'Lcy_pdo3_amt'				=	0,
		/*70*/	'lcy_oper_amt'				=	0,
		/*71*/	'loc'						=	0,
		/*72*/	'lcy_mnpy'					=	0,
		/*73*/	'lgl_actn_ind'				=	'',
		/*74*/	'Lcy_mv'					=	0,
		/*75*/	'Lcy_par_val'				=	0,
		/*76*/	'Port_typ'					=	0,
		/*77*/	'No_rng'					=	0,
		/*78*/	'Pdc_coup'					=	9999,
		/*79*/	'Pgo_amt'					=	0, 
		/*80*/	'con_no_typ'				=	'',
		/*81*/	'ope_typ'					=	'',
		/*82*/	'mod_entr_bs'				=	'',
		/*83*/	'opc_compra'				=	0,
		/*84*/	'ident_instr'				=	'',
		/*85*/	'ident_emi_instr'			=	'',
		/*86*/	'serie_instr'				=	'',
		/*87*/	'subserie_instr'			=	'',
		/*88*/	'cat_risk_instr'			=	'',
		/*89*/ 	'limit_rate'				=	0,
		/*90*/ 	'pdc_after_fix_per'			=	0,
		/*91*/ 	'mSerie'					=	P.Nombre_Serie,
		/*92*/ 	'mNominal'					=	P.Nominal,
		/*93*/ 	'CodInterProd'  			=	'MD01' , --'BONOS',
		        'Valor_moneda'              = v.vmvalor
		FROM	MDPasivo..CARTERA_PASIVO_HISTORICA P
				left join #VALOR_MONEDA V on v.vmcodigo = P.moneda_emision 
				inner join BacParamSuda..MONEDA m	with(nolock) On m.mncodmon	= P.Moneda_Emision
		WHERE	P.Codigo_Instrumento		IN(9,11) --> VB+- 29032010 
		AND		estado_operacion			<> 'A'
		AND		fecha_vencimiento			>= @dFechaProceso
		AND		P.nombre_serie				NOT LIKE ('%GAST%')
		AND     P.fecha_cartera				= @dFechaProceso



		/*INGRESO DE CORFOS*/

		INSERT INTO @INT_OPE
		SELECT
		/*01*/	'ctry'						=	'CL ',
		/*02*/	'book_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
		/*03*/	'intf_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),--(SELECT @dFechaProceso),
		/*04*/	'src_id'					=	'OPC3',
		/*05*/	'br'						=	'0011',
		/*06*/	'cem'						=	'001', 
		/*07*/	'con_sta'					=	'A  ',
		/*08*/	'Dlnq_sta'					=	'1',
		/*09*/	'prod'						=	'MD01',--(SELECT Codigo_Producto FROM INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) ,
		/*10*/	'open_dt'					=	'',
	    /*11*/	'lst_accr_dt'				=	'',
		/*12*/	'Iden_cli'					=	'000607060002' ,--LTRIM(RTRIM(STR(Rut_Entidad)))+Digito_Entidad ,
		/*13*/	'cc'						=	'          ',
		/*14*/	'con_no'					=	LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
		/*15*/	'strt_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*16*/	'end_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Vencimiento,112)),
		/*17*/	'next_rset_rt_dt' 			=	'',
		/*18*/	'int_pymt_arrs_ind' 		=	'A',
		/*19*/	'ccy'						=	m.mncodbkb,
		/*20*/	'ocy_nom_amt_sign'			=	'+',
		/*21*/  'ocy_nom_amt'				=	P.valor_emision_um,
		/*22*/	'lcy_nom_amt_sign'			=	'+',
		/*23*/	'lcy_nom_amt'				=	P.Valor_emision_pesos,
		/*24*/	'fcy_lc_amt'				=	0,
		/*25*/	'Lcy_reaj_amt_sing'			=	CASE WHEN reajuste_emision >= 0 THEN '+' ELSE '-' END, 
		/*26*/  'Lcy_reaj_amt'				=	ABS(reajuste_emision) , 
		/*27*/	'Ocy_int_amt_sing'			=	CASE WHEN interes_emision >= 0 THEN '+' ELSE '-' END, 
		/*28*/	'Ocy_int_amt'				=	CONVERT(NUMERIC(19,2),(interes_emision / ISNULL((SELECT CONVERT(NUMERIC(19,2),vmvalor) FROM MDPasivo..VIEW_VALOR_MONEDA WHERE vmcodigo =  ( case when moneda_emision in ( 994,998,997) then moneda_emision else 0  end )  AND VMFECHA = @dFechaProceso ) , 1 ))), 
		/*29*/	'Lcy_int_amt_sing'			=	CASE WHEN interes_emision >= 0 THEN '+' ELSE '-' END,
		/*30*/	'Lcy_int_amt'				=	ABS(interes_emision),
		/*31*/	'fix_flting_ind'			=	'F',
	    /*32*/	'int_rt_cod'				=	'',
		/*33*/	'int_rt'					=	P.Tasa_Emision,
		/*34*/	'pnlt_rt'					=	P.Tasa_Colocacion,
		/*35*/	'rt_meth'					=	'0',
		/*36*/	'pool_rt'					=	0,
		/*37*/	'pool_rt_cod'				=	'',
		/*38*/	'pnlt_rt_cod'				=	'',
		/*39*/	'int_rt_sprd'				=	0,
		/*40*/	'pool_rt_sprd'				=	0,
		/*41*/	'pnlt_rt_sprd'				=	0,
		/*42*/	'aset_liab_ind'				=	'P',
		/*43*/	'sbif_bal_no_rep_sign'		=	'',
		/*44*/	'sbif_bal_no_rep'			=	0,
		/*45*/	'sbif_tipo_tasa'			=	0,
		/*46*/	'sbif_prod_trans'			=	0,
		/*47*/	'sbif_tipo_oper_trans'		=	1,
		/*48*/	'lcy_fee_amt_sign'			=	'+',
		/*49*/	'lcy_fee_amt'				=	0,
		/*50*/	'orig_strt_dt'				=	'', 
		/*51*/	'nacc_from_dt'				=	'',
		/*52*/	'pdue_from_dt'				=	'',
		/*53*/	'wrof_from_dt'				=	'',
		/*54*/	'orig_con_no'				=	'',
		/*55*/	'no_of_remn_coup'			=	(SELECT	COUNT(*)FROM	MDPasivo..FLUJO_CREDITOS FC WHERE	FC.codigo_instrumento = P.codigo_instrumento AND		FC.cuota_vencimiento >= @dFechaProceso),
		/*56*/	'no_of_pdo_coup'			=	0,
		/*57*/	'no_of_tot_coup'			=	ISNULL((SELECT	MAX(cuota_correlativo) FROM	MDPasivo..FLUJO_CREDITOS FC WHERE	FC.numero_operacion = P.Numero_Operacion),0),
		/*58*/	'sbif_dest_coloc'			=	'000',
		/*59*/	'stop_accr_dt'				=	'',
		/*60*/	'lst_int_pymt_dt'			=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*61*/	'ren_ind'					=	'',
		/*62*/	'lst_rset_dt'				=	'',
		/*63*/	'next_rt_ch_dt'				=	'',
		/*64*/	'lst_rt_ch_dt'				=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*65*/	'ocy_orig_nom_amt'			=	P.Valor_emision_UM,
		/*66*/	'lcy_avl_bal'				=	0,
		/*67*/	'lcy_pdo1_amt'				=	0,
		/*68*/	'lcy_pdo2_amt'				=	0,
		/*69*/	'Lcy_pdo3_amt'				=	0,
		/*70*/	'lcy_oper_amt'				=	0,
		/*71*/	'loc'						=	0,
		/*72*/	'lcy_mnpy'					=	0,
		/*73*/	'lgl_actn_ind'				=	'',
		/*74*/	'Lcy_mv'					=	0,
		/*75*/	'Lcy_par_val'				=	0,
		/*76*/	'Port_typ'					=	0,
		/*77*/	'No_rng'					=	0,
		/*78*/	'Pdc_coup'					=	9999,
		/*79*/	'Pgo_amt'					=	0, 
		/*80*/	'con_no_typ'				=	'',
		/*81*/	'ope_typ'					=	'',
		/*82*/	'mod_entr_bs'				=	'',
		/*83*/	'opc_compra'				=	0,
		/*84*/	'ident_instr'				=	'',
		/*85*/	'ident_emi_instr'			=	'',
		/*86*/	'serie_instr'				=	'',
		/*87*/	'subserie_instr'			=	'',
		/*88*/	'cat_risk_instr'			=	'',
		/*89*/ 	'limit_rate'				=	0,
		/*90*/ 	'pdc_after_fix_per'			=	0,
				'mSerie'					=	P.Nombre_Serie,
				'mNominal'					=	P.Nominal,
				'CodInterProd'  			=	'MD01',
				'Valor_moneda'              =   v.vmvalor -- v.vmvalor -- v.vnvalor

		FROM	MDPasivo..CARTERA_PASIVO_HISTORICA P
			    left join #VALOR_MONEDA V on v.vmcodigo = P.moneda_emision 
				inner join BacParamSuda..MONEDA m	with(nolock) On m.mncodmon	= P.Moneda_Emision
	    WHERE	P.Codigo_Instrumento		NOT IN (1,15,9,11)  
		AND		estado_operacion			!='A' 
		AND		fecha_vencimiento			>=@dFechaProceso 
		AND		P.fecha_cartera				= @dFechaProceso

		--				select * from #VALOR_MONEDA
		--return


		INSERT INTO @INT_OPE
		SELECT
		/*01*/	'ctry'						=	'CL ',
		/*02*/	'book_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112))	,
		/*03*/	'intf_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),--(SELECT @dFechaProceso),
		/*04*/	'src_id'					=	'OPC3',
		/*05*/	'br'						=	'0011',
		/*06*/	'cem'						=	'001', 
		/*07*/	'con_sta'					=	CASE WHEN @dFechaProceso > P.fecha_movimiento THEN 'C  ' ELSE 'A  ' END,
		/*08*/	'Dlnq_sta'					=	'1',
		/*09*/	'prod'						=	(	SELECT	Codigo_Producto FROM	MDPasivo..INSTRUMENTO_PASIVO I 	WHERE	I.Codigo_Instrumento = P.Codigo_Instrumento) ,
		/*10*/	'open_dt'					=	'',
		/*11*/	'lst_accr_dt'				=	'',
		/*12*/	'Iden_cli'					=	right(replicate('0',12)+convert(varchar(10),Rut_Entidad)+Digito_Entidad,12),--LTRIM(RTRIM(STR(Rut_Entidad)))+Digito_Entidad ,
		/*13*/	'cc'						=	'          ',
		/*14*/	'con_no'					=	LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo))), 
		/*15*/	'strt_dt'					=	LTRIM(CONVERT(CHAR(10),P.Fecha_Emision_Papel,112)),
		/*16*/	'end_dt'					=	LTRIM(CONVERT(CHAR(10),@dFechaProceso,112)),
		/*17*/	'next_rset_rt_dt' 			=	'',
		/*18*/	'int_pymt_arrs_ind' 		=	'A',
		/*19*/	'ccy'						=	m.mncodbkb,
		/*20*/	'ocy_nom_amt_sign'			=	'+',
		/*21*/	'ocy_nom_amt'				=	P.valor_colocacion_um,
		/*22*/	'lcy_nom_amt_sign'			=	'+',
		/*23*/	'lcy_nom_amt'				=	P.Valor_colocacion_clp,
		/*24*/	'fcy_lc_amt'				=	0,
		/*25*/	'Lcy_reaj_amt_sing'			=	'+', 
		/*26*/	'Lcy_reaj_amt'				=	0 , 
		/*27*/	'Ocy_int_amt_sing'			=	'+', 
		/*28*/	'Ocy_int_amt'				=	0, 
		/*29*/	'Lcy_int_amt_sing'			=	'+',
		/*30*/	'Lcy_int_amt'				=	0,
		/*31*/	'fix_flting_ind'	        =	'F',
		/*32*/	'int_rt_cod'				=	'',
		/*33*/	'int_rt'					=	P.Tasa_Emision,
		/*34*/	'pnlt_rt'					=	P.Tasa_Colocacion,
		/*35*/	'rt_meth'					=	'0',
		/*36*/	'pool_rt'					=	0,
		/*37*/	'pool_rt_cod'				=	'',
		/*38*/	'pnlt_rt_cod'				=	'',
		/*39*/	'int_rt_sprd'				=	0,
		/*40*/	'pool_rt_sprd'				=	0,
		/*41*/	'pnlt_rt_sprd'				=	0,
		/*42*/	'aset_liab_ind'				=	'P',
		/*43*/	'sbif_bal_no_rep_sign'		=	'',
		/*44*/	'sbif_bal_no_rep'			=	0,
		/*45*/	'sbif_tipo_tasa'			=	0,
		/*46*/	'sbif_prod_trans'		=	0,
		/*47*/	'sbif_tipo_oper_trans'		=	1,
		/*48*/	'lcy_fee_amt_sign'			=	'+',
		/*49*/	'lcy_fee_amt'				=	0,
		/*50*/	'orig_strt_dt'				=	'', 
		/*51*/	'nacc_from_dt'				=	'',
		/*52*/	'pdue_from_dt'				=	'',
		/*53*/	'wrof_from_dt'				=	'',
		/*54*/	'orig_con_no'				=	'',
		/*55*/	'no_of_remn_coup'			=	(	SELECT	COUNT(*) FROM	MDPasivo..FLUJO_CREDITOS FC WHERE	FC.codigo_instrumento	 = P.codigo_instrumento AND		FC.cuota_vencimiento	>= @dFechaProceso),
		/*56*/	'no_of_pdo_coup'		=	0,
		/*57*/	'no_of_tot_coup'			=	(	SELECT	MAX(cuota_correlativo) FROM	MDPasivo..FLUJO_CREDITOS FC WHERE	FC.numero_operacion = P.Numero_Operacion),
		/*58*/	'sbif_dest_coloc'			=	'000',
		/*59*/	'stop_accr_dt'				=	'',
		/*60*/	'lst_int_pymt_dt'			=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*61*/	'ren_ind'					=	'',
		/*62*/	'lst_rset_dt'				=	'',
		/*63*/	'next_rt_ch_dt'				=	'',
		/*64*/	'lst_rt_ch_dt'				=	LTRIM(CONVERT(CHAR(10),P.Fecha_Anterior_Cupon,112)),
		/*65*/	'ocy_orig_nom_amt'			=	P.Valor_colocacion_UM,
		/*66*/	'lcy_avl_bal'				=	0,
		/*67*/	'lcy_pdo1_amt'				=	0,
		/*68*/	'lcy_pdo2_amt'				=	0,
		/*69*/	'Lcy_pdo3_amt'				=	0,
		/*70*/	'lcy_oper_amt'				=	0,
		/*71*/	'loc'						=	0,
		/*72*/	'lcy_mnpy'					=	0,
		/*73*/	'lgl_actn_ind'				=	'',
		/*74*/	'Lcy_mv'					=	0,
		/*75*/	'Lcy_par_val'				=	0,
		/*76*/	'Port_typ'					=	0,
		/*77*/	'No_rng'					=	0,
		/*78*/	'Pdc_coup'					=	9999,
		/*79*/	'Pgo_amt'					=	0, 
		/*80*/	'con_no_typ'				=	'',
		/*81*/	'ope_typ'					=	'',
		/*82*/	'mod_entr_bs'				=	'',
		/*83*/	'opc_compra'				=	0,
		/*84*/	'ident_instr'				=	'',
		/*85*/	'ident_emi_instr'			=	'',
		/*86*/	'serie_instr'				=	'',
		/*87*/	'subserie_instr'			=	'',
		/*88*/	'cat_risk_instr'			=	'',
		/*89*/ 	'limit_rate'				=	0,
		/*90*/ 	'pdc_after_fix_per'			=	0,
				'mSerie'					=	P.Nombre_Serie,
				'mNominal'					=	P.Nominal,
				'CodInterProd'  			=	(SELECT glosa FROM MDPasivo..INSTRUMENTO_PASIVO I WHERE I.Codigo_Instrumento = P.Codigo_Instrumento) ,
				'Valor_moneda'              =  v.vmvalor

		FROM	MDPasivo..MOVIMIENTO_PASIVO P
			    left join #VALOR_MONEDA V on v.vmcodigo = P.moneda_emision 
				inner join BacParamSuda..MONEDA m	with(nolock) On m.mncodmon	= P.Moneda_Emision
		,	MDPasivo..VIEW_DATOS_GENERALES_HISTORICA 
		WHERE	p.Codigo_Instrumento		NOT IN (1,15,9,11)  
		AND		estado_operacion			<>'A' 
		AND		fecha_vencimiento			>=@dFechaProceso 
		AND		MONTH(fecha_movimiento)		 = MONTH(@dFechaProceso) 
		AND		tipo_operacion				 = 'VEN'
		AND		MDPasivo..VIEW_DATOS_GENERALES_HISTORICA.Fecha_Proceso = P.fecha_movimiento
		AND		P.fecha_movimiento			 = @dFechaProceso


		INSERT INTO  #Operaciones
		SELECT	'Nro_Operacion'			= Numero_Operacion	,
				'Cor_Operacion'			= numero_correlativo	,
				'Operac_SIGIR'			= LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo)))

		FROM	MDPasivo..CARTERA_PASIVO_HISTORICA
		WHERE	estado_operacion		<>'A' and		fecha_vencimiento		>= @dFechaProceso 
		AND		nombre_serie			NOT LIKE ('%GAST%')
		AND     fecha_cartera			= @dFechaProceso 


		INSERT INTO  #Operaciones
		SELECT	'Nro_Operacion'			= Numero_Operacion	,
				'Cor_Operacion'			= numero_correlativo	,		
		'Operac_SIGIR'			= LTRIM(RTRIM(STR(Numero_Operacion)))+LTRIM(RTRIM(STR(numero_correlativo)))
		FROM	MDPasivo..MOVIMIENTO_PASIVO
		WHERE	estado_operacion		<>'A' and		fecha_vencimiento		>= @dFechaProceso 	AND     MONTH(fecha_movimiento)  = MONTH(@dFechaProceso) AND		tipo_operacion			 = 'VEN'
		AND		nombre_serie			 NOT LIKE ('%GAST%')
		AND 	fecha_movimiento		= @dFechaProceso --+ JPL

	END
--- JPL

	DECLARE	@Op					NUMERIC(10),
			@Corr				NUMERIC(3),
			@Op_SIGIR			VARCHAR(20),
			@Fecha_Ini			DATETIME,
			@Fecha_Fin			DATETIME,
			@Tipo_Tasa			NUMERIC(3,0),
			@Tasa_SBIF			NUMERIC(3,0),
			@Serie				VARCHAR(20),
			@Porc  				NUMERIC(12,9),
			@Nomin 				NUMERIC(19,4),	
			@Resul				NUMERIC(19,4),
			@Total				NUMERIC,
			@Indice 			NUMERIC


	SELECT @Total = COUNT(1) FROM @INT_OPE
	SELECT @Indice = 1
	
	 DECLARE @dias  NUMERIC(9,0)   

	WHILE @Indice <= @Total
	BEGIN
		/*Calculo Tasa SBIF*/

		SET @Op_SIGIR 	= (SELECT con_no		FROM @INT_OPE		WHERE ID_TABLA = @Indice)
		SET @Op 		= (SELECT Nro_Operacion FROM #Operaciones	WHERE Operac_SIGIR = @Op_SIGIR)
		SET @Corr 		= (SELECT Cor_Operacion FROM #Operaciones	WHERE Operac_SIGIR = @Op_SIGIR)
		SET @Tipo_Tasa 	= 333

		IF EXISTS( SELECT 1 FROM MDPasivo..CARTERA_PASIVO WHERE Numero_Operacion = @Op AND numero_correlativo = @Corr)
        BEGIN
			SET @Fecha_Ini 	= (SELECT TOP 1 Fecha_Colocacion  FROM MDPasivo..CARTERA_PASIVO				WHERE Numero_Operacion = @Op AND numero_correlativo = @Corr)		
			SET @Fecha_Fin 	= (SELECT TOP 1 Fecha_Vencimiento FROM MDPasivo..CARTERA_PASIVO				WHERE Numero_Operacion = @Op AND numero_correlativo = @Corr)
		END ELSE
		BEGIN
			SET @Fecha_Ini 	= (SELECT TOP 1 Fecha_Colocacion  FROM MDPasivo..CARTERA_PASIVO_HISTORICA		WHERE Numero_Operacion = @Op AND numero_correlativo = @Corr)		
		    SET @Fecha_Fin 	= (SELECT TOP 1 Fecha_Vencimiento FROM MDPasivo..CARTERA_PASIVO_HISTORICA		WHERE Numero_Operacion = @Op AND numero_correlativo = @Corr)
		END

		--EXEC MDPasivo..Sp_Obtener_Tasa_SBIF @Fecha_Ini, @Fecha_Fin, @Tipo_Tasa, @Tasa_SBIF OUTPUT 20220325 se reemplaza ejecución.

		/*obtener tasa sbif*/
		 set @dias = DATEDIFF(DAY, @Fecha_Ini, @Fecha_Fin)  
	
		 set @tasa_SBIF =  
			 CASE  WHEN @dias < 30 THEN 1  
			  WHEN @dias > = 30 AND @dias < 90 THEN 2  
			  WHEN @dias > = 90 AND @dias < 180 THEN 3  
			  WHEN @dias > = 180 AND @dias < 365 THEN 4  
			  WHEN @dias > = 365 AND @dias < 1095 THEN 5  
			  WHEN @dias > = 1095 THEN  6  
			 END  
  
		 IF @tipo_tasa = 333 (select @tasa_SBIF = @tasa_SBIF + 100)  
				 ELSE (select @tasa_SBIF = @tasa_SBIF + 290)  
		/*fin obtener tasa sbif*/

		/*Calculo Monto Pagado*/

		SET @Serie = (SELECT mSerie		FROM @INT_OPE	WHERE ID_TABLA = @Indice)
		SET @Nomin = (SELECT mNominal	FROM @INT_OPE	WHERE ID_TABLA = @Indice)


		IF (SELECT TOP 1 codigo_instrumento FROM MDPasivo..MOVIMIENTO_PASIVO WHERE Numero_Operacion = @Op) = 15 BEGIN
			SET @Porc 	= (SELECT SUM(Amortizacion) FROM MDPasivo..FLUJO_BONOS WHERE Nombre_Serie = @Serie AND Fecha_Vencimiento < @dFechaProceso)
			SET @Porc 	= @Porc / 100
			SET @Resul 	= @Porc * @Nomin
		END 
ELSE BEGIN

			SET @Resul 	= (SELECT SUM(cuota_capital) FROM MDPasivo..FLUJO_CREDITOS WHERE Numero_Operacion = @Op AND cuota_vencimiento < @dFechaProceso) 
		END



		/*Actualizar Datos*/
		UPDATE	@INT_OPE
		SET		sbif_tipo_tasa	= @Tasa_SBIF,
			    Pgo_amt         = ISNULL(@Resul,0)
		WHERE	ID_TABLA		= @Indice



		SET @Indice = @Indice + 1


	END

Declare @TipoSalida bit = 0

if @TipoSalida != 0
	SELECT 
	
	/*01*/	 ctry			
	/*02*/ , book_dt	
	/*03*/ , intf_dt--CONVERT(CHAR(08),intf_dt,112)		
 	/*04*/ , src_id	+ SPACE (10)	
	/*05*/ , cem			
 	/*06*/ , br			
 	/*07*/ , con_sta		
 	/*08*/ , Dlnq_sta		
 	/*09*/ , 'MD01' + SPACE(12)	--'MD01' + SPACE(12)	--LTRIM(RTRIM(prod))+REPLICATE(' ',16-LEN(LTRIM(RTRIM(prod)))) as prod--20220214 LEFT(prod,16)		
 	/*10*/ , (case when open_dt='19000101' then '00000000'  when open_dt='' then '00000000' else open_dt end) as open_dt				--CASE WHEN open_dt		= '19000101' THEN SPACE(08) ELSE CONVERT(CHAR(08),open_dt,112) END--20220214LEFT(prod,4)
	/*11*/ , (case when lst_accr_dt='19000101' then '00000000'  when lst_accr_dt='' then '00000000' else lst_accr_dt end) as lst_accr_dt	--CASE WHEN lst_accr_dt	= '19000101' THEN SPACE(08) ELSE CONVERT(CHAR(08),lst_accr_dt,112) END--20220214 CodInterProd
	/*12*/ , Iden_cli--LTRIM(RTRIM(Iden_cli))+REPLICATE(' ',12-LEN(LTRIM(RTRIM(Iden_cli))))--20220214 SPACE(01)
	/*13*/ , LTRIM(RTRIM(CC))+REPLICATE('0',10-LEN(LTRIM(RTRIM(CC)))) as cc--20220214 'M'
	/*14*/ , left(con_no+space(20), 20)	 AS con_no --20220214 CONVERT(CHAR(08),strt_dt,112)
	
	/*15*/ , (case when strt_dt='19000101' then '00000000' else strt_dt end) as strt_dt								--	CONVERT(CHAR(08),strt_dt,112)--20220214 CONVERT(CHAR(08),lst_accr_dt,112)
 	/*16*/ , (case when end_dt='19000101' then '00000000' else end_dt end)   as  end_dt								--	CONVERT(CHAR(08),end_dt,112)--20220214 Iden_cli 
 	/*17*/ , (case when next_rset_rt_dt='19000101' then '00000000'  when  next_rset_rt_dt	=	'' then '00000000' else next_rset_rt_dt end)    as next_rset_rt_dt	--	CONVERT(CHAR(08),next_rset_rt_dt,112)--20220214 cc	

	/*18*/ , CONVERT(CHAR(1),int_pymt_arrs_ind)  as int_pymt_arrs_ind	
	/*19*/ , left(ccy,4) as ccy--REPLICATE ('0', 4 - LEN(LTRIM(RTRIM(ccy)))) + LTRIM(RTRIM(ccy)) --case when ccy = 13 then '13 ' else REPLICATE ('0', 03 - LEN(LTRIM(RTRIM(ccy)))) + LTRIM(RTRIM(ccy)) end
	/*20*/ , ocy_nom_amt_sign	

	
	/*21*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_nom_amt*10000))),19) as ocy_nom_amt--20220214
 	/*22*/ , lcy_nom_amt_sign	
	/*23*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_nom_amt*100))),19) as lcy_nom_amt--20220214 RTRIM(REPLICATE ('0', 15 - LEN(CONVERT(NUMERIC,lcy_nom_amt))) + CONVERT(CHAR,CONVERT(NUMERIC,lcy_nom_amt))) + RIGHT(RTRIM(CONVERT(VARCHAR,lcy_nom_amt)),2) 		
	/*24*/ , REPLICATE('0',19) as fcy_lc_amt--20220214'000000000000000000'
	/*25*/ , CONVERT(CHAR(01),Lcy_reaj_amt_sing) as Lcy_reaj_amt_sing
	
	/*26*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_reaj_amt*100))),19) as Lcy_reaj_amt--20220214 RTRIM(REPLICATE ('0', 16 - LEN(CONVERT(NUMERIC,ABS(Lcy_reaj_amt)))) + CONVERT(CHAR,CONVERT(NUMERIC,ABS(Lcy_reaj_amt)))) + RIGHT(RTRIM(CONVERT(VARCHAR,ABS(Lcy_reaj_amt))),2) 		
 	/*27*/ , CONVERT(CHAR(01),Ocy_int_amt_sing) as Ocy_int_amt_sing	
 	/*28*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Ocy_int_amt*10000))),19) as Ocy_int_amt--20220214 RTRIM(REPLICATE ('0', 16 - LEN(CONVERT(NUMERIC,ABS(Ocy_int_amt)))) + CONVERT(CHAR,CONVERT(NUMERIC,ABS(Ocy_int_amt))))	 + RIGHT(RTRIM(CONVERT(VARCHAR,ABS(Ocy_int_amt))),2)	
 	/*29*/ , CONVERT(CHAR(01),Lcy_int_amt_sing)	 as Lcy_int_amt_sing

	/*30*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_int_amt*100))),19) as Lcy_int_amt--20220214 RTRIM(REPLICATE ('0', 16 - LEN(CONVERT(NUMERIC,Lcy_int_amt))) + CONVERT(CHAR,CONVERT(NUMERIC,Lcy_int_amt))) + RIGHT(RTRIM(CONVERT(VARCHAR,Lcy_int_amt)),2)
	/*31*/ , CONVERT(CHAR(02),fix_flting_ind)	as fix_flting_ind
	/*32*/ , CONVERT(CHAR(04),int_rt_cod)		as int_rt_cod
	/*33*/ , right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt*100000000))),16) as int_rt--20220214 --RTRIM(REPLICATE ('0', 8 - LEN(CONVERT(NUMERIC,int_rt))) + CONVERT(CHAR,CONVERT(NUMERIC,int_rt))) + RIGHT(RTRIM(CONVERT(VARCHAR,int_rt)),8)
	/*34*/ --, right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt*100000000))),16) as pnlt_rt--20220214 --RTRIM(REPLICATE ('0', 8 - LEN(CONVERT(NUMERIC,pnlt_rt))) + CONVERT(CHAR,CONVERT(NUMERIC,pnlt_rt))) + RIGHT(RTRIM(CONVERT(VARCHAR,pnlt_rt)),8)
		,case when pnlt_rt>0 then '0' else '-' end + right(replicate(0,15)+convert(varchar(16),convert(numeric(16), (CAST(abs(pnlt_rt) AS NUMERIC(16,8))*100000000))),15) as pnlt_rt
	/*35*/ , CONVERT(CHAR(01),rt_meth)	as rt_meth	
 	/*36*/ , REPLICATE('0',16) as pool_rt--20220214 '0000000000000000'

	--0000000009000000
	--00000000-2000000
	/*37*/ , CONVERT(CHAR(05),pool_rt_cod)	as pool_rt_cod	
	/*38*/ , CONVERT(CHAR(04),pnlt_rt_cod)	as pnlt_rt_cod
	/*39*/ , REPLICATE('0',16) as int_rt_sprd--20220214 '0000000000000000'
    /*40*/ , REPLICATE('0',16) as pool_rt_sprd --20220214 '0000000000000000'
	/*41*/ , REPLICATE('0',16) as pnlt_rt_sprd--20220214 '0000000000000000'
	/*42*/ , aset_liab_ind		
 	/*43*/ , CONVERT(CHAR(01),sbif_bal_no_rep_sign) as sbif_bal_no_rep_sign	
	/*44*/ , REPLICATE('0',19) as sbif_bal_no_rep--20220214 '000000000000000000'
	/*45*/ , CONVERT(CHAR(03),ISNULL(sbif_tipo_tasa,106))	as sbif_tipo_tasa
	/*46*/ , '00' as sbif_prod_trans
	

	/*47*/ , '0' as sbif_tipo_oper_trans
	/*48*/ , CONVERT(CHAR(01),lcy_fee_amt_sign)	as lcy_fee_amt_sign
	/*49*/ , REPLICATE('0',19) as lcy_fee_amt--20220214 '000000000000000000' as 
	/*50*/ , CASE WHEN orig_strt_dt = '19000101' THEN '00000000'  when  orig_strt_dt='' then '00000000' ELSE CONVERT(CHAR(08),orig_strt_dt,112) END		AS orig_strt_dt
	/*51*/ , CASE WHEN nacc_from_dt = '19000101' THEN '00000000'  when  nacc_from_dt='' then '00000000' ELSE CONVERT(CHAR(08),nacc_from_dt,112) END		AS nacc_from_dt
	/*52*/ , CASE WHEN pdue_from_dt = '19000101' THEN '00000000'  when  pdue_from_dt='' then '00000000' ELSE CONVERT(CHAR(08),pdue_from_dt,112) END		AS pdue_from_dt		
	/*53*/ , CASE WHEN wrof_from_dt = '19000101' THEN '00000000'  when  wrof_from_dt='' then '00000000' ELSE CONVERT(CHAR(08),wrof_from_dt,112) END		AS wrof_from_dt
	/*54*/ , REPLICATE('0',20-LEN(LTRIM(RTRIM(orig_con_no))))+LTRIM(RTRIM(orig_con_no)) as orig_con_no--20220214 CONVERT(CHAR(20),orig_con_no)		
	/*55*/ , RTRIM(REPLICATE ('0', 4 - LEN(CONVERT(NUMERIC,no_of_remn_coup))) + CONVERT(CHAR,CONVERT(NUMERIC,no_of_remn_coup)))  as no_of_remn_coup
	/*56*/ , '0000' as no_of_pdo_coup

	/*57*/ , RTRIM(REPLICATE ('0', 4 - LEN(CONVERT(NUMERIC,no_of_tot_coup))) + CONVERT(CHAR,CONVERT(NUMERIC,no_of_tot_coup)))  as no_of_tot_coup
	/*58*/ , CONVERT(CHAR(03),sbif_dest_coloc) as sbif_dest_coloc
	/*59*/ , CASE WHEN stop_accr_dt		= '19000101' THEN '00000000'  when  stop_accr_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),stop_accr_dt,112) END		AS stop_accr_dt--CASE WHEN stop_accr_dt = '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),stop_accr_dt,112)	END	
	/*60*/ , CASE WHEN lst_int_pymt_dt	= '19000101' THEN '00000000'  when  lst_int_pymt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_int_pymt_dt,112) END		AS lst_int_pymt_dt--CASE WHEN lst_int_pymt_dt= '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),lst_int_pymt_dt,112) END	
	/*61*/ , CONVERT(CHAR(01),ren_ind)	as ren_ind	
	/*62*/ , CASE WHEN lst_rset_dt		= '19000101' THEN '00000000'  when  lst_rset_dt		=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rset_dt,112)	END		AS lst_rset_dt-- CASE WHEN lst_rset_dt = '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),lst_rset_dt,112)	END		
	/*63*/ , CASE WHEN next_rt_ch_dt	= '19000101' THEN '00000000'  when  next_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rt_ch_dt,112) END		AS next_rt_ch_dt--CASE WHEN next_rt_ch_dt = '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),next_rt_ch_dt,112)	END		
	/*64*/ , CASE WHEN lst_rt_ch_dt		= '19000101' THEN '00000000'  when  lst_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rt_ch_dt,112)	END		AS lst_rt_ch_dt--CASE WHEN lst_rt_ch_dt = '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),lst_rt_ch_dt,112)	END		
	/*65*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_orig_nom_amt*10000))),19) as ocy_orig_nom_amt--20220214 RTRIM(REPLICATE ('0', 16 - LEN(CONVERT(NUMERIC,ocy_orig_nom_amt))) +CONVERT(CHAR,CONVERT(NUMERIC,ocy_orig_nom_amt))) + RIGHT(RTRIM(CONVERT(VARCHAR,ocy_orig_nom_amt)),2)
	/*66*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_avl_bal*100))),19)  as lcy_avl_bal--20220214 lcy_avl_bal				NUMERIC(19,2),
	/*67*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo1_amt*100))),19) as lcy_pdo1_amt--20220214 	lcy_pdo1_amt			NUMERIC(19,2),
	/*68*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo2_amt*100))),19) as lcy_pdo2_amt--20220214 	lcy_pdo2_amt			NUMERIC(19,2),
	/*69*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_pdo3_amt*100))),19) as Lcy_pdo3_amt--20220214 	Lcy_pdo3_amt			NUMERIC(19,2),
	/*70*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_oper_amt*100))),19) as lcy_oper_amt--20220214		lcy_oper_amt			NUMERIC(19,2),
	/*71*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(loc*100))),19) as loc--20220214 	loc						NUMERIC(19,2),
	/*72*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_mnpy*100))),19) as lcy_mnpy--20220214 	lcy_mnpy				NUMERIC(19,2),
	/*73*/ , CONVERT(CHAR(01),lgl_actn_ind) as lgl_actn_ind	--20220214 	lgl_actn_ind			VARCHAR(1),
	/*74*/ , right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_mv*10000))),19) as Lcy_mv--20220214 	Lcy_mv					NUMERIC(19,2),

	/*75*/ , REPLICATE('0',19) as Lcy_par_val--20220214 '000000000000000000'	
	/*76*/ , CONVERT(CHAR(01),Port_typ)	as Port_typ	
	/*77*/ , '000'	 as No_rng
	/*78*/ , RTRIM(REPLICATE ('0', 4 - LEN(CONVERT(NUMERIC,Pdc_coup))) + CONVERT(CHAR,CONVERT(NUMERIC,Pdc_coup))) as Pdc_coup  
	/*79*/ , REPLICATE('0',19) as Pgo_amt --20220214 '000000000000000000'	
	/*80*/ , CONVERT(CHAR(01),con_no_typ)	 as con_no_typ	
	/*81*/ , CONVERT(CHAR(01),ope_typ)	as ope_typ	
	/*82*/ , CONVERT(CHAR(02),mod_entr_bs)	as mod_entr_bs	 
	/*83*/ , REPLICATE('0',12) as opc_compra--20220214 '000000000000'
	/*84*/ , CONVERT(CHAR(05),ident_instr)	as ident_instr	
	/*85*/ , CONVERT(CHAR(15),ident_emi_instr)	as ident_emi_instr
	/*86*/ , CONVERT(CHAR(04),serie_instr)	as serie_instr	
	
	/*87*/ , CONVERT(CHAR(04),subserie_instr)as subserie_instr
	/*88*/ , CONVERT(CHAR(08),cat_risk_instr) as cat_risk_instr--20220214 CONVERT(CHAR(03),cat_risk_instr)
	/*89*/ , right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(limit_rate*100000000))),16) as limit_rate--20220214 	RTRIM(REPLICATE ('0', 8 - LEN(CONVERT(NUMERIC,limit_rate))) + CONVERT(CHAR,CONVERT(NUMERIC,limit_rate))) + RIGHT(RTRIM(CONVERT(VARCHAR,limit_rate)),8) 
	/*90*/ , '0000' as pdc_after_fix_per
	/*91*/ , REPLICATE('0',19)--20220214 '000000000000000000'
	/*92*/ , REPLICATE('0',19)--20220214 '000000000000000000'
	/*93*/ , REPLICATE('0',19)--20220214 '000000000000000000'
	/*94*/ , 'S'
	/*95*/ , REPLICATE('0',19)--20220214 '000000000000000000'

		-->      Se Agrega en requerimiento N° 8136
    /*96*/ , REPLICATE('0',19)--20220214 '000000000000000000'      -->   '--> Monto Mora 2 en Moneda Local (lcy_pdo7_amt)
    /*97*/ , REPLICATE('0',19)--20220214 '000000000000000000'      -->   '--> Monto Mora 7 en MonedaLocal (lcy_pdo8_amt)
	/*98*/ , REPLICATE('0',19)--20220214 '000000000000000000'      -->   '--> Monto Mora 9 en Moneda Local (lcy_pdo9_amt)
    /*99*/ , ' '                        -->   '--> Origen del Activo  	(assets_origin)
  
     	--> Se agrega requerimiento 25169
	/*100*/, REPLICATE('0',8)--20220214 '00000000'
	/*101*/, ' '
	/*102*/, REPLICATE('0',19)--20220214 '0000000000000000000' 
	/*103*/, ' ' 
	/*104*/, REPLICATE('0',19)--20220214 '0000000000000000000' 
	/*105*/, ' ' 
	/*106*/, REPLICATE('0',8)--20220214 '00000000'

	/*107*/,	REPLICATE('0',8)--20220214 '00000000'					--Accounting_dt				DATE
	/*108*/,	REPLICATE('0',8)--20220214 ' '							--last_payment_dt			DATE
	/*109*/,	REPLICATE('0',8) bidding_dt--20220214 '0000000000000000000'		--last_amount_paid			NUMBER(19,2)
	/*110*/,	REPLICATE('0',8) loan_disbursement_dt--20220214 '00000000'					--credit_line_approved_dt	DATE
	/*111*/,	REPLICATE('0',8) Accounting_dt--20220214 '0000000000000000000'		--Amount_instalment			NUMBER(19,2)
	/*112*/,	REPLICATE('0',8) last_payment_dt--20220214 '0000000000000000000'		--Amount_revolving			NUMBER(19,2)
	/*113*/,	REPLICATE('0',19)--20220214 REPLICATE(' ', 1)			--Ind_credit_line_duration	Varchar (1)
	/*114*/,	REPLICATE(' ',8)--20220214 REPLICATE(' ', 4)			--nat_con_no				Varchar (4)
	/*115*/,	REPLICATE('0',19)--20220214 REPLICATE(' ', 1)			--dest_finan				Varchar (1)
	/*116*/,	REPLICATE('0',19)--20220214 REPLICATE('0', 3)			--no_post_coup				NUMBER(3,0)
	/*117*/,	REPLICATE(' ',1)--20220214 REPLICATE(' ', 2)			--giro						Varchar (2)
	/*118*/,	REPLICATE(' ',4)--20220214 REPLICATE(' ', 2)			--giro						Varchar (2) 
	
	FROM @INT_OPE --order by cem, prod, con_no
else
	begin
		INSERT INTO @salida_int
		select
			/*01*/	 ctry			
			/*02*/ + book_dt	
			/*03*/ + intf_dt--CONVERT(CHAR(08),intf_dt,112)		
 			/*04*/ + src_id	+ SPACE (10)	
			/*05*/ + cem			
 			/*06*/ + br			
 			/*07*/ + con_sta		
 			/*08*/ + Dlnq_sta		
 			/*09*/ + 'MD01' + SPACE(12)--'MD01' + SPACE(12)	--LTRIM(RTRIM(prod))+REPLICATE(' ',16-LEN(LTRIM(RTRIM(prod))))--20220214 LEFT(prod,16)		
 			/*10*/ + (case when open_dt='19000101' then '00000000'  when open_dt='' then '00000000' else open_dt end) 				--CASE WHEN open_dt		= '19000101' THEN SPACE(08) ELSE CONVERT(CHAR(08),open_dt,112) END--20220214LEFT(prod,4)
			/*11*/ + (case when lst_accr_dt='19000101' then '00000000'  when lst_accr_dt='' then '00000000' else lst_accr_dt end) 	--CASE WHEN lst_accr_dt	= '19000101' THEN SPACE(08) ELSE CONVERT(CHAR(08),lst_accr_dt,112) END--20220214 CodInterProd
			/*12*/ + Iden_cli--LTRIM(RTRIM(Iden_cli))+REPLICATE(' ',12-LEN(LTRIM(RTRIM(Iden_cli))))--20220214 SPACE(01)
			/*13*/ + LTRIM(RTRIM(CC))+REPLICATE('0',10-LEN(LTRIM(RTRIM(CC))))--20220214 'M'
			/*14*/ + left(con_no+space(20), 20)	 --20220214 CONVERT(CHAR(08),strt_dt,112)
	
			/*15*/ + (case when strt_dt='19000101' then '00000000'  when strt_dt='' then '00000000' else strt_dt end) 								--	CONVERT(CHAR(08),strt_dt,112)--20220214 CONVERT(CHAR(08),lst_accr_dt,112)
 			/*16*/ + (case when end_dt='19000101' then '00000000'  when end_dt='' then '00000000' else end_dt end)   							--	CONVERT(CHAR(08),end_dt,112)--20220214 Iden_cli 
 			/*17*/ + (case when next_rset_rt_dt='19000101' then '00000000'  when  next_rset_rt_dt	=	'' then '00000000' else next_rset_rt_dt end)   	--	CONVERT(CHAR(08),next_rset_rt_dt,112)--20220214 cc	
			/*18*/ + CONVERT(CHAR(1),int_pymt_arrs_ind) 	
			/*19*/ + left(ccy,4)--REPLICATE ('0', 4 - LEN(LTRIM(RTRIM(ccy)))) + LTRIM(RTRIM(ccy)) --case when ccy = 13 then '13 ' else REPLICATE ('0', 03 - LEN(LTRIM(RTRIM(ccy)))) + LTRIM(RTRIM(ccy)) end
			/*20*/ + ocy_nom_amt_sign	

	
			/*21*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_nom_amt*10000))),19)--20220214
 			/*22*/ + lcy_nom_amt_sign	
			/*23*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_nom_amt*100))),19)--20220214 RTRIM(REPLICATE ('0', 15 - LEN(CONVERT(NUMERIC,lcy_nom_amt))) + CONVERT(CHAR,CONVERT(NUMERIC,lcy_nom_amt))) + RIGHT(RTRIM(CONVERT(VARCHAR,lcy_nom_amt)),2) 		
			/*24*/ + REPLICATE('0',19)--20220214'000000000000000000'
			/*25*/ + CONVERT(CHAR(01),Lcy_reaj_amt_sing)
	
			/*26*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_reaj_amt*100))),19)--20220214 RTRIM(REPLICATE ('0', 16 - LEN(CONVERT(NUMERIC,ABS(Lcy_reaj_amt)))) + CONVERT(CHAR,CONVERT(NUMERIC,ABS(Lcy_reaj_amt)))) + RIGHT(RTRIM(CONVERT(VARCHAR,ABS(Lcy_reaj_amt))),2) 		
 			/*27*/ + CONVERT(CHAR(01),Ocy_int_amt_sing)	
 			/*28*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Ocy_int_amt*10000))),19)--20220214 RTRIM(REPLICATE ('0', 16 - LEN(CONVERT(NUMERIC,ABS(Ocy_int_amt)))) + CONVERT(CHAR,CONVERT(NUMERIC,ABS(Ocy_int_amt))))	 + RIGHT(RTRIM(CONVERT(VARCHAR,ABS(Ocy_int_amt))),2)	
 			/*29*/ + CONVERT(CHAR(01),Lcy_int_amt_sing)	

			/*30*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_int_amt*100))),19)--20220214 RTRIM(REPLICATE ('0', 16 - LEN(CONVERT(NUMERIC,Lcy_int_amt))) + CONVERT(CHAR,CONVERT(NUMERIC,Lcy_int_amt))) + RIGHT(RTRIM(CONVERT(VARCHAR,Lcy_int_amt)),2)
			/*31*/ + CONVERT(CHAR(02),fix_flting_ind)	
			/*32*/ + CONVERT(CHAR(04),int_rt_cod)		
			/*33*/ + right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(int_rt*100000000))),16)--20220214 --RTRIM(REPLICATE ('0', 8 - LEN(CONVERT(NUMERIC,int_rt))) + CONVERT(CHAR,CONVERT(NUMERIC,int_rt))) + RIGHT(RTRIM(CONVERT(VARCHAR,int_rt)),8)
		--	/*34*/ + right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(pnlt_rt*100000000))),16)--20220214 --RTRIM(REPLICATE ('0', 8 - LEN(CONVERT(NUMERIC,pnlt_rt))) + CONVERT(CHAR,CONVERT(NUMERIC,pnlt_rt))) + RIGHT(RTRIM(CONVERT(VARCHAR,pnlt_rt)),8)
					+ case when pnlt_rt>0 then '0' else '-' end + right(replicate(0,15)+convert(varchar(16),convert(numeric(16), (CAST(abs(pnlt_rt) AS NUMERIC(16,8))*100000000))),15)
			/*35*/ + CONVERT(CHAR(01),rt_meth)		
 			/*36*/ + REPLICATE('0',16)--20220214 '0000000000000000'

	
			/*37*/ + CONVERT(CHAR(05),pool_rt_cod)		
			/*38*/ + CONVERT(CHAR(04),pnlt_rt_cod)		
			/*39*/ + REPLICATE('0',16)--20220214 '0000000000000000'
			/*40*/ + REPLICATE('0',16)--20220214 '0000000000000000'
			/*41*/ + REPLICATE('0',16)--20220214 '0000000000000000'
			/*42*/ + aset_liab_ind		
 			/*43*/ + CONVERT(CHAR(01),sbif_bal_no_rep_sign)	
			/*44*/ + REPLICATE('0',19)--20220214 '000000000000000000'
			/*45*/ + CONVERT(CHAR(03),ISNULL(sbif_tipo_tasa,106))	
			/*46*/ + '00'
			/*47*/ + '0'
			/*48*/ + CONVERT(CHAR(01),lcy_fee_amt_sign)	
			/*49*/ + REPLICATE('0',19)--20220214 '000000000000000000'
			/*50*/ + CASE WHEN orig_strt_dt = '19000101' THEN '00000000'  when  orig_strt_dt='' then '00000000' ELSE CONVERT(CHAR(08),orig_strt_dt,112) END		
			/*51*/ + CASE WHEN nacc_from_dt = '19000101' THEN '00000000'  when  nacc_from_dt='' then '00000000' ELSE CONVERT(CHAR(08),nacc_from_dt,112) END		
			/*52*/ + CASE WHEN pdue_from_dt = '19000101' THEN '00000000'  when  pdue_from_dt='' then '00000000' ELSE CONVERT(CHAR(08),pdue_from_dt,112) END		
			/*53*/ + CASE WHEN wrof_from_dt = '19000101' THEN '00000000'  when  wrof_from_dt='' then '00000000' ELSE CONVERT(CHAR(08),wrof_from_dt,112) END		
			/*54*/ + REPLICATE('0',20-LEN(LTRIM(RTRIM(orig_con_no))))+LTRIM(RTRIM(orig_con_no))--20220214 CONVERT(CHAR(20),orig_con_no)		
			/*55*/ + RTRIM(REPLICATE ('0', 4 - LEN(CONVERT(NUMERIC,no_of_remn_coup))) + CONVERT(CHAR,CONVERT(NUMERIC,no_of_remn_coup))) 
			/*56*/ + '0000'

			/*57*/ + RTRIM(REPLICATE ('0', 4 - LEN(CONVERT(NUMERIC,no_of_tot_coup))) + CONVERT(CHAR,CONVERT(NUMERIC,no_of_tot_coup))) 
			/*58*/ + CONVERT(CHAR(03),sbif_dest_coloc)
			/*59*/ + CASE WHEN stop_accr_dt		= '19000101' THEN '00000000'  when  stop_accr_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),stop_accr_dt,112) END		--CASE WHEN stop_accr_dt = '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),stop_accr_dt,112)	END	
			/*60*/ + CASE WHEN lst_int_pymt_dt	= '19000101' THEN '00000000'  when  lst_int_pymt_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_int_pymt_dt,112) END	--CASE WHEN lst_int_pymt_dt= '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),lst_int_pymt_dt,112) END	
			/*61*/ + CONVERT(CHAR(01),ren_ind)		
			/*62*/ + CASE WHEN lst_rset_dt		= '19000101' THEN '00000000'  when  lst_rset_dt		=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rset_dt,112)	END		-- CASE WHEN lst_rset_dt = '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),lst_rset_dt,112)	END		
			/*63*/ + CASE WHEN next_rt_ch_dt	= '19000101' THEN '00000000'  when  next_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),next_rt_ch_dt,112) END		--CASE WHEN next_rt_ch_dt = '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),next_rt_ch_dt,112)	END		
			/*64*/ + CASE WHEN lst_rt_ch_dt		= '19000101' THEN '00000000'  when  lst_rt_ch_dt	=	'' then '00000000' ELSE CONVERT(CHAR(08),lst_rt_ch_dt,112)	END		--CASE WHEN lst_rt_ch_dt = '19000101' THEN SPACE(08)ELSE CONVERT(CHAR(08),lst_rt_ch_dt,112)	END		
			/*65*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(ocy_orig_nom_amt*10000))),19)--20220214 RTRIM(REPLICATE ('0', 16 - LEN(CONVERT(NUMERIC,ocy_orig_nom_amt))) +CONVERT(CHAR,CONVERT(NUMERIC,ocy_orig_nom_amt))) + RIGHT(RTRIM(CONVERT(VARCHAR,ocy_orig_nom_amt)),2)
			/*66*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_avl_bal*100))),19)--20220214 lcy_avl_bal				NUMERIC(19,2),
			/*67*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo1_amt*100))),19)--20220214 	lcy_pdo1_amt			NUMERIC(19,2),
			/*68*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_pdo2_amt*100))),19)--20220214 	lcy_pdo2_amt			NUMERIC(19,2),
			/*69*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_pdo3_amt*100))),19)--20220214 	Lcy_pdo3_amt			NUMERIC(19,2),
			/*70*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_oper_amt*100))),19)--20220214		lcy_oper_amt			NUMERIC(19,2),
			/*71*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(loc*100))),19)--20220214 	loc						NUMERIC(19,2),
			/*72*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(lcy_mnpy*100))),19)--20220214 	lcy_mnpy				NUMERIC(19,2),
			/*73*/ + CONVERT(CHAR(01),lgl_actn_ind)	--20220214 	lgl_actn_ind			VARCHAR(1),
			/*74*/ + right(replicate(0,19)+convert(varchar(19),convert(numeric(19),(Lcy_mv*10000))),19)--20220214 	Lcy_mv					NUMERIC(19,2),

			/*75*/ + REPLICATE('0',19)--20220214 '000000000000000000'	
			/*76*/ + CONVERT(CHAR(01),Port_typ)		
			/*77*/ + '000'	
			/*78*/ + RTRIM(REPLICATE ('0', 4 - LEN(CONVERT(NUMERIC,Pdc_coup))) + CONVERT(CHAR,CONVERT(NUMERIC,Pdc_coup)))  
			/*79*/ + REPLICATE('0',19)--20220214 '000000000000000000'	
			/*80*/ + CONVERT(CHAR(01),con_no_typ)		
			/*81*/ + CONVERT(CHAR(01),ope_typ)		
			/*82*/ + CONVERT(CHAR(02),mod_entr_bs)		
			/*83*/ + REPLICATE('0',12)--20220214 '000000000000'
			/*84*/ + CONVERT(CHAR(05),ident_instr)		
			/*85*/ + CONVERT(CHAR(15),ident_emi_instr)	
			/*86*/ + CONVERT(CHAR(04),serie_instr)		
	
			/*87*/ + CONVERT(CHAR(04),subserie_instr)
			/*88*/ + CONVERT(CHAR(08),cat_risk_instr)--20220214 CONVERT(CHAR(03),cat_risk_instr)
			/*89*/ + right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(limit_rate*100000000))),16)--20220214 	RTRIM(REPLICATE ('0', 8 - LEN(CONVERT(NUMERIC,limit_rate))) + CONVERT(CHAR,CONVERT(NUMERIC,limit_rate))) + RIGHT(RTRIM(CONVERT(VARCHAR,limit_rate)),8) 
			/*90*/ + '0000'
			/*91*/ + REPLICATE('0',19)--20220214 '000000000000000000'
			/*92*/ + REPLICATE('0',19)--20220214 '000000000000000000'
			/*93*/ + REPLICATE('0',19)--20220214 '000000000000000000'
			/*94*/ + 'S'
			/*95*/ + REPLICATE('0',19)--20220214 '000000000000000000'

				-->      Se Agrega en requerimiento N° 8136
			/*96*/ + REPLICATE('0',19)--20220214 '000000000000000000'      -->   '--> Monto Mora 2 en Moneda Local (lcy_pdo7_amt)
			/*97*/ + REPLICATE('0',19)--20220214 '000000000000000000'      -->   '--> Monto Mora 7 en MonedaLocal (lcy_pdo8_amt)
			/*98*/ + REPLICATE('0',19)--20220214 '000000000000000000'      -->   '--> Monto Mora 9 en Moneda Local (lcy_pdo9_amt)
			/*99*/ + ' '                        -->   '--> Origen del Activo  	(assets_origin)
  
     			--> Se agrega requerimiento 25169
			/*100*/+ REPLICATE('0',8)--20220214 '00000000'
			/*101*/+ ' '
			/*102*/+ REPLICATE('0',19)--20220214 '0000000000000000000' 
			/*103*/+ ' ' 
			/*104*/+ REPLICATE('0',19)--20220214 '0000000000000000000' 
			/*105*/+ ' ' 
			/*106*/+ REPLICATE('0',8)--20220214 '00000000'

			/*107*/+REPLICATE('0',19)--20220214 '00000000'					--Accounting_dt				DATE
			/*108*/+REPLICATE(' ',1)--20220214 ' '					--last_payment_dt			DATE
			/*109*/+ '00000000'	--	REPLICATE(' ',8)--20220214 '0000000000000000000'		--last_amount_paid			NUMBER(19,2)
			/*110*/+ '00000000'	--	REPLICATE(' ',8)--20220214 '00000000'					--credit_line_approved_dt	DATE
			/*111*/+ '00000000'	--REPLICATE(' ',8)--20220214 '0000000000000000000'		--Amount_instalment			NUMBER(19,2)
			/*112*/+ '00000000'	--REPLICATE(' ',8)--20220214 '0000000000000000000'		--Amount_revolving			NUMBER(19,2)
			/*113*/+REPLICATE('0',19)--20220214 REPLICATE(' ', 1)			--Ind_credit_line_duration	Varchar (1)
			/*114*/+'00000000'	--	REPLICATE(' ',8)--20220214 REPLICATE(' ', 4)			--nat_con_no				Varchar (4)
			/*115*/+	REPLICATE('0',19)--20220214 REPLICATE(' ', 1)			--dest_finan				Varchar (1)
			/*116*/+	REPLICATE('0',19)--20220214 REPLICATE('0', 3)			--no_post_coup				NUMBER(3,0)
			/*117*/+	REPLICATE(' ',1)--20220214 REPLICATE(' ', 2)			--giro						Varchar (2)
			/*118*/+	REPLICATE(' ',4)--20220214 REPLICATE(' ', 2)			--giro						Varchar (2)
				AS REG_SALIDA 
	   			-->   Se Agrega en requerimiento N° 8136
			   ,ORDEN	= ROW_NUMBER() OVER (ORDER BY ctry)

			FROM @INT_OPE


			select REG_SALIDA from @salida_int
	END

	drop table #Operaciones
	drop table #VALOR_MONEDA
END
GO
