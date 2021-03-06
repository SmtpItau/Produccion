USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_RF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_RF '20181031'
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_RF]
(
	@FECHA		 DATE = NULL
)
AS 
BEGIN 	
/*
Procedimiento: Extraccion de operaciones de renta fija (Recompras, Reventas, Recompras y Reventas Automaticas, ICAP - ICOL)
y los vencimientos VC
- los valores default en la consulta, son reemplazados luego por una actualizacion masiva de toda la data extraida.

RSILVA.
*/
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ DETALLE OPERACIONES RF
--MODIFICACION	: 01-08-2018	DUPLICADOS
--MODIFICACION	: 16-10-2018	FEC_CAN_ANT

SET NOCOUNT ON
--DECLARE @FECHA DATE
DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE

IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT acfecproc FROM BacTraderSuda..MDAC with (nolock) ) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA 
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')
	

/********************************************************************************************/
/*			CARGA DE VALORES DE MONEDA CONTABLE												*/
/********************************************************************************************/
IF OBJECT_ID('TEMPDB..##RENT_VALOR_TC_CONTABLE') IS NOT NULL BEGIN
	DROP TABLE ##RENT_VALOR_TC_CONTABLE
END

EXEC REPORTES.DBO.SP_RENT_VALOR_TC_CONTABLE @FECHA=@FECHA
/********************************************************************************************/


IF OBJECT_ID('TEMPDB..#TMP_OTROS_RF') IS NOT NULL BEGIN
	DROP TABLE #TMP_OTROS_RF
END


