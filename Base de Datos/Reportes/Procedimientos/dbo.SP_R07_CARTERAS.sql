USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_R07_CARTERAS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_R07_CARTERAS] (@dFechaProceso  DateTime=NULL)  
AS  
BEGIN  
SET NOCOUNT ON    
      
Declare @SEP VarChar(1); Set @SEP = ';'  
  
Declare @TipoSalida bit = 1
--declare @dFechaProceso datetime--='20210722'  
declare @dFechaValorizacion datetime=@dFechaProceso 
  
if @dFechaProceso is null  
begin   
 set @dFechaProceso = (select acfecproc from bactradersuda..mdac)  
end  
  
--Rescato última fecha de carga de valorización de mercado existente.  
IF NOT EXISTS( SELECT 1 FROM BacTraderSuda.dbo.VALORIZACION_MERCADO WHERE fecha_valorizacion = @dFechaProceso )    
    BEGIN    
        set @dFechaValorizacion = (select  MIN(fecha_valorizacion) FROM BacTraderSuda..VALORIZACION_MERCADO WHERE fecha_valorizacion > @dFechaProceso  )  
    END    
--Si @dFechaValorizacion viene con un NULL, reemplazo por la fecha anterior de proceso.
 --IF @dFechaValorizacion IS NULL
	--BEGIN
	--	set @dFechaValorizacion = (select acfecante from bactradersuda..mdac)  
	--END 

--Rescato Valor Moneda a Fecha de Proceso  
Declare @tmpParidad table( CodMoneda int, MonedaNemo Char(3), Valor  float)  
--Inserto TC CLP
insert into @tmpParidad
	select 999, '', 1.0 

--Inserto TC Dólar USA (para papeles emitidos con Dólar USA se usa Dólar Acuerdo para informar MtM)
insert into @tmpParidad
	select 13,'',Tipo_Cambio	from BacParamSuda..VALOR_MONEDA_CONTABLE where fecha=@dFechaProceso  and Codigo_Moneda=994

--Inserto TC <> CLP 
insert into @tmpParidad  
	SELECT vmcodigo,'',vmvalor  from  BacParamSuda..VALOR_MONEDA  where vmfecha=@dFechaProceso  and vmcodigo!=994

