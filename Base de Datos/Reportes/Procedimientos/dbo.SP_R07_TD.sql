USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_R07_TD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_R07_TD](@dFechaProceso		DateTime=NULL)
AS
BEGIN
SET NOCOUNT ON  
    
Declare @SEP VarChar(1); Set @SEP = ';'

Declare @TipoSalida	bit = 1
--flag para definir tipo de salida SQL
--set @TipoSalida=0

if @dFechaProceso is null
begin 
			set @dFechaProceso = (select acfecproc from bactradersuda..mdac)
end


--Set @dFechaProceso='20200423'


declare @TD as table	 (
		fechaproceso				datetime,
		localidad					varchar(10),--3),
		vehiculo					varchar(20),--15),
		tipoproducto				varchar(30),--25),
		producto					varchar(30),--15),
		numerooperacion				varchar(50),--15),
		tipoflujo					VARCHAR(3),
		numeroflujo					int,
		cliente						VARCHAR(15),--numeric(9),
		nombrecliente				VARCHAR(70),
		codigocarterafinanciera		NUMERIC(9),
		carterafinanciera			VARCHAR(50),
		codigocarteranormativa		varchar(20),--1),
		carteranormativa			VARCHAR(50),
		codigolibro					int,
		libro						VARCHAR(50)	,
		familia						VARCHAR(20),--25),
		mascara						VARCHAR(20),--25),
		instrumento					VARCHAR(20),--25),
		codigomoneda				int,--NUMERIC(9),
		moneda						VARCHAR(5),--3),
		codigoemisor				VARCHAR(15),--NUMERIC(9),
		emisor						varchar(20),--50),
		fechavencimiento			datetime,
		tenor						int,
		saldoresidual				numeric(19,4),--numeric(24,8) ,
		tasa						numeric(19,4),--numeric(24,8) ,
		spread						numeric(19,4),--numeric(24,8) ,
		amortizacion				numeric(19,4),--numeric(24,8) ,
		flujoadicional				numeric(19,4),--numeric(24,8),
		interes						numeric(19,4),--numeric(24,8),
		flujo						numeric(19,4),--numeric(24,8),
		amortizacionclp				numeric(19,4),--numeric(24,8),
		flujoadicionalclp			numeric(19,4),--numeric(24,8),
		interesclp					numeric(19,4),--numeric(24,8),
		flujoclp					numeric(19,4),--numeric(24,8),
		num_doc						numeric(10),--9),		--campo nuevo / Número del Documento
		correlativo					int,					--campo nuevo
		operacion					numeric(9)
		)

Declare @R07_TD_SALIDA TABLE 
	(
	REG_SALIDA		Varchar(600))
		
--Rescato Valor Moneda a Fecha de Proceso
Declare @tmpParidad table(	CodMoneda	int, MonedaNemo Char(3), Valor  float)


--Inserto TC CLP
insert into @tmpParidad
	select 999, '', 1.0 

--Inserto TC Dólar USA (para papeles emitidos con Dólar USA se usa Dólar Acuerdo para informar MtM)
insert into @tmpParidad
	select 13,'',Tipo_Cambio	from BacParamSuda..VALOR_MONEDA_CONTABLE where fecha=@dFechaProceso  and Codigo_Moneda=994

--Inserto TC <> CLP 
insert into @tmpParidad  
	SELECT vmcodigo,'',vmvalor  from  BacParamSuda..VALOR_MONEDA  where vmfecha=@dFechaProceso  and vmcodigo!=994