/****************************************************
	CARTERA CANCELADA O VENCIDA del dia, RECOMPRAS, REVENTAS, ICAP, ICOL.
*****************************************************/	
select 
vencimientos.*
into #TMP_OTROS_RF
from 
(
select distinct
	  rs.rsnumoper
	 ,rs.rsnumdocu	 	 
	 ,rs.rscorrela
	 ,id_sistema				= 'BTR'
	 ,rstipoper					= rs.rstipopero
	 ,rs.rsmonemi
	 ,rs.rsrutcli
	 ,rs.rscodcli
	 ,rs.rsmascara
	 ,rs.rsinstser
	 ,rs.rsnumucup
	 ,rs.rsnumpcup
	 ,rstipopero				= rs.rstipoper				
	 ,status_v					= 'venc-otros'			 
	 ,rs.codigo_carterasuper
	 ,rs.rsid_libro
	 ,rs.rscartera
	 ,rs.rstir
	 ,rs.rscodigo
	 ,rs.rsbasemi	 
	 ,seriado					='R'
-- otros
	,cod_gestor_prod			= convert(varchar(15),null)
	,codtipotasa				='F'
	,tipo_cambio				=convert(numeric(18,4),0)
	,nemo						='-----'
	,int_origen					= 0.0	
	,cuotas_pactadas			= isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 rs.rsinstser,rs.rstipopero,rs.rsnominal
											,rs.rsnumucup,rs.rsnumdocu,rs.rsfeccomp
											,rs.rsfecvcto,rs.rsfecucup,rs.rsfecpcup,1
											) where concept = 'ultimo_cupon'),1)
	,cuotas_pendientes			= isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 rs.rsinstser,rs.rstipopero,rs.rsnominal
											,rs.rsnumucup,rs.rsnumdocu,rs.rsfeccomp
											,rs.rsfecvcto,rs.rsfecucup,rs.rsfecpcup,1
											) where concept = 'ultimo_cupon'),1) - 
											isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 rs.rsinstser,rs.rstipoper,rs.rsnominal
											,rs.rsnumucup,rs.rsnumdocu,rs.rsfeccomp
											,rs.rsfecvcto,rs.rsfecucup,rs.rsfecpcup,1
											) where concept = 'cupon_vigente'),1)  
	,imp_ini_mo					= rs.rsnominal
	,imp_ini_ml					= convert(numeric(20,4),0)

	,imp_cuo_mo					= isnull( (select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 rs.rsinstser,rs.rstipopero,rs.rsnominal
											,rs.rsnumucup,rs.rsnumdocu,rs.rsfeccomp
											,rs.rsfecvcto,rs.rsfecucup,rs.rsfecpcup,null
											) where concept = 'imp_cuo_mo' ),0)
	,imp_cuo_ini_mo				= isnull( (select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 rs.rsinstser,rs.rstipoper,rs.rsnominal
											,rs.rsnumucup,rs.rsnumdocu,rs.rsfeccomp
											,rs.rsfecvcto,rs.rsfecucup,rs.rsfecpcup,null
											) where concept = 'imp_cuo_ini_mo' ),0)	
	
	/************provisorio*******************************************************/
	,imp_pago_ml				= rs.rsvppresen--convert(numeric(20,4),0)
	,imp_pago_mo				= rs.rsvppresen--convert(numeric(20,4),0)
	/************provisorio*******************************************************/


	,fre_rev_int				= convert(numeric,(20),0)
	,fre_pago_int				= convert(numeric(20),0)
	,cod_uni_fre_pago_int		= 'Z'
	,cod_uni_fre_rev_int		= 'Z'
	,cod_uni_plz_amrt			= 'Z'
	,cod_base_tas_int			= 'Z'
	,cod_bca_int				= 'Z'


	,plz_contractual			= (case 
									when datediff(day,rs.rsfecucup,rs.rsfecpcup)<= 0 then 
										(case when not isnull(
										datediff(day,(select top 1 convert(date,other) from dbo.Fx_RNT_RF_VALUES(
											 rs.rsinstser,rs.rstipopero,rs.rsnominal
											,rs.rsnumucup,rs.rsnumdocu,rs.rsfeccomp
											,rs.rsfecvcto,rs.rsfecucup,rs.rsfecpcup,1
											) where concept = 'fecha_cupon_anterior' )
										,rs.rsfecvcto),-1  ) = -1   
										then 
											datediff(day,
											(select top 1 convert(date,other) from dbo.Fx_RNT_RF_VALUES(
												 rs.rsinstser,rs.rstipopero,rs.rsnominal
												,rs.rsnumucup,rs.rsnumdocu,rs.rsfeccomp
												,rs.rsfecvcto,rs.rsfecucup,rs.rsfecpcup,1
												) where concept = 'fecha_cupon_anterior' )
											,rs.rsfecvcto)
										else datediff(day, rs.rsfeccomp,rs.rsfecvcto)
									 	end)
									else datediff(day,rs.rsfecucup,rs.rsfecpcup)
								  end)	
	,plz_amrt					= convert(numeric(20),0)
	
	,fec_alta_cto				= convert(date,rs.rsfeccomp)
	,fec_ini_gest				= convert(date,rs.rsfeccomp)
	,fec_can_ant				= convert(date,'1900-01-01')
	-- MGM Cambio en el Indicador de Cancelacion 
	,ind_can_ant				= 5--null--convert(numeric(5),1)
	-- MGM 30-07-2018
	,fec_ult_liq				= convert(date,rs.rsfecucup)
	,fec_prx_liq				= convert(date,rs.rsfecpcup)
	,fec_ult_rev				= convert(date,rs.rsfeccomp)
	,fec_prx_rev				= convert(date,rs.rsfecvcto)
	,fec_ven					= convert(date,rs.rsfecvcto) --convert(date,'1900-01-01')
from   BacTraderSuda.dbo.mdrs as rs with(nolock)
where  rs.rsfecha   between @fecha_ini_filtro and @fecha_proc_filtro
and          rs.rstipoper    = 'VT'
and          rs.rsinstser    NOT IN('ICOL','ICAP')
and          rs.rscartera    = 110  --> vencimento de cupon
union
select 
	 rs.rsnumoper
	,rs.rsnumdocu
	,rs.rscorrela
	,id_sistema				= 'BTR'
	,rs.rsinstser
	,rs.rsmonemi
	,rs.rsrutcli
	,rs.rscodcli	 
	,rs.rsmascara
	,rs.rsinstser
	,rs.rsnumucup
	,rs.rsnumpcup
	,rstipoper					= rs.rsinstser
	,status_v					= 'venc-icap-icol'			
	,rs.codigo_carterasuper
	,rs.rsid_libro
	,rs.rscartera
	,rs.rstir	
	,rs.rscodigo
	,rs.rsbasemi		
	,seriado					='N'
