USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIR104_DEVRF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LIR104_DEVRF]
AS 
BEGIN

	SET NOCOUNT ON 

	DECLARE @Separador      VARCHAR(1)
	SET @Separador = ';'

	DECLARE @fecha_desde	DATETIME
		SET @fecha_desde	= (SELECT acfecproc FROM bactradersuda.dbo.mdac); --'2019-12-30'
	DECLARE @fecha_hasta	DATETIME
		SET @fecha_hasta	= (SELECT acfecproc FROM bactradersuda.dbo.mdac); --'2019-12-30'


	IF (OBJECT_ID('tempdb.dbo.#DevengoFinal','U')) is not null
		drop table #DevengoFinal

	IF (OBJECT_ID('tempdb.dbo.#TablaCuenta','U')) is not null
		drop table #TablaCuenta

	IF (OBJECT_ID('tempdb.dbo.#tblFinal','U')) is not null
		drop table #tblFinal

	IF (OBJECT_ID('tempdb.dbo.#tblCtasParche','U')) is not null
		DROP TABLE #tblCtasParche 

	IF (OBJECT_ID('tempdb.dbo.#DevRFTotal','U')) is not null
		DROP TABLE #DevRFTotal

	IF (OBJECT_ID('tempdb.dbo.#CTASDEVENGO','U')) is not null
		DROP TABLE #CTASDEVENGO

	IF (OBJECT_ID('tempdb.dbo.#TEMPOCTA','U')) is not null
		DROP TABLE #TEMPOCTA



CREATE TABLE #TEMPOCTA
(	FAMILIA		VARCHAR(10)		,
	CARTERA		CHAR(1)			,
	CUENTA		NUMERIC(10)		,
	TIPO		NUMERIC(2)	
)
---------

