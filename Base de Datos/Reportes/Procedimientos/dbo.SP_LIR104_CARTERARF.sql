USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIR104_CARTERARF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[SP_LIR104_CARTERARF]
AS 
BEGIN 

SET NOCOUNT ON

	DECLARE @Separador      VARCHAR(1) 
	SET @Separador = ';'

DECLARE @fecha_desde	DATETIME
	SET @fecha_desde	= (SELECT acfecproc FROM bactradersuda.dbo.mdac); --'2019-12-30'
DECLARE @fecha_hasta	DATETIME
	SET @fecha_hasta	= (SELECT acfecproc FROM bactradersuda.dbo.mdac); 


IF (OBJECT_ID('tempdb.dbo.#TablaCuenta','U')) is not null
    DROP TABLE #TablaCuenta

IF (OBJECT_ID('tempdb.dbo.#tblFinal','U')) is not null
    DROP TABLE #tblFinal

IF (OBJECT_ID('tempdb.dbo.#CarteraTotal','U')) is not null
    DROP TABLE #CarteraTotal 

IF (OBJECT_ID('tempdb.dbo.#tblCtasParche','U')) is not null
    DROP TABLE #tblCtasParche 


SELECT  DISTINCT instrumento
,				 codigovariable
,				 ctaContable 
  INTO #tblCtasParche
  FROM bactradersuda.dbo.Cartera_cuenta_his  f
 WHERE variable = 'valor_compra'
   AND TipoLinea ='D'
   AND t_operacion ='CP'
 ORDER 
    BY  instrumento, codigovariable,ctaContable 


SELECT	DISTINCT numdocu
,		correla
,		variable
,		ctaContable				AS CuentaCapital
  INTO #TablaCuenta
  FROM bactradersuda.dbo.Cartera_cuenta 
 WHERE t_movimiento ='MOV'  
   AND t_operacion ='CP' 
   AND variable ='valor_compra'
UNION 
SELECT	DISTINCT numdocu
,		correla
,		variable
,		ctaContable				AS CuentaCapital
 FROM bactradersuda.dbo.Cartera_cuenta_his
WHERE t_movimiento ='MOV'  
   AND t_operacion ='CP' 
   AND variable ='valor_compra'

 SELECT	numdocu,	
		correla, 
	    MAX(CuentaCapital)	AS CuentaCapital
   INTO #tblFinal
   FROM #TablaCuenta
  GROUP 
     BY numdocu,correla

	SELECT 
			convert(varchar, rsfecha,112)						as Fecha-->>CVM.20200529_AAAAMMDD				
	,		ltrim(convert(char(01),mdrs.codigo_carterasuper))	as codigo_carterasuper
	,		ltrim(convert(varchar,super.tbglosa))				as carterasuper
	,		ltrim(convert(char(5),rsid_libro))					as libro				
	,		ltrim(convert(varchar,libro.tbglosa))				as des_libro
	,		ltrim(convert(char(5),rstipcart))					as tipo_cartera
	,		ISNULL(financiera.tbglosa,'')						as des_tipo_cartera
	,		ltrim(convert(char(15),rscodigo))					as rscodigo					
	,		mnnemo												as moneda											
	,		convert(varchar,rsfeccomp,112)						as fecha_compra-->>CVM.20200529_AAAAMMDD				
	,		'CP'												as tipo												
	,		rsnumdocu											as nro_documento
	,		rsnumoper											as nro_operacion		
	,		rscorrela											as correlativo			
	,		rsinstser											as instrumento					
	,		rsnominal											as nominal						
	,		rstir												as tir							
	,		rsvalcomp											as valor_compra
	,		/*rsvalcomp*/isnull(valor_compra_original,0)		as valor_compra_original
	,		rsinteres											as interes						
	,		rsreajuste											as reajuste						
	,		(rsinteres + rsreajuste)							as devengo_dia				
	,		rsvppresenx											as valor_presente_prox	-->>20200811				
	,       mdrs.rscartera										as cartera
	,		cartera.tbglosa										as des_cartera
	,		isnull(VALORIZACION_MERCADO.valor_mercado,0)	    as valor_mercado
	,		isnull(VALORIZACION_MERCADO.diferencia_mercado,0)	AS AVR
	,		isnull(cta.CuentaCapital,0)							AS Cuenta
	,		VIEW_INSTRUMENTO.inserie							AS Familia  
	,		mdrs.rstipcart										AS TipoCartera 
	,		rsvppresen											as valor_presente -->>20200811