--Flujos NS
insert into @TD
SELECT				 rsfecctb  
                    ,'CL'  
                    ,'CORPBANCA'  
                    ,(CASE WHEN rscartera = '111' THEN 'CP'  
                                     WHEN rscartera = '114' THEN 'Intermediacion'    
                                     WHEN rscartera = '121' THEN 'Interbancarios'  
                                     WHEN rscartera = '130' THEN 'Interbancarios-CENTRAL'  
                                                            ELSE 'COMDER'  
                     END  ) as tipoproducto
                    ,'RFMN'  
                    ,cast(rsnumdocu as varchar(10)) + '-' + cast(rsnumoper as varchar(10)) + '-' + cast(rscorrela as varchar(10))  
                    ,'ACT'  
                    ,1  
                    ,CAST( rsrutcli AS VARCHAR(10) ) + C.cldv  
                    ,C.clnombre  
                    ,rstipcart  
                    ,ISNULL( FP.tbglosa, CAST(rstipcart AS varchar(10)))  
                    ,RS.codigo_Carterasuper  
                    ,RP.tbglosa  
                    ,rsid_libro  
                    ,BO.tbglosa  
                    ,inserie  
                    ,rsmascara  
                    ,rsinstser  
                    ,rsmonemi  
                    ,MC.mnnemo 
                    ,ISNULL(rsrutemis,0)  
					,ISNULL(emgeneric,'')  
                    ,CASE WHEN rscartera = '130' THEN rsfecvtop ELSE rsfecvcto END  
                    ,DATEDIFF( DAY, rsfecctb, CASE WHEN rscartera =  '130' THEN rsfecvtop ELSE rsfecvcto END )  
                    ,RS.rsvalcomu  
					,RS.rstir  
                    ,0  
                    ,RS.rsvalcomu  
                    ,0  
                     ,ISNULL((RS.rsnominal - RS.rsvalcomu) , 0 )   
                    ,RS.rsnominal  
                    , ISNULL(ROUND( RS.rsvalcomu * TC.valor, 0 )  , 0 )  
                    ,0  
                    , ISNULL(ROUND( (RS.rsnominal - RS.rsvalcomu) * TC.valor, 0 ) , 0 )   
                    , ISNULL(ROUND(( RS.rsnominal * TC.valor), 0 )  , 0 )  
					,rsnumdocu
					,rscorrela
					,rsnumoper
                 FROM BacTraderSuda.dbo.mdrs                 RS with(nolock)	
                      LEFT  JOIN BacParamSuda.dbo.Cliente    C  with(nolock)	ON  C.clrut         = rsrutcli AND  C.clcodigo      = rscodcli  
                      LEFT  JOIN BacParamSuda.dbo.Emisor     E  with(nolock)	ON  E.emrut         = rsrutemis  
                      LEFT  JOIN BacParamSuda.dbo.Moneda     MC with(nolock)	ON  MC.mncodmon     = rsmonemi  
                      LEFT  JOIN BacParamSuda.dbo.INSTRUMENTO INS  with(nolock)	ON  INS.incodigo    = rscodigo  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE  FP  with(nolock) ON  FP.tbcateg      = 204  AND  FP.tbcodigo1    = CAST( rstipcart AS VARCHAR(10) )  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE  RP  with(nolock) ON  RP.tbcateg      = 1111 AND  RP.tbcodigo1    = RS.codigo_Carterasuper  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE  BO  with(nolock) ON  BO.tbcateg      = 1552 AND  BO.tbcodigo1    = CAST( rsid_libro AS VARCHAR(10) )  
                      LEFT JOIN @tmpParidad                              TC				  ON  tc.CodMoneda    = mc.mncodmon
                WHERE rsfecctb     = @dfechaproceso  AND rstipoper    = 'DEV'  AND rscartera    IN ( '111', '114', '121', '130', '159' )  
                  AND rsnominal   != 0				 AND INS.inmdse   = 'N'    AND CASE WHEN rscartera in ( '121', '130' ) THEN rsfecvtop ELSE rsfecvcto END >= @dfechaproceso  
                ORDER BY 1  


		