INSERT INTO #TEMPOCTA VALUES('BCD','A',715201008,11)
INSERT INTO #TEMPOCTA VALUES('BCD','A',735201006,12)
INSERT INTO #TEMPOCTA VALUES('BCD','P',715201008,11)
INSERT INTO #TEMPOCTA VALUES('BCD','P',735201006,12)
INSERT INTO #TEMPOCTA VALUES('BCD','T',715101008,11)
INSERT INTO #TEMPOCTA VALUES('BCD','T',735101006,12)
INSERT INTO #TEMPOCTA VALUES('BCP','A',715201002,11)
INSERT INTO #TEMPOCTA VALUES('BCP','P',715201002,11)
INSERT INTO #TEMPOCTA VALUES('BCP','T',715101002,11)
INSERT INTO #TEMPOCTA VALUES('BCU','A',715201005,11)
INSERT INTO #TEMPOCTA VALUES('BCU','A',735201003,12)
INSERT INTO #TEMPOCTA VALUES('BCU','P',715201005,11)
INSERT INTO #TEMPOCTA VALUES('BCU','P',735201003,12)
INSERT INTO #TEMPOCTA VALUES('BCU','T',715101005,11)
INSERT INTO #TEMPOCTA VALUES('BCU','T',735101003,12)
INSERT INTO #TEMPOCTA VALUES('BCX','A',715204001,11)
INSERT INTO #TEMPOCTA VALUES('BCX','P',715204001,11)
INSERT INTO #TEMPOCTA VALUES('BCX','T',715104001,11)
INSERT INTO #TEMPOCTA VALUES('BONOS','A',715201016,11)
INSERT INTO #TEMPOCTA VALUES('BONOS','A',735201012,12)
INSERT INTO #TEMPOCTA VALUES('BONOS','P',715201025,11)
INSERT INTO #TEMPOCTA VALUES('BONOS','P',715201019,12)
INSERT INTO #TEMPOCTA VALUES('BONOS','T',715101017,11)
INSERT INTO #TEMPOCTA VALUES('BONOS','T',715201019,12)
INSERT INTO #TEMPOCTA VALUES('BR','A',715201010,11)
INSERT INTO #TEMPOCTA VALUES('BR','A',735201008,12)
INSERT INTO #TEMPOCTA VALUES('BR','P',715201010,11)
INSERT INTO #TEMPOCTA VALUES('BR','P',735201008,12)
INSERT INTO #TEMPOCTA VALUES('BR','T',715101010,11)
INSERT INTO #TEMPOCTA VALUES('BR','T',735101008,12)
INSERT INTO #TEMPOCTA VALUES('BTP','A',715201020,11)
INSERT INTO #TEMPOCTA VALUES('BTP','P',715201020,11)
INSERT INTO #TEMPOCTA VALUES('BTP','T',715101022,11)
INSERT INTO #TEMPOCTA VALUES('BTU','A',715101009,11)
INSERT INTO #TEMPOCTA VALUES('BTU','A',735101007,12)
INSERT INTO #TEMPOCTA VALUES('BTU','P',715201009,11)
INSERT INTO #TEMPOCTA VALUES('BTU','P',735201007,12)
INSERT INTO #TEMPOCTA VALUES('BTU','T',715101009,11)
INSERT INTO #TEMPOCTA VALUES('BTU','T',735101007,12)
INSERT INTO #TEMPOCTA VALUES('CERO','A',715201004,11)
INSERT INTO #TEMPOCTA VALUES('CERO','A',735201002,12)
INSERT INTO #TEMPOCTA VALUES('CERO','P',715201004,11)
INSERT INTO #TEMPOCTA VALUES('CERO','P',735201002,12)
INSERT INTO #TEMPOCTA VALUES('CERO','T',715101004,11)
INSERT INTO #TEMPOCTA VALUES('CERO','T',735101002,12)
INSERT INTO #TEMPOCTA VALUES('DPF','A',715101012,11)
INSERT INTO #TEMPOCTA VALUES('DPF','P',715101012,11)
INSERT INTO #TEMPOCTA VALUES('DPF','T',715101012,11)
INSERT INTO #TEMPOCTA VALUES('DPR','A',715201015,11)
INSERT INTO #TEMPOCTA VALUES('DPR','A',735201011,12)
INSERT INTO #TEMPOCTA VALUES('DPR','P',715201015,11)
INSERT INTO #TEMPOCTA VALUES('DPR','P',735201011,12)
INSERT INTO #TEMPOCTA VALUES('DPR','T',715101015,11)
INSERT INTO #TEMPOCTA VALUES('DPR','T',735101011,12)
INSERT INTO #TEMPOCTA VALUES('FMUTUO','A',715201002,11)
INSERT INTO #TEMPOCTA VALUES('FMUTUO','P',715201002,11)
INSERT INTO #TEMPOCTA VALUES('FMUTUO','T',715101002,11)
INSERT INTO #TEMPOCTA VALUES('ICPN','A',715201021,11)
INSERT INTO #TEMPOCTA VALUES('ICPN','P',715201021,11)
INSERT INTO #TEMPOCTA VALUES('ICPN','T',715101023,11)
INSERT INTO #TEMPOCTA VALUES('ICPR','A',715201022,11)
INSERT INTO #TEMPOCTA VALUES('ICPR','P',715201022,11)
INSERT INTO #TEMPOCTA VALUES('ICPR','T',715101024,11)
INSERT INTO #TEMPOCTA VALUES('LCHR','A',715201013,11)
INSERT INTO #TEMPOCTA VALUES('LCHR','A',735201009,12)
INSERT INTO #TEMPOCTA VALUES('LCHR','P',715201013,11)
INSERT INTO #TEMPOCTA VALUES('LCHR','P',735201009,12)
INSERT INTO #TEMPOCTA VALUES('LCHR','T',715101011,11)
INSERT INTO #TEMPOCTA VALUES('LCHR','T',735101009,12)
INSERT INTO #TEMPOCTA VALUES('PCX','A',715204002,11)
INSERT INTO #TEMPOCTA VALUES('PCX','P',715204002,11)
INSERT INTO #TEMPOCTA VALUES('PCX','T',715104002,11)
INSERT INTO #TEMPOCTA VALUES('PDBC','A',715301003,11)
INSERT INTO #TEMPOCTA VALUES('PDBC','P',715201001,11)
INSERT INTO #TEMPOCTA VALUES('PDBC','T',715101001,11)
INSERT INTO #TEMPOCTA VALUES('PRC','A',715201003,11)
INSERT INTO #TEMPOCTA VALUES('PRC','A',735201001,12)
INSERT INTO #TEMPOCTA VALUES('PRC','P',715201003,11)
INSERT INTO #TEMPOCTA VALUES('PRC','P',735201001,12)
INSERT INTO #TEMPOCTA VALUES('PRC','T',715101003,11)
INSERT INTO #TEMPOCTA VALUES('PRC','T',735101001,12)
INSERT INTO #TEMPOCTA VALUES('PRD','A',715201006,11)
INSERT INTO #TEMPOCTA VALUES('PRD','A',735201004,12)
INSERT INTO #TEMPOCTA VALUES('PRD','P',715201006,11)
INSERT INTO #TEMPOCTA VALUES('PRD','P',735201004,12)
INSERT INTO #TEMPOCTA VALUES('PRD','T',715101006,11)
INSERT INTO #TEMPOCTA VALUES('PRD','T',735101004,12)
INSERT INTO #TEMPOCTA VALUES('XERO','A',715204003,11)
INSERT INTO #TEMPOCTA VALUES('XERO','P',715204003,11)
INSERT INTO #TEMPOCTA VALUES('XERO','T',715104003,11)