--	,		P.TOT												AS TOT
	  INTO #CarteraTotal
	  FROM bactradersuda.dbo.MDRS MDRS with(nolock)
     LEFT 
	  JOIN bactradersuda.dbo.VALORIZACION_MERCADO VALORIZACION_MERCADO with(nolock)
	    ON VALORIZACION_MERCADO.rmnumdocu = MDRS.rsnumdocu 
	   AND VALORIZACION_MERCADO.rmnumoper = MDRS.rsnumoper 
	   AND VALORIZACION_MERCADO.rmcorrela = MDRS.rscorrela 
	   AND VALORIZACION_MERCADO.fecha_valorizacion = rsfecha --[dbo].[Fx_Buscar_Fecha_Habil_Anterior](rsfecha,1,6) 
	   AND VALORIZACION_MERCADO.id_sistema='BTR' 
	   --AND VALORIZACION_MERCADO.tipo_operacion<>'CG'
LEFT JOIN bactradersuda.dbo.VIEW_EMISOR VIEW_EMISOR 
	    ON VIEW_EMISOR.emrut=mdrs.rsrutemis 
LEFT JOIN bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO 
        ON VIEW_INSTRUMENTO.incodigo= mdrs.rscodigo
 LEFT JOIN bactradersuda.dbo.VIEW_MONEDA VIEW_MONEDA 
	    ON VIEW_MONEDA.mncodmon=mdrs.rsmonemi
 LEFT JOIN BacTraderSuda..MDMH h with(nolock)
	    ON h.mofecpro=rsfeccomp 
	   AND h.monumdocu=rsnumdocu 
	   AND h.monumoper=rsnumdocu 
	   AND h.mocorrela=rscorrela 
	   AND motipoper='CP'
 LEFT JOIN bacparamsuda.dbo.tabla_general_detalle libro 
		ON libro.tbcateg=1552 
	   AND libro.tbcodigo1 = rsid_libro
 LEFT JOIN bacparamsuda.dbo.tabla_general_detalle financiera 
		ON financiera.tbcateg=204 
	   AND financiera.tbcodigo1 = rstipcart
 LEFT JOIN bacparamsuda.dbo.tabla_general_detalle super 
		ON super.tbcateg=1111 
	   AND super.tbcodigo1 = mdrs.codigo_carterasuper
 LEFT JOIN bacparamsuda.dbo.tabla_general_detalle cartera 
		ON cartera.tbcateg=9921 
	   AND cartera.tbcodigo1 = mdrs.rscartera
 LEFT JOIN #tblFinal cta 
		ON NumDocu = rsnumdocu  
	   AND Correla = rscorrela
     WHERE MDRS.rstipoper='DEV' 
	   AND MDRS.rsfecha BETWEEN @fecha_desde AND @fecha_hasta -->>CVM.20200611 rango de fechas 
	   AND MDRS.rscartera IN (159,111,114) 
     ORDER 
	    BY mdrs.rsfecha, 
		   mdrs.rsnumdocu, 
		   mdrs.rscorrela 

-- --------------------------------------------------------------------------------------
-- Actualización de cuentaas Contables en base a data empirica en base al codigo de cartera
-- ======================================================================================
UPDATE #CarteraTotal 
   SET Cuenta    = p.CtaContable
  FROM #CarteraTotal a 
 INNER 
  JOIN #tblCtasParche p 
    ON p.instrumento	= a.Familia
   AND p.CodigoVariable = a.TipoCartera
 WHERE a.Cuenta =0
 -- ======================================================================================
 
 -- --------------------------------------------------------------------------------------
-- Actualización de cuentas Contables en base a data empirica en base al instrumento 
-- =======================================================================================
 UPDATE #CarteraTotal 
   SET Cuenta    = p.CtaContable
  FROM #CarteraTotal a 
 INNER 
  JOIN #tblCtasParche p 
    ON p.instrumento	= a.Familia
 WHERE a.Cuenta =0
 -- ======================================================================================


