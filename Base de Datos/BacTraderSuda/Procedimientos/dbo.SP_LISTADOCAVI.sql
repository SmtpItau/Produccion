USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCAVI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LISTADOCAVI]
            (@entidad numeric(10))
as
begin
      set nocount on
if @entidad = 0
  begin
      select  'nomemp'     = isnull( MDAC.acnomprop, ''),
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),
              'numdocu'    = rtrim(convert(char(10),MDVI.vinumdocu)) + '-' + rtrim(convert(char(03), MDVI.vicorrela)),
              'numdoc'     = MDVI.vinumdocu,
              'numoper'    = MDVI.vinumoper,
              'correla'    = MDVI.vicorrela,
              'rutcart'    = MDVI.virutcart,
              'seriado'    = isnull(MDVI.viseriado,''),  
              'serie'      = isnull(MDVI.viinstser,''),
			  'familia'    = isnull( inserie,''),
			  'largo_util' = 0,
              'fecemi'     = space(10),
              'fecven'     = space(10),
              'codser'     = MDVI.vicodigo,
              'tasemi'     = MDVI.vitaspact,
              'basemi'     = MDVI.vibaspact,
              'monemi'     = space(5),
              'codmon'     = MDVI.vimonpact,
              'nominal'    = MDVI.vinominal,
              'tir'        = MDVI.vitaspact,
              'pvp'        = MDVI.vipvpvent,
              'mtocom'     = MDVI.vivalvent,        
              'vpproc'     = MDVI.vicapitalvi,
              'interes'    = MDVI.viinteresvi,
              'reajus'     = MDVI.vireajustvi,
              'vppproc'    = convert(numeric(19,4),0),
              'fecinip'    = convert(char(10), MDVI.vifecinip, 103),
              'fecvenp'    = convert(char(10), MDVI.vifecvenp, 103),
			   'cartera'    = isnull((select rcnombre from VIEW_ENTIDAD MDRC where rcrut = @entidad),''),
			   'valven'     = MDVI.vivalvenp
        into   #TEMP1
        from   MDAC, MDVI, VIEW_INSTRUMENTO, VIEW_ENTIDAD
        where  MDVI.vicodigo = VIEW_INSTRUMENTO.incodigo
 
 update #TEMP1
 set   familia = VIEW_INSTRUMENTO.inserie
 from  #TEMP1, VIEW_INSTRUMENTO
 where #TEMP1.codser = VIEW_INSTRUMENTO.incodigo
 update #TEMP1
 set   largo_util = datalength( VIEW_MASCARA_INSTRUMENTO.msmascara)
 from  #TEMP1, VIEW_MASCARA_INSTRUMENTO
 where #TEMP1.familia = VIEW_MASCARA_INSTRUMENTO.msfamilia
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
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_NOSERIE.nsfecemi,103),
              fecven     = convert(char(10),VIEW_NOSERIE.nsfecven,103)  
       from   VIEW_NOSERIE
       where  rutcart    = VIEW_NOSERIE.nsrutcart
       and    numdoc     = VIEW_NOSERIE.nsnumdocu 
       and    correla    = VIEW_NOSERIE.nscorrela
       and    codser     = VIEW_NOSERIE.nscodigo
       and    seriado    <> 'S'
       ------------------------------------------------------
       --        actualizamos nemotecnico de moneda        --
       ------------------------------------------------------
       update #TEMP1 
       set #TEMP1.monemi = isnull( VIEW_MONEDA.mnnemo,'')
       from   VIEW_MONEDA, #TEMP1 
       where  #TEMP1.codmon =  VIEW_MONEDA.mncodmon 
       ------------------------------------------------------
       -- actualizamos los datos del devengamiento
       ------------------------------------------------------
--       update #TEMP1 set reajus  = reajus - isnull(MDRS.rsreajuste,0)
--       from   MDRS
--       where  rutcart = MDRS.rsrutcart
--       and    numdoc  = MDRS.rsnumdocu
--       and    numoper = MDRS.rsnumoper
--       and    correla = MDRS.rscorrela
--       and MDRS.rscartera = '115'
       update #TEMP1 set vppproc = vpproc + interes + reajus
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
               fecinip,
               fecvenp,
               familia,
        cartera,
               valven
       from   #TEMP1