--estrucutura cartera renta fija   
DECLARE @Cartera  TABLE (  fechaproceso				DATETIME  
						 , localidad				VARCHAR(10)  --3)  
						 , vehiculo					VARCHAR(20)  --16)  
						 , tipoproducto				VARCHAR(30)  --15)  
						 , numerooperacion			VARCHAR(50)  --NUMERIC(10)  
						 , tipoflujo				VARCHAR(3)  
						 , producto					VARCHAR(30)  --25)  
						 , cliente					VARCHAR(15)  --NUMERIC(9)  
						 , nombrecliente			VARCHAR(70)  
						 , fechacompra				DATETIME  
						 , fechaemision				DATETIME  
						 , fechavencimiento			DATETIME  
						 , tenor					int			--NUMERIC(9)  
						 , codigocarterafinanciera  int			--NUMERIC(9)  
						 , carterafinanciera		nvarchar(50)--VARCHAR(50)  
						 , codigocarteranormativa	VARCHAR(20)  --1)   
						 , carteranormativa			VARCHAR(50)  
						 , codigolibro				int			--NUMERIC(9)  
						 , libro					VARCHAR(50)   
						 , familia					VARCHAR(20)  --25)  
						 , mascara					VARCHAR(25)  --25)  
						 , instrumento				VARCHAR(25)  --25)  
						 , codigomonedaemision		int			--NUMERIC(9)  
						 , monedaemision			VARCHAR(5)  --3)   
						 , codigoemisor				VARCHAR(15)  --NUMERIC(9)  
						 , emisor					VARCHAR(20)		--50)   
						 , nominal					numeric(19,4) --24,8)   
						 , tir						numeric(19,4) --(24,8)   
						 , valorcompramo			numeric(19,4) --(24,8)   
						 , valorcompra				numeric(19,4) --(24,8)   
						 , monedavalorpresente		VARCHAR(10)  
						 , valorpresentemo			numeric(19,4) --(24,8)    
						 , valorpresente			numeric(19,4) --(24,8)   
						 , tirmtm					numeric(19,4) --(24,8)   
						 , mtm						numeric(19,4) --(24,8)   
						 , delta					numeric(19,4) --(24,8)   
						 , interesdiario			numeric(19,4) --(24,8)   
						 , reajustediario			numeric(19,4) --(24,8)   
						 , interesacumulado			numeric(19,4) --(24,8)     -- Interés Acumulado Mensual  
						 , reajusteacumulado		numeric(19,4) --(24,8)  -- Reajuste Acumulado Mensual  
						 , proximovalorpresente		numeric(19,4) --(24,8)   
						 , proximovalorpresentemo	numeric(19,4) --(24,8)   
						 , documento				NUMERIC(9)  
						 , operacion				NUMERIC(13)  --9)  
						 , correlativo				NUMERIC(13)  --9)  
						 , fechacupon				datetime     -- fecha de cupón  
						 , fechapago				datetime     -- fecha de pago del instrumento  
						 , mtmclpayer				numeric(19,4) --(24,8)  -- valor de mercado de la operación ayer  
						 , devengodiario			numeric(19,4) --(24,8)  -- "Devengo de interés y reajustes considerando operaciones vigentes y ventas PM (Interesdiario + reajustediario) (devengo de ventas PM = Valor_papeleta - Utilidad_Perdida)"  
						 , diferenciamercadoclp		numeric(19,4) --(24,8)  -- Diferencia en CLP entre valormercado y  valorpresente  
						 , valorpapeleta			numeric(19,4) --(24,8)  -- Valor de papeleta de la venta.  
						 , tipooperacion			varchar(3)     -- referencia MoTipOper de la tabla  BACTRADERSUDA.DBO.MDMH  
						 , codigoinstrumento		numeric			-- referencia MoCodigo de la tabla  BACTRADERSUDA.DBO.MDMH  
						 , numdocuventa				numeric(9)     --  Numero de documento de la venta.  
						 , tirventa					numeric(19,4) --(24,8)  -- Tir de mercado a la que se vende la operación.  
						 , utilidadperdidaventa		numeric(19,4) --(24,8)  --  Utilidad o pérdidas por ventas  
          				 , tip_crt					varchar(5)     -- Tipo de Cartera  
						 , fec_liquidación			datetime		-- Fecha de Liquidación  
						 , plazo_al_vcto			int				-- Plazo al Vencimiento  
						 , cod_subcrt_norm			varchar(5)     -- Cartera normativa  
						 , interes_acum				numeric(19,4) --(24,8) -- Interes Acumulado  
						 , reajuste_acum			numeric(19,4) --(24,8) --  Reajuste Acumulado  
						 , [cod_cta_cont]			VARCHAR(100) --20)  -- Código Cuenta Contable  
						 , [cta_ifrs]				VARCHAR(100) --20)  -- Cuenta IFRS  
           
)  
--Declare @R07_CARTERA_SALIDA Table   (   REG_SALIDA  Varchar(1000))  
create table #R07_CARTERA_SALIDA ( REG_SALIDA  Varchar(1000))  
--RFN  
Insert into @Cartera  
 SELECT      
					  rsfecctb																										    --as	'fechaproceso'																					
                    , 'CL'    																											--as	'localidad'				
                    , 'CORPBANCA'    																									--as	'vehiculo'					
                    , CASE WHEN rscartera = '111' THEN 'CP'  
                           WHEN rscartera = '114' THEN 'Intermediacion'      																
                           WHEN rscartera = '121' THEN 'Interbancarios'    																	
                           WHEN rscartera = '130' THEN 'Interbancarios-CENTRAL'    															
                                                  ELSE 'COMDER'    																			
                      END    																											--as	'tipoproducto'
                    , cast(rsnumdocu as varchar(10)) + '-' + cast(rsnumoper as varchar(10)) + '-' + cast(rscorrela as varchar(10))    	--as	'numerooperacion'			
                    , 'ACT'    																											--as	'tipoflujo'				
                    , 'RFMN'    																										--as	'producto'					
                    , CAST( rsrutcli AS VARCHAR(10) ) + Cli.cldv    																	--as	'cliente'					
                    , Cli.clnombre    																									--as	'nombrecliente'			
                    , rsfeccomp    																										--as	'fechacompra'				
                    , rsfecemis    																										--as	'fechaemision'				
                    , CASE WHEN rscartera = '130' THEN rsfecvtop ELSE rsfecvcto END    													--as	'fechavencimiento'			
                    , DATEDIFF( DAY, rsfecctb, CASE WHEN rscartera = '130' THEN rsfecvtop ELSE rsfecvcto END )    						--as	'tenor'					
                    , rstipcart    																										--as	'codigocarterafinanciera'
                    , ltrim(convert(varchar(50),fi.tbglosa))				    															--as	'carterafinanciera'		
                    , RS.codigo_Carterasuper    																						--as	'codigocarteranormativa'	
                    , ltrim(convert(varchar(50),su.tbglosa))	    																		--as	'carteranormativa'			
                    , rsid_libro    																									--as	'codigolibro'				
                    , ltrim(convert(varchar(50),li.tbglosa))																				--as	'libro'					
                    , inserie    																										--as	'familia'					
                    , rsmascara    																										--as	'mascara'					
                    , rsinstser    																										--as	'instrumento'				
                    , rsmonemi    																										--as	'codigomonedaemision'		
                    , Mo.mnnemo    																										--as	'monedaemision'			
                    , rsrutemis    																										--as	'codigoemisor'				
                    , isnull(emgeneric,'')    																							--as	'emisor'					
                    , rsnominal    																										--as	'nominal'					
                    , rstir    																											--as	'tir'						
                    , rsvalcomu    																										--as	'valorcompramo'			
                    , rsvalcomp    																										--as	'valorcompra'				
                    , 'CLP'    																											--as	'monedavalorpresente'		
                    , ISNULL(rsvppresen  ,0)  																							--as	'valorpresentemo'			
                    , ISNULL(rsvppresen  ,0)  																							--as	'valorpresente'			
                    , ISNULL(vm.tasa_mercado,0)    																						--as	'tirmtm'					
                    , ISNULL(vm.valor_mercado,0)    																					--as	'mtm'						
                    , ISNULL(vm.diferencia_mercado,0)    																				--as	'delta'					
                    , ISNULL(rsinteres,0 )    																							--as	'interesdiario'			
                    , ISNULL(rsreajuste,0)    																							--as	'reajustediario'			
                    , ISNULL(rsinteres_acum,0)    																						--as	'interesacumulado'			
                    , ISNULL(rsreajuste_acum,0)    																						--as	'reajusteacumulado'		
                    , ISNULL(rsvppresenx,0)    																							--as	'proximovalorpresente'		
                    , ISNULL(rsvppresenx,0)    																							--as	'proximovalorpresentemo'	
                    , rsnumdocu     																									--as	'documento'				
                    , rsnumoper     																									--as	'operacion'				
                    , rscorrela    																										--as	'correlativo'				
					, rs.rsfecucup   as fechacupon  																					--as	'fechacupon'				
					, rs.rsfecucup   as fechapago  																						--as	'fechapago'				
					, 0      as mtmclpayer  																							--as	'mtmclpayer'				
					, ISNULL((rs.rsinteres+rs.rsreajuste),0) as devengodiario  															--as	'devengodiario'			
					, ISNULL((vm.valor_mercado- rs.rsvppresen),0) as diferenciamercadoclp  												--as	'diferenciamercadoclp'		
					,0      as valorpapeleta  																							--as	'valorpapeleta'			
					,rstipopero    AS tipooperacion  																					--as	'tipooperacion'			
					,rscodigo       as codigoinstrumento  																				--as	'codigoinstrumento'		
					,0      as numdocuventa  																							--as	'numdocuventa'				
					,0      as tirventa  																								--as	'tirventa'					
					,0      as utilidadperdidaventa  																					--as	'utilidadperdidaventa'		
					,''      as tip_crt        																							--as	'tip_crt'					
					,''      as fec_liquidación      																					--as	'fec_liquidación'			
					,0      as plazo_al_vcto      																						--as	'plazo_al_vcto'			
					,''      as cod_subcrt_norm      																					--as	'cod_subcrt_norm'			
					,rs.rsinteres_acum  as interes_acum       																			--as	'interes_acum'				
					,rs.rsreajuste_acum  as reajuste_acum     																			--as	'reajuste_acum'			
					,''      as [cod_cta_cont]      																					--as	'[cod_cta_cont]'			
					,''      as [cta_ifrs]      																						--as	'[cta_ifrs]'				
                 FROM BacTraderSuda.dbo.mdrs              Rs				with(nolock)
                      LEFT  JOIN BacParamSuda.dbo.Cliente Cli				with(nolock) ON  Cli.clrut    = rsrutcli  AND  Cli.clcodigo = rscodcli    
                      LEFT  JOIN BacParamSuda.dbo.Emisor  Emi				with(nolock) ON  Emi.emrut    = rsrutemis    
					  LEFT  JOIN BacParamSuda.dbo.INSTRUMENTO INS			with(nolock) ON  INS.incodigo = rscodigo    
					  LEFT  JOIN BacParamSuda.dbo.Moneda  Mo				with(nolock) ON  Mo.mncodmon  = rsmonemi      
					  LEFT  JOIN bacparamsuda.dbo.tabla_general_detalle li  with(nolock) ON  li.tbcateg=1552 AND li.tbcodigo1 = CAST(rsid_libro AS VARCHAR(10))    
					  LEFT  JOIN bacparamsuda.dbo.tabla_general_detalle fi  with(nolock) ON  fi.tbcateg=204  AND fi.tbcodigo1 = CAST(rstipcart AS VARCHAR(10))  
					  LEFT  JOIN bacparamsuda.dbo.tabla_general_detalle su  with(nolock) ON  su.tbcateg=1111 AND su.tbcodigo1 = rs.codigo_carterasuper  
					  LEFT  JOIN BacTraderSuda.dbo.VALORIZACION_MERCADO vm  with(nolock) ON  rmnumdocu       = rsnumdocu  AND  rmnumoper = rsnumoper  AND  rmcorrela = rscorrela    
									   AND  fecha_valorizacion = @dFechaValorizacion  
                       AND  tipo_operacion  = CASE	WHEN rscartera = '111' THEN 'CP'     
													WHEN rscartera = '114' THEN 'VI' ELSE 'CG' END    
				WHERE rsfecctb     = @dFechaProceso    
                  AND rstipoper    = 'DEV'    
                  AND rscartera    IN ( '111', '114', '121', '130', '159' )    
                  AND rsnominal    != 0    
          