-- otros
	,cod_gestor_prod			= convert(varchar(15),null)	
	,codtipotasa				='F'
	,tipo_cambio				=convert(numeric(18,4),0)
	,nemo						='-----'
	,int_origen					= 0.0	
	,cuotas_pactadas			= 1 -- convert(numeric(20),0)
	,cuotas_pendientes			= 0 -- convert(numeric(20),0)
	/****provisorios*****************************************/	
	,imp_ini_mo					= rs.rsvppresen	 --> nominal
	,imp_ini_ml					= rs.rsvppresen
	,imp_cuo_mo					= 0.0 -- convert(numeric(20,4),0)
	,imp_cuo_ini_mo				= 0.0 -- convert(numeric(20,4),0)
	/****provisorios*****************************************/
	,imp_pago_ml				= rs.rsnominal	--convert(numeric(20,4),0)
	,imp_pago_mo				= rs.rsnominal	--convert(numeric(20,4),0)
	
	,fre_rev_int				= convert(numeric,(20),0)
	,fre_pago_int				= convert(numeric(20),0)
	,cod_uni_fre_pago_int		= 'Z'
	,cod_uni_fre_rev_int		= 'Z'
	,cod_uni_plz_amrt			= 'Z'
	,cod_base_tas_int			= 'Z'
	,cod_bca_int				= 'Z'

	,plz_contractual			= datediff(day,rs.rsfeccomp,rsfecvtop)
	,plz_amrt					= convert(numeric(20),0)
	
	,fec_alta_cto				= convert(date,rs.rsfeccomp)
	,fec_ini_gest				= convert(date,rs.rsfeccomp)
	,fec_can_ant				= convert(date,'1900-01-01')
	-- MGM Cambio en el Indicador de Cancelacion 
	,ind_can_ant				= 5--null--convert(numeric(5),1)
	-- MGM 30-07-2018
	,fec_ult_liq				= convert(date,rs.rsfeccomp)
	,fec_prx_liq				= convert(date,rs.rsfecvtop)
	,fec_ult_rev				= convert(date,rs.rsfeccomp)
	,fec_prx_rev				= convert(date,rs.rsfecvtop)
	,fec_ven					= convert(date,rs.rsfecvtop)
