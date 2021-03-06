USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_MARK_TO_MARKET]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_MARK_TO_MARKET]
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
if exists (select * from MDMM) begin
   select 
      'pmfecproc' = convert(char(10), pmfecproc, 103),
      'pmfecprox' = convert(char(10), pmfecprox, 103),
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
      'hora' = convert(varchar(10), getdate(), 108),
      mmfecini=convert(char(10), mmfecini,103),
      mmfecter=convert(char(10), mmfecter,103), 
      mminstser          ,
      mmmoneda           ,
      mmnominal          , 
      mmfecven=convert(char(10), mmfecven,103), 
      mmtirc             ,
      mmvptirc           ,
      mmtasarg           ,
      mmvalor            , 
      mmutil             , 
      mmtipoper          ,
      mmnomemp           , 
      mmrutemp           , 
      mmrango1           , 
      mmrango2           , 
      mmfecpro=convert(char(10), mmfecpro,103), 
      mmcodinst 
   from  #PARAMETROS,MDMM 
   order by mmtipoper end
else begin 
   select 
      'pmfecproc' = convert(char(10), pmfecproc, 103),
      'pmfecprox' = convert(char(10), pmfecprox, 103),
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
      'hora' = convert(varchar(10), getdate(), 108),
      'mmfecini'= '         ',
      'mmfecter'= '         ',
      'mminstser'= '         ',
      'mmmoneda' = '         ',
      'mmnominal' = '         ',
      'mmfecven'= ' ',
      'mmtirc' = '         ',
      'mmvptirc'= '         ',
      'mmtasarg'= '         ',
      'mmvalor' = '         ',
      'mmutil'  = '         ',
      'mmtipoper'= '         ',
      'mmnomemp' = '         ',
      'mmrutemp' = '         ',
      'mmrango1' = '         ',
      'mmrango2' = '         ',
      'mmfecpro'= '         ',
      'mmcodinst'= '         '
   from #PARAMETROS
end
end


GO
