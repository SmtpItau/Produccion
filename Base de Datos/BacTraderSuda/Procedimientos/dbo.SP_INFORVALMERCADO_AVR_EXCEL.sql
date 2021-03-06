USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORVALMERCADO_AVR_EXCEL]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORVALMERCADO_AVR_EXCEL]
						(	 @cSistema		CHAR(3)		-- Id sistema en VM
       ,@Libro   CHAR(6)  -- LIBRO  
       ,@AreaNegocio CHAR(3)  -- CARTERA DE INVERSION  
							,@CarteraFinac	CHAR(5)		-- CARTERA DE INVERSION		-->	CAMBIO DE LARGO 1 A 5 CARACTERES
       ,@CarteraNorma CHAR(1)  -- CARTERA NORMATIVA  
       ,@RutCliente NUMERIC(9) --RUT CLIENTE  
       ,@cFechaD  CHAR(8)  
       ,@cFechaH  CHAR(8)  
       ,@vTitulo  VARCHAR(200)  
       ,@vOperador  CHAR(15)  
       ,@cDolar  CHAR(1)  
)  
AS  
BEGIN  
 SET NOCOUNT ON   
 DECLARE @acfecproc CHAR(10),  
  @acfecprox CHAR(10),  
  @uf_hoy  FLOAT,  
  @uf_man  FLOAT,  
  @ivp_hoy FLOAT,  
  @ivp_man FLOAT,  
  @do_hoy  FLOAT,  
  @do_man  FLOAT,  
  @da_hoy  FLOAT,  
  @da_man  FLOAT,  
  @acnomprop CHAR(40),  
  @rut_empresa varCHAR(12),  
  @hora   varCHAR(8),  
  @sAreaNegocio varCHAR(50),  
  @sLibro   varCHAR(50),  
  @sCarteraFinac varCHAR(50),  
  @sCarteraNorma varCHAR(50),  
  @sRutCliente varCHAR(50),  
  @sOperador  varCHAR(50),  
  @sRangoFecha varCHAR(50),  
  @sRut_cliente varCHAR(50)  
 EXECUTE Sp_Base_Del_Informe @acfecproc OUTPUT  
     ,@acfecprox OUTPUT  
     ,@uf_hoy OUTPUT  
     ,@uf_man OUTPUT  
     ,@ivp_hoy OUTPUT  
     ,@ivp_man OUTPUT  
     ,@do_hoy OUTPUT  
     ,@do_man OUTPUT  
     ,@da_hoy OUTPUT  
     ,@da_man OUTPUT  
     ,@acnomprop OUTPUT  
     ,@rut_empresa OUTPUT  
     ,@hora  OUTPUT  
  
 --obtiene descripcion de area de negocio  
 set @sAreaNegocio='< TODOS [AS] >'  
 select  @sAreaNegocio = tbglosa  
 from VIEW_TABLA_GENERAL_DETALLE   
 where tbcateg=1553  
 AND  tbcodigo1 = @AreaNegocio  
  
 --obtiene descripcion del Operador  
 set @sOperador='< TODOS [AS] >'  
 select @sOperador= nombre  
 from  VIEW_USUARIO  
 where  tipo_usuario='TRADER'  
 and usuario = @vOperador  
  
 --obtiene descripcion de la cartera normativa  
 set @sCarteraNorma='< TODOS [AS] >'  
 SELECT  @sCarteraNorma = tbglosa  
  FROM VIEW_TABLA_GENERAL_DETALLE A  
  WHERE A.tbcateg = 1111  
  and A.tbcodigo1  = @CarteraNorma  
  
 --obtiene descripcion de la cartera financiera  
 set @sCarteraFinac='< TODOS [AS] >'  
 SELECT  @sCarteraFinac = tbglosa  
  FROM VIEW_TABLA_GENERAL_DETALLE A  
  WHERE A.tbcateg = 204  
  and A.tbcodigo1  = @CarteraFinac  
  
 --obtiene descripcion Libro  
 set @sLibro='< TODOS [AS] >'  
 SELECT  @sLibro = tbglosa  
  FROM VIEW_TABLA_GENERAL_DETALLE A  
  WHERE A.tbcateg = 1552  
  and A.tbcodigo1  = @Libro  
  
 --obtiene Nombre de Cliente  
 SET  @sRut_cliente = '< TODOS [AS] >'  
 SELECT @sRut_cliente = clnombre  
 FROM VIEW_CLIENTE  
 WHERE clrut = @RutCliente  
   
 SELECT  'rmnumdocu' = ISNULL(RTRIM(CONVERT(CHAR(7),vm.rmnumdocu)) + '-' + CONVERT(CHAR(3),vm.rmcorrela),'*-*')  
  ,'rmnumoper' = ISNULL(vm.rmnumoper,0)  
  ,'tminster' = CONVERT(VARCHAR(13),ISNULL(cp.cpinstser,'')) --> CONVERT(VARCHAR(13),ISNULL(tm.tminstser,''))  
  ,'tmfecpro' = ISNULL(CONVERT(CHAR(10),cp.cpfecven,103),'') --> ISNULL(CONVERT(CHAR(10),tm.tmfecvcto,103),'')  
  ,'tmnominal' = CONVERT(NUMERIC(20), ISNULL(vm.valor_nominal,0))  
  ,'moneda' = ISNULL(mn.mnnemo,'')  
  ,'rmttir' = ISNULL(vm.tasa_compra,0)  
  ,'rmvpres' = CONVERT(NUMERIC(19,4),ISNULL(vm.valor_presente,0))  
  ,'rmvmerc' = CONVERT(NUMERIC(19,4),ISNULL(vm.valor_mercado,0))  
  ,'tmtmerc' = CONVERT(NUMERIC(19,4),ISNULL(vm.tasa_mercado,0))  
  ,'rmdmerc' = CONVERT(NUMERIC(19,4),ISNULL(vm.diferencia_mercado,0))  
  ,'tmmarket' = CONVERT(NUMERIC(19,4),ISNULL(tm.tasa_market,0))  
  ,'rmvmarket' = CONVERT(NUMERIC(19,4),ISNULL(vm.valor_market,0))  
  ,'rmdmarket' = ISNULL(vm.diferencia_market,0)  
  ,'tmmarket1' = ISNULL(tm.tasa_market1,0)  
  ,'rmvmarket1' = ISNULL(vm.valor_market1,0)  
  ,'rmdmarket1' = ISNULL(vm.diferencia_market1,0)  
  ,'tmmarket2' = ISNULL(tm.tasa_market2,0)  
  ,'rmvmarket2' = ISNULL(vm.valor_market2,0)  
  ,'rmdmarket2' = ISNULL(vm.diferencia_market2,0)  
  ,'inserie'      = CONVERT(CHAR(25), CASE WHEN INCODIGO = 15 AND emtipo     IN('1','3','4')                     THEN 'BONOS OTRAS INST.'  
                                                         WHEN INCODIGO = 15 AND emtipo       = '2'                      THEN 'BONOS INST. FINANCIERAS'   
                                                         WHEN INCODIGO = 20 AND tm.tmrutemis = 97030000 AND vm.moneda_emision = 997 THEN 'LCHR ESTA IVP'  
                                                         WHEN INCODIGO = 20 AND tm.tmrutemis = 97030000 AND vm.moneda_emision = 998 THEN 'LCHR ESTA UF'   
                                                         WHEN INCODIGO = 20 AND tm.tmrutemis = 97023000                             THEN 'LCHR PROPIAS'  
                                                         WHEN INCODIGO = 20                                                         THEN 'LCHR OTROS'   
                                                         ELSE inserie   
                                                     END)  
  ,'sw'   = '0'  
  ,'titulo'  = @vTitulo  
  ,'subtitulo'  = CASE WHEN vm.tipo_operacion = 'CP' THEN 'DISPONIBLE  '  
      ELSE 'INTERMEDIADO'    
     END  
  ,'Tipoper'  = ISNULL(vm.tipo_operacion,'')  
  ,'TASA_EMISION'  = CASE WHEN cpseriado = 'N' THEN (SELECT TOP 1    nstasemi FROM VIEW_NOSERIE WHERE nscodigo  = cpcodigo AND nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela)  
      ELSE    (SELECT DISTINCT setasemi FROM VIEW_SERIE   WHERE semascara = cpmascara)   
      END  
  ,'rsvppresen'  = ISNULL(cp.cpvalcomp,0.0)  
  ,'fechaaux'  = DATEDIFF(DAY,CONVERT(DATETIME,@cFechaD,113),cp.cpfecven)  
  ,'duration'  = cp.cpdurat  
  ,'Clasificacion1' = CASE WHEN LTRIM(CONVERT( CHAR(40),clasificacion1)) = '' THEN '---' END  
  ,'Clasificacion2' = CASE WHEN LTRIM(CONVERT( CHAR(40),clasificacion2)) = '' THEN '---' END  
  ,'Tipo_corto1'  = CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_corto1))    = '' THEN '---' END  
  ,'Tipo_largo1'  = CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_largo1))    = '' THEN '---' END  
  ,'Tipo_corto2'  = CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_corto1))    = '' THEN '---' END  
  ,'Tipo_largo2'  = CASE WHEN LTRIM(CONVERT( CHAR(40),tipo_largo2))    = '' THEN '---' END  
  ,'ValPresTC_LT'  = ISNULL(Clt_VPTC_ValAct,0)  
  ,'ValPresTM_LT'  = ISNULL(Clt_VPTM_ValAct,0)  
  ,'TirCompra_LT'  = ISNULL(Clt_TC_PP_Ini,0)  
  ,'TirMercado_LT' = ISNULL(Clt_TM_PP_Val,0)  
  ,'ResDif_LT'  = ISNULL(Clt_Res_VM_VP,0)  