--RFE  
Insert into @Cartera  
 SELECT      rs.rsfecpro    
                    ,  'CL'    
                    ,  'CORPBANCA'    
                    ,  'CP'																														--as	'tipoproducto'
                    ,  cast(rs.rsnumdocu as varchar) + '-' + cast(rs.rsnumoper as varchar) + '-' + cast(rs.rscorrelativo as varchar)    		--as	'numerooperacion'		
                    ,  'ACT'    																												--as	'tipoflujo'				
                    ,  'INVEXT'    																												--as	'producto'				
                    ,  CAST( rs.rsrutcli AS VARCHAR(10) ) + Cli.cldv    																		--as	'cliente'				
                    ,  Cli.clnombre    																											--as	'nombrecliente'			
                    ,  rs.rsfeccomp    																											--as	'fechacompra'			
                    ,  rs.rsfecemis    																											--as	'fechaemision'			
                    ,  rs.rsfecvcto    																											--as	'fechavencimiento'		
                    ,  DATEDIFF( DAY, rs.rsfecpro, rs.rsfecvcto )    																			--as	'tenor'					
                    ,  rs.Tipo_Cartera_Financiera    																							--as	'codigocarterafinanciera
                    ,  ISNULL( fi.tbglosa, CAST( rs.Tipo_Cartera_Financiera AS VARCHAR(10) ))    												--as	'carterafinanciera'		
                    ,  rs.codigo_carterasuper    																								--as	'codigocarteranormativa'
                    ,  su.tbglosa    																											--as	'carteranormativa'		
                    ,  rs.RsId_Libro    																										--as	'codigolibro'			
                    ,  li.tbglosa    																											--as	'libro'					
                    ,  rs.cod_familia    																										--as	'familia'				
                    ,  rs.cod_nemo    																											--as	'mascara'				
                    ,  rs.id_instrum    																										--as	'instrumento'			
                    ,  rs.rsmonemi    																											--as	'codigomonedaemision'	
                    ,  Mo.mnnemo   																												--as	'monedaemision'			
                    ,  rs.rsrutemis    																											--as	'codigoemisor'			
                    ,  isnull(emgeneric,'')    																									--as	'emisor'				
                    ,  rs.rsnominal    																											--as	'nominal'				
					,  rs.rstir    																												--as	'tir'					
                    ,  rs.rsvalcomu    																											--as	'valorcompramo'			
                    ,  rs.rsvalcomu    																											--as	'valorcompra'			
                    ,  Mo1.mnnemo    																											--as	'monedavalorpresente'	
                    ,  ISNULL(rs.rsvppresen  ,0)  																								--as	'valorpresentemo'		
                    ,  ISNULL(ROUND( rs.rsvppresen * TC.valor, 0 )  ,0)  																		--as	'valorpresente'			
                    ,  ISNULL(rs.rstirmerc ,0)   																								--as	'tirmtm'				
                    ,  ISNULL( ROUND( rs.rsvalmerc * TC.valor, 0 )  ,0)  																		--as	'mtm'					
                    ,  ISNULL(rs.rsvalmerc - rs.rsvppresen  ,0)  																				--as	'delta'					
                    ,  ISNULL(rsinteres,0 )    																									--as	'interesdiario'			
                    ,  ISNULL(rsreajuste,0)    																									--as	'reajustediario'		
                    ,  ISNULL(rsinteres_acum,0)    																								--as	'interesacumulado'		
                    ,  ISNULL(rsreajuste_acum,0)    																							--as	'reajusteacumulado'		
                    ,  ISNULL(ROUND( rsvppresenx * TC.valor, 0 )  ,0)  																			--as	'proximovalorpresente'	
                    ,  ISNULL(rsvppresenx,0)    																								--as	'proximovalorpresentemo'
                    ,  rsnumdocu     																											--as	'documento'				
                    ,  rsnumoper     																											--as	'operacion'				
                    ,  rscorrelativo    																										--as	'correlativo'			
					,  rs.rsfecucup   as fechacupon  																							--as	'fechacupon'			
					 , rs.rsfecucup   as fechapago  																							--as	'fechapago'				
					 , 0      as mtmclpayer  																									--as	'mtmclpayer'			
					 , ISNULL((rs.rsinteres+rs.rsinteres),0) as devengodiario  																	--as	'devengodiario'			
					 , ISNULL((RS.rsvalmerc- rs.rsvppresen),0) as diferenciamercadoclp  														--as	'diferenciamercadoclp'	
					 , 0      as valorpapeleta  																								--as	'valorpapeleta'			
					 , 'CP'   AS tipooperacion  																								--as	'tipooperacion'			
					 , RS.cod_familia   as codigoinstrumento  																					--as	'codigoinstrumento'		
					 , 0      as numdocuventa  																									--as	'numdocuventa'			
					 , 0      as tirventa  																										--as	'tirventa'				
					 , 0      as utilidadperdidaventa  																							--as	'utilidadperdidaventa'	
					 , ''      as tip_crt        																								--as	'tip_crt'				
					 , ''      as fec_liquidación      																							--as	'fec_liquidación'		
					 , 0      as plazo_al_vcto      																							--as	'plazo_al_vcto'			
					 , ''      as cod_subcrt_norm      																							--as	'cod_subcrt_norm'		
					 , rs.rsinteres_acum  as interes_acum       																				--as	'interes_acum'			
					 , rs.rsreajuste_acum  as reajuste_acum     																				--as	'reajuste_acum'			
					 , ''      as [cod_cta_cont]      																							--as	'[cod_cta_cont]'		
					 , ''      as [cta_ifrs]   																									--as	'[cta_ifrs]'			
  
                 FROM BacBonosExtSuda.dbo.text_rsu rs    with(nolock)  
                      LEFT  JOIN BacParamSuda.dbo.Cliente    Cli    with(nolock)   ON  Cli.clrut    = rs.rsrutcli  AND  Cli.clcodigo = rs.rscodcli    
                      LEFT  JOIN BacParamSuda.dbo.Moneda     Mo  with(nolock)   ON  Mo.mncodmon  = rs.rsmonemi    
                      LEFT  JOIN BacParamSuda.dbo.Moneda     Mo1 with(nolock)   ON  Mo1.mncodmon = rs.rsmonpag    
                      LEFT  JOIN BacParamSuda.dbo.Emisor     E  with(nolock)   ON  E.emrut      = rs.rsrutemis  
					  LEFT  JOIN bacparamsuda.dbo.tabla_general_detalle li  with(nolock) ON  li.tbcateg=1552 AND li.tbcodigo1 = CAST(rsid_libro AS VARCHAR(10))    
					  LEFT  JOIN bacparamsuda.dbo.tabla_general_detalle fi  with(nolock) ON  fi.tbcateg=204  AND fi.tbcodigo1 = CAST(rs.Tipo_Cartera_Financiera AS VARCHAR(10))  
					  LEFT  JOIN bacparamsuda.dbo.tabla_general_detalle su  with(nolock) ON  su.tbcateg=1111 AND su.tbcodigo1 = rs.codigo_carterasuper  
                      LEFT  JOIN BacParamSuda.dbo.Moneda      CMC   with(nolock) ON  CMC.mncodmon   = Mo.mncodmon    
                      LEFT  JOIN BacParamSuda.dbo.Moneda      CMP   with(nolock) ON  CMP.mncodmon   = Mo1.mncodmon    
                      LEFT  JOIN @tmpParidad                  TC     ON  TC.CodMoneda  = mo1.mncodmon   
                WHERE rsfecpro             = @dFechaProceso  AND(rs.rstipoper   = 'DEV'  or rs.rstipoper = 'CP' AND rsfecpro = rsfeccomp)    
  
