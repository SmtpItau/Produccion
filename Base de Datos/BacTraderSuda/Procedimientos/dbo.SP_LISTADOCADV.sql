USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCADV]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LISTADOCADV]
  as
  begin
      
        select 'nomemp'     = isnull( MDAC.acnomprop, ''),
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),
              'numdocu'    = rtrim(convert(char(10),MDCI.cinumdocu)) + '-' + rtrim(convert(char(03), MDCI.cicorrela)),
              'numdoc'     = MDCI.cinumdocu,
              'correla'    = MDCI.cicorrela,
              'rutcart'    = MDCI.cirutcart,
              'seriado'    = MDCI.ciseriado,  
              'serie'      = MDCI.ciinstser,
       'familia'    = isnull(inserie,''),
       'largo_util' = 0,
              'fecemi'     = convert(char(10), MDCI.cifecinip, 103),
              'fecven'     = convert(char(10), MDCI.cifecvenp, 103),
       'codser'    = MDCI.cicodigo,
              'tasemi'     = MDCI.citaspact,
              'basemi'     = MDCI.cibaspact,
              'monemi'     = space(5),
              'codmon'     = MDCI.cimonpact,
              'nominal'    = MDCI.cinominal,
              'tir'        = MDCI.citircomp,
              'pvp'        = MDCI.cipvpcomp,
              'mtocom'     = MDCI.civalcomp,        
              'vpproc'     = MDCI.cicapitalci,
              'interes'    = MDCI.ciinteresci,
              'reajus'     = MDCI.cireajustci,
              'vppproc'    = convert(numeric(19,4),0),
       'cartera'    = isnull(MDRC.rcnombre,''),
              'valvenp'    = MDCI.civalvenp
        into   #TEMP1
        from   MDAC, MDCI, VIEW_INSTRUMENTO, VIEW_ENTIDAD MDRC
 where  MDCI.ciinstser <> 'ICAP' and MDCI.ciinstser <> 'ICOL' and MDCI.cicodigo=VIEW_INSTRUMENTO.incodigo
  and MDCI.cirutcart = MDRC.rcrut
     ----------------------------------------------------------------
     -- solo para compras con pacto cuando es seriado              --
     ---------------------------------------------------------------- 
     -- actualizamos datos de la tabla de temporal con los datos de serie
       update #TEMP1 set
              #TEMP1.fecemi     = convert(char(10),VIEW_SERIE.sefecemi,103),
              #TEMP1.fecven     = convert(char(10),VIEW_SERIE.sefecven,103)
       from   VIEW_SERIE 
       where  #TEMP1.seriado    = 'S'
       and    substring(#TEMP1.serie,1,#TEMP1.largo_util) = VIEW_SERIE.seserie
     ----------------------------------------------------------------
     -- solo para compras propias cuando no es seriado             --
     ---------------------------------------------------------------- 
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_NOSERIE.nsfecemi,103),
              fecven     = convert(char(10),VIEW_NOSERIE.nsfecven,103)
       from   VIEW_NOSERIE
       where  rutcart    = VIEW_NOSERIE.nsrutcart
       and    numdoc     = VIEW_NOSERIE.nsnumdocu 
       and    correla    = VIEW_NOSERIE.nscorrela
       and    codser     = VIEW_NOSERIE.nscodigo
       and    seriado    = 'N'
       ------------------------------------------------------
       --        actualizamos nemotecnico de moneda        --
       ------------------------------------------------------
       update #TEMP1 
       set #TEMP1.monemi = isnull(VIEW_MONEDA.mnnemo,'')
       from   VIEW_MONEDA, #TEMP1 
       where  #TEMP1.codmon =  VIEW_MONEDA.mncodmon 
       ------------------------------------------------------
       -- actualizamos los datos del devengamiento
       ------------------------------------------------------
       update #TEMP1 set reajus  = reajus - isnull(MDRS.rsreajuste,0)
       from   MDRS
       where  rutcart = MDRS.rsrutcart
       and    numdoc  = MDRS.rsnumdocu
       and    correla = MDRS.rscorrela
       and    MDRS.rscartera = '112'
       ----------------------------------------------------- 
       -- sumatoria de valor de proximo proceso
       -----------------------------------------------------
       update #TEMP1 set vppproc = interes + reajus + vpproc
 
       select  nomemp,
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
               mtocom,
               vpproc,
               interes,
               reajus,
               vppproc,
        familia,
        cartera,
        valvenp
       from   #TEMP1
       order by #TEMP1.numdoc, #TEMP1.correla
end
--select * from MDMS
-- select * from MDIN
-- select * from MDSE
--   where  seserie='estx20'
-- select * from VIEW_NOSERIE
-- select * from MDCI
-- dump transaction master with no_log
-- select * from VIEW_MONEDA
-- sp_helptext sp_listadocadv


GO