---------
SELECT codigo_instrumento, CarteraNormativa,TipoInstrumento,TipoEmisor,OrigenEmision,CodigoCartera,V.codigo_cuenta,codigo_campo 
INTO #CTASDEVENGO
FROM  bacparamsuda.dbo.PERFIL_CNT A
  INNER JOIN  bacparamsuda.dbo.PERFIL_DETALLE_CNT B
  ON A.folio_perfil=B.folio_perfil
  INNER JOIN  bacparamsuda.dbo.PERFIL_VARIABLE_CNT V ON V.folio_perfil= A.folio_perfil AND V.correlativo_perfil = B.correlativo_perfil 

  left join (select * from bacparamsuda.dbo.TBL_CLASIFICACION_CARTERA_INSTRUMENTO   	WHERE id_sistema = 'BTR' AND Tipo_movimiento = 'DEV' AND Tipo_operacion = 'DVCP' ) cc on cc.CodigoCartera =V.valor_dato_campo
   WHERE a.tipo_operacion='DVCP' AND A.id_sistema='BTR'
  AND
   (SUBSTRING(CONVERT(VARCHAR,V.codigo_cuenta),1,1)=5	
  OR SUBSTRING(CONVERT(VARCHAR,V.codigo_cuenta),1,1)=7)

  
	SELECT  DISTINCT instrumento
	,				 codigovariable
	,				 ctaContable 
	,				 variable 
	  INTO #tblCtasParche
	  FROM bactradersuda.dbo.Cartera_cuenta_his  f with(nolock)

	 WHERE t_movimiento ='DEV'  
	   AND t_operacion ='DVCP' 
	   AND (variable ='Interes_papel'
		OR variable ='Reajuste_papel')
	 ORDER 
		BY  instrumento, codigovariable,ctaContable 


SELECT	DISTINCT numdocu
,		correla
,		variable
,		ctaContable				as CuentaInteres
,		Convert(char(20),'')	as CuentaReajuste
  INTO #TablaCuenta
  FROM bactradersuda.dbo.Cartera_cuenta with(nolock)
 WHERE t_movimiento ='DEV'  
   AND t_operacion ='DVCP' 
   AND variable ='Interes_papel'
union 
SELECT	DISTINCT numdocu
,		correla
,		variable
,		ctaContable				as CuentaInteres
,		Convert(char(20),'')	as CuentaReajuste
  FROM bactradersuda.dbo.Cartera_cuenta_his with(nolock)
 WHERE t_movimiento ='DEV'  
   AND t_operacion ='DVCP' 
   AND variable ='Interes_papel'