end
else
  begin
      select  'nomemp'     = isnull( MDAC.acnomprop, ''),
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),
              'numdocu'    = rtrim(convert(char(10),MDVI.vinumdocu)) + '-' + rtrim(convert(char(03), MDVI.vicorrela)),
              'numdoc'     = MDVI.vinumdocu,
			  'numoper'    = MDVI.vinumoper,
              'correla'    = MDVI.vicorrela,
              'rutcart'    = MDVI.virutcart,
              'seriado'    = isnull(MDVI.viseriado,''),  
              'serie'      = isnull(MDVI.viinstser,''),
			  'familia'    = isnull(inserie,''),
			  'largo_util' = 0,
              'fecemi'     = space(10),
              'fecven'     = space(10),
			  'codser'    = MDVI.vicodigo,
              'tasemi'     = MDVI.vitaspact,
              'basemi'     = MDVI.vibaspact,
              'monemi'     = space(5),
              'codmon'     = MDVI.vimonpact,
              'nominal'    = MDVI.vinominal,
              'tir'        = MDVI.vitaspact,
              'pvp'        = MDVI.vipvpvent,
              'mtocom'     = MDVI.vivalvent,        
              'vpproc'     = MDVI.vicapitalvi,
              'interes'    = MDVI.viinteresvi,
              'reajus'     = MDVI.vireajustvi,
              'vppproc'    = convert(numeric(19,4),0),
              'fecinip'    = convert(char(10), MDVI.vifecinip, 103),
              'fecvenp'    = convert(char(10), MDVI.vifecvenp, 103),
			  'cartera'    = isnull((select rcnombre from VIEW_ENTIDAD where rcrut = @entidad),''),
			  'valven'     = MDVI.vivalvenp
        into   #TEMP2
        from   MDAC, MDVI, VIEW_INSTRUMENTO, VIEW_ENTIDAD MDRC
        where  MDVI.vicodigo = VIEW_INSTRUMENTO.incodigo and MDVI.virutcart = @entidad
 
 update #TEMP2
 set   familia = VIEW_INSTRUMENTO.inserie
 from  #TEMP2, VIEW_INSTRUMENTO
 where #TEMP2.codser = VIEW_INSTRUMENTO.incodigo
 update #TEMP2
 set   largo_util = datalength( VIEW_MASCARA_INSTRUMENTO.msmascara)
 from  #TEMP2, VIEW_MASCARA_INSTRUMENTO
 where #TEMP2.familia = VIEW_MASCARA_INSTRUMENTO.msfamilia
     ----------------------------------------------------------------
     -- solo para compras con pacto cuando es seriado              --
     ---------------------------------------------------------------- 
     -- actualizamos datos de la tabla de temporal con los datos de serie
       update #TEMP2 set
              #TEMP2.fecemi     = convert(char(10),VIEW_SERIE.sefecemi,103),
              #TEMP2.fecven     = convert(char(10),VIEW_SERIE.sefecven,103)  
       from   VIEW_SERIE 
       where  #TEMP2.seriado    = 'S'
       and    substring(#TEMP2.serie,1,#TEMP2.largo_util) = VIEW_SERIE.seserie
       update #TEMP2 set
              fecemi     = convert(char(10),VIEW_NOSERIE.nsfecemi,103),
              fecven     = convert(char(10),VIEW_NOSERIE.nsfecven,103)  
       from   VIEW_NOSERIE
       where  rutcart    = VIEW_NOSERIE.nsrutcart
       and    numdoc     = VIEW_NOSERIE.nsnumdocu 
       and    correla    = VIEW_NOSERIE.nscorrela
       and    codser     = VIEW_NOSERIE.nscodigo
       and    seriado    <> 'S'
       ------------------------------------------------------
       --        actualizamos nemotecnico de moneda        --
       ------------------------------------------------------
       update #TEMP2 
       set #TEMP2.monemi = isnull(VIEW_MONEDA.mnnemo,'')
       from   VIEW_MONEDA, #TEMP2 
       where  #TEMP2.codmon =  VIEW_MONEDA.mncodmon 
       ------------------------------------------------------
       -- actualizamos los datos del devengamiento
       ------------------------------------------------------
--       update #TEMP1 set reajus  = reajus - isnull(MDRS.rsreajuste,0)
--       from   MDRS
--       where  rutcart = MDRS.rsrutcart
--       and    numdoc  = MDRS.rsnumdocu
--       and    numoper = MDRS.rsnumoper
--       and    correla = MDRS.rscorrela
--       and    MDRS.rscartera = '115'
       update #TEMP2 set vppproc = vpproc + interes + reajus
      
      set nocount off
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
               fecinip,
               fecvenp,
               familia,
        cartera,
               valven
       from   #TEMP2
  end   
end
-- select * from MDVI
-- sp_listadocavi
--sp_listadocavi 1


GO
