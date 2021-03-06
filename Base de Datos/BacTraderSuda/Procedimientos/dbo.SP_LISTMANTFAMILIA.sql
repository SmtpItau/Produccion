USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTMANTFAMILIA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTMANTFAMILIA]
 as
 begin
      select acfecproc,
             acfecprox,
             'uf_hoy'    = convert(float, 0),
             'uf_man'    = convert(float, 0),
             'ivp_hoy'   = convert(float, 0),
             'ivp_man'   = convert(float, 0),
             'do_hoy'    = convert(float, 0),
             'do_man'    = convert(float, 0),
             'da_hoy'    = convert(float, 0),
             'da_man'    = convert(float, 0),
             acnomprop,
             'rut_empresa' = rtrim(convert(char(10),acrutprop)) + '-' + acdigprop
        into 
             #PARAMETROS
        from 
             MDAC
      /* rescata valor de uf -------------------------------------------------------------- */
      update #PARAMETROS set uf_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
      update #PARAMETROS set uf_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 998
      /* rescata valor de ivp ------------------------------------------------------------- */
      update #PARAMETROS set ivp_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
      update #PARAMETROS set ivp_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 997
      /* rescata valor de do -------------------------------------------------------------- */
      update #PARAMETROS set do_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
      update #PARAMETROS set do_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 994
      /* rescata valor de da -------------------------------------------------------------- */
      update #PARAMETROS set da_hoy = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
      update #PARAMETROS set da_man = isnull(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                  from VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                 where VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                   and VIEW_VALOR_MONEDA.vmcodigo = 995
         select
             'NOMEMP'     = isnull( MDAC.acnomprop, ''),
             'RUTEMP'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
             'FECPRO'     = convert(char(10), MDAC.acfecproc, 103),
             'CODIGO'     = isnull(VIEW_INSTRUMENTO.incodigo,0),
             'SERIE'      = isnull(VIEW_INSTRUMENTO.inserie,''),
             'GLOSA'      = isnull(VIEW_INSTRUMENTO.inglosa,''),
             'RUTEMISOR'  = isnull(VIEW_INSTRUMENTO.inrutemi,0),
             'RUTEMI'     = space(11),
             'NOMEMI'     = space(40),
             'CODMON'     = isnull(VIEW_INSTRUMENTO.inmonemi,0),
             'MONEMI'     = space(5),
             'DESMONEMI'  = space(40),              
      'BASEMI'     = isnull(VIEW_INSTRUMENTO.inbasemi,0),
             'PROG'       = isnull(VIEW_INSTRUMENTO.inprog,''),
             'REFNOMINAL' = isnull(VIEW_INSTRUMENTO.inrefnomi,''),
             'MDSE'       = isnull(VIEW_INSTRUMENTO.inMDSE,''),
             'MDTD'       = isnull(VIEW_INSTRUMENTO.inmdtd,''),
             'MDPR'       = isnull(VIEW_INSTRUMENTO.inMDPR,'')
         into #TEMP from MDAC, VIEW_INSTRUMENTO order by VIEW_INSTRUMENTO.inserie
  update #TEMP set rutemi    =  convert(char(9),isnull(MDEM.emrut,0)) +'-' + isnull(MDEM.emdv,''),nomemi    =  isnull(MDEM.emnombre,'')
                from VIEW_EMISOR MDEM where #TEMP.rutemisor = MDEM.emrut
     
         update #TEMP set monemi    =  isnull(VIEW_MONEDA.mnnemo,''), desmonemi =  isnull(VIEW_MONEDA.mnglosa,''),basemi    =  isnull(VIEW_MONEDA.mnbase,0)     
                from VIEW_CLIENTE, VIEW_MONEDA where #TEMP.codmon    = VIEW_MONEDA.mncodmon
      select 'acfecproc' = convert(char(10), acfecproc, 103),
             'acfecprox' = convert(char(10), acfecprox, 103),
             uf_hoy,
             uf_man,
             ivp_hoy,
             ivp_man,
             do_hoy,
             do_man,
             da_hoy,
             da_man,
             acnomprop,
             rut_empresa,
             'hora' = convert(varchar(10), getdate(), 108),
             nomemp,
             rutemp,
             fecpro,
             codigo,
             serie,
             glosa,
             rutemi,
             nomemi,
             codmon,
             monemi,
             desmonemi,
             basemi,
             prog,
             refnominal,
             MDSE,
             VIEW_TABLA_DESARROLLO,
             MDPR
         from #TEMP, #PARAMETROS 
 end
-- sp_listmantfamilia


GO