union 
SELECT	DISTINCT numdocu
,		correla
,		variable
,		Convert(char(20),'')	as CuentaInteres
,		ctaContable				as CuentaReajuste
--  INTO #TablaCuenta
  FROM bactradersuda.dbo.Cartera_cuenta with(nolock)
 WHERE t_movimiento ='DEV'  
   AND t_operacion ='DVCP' 
   AND variable ='Reajuste_papel'
union 
SELECT	DISTINCT numdocu
,		correla
,		variable
,		Convert(char(20),'')	as CuentaInteres
,		ctaContable				as CuentaReajuste
--  INTO #TablaCuenta
  FROM bactradersuda.dbo.Cartera_cuenta_his with(nolock)
 WHERE t_movimiento ='DEV'  
   AND t_operacion ='DVCP' 
   AND variable ='Reajuste_papel'

  SELECT	numdocu,	
			correla, 
			max(cuentainteres)	as ctaInteres ,
			max(cuentareajuste) as ctaReajuste 
	INTO #tblFinal
	FROM #TablaCuenta
   group 
      by numdocu,correla
/*
	  SELECT distinct INSTRUMENTO,CodigoVariable,tbglosa
	    FROM bactradersuda.dbo.Cartera_cuenta_his
 LEFT JOIN bacparamsuda.dbo.tabla_general_detalle financiera 
		ON financiera.tbcateg=204 
	   AND financiera.tbcodigo1 = CodigoVariable
		where VARIABLE ='valor_compra'
	order by INSTRUMENTO,CodigoVariable
*/	
	SELECT 
			convert(varchar, rsfecha,112) as rsfecha -->>CVM.20200529_AAAAMMDD
		,	rsrutcart
		,	rstipcart
		,	rsnumdocu
		,	rscorrela
		,	rsnumoper
		,	rscartera
		,	rstipoper
		,	rsinstser
		,	rsrutcli 
		,	rscodcli 
		,	rsvppresen 
		,	rsvppresenx 
		,	rscupamo 
		,	rscupint 
		,	rscuprea 
		,	rsflujo 
		,	convert(varchar, rsfecprox,112) as rsfecprox -->>CVM.20200529_AAAAMMDD 
		,	convert(varchar, rsfecctb,112) as rsfecctb-->>CVM.20200529_AAAAMMDD 
		,	rsnominal 
		,	rstir
		,	rstasfloat
		,	rsmonpact
		,	rsmonemi
		,	rstasemi
		,	rsbasemi
		,	rscodigo
		,	rsinteres 
		,	rsreajuste 
		,	rsnumucup
		,	rsnumpcup
		,	rsinteres_acumcp 
		,	rsreajuste_acumcp 
		,	valor_tasa_emision 
		,	valor_par
		,	convert(varchar, Fecha_PagoMañana,112) as Fecha_PagoMañana-->>CVM.20200529_AAAAMMDD 
		,	ISNULL(cta.ctaInteres,0) AS  cta_cble_interes
		,	isnull(cta.ctaReajuste,0) AS  cta_cble_reajuste
			,   inserie				
			, codigo_Carterasuper, emrut
		  ,case when incodigo <> 15 then 0 else incodigo end			as Instru 
   ,codigo_carterasuper											as cartera
   ,  CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END		as tipoBono	
   ,  (CASE WHEN emrut = '97023000' THEN 1			
        ELSE (CASE WHEN emtipo <> 2 THEN 0   
          ELSE emtipo END)   
        END )	as Emisor
into #DevRFTotal
FROM bactradersuda.dbo.mdrs with(nolock)
left join  #tblFinal cta on NumDocu = rsnumdocu  and Correla = rscorrela
	INNER JOIN bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO 
			ON VIEW_INSTRUMENTO.incodigo= rscodigo
LEFT JOIN  bacparamsuda.dbo.EMISOR ON EMRUT = RSRUTEMIS
where rscartera in (111,114,159)
	AND rsfecha  between @fecha_desde and @fecha_hasta
	--AND rsfecha ='20020520'--AQUI between @fecha_desde and @fecha_hasta

