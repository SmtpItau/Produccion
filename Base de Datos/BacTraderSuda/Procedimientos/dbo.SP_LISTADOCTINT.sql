USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCTINT]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOCTINT]
as
begin
   set nocount on
 declare @cont integer
       select 'nomemp'     = isnull( MDAC.acnomprop, ''),
              'rutemp'     = isnull(( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),
              'numdocu'    = rtrim(convert(char(10),MDVI.vinumdocu)) + '-' + rtrim(convert(char(03), MDVI.vicorrela)),
              'numoper'    = MDVI.vinumoper,
              'numdoc'     = MDVI.vinumdocu,
              'tipoper'    = MDVI.vitipoper,
              'correla'    = MDVI.vicorrela,
              'rutcart'    = MDVI.virutcart,
              'serie'      = space(12),
              'seriado'    = space(01),
              'fecemi'     = space(10),
              'fecven'     = space(10),
              'tasemi'     = convert(numeric(19,4),0),
              'basemi'     = convert(numeric(19,0),0),
              'monemi'     = space(05),
       'codser'    = 0,
              'codmon'     = 0,
       'familia'    = isnull(VIEW_INSTRUMENTO.inserie,''),
       'mascara'    = MDVI.vimascara,
              'nominal'    = convert(numeric(19,4),isnull(MDVI.vinominal,0)),
              'tir'        = convert(numeric(19,4),isnull(MDVI.vitirvent,0)),
              'pvp'        = convert(numeric(19,4),isnull(MDVI.vipvpvent,0)),
              'vpproc'     = convert(numeric(19,4),isnull(MDVI.vivptirv ,0)),
              'interes'    = convert(numeric(19,4),0),
              'reajus'     = convert(numeric(19,4),0),
              'vppproc'    = convert(numeric(19,4),0),
       'cartera'    = isnull(MDRC.rcnombre,'') 
       into   #TEMP1
       from   MDAC, MDVI, VIEW_INSTRUMENTO, VIEW_ENTIDAD MDRC
       where  MDVI.vitipoper = 'CI' and MDVI.vicodigo = VIEW_INSTRUMENTO.incodigo and MDVI.virutcart = MDRC.rcrut
       order by MDVI.vinumdocu,
                MDVI.vicorrela
     
     ----------------------------------------------------------------
     -- actualizamos serie desde la MDCP a la temporal             --
     ----------------------------------------------------------------
        update #TEMP1 set 
  serie   = MDCI.ciinstser,
                seriado = MDCI.ciseriado,
  codser  = MDCI.cicodigo
        from   MDCI
        where  numdoc    = MDCI.cinumdocu
        and    correla   = MDCI.cicorrela
-- update #TEMP1
-- set    familia = MDIN.inserie
-- from   #TEMP1, MDIN
-- where  #TEMP1.codser = MDIN.incodigo
     --------------------------------------------------------------------
     -- solo para compras propias cuando es seriado                    --
     -------------------------------------------------------------------- 
     -- actualizamos datos de la tabla de temporal con los datos de serie
     --------------------------------------------------------------------
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_SERIE.sefecemi,103),
              fecven     = convert(char(10),VIEW_SERIE.sefecven,103),
              tasemi     = VIEW_SERIE.setasemi,
              basemi     = VIEW_SERIE.sebasemi,
              codmon     = VIEW_SERIE.semonemi,
              monemi     = ''
       from   VIEW_SERIE
       where  seriado    = 'S'
       and    VIEW_SERIE.seserie = mascara
     ----------------------------------------------------------------
     -- solo para compras propias cuando no es seriado             --
     ---------------------------------------------------------------- 
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_NOSERIE.nsfecemi,103),
              fecven     = convert(char(10),VIEW_NOSERIE.nsfecven,103),  
              tasemi     = VIEW_NOSERIE.nstasemi,
              basemi     = VIEW_NOSERIE.nsbasemi,
              codmon     = VIEW_NOSERIE.nsmonemi,
              monemi     = ''
       from   VIEW_NOSERIE
       where  numoper    = VIEW_NOSERIE.nsnumdocu
       and    rutcart    = VIEW_NOSERIE.nsrutcart
       and    numdoc     = VIEW_NOSERIE.nsnumdocu 
       and    correla    = VIEW_NOSERIE.nscorrela
     ------------------------------------------------------
     --        actualizamos nemotecnico de moneda        --
     ------------------------------------------------------
      update #TEMP1 set monemi = substring(VIEW_MONEDA.mnnemo, 1, 3) 
      from   VIEW_MONEDA 
      where  codmon = VIEW_MONEDA.mncodmon 
     ------------------------------------------------
     -- actualizamos los datos del devengamiento
     ------------------------------------------------
      update #TEMP1 set interes = isnull(MDRS.rsinteres,0),
                        reajus  = isnull(MDRS.rsreajuste,0)
      from   MDRS
      where  numoper = MDRS.rsnumoper
      and    rutcart = MDRS.rsrutcart
      and    numdoc  = MDRS.rsnumdocu
      and    correla = MDRS.rscorrela
     ----------------------------------------------------- 
     -- sumatoria de valor de proximo proceso
     -----------------------------------------------------
      update #TEMP1 set vppproc = interes + reajus + vpproc
      select nomemp,
             rutemp,
             fecpro,
             fecppro,
             numdocu,
             serie,
             fecemi,
             fecven,
             tasemi,
             basemi,
             monemi,
             nominal,
             tir,
             pvp,
             vpproc,
             interes,
             reajus,
             vppproc,
      familia,
      cartera
       from #TEMP1
   set nocount off
      select 'OK'
end


GO
