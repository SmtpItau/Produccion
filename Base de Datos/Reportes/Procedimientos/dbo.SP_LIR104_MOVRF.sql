USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIR104_MOVRF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LIR104_MOVRF]
AS 
BEGIN
	SET NOCOUNT ON 

	DECLARE @Separador      VARCHAR(1)
	SET @Separador = ';'


	DECLARE @fecha_desde	DATETIME
		SET @fecha_desde	= (SELECT acfecproc FROM bactradersuda.dbo.mdac); --'2019-12-30'
	DECLARE @fecha_hasta	DATETIME
		SET @fecha_hasta	= (SELECT acfecproc FROM bactradersuda.dbo.mdac); --'2019-12-30'


	if (OBJECT_ID('tempdb.dbo.#TablaCuenta','U')) is not null
		drop table #TablaCuenta

	if (OBJECT_ID('tempdb.dbo.#tblFinal','U')) is not null
		drop table #tblFinal

	if (OBJECT_ID('tempdb.dbo.#ctasFinal','U')) is not null
    drop table #ctasFinal

	if (OBJECT_ID('tempdb.dbo.#ctasVentas','U')) is not null
    drop table #ctasVentas

/*drop table #TablaCuenta
drop table 
*/

	SET NOCOUNT ON 

	select   codigo_instrumento, CarteraNormativa, MAX(Uti_DifPrecioAvr) as Uti_DifPrecioAvr , MAX(Per_DifPrecioAvr) as Per_DifPrecioAvr, MAX(Uti_DifPrecio) as Uti_DifPrecio, MAX(Per_DifPrecio) as Per_DifPrecio
	into #ctasVentas
	from   
	  (SELECT codigo_instrumento, CarteraNormativa,
	  case when Tp = 975 then codigo_cuenta else 0 end as  Uti_DifPrecioAvr  
	  ,case when Tp = 976 then codigo_cuenta else 0 end as  Per_DifPrecioAvr  
	  ,case when Tp = 977 then codigo_cuenta else 0 end as  Uti_DifPrecio  
	  ,case when Tp = 978 then codigo_cuenta else 0 end as  Per_DifPrecio  
	  
	  FROM  

	  (SELECT DISTINCT codigo_instrumento, codigo_campo as tp, v.codigo_cuenta, CarteraNormativa 
		FROM bacparamsuda.dbo.PERFIL_CNT A
		INNER JOIN bacparamsuda.dbo.PERFIL_DETALLE_CNT B	ON A.folio_perfil=B.folio_perfil
		INNER JOIN bacparamsuda.dbo.PERFIL_VARIABLE_CNT V	ON V.folio_perfil= A.folio_perfil 
														AND V.correlativo_perfil = B.correlativo_perfil 
		left join (select * from bacparamsuda.dbo.TBL_CLASIFICACION_CARTERA_INSTRUMENTO   	
					WHERE id_sistema = 'BTR' 
						AND Tipo_movimiento = 'MOV' 
						AND Tipo_operacion = 'VP' )		cc	on cc.CodigoCartera =V.valor_dato_campo
	   WHERE a.tipo_operacion='VP' AND A.id_sistema='BTR'
	AND 
	   (SUBSTRING(CONVERT(VARCHAR,V.codigo_cuenta),1,1)=5	
	  OR SUBSTRING(CONVERT(VARCHAR,V.codigo_cuenta),1,1)=7)
	  --and valor_dato_campo=39
	  ) AS ctaVP) as total

	  group by codigo_instrumento, CarteraNormativa
	  
	  

	SELECT	DISTINCT numdocu
	,		correla
	,		variable
	,		ctaContable				AS CuentaCapital
	  INTO #TablaCuenta
	  FROM bactradersuda.dbo.Cartera_cuenta  with(nolock)
	 WHERE t_movimiento ='MOV'  
	   AND t_operacion ='CP' 
	   AND variable ='valor_compra'
	union 
	SELECT	DISTINCT numdocu
	,		correla
	,		variable
	,		ctaContable				AS CuentaCapital
	  FROM bactradersuda.dbo.Cartera_cuenta_his with(nolock)
	 WHERE t_movimiento ='MOV'  
	   AND t_operacion ='CP' 
	   AND variable ='valor_compra'

	  SELECT	numdocu,	
				correla, 
				max(CuentaCapital)	AS CuentaCapital 
		INTO #tblFinal
		FROM #TablaCuenta
	   group 
		  by numdocu,correla


	SELECT
	 convert(varchar, mofecpro,112) as mofecpro-->>CVM.20200529_AAAAMMDD
	,morutcart
	,motipcart
	,cartera1.tbglosa   as  glosa_motipcart
	,monumdocu
	,mocorrela
	,monumdocuo
	,mocorrelao
	,monumoper
	,motipoper
	,case	when motipoper ='VP' then 'VENTA DEFINITIVA' 
			when motipoper ='CP' then 'COMPRA DEFINITIVA' end as  glosa_motipoper
	,motipopero
	,case	when motipopero ='VP' then 'VENTA DEFINITIVA' 
			when motipopero ='CP' then 'COMPRA DEFINITIVA' end as  glosa_motipopero

	,moinstser
	,momascara
	,mocodigo
	, ins.inglosa   as  glosa_mocodigo
	,moseriado
	,convert(varchar, mofecemi,112) as mofecemi-->>CVM.20200529_AAAAMMDD
	,convert(varchar, mofecven,112) as mofecven-->>CVM.20200529_AAAAMMDD
	,momonemi
	,motasemi
	,mobasemi
	,morutemi
	,monominal 
	,movpresen 
	,convert(varchar, mofecinip,112) as mofecinip-->>CVM.20200529_AAAAMMDD
	,convert(varchar, mofecvenp,112) as mofecvenp-->>CVM.20200529_AAAAMMDD
	,motipret 
	,mohora 
	,movalant 
	,mostatreg 
	,moutilidad 
	,moperdida 
	,movalven 
	,moclave_dcv
	,momtoPFE
	,momtoCCE 
	,convert(varchar, fecha_compra_original,112) as fecha_compra_original-->>CVM.20200529_AAAAMMDD
	,valor_compra_original 
	,valor_compra_um_original 
	,tir_compra_original
	,cartera2.tbglosa  as Tipo_Cartera_Financiera
	,convert(varchar, Fecha_PagoMañana,112) as Fecha_PagoMañana-->>CVM.20200529_AAAAMMDD
	,MtoVentaPM 
	,pagoMañana
	,moTirTran
	,Resultado_Dif_Precio 
	,Resultado_Dif_Mercado 
	,datediff(day, mofecpro, mofecven) as cantidad_dias
	, id_libro--moid_libro
	, cartera3.tbglosa as  cartera
	,  isnull(cta.CuentaCapital,'') AS CuentaCapital
	--,cta_ctble_perdida
	--,cta_ctble_utilidad
	,convert(NUMERIC(10),0) AS CTA1 
	,convert(NUMERIC(10),0) AS CTA2 
	,convert(NUMERIC(10),0) AS CTA3 
	,convert(NUMERIC(10),0) AS CTA4 
	,inserie
	,CODIGO_CARTERASUPER AS CARTERAX
	-->, (select datediff(day,acfecproc,acfecprox) from BacTraderSuda.dbo.mdac a) plazodevengo
	, (select datediff(day,mofecpro,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(mofecpro,1,6))) as plazodevengo
	into #ctasFinal 
	FROM bactradersuda.dbo.mdmo with(nolock) -->mdmh
	left join bacparamsuda.dbo.TABLA_GENERAL_DETALLE Cartera1  on Cartera1.tbcateg = 204 and  CONVERT(NUMERIC(6),Cartera1.tbcodigo1) = motipcart

	left join bacparamsuda.dbo.TABLA_GENERAL_DETALLE Cartera2  on Cartera2.tbcateg = 1111 and  Cartera2.tbcodigo1 = codigo_carterasuper
		
	left join bacparamsuda.dbo.TABLA_GENERAL_DETALLE Cartera3  on Cartera3.tbcateg = 1552 and  CONVERT(NUMERIC(6),Cartera3.tbcodigo1) = id_libro--moid_libro

	left join bacparamsuda.dbo.INSTRUMENTO ins on ins.incodigo = mocodigo

	left join  #tblFinal cta on NumDocu = monumdocu  and Correla = mocorrela
	where motipoper in ('CP','VP')
	and mofecpro between @fecha_desde and @fecha_hasta
	--and mofecpro ='20060206'
	 
	 UPDATE #ctasFinal
	 SET CTA1 =Uti_DifPrecioAvr
	 , CTA2= Per_DifPrecioAvr
	 , CTA3= Uti_DifPrecio
	 , CTA4 =Per_DifPrecio	
	 FROM #ctasFinal A
	 INNER JOIN #ctasVentas B
	 ON A.inserie = B.codigo_instrumento
	 AND A.CARTERAX = b.carteranormativa
	 AND MOTIPOPER='VP'
	-- SELECT * FROM BacTraderSuda.dbo.MDMO


	update #ctasFinal
	set CTA1 = case		when CTA1 = '560901002'						then '560801013' 
						when CTA1 = '560801035'						then '560801016'	
	                    when CTA1 = '760701039'						then '760601039'	
	                    when CTA1 = '760801022'						then '760801021'	
	                    when CTA1 = '760801036'						then case	when motipcart = 22		then '760801016' 
																				when motipcart = 2		then '760801018'
																		 end
						else CTA1 
				end
	, 
		CTA2 = case		when CTA2 = '560901002'						then '560801013' 
						when CTA2 = '560801035'						then '560801016'	
	                    when CTA2 = '760701039'						then '760601039'	
	                    when CTA2 = '760801022'						then '760801021'	
	                    when CTA2 = '760801036'						then case	when motipcart = 22		then '760801016' 
																				when motipcart = 2		then '760801018'
																		 end
						else CTA2
				end
	,
		CTA3 = case		when CTA3 = '560901002'						then '560801013' 
						when CTA3 = '560801035'						then '560801016'	
	                    when CTA3 = '760701039'						then '760601039'	
	                    when CTA3 = '760801022'						then '760801021'	
	                    when CTA3 = '760801036'						then case	when motipcart = 22		then '760801016' 
																				when motipcart = 2		then '760801018'
																		 end
						else CTA3
				end
	,
		CTA4 = case		when CTA4 = '560901002'						then '560801013' 
						when CTA4 = '560801035'						then '560801016'	
	                    when CTA4 = '760701039'						then '760601039'	
	                    when CTA4 = '760801022'						then '760801021'	
	                    when CTA4 = '760801036'						then case	when motipcart = 22		then '760801016' 
																				when motipcart = 2		then '760801018'
																		 end
						else CTA4
				end