from   BacTraderSuda.dbo.mdrs as rs with(nolock)
where  rs.rsfecha	between @fecha_ini_filtro and @fecha_proc_filtro
       and          rs.rstipoper    = 'VC'
       and          rs.rsinstser    IN('ICOL','ICAP')
       and          rs.rscartera    = 130  --> Cartera Interbancaria con el Central
) as vencimientos
union
/*re (compras,ventas) */
select 
recompras.*
from (
select distinct
	 monumoper
	,monumdocu
	,mocorrela	
	,id_sistema				= 'BTR'
	,motipoper
	,momonemi
	,morutcli
	,mocodcli	
	,momascara
	,moinstser
	,monumucup
	,prx_cupon				= 0			--> no existe proximo cupon en tabla
	,motipopero
	,status_v				= 'daily-rc/rv/rca/rva' 	
	,codigo_carterasuper
	,Tipo_Cartera_Financiera
	,id_libro
	,motir	
	,mocodigo
	,mobasemi	
	,moseriado
-- otros
	,cod_gestor_prod			= convert(varchar(15),null)
	,codtipotasa				='F'
	,tipo_cambio				=convert(numeric(18,4),0)
	,nemo						='-----'
	,int_origen					= 0.0	
	,cuotas_pactadas			= isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'ultimo_cupon'),1)
	,cuotas_pendientes			= isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											  moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'ultimo_cupon'),1) - 
											isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											  moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'cupon_vigente'),1)  
	,imp_ini_mo					= monominal
	,imp_ini_ml					= convert(numeric(20,4),0)
	
	,imp_cuo_mo					=isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'imp_cuo_mo'),0)
	,imp_cuo_ini_mo				= isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'imp_cuo_ini_mo'),0)	
	,imp_pago_ml				= movalvenp --convert(numeric(20,4),0)
	,imp_pago_mo				= movalvenp --convert(numeric(20,4),0)

	,fre_rev_int				= convert(numeric,(20),0)
	,fre_pago_int				= convert(numeric(20),0)
	,cod_uni_fre_pago_int		= 'Z'
	,cod_uni_fre_rev_int		= 'Z'
	,cod_uni_plz_amrt			= 'Z'
	,cod_base_tas_int			= 'Z'
	,cod_bca_int				= 'Z'


	,plz_contractual			= (case 
									when datediff(day,mofecinip,mofecvenp)<= 0 then 
										(case when not isnull(
										datediff(day,(select top 1 convert(date,other) from dbo.Fx_RNT_RF_VALUES(
											moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'fecha_cupon_anterior' )
										,mofecvenp),-1  ) = -1   
										then 
											datediff(day,
											(select top 1 convert(date,other) from dbo.Fx_RNT_RF_VALUES(
													moinstser,motipopero,monominal											 
													,monumucup,monumdocu,mofecemi
													,mofecven,mofecucup,mofecpcup,1
												) where concept = 'fecha_cupon_anterior' )
											,mofecvenp)
										else datediff(day, mofecinip,mofecvenp)
									 	end)
									else datediff(day,mofecinip,mofecvenp)
								  end)	
	,plz_amrt					= convert(numeric(20),0)
	
	,fec_alta_cto				= convert(date,mofecinip)
	,fec_ini_gest				= convert(date,mofecinip)
--+++FMO 20181016 se modifica FEC_CAN_ANT
	,fec_can_ant				= CASE WHEN motipoper in('RCA', 'RVA') THEN convert(date,mofecpro) ELSE convert(date,'1900-01-01') END
-----FMO 20181016 se modifica FEC_CAN_ANT
	-- MGM Cambio en el Indicador de Cancelacion
	,ind_can_ant				= CASE WHEN motipoper in('RCA', 'RVA') THEN 1 ELSE 5 END --convert(numeric(5),5)
	-- MGM 30-07-2018
	,fec_ult_liq				= convert(date,mofecinip)
	,fec_prx_liq				= convert(date,mofecvenp)
	,fec_ult_rev				= convert(date,mofecinip)
	,fec_prx_rev				= convert(date,mofecvenp)
	,fec_ven					= convert(date,mofecvenp)
 from   BacTradersuda.dbo.mdmo
 where  motipoper in('RC', 'RV', 'RCA', 'RVA')
 and   mofecpro     between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO 
 union 
 select distinct
	 monumoper
	,monumdocu
	,mocorrela
	,id_sistema				= 'BTR'
	,motipoper
	,momonemi
	,morutcli
	,mocodcli	
	,momascara
	,moinstser
	,monumucup
	,prx_cupon				= 0			--> no existe proximo cupon en tabla
	,motipopero
	,status_v				= 'hist-rc/rv/rca/rva' 	
	,codigo_carterasuper
	,Tipo_Cartera_Financiera
	,moid_libro
	,motir	
	,mocodigo
	,mobasemi	
	,moseriado
-- otros
	,cod_gestor_prod			= convert(varchar(15),null)
	,codtipotasa				='F'
	,tipo_cambio				=convert(numeric(18,4),0)
	,nemo						='-----'
	,int_origen					= 0.0	
	,cuotas_pactadas			= isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'ultimo_cupon'),1)
	,cuotas_pendientes			= isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											  moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'ultimo_cupon'),1) - 
											isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											  moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'cupon_vigente'),1)  
	,imp_ini_mo					= monominal
	,imp_ini_ml					= convert(numeric(20,4),0)
	
	,imp_cuo_mo					=isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'imp_cuo_mo'),0)
	,imp_cuo_ini_mo				= isnull((select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'imp_cuo_ini_mo'),0)	
	,imp_pago_ml				= movalvenp --convert(numeric(20,4),0)
	,imp_pago_mo				= movalvenp --convert(numeric(20,4),0)

	,fre_rev_int				= convert(numeric,(20),0)
	,fre_pago_int				= convert(numeric(20),0)
	,cod_uni_fre_pago_int		= 'Z'
	,cod_uni_fre_rev_int		= 'Z'
	,cod_uni_plz_amrt			= 'Z'
	,cod_base_tas_int			= 'Z'
	,cod_bca_int				= 'Z'


	,plz_contractual			= (case 
									when datediff(day,mofecinip,mofecvenp)<= 0 then 
										(case when not isnull(
										datediff(day,(select top 1 convert(date,other) from dbo.Fx_RNT_RF_VALUES(
											moinstser,motipopero,monominal											 
											,monumucup,monumdocu,mofecemi
											,mofecven,mofecucup,mofecpcup,1
											) where concept = 'fecha_cupon_anterior' )
										,mofecvenp),-1  ) = -1   
										then 
											datediff(day,
											(select top 1 convert(date,other) from dbo.Fx_RNT_RF_VALUES(
													moinstser,motipopero,monominal											 
													,monumucup,monumdocu,mofecemi
													,mofecven,mofecucup,mofecpcup,1
												) where concept = 'fecha_cupon_anterior' )
											,mofecvenp)
										else datediff(day, mofecinip,mofecvenp)
									 	end)
									else datediff(day,mofecinip,mofecvenp)
								  end)	
	,plz_amrt					= convert(numeric(20),0)
	
	,fec_alta_cto				= convert(date,mofecinip)
	,fec_ini_gest				= convert(date,mofecinip)
