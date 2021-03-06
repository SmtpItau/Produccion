USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCTDIS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOCTDIS]
as
begin
      
 declare @cont integer
      
       select 'nomemp'     = isnull( MDAC.acnomprop, ''), 
              'rutemp'     = isnull((rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),
              'numdoc'     = isnull( MDDI.dinumdocuo,0),
              'rutcart'    = isnull( MDDI.dirutcart, 0),
              'correla'    = isnull( MDDI.dicorrelao,0),
              'numdocu'    = rtrim(convert(char(10),isnull(MDDI.dinumdocuo, 0))) +'-'+ convert(char(3),isnull( MDDI.dicorrelao, 0)),
              'tipoper'    = isnull( MDDI.ditipoper,''),
              'serie'      = isnull( MDDI.diinstser,''),
              'seriado'    = space(01),
       'codser'     = 0,
       'familia'    = space(12),
       'mascara'    = space(12),
              'fecemi'     = space(10),
              'fecven'     = space(10),
              'tasemi'     = convert(numeric(19,4),0),
              'basemi'     = 0,
              'monemi'     = space(12),
              'codmon'     = 0,
              'nominal'    = convert(numeric(19,4),MDDI.dinominal),
              'tir'        = convert(numeric(19,4),MDDI.ditircomp),
              'pvp'        = convert(numeric(19,4),MDDI.dipvpcomp),
              'vpproc'     = convert(numeric(19,4),MDDI.divptirc),
       'cartera'    = isnull(MDRC.rcnombre,'')
       into   #TEMP1
       from   MDAC, MDDI, VIEW_ENTIDAD MDRC
       where  MDDI.ditipoper = 'ci' and MDDI.dinominal > 0 and MDDI.dirutcart = MDRC.rcrut
     -----------------------------------------------
     -- actualizamos el campo seriado de la temporal
     -----------------------------------------------
     -- solo ci
     ------------------------------------------------
      update #TEMP1 set 
  seriado = MDCI.ciseriado ,
  codser  = MDCI.cicodigo,
  mascara = MDCI.cimascara
      from  MDCI
      where tipoper        = 'CI'
      and   MDCI.cirutcart = rutcart
      and   MDCI.cinumdocu = numdoc
      and   MDCI.cicorrela = correla
 update #TEMP1
 set   familia = VIEW_INSTRUMENTO.inserie
 from  #TEMP1, VIEW_INSTRUMENTO
 where #TEMP1.codser = VIEW_INSTRUMENTO.incodigo
     --------------------------------------------------------------------
     -- solo para compras con pacto cuando es seriado                  --
     --------------------------------------------------------------------         
     -- actualizamos datos de la tabla de temporal con los datos de serie
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_SERIE.sefecemi,103),
              fecven     = convert(char(10),VIEW_SERIE.sefecven,103),  
              tasemi     = VIEW_SERIE.setasemi,
              basemi     = VIEW_SERIE.sebasemi,
              codmon     = VIEW_SERIE.semonemi,
              monemi     = ''
       from   VIEW_SERIE
       where  seriado    = 'S'
       and    tipoper    = 'CI'
       and    VIEW_SERIE.seserie = mascara
     --------------------------------------------------------------------
     -- solo para compras con pacto cuando no es seriado               --
     --------------------------------------------------------------------         
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_NOSERIE.nsfecemi,103),
              fecven     = convert(char(10),VIEW_NOSERIE.nsfecven,103),  
              tasemi     = isnull(VIEW_NOSERIE.nstasemi,0),
              basemi     = isnull(VIEW_NOSERIE.nsbasemi,0),
              codmon     = VIEW_NOSERIE.nsmonemi,
              monemi     = ''
       from   VIEW_NOSERIE, MDCI
       where  seriado    <> 'S'
       and    tipoper    = 'CI'
       and    rutcart    = VIEW_NOSERIE.nsrutcart
       and    numdoc     = VIEW_NOSERIE.nsnumdocu 
       and    correla    = VIEW_NOSERIE.nscorrela
     ------------------------------------------------------
     --        actualizamos nemotecnico de moneda        --
     ------------------------------------------------------
      update #TEMP1 set monemi = substring(VIEW_MONEDA.mnnemo, 1, 3)
      from   VIEW_MONEDA 
      where  codmon = VIEW_MONEDA.mncodmon 
      select * into #TEMP2 from #TEMP1
      order by #TEMP1.numdoc, #TEMP1.correla
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
      familia,
      cartera
       from  #TEMP2
end


GO
