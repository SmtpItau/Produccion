USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCPINT]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOCPINT]
            (@entidad numeric(10))
as
begin
set nocount on
if @entidad = 0 
 begin
       select 'nomemp'    = isnull( MDAC.acnomprop, ''),
              'rutemp'    = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'    = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'   = convert(char(10), MDAC.acfecprox, 103),
              'numdocu'   = rtrim(convert(char(10),MDVI.vinumdocu)) + '-' + rtrim(convert(char(03), MDVI.vicorrela)) + '-' + rtrim(convert(char(10),MDVI.vinumoper)),
              'numoper'   = MDVI.vinumoper,
              'numdoc'    = MDVI.vinumdocu,
              'tipoper'   = MDVI.vitipoper,
              'correla'   = MDVI.vicorrela,
              'rutcart'   = MDVI.virutcart,
              'serie'     = space(12),
              'seriado'   = space(01),
              'fecemi'    = space(10),
              'fecven'    = space(10),
       'familia'   = isnull(VIEW_INSTRUMENTO.inserie,''),
       'largo_util'= 0,
       'codser'    = 0,
              'tasemi'    = 0,
              'basemi'    = 0,
              'monemi'    = space(05),
              'codmon'    = 0,
              'nominal'   = isnull(MDVI.vinominal,0),
              'tir'       = isnull(MDVI.vitirvent,0),
              'pvp'       = isnull(MDVI.vipvpvent,0),
              'vpproc'    = isnull(MDVI.vicapitalv,0),
              'interes'   = isnull(MDVI.viinteresv,0),
              'reajus'    = isnull(MDVI.vireajustv,0),
              'vppproc'   = convert(numeric(19,4),0),
              'entidad'   = (select rcnombre where rcrut = MDVI.virutcart) 
       into   #TEMP1
       from   MDAC, MDVI, VIEW_INSTRUMENTO, VIEW_ENTIDAD MDRC
       where  MDVI.vitipoper = 'CP' and MDVI.vicodigo = VIEW_INSTRUMENTO.incodigo 
       order by MDVI.vinumdocu, MDVI.vicorrela
     
     ----------------------------------------------------------------
     -- actualizamos serie desde la MDCP a la temporal             --
     ----------------------------------------------------------------
        update #TEMP1 set 
  serie   = MDCP.cpinstser,
                seriado = MDCP.cpseriado,
  codser  = MDCP.cpcodigo
        from   MDCP
        where  numdoc  = MDCP.cpnumdocu
        and    correla = MDCP.cpcorrela
     --------------------------------------------------------------------
     -- solo para compras propias cuando es seriado                    --
     -------------------------------------------------------------------- 
     -- actualizamos datos de la tabla de temporal con los datos de serie     
     --------------------------------------------------------------------
       update #TEMP1 set
              fecemi     = convert(char(10), VIEW_SERIE.sefecemi,103),
              fecven     = convert(char(10), VIEW_SERIE.sefecven,103),  
              tasemi     = VIEW_SERIE.setasemi,
              basemi     = VIEW_SERIE.sebasemi,
              codmon     = VIEW_SERIE.semonemi,
              monemi     = ''
       from   VIEW_SERIE
       where  seriado    = 'S'
       and    substring(#TEMP1.serie,1,#TEMP1.largo_util) = VIEW_SERIE.seserie
 
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
--      update #TEMP1 set reajus  = reajus - isnull(MDRS.rsreajuste,0)
--      from   MDRS
--      where  MDRS.rscartera = '114'
--      and    numoper = MDRS.rsnumoper
--      and    rutcart = MDRS.rsrutcart
--      and    numdoc  = MDRS.rsnumdocu
--      and    correla = MDRS.rscorrela
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
              entidad
       from   #TEMP1
 end
 else
  begin
      select  'nomemp'    = isnull( MDAC.acnomprop, ''),
              'rutemp'    = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'    = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'   = convert(char(10), MDAC.acfecprox, 103),
              'numdocu'   = rtrim(convert(char(10),MDVI.vinumdocu)) + '-' + rtrim(convert(char(03), MDVI.vicorrela)) + '-' + rtrim(convert(char(10),MDVI.vinumoper)),
              'numoper'   = MDVI.vinumoper,
              'numdoc'    = MDVI.vinumdocu,
              'tipoper'   = MDVI.vitipoper,
              'correla'   = MDVI.vicorrela,
              'rutcart'   = MDVI.virutcart,
              'serie'     = space(12),
              'seriado'   = space(01),
              'fecemi'    = space(10),
              'fecven'    = space(10),
       'familia'   = isnull(VIEW_INSTRUMENTO.inserie,''),
       'largo_util'= 0,
       'codser'    = 0,
              'tasemi'    = 0,
              'basemi'    = 0,
              'monemi'    = space(05),
              'codmon'    = 0,
              'nominal'   = isnull(MDVI.vinominal,0),
              'tir'       = isnull(MDVI.vitirvent,0),
              'pvp'       = isnull(MDVI.vipvpvent,0),
              'vpproc'    = isnull(MDVI.vicapitalv,0),
              'interes'   = isnull(MDVI.viinteresv,0),
              'reajus'    = isnull(MDVI.vireajustv,0),
              'vppproc'   = convert(numeric(19,4),0),
       'entidad'   = (select rcnombre where rcrut = MDVI.virutcart)
       into   #TEMP2 
       from   MDAC, MDVI, VIEW_INSTRUMENTO, VIEW_ENTIDAD MDRC
       where  MDVI.vitipoper = 'CP' and MDVI.vicodigo = VIEW_INSTRUMENTO.incodigo and MDVI.virutcart = @entidad
       order by MDVI.vinumdocu, MDVI.vicorrela
     
     ----------------------------------------------------------------
     -- actualizamos serie desde la MDCP a la temporal             --
     ----------------------------------------------------------------
        update #TEMP2 set 
  serie   = MDCP.cpinstser,
                seriado = MDCP.cpseriado,
  codser  = MDCP.cpcodigo
        from   MDCP
        where  numdoc  = MDCP.cpnumdocu
        and    correla = MDCP.cpcorrela
     --------------------------------------------------------------------
     -- solo para compras propias cuando es seriado                    --
     -------------------------------------------------------------------- 
     -- actualizamos datos de la tabla de temporal con los datos de serie     
     --------------------------------------------------------------------
       update #TEMP2 set
              fecemi = convert(char(10),VIEW_SERIE.sefecemi,103),
              fecven     = convert(char(10),VIEW_SERIE.sefecven,103),  
              tasemi     = VIEW_SERIE.setasemi,
              basemi     = VIEW_SERIE.sebasemi,
              codmon     = VIEW_SERIE.semonemi,
              monemi     = ''
       from   VIEW_SERIE
       where  seriado    = 'S'
       and    substring(#TEMP2.serie,1,#TEMP2.largo_util) = VIEW_SERIE.seserie
 
     ----------------------------------------------------------------
     -- solo para compras propias cuando no es seriado             --
     ---------------------------------------------------------------- 
       update #TEMP2 set
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
      update #TEMP2 set monemi = substring(VIEW_MONEDA.mnnemo, 1, 3) 
      from   VIEW_MONEDA
      where  codmon = VIEW_MONEDA.mncodmon 
     ------------------------------------------------
     -- actualizamos los datos del devengamiento
     ------------------------------------------------
--      update #TEMP1 set reajus  = reajus - isnull(MDRS.rsreajuste,0)
--      from   MDRS
--      where  MDRS.rscartera = '114'
--      and    numoper = MDRS.rsnumoper
--      and    rutcart = MDRS.rsrutcart
--      and    numdoc  = MDRS.rsnumdocu
--      and    correla = MDRS.rscorrela
     ----------------------------------------------------- 
     -- sumatoria de valor de proximo proceso
     -----------------------------------------------------
       update #TEMP2 set vppproc = interes + reajus + vpproc
      set nocount off
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
              entidad
       from   #TEMP2
    
  end
end


GO