--+++FMO 20181016 se modifica FEC_CAN_ANT
	,fec_can_ant				= CASE WHEN motipoper in('RCA', 'RVA') THEN convert(date,mofecpro) ELSE convert(date,'1900-01-01') END
-----FMO 20181016 se modifica FEC_CAN_ANT
	-- MGM Cambio en el Indicador de Cancelacion
	,ind_can_ant				= CASE WHEN motipoper in('RCA', 'RVA') THEN 1 ELSE 5 END--convert(numeric(5),5)
	-- MGM 30-07-2018
	,fec_ult_liq				= convert(date,mofecinip)
	,fec_prx_liq				= convert(date,mofecvenp)
	,fec_ult_rev				= convert(date,mofecinip)
	,fec_prx_rev				= convert(date,mofecvenp)
	,fec_ven					= convert(date,mofecvenp)
 from   
		BacTradersuda.dbo.mdmh
 where  
	   mofecpro     between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO 
AND    motipoper in('RC', 'RV', 'RCA', 'RVA')

 ) as recompras
  

/*************************************************************************************************************/
/*		actualizacion de nemo de monedas y valores de tipo de cambio										 */
/*************************************************************************************************************/
update #TMP_OTROS_RF
set
	 tipo_cambio	= convert(numeric(18,4),tc.vmvalor)
	,nemo			= m.mnnemo
	,imp_ini_ml		= imp_ini_mo * tc.vmvalor
	,imp_cuo_ini_mo = imp_ini_mo
	,rsmascara		= (case when ltrim(rtrim(rsinstser))='ICOL' then 'ICOL' 
							when ltrim(rtrim(rsinstser))='ICAP' then 'ICAP' 
						else rsmascara end)
	,plz_amrt		= (case 
						when rf.plz_contractual <31 then rf.plz_contractual 
						when rf.plz_contractual >=31 and rf.plz_contractual <365 then round(rf.plz_contractual/30,0,0)
						when rf.plz_contractual >=365 then rf.plz_contractual/360
						end)		
	,fre_rev_int				= (case 
										when plz_contractual <31 then 1
										when plz_contractual >=31 and plz_contractual <365 then 2
										when plz_contractual >=365 then 3
								  end)
	,fre_pago_int				=(case 
										when plz_contractual <31 then 1
										when plz_contractual >=31 and plz_contractual <365 then 2
										when plz_contractual >=365 then 3
								  end)
	,cod_uni_fre_pago_int		=  (case 
										when plz_contractual <31 then 'D'
										when plz_contractual >=31 and plz_contractual <365 then 'M'
										when plz_contractual >=365 then 'A'
								  end)
	,cod_uni_fre_rev_int		=  (case 
										when plz_contractual <31 then 'D'
										when plz_contractual >=31 and plz_contractual <365 then 'M'
										when plz_contractual >=365 then 'A'
								  end)
	,cod_uni_plz_amrt			= (case 
										when plz_contractual <31 then 'D'
										when plz_contractual >=31 and plz_contractual <365 then 'M'
										when plz_contractual >=365 then 'A'
								  end)
	,cod_base_tas_int			= (case	
										when rf.rsbasemi = 0 then 'M'
										when rf.rsbasemi = 30 then 'M'
										when rf.rsbasemi in (360, 365)  then 'A'
										else 'A'
										end)
	,cod_bca_int				= (case 
										when rf.rsbasemi = 30 then '1'
										when rf.rsbasemi = 360 then '2'
										when rf.rsbasemi > 360 then '6'
										when rf.rsbasemi = 0 then '3' 
										else '7' end)
	,cod_gestor_prod			= isnull((select top 1 (case 
														when mousuario is null then 'RNVARRETE'
														when ltrim(rtrim(mousuario))='' then 'RNAVARRETE' 
														else ltrim(rtrim(mousuario))
														end) as mousuario from 
														bactradersuda.dbo.mdmo with(nolock) where monumdocu = rf.rsnumdocu),'RNAVARRETE')							
