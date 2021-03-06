USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFCTD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFCTD]
  as
  begin
set nocount on
      
     -- definiciones de variables
     --------------------------------
        declare @carchivo varchar(30)
        declare @cbuffer  varchar(255)
        declare @cexecute varchar(200)
        declare @user     varchar(100)
        select @user   = 'Sp_Infctd'
        select @carchivo = ltrim( @user ) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,12 ,1,'_' )
        select @carchivo = stuff( @carchivo,15,1,'_' )
        select @carchivo = stuff( @carchivo,18,1,'_' )
        select @carchivo = ltrim( @carchivo )
        select @cbuffer  = 'select * into ' + @carchivo  + ' from #TEMP4'
     ---------------------------------------------------
     -- seleccionamos todos los campos de la tabla MDDI
     ---------------------------------------------------
       SELECT 'NOMEMP'     = 'B,' + isnull( MDAC.acnomprop, ''), 
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'fecpro1'    = convert(char(10), MDAC.acfecproc, 103),
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),
              'numdoc'     = isnull( MDDI.dinumdocuo, 0),
              'rutcart'    = isnull(MDDI.dirutcart,0),
              'correla'    = isnull( MDDI.dicorrelao, 0),
              'numdocu'    = rtrim(convert(char(10),isnull( MDDI.dinumdocuo, 0))) +'-'+ convert(char(3),isnull( MDDI.dicorrelao, 0)), 
              'tipoper'    = MDDI.ditipoper,
              'serie'      = isnull( MDDI.diinstser, ''),
              'seriado'    = space(01),
              'fecemi'     = space(10),
              'fecven'     = space(10),
              'tasemi'     = space(9),
              'basemi'     = space(3),
              'monemi'     = space(3),
              'codmon'     = 0,
              'nominal'    = isnull( MDDI.dinominal, 0),
              'tir'        = isnull( MDDI.ditircomp, 0),
              'pvp'        = isnull( MDDI.dipvpcomp, 0),
              'vpproc'     = isnull( MDDI.divptirc,  0)
       into   #TEMP1
       from   MDAC, MDDI
       where  MDDI.ditipoper = 'CI'
     -----------------------------------------------
     -- actualizamos el campo seriado de la temporal
     -----------------------------------------------
     -- solo ci
     ------------------------------------------------
     update #TEMP1 set seriado = MDCI.ciseriado 
     from  MDCI
     where tipoper        = 'CI'
     and   MDCI.cirutcart = rutcart
     and   MDCI.cinumdocu = numdoc
     and   MDCI.cicorrela = correla
        
     --------------------------------------------------------------------
     -- solo para compras con pacto cuando es seriado                  --
     --------------------------------------------------------------------         
     -- actualizamos datos de la tabla de temporal con los datos de serie
       update #TEMP1 set
              fecemi     = convert(char(10),mdse.sefecemi,103),
              fecven     = convert(char(10),mdse.sefecven,103),  
              tasemi     = convert(char(09),mdse.setasemi),
              basemi     = convert(char(03),mdse.sebasemi),
              codmon     = mdse.semonemi,
              monemi     = ''
       from   VIEW_SERIE mdse
       where  seriado    = 'S'
       and    tipoper    = 'CI'
       and    serie      = mdse.seserie
     --------------------------------------------------------------------
     -- solo para compras con pacto cuando no es seriado               --
     --------------------------------------------------------------------         
       update #TEMP1 set
              fecemi     = convert(char(10),VIEW_NOSERIE.nsfecemi,103),
    fecven     = convert(char(10),VIEW_NOSERIE.nsfecven,103),  
              tasemi     = convert(char(09),VIEW_NOSERIE.nstasemi),
              basemi     = convert(char(03),VIEW_NOSERIE.nsbasemi),
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
      from   VIEW_MONEDA  VIEW_MONEDA
      where  codmon = VIEW_MONEDA.mncodmon 
  
     ----------------------------------------------------------------
     -- temporal 4
     ----------------------------------------------------------------
       SELECT 'NOMEMP'     = 'A,' + isnull( MDAC.acnomprop, ''),                                                                       
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),               
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),                                                            
              'fecpro1'    = convert(char(10), MDAC.acfecproc, 103),                                                            
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),                                                            
              'numdocu'    = space(14),
              'serie'      = space(12),
              'fecemi'     = space(10),
              'fecven'     = space(10),
              'tasemi'     = space(09),
              'basemi'     = space(03),
              'monemi'     = space(03),
              'nominal'    = 0,
              'tir'        = 0,
              'pvp'        = 0,
              'vpproc'     = 0
       into   #TEMP4
       from   MDAC
       select 'nomemp'     = #TEMP1.nomemp,
              'rutemp'     = #TEMP1.rutemp,
              'fecpro'     = #TEMP1.fecpro,
              'fecpro1'    = #TEMP1.fecpro1,
              'fecppro'    = #TEMP1.fecppro,
              'numdocu'    = #TEMP1.numdocu,
              'serie'      = #TEMP1.serie,
              'fecemi'     = #TEMP1.fecemi,
              'fecven'     = #TEMP1.fecven,
              'tasemi'     = #TEMP1.tasemi,
              'basemi'     = #TEMP1.basemi,
              'monemi'     = #TEMP1.monemi,
              'nominal'    = #TEMP1.nominal,
              'tir'        = #TEMP1.tir,
              'pvp'        = #TEMP1.pvp,
              'vpproc'     = #TEMP1.vpproc
       into   #TEMP3
       from   #TEMP1
       insert into #TEMP4 select * from #TEMP3
     -- seleccionamos solo los campos que necesitamos imprimir 
     -----------------------------------------------------------
     -- de la tabla temporal.-      
     -----------------------------------------------------------
        execute (@cbuffer)
     -- generar datos sdf.-
     ---------------------------------------------
        select  @cexecute = 'master.dbo.xp_cmdshell ''bcp bt_chile..' + @carchivo +' out c:\jfsrvr\' + @carchivo + '.txt /c  /r \n /t, /sbac-srv /usa /pethernet'''
        execute  ( @cexecute )
     -- conbinar  los datos con la cabecera.-
     ----------------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell ''copy c:\btchile\carteras\inf_ctd\inf_ctd.txt+c:\jfsrvr\'+@carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dxx'''
        execute (@cexecute)
     -- borra el archivo txt del servidor.-
     ----------------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell ''del c:\jfsrvr\'+@carchivo+'.txt'''
        execute (@cexecute)
    
     -- borra la tabla que se ha creado
     ----------------------------------------------
        select @cexecute = 'drop table ' + @carchivo
        execute (@cexecute)
end

GO
