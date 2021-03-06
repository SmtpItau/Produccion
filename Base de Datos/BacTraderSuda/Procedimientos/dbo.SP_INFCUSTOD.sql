USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFCUSTOD]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_INFCUSTOD] ( @ctipoper char(03) )
  as
  begin
  set nocount on
     -- definiciones de variables
     --------------------------------
        declare @carchivo varchar(30)
        declare @cbuffer  varchar(255)
        declare @cexecute varchar(200)
        declare @user     varchar(100)
        select @user   = 'Sp_Infcustod'
        select @carchivo = ltrim( @user ) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,15 ,1,'_' )
        select @carchivo = stuff( @carchivo,18,1,'_' )
        select @carchivo = stuff( @carchivo,21,1,'_' )
        select @carchivo = ltrim( @carchivo )
        select @cbuffer  = 'select * into ' + @carchivo  + ' from #TEMP5'
     ---------------------------------------------------
     -- encabezado de la temporal temp1
     ---------------------------------------------------
       SELECT 'NOMEMP'     = 'A,' + isnull( MDAC.acnomprop, ''),
              'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
              'nomoper'    = space(20),
              'numdoc'     = 0,
              'correla'    = 0,
              'numdocu'    = space(14),
              'serie'      = space(12),
              'monemi'     = space(03),
              'nominal'    = convert(float,0),
              'tir'        = convert(float,0),
              'pvp'        = convert(float,0),
              'vpproc'     = convert(float,0),
              'numcorte'   = 0,
              'mtocorte'   = convert(float,0),
              'flag'       = space(01)
       into   #TEMP1
       from   MDAC
    ------------------------------------------------
     -- actualizamos el campo nombre operacion
     ------------------------------------------------
       update #TEMP1 set nomoper = 'compras propias  ' 
       where @ctipoper = 'CP'
       update #TEMP1 set nomoper = 'compras con pacto' 
       where @ctipoper = 'CI'
     ---------------------------------------------------
     -- seleccionamos todos los campos de la tabla MDDI 
     -- todos aquellos que sean 'cp' o 'ci'
     ---------------------------------------------------
       SELECT 'NOMEMP'     = 'B,' + space(38), 
              'rutemp'     = space(11),
              'fecpro'     = space(10),
              'nomoper'    = space(20),
              'numdoc'     = isnull( MDDI.dinumdocu, 0),
              'correla'    = isnull( MDDI.dicorrela, 0),
              'rutcart'    = isnull( MDDI.dirutcart, 0),
              'numdocu'    = rtrim(convert(char(10),isnull( MDDI.dinumdocu, 0))) +'-'+ convert(char(3),isnull( MDDI.dicorrela, 0)), 
              'tipoper'    = MDDI.ditipoper,
              'serie'      = isnull( MDDI.diinstser, ''),
              'monemi'     = substring(MDDI.dinemmon, 1, 3),
              'nominal'    = convert(float,isnull( MDDI.dinominal, 0)),
              'tir'        = convert(float,isnull( MDDI.ditircomp, 0)),
              'pvp'        = convert(float,isnull( MDDI.dipvpcomp, 0)),
              'vpproc'     = convert(float,isnull( MDDI.divptirc,  0)),
              'numcorte'   = 0,
              'mtocorte'   = convert(float,0),
              'flag'       = space(01)
       into   #TEMP2
       from   MDAC, MDDI
       where  MDDI.ditipoper = @ctipoper
     ----------------------------------------------------
     -- seleccionamos los detalles de cortes de la mdco
     ----------------------------------------------------
       SELECT 'NOMEMP'     = 'C,' + space(38), 
              'rutemp'     = space(11),
              'fecpro'     = space(10),
              'nomoper'    = space(20),
              'numdoc'     = #TEMP2.numdoc,
              'correla'    = #TEMP2.correla,
   'rutcart'    = #TEMP2.rutcart,
              'numdocu'    = #TEMP2.numdocu, 
              'serie'      = space(12),
      'monemi'     = space(03),
              'nominal'    = convert(float,0),
              'tir'        = convert(float,0),
              'pvp'        = convert(float,0),
              'vpproc'     = convert(float,0),
              'numcorte'   = isnull ( mdco.cocantcortd,0),
              'mtocorte'   = convert(float,isnull ( mdco.comtocort,  0)),
              'flag'       = space(01)
       into   #TEMP3
       from   #TEMP2, MDCO
       where  conumdocu = #TEMP2.numdoc 
       and    cocorrela = #TEMP2.correla
       and    corutcart = #TEMP2.rutcart
       order by #TEMP2.numdocu, mdco.comtocort desc
     ---------------------------------------------
     -- pie de pagina
     --------------------------------------------- 
       SELECT 'NOMEMP'     = 'D,',
              'rutemp'     = space(11),
              'fecpro'     = space(10),
              'nomoper'    = space(20),
              'numdoc'     = #TEMP2.numdoc,
              'correla'    = #TEMP2.correla,
              'numdocu'    = #TEMP2.numdocu,
              'serie'      = space(12),
              'monemi'     = space(03),
              'nominal'    = convert(float,0),
              'tir'        = convert(float,0),
              'pvp'        = convert(float,0),
              'vpproc'     = convert(float,0),
              'numcorte'   = 0,
              'mtocorte'   = convert(float,0),
              'flag'       = space(01)
       into   #TEMP4
       from   #TEMP2
     ----------------------------------------------
     -- insertamos registros de la tabla temporal 2
     ----------------------------------------------
       insert into #TEMP1 select #TEMP2.nomemp,
                                 #TEMP2.rutemp,
                                 #TEMP2.fecpro,
                                 #TEMP2.nomoper,
                                 #TEMP2.numdoc,
                                 #TEMP2.correla,
                                 #TEMP2.numdocu,
                                 #TEMP2.serie,
                                 #TEMP2.monemi,
                                 #TEMP2.nominal,
                                 #TEMP2.tir,
                                 #TEMP2.pvp,
                                 #TEMP2.vpproc,
                                 #TEMP2.numcorte,
                                 #TEMP2.mtocorte,
                                 #TEMP2.flag
                          from   #TEMP2
     ----------------------------------------------
     -- insertamos registros de la tabla temporal 3
     ----------------------------------------------
       insert into #TEMP1 select #TEMP3.nomemp,
                                 #TEMP3.rutemp,
                                 #TEMP3.fecpro,
                                 #TEMP3.nomoper,
                                 #TEMP3.numdoc,
                                 #TEMP3.correla,                                
                                 #TEMP3.numdocu,
                                 #TEMP3.serie,
                                 #TEMP3.monemi,
                                 #TEMP3.nominal,
                                 #TEMP3.tir,
                                 #TEMP3.pvp,
                                 #TEMP3.vpproc,
                                 #TEMP3.numcorte,
                                 #TEMP3.mtocorte,
                                 #TEMP3.flag
                          from   #TEMP3
     ----------------------------------------------
     -- insertamos registros de la tabla temporal 4
     ----------------------------------------------
       insert into #TEMP1 select #TEMP4.nomemp,
                                 #TEMP4.rutemp,
                                 #TEMP4.fecpro,
                                 #TEMP4.nomoper,