/*
 SELECT   case when incodigo <> 15 then 0 else incodigo end			as Instru 
   ,codigo_carterasuper											as cartera
   ,  CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END		as tipoBono	
   ,  (CASE WHEN emrut = '97023000' THEN 1			
        ELSE (CASE WHEN emtipo <> 2 THEN 0   
          ELSE emtipo END)   
        END )	as Emisor,
    FROM BACTRADERSUDA..MDrs LEFT JOIN  BACPARAMSUDA..EMISOR  ON emrut = rsrutemis 
   INNER JOIN  BACPARAMSUDA..INSTRUMENTO     ON incodigo  = rscodigo  )
   as datas
   INNER JOIN 
   */



	-- ---------------------------------------------------------------------------------------------------
	-- Actualización de cuentaas Contables Interes en base a data empirica en base al codigo de cartera
	-- ===================================================================================================
	UPDATE #DevRFTotal  
	   SET cta_cble_interes   = p.CtaContable
	  FROM #DevRFTotal a 
	 INNER 
	  JOIN #tblCtasParche p 
		ON p.instrumento	= a.inserie 
	   AND p.CodigoVariable = a.rstipcart
	   AND p.Variable = 'Interes_papel'
	 WHERE a.cta_cble_interes =0
/*
select 	  * FROM #ContaRFTotal a 
	 INNER 
	  JOIN #tblCtasParche p 
		ON p.instrumento	= a.inserie 
	   AND p.CodigoVariable = a.cartera 
	 WHERE a.cta_cble_interes =0
	 */
	 -- ==================================================================================================

	-- --------------------------------------------------------------------------------------
	-- Actualización de cuentaas Contables Interesen base a data empirica en base al codigo de cartera
	-- ======================================================================================
	UPDATE #DevRFTotal  
	   SET cta_cble_interes   = p.CtaContable
	  FROM #DevRFTotal a 
	 INNER 
	  JOIN #tblCtasParche p 
		ON p.instrumento	= a.inserie 
	   AND p.Variable = 'Interes_papel'
	 WHERE a.cta_cble_interes =0
	 -- ======================================================================================

	 -- --------------------------------------------------------------------------------------
	-- Actualización de cuentaas Contables Reajuste en base a data empirica en base al codigo de cartera
	-- ======================================================================================
	UPDATE #DevRFTotal  
	   SET cta_cble_reajuste = p.CtaContable
	  FROM #DevRFTotal a 
	 INNER 
	  JOIN #tblCtasParche p 
		ON p.instrumento	= a.inserie 
	   AND p.CodigoVariable = a.rstipcart
	   AND p.Variable = 'Reajuste_papel' 
	 WHERE a.cta_cble_reajuste =0
	 -- ======================================================================================

	-- --------------------------------------------------------------------------------------
	-- Actualización de cuentaas Contables en base a data empirica en base al codigo de cartera
	-- ======================================================================================
	UPDATE #DevRFTotal  
		 SET cta_cble_reajuste = p.CtaContable
	  FROM #DevRFTotal a 
	 INNER 
	  JOIN #tblCtasParche p 
		ON p.instrumento	= a.inserie 
			   AND p.Variable = 'Reajuste_papel' 

	 WHERE a.cta_cble_reajuste =0


	SELECT 
			rsfecha
		,	rsrutcart
		,	rstipcart
		,	rsnumdocu
		,	rscorrela
		,	rsnumoper
		,	rscartera
		,	rstipoper
		,	rsinstser
		,	rsrutcli 
		,	rscodcli 
		,	rsvppresen 
		,	rsvppresenx 
		,	rscupamo 
		,	rscupint 
		,	rscuprea 
		,	rsflujo 
		,	rsfecprox
		,	rsfecctb
		,	rsnominal 
		,	rstir
		,	rstasfloat
		,	rsmonpact
		,	rsmonemi
		,	rstasemi
		,	rsbasemi
		,	rscodigo
		,	rsinteres 
		,	rsreajuste 
		,	rsnumucup
		,	rsnumpcup
		,	rsinteres_acumcp 
		,	rsreajuste_acumcp 
		,	valor_tasa_emision 
		,	valor_par
		,	Fecha_PagoMañana
		,	isnull(TpInteres.cuenta,0)  as cta_cble_interes
		,	isnull(TpReajuste.CUENTA,0) as cta_cble_reajuste
		, codigo_Carterasuper
		, emrut , Emisor 