/* -->ACTUALIZACION POR FORMATO DECIMAL 20210630
SELECT 
		convert(varchar,mofecpro)				+ @Separador +
		convert(varchar,morutcart)				+ @Separador + 
		convert(varchar,motipcart)				+ @Separador + 

		convert(varchar,glosa_motipcart)		+ @Separador + 
		convert(varchar,monumdocu)				+ @Separador + 	
		convert(varchar,mocorrela)				+ @Separador + 	
		convert(varchar,monumdocuo)				+ @Separador + 	
		convert(varchar,mocorrelao)				+ @Separador + 	
		convert(varchar,monumoper)				+ @Separador + 	
		convert(varchar,motipoper)				+ @Separador + 	
		convert(varchar,glosa_motipoper)		+ @Separador + 	
		convert(varchar,motipopero)				+ @Separador + 	
		convert(varchar,glosa_motipopero)		+ @Separador + 	
		convert(varchar,moinstser)				+ @Separador + 	
		convert(varchar,momascara)				+ @Separador + 	
		convert(varchar,mocodigo)				+ @Separador + 	
		convert(varchar,glosa_mocodigo)			+ @Separador + 
		convert(varchar,moseriado)				+ @Separador + 

		convert(varchar,mofecemi)				+ @Separador +	
		convert(varchar,mofecven)				+ @Separador +  
		convert(varchar,momonemi)				+ @Separador + 
		convert(varchar,cast(motasemi as decimal))	+ @Separador + 
		convert(varchar,mobasemi)				+ @Separador + 
		convert(varchar,morutemi)				+ @Separador + 
		convert(varchar,cast(monominal as decimal))	+ @Separador + 
		convert(varchar,cast(movpresen as decimal))	+ @Separador + 
		convert(varchar,mofecinip)				+ @Separador + 
		convert(varchar,mofecvenp)				+ @Separador + 
		convert(varchar,motipret)				+ @Separador + 
		convert(varchar,mohora)						+ @Separador + 	 
		convert(varchar,cast(movalant as decimal))	+ @Separador + 
		convert(varchar,mostatreg)					+ @Separador + 
		convert(varchar,cast(moutilidad as decimal))+ @Separador + 
		convert(varchar,cast(moperdida as decimal))	+ @Separador +  
		convert(varchar,cast(movalven as decimal))	+ @Separador +  
		convert(varchar,moclave_dcv)				+ @Separador + 
		convert(varchar,cast(momtoPFE as decimal))	+ @Separador +	
		convert(varchar,cast(momtoCCE as decimal))	+ @Separador +	 
		convert(varchar,fecha_compra_original)						+ @Separador + 
		convert(varchar,cast(valor_compra_original as decimal))		+ @Separador +  
		convert(varchar,cast(valor_compra_um_original as decimal))	+ @Separador +  
		convert(varchar,cast(tir_compra_original as decimal))		+ @Separador + 	
		convert(varchar,Tipo_Cartera_Financiera)					+ @Separador + 
		convert(varchar,Fecha_PagoMañana)				+ @Separador + 	
		convert(varchar,cast(MtoVentaPM as decimal))	+ @Separador +  
		convert(varchar,pagoMañana)						+ @Separador + 
		convert(varchar,cast(moTirTran as decimal))		+ @Separador +	
		convert(varchar,cast(Resultado_Dif_Precio as decimal))	+ @Separador +  
		convert(varchar,cast(Resultado_Dif_Mercado as decimal))	+ @Separador + 	 
		convert(varchar,cantidad_dias)					+ @Separador + 
		convert(varchar,moid_libro)						+ @Separador + 
		convert(varchar,cartera)		+ @Separador +
		convert(varchar,CuentaCapital)	+ @Separador +
		convert(varchar,cta1)	+ @Separador +		 
		convert(varchar,CTA2)	+ @Separador +		 
		convert(varchar,CTA3)	+ @Separador +		 
		convert(varchar,CTA4)	+ @Separador +		 
		convert(varchar,inserie)		+ @Separador +	 
		convert(varchar,plazodevengo)		+ @Separador
		as REG_SALIDA
		FROM #ctasFinal

*/


	SELECT 
		convert(varchar,mofecpro)				+ @Separador +
		convert(varchar,morutcart)				+ @Separador + 
		convert(varchar,motipcart)				+ @Separador + 

		convert(varchar,glosa_motipcart)		+ @Separador + 
		convert(varchar,monumdocu)				+ @Separador + 	
		convert(varchar,mocorrela)				+ @Separador + 	
		convert(varchar,monumdocuo)				+ @Separador + 	
		convert(varchar,mocorrelao)				+ @Separador + 	
		convert(varchar,monumoper)				+ @Separador + 	
		convert(varchar,motipoper)				+ @Separador + 	
		convert(varchar,glosa_motipoper)		+ @Separador + 	
		convert(varchar,motipopero)				+ @Separador + 	
		convert(varchar,glosa_motipopero)		+ @Separador + 	
		convert(varchar,moinstser)				+ @Separador + 	
		convert(varchar,momascara)				+ @Separador + 	
		convert(varchar,mocodigo)				+ @Separador + 	
		convert(varchar,glosa_mocodigo)			+ @Separador + 
		convert(varchar,moseriado)				+ @Separador + 

		convert(varchar,mofecemi)				+ @Separador +	
		convert(varchar,mofecven)				+ @Separador +  
		convert(varchar,momonemi)				+ @Separador + 
		convert(varchar,cast(motasemi as numeric(19,4)))	+ @Separador + 
		convert(varchar,mobasemi)				+ @Separador + 
		convert(varchar,morutemi)				+ @Separador + 
		convert(varchar,cast(monominal as numeric(19,4)))	+ @Separador + 
		convert(varchar,cast(movpresen as numeric(19,4)))	+ @Separador + 
		convert(varchar,mofecinip)				+ @Separador + 
		convert(varchar,mofecvenp)				+ @Separador + 
		convert(varchar,motipret)				+ @Separador + 
		convert(varchar,mohora)						+ @Separador + 	 
		convert(varchar,cast(movalant as numeric(19,4)))	+ @Separador + 
		convert(varchar,mostatreg)					+ @Separador + 
		convert(varchar,cast(moutilidad as numeric(19,4)))+ @Separador + 
		convert(varchar,cast(moperdida as numeric(19,4)))	+ @Separador +  
		convert(varchar,cast(movalven as numeric(19,4)))	+ @Separador +  
		convert(varchar,moclave_dcv)				+ @Separador + 
		convert(varchar,cast(momtoPFE as numeric(19,4)))	+ @Separador +	
		convert(varchar,cast(momtoCCE as numeric(19,4)))	+ @Separador +	 
		convert(varchar,fecha_compra_original)						+ @Separador + 
		convert(varchar,cast(valor_compra_original as numeric(19,4)))		+ @Separador +  
		convert(varchar,cast(valor_compra_um_original as numeric(19,4)))	+ @Separador +  
		convert(varchar,cast(tir_compra_original as numeric(19,4)))		+ @Separador + 	
		convert(varchar,Tipo_Cartera_Financiera)					+ @Separador + 
		convert(varchar,Fecha_PagoMañana)				+ @Separador + 	
		convert(varchar,cast(MtoVentaPM as numeric(19,4)))	+ @Separador +  
		convert(varchar,pagoMañana)						+ @Separador + 
		convert(varchar,cast(moTirTran as numeric(19,4)))		+ @Separador +	
		convert(varchar,cast(Resultado_Dif_Precio as numeric(19,4)))	+ @Separador +  
		convert(varchar,cast(Resultado_Dif_Mercado as numeric(19,4)))	+ @Separador + 	 
		convert(varchar,cantidad_dias)					+ @Separador + 
		convert(varchar,id_libro)						+ @Separador + --moid_libro
		convert(varchar,cartera)		+ @Separador +
		convert(varchar,CuentaCapital)	+ @Separador +
		convert(varchar,cta1)	+ @Separador +		 
		convert(varchar,CTA2)	+ @Separador +		 
		convert(varchar,CTA3)	+ @Separador +		 
		convert(varchar,CTA4)	+ @Separador +		 
		convert(varchar,inserie)		+ @Separador +	 
		convert(varchar,plazodevengo)		+ @Separador
		as REG_SALIDA
		FROM #ctasFinal

END 
GO