----Flujos S (Sin LCHR).
insert into @TD
SELECT				  rsfecctb  
                    , 'CL'  
                    , 'CORPBANCA'  
                    , CASE WHEN rscartera = '111' THEN 'CP'  
                           WHEN rscartera = '159' THEN 'COMDER'  
                                                  ELSE 'Intermediacion'  
                      END  
                    , 'RFMN'  
                    , cast(rsnumdocu as varchar(10)) + '-' + cast(rsnumoper as varchar(10)) + '-' + cast(rscorrela as varchar(10))  
                    , 'ACT'  
                    , tdcupon  
                    , CAST( rsrutcli AS VARCHAR(10) ) + C.cldv  
                    , C.clnombre  
                    , rstipcart  
                    , ISNULL( FP.tbglosa, CAST(rstipcart AS varchar(10)))  
                    , RS.codigo_Carterasuper  
                    , RP.tbglosa  
                    , rsid_libro  
                    , BO.tbglosa  
                    , inserie  
                    , rsmascara  
                    , rsinstser  
                    , rsmonemi  
                    , MC.mnnemo 
                    , rsrutemis  
                    , emgeneric  
                    , tdfecven  
                    , DATEDIFF( DAY, rsfecctb, tdfecven )  
                    , ISNULL((td.tdsaldo + td.tdamort)  * 0.01 * rsnominal , 0 )   
                    , RS.rstir  
                    , 0  
                    , ISNULL(td.tdamort   * 0.01 * rsnominal , 0 )   
                    , 0  
                    , ISNULL(td.tdinteres * 0.01 * rsnominal , 0 )   
                    , ISNULL(td.tdflujo   * 0.01 * rsnominal, 0 )    
                    , ISNULL(ROUND( (td.tdamort   * 0.01 * rsnominal) * TC.valor, 0 ), 0 )    
                    , 0  
                    , ISNULL(ROUND( (td.tdinteres * 0.01 * rsnominal) * TC.valor, 0 ), 0 )    
         , ISNULL(ROUND( (td.tdflujo   * 0.01 * rsnominal) * TC.valor, 0 ), 0 )    
					, rsnumdocu
					, rscorrela
					, rsnumoper								
                 FROM BacTraderSuda.dbo.mdrs							RS  with(nolock)	
                      LEFT  JOIN BacParamSuda.dbo.Cliente				C   with(nolock)	ON  C.clrut         = rsrutcli  AND  C.clcodigo = rscodcli  
                      LEFT  JOIN BacParamSuda.dbo.Emisor				E   with(nolock)	ON  E.emrut         = rsrutemis  
					  LEFT  JOIN BacParamSuda.dbo.Moneda				MC	with(nolock)	ON  MC.mncodmon     = rsmonemi  
                      LEFT  JOIN BacParamSuda.dbo.INSTRUMENTO			INS with(nolock)	ON  INS.incodigo    = rscodigo  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE FP  with(nolock)	ON  FP.tbcateg      = 204  AND  FP.tbcodigo1    = CAST( rstipcart AS VARCHAR(10) )  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE RP  with(nolock)	ON  RP.tbcateg      = 1111 AND  RP.tbcodigo1    = RS.codigo_Carterasuper  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE BO  with(nolock)	ON  BO.tbcateg      = 1552  AND  BO.tbcodigo1   = CAST( rsid_libro AS VARCHAR(10) )  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_DESARROLLO		TD  with(nolock)	ON  TD.tdmascara    = rsmascara    
                      LEFT JOIN  @tmpParidad                            TC					ON  tc.CodMoneda    = mc.mncodmon
                WHERE rsfecctb      = @dFechaProceso  
                  AND rstipoper    = 'DEV'  
                  AND rscartera    IN ( '111', '114', '159' )  
				  AND rsvppresen  <> 0  
                  AND INS.inmdse   = 'S'  
                  AND RSCODIGO    <> 20  
                  AND tdfecven    >= rsfecctb  
                ORDER BY rsinstser  


---- Flujos S (LCHR)
insert into @TD
SELECT			rsfecctb  
            ,  'CL'  
            ,  'CORPBANCA'  
            ,  CASE WHEN rscartera = '111' THEN 'CP'  
                    WHEN rscartera = '159' THEN 'COMDER'  
                                            ELSE 'Intermediacion'  
                END  
            ,  'RFMN'  
            ,  cast(rsnumdocu as varchar(10)) + '-' + cast(rsnumoper as varchar(10)) + '-' + cast(rscorrela as varchar(10))  
            ,  'ACT'  
            ,  tdcupon  
            ,  CAST( rsrutcli AS VARCHAR(10) ) + C.cldv  
            ,  C.clnombre  
            ,  rstipcart  
            ,  ISNULL( FP.tbglosa, CAST(rstipcart AS varchar(10)))  
            ,  RS.codigo_Carterasuper  
            ,  RP.tbglosa  
            ,  rsid_libro  
            ,  BO.tbglosa  
            ,  inserie  
            ,  rsmascara  
            ,  rsinstser  
            ,  rsmonemi  
            ,  MC.mnnemo
            ,  rsrutemis  
            ,  emgeneric  
            ,  DATEADD( MONTH, tdcupon * 3, rsfecemis )  
            ,  DATEDIFF( DAY, rsfecctb, DATEADD( MONTH, tdcupon * 3, rsfecemis ) )  
            , ISNULL( (td.tdsaldo + td.tdamort)  * 0.01 * rsnominal , 0 )   
            ,  RS.rstir  
            ,  0  
            , ISNULL( td.tdamort   * 0.01 * rsnominal  , 0 )  
            ,  0  
            , ISNULL( td.tdinteres * 0.01 * rsnominal  , 0 )  
            , ISNULL( td.tdflujo   * 0.01 * rsnominal  , 0 )  
            , ISNULL( ROUND( (td.tdamort   * 0.01 * rsnominal) * TC.valor, 0 ) , 0 )   
            ,  0  
            , ISNULL( ROUND( (td.tdinteres * 0.01 * rsnominal) * TC.valor, 0 )  , 0 )  
            , ISNULL( ROUND( (td.tdflujo   * 0.01 * rsnominal) * TC.valor, 0 ) , 0 )   
			, rsnumdocu
			, rscorrela
			, rsnumoper	
        FROM BacTraderSuda.dbo.mdrs						RS		with(nolock)	
                LEFT  JOIN BacParamSuda.dbo.Cliente		C		with(nolock)  ON  C.clrut         = rsrutcli  AND  C.clcodigo      = rscodcli  
                LEFT  JOIN BacParamSuda.dbo.Emisor		E		with(nolock)  ON  E.emrut  = rsrutemis  
                LEFT  JOIN BacParamSuda.dbo.Moneda		MC		with(nolock)  ON  MC.mncodmon     = rsmonemi  
                LEFT  JOIN BacParamSuda.dbo.INSTRUMENTO	INS		with(nolock)  ON  INS.incodigo    = rscodigo  
                LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE FP   with(nolock) ON  FP.tbcateg      = 204   AND  FP.tbcodigo1    = CAST( rstipcart AS VARCHAR(10) )  
                LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE RP   with(nolock) ON  RP.tbcateg      = 1111  AND  RP.tbcodigo1    = RS.codigo_Carterasuper  
                LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE BO   with(nolock) ON  BO.tbcateg      = 1552  AND  BO.tbcodigo1    = CAST( rsid_libro AS VARCHAR(10) )  
                LEFT  JOIN BacParamSuda.dbo.TABLA_DESARROLLO TD   with(nolock)	  ON  TD.tdmascara    = rsmascara  
                LEFT JOIN @tmpParidad                              TC    ON  tc.CodMoneda       = mc.mncodmon
        WHERE rsfecctb      = @dFechaProceso  
            AND rstipoper     = 'DEV'                  AND rscartera    IN ( '111', '114', '159' )  
            AND rsnominal    != 0                      AND INS.inmdse    = 'S'  
            AND RSCODIGO      = 20                     AND DATEADD( MONTH, tdcupon * 3, rsfecemis )    >= rsfecctb  
        ORDER BY rsinstser  