from 
			#TMP_OTROS_RF as rf
inner join	##RENT_VALOR_TC_CONTABLE as tc on 
			rf.rsmonemi = tc.vmcodigo
inner join	BacParamSuda.dbo.moneda as m on 
			rf.rsmonemi = m.mncodmon

--select * from #tmp_otros_rf where status_v='daily-rc/rv/rca/rva' --'venc-icap-icol' -- rsnumoper =198202



/*************************************************************************************************************/
/*	EXTRACCION DE DATOS DE LA CARTERA OTROS RF.																 */
/*************************************************************************************************************/
SELECT DISTINCT
/*1*/		 NRO_DOCUMENTO			= rs.rsnumdocu																						--NUMERIC(20)
/*2*/		,NRO_OPERACION			= rs.rsnumoper																						--NUMERIC(20)
/*3*/		,NRO_CORRELATIVO		= rs.rscorrela																						--NUMERIC(20)		DEFAULT(1)
/*4*/		,FEC_DATA				= @FECHA_PROC_FILTRO																				--DATE				DEFAULT('1900-01-01')
/*5*/		,COD_ENTIDAD			= '1769'																							--VARCHAR(4)
/*6*/		,COD_PRODUCTO			= 'BTR'																								--VARCHAR(4)
/*7*/		,COD_SUBPRODU			= rs.rstipoper																						--VARCHAR(4)
/*8*/		,NUM_CUENTA				= rs.rsnumoper																						--VARCHAR(12)
/*9*/		,NUM_SECUENCIA_CTO		= rs.rscorrela																						--NUMERIC(4)		DEFAULT 1
/*10*/		,COD_DIVISA				= case rs.nemo 
										when 'UF' then 'CLP'
										when 'DO' then 'USD'
										else rs.nemo
										end																								--VARCHAR(4)