--VARIABLE PARA EL UPDATE  
  ,'Usuario'   = space(50)  
  ,'Cartera'   = '  '  
  ,'numero_operacion' = vm.rmnumoper  
  ,'numero_documento' = vm.rmnumdocu  
  ,'correlativo'  = vm.rmcorrela  
  ,'fecha_valorizacion'= vm.fecha_valorizacion  
------------------------  
  ,'Area_de_Negocio'  = @sAreaNegocio  
  ,'Cartera_Normativa' = @sCarteraNorma  
  ,'Cartera_Financiera' = @sCarteraFinac  
  ,'Cliente'   = @sRut_cliente  
  ,'Operador'   = @sOperador  
  ,'Libro'   = @sLibro  
  ,'Fecha1'   = CONVERT(DATETIME,@cFechaD,113)   
  ,'Fecha2'   = CONVERT(DATETIME,@cFechaH,113)  
 INTO #TEMPO  
 FROM    VALORIZACION_MERCADO  vm with(nolock)  
  INNER JOIN MDCP cp with(nolock) ON  vm.rmnumdocu = cp.cpnumdocu --- los disponibles  
      AND vm.rmcorrela     = cp.cpcorrela  
      AND vm.rut_emisor     <> '97023000'  
         AND (cp.Id_Sistema    = @AreaNegocio OR @AreaNegocio ='')  
      AND (cp.Tipo_Cartera_Financiera = @CarteraFinac OR @CarteraFinac = '')  
      AND (cp.codigo_carterasuper  = @CarteraNorma OR @CarteraNorma = '')  
      AND (cp.cprutcli    = @RutCliente OR @RutCliente  = 0)  
      AND (cp.id_libro    = @Libro  OR @Libro ='')  
     LEFT  JOIN TASA_MERCADO  tm with(nolock) ON   
       tm.id_sistema  = @cSistema  
      AND tm.fecha_proceso = vm.fecha_valorizacion  
      AND tm.tmrutcart  = vm.rmrutcart  
      AND tm.tmcodigo   = vm.rmcodigo  
      AND tm.tminstser  = vm.rminstser  
  LEFT JOIN VIEW_MONEDA               mn with(nolock) ON mn.mncodmon      = vm.moneda_emision  
  LEFT JOIN VIEW_INSTRUMENTO          it with(nolock) ON it.incodigo      = cp.cpcodigo  
  LEFT JOIN VIEW_EMISOR               em with(nolock) ON em.emrut         = vm.rut_emisor --> AND em.emgeneric = tm.tmgenemis  
  LEFT JOIN TBL_CARTERA_LIBRE_TRADING lt with(nolock) ON lt.clt_sistema   = @cSistema  
       AND lt.clt_fechaproc = vm.fecha_valorizacion  
       AND clt_numoper      = vm.rmnumoper  
       AND clt_numdocu      = vm.rmnumdocu  
       AND clt_numcorr      = vm.rmcorrela  
  
 WHERE   (vm.fecha_valorizacion between @cFechaD and @cFechaH)  
 AND (vm.codigo_carterasuper     = @CarteraNorma or  @CarteraNorma ='')  
 AND CHARINDEX(STR( vm.moneda_emision, 3), CASE WHEN @cDolar = 'N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0  
   ORDER BY vm.rminstser  
  
  
 IF @@ROWCOUNT > 0 BEGIN  
  CREATE NONCLUSTERED INDEX TEMP_001 ON #TEMPO   
  ( inserie  
  , moneda  
  , tipoper  
  )  
  
  update  #TEMPO  
  set  Usuario = mousuario  
  from mdmo  
  where  #TEMPO.numero_operacion = monumoper  
  and  #TEMPO.numero_documento = monumdocu  
  and  #TEMPO.correlativo  = mocorrela  
  and  #TEMPO.fecha_valorizacion =@acfecproc  
  AND  motipoper IN ( 'CP', 'VI' )  
    
  update  #TEMPO  
  set  Usuario = mousuario  
  from mdmh  
  where  mdmh.mofecpro = #TEMPO.fecha_valorizacion   
  AND  #TEMPO.numero_operacion = monumoper  
  and  #TEMPO.numero_documento = monumdocu  
  and  #TEMPO.correlativo  = mocorrela  
  and  #TEMPO.fecha_valorizacion < @acfecproc  
  AND  mdmh.motipoper IN ( 'CP', 'VI' )  
    
  IF @vOperador <> ''  
  BEGIN  
   DELETE  #TEMPO  
   WHERE Usuario <> @vOperador  
  END  
    
  SELECT inserie                           ,  
   moneda     ,  
   tipoper     ,  
   subtitulo    ,  
   'tmnominal' = SUM(tmnominal) ,  
   'rmvpres' = SUM(rmvpres)  ,  
   'rmvmerc' = SUM(rmvmerc)  ,  
   'rmdmerc' = SUM(rmdmerc)  ,  
   'rmvmarket' = SUM(rmvmarket) ,  
   'rmdmarket' = SUM(rmdmarket) ,  
   'rmvmarket1' = SUM(rmvmarket1) ,  
   'rmdmarket1' = SUM(rmdmarket1) ,  
   'rmvmarket2' = SUM(rmvmarket2) ,  
   'rmdmarket2' = SUM(rmdmarket2)  
  INTO #TOTAL  
  FROM #TEMPO  
  GROUP  
  BY inserie  
  , moneda  
  , tipoper  
  , subtitulo  
  
                                                                                                                                                                --  1  
  INSERT INTO #TEMPO  
(    rmnumdocu  
   ,rmnumoper  
   ,tminster  
   ,tmfecpro  
   ,tmnominal  
   ,moneda  
   ,rmttir  
   ,rmvpres  
   ,rmvmerc  
   ,tmtmerc  
   ,rmdmerc  
   ,tmmarket  
   ,rmvmarket  
   ,rmdmarket  
   ,tmmarket1  
   ,rmvmarket1  
   ,rmdmarket1  
   ,tmmarket2  
   ,rmvmarket2  
   ,rmdmarket2  
   ,inserie     
   ,sw  
   ,titulo  
   ,subtitulo  
   ,Tipoper  
   ,TASA_EMISION  
   ,rsvppresen  
   ,fechaaux  
   ,duration  
   ,Clasificacion1  
   ,Clasificacion2  
   ,Tipo_corto1  
   ,Tipo_largo1  
   ,Tipo_corto2  
   ,Tipo_largo2  
   ,ValPresTC_LT  
   ,ValPresTM_LT  
   ,TirCompra_LT  
   ,TirMercado_LT  
   ,ResDif_LT  
   ,Usuario  
---------------------------------RQ_7619  
   ,Cartera     
   ,numero_operacion   
   ,numero_documento   
   ,correlativo    
   ,fecha_valorizacion   
---------------------------------RQ_7619  
   ,Area_de_Negocio  
   ,Cartera_Normativa  
   ,Cartera_Financiera  
   ,Cliente  
   ,Operador  
   ,Libro  
   ,Fecha1  
   ,Fecha2  
)  
  SELECT ''   ,  --1  
   0    ,  --2  
                        ''   ,  --3  
   '',  --4  
   tmnominal, --5  
   MONEDA   , --6  
   0,  --7  
   rmvpres,  --8  
   rmvmerc, --9  
   0,  --10  
   rmdmerc, --11  
   0,  --12  
   rmvmarket, --13  
   rmdmarket, --14  
   0,      --15  
   rmvmarket1, --16  
   rmDmarket1, --17  
   0,  --18  
   rmvmarket2, --19  
   rmDmarket2, --20  
   INSERIE, --21  
   1,  --22  
   @vTitulo , --23  
   subtitulo, --24  
   '',  --25  
   0,  --26  
   0,  --27  
   '',  --28  
   0,     --29  
   '',  --30  
   '',  --31    
   '',  --32  
   '',  --33  
   '',  --34  
   ''  --35  
  , 0.0  --36  
  , 0.0  --37  
  , 0.0  --38  
  , 0.0  --39  
  , 0.0  --40   
  , @sOperador  
-------------------------------------RQ_7619  
  , ''  
  , 0  
  , 0  
  , 0  
  , ''  
-------------------------------------RQ_7619  
  , @sAreaNegocio  
  , @sCarteraNorma  
  , @sCarteraFinac  
  , @sRut_cliente  
  , @sOperador  
  , @sLibro  
  , CONVERT(DATETIME,@cFechaD,113)   
  , CONVERT(DATETIME,@cFechaH,113)  
  FROM #TOTAL   
 END   
 ELSE BEGIN  
  INSERT INTO #TEMPO   
(   rmnumdocu  
  ,rmnumoper  
  ,tminster  
  ,tmfecpro  
  ,tmnominal  
  ,moneda  
  ,rmttir  
  ,rmvpres  
  ,rmvmerc  
  ,tmtmerc  
  ,rmdmerc  
  ,tmmarket  
  ,rmvmarket  
  ,rmdmarket  
  ,tmmarket1  
  ,rmvmarket1  
  ,rmdmarket1  
  ,tmmarket2  
  ,rmvmarket2  
  ,rmdmarket2  
  ,inserie     
   ,sw  
   ,titulo  
  ,subtitulo  
  ,Tipoper  
  ,TASA_EMISION  
  ,rsvppresen  
  ,fechaaux  
  ,duration  
  ,Clasificacion1  
  ,Clasificacion2  
  ,Tipo_corto1  
  ,Tipo_largo1  
  ,Tipo_corto2  
  ,Tipo_largo2  
  ,ValPresTC_LT  
  ,ValPresTM_LT  
  ,TirCompra_LT  
  ,TirMercado_LT  
  ,ResDif_LT  
  ,Usuario  
--------------------------------- RQ_7619  
  ,Cartera     
  ,numero_operacion   
  ,numero_documento   
  ,correlativo    
  ,fecha_valorizacion   
---------------------------------RQ_7619  
  ,Area_de_Negocio  
  ,Cartera_Normativa  
  ,Cartera_Financiera  
  ,Cliente  
  ,Operador  
  ,Libro  
  ,Fecha1  
  ,Fecha2  
)  
  SELECT  '',  --1  
   0,  --2  
   '',  --3  
   '',  --4  
   0,  --5  
   '',  --6  
   0,  --7  
   0,  --8  
   0,  --9  
   0,  --10  
   0,  --11  
   0,  --12  
   0,  --13  
   0,  --14  
   0,  --15  
   0,  --16  
   0,  --17  
   0,  --18  
   0,  --19  
   0,  --20  
   '',  --21  
   '0',  --22  
   @vTitulo, --23  
   '',  --24  
   '',  --25  
   0,  --26  
   0,  --27  
   '',  --28  
   0,     --29  
             '',  --30  
             '',  --31    
             '',  --32  
             '',  --33  
             '',  --34  
             ''  --35  
  , 0.0  --36  
  , 0.0  --37  
  , 0.0  --38  
  , 0.0  --39  
  , 0.0  --40  
  , @sOperador  
-------------------------------------RQ_7619  
  , ''  
  , 0  
  , 0  
  , 0  
  , ''  
-------------------------------------RQ_7619  
  , @sAreaNegocio  
  , @sCarteraNorma  
  , @sCarteraFinac  
  , @sRut_cliente  
  , @sOperador  
  , @sLibro  
  , CONVERT(DATETIME,@cFechaD,113)   
  , CONVERT(DATETIME,@cFechaH,113)  
 END  
     
  SELECT rmnumdocu,  
   rmnumoper,  
   tminster,  
   tmfecpro,  
   tmnominal,  
   moneda,  
   rmttir,  
   rmvpres,  
   rmvmerc,  
   tmtmerc,  
   rmdmerc,  
   tmmarket,  
   rmvmarket,  
   rmdmarket,  
   tmmarket1,  
   rmvmarket1,  
   rmdmarket1,  
   tmmarket2,  
   rmvmarket2,  
   rmdmarket2,  
   'inserie' = ISNULL(inserie,''),  
   'acfecproc' = @acfecproc ,  
   'acfecprox' = @acfecprox ,  
   'uf_hoy' = @uf_hoy ,   
   'uf_man' = @uf_man ,  
   'ivp_hoy' = @ivp_hoy ,  
   'ivp_man' = @ivp_man ,  
   'do_hoy' = @do_hoy ,  
   'do_man' = @do_man ,  
   'da_hoy' = @da_hoy ,  
   'da_man' = @da_man ,  
   'acnomprop' = @acnomprop ,  
   'rut_empresa' = @rut_empresa ,  
   'hora'  = @hora  ,  
   sw    ,  
   titulo    ,  
   subtitulo   ,  
   'Fecha1' = SUBSTRING(@cfechaD,7,2) + '/' + SUBSTRING(@cfechaD,5,2) + '/' + SUBSTRING(@cfechaD,1,4),  
   'Fecha2' = SUBSTRING(@cfechaH,7,2) + '/' + SUBSTRING(@cfechaH,5,2) + '/' + SUBSTRING(@cfechaH,1,4),  
   TASA_EMISION,  
   rsvppresen,  
   fechaaux,  
                        duration,  
   clasificacion1,  
   clasificacion2,  
   tipo_corto1,  
   tipo_largo1,  
   tipo_corto2,  
   tipo_largo2,  
   ValPresTC_LT,  --36  
   ValPresTM_LT, --37  
   TirCompra_LT,  --38  
   TirMercado_LT,  --39  
   ResDif_LT,  --40  
   Usuario,  
   Area_de_Negocio,  
   Cartera_Normativa,  
   Cartera_Financiera,  
   Cliente,  
   Operador,  
   Libro  
  , CONVERT(DATETIME,@cFechaD,113)   
  , CONVERT(DATETIME,@cFechaH,113)  
  FROM #TEMPO  
  ORDER   
  BY tminster  
  
  
END
GO