---- Bonos Pasivos  
insert into @TD
			SELECT     fecha_calculo  
                    , 'CL'  
                    , 'CORPBANCA'  
                    , CASE WHEN LEFT( rs.nombre_serie, 4 ) in ( 'BCOR', 'BITA' ) THEN 'Bono propia Emision' ELSE 'Bono Subordinado' END  
                    , 'BonosPasivos'  
                    , cast(rs.numero_operacion as varchar(10)) + '-' + cast(rs.numero_correlativo as varchar(10))  
                    , 'PAS'  
					, td.numero_cupon				
					, CAST(cli.Clrut AS VARCHAR(10) ) + Cli.cldv  			
					, clnombre					
                    , 0  
                    , ''  
                    , 0  
                    , ''  
                    , 0  
                    , ''  
                    , rs.codigo_instrumento  
                    , rs.nombre_serie  
                    , rs.nombre_serie  
                    , rs.moneda_emision  
                    , mnnemo   
                    , 97023000  
                    , 'CORPBANCA'  
                    , td.fecha_vencimiento  
                    , DATEDIFF( DAY, fecha_calculo, td.fecha_vencimiento )  
                    , ISNULL( rs.nominal * td.saldo * 0.01  , 0 )  
                    , rs.tasa_colocacion  
                    , 0  
                    , ISNULL( rs.nominal * td.amortizacion * 0.01  , 0 )  
                    , 0  
                    , ISNULL( rs.nominal * td.interes * 0.01  , 0 )  
                    , ISNULL( rs.nominal * td.flujo * 0.01 , 0 )   
  
                    , ISNULL( ROUND( (rs.nominal * td.amortizacion * 0.01) * TC.valor, 0 ) , 0 )   
                    , 0  
                    , ISNULL(  ROUND( (rs.nominal * td.interes * 0.01) * TC.valor, 0 )  , 0 )  
                    , ISNULL( ROUND( (rs.nominal * td.flujo * 0.01) * TC.valor, 0 )  , 0 )  
  					, 0
					, rs.numero_correlativo
					, rs.numero_operacion
                  FROM mdpasivo.dbo.resultado_pasivo          rs   with(nolock)	 
					  inner join mdpasivo.dbo.cartera_pasivo cp with (nolock) on  cp.numero_operacion=rs.numero_operacion and cp.numero_correlativo=rs.numero_correlativo
					  inner join bacparamsuda.dbo.cliente	cli	with (nolock) on cp.rut_cliente=cli.clrut and cp.codigo_cliente=cli.clcodigo
                      LEFT  JOIN mdpasivo.dbo.Serie_Pasivo   se    with(nolock)    ON se.nombre_serie = rs.nombre_serie  
                      LEFT  JOIN bacparamsuda.dbo.moneda     mc    with(nolock)   ON mc.mncodmon     = rs.moneda_emision  
                      LEFT  JOIN mdpasivo.dbo.INSTRUMENTO_PASIVO INS with(nolock) ON  INS.codigo_instrumento  = rs.codigo_instrumento  
                      LEFT  JOIN mdpasivo.dbo.FLUJO_BONOS    td   with(nolock)	  ON  td.nombre_serie  = rs.nombre_serie  
                      LEFT JOIN @tmpParidad                 TC    ON  tc.CodMoneda = mc.mncodmon
               WHERE fecha_calculo        = @dFechaProceso   and td.fecha_vencimiento >= @dFechaProceso  
                 AND rs.tipo_operacion    != 'VC'  
              ORDER BY 1
			  
		 