/*11*/		,COD_REAJUSTE			= case rs.nemo
										when 'UF' then 'UF'											
										else null
										end																								--VARCHAR(3)
/*12*/		,IDF_PERS_ODS			= convert(varchar,CL.clrut) + '-' + ltrim(rtrim(cl.cldv))											--VARCHAR(25)
/*13*/		,COD_CENTRO_CONT		= '2230'																							--VARCHAR(4)		DEFAULT('2230')
/*14*/		,COD_OFI_COMERCIAL		= ''																								--VARCHAR(5)		DEFAULT('001  ')
/*15*/		,COD_GESTOR_PROD		= rs.cod_gestor_prod																				--VARCHAR(15)
/*16*/		,COD_BASE_TAS_INT		= rs.cod_base_tas_int																				--VARCHAR(1)
/*17*/		,COD_BCA_INT			= rs.cod_bca_int																					--VARCHAR(1)
/*18*/		,COD_COMPOS_INT			= 'C'																								--CHAR(1)
/*19*/		,COD_MOD_PAGO			= 'V'																								--CHAR(1)
/*20*/		,COD_MET_AMRT			= '1'																								--VARCHAR(4)
/*21*/		,COD_CUR_REF			= 0																									--VARCHAR(5)
/*22*/		,COD_TIP_TAS			= rs.codtipotasa																					--VARCHAR(2) 
/*23*/		,TAS_INT				= rs.rstir																							--NUMERIC(8,5)
/*24*/		,TAS_DIF_INC_REF		= rs.rstir																							--NUMERIC(8,5)
/*25*/		,FEC_ALTA_CTO			= rs.fec_alta_cto																					--DATE
/*26*/		,FEC_INI_GEST			= rs.fec_ini_gest																					--DATE
/*27*/		,FEC_CAN_ANT			= rs.fec_can_ant 																					--DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*28*/		,FEC_ULT_LIQ			= rs.fec_ult_liq				--(fecha corte ult. cupon +- fecha valuta si es que aplica)			--DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*29*/		,FEC_PRX_LIQ			= rs.fec_prx_liq				--(fecha corte prox. cupon)											--DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*30*/		,FEC_ULT_REV			= rs.fec_ult_rev				--(fecha de compra cupon) 											--DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*31*/		,FEC_PRX_REV			= rs.fec_prx_rev																					--DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*32*/		,FEC_VEN				= rs.fec_ven																						--DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*33*/		,FRE_PAGO_INT			= rs.fre_pago_int																					--NUMERIC(5)
/*34*/		,COD_UNI_FRE_PAGO_INT	= rs.cod_uni_fre_pago_int																			--CHAR(1)
/*35*/		,FRE_REV_INT			= rs.fre_rev_int																					--CHAR(1)
/*36*/		,COD_UNI_FRE_REV_INT	= rs.cod_uni_fre_rev_int																			--CHAR(1)
/*37*/		,PLZ_CONTRACTUAL		= rs.plz_contractual																				--NUMERIC(5)
/*38*/		,PLZ_AMRT				= rs.plz_amrt																						--NUMERIC(5)
/*39*/		,COD_UNI_PLZ_AMRT		= rs.cod_uni_plz_amrt																				--CHAR(1)
/*40*/		,IMP_INI_MO				= rs.imp_ini_mo																						--NUMERIC(20,4)
/*41*/		,IMP_CUO_MO				= rs.imp_cuo_mo																						--NUMERIC(20,2)
/*42*/		,IMP_CUO_INI_MO			= rs.imp_cuo_ini_mo																					--NUMERIC(20,2)
/*43*/		,NUM_CUO_PAC			= rs.cuotas_pactadas																				--NUMERIC(5)		DEFAULT(1)
/*44*/		,NUM_CUO_PEND			= case when cuotas_pendientes < 0 then 0 else cuotas_pendientes end  																				--NUMERIC(5)		DEFAULT(1)
/*45*/		,IMP_PAGO_ML			= (case 
										when status_v in('daily-rc/rv/rca/rva') then rs.imp_pago_ml --/ rs.tipo_cambio
										else round(rs.imp_pago_ml * rs.tipo_cambio,4,0)															
										end)																							--NUMERIC(20,4)