--PAS  
Insert into @Cartera  
   SELECT   fecha_calculo    
                    , 'CL'    
                    , 'CORPBANCA'    
                    , CASE WHEN LEFT( rs.nombre_serie, 4 ) in ( 'BCOR', 'BITA' ) THEN 'Bono propia Emision' ELSE 'Bono Subordinado' END    
                    , cast(rs.numero_operacion as varchar(10)) + '-' + cast(rs.numero_correlativo as varchar(10))    
                    , 'PAS'    
                    , 'BonosPasivos'    
                    , CAST( rut_cliente AS VARCHAR(10) ) + Cli.cldv        
					, Cli.clnombre    
                    , s.fecha_emision    
                    , s.fecha_emision    
                    , s.fecha_vencimiento    
                    , DateDiff(Day, fecha_calculo, s.fecha_vencimiento )    
                    , 0    
					, ''    
                    , '0'    
                    , ''    
                    , 0    
                    , ''    
                    , s.codigo_instrumento    
                    , rs.nombre_serie    
                    , rs.nombre_serie    
                    , rs.moneda_emision    
                    , m.mnnemo   
					, '97023000'    
                    , 'CORPBANCA'     
                    , rs.nominal --nominal    
                    , rs.tasa_colocacion --tir    
                    , valor_colocacion      --saleamountum    
                    , rs.valor_colocacion_um   --saleamount    
                    , 'CLP'    
                    , col_Val_pte_ctr       --presentvalueum    
                    , col_Val_pte_ctr       --presentvalue    
                    , 0    
                    , 0    
                    , 0    
                    , ISNULL(col_int_dia_dev,0 )    
                    , ISNULL(col_rea_dia_dev,0)    
                    , ISNULL(col_int_acm_ctr,0)    
                    , ISNULL(col_rea_acm_ctr,0)    
                    , ISNULL(col_val_prx_dev,0)    
                    , ISNULL(col_val_prx_dev,0)    
                    , 0     
                    , rs.numero_operacion     
                    , rs.numero_correlativo    
					 , rs.fecha_ultimo_cupon as fechacupon  
					 , rs.fecha_ultimo_cupon as fechapago  
					 , 0      as mtmclpayer  
					 , 0      as devengodiario    --(rs.interes_colocacion+rs.reajuste_colocacion)  
					 , 0      as diferenciamercadoclp  --(rs.rsvalmerc- rs.rsvppresen) as diferenciamercadoclp  
					 , 0      as valorpapeleta  
					 , ''     AS tipooperacion  
					 , rs.codigo_instrumento as codigoinstrumento  
					 , 0      as numdocuventa  
					 , 0      as tirventa  
					 , 0      as utilidadperdidaventa  
     
					 , ''     as tip_crt        
					 , ''     as fec_liquidación      
					 , 0      as plazo_al_vcto      
					 , ''     as cod_subcrt_norm      
					 , 0      as interes_acum       
					 , 0      as reajuste_acum     
					 , ''     as [cod_cta_cont]      
					 , ''     as [cta_ifrs]   
  
              FROM mdpasivo.dbo.resultado_pasivo   rs  with(nolock)  
				inner join mdpasivo.dbo.cartera_pasivo cp with (nolock) on  cp.numero_operacion=rs.numero_operacion and cp.numero_correlativo=rs.numero_correlativo  
				inner join bacparamsuda.dbo.cliente cli with (nolock) on cp.rut_cliente=cli.clrut and cp.codigo_cliente=cli.clcodigo  
                inner join mdpasivo.dbo.Serie_Pasivo  s   with(nolock) on s.nombre_serie = rs.nombre_serie    
                inner join bacparamsuda.dbo.moneda    m   with(nolock) on m.mncodmon     = rs.moneda_emision    
                LEFT JOIN  BacParamSuda.dbo.Moneda    m1  with(nolock) on m1.mncodmon    = m.mncodmon    
                WHERE fecha_calculo = @dFechaProceso  AND rs.tipo_operacion    != 'VC'    
  
  