----Bonos en el Exterior (Seriado)    
  insert into @TD                                                                                                              
           SELECT	 cart.rsfecpro  
                    ,'CL'  
                    ,'CORPBANCA'  
                    ,'CP'  
                    ,'INVEXT'  
                    ,cast(cart.rsnumdocu as varchar) + '-' + cast(cart.rsnumoper as varchar) + '-' + cast(cart.rscorrelativo as varchar)  
                    ,'ACT'  
                    ,desa.num_cupon  
                    ,CAST( cart.rsrutcli AS VARCHAR(10) ) + Clie.cldv  
                    ,Clie.clnombre  
                    ,cart.Tipo_Cartera_Financiera  
                    ,ISNULL( FP.tbglosa, CAST( cart.Tipo_Cartera_Financiera AS VARCHAR(10) ))  
                    ,cart.codigo_carterasuper  
                    ,RP.tbglosa  
                    ,cart.RsId_Libro  
                    ,BO.tbglosa  
                    ,cart.cod_familia  
                    ,cart.cod_nemo  
                    ,cart.id_instrum  
                    ,cart.rsmonemi  
                    , MC.mnnemo 
                    ,cart.rsrutemis  
                    ,E.emgeneric  
                    ,desa.fecha_vcto_cupon  
                    ,DATEDIFF( DAY, cart.rsfecpro, desa.fecha_vcto_cupon )  
                    , ISNULL((desa.saldo + desa.amortizacion)  * 0.01 * cart.rsnominal  , 0 ) 
                    ,cart.rstir  
                    ,0  
                    , ISNULL(desa.amortizacion   * 0.01 * cart.rsnominal  , 0 ) 
                    ,0  
                    , ISNULL(desa.interes * 0.01 * cart.rsnominal  , 0 ) 
                    , ISNULL(desa.flujo   * 0.01 * cart.rsnominal  , 0 ) 
                    , ISNULL(ROUND( (desa.amortizacion   * 0.01 * cart.rsnominal) * TC.valor, 0 )  , 0 ) 
                    ,0  
                    , ISNULL(ROUND( (desa.interes * 0.01 * cart.rsnominal) * TC.valor, 0 )  , 0 ) 
                    , ISNULL(ROUND( (desa.flujo   * 0.01 * cart.rsnominal) * TC.valor, 0 )  , 0 ) 
					, cart.rsnumdocu
					, cart.rscorrelativo
					, cart.rsnumoper
                 FROM BacBonosExtSuda.dbo.text_rsu           cart     with(nolock)	
                      INNER JOIN BacBonosExtSuda.dbo.text_dsa desa    with(nolock)	ON desa.cod_nemo    = cart.cod_nemo  
                      LEFT  JOIN BacParamSuda.dbo.Cliente    Clie    with(nolock)	ON clie.clrut       = cart.rsrutcli  AND clie.clcodigo    = cart.rscodcli  
                      LEFT  JOIN BacParamSuda.dbo.Moneda     MC    with(nolock)		ON  MC.mncodmon     = cart.rsmonemi  
                      LEFT  JOIN BacParamSuda.dbo.Moneda     MP    with(nolock)		ON  MP.mncodmon     = cart.rsmonpag  
                      LEFT  JOIN BacParamSuda.dbo.Emisor     E    with(nolock)		ON  E.emrut         = cart.rsrutemis  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE FP    with(nolock)	ON  FP.tbcateg      = 204  AND  FP.tbcodigo1    = CAST( cart.Tipo_Cartera_Financiera AS VARCHAR(10) )  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE RP    with(nolock)	ON  RP.tbcateg      = 1111  AND  RP.tbcodigo1    = cart.codigo_carterasuper  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE BO    with(nolock)	ON  BO.tbcateg      = 1552  AND  BO.tbcodigo1    = CAST( cart.RsId_Libro AS VARCHAR(10) )  
                      LEFT JOIN @tmpParidad                              TC    ON  tc.CodMoneda       = mc.mncodmon
                WHERE cart.rsfecpro    = @dFechaProceso  
                  AND cart.rstipoper   = 'DEV'  
                  and desa.fecha_vcto_cupon >= @dFechaProceso  and rsnominal!=0