into #DevengoFinal
from #DevRFTotal datas
LEFT JOIN	#TEMPOCTA  TpInteres
ON TpInteres.familia = datas.inserie
and TpInteres.cartera  = datas.cartera
and TpInteres.TIPO = 11
  
LEFT JOIN	#TEMPOCTA  TpReajuste 
ON TpReajuste.familia = datas.inserie
and TpReajuste .cartera  = datas.cartera
and TpReajuste .TIPO = 12


update  #DevengoFinal
set  cta_cble_interes = case when cta_cble_interes = '715201025'  then case when rstipcart = 22 then '715201016' 
																			when rstipcart = 35 then '715201016' 
																			when rstipcart =  2 then '715201018'
																			else cta_cble_interes
																		end
						else cta_cble_interes
						end																				
,
  cta_cble_reajuste = case when cta_cble_reajuste = '715201025'  then case when rstipcart = 22 then '715201016' 
																			when rstipcart = 35 then '715201016' 
																			when rstipcart =  2 then '715201018'
																			else cta_cble_reajuste
																		end
							when cta_cble_reajuste = '715201019'  then case when rstipcart = 2 then '735201013'
																		else '735201012'
																		end  
						else cta_cble_reajuste
						end 


update  #DevengoFinal
set  cta_cble_interes = case when cta_cble_interes = '715101012'  then case when codigo_carterasuper = 'T' then '715101012' 
																			when codigo_carterasuper = 'A' then '715201012' 
																			when codigo_carterasuper = 'P' then '715201012'
																			else cta_cble_interes
																		end
						else cta_cble_interes
						end																				


/*ACTUALIZACION POR FORMATO DECIMAL 20210630
SELECT 
	convert(varchar,rsfecha)	+ @Separador +                           
	convert(varchar,rsrutcart)	+ @Separador +                               
	convert(varchar,rstipcart)	+ @Separador +                                
	convert(varchar,rsnumdocu)	+ @Separador +                               
	convert(varchar,rscorrela)	+ @Separador +                                
	convert(varchar,rsnumoper)	+ @Separador +                                
	convert(varchar,rscartera)	+ @Separador + 
	convert(varchar,rstipoper)	+ @Separador +  
	convert(varchar,rsinstser)	+ @Separador +   
	convert(varchar,rsrutcli)	+ @Separador +                                
	convert(varchar,rscodcli)	+ @Separador +                                
	convert(varchar,cast(rsvppresen as decimal))	+ @Separador +                               
	convert(varchar,cast(rsvppresenx as decimal))	+ @Separador +                            
	convert(varchar,cast(rscupamo as decimal))		+ @Separador +                                 
	convert(varchar,cast(rscupint as decimal))		+ @Separador +      
	convert(varchar,cast(rscuprea as decimal))	+ @Separador +                                  
	convert(varchar,cast(rsflujo as decimal))	+ @Separador +                                
	convert(varchar,rsfecprox)	+ @Separador +                     
	convert(varchar,rsfecctb)	+ @Separador +                     
	convert(varchar,cast(rsnominal as decimal))	+ @Separador +                               
	convert(varchar,cast(rstir as decimal))		+ @Separador +                           
	convert(varchar,cast(rstasfloat as decimal))+ @Separador + 
	convert(varchar,rsmonpact)	+ @Separador +                               
	convert(varchar,rsmonemi)	+ @Separador +                             
	convert(varchar,cast(rstasemi as decimal))	+ @Separador +                          
	convert(varchar,rsbasemi)	+ @Separador +                                 
	convert(varchar,rscodigo)	+ @Separador +                             
	convert(varchar,cast(rsinteres as decimal))	+ @Separador +                                 
	convert(varchar,cast(rsreajuste as decimal))	+ @Separador +    
	convert(varchar,rsnumucup)	+ @Separador +     
	convert(varchar,rsnumpcup)	+ @Separador +     
	convert(varchar,cast(rsinteres_acumcp as decimal))	+ @Separador +                        
	convert(varchar,cast(rsreajuste_acumcp as decimal))	+ @Separador +                        
	convert(varchar,cast(valor_tasa_emision as decimal))+ @Separador +                      
	convert(varchar,cast(valor_par as decimal))			+ @Separador +                               
	convert(varchar,Fecha_PagoMañana)	+ @Separador +               
	convert(varchar,cta_cble_interes)	+ @Separador +                        
	convert(varchar,cta_cble_reajuste)	+ @Separador +                       
	codigo_Carterasuper					+ @Separador +
	convert(varchar,emrut)				+ @Separador +                       
	convert(varchar,Emisor)				+ @Separador
as REG_SALIDA
FROM #DevengoFinal 						

*/

