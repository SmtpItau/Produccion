USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVAL]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_infval    fecha de la secuencia de comandos: 05/04/2001 13:13:34 ******/
CREATE PROCEDURE [dbo].[SP_INFVAL]
  as
  begin
      
     -- definiciones de variables
     --------------------------------
        declare @carchivo varchar(30)
        declare @cbuffer  varchar(255)
        declare @cexecute varchar(200)
        declare @user     varchar(100)
        select @user   = 'Sp_Infval'
        select @carchivo = ltrim( @user ) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,12 ,1,'_' )
        select @carchivo = stuff( @carchivo,15,1,'_' )
        select @carchivo = stuff( @carchivo,18,1,'_' )
        select @carchivo = ltrim( @carchivo )
        select @cbuffer  = 'select * into ' + @carchivo  + ' from #TEMP1'
     ----------------------------------------------------------------
     -- temporal 1
     ----------------------------------------------------------------
       SELECT 'NOMEMP'     = 'A,' + isnull( MDAC.acnomprop, ''),                                                                       
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),               
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),                                                            
              'fecpro1'    = convert(char(10), MDAC.acfecproc, 103),                                                            
              'fecppro'    = convert(char(10), MDAC.acfecprox, 103),                                                            
              'numdocu'    = space(14),
              'tipoper'    = space(03),
              'serie'      = space(12),
              'fecemi'     = space(10),
              'fecven'     = space(10),
              'tasemi'     = space(09),
              'basemi'     = space(03),
              'monemi'     = space(03),
              'nominal'    = convert(float,0), -- nominal
              'pvpmcd'     = convert(float,0), -- % valor par a tasa de mercado
              'tirmcd'     = convert(float,0), -- tasa de mercado
              'vptirc'     = convert(float,0), -- valor presente tir de compra
              'vpmcd'      = convert(float,0), -- valor presente valorizado a tasa de mercado
              'difmcdo'    = convert(float,0)  -- diferencia mercado ( vptirc - vpmcd )
       into   #TEMP1
       from   MDAC
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
              'nominal'    = isnull( MDDI.dinominal,  0),
              'pvpmcd'     = isnull( MDDI.dipvpmcd,   0),
              'tirmcd'     = isnull( MDDI.ditirmcd,   0),
              'vptirc'     = isnull( MDDI.divptirc,   0),
              'vpmcd'      = isnull( MDDI.divpmcd,    0),
              'difmcdo'    = convert(float, 0)
       into   #TEMP2
       from   MDAC, MDDI
       order by ditipoper,
                dinumdocu,
                dicorrela
       update #TEMP2 set #TEMP2.difmcdo = #TEMP2.vptirc - #TEMP2.vpmcd
   -------------------------------------------------
   -- actualizamos el campo seriado de la temporal
   -------------------------------------------------
     -- solo ci
     -----------------------------------------------
     update #TEMP2 set seriado = MDCI.ciseriado 
     from  MDCI
     where tipoper        = 'CI'
     and   MDCI.cirutcart = rutcart
     and   MDCI.cinumdocu = numdoc
     and   MDCI.cicorrela = correla
     -----------------------------------------------
     -- solo cp
     -----------------------------------------------
     update #TEMP2 set seriado = MDCP.cpseriado 
     from  MDCP
     where tipoper        = 'CP'
     and   MDCP.cprutcart = rutcart
     and   MDCP.cpnumdocu = numdoc
     and   MDCP.cpcorrela = correla
        
     --------------------------------------------------------------------
     -- solo cuando es seriado                                         --
     --------------------------------------------------------------------         
     -- actualizamos datos de la tabla de temporal con los datos de serie
       update #TEMP2 set
              fecemi     = convert(char(10),VIEW_SERIE.sefecemi,103),
              fecven     = convert(char(10),VIEW_SERIE.sefecven,103),  
              tasemi     = convert(char(09),VIEW_SERIE.setasemi),
              basemi     = convert(char(03),VIEW_SERIE.sebasemi),
              codmon     = VIEW_SERIE.semonemi,
              monemi     = ''
       from   VIEW_SERIE
       where  seriado    = 'S'
       and    serie      = VIEW_SERIE.seserie
     --------------------------------------------------------------------
     -- solo cuando no es seriado                                      --
     --------------------------------------------------------------------         
       update #TEMP2 set
              fecemi     = convert(char(10),VIEW_NOSERIE.nsfecemi,103),
              fecven     = convert(char(10),VIEW_NOSERIE.nsfecven,103),  
              tasemi     = convert(char(09),VIEW_NOSERIE.nstasemi),
              basemi     = convert(char(03),VIEW_NOSERIE.nsbasemi),
              codmon     = VIEW_NOSERIE.nsmonemi,
              monemi     = ''
       from   VIEW_NOSERIE
       where  seriado    <> 'S'
       and    rutcart    = VIEW_NOSERIE.nsrutcart
       and    numdoc     = VIEW_NOSERIE.nsnumdocu 
       and    correla    = VIEW_NOSERIE.nscorrela
     ------------------------------------------------------
     --        actualizamos nemottcnico de moneda        --
     ------------------------------------------------------
      update #TEMP2 set monemi = substring(VIEW_MONEDA.mnnemo, 1, 3)
      from   VIEW_MONEDA 
      where  codmon = VIEW_MONEDA.mncodmon
      insert into #TEMP1 select #TEMP2.nomemp  ,
                                #TEMP2.rutemp  ,
                                #TEMP2.fecpro  ,
                                #TEMP2.fecpro1 ,
                                #TEMP2.fecppro ,
                                #TEMP2.numdocu ,
                                #TEMP2.tipoper ,
                                #TEMP2.serie   ,
                                #TEMP2.fecemi  ,
                                #TEMP2.fecven  ,
                                #TEMP2.tasemi  ,
                                #TEMP2.basemi  ,
                                #TEMP2.monemi  ,
                                #TEMP2.nominal ,
                                #TEMP2.pvpmcd  ,
                                #TEMP2.tirmcd  ,
                                #TEMP2.vptirc  ,
                                #TEMP2.vpmcd   ,
                                #TEMP2.difmcdo
                         from   #TEMP2
                         order by #TEMP2.tipoper,
                                  #TEMP2.numdoc ,
                                  #TEMP2.correla
     -- seleccionamos solo los campos que necesitamos imprimir 
     -----------------------------------------------------------
     -- de la tabla temporal.-      
     -----------------------------------------------------------
        select * from #TEMP1
        execute (@cbuffer)
     -- generar datos sdf.-
     ---------------------------------------------
        select  @cexecute = 'master.dbo.xp_cmdshell "bcp bt_chile..' + @carchivo +' out c:\jfsrvr\' + @carchivo + '.txt /c  /r \n /t, /sbac-srv /usa /pethernet"'
        execute  ( @cexecute )
     -- conbinar  los datos con la cabecera.-
     ----------------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell "copy c:\btchile\infval\infval.txt+c:\jfsrvr\'+@carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat"'
        execute (@cexecute)
     -- borra el archivo txt del servidor.-
     ----------------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell "del c:\jfsrvr\'+@carchivo+'.txt"'
        execute (@cexecute)
    
     -- borra la tabla que se ha creado
     ----------------------------------------------
        select @cexecute = 'drop table ' + @carchivo
        execute (@cexecute)
end


GO