/*46*/		,IMP_PAGO_MO			= round(rs.imp_pago_mo/ rs.tipo_cambio,4,0)															--NUMERIC(20,4)
-- MGM Cambio en el Indicador de Cancelacion a 5
/*47*/		,IND_CAN_ANT			= rs.ind_can_ant																								--CHAR(1)
-- MGM 30-07-2018
/*48*/		,IND_TAS_PREDEF			= 'N' -- (case when cp.cptasest<>0 then 'S' else 'N' end)											--CHAR(1)
/*49*/		,TAS_PREDEF				= 0.0 -- cp.cptasest																				--NUMERIC(8,5)
/*50*/		,IMP_INI_ML				= rs.imp_ini_ml																						--NUMERIC(20,4)
/*51*/		,TAS_INT_ORIGEN			= rs.int_origen																						--NUMERIC(8,5)
/*52*/		,COD_PORTAFOLIO			= rs.rscartera																						--VARCHAR(10)
/*53*/		,DES_PORTAFOLIO			= (case 
										when rs.rscartera = 111 then '(VENCIMIENTO CUPON)'
										when rs.rscartera = 130 then 'IB:(ICAP/ICOL)'
										else
											(substring((select ltrim(rtrim(tbglosa)) 
												from bactradersuda.dbo.view_tabla_general_detalle with(nolock)
												where tbcodigo1=rs.rscartera and tbcateg=204),1,20)
												)																						
										end)																							--VARCHAR(20)
/*54*/		,COD_NEMOTECNICO		= rs.rsinstser																						--VARCHAR(20)
/*55*/		,COD_CARTERA_FINANCI	= CASE rs.rscartera 
										WHEN 1 THEN  'TR'	-- Trading
										WHEN 2 THEN  'PLP'	-- Portfolio LP
										WHEN 3 THEN  'ET'	-- Estructuración
										WHEN 4 THEN  'BL'	-- BALANCE
										WHEN 9 THEN  'PR'	-- PROPIETARIO
										WHEN 10 THEN 'PLO'	-- PORTFOLIO LO 180
										WHEN 13 THEN 'MT'	-- MM TASA   -- REVISAR
										WHEN 14 THEN 'MF'	-- MM FX -- REVISAR
										WHEN 16 THEN 'BGF'	-- Balance Gestion Financiera -- REVISAR
										ELSE		 'BGL'	-- Balance Gestion Liquidez -- REVISAR
										END																								--CHAR(8) 
/*56*/		,COD_TIP_LIBRO			= (case when rs.rsid_libro = 1 then 'N' else 'B' end)												--VARCHAR(1)
/*57*/		,NUM_DOC				= rs.rsnumdocu																						--VARCHAR(12)
/*58*/		,NUM_OPE_ANT			= null																								--VARCHAR(12)
/*59*/		,T_FLUJO				= 0																									--INT DEFAULT 0
--			,rs.status_v
--			,rs.rstipoper		as rstipopero
--			,rs.rstipopero		as rstipoper
FROM 

			#TMP_OTROS_RF AS rs	WITH(NOLOCK)
LEFT JOIN	BacParamSuda.dbo.Cliente as cl with(nolock)
			on
				rs.rsrutcli = cl.clrut
			and rs.rscodcli = cl.clcodigo
--where status_v = 'daily-rc/rv/rca/rva' --not in ('venc-otros','venc-icap-icol')
order by nro_documento asc
--select * from #TMP_OTROS_RF where status_v in ('daily-rc/rv/rca/rva')
--SP_REPORTES_VCTOS_PACTOS '20170501','20170608'
--SP_INFCONVCTO
--SP_REPORTES_VCTOS_INTERBANCARIOS
end 
GO