SELECT 
	convert(varchar,rsfecha)	+ @Separador +                           
	convert(varchar,rsrutcart)	+ @Separador +                               
	convert(varchar,rstipcart)	+ @Separador +                                
	convert(varchar,rsnumdocu)	+ @Separador +                               
	convert(varchar,rscorrela)	+ @Separador +                                
	convert(varchar,rsnumoper)	+ @Separador +                                
	convert(varchar,rscartera)	+ @Separador + 
	convert(varchar,rstipoper)	+ @Separador +  
	convert(varchar,rsinstser)	+ @Separador +   
	convert(varchar,rsrutcli)	+ @Separador +                                
	convert(varchar,rscodcli)	+ @Separador +                                
	convert(varchar,cast(rsvppresen as numeric(19,4)))	+ @Separador +                               
	convert(varchar,cast(rsvppresenx as numeric(19,4)))	+ @Separador +                            
	convert(varchar,cast(rscupamo as numeric(19,4)))		+ @Separador +                                 
	convert(varchar,cast(rscupint as numeric(19,4)))		+ @Separador +      
	convert(varchar,cast(rscuprea as numeric(19,4)))	+ @Separador +                                  
	convert(varchar,cast(rsflujo as numeric(19,4)))	+ @Separador +                                
	convert(varchar,rsfecprox)	+ @Separador +                     
	convert(varchar,rsfecctb)	+ @Separador +                     
	convert(varchar,cast(rsnominal as numeric(19,4)))	+ @Separador +                               
	convert(varchar,cast(rstir as numeric(19,4)))		+ @Separador +                           
	convert(varchar,cast(rstasfloat as numeric(19,4)))+ @Separador + 
	convert(varchar,rsmonpact)	+ @Separador +                               
	convert(varchar,rsmonemi)	+ @Separador +                             
	convert(varchar,cast(rstasemi as numeric(19,4)))	+ @Separador +                          
	convert(varchar,rsbasemi)	+ @Separador +                                 
	convert(varchar,rscodigo)	+ @Separador +                             
	convert(varchar,cast(rsinteres as numeric(19,4)))	+ @Separador +                                 
	convert(varchar,cast(rsreajuste as numeric(19,4)))	+ @Separador +    
	convert(varchar,rsnumucup)	+ @Separador +     
	convert(varchar,rsnumpcup)	+ @Separador +     
	convert(varchar,cast(rsinteres_acumcp as numeric(19,4)))	+ @Separador +                        
	convert(varchar,cast(rsreajuste_acumcp as numeric(19,4)))	+ @Separador +                        
	convert(varchar,cast(valor_tasa_emision as numeric(19,4)))+ @Separador +                      
	convert(varchar,cast(valor_par as numeric(19,8)))			+ @Separador +                               
	convert(varchar,Fecha_PagoMañana)	+ @Separador +               
	convert(varchar,cta_cble_interes)	+ @Separador +                        
	convert(varchar,cta_cble_reajuste)	+ @Separador +                       
	codigo_Carterasuper					+ @Separador +
	convert(varchar,emrut)				+ @Separador +                       
	convert(varchar,Emisor)				+ @Separador
as REG_SALIDA
FROM #DevengoFinal 						




end   
/*
select top 10 * from bactradersuda.dbo.mdrs
*/
GO