/*ACTUALIZACION POR FORMATO DECIMAL 20210630
SELECT 
		convert(varchar,fecha,105)									+ @Separador +
		ltrim(convert(char(01),codigo_carterasuper))				+ @Separador +
		ltrim(convert(varchar,carterasuper))						+ @Separador +
		ltrim(convert(char(5),libro))								+ @Separador +
		ltrim(convert(varchar,des_libro))							+ @Separador +
		ltrim(convert(char(5),tipo_cartera))						+ @Separador +
		ISNULL(des_tipo_cartera,'')									+ @Separador +
		ltrim(convert(char(15),rscodigo)) 							+ @Separador + --as codigo_instrumento
		moneda														+ @Separador +
		convert(varchar,fecha_compra,105)							+ @Separador +	
		tipo														+ @Separador +		
		convert(varchar,nro_documento)								+ @Separador +	
		convert(varchar,nro_operacion)								+ @Separador +	
		convert(varchar,correlativo)								+ @Separador +
		instrumento													+ @Separador +
		ltrim(convert(varchar,cast(nominal as decimal)))			+ @Separador +
		ltrim(convert(varchar,cast(tir as float))) 					+ @Separador + -- as tir_compra
		ltrim(convert(varchar,cast(valor_compra as decimal)))		+ @Separador +
		ltrim(convert(varchar,cast(valor_compra_original as decimal)))		+ @Separador +
		ltrim(convert(varchar,cast(interes as decimal)))					+ @Separador + --as interes_diario
		ltrim(convert(varchar,cast(reajuste as decimal))) 					+ @Separador + --reajuste_diario
		ltrim(convert(varchar,cast(devengo_dia as decimal)))  				+ @Separador + --as devengo_diario
		ltrim(convert(varchar,cast(valor_presente_prox as decimal)))		+ @Separador +-->>20200811

		ltrim(convert(varchar,cast(cartera as decimal)))			+ @Separador +
		ltrim(convert(varchar,des_cartera))							+ @Separador +
		ltrim(convert(varchar,cast(valor_mercado as decimal)))		+ @Separador +
		ltrim(convert(varchar,cast(avr as decimal)))				+ @Separador+
		ltrim(convert(varchar,cast(cuenta as decimal)))			+ @Separador + --as cta_cble_activo
		ltrim(convert(varchar,cast(valor_presente as decimal))) -->>20200811

	as REG_SALIDA
   from #CarteraTotal
*/


SELECT 
		convert(varchar,fecha,105)									+ @Separador +
		ltrim(convert(char(01),codigo_carterasuper))				+ @Separador +
		ltrim(convert(varchar,carterasuper))						+ @Separador +
		ltrim(convert(char(5),libro))								+ @Separador +
		ltrim(convert(varchar,des_libro))							+ @Separador +
		ltrim(convert(char(5),tipo_cartera))						+ @Separador +
		ISNULL(des_tipo_cartera,'')									+ @Separador +
		ltrim(convert(char(15),rscodigo)) 							+ @Separador + --as codigo_instrumento
		moneda														+ @Separador +
		convert(varchar,fecha_compra,105)							+ @Separador +	
		tipo														+ @Separador +		
		convert(varchar,nro_documento)								+ @Separador +	
		convert(varchar,nro_operacion)								+ @Separador +	
		convert(varchar,correlativo)								+ @Separador +
		instrumento													+ @Separador +
		ltrim(convert(varchar,cast(nominal as numeric(19,4))))			+ @Separador +
		ltrim(convert(varchar,cast(tir as float))) 					+ @Separador + -- as tir_compra
		ltrim(convert(varchar,cast(valor_compra as numeric(19,4))))		+ @Separador +
		ltrim(convert(varchar,cast(valor_compra_original as numeric(19,4))))		+ @Separador +
		ltrim(convert(varchar,cast(interes as numeric(19,4))))					+ @Separador + --as interes_diario
		ltrim(convert(varchar,cast(reajuste as numeric(19,4)))) 					+ @Separador + --reajuste_diario
		ltrim(convert(varchar,cast(devengo_dia as numeric(19,4))))  				+ @Separador + --as devengo_diario
		ltrim(convert(varchar,cast(valor_presente_prox as numeric(19,4))))		+ @Separador +-->>20200811

		ltrim(convert(varchar,cast(cartera as numeric(19,0))))			+ @Separador + -->>20210802
		ltrim(convert(varchar,des_cartera))							+ @Separador +
		ltrim(convert(varchar,cast(valor_mercado as numeric(19,4))))		+ @Separador +
		ltrim(convert(varchar,cast(avr as numeric(19,4))))				+ @Separador+
		ltrim(convert(varchar,cast(cuenta as numeric(19))))			+ @Separador + --as cta_cble_activo
		ltrim(convert(varchar,cast(valor_presente as numeric(19,4)))) + @Separador  -->>20200811

	as REG_SALIDA
   from #CarteraTotal

END 
GO
