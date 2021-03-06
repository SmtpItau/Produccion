USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFDCARTERA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_INFDCARTERA]
  as
  begin
      
        ------------------------------
 -- definiciones de variables
        ------------------------------
        declare @carchivo varchar(30)
        declare @cbuffer  varchar(250)
        declare @cexecute varchar(200)
        declare @user     varchar(100)
        select @user   = 'Sp_Infdcartera'
        select @carchivo = ltrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,17 ,1,'_')
        select @carchivo = stuff( @carchivo,20,1,'_')
        select @carchivo = stuff( @carchivo,23,1,'_')
        select @carchivo = ltrim(@carchivo)
        select @cbuffer   = ''
        select @cbuffer   = @cbuffer + 'select * ' + 'into '  + @carchivo + ' from #TEMP3 order by #TEMP3.nombre'
     -----------------------------------------
     -- forma el archivo de datos para el jf.
     -----------------------------------------
     --------------------------------------------------
     -- seleccionamos todos los campos de la tabla MDRC
     -------------------------------------------------- 
        SELECT 'NOMEMP'     = 'B,' + char(34) + isnull( MDAC.acnomprop, '') + char(34) ,
               'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
               'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
               'fecpro1'    = convert(char(10), MDAC.acfecproc, 103),
               'rutcar'     = MDRC.rcrut,
               'rut'        = rtrim(convert(char(09),MDRC.rcrut)) + '-' + MDRC.rcdv,
               'codcar'     = isnull( MDRC.rccodcar, 0),
               'nombre'     = isnull( MDRC.rcnombre, ''),
               'numoper'    = isnull( MDRC.rcnumoper, 0),
               'telefono'   = isnull( MDRC.rctelefono, ''),
               'fax'        = isnull( MDRC.rcfax, ''),
               'direcc'     = char(34) + isnull( MDRC.rcdirecc, '') + char(34)
        into   #TEMP1
        from   VIEW_ENTIDAD MDRC, MDAC
        where  MDRC.rcrut > 0
        order by MDRC.rcrut
 
     
     ----------------------------------------------------------------
     -- tabla temporal 3
     ---------------------------------------------------------------- 
        SELECT 'NOMEMP'     = 'A,'+ char(34) + isnull( MDAC.acnomprop, '') + char(34),
               'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
               'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
               'fecpro1'    = convert(char(10), MDAC.acfecproc, 103),
               'rut'        = space(12),
               'codcar'     = 0,
               'nombre'     = space(50),
               'numoper'    = 0,
               'telefono'   = space(30),
               'fax'        = space(30),
               'direcc'     = space(50)
        into   #TEMP3
        from   MDAC
        select 'nomemp'     = #TEMP1.nomemp,
               'rutemp'     = #TEMP1.rutemp,
               'fecpro'     = #TEMP1.fecpro,
               'fecpro1'    = #TEMP1.fecpro1,
               'rut'        = #TEMP1.rut,
               'codcar'     = #TEMP1.codcar,
               'nombre'     = #TEMP1.nombre,
               'numoper'    = #TEMP1.numoper,
               'telefono'   = #TEMP1.telefono,
               'fax'        = #TEMP1.fax,
               'direcc'     = #TEMP1.direcc
        into   #TEMP2
        from   #TEMP1
        order by #TEMP1.rutcar
        insert into #TEMP3 select * from #TEMP2 
       
                
     -- seleccionamos solo los campos que necesitamos imprimir de la tabla temporal.-      
     --------------------------------------------------------------------------------
        execute (@cbuffer)
     -- generar datos sdf.-
     ---------------------- 
        select  @cexecute = 'master.dbo.xp_cmdshell ''bcp bt_chile..' + @carchivo +' out c:\jfsrvr\' + @carchivo + '.txt /c /r \n /t , /sbac-srv /usa /pethernet'''
        execute  ( @cexecute )
     -- conbinar  los datos con la cabecera.-
     ----------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell ''copy c:\btchile\manten\dcartera\dcartera.txt+c:\jfsrvr\'+@carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat'''
        execute (@cexecute)
     -- borra el archivo txt del servidor.-
     --------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell ''del c:\jfsrvr\''+@carchivo+''.txt'''
        execute (@cexecute)
    
     -- borra la tabla que se ha creado
     --------------------------------------
        select @cexecute = 'drop table ' + @carchivo
        execute (@cexecute)
     
end

GO
