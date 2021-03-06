USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOINFVAL]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOINFVAL]  with recompile
  as
  begin
      
       select 'nomemp'     = isnull( MDAC.acnomprop, ''), 
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),
              'numdoc'     = isnull( MDDI.dinumdocuo, 0),
              'rutcart'    = isnull( MDDI.dirutcart,0),
              'correla'    = isnull( MDDI.dicorrelao, 0),
              'numdocu'    = rtrim(convert(char(10),isnull( MDDI.dinumdocuo, 0))) +'-'+ convert(char(3),isnull( MDDI.dicorrelao, 0)), 
              'tipoper'    = isnull( MDDI.ditipoper,''),
              'serie'      = isnull( MDDI.diinstser, ''),
              'seriado'    = space(01),
              'fecemi'     = space(10),
              'fecven'     = space(10),
              'tasemi'     = convert(numeric(19,4),0),
              'basemi'     = convert(numeric(03,0),0),
              'monemi'     = space(5),
              'codmon'     = 0,
       'codser'     = 0,
       'familia'    = space(12),
       'largo_util' = 0,
              'nominal'    = isnull(convert(numeric(19,4), MDDI.dinominal),0),
              'pvpmcd'     = isnull(convert(numeric(19,4), MDDI.dipvpmcd ),0),
              'tirmcd'     = isnull(convert(numeric(19,4), MDDI.ditirmcd ),0),
              'vptirc'     = isnull(convert(numeric(19,4), MDDI.divptirc ),0),
              'vpmcd'      = isnull(convert(numeric(19,4), MDDI.divpmcd  ),0),
              'difmcdo'    = isnull( MDDI.divptirc,0) - isnull( MDDI.divpmcd,0)
        into   #TEMP1
        from   MDAC, MDDI
 where ( MDDI.ditipoper= 'CP' or MDDI.ditipoper= 'CI' ) and MDDI.dinominal > 0
     -------------------------------------------------
     -- actualizamos el campo seriado de la temporal
     -------------------------------------------------
     -- solo ci
     -----------------------------------------------
     update #TEMP1 set seriado = MDCI.ciseriado,
         codser  = MDCI.cicodigo
     from  MDCI
     where tipoper        = 'CI'
     and   MDCI.cirutcart = rutcart
     and   MDCI.cinumdocu = numdoc
     and   MDCI.cicorrela = correla
     -----------------------------------------------
     -- solo cp
     -----------------------------------------------
     update #TEMP1 set  seriado = MDCP.cpseriado,
   codser  = MDCP.cpcodigo
     from  MDCP
     where tipoper        = 'CP'
     and   MDCP.cprutcart = rutcart
     and   MDCP.cpnumdocu = numdoc
     and   MDCP.cpcorrela = correla
 update #TEMP1
 set   familia = VIEW_INSTRUMENTO.inserie
 from  #TEMP1, VIEW_INSTRUMENTO
 where #TEMP1.codser = VIEW_INSTRUMENTO.incodigo
 update #TEMP1
 set   largo_util = datalength( MDMS.msmascara)
 from  #TEMP1, VIEW_MASCARA_INSTRUMENTO MDMS
 where #TEMP1.familia = MDMS.msfamilia 
     --------------------------------------------------------------------
     -- solo cuando es seriado                                         --
     --------------------------------------------------------------------         
     -- actualizamos datos de la tabla de temporal con los datos de serie
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_SERIE.sefecemi,103),
              fecven     = convert(char(10),VIEW_SERIE.sefecven,103),  
              tasemi     = isnull(VIEW_SERIE.setasemi,0),
              basemi     = isnull(VIEW_SERIE.sebasemi,0),
              codmon     = VIEW_SERIE.semonemi,
              monemi     = ''
       from   VIEW_SERIE
       where  seriado    = 'S'
       and    substring(serie,1,#TEMP1.largo_util) = VIEW_SERIE.seserie
     --------------------------------------------------------------------
     -- solo cuando no es seriado                                      --
     --------------------------------------------------------------------         
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_NOSERIE.nsfecemi,103),
              fecven     = convert(char(10),VIEW_NOSERIE.nsfecven,103),  
              tasemi     = isnull(VIEW_NOSERIE.nstasemi,0),
              basemi     = isnull(VIEW_NOSERIE.nsbasemi,0),
              codmon     = VIEW_NOSERIE.nsmonemi,
              monemi     = ''
       from   VIEW_NOSERIE
       where  seriado    <> 'S'
       and    rutcart    = VIEW_NOSERIE.nsrutcart
       and    numdoc     = VIEW_NOSERIE.nsnumdocu 
       and    correla    = VIEW_NOSERIE.nscorrela
      ------------------------------------------------------
      --        actualizamos nemot'cnico de moneda        --
      ------------------------------------------------------
      update #TEMP1 set monemi = isnull(VIEW_MONEDA.mnnemo,'')
      from   VIEW_MONEDA 
      where  codmon = VIEW_MONEDA.mncodmon
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
      tipoper,
             nominal,
             pvpmcd,
             tirmcd,
             vptirc,
             vpmcd,
             difmcdo
       from  #TEMP1
       order by tipoper, numdoc, correla
end


GO
