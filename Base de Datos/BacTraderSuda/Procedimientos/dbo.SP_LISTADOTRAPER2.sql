USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOTRAPER2]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOTRAPER2]
   (@clave   char(1)='',
    @entidad numeric(9)=0)
 
as
begin
 select 'pmfecproc' = acfecproc,
       'pmfecprox' = acfecprox,
       'uf_hoy'    = convert(float, 0),
       'uf_man'    = convert(float, 0),
       'ivp_hoy'   = convert(float, 0),
       'ivp_man'   = convert(float, 0),
       'do_hoy'    = convert(float, 0),
       'do_man'    = convert(float, 0),
       'da_hoy'    = convert(float, 0),
       'da_man'    = convert(float, 0),
       'pmnomprop' = acnomprop,
       'rut_empresa' = rtrim(convert(char(10),acrutprop)) + '-' + acdigprop
  into #PARAMETROS
  from MDAC
/* rescata valor de uf -------------------------------------------------------------- */
update #PARAMETROS set uf_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
update #PARAMETROS set uf_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
/* rescata valor de ivp ------------------------------------------------------------- */
update #PARAMETROS set ivp_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
update #PARAMETROS set ivp_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
/* rescata valor de do -------------------------------------------------------------- */
update #PARAMETROS set do_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
update #PARAMETROS set do_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
/* rescata valor de da -------------------------------------------------------------- */
update #PARAMETROS set da_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
update #PARAMETROS set da_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = pmfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
 if exists(select 'pmfecproc' = convert(char(10),pmfecproc,103),
                  'pmfecprox' =convert(char(10),pmfecprox,103),
           uf_hoy,
           uf_man,
           ivp_hoy,
           ivp_man,
           do_hoy,
           do_man,
           da_hoy,
    da_man,
    pmnomprop,
           rut_empresa,
    rcnombre,
    'numero' = rsnumdocu ,
    'correla' = rscorrela,
    'serie' = rsinstser,
    'emisor' = (select emnombre from MDEM where emrut = rsrutemis),
    'fecemi' = convert(char(10),rsfecemis,103) ,
    'fecvenc' = convert(char(10),rsfecvcto,103),
    'tasaemi' = rstasemi,
    'baseemi' = rsbasemi,
    'moneda' = (select mnnemo from VIEW_MONEDA where rsmonemi = mncodmon),
    'nominal' = rsnominal,
    'tir'  = rstir ,
    '%'  = rsvpcomp,
    'valor_pres' = rsinteres + rsreajuste +rsvppresen ,
    'familia' = (select inserie from MDIN where rscodigo = incodigo),
    'hora' = convert(varchar(10),getdate(),108)    
           from MDRS ,#PARAMETROS,VIEW_ENTIDAD,MDDI
    where MDDI.codigo_carterasuper=@clave
   and (rstipcart = @entidad or @entidad = 0) 
   and (rsnumdocu=dinumdocu)
   and  rsfecha  = convert(char(10),pmfecproc,112)
 ) 
begin
 select    'pmfecproc' = convert(char(10),pmfecproc,103),
                  'pmfecprox' =convert(char(10),pmfecprox,103),
           uf_hoy,
           uf_man,
           ivp_hoy,
           ivp_man,
           do_hoy,
           do_man,
           da_hoy,
    da_man,
    pmnomprop,
           rut_empresa,
    rcnombre,
    'numero' = rsnumdocu ,
    'correla' =  rscorrela,
    'serie' = rsinstser,
    'emisor' = (select emnombre from MDEM where emrut = rsrutemis),
    'fecemi' =  convert(char(10),rsfecemis,103) ,
    'fecvenc' =  convert(char(10),rsfecvcto,103),
    'tasaemi' = rstasemi,
    'baseemi' = rsbasemi,
    'moneda' = (select mnnemo from VIEW_MONEDA where rsmonemi = mncodmon),
    'nominal' = rsnominal,
    'tir' = rstir ,
    '%'  = rsvpcomp,
    'valor_pres' = rsinteres + rsreajuste +rsvppresen ,
    'familia' = (select inserie from MDIN where rscodigo = incodigo),
    'hora' = convert(varchar(10),getdate(),108)    
           from MDRS ,#PARAMETROS,VIEW_ENTIDAD,MDDI
    where MDDI.codigo_carterasuper=@clave
   and (rstipcart = @entidad or @entidad = 0) 
   and (rsnumdocu=dinumdocu)
   and  rsfecha  = convert(char(10),pmfecproc,112)
end else begin
 select    'pmfecproc' ='',
                  'pmfecprox' ='',
           'uf_hoy'=uf_hoy,
           'uf_man'=uf_man,
           'ivp_hoy'=ivp_hoy,
           'ivp_man'=ivp_man,
           'do_hoy'=do_hoy,
           'do_man'=do_man,
           'da_hoy'=da_hoy,
    'da_man'=da_man,
    'pmnomprop'=pmnomprop,
           'rut_empresa'=rut_empresa,
    'rcnombre'=rcnombre,
    'numero' = 0 ,
    'correla' =  0,
    'serie' = '',
    'emisor' = '',
    'fecemi' =  '',
    'fecvenc' =  '',
    'tasaemi' = '',
    'baseemi' = '',
    'moneda' = '',
    'nominal' = 0,
    'tir' = 0 ,
    '%'  = 0,
    'valor_pres' = 0 ,
    'familia' = 0,
    'hora' = ''    
    from MDRS ,#PARAMETROS,VIEW_ENTIDAD,MDDI
    where MDDI.codigo_carterasuper=@clave
   and (rstipcart = @entidad or @entidad = 0) 
   and (rsnumdocu=dinumdocu)
   and  rsfecha  = convert(char(10),pmfecproc,112)
           end
end


GO