----Bonos en el Exterior (No seriado)
insert into @TD  
SELECT				   cart.rsfecpro  
                    ,  'CL'  
                    ,  'CORPBANCA'  
                    ,  'CP'  
                    ,  'INVEXT'  
                    ,  cast(cart.rsnumdocu as varchar) + '-' + cast(cart.rsnumoper as varchar) + '-' + cast(cart.rscorrelativo as varchar)  
                    ,  'ACT'  
                    ,  1  
                    ,  CAST( cart.rsrutcli AS VARCHAR(10) ) + Clie.cldv  
                    ,  Clie.clnombre  
                    ,  cart.Tipo_Cartera_Financiera  
                    ,  ISNULL( FP.tbglosa, CAST( cart.Tipo_Cartera_Financiera AS VARCHAR(10) ))  
                    ,  cart.codigo_carterasuper  
                    ,  RP.tbglosa  
                    ,  cart.RsId_Libro  
                    ,  BO.tbglosa  
					,  cart.cod_familia  
                    ,  cart.cod_nemo  
                    ,  cart.id_instrum  
                    ,  cart.rsmonemi  
                    ,  MC.mnnemo  
                    ,  cart.rsrutemis  
                    ,  E.emgeneric  
                    ,  cart.rsfecvcto  
                    ,  DATEDIFF( DAY, cart.rsfecpro, cart.rsfecvcto )  
                    ,  cart.rsnominal  
                    ,  cart.rstir  
                    ,  0  
                    ,  cart.rsprincipal  
                    ,  0  
                    ,  ISNULL( cart.rsnominal - cart.rsprincipal , 0 )  
                    ,  cart.rsnominal  
                    ,   ISNULL(ROUND( cart.rsprincipal * TC.valor, 0 ) , 0 )  
                    ,  0  
                    ,   ISNULL(ROUND( (cart.rsnominal - cart.rsprincipal) * TC.valor, 0 )  , 0 ) 
                    ,   ISNULL(ROUND( cart.rsnominal * TC.valor, 0 )  , 0 ) 
					,  cart.rsnumdocu
					,  cart.rscorrelativo
					,  cart.rsnumoper
                 FROM BacBonosExtSuda.dbo.text_rsu           cart    with(nolock)	
                      LEFT  JOIN BacParamSuda.dbo.Cliente    Clie    with(nolock)	ON  clie.clrut      = cart.rsrutcli  AND clie.clcodigo    = cart.rscodcli  
                      LEFT  JOIN BacParamSuda.dbo.Moneda     MC      with(nolock)	ON  MC.mncodmon     = cart.rsmonemi  
				      LEFT  JOIN BacParamSuda.dbo.Moneda     MP      with(nolock)	ON  MP.mncodmon     = cart.rsmonpag  
                      LEFT  JOIN BacParamSuda.dbo.Emisor     E       with(nolock)	ON  E.emrut         = cart.rsrutemis  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE FP    with(nolock)	ON  FP.tbcateg      = 204    AND  FP.tbcodigo1    = CAST( cart.Tipo_Cartera_Financiera AS VARCHAR(10) )  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE RP    with(nolock)	ON  RP.tbcateg      = 1111   AND  RP.tbcodigo1    = cart.codigo_carterasuper  
                      LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE BO    with(nolock)	ON  BO.tbcateg      = 1552    AND  BO.tbcodigo1    = CAST( cart.RsId_Libro AS VARCHAR(10) )  
                      LEFT JOIN @tmpParidad                             TC    ON  tc.CodMoneda       = mc.mncodmon
                WHERE cart.rsfecpro    = @dFechaProceso  
                  AND cart.rstipoper   = 'DEV'  AND cart.cod_familia in ( '2001', '2002' )  