--ACTUALIZA CUENTA CONTABLE BTR-CP  
UPDATE @Cartera  
SET [cod_cta_cont] =CtaContable  
FROM @Cartera,  
 BACTRADERSUDA..CARTERA_CUENTA     
  WHERE   
   Sistema  = 'BTR'    
  AND t_operacion = 'CP'    
  AND NumDocu  = documento    
  AND Correla  = correlativo    
  AND NumOper  = operacion     
  AND variable = CASE WHEN codigoinstrumento = 20 AND Moneda <> 997 THEN   
      'valor_tasa_emision'    
                      ELSE                                        
      'valor_compra'    
     END    
  
--ACTUALIZA CUENTA CONTABLE INVEXT-CP  
UPDATE @Cartera  
SET [cod_cta_cont] =CtaContable  
FROM @Cartera,  
 BacBonosExtSuda..CARTERA_CUENTA     
WHERE  
 producto  = 'INVEXT'    
AND NumDocu  = documento    
AND Correla  = correlativo    
AND t_operacion= 'CP'  
  
--TODO : ACTUALIZA CUENTA CONTABLE PASIVOS  
  
-- Actualizar Campos con Tíldes    
 
--UPDATE @Cartera  
--SET nombrecliente  = UPPER(dbo.fnLimpiarCaracteres(nombrecliente))  
--,   carterafinanciera = UPPER(dbo.fnLimpiarCaracteres(carterafinanciera))  
  
  
If @TipoSalida = 1   
 begin  
  --LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), mtm ) ) , '.', ','))
  Insert Into #R07_CARTERA_SALIDA  
  Select    
    --versión 2  
    LTRIM(CONVERT(CHAR(10),fechaproceso,105))							+ @SEP + LTRIM(localidad)												+ @SEP + LTRIM(vehiculo)											+ @SEP +       
    LTRIM(tipoproducto)													+ @SEP + LTRIM(documento)												+ @SEP + lTRIM(numerooperacion)										+ @SEP + LTRIM(correlativo)												+ @SEP +  
    LTRIM(tipoflujo)													+ @SEP + LTRIM(producto)												+ @SEP + lTRIM(tip_crt)												+ @SEP + LTRIM(cliente)													+ @SEP +   
    LTRIM(CONVERT(CHAR(10),fechacompra,105))							+ @SEP + LTRIM(CONVERT(CHAR(10),fechaemision,105))						+ @SEP +   
    LTRIM(CONVERT(CHAR(10),fechavencimiento,105))						+ @SEP + LTRIM(CONVERT(CHAR(10),fec_liquidación,105))					+ @SEP +   
    LTRIM(plazo_al_vcto)												+ @SEP + LTRIM(codigocarterafinanciera)									+ @SEP + LTRIM(CONVERT(nvarchar(50),carterafinanciera))				+ @SEP +  LTRIM(codigocarteranormativa)									+ @SEP +  
    LTRIM(CONVERT(VARCHAR(50),carteranormativa))						+ @SEP + LTRIM(cod_subcrt_norm)											+ @SEP + LTRIM(codigolibro)											+ @SEP +  LTRIM(familia)												+ @SEP +  
    LTRIM(mascara)														+ @SEP + LTRIM(instrumento)												+ @SEP + LTRIM(monedaemision)										+ @SEP +  LTRIM(codigoemisor)											+ @SEP +   
   	LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), nominal ) ) , '.', ','))					+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), tir ) ) , '.', ','))				+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), valorcompramo ) ) , '.', ','))			+ @SEP +  lTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), valorcompra ) ) , '.', ','))		+ @SEP + 
	LTRIM(monedavalorpresente)																+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), valorpresentemo ) ) , '.', ','))	+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), interesdiario ) ) , '.', ','))			+ @SEP +  LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), reajustediario ) ) , '.', ','))	+ @SEP +
	LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), interesacumulado ) ) , '.', ','))			+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), reajusteacumulado ) ) , '.', ','))	+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), interes_acum ) ) , '.', ','))			+ @SEP +  LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), reajuste_acum ) ) , '.', ','))	+ @SEP +
	LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), proximovalorpresentemo ) ) , '.', ','))		+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), tirmtm ) ) , '.', ','))			+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), mtm ) ) , '.', ','))					+ @SEP +  LTRIM(cod_cta_cont)															+ @SEP +
	LTRIM(cta_ifrs)																			+ @SEP + LTRIM(nombrecliente)															+ @SEP + LTRIM(tenor)																		+ @SEP +  LTRIM(libro)																	+ @SEP +
	LTRIM(codigomonedaemision)																+ @SEP + LTRIM(emisor)																	+ @SEP + LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), valorpresente ) ) , '.', ','))			+ @SEP +  LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), delta ) ) , '.', ','))			+ @SEP + 
	LTRIM(REPLACE(RTRIM(CONVERT( NUMERIC(19,4), proximovalorpresente ) ) , '.', ','))		+ @SEP + LTRIM(REPLACE(RTRIM(operacion ),' ',''))  			AS   REG_SALIDA	

    --LTRIM(RTRIM(CONVERT( NUMERIC(19,4), nominal ) ) )					+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), tir ) ) )					+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), valorcompramo ) ) )	+ @SEP +  lTRIM(RTRIM(CONVERT( NUMERIC(19,4), valorcompra ) ) )			+ @SEP +   
    --LTRIM(monedavalorpresente)											+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), valorpresentemo ) ) )		+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), interesdiario ) ))		+ @SEP +  LTRIM(RTRIM(CONVERT( NUMERIC(19,4), reajustediario ) ) )		+ @SEP +  
    --LTRIM(RTRIM(CONVERT( NUMERIC(19,4), interesacumulado ) ) )			+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), reajusteacumulado ) ) )	+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), interes_acum ) ) )		+ @SEP +  LTRIM(RTRIM(CONVERT( NUMERIC(19,4), reajuste_acum ) ) )		+ @SEP +  
    --LTRIM(RTRIM(CONVERT( NUMERIC(19,4), proximovalorpresentemo ) ))		+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), tirmtm ) ) )				+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), mtm ) ))				+ @SEP +  LTRIM(cod_cta_cont)											+ @SEP +  
    --LTRIM(cta_ifrs)														+ @SEP + LTRIM(CONVERT(VARCHAR(70),nombrecliente))						+ @SEP + LTRIM(tenor)												+ @SEP +  LTRIM(libro)													+ @SEP +  
    --LTRIM(codigomonedaemision)											+ @SEP + LTRIM(emisor)													+ @SEP + LTRIM(RTRIM(CONVERT( NUMERIC(19,4), valorpresente ) ) )    + @SEP +  LTRIM(RTRIM(CONVERT( NUMERIC(19,4), delta ) ) )				+ @SEP +   
    --LTRIM(RTRIM(CONVERT( NUMERIC(19,4), proximovalorpresente ) ) )		+ @SEP +  LTRIM(REPLACE(RTRIM(operacion ),' ',''))     AS   REG_SALIDA     
  From   
   @Cartera  
   
  --Select distinct  * from @R07_CARTERA_SALIDA 
  select * from #R07_CARTERA_SALIDA
  drop table #R07_CARTERA_SALIDA
  
 end  
 else  
 begin  
  SELECT producto, numerooperacion, tirmtm,mtm, delta,* From @Cartera  -- where producto='RFMN'
 end  
  
END   
--go  
--exec SP_R07_CARTERAS '20210811'  
  





GO