#TEMP4.numdoc,
                                 #TEMP4.correla,
                                 #TEMP4.numdocu,
                        #TEMP4.serie,
             #TEMP4.monemi,
                                 #TEMP4.nominal,
                                 #TEMP4.tir,
                                 #TEMP4.pvp,
                                 #TEMP4.vpproc,
                                 #TEMP4.numcorte,
                                 #TEMP4.mtocorte,
                                 #TEMP4.flag
                          from   #TEMP4
       
     -------------------------------------------------
     -- traspasamos de la tabla temporal 1 a la tabla
     -- temporal 5
     -------------------------------------------------
       select 'nomemp'   = #TEMP1.nomemp,
              'rutemp'   = #TEMP1.rutemp,
              'fecpro'   = #TEMP1.fecpro,
              'nomoper'  = #TEMP1.nomoper,
              'numdocu'  = #TEMP1.numdocu,
              'serie'    = #TEMP1.serie,
              'monemi'   = #TEMP1.monemi,
              'nominal'  = #TEMP1.nominal,
              'tir'      = #TEMP1.tir,
              'pvp'      = #TEMP1.pvp,
              'vpproc'   = #TEMP1.vpproc,
              'numcorte' = #TEMP1.numcorte,
              'mtocorte' = #TEMP1.mtocorte,
              'flag'     = #TEMP1.flag
       into   #TEMP5
       from   #TEMP1
       order by #TEMP1.numdoc  ,
                #TEMP1.correla ,
                #TEMP1.nomemp  ,
                #TEMP1.mtocorte
     -- seleccionamos solo los campos que necesitamos imprimir 
     -----------------------------------------------------------
     -- de la tabla temporal.-      
     -----------------------------------------------------------
        select * from #TEMP5
        execute (@cbuffer)
     -- generar datos sdf.-
     ---------------------------------------------
        select  @cexecute = 'master.dbo.xp_cmdshell ''bcp bt_chile..' + @carchivo +' out c:\jfsrvr\' + @carchivo + '.txt /c  /r \n /t, /sbac-srv /usa /pethernet'''
        execute  ( @cexecute )
     -- combinar  los datos con la cabecera.-
     ----------------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell ''copy c:\btchile\custod\custod.txt+c:\jfsrvr\'+@carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dxx'''
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