----Pactos
insert into @TD  
			SELECT     rsfecctb  
                    ,  'CL'  
                    ,  'CORPBANCA'  
                    ,  case when rscartera = '112' THEN 'Compra con Pacto' ELSE 'Venta con Pacto' END  
                    ,  'RFMN'  
                    ,  cast(rsnumoper as varchar(10))  
                    ,  case when rscartera = '112' then 'ACT' else 'PAS' end  
                    ,  1  
                    ,  CAST( rsrutcli AS VARCHAR(10) ) + C.cldv  
                    ,  C.clnombre  
                    ,  rstipcart  
                    ,  ISNULL( FP.tbglosa, CAST(rstipcart AS varchar(10)))  
              ,  RS.codigo_Carterasuper  
                    ,  RP.tbglosa  
                    ,  rsid_libro  
                    ,  BO.tbglosa  
                    ,  'Pacto'  
                    ,  'Pacto'  
                    ,  'Pacto'  
                    ,  rsmonpact  
                    ,   MC.mnnemo  
                    ,  0  
                    ,  ''  
                    ,  rsfecvtop  
                    ,  DATEDIFF( DAY, rsfecctb, rsfecvtop )  
                    ,  SUM(RS.rsvalvtop)  
                    ,  RS.rstaspact  
                    ,  0  
                    ,  ISNULL(SUM(RS.rsvalinip)  ,0)
                    ,  0  
                    ,  ISNULL(SUM(RS.rsvalvtop - RS.rsvalinip),0)  
                    ,  ISNULL(SUM(RS.rsvalvtop)  ,0)
                    ,  ISNULL(SUM(ROUND( RS.rsvalinip *  TC.valor, 0 ))  ,0)
                    ,  0  
                    ,  ISNULL(SUM(ROUND( (RS.rsvalvtop - RS.rsvalinip) *  TC.valor, 0 ))  ,0)
                    ,  ISNULL(SUM(ROUND( RS.rsvalvtop *  TC.valor, 0 ))  ,0)
					,  rsnumdocu
					,  rscorrela
					,  rsnumoper
                 FROM BacTraderSuda.dbo.mdrs  RS  with(nolock) 
				     LEFT  JOIN BacParamSuda.dbo.Cliente C  with(nolock)	 ON  C.clrut         = rsrutcli  AND  C.clcodigo      = rscodcli  
                     LEFT  JOIN BacParamSuda.dbo.Emisor E  with(nolock)      ON  E.emrut         = rsrutemis  
					 LEFT  JOIN BacParamSuda.dbo.Moneda     MC  with(nolock) ON  MC.mncodmon     = rsmonpact  
                     LEFT  JOIN BacParamSuda.dbo.INSTRUMENTO INS  with(nolock) ON  INS.incodigo    = rscodigo  
                     LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE FP  with(nolock) ON  FP.tbcateg      = 204  AND  FP.tbcodigo1    = CAST( rstipcart AS VARCHAR(10) )  
                     LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE RP  with(nolock) ON  RP.tbcateg      = 1111 AND  RP.tbcodigo1    = RS.codigo_Carterasuper  
                     LEFT  JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE BO  with(nolock) ON  BO.tbcateg      = 1552  AND  BO.tbcodigo1    = CAST( rsid_libro AS VARCHAR(10) )  
                     LEFT JOIN @tmpParidad                             TC    ON  tc.CodMoneda       = mc.mncodmon
                WHERE rsfecctb     = @dFechaProceso  
                  AND rstipoper    = 'DEV'  
                  AND rscartera    in ( '112', '115' )  
                  and rsfecvtop    >= @dfechaproceso  
                GROUP BY  
                      rsfecctb  
                    , rscartera  
                    , rsnumoper  
                    , CAST( rsrutcli AS VARCHAR(10) ) + C.cldv  
                    , C.clnombre  
                    , rsfecvtop  
                    , rstipcart  
                    , ISNULL( FP.tbglosa, CAST(rstipcart AS varchar(10)))  
                    , RS.codigo_Carterasuper  
                    , RP.tbglosa  
                    , rsid_libro  
                    , BO.tbglosa  
                    , rsmonpact  
                    ,  MC.mnnemo 
                    , rstaspact  
					,  rsnumdocu
					,  rscorrela
					,  rsnumoper
                ORDER BY 1  


	--UPDATE @TD
	--SET nombrecliente		= UPPER(dbo.fnLimpiarCaracteres(nombrecliente))
	--,   carterafinanciera	= UPPER(dbo.fnLimpiarCaracteres(carterafinanciera))
	--LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), nominal ) ) , '.', ','))	
		if @TipoSalida = 1
			Begin
			/*	--CAMBIO "." POR ","
				INSERT INTO @R07_TD_SALIDA
				SELECT  
					LTRIM(CONVERT(CHAR(10),fechaproceso,105))	+ @SEP + LTRIM(localidad)					+ @SEP	+	LTRIM(vehiculo)			+ @SEP	+
					LTRIM(tipoproducto)							+ @SEP + LTRIM(producto)					+ @SEP	+	LTRIM(num_doc)			+ @SEP	+
					LTRIM(numerooperacion)						+ @SEP + LTRIM(correlativo)					+ @SEP  +   LTRIM(tipoflujo)		+ @SEP  + 
					LTRIM(numeroflujo)							+ @SEP + LTRIM(moneda)						+ @SEP	+	LTRIM(CONVERT(CHAR(10),fechavencimiento,105)) + @SEP	+
					LTRIM(tenor)								+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), saldoresidual ) ) )				+ @SEP	+	LTRIM(RTRIM(CONVERT( NUMERIC(19,4), tasa)))				+ @SEP	+
					LTRIM(RTRIM(CONVERT(NUMERIC(19,4), spread)))+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), amortizacion ) ) )					+ @SEP	+	LTRIM(RTRIM(CONVERT( NUMERIC(19,4), interes)))			+ @SEP +
					LTRIM(RTRIM(CONVERT(NUMERIC(19,4), flujo)))	+ @SEP + LTRIM(cliente)						+ @SEP  +   LTRIM(nombrecliente)	+ @SEP +
					LTRIM(codigocarterafinanciera)				+ @SEP + LTRIM(carterafinanciera)			+ @SEP	+  
					LTRIM(codigocarteranormativa)				+ @SEP + LTRIM(carteranormativa)			+ @SEP	+	LTRIM(codigolibro)		+ @SEP	+
					LTRIM(libro)								+ @SEP + LTRIM(familia)						+ @SEP	+	LTRIM(mascara)			+ @SEP	+
					LTRIM(instrumento)							+ @SEP + LTRIM(codigomoneda)				+ @SEP	+	
					LTRIM(codigoemisor)							+ @SEP + LTRIM(emisor)						+ @SEP	+	
					LTRIM(RTRIM(CONVERT( NUMERIC(19,4), flujoadicional )) )						+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), amortizacionclp ) ))				+ @SEP	+
					LTRIM(RTRIM(CONVERT( NUMERIC(19,4), flujoadicionalclp )))					+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), interesclp ) ) )					+ @SEP	+	
					LTRIM(RTRIM(flujoclp ))  AS   REG_SALIDA			
				from
					 @TD 
				ORDER BY numerooperacion, numeroflujo

				select  * from @R07_TD_SALIDA
				*/
				--20210910. Nuevamente se pide cambio de "." POR ","
				INSERT INTO @R07_TD_SALIDA
				SELECT  
					LTRIM(CONVERT(CHAR(10),fechaproceso,105))	+ @SEP + LTRIM(localidad)					+ @SEP	+	LTRIM(vehiculo)			+ @SEP	+
					LTRIM(tipoproducto)							+ @SEP + LTRIM(producto)					+ @SEP	+	LTRIM(num_doc)			+ @SEP	+
					LTRIM(numerooperacion)						+ @SEP + LTRIM(correlativo)					+ @SEP  +   LTRIM(tipoflujo)		+ @SEP  + 
					LTRIM(numeroflujo)							+ @SEP + LTRIM(moneda)						+ @SEP	+	LTRIM(CONVERT(CHAR(10),fechavencimiento,105)) + @SEP +
					LTRIM(tenor)								+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), saldoresidual ) ) , '.', ','))					+ @SEP	+	
					LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), tasa)), '.', ','))		+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), spread ) ) , '.', ','))	+ @SEP  + 
					LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), amortizacion ) ) , '.', ',')) 				+ @SEP	+ LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), interes ) ) , '.', ','))	+ @SEP +
					LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), flujo ) ) , '.', ','))	+ @SEP + LTRIM(cliente)						+ @SEP  +   LTRIM(nombrecliente)	+ @SEP +
					LTRIM(codigocarterafinanciera)				+ @SEP + LTRIM(carterafinanciera)			+ @SEP	+  
					LTRIM(codigocarteranormativa)				+ @SEP + LTRIM(carteranormativa)			+ @SEP	+	LTRIM(codigolibro)		+ @SEP	+
					LTRIM(libro)								+ @SEP + LTRIM(familia)						+ @SEP	+	LTRIM(mascara)			+ @SEP	+
					LTRIM(instrumento)							+ @SEP + LTRIM(codigomoneda)				+ @SEP	+	
					LTRIM(codigoemisor)							+ @SEP + LTRIM(emisor)						+ @SEP	+	
					LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), flujoadicional ) ) , '.', ','))				+ @SEP	+ LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), amortizacionclp ) ) , '.', ',')) 		+ @SEP	+
					LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), flujoadicionalclp ) ) , '.', ','))			+ @SEP	+ LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), interesclp ) ) , '.', ',')) 			+ @SEP	+	
					LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), flujoclp ) ) , '.', ','))  AS   REG_SALIDA			
				from
					 @TD 
				ORDER BY numerooperacion, numeroflujo

				select  * from @R07_TD_SALIDA
			End
			Else
			Begin
				SELECT 
					fechaproceso,localidad,vehiculo,tipoproducto,producto,num_doc,numerooperacion,correlativo,tipoflujo,numeroflujo,moneda,
					fechavencimiento,tenor,saldoresidual,tasa,spread,amortizacion,interes,flujo,cliente,nombrecliente,codigocarterafinanciera,
					carterafinanciera,codigocarteranormativa,carteranormativa,codigolibro,libro,familia,mascara,instrumento,
					codigomoneda,codigoemisor,emisor,flujoadicional,amortizacionclp,flujoadicionalclp,interesclp,flujoclp
				from
					 @TD --where mascara='BTP0600122'
				ORDER BY numerooperacion, numeroflujo
			End 


END

--GO
--EXEC SP_R07_TD '20210929'




GO
