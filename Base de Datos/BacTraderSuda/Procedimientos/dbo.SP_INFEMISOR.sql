USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFEMISOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFEMISOR]
  as
  begin
set nocount on
      
        ------------------------------
 -- definiciones de variables
        ------------------------------
        declare @carchivo varchar(25)
        declare @cbuffer  varchar(250)
        declare @cexecute varchar(200)
        declare @user     varchar(100)
        select @user   = 'Sp_Infemisor'     
        select @carchivo = ltrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,15 ,1,'_' )
        select @carchivo = stuff( @carchivo,18,1,'_'  )
        select @carchivo = stuff( @carchivo,21,1,'_'  )
        select @carchivo = ltrim( @carchivo )
        select @cbuffer   = ''
        select @cbuffer   = @cbuffer + 'select * ' + 'into '  + @carchivo + ' from #TEMP3 order by #TEMP3.nombre'
     -----------------------------------------
     -- forma el archivo de datos para el jf.
     -----------------------------------------
     --------------------------------------------------
     -- seleccionamos todos los campos de la tabla MDEM
     -------------------------------------------------- 
        select 'nomemp'     = 'b,' + char(34) + isnull( b.acnomprop, '') + char(34) ,
               'rutemp'     = isnull( ( rtrim (convert( char(9), b.acrutprop ) ) + '-' + b.acdigprop ),'' ),               
               'fecpro'     = convert(char(10), b.acfecproc, 103),                                                            
               'fecpro1'    = convert(char(10), b.acfecproc, 103),               
               'rutemi'     = a.emrut,
               'rut'        = rtrim(convert(char(09),a.emrut)) + '-' + a.emdv,
               'codigo'     = isnull( a.emcodigo, 0),
               'nombre'     = char(34) + substring(isnull( a.emnombre, ''),1,38) + char(34),
               'generic'    = isnull( a.emgeneric, ''),
               'codtipo'    = isnull( a.emtipo, ''),
               'tipo'       = space(15), 
               'direcc'     = char(34) + substring(isnull( a.emdirecc, ''),1,38) + char(34),
               'codcomuna'  = isnull( a.emcomuna, 0),
               'comuna'     = space(15)
        into   #TEMP1
        from   VIEW_EMISOR  a, MDAC b
        where  a.emrut > 0
        order by a.emrut
 
     ---------------------------------------------------------------- 
     -- actualizamos la glosa de comuna
     ----------------------------------------------------------------
        update #TEMP1 set comuna = nom_ciu
        from   VIEW_CIUDAD_COMUNA
        where  cod_ciu    = 1
        and    #TEMP1.codcomuna = cod_com
-----------------------------------------------------------------------
--     falta verificar el tipo de emisor
--     ---------------------------------------------------------------- 
--     -- actualizamos la glosa de tipo de emisor
--     ----------------------------------------------------------------
--        update #TEMP1 set tipo = MDTC.tbglosa
--        from   MDTC
--        where  MDTC.tbcateg     = 41
--        and    convert(integer,#TEMP1.codtipo) = convert(numeric(6),MDTC.tbcodigo1)
  
        update #TEMP1 set tipo = 'FINANCIERO'
        where  tipo = ''
        update #TEMP1 set comuna = 'SAN MIGUEL'
        where  comuna = ''
-----------------------------------------------------------------------
     
     ----------------------------------------------------------------
     -- tabla temporal 3
     ---------------------------------------------------------------- 
        SELECT 'NOMEMP'     = 'A,'+ char(34) + isnull( MDAC.acnomprop, '') + char(34),
               'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
               'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
               'fecpro1'    = convert(char(10), MDAC.acfecproc, 103),
               'rut'        = space(11),
               'codigo'     = 0,
             'nombre' = space(40),
               'generic'    = space(10),
               'tipo'       = space(15),
               'direcc'     = space(40), 
               'comuna'     = space(15)
        into   #TEMP3
        from   MDAC
        select 'nomemp'     = #TEMP1.nomemp,
               'rutemp'     = #TEMP1.rutemp,
               'fecpro'     = #TEMP1.fecpro,
               'fecpro1'    = #TEMP1.fecpro1,
               'rut'        = #TEMP1.rut,
               'codigo'     = #TEMP1.codigo,
               'nombre'     = #TEMP1.nombre,
               'generic'    = #TEMP1.generic, 
               'tipo'       = #TEMP1.tipo,
               'direcc'     = #TEMP1.direcc,               
               'comuna'     = #TEMP1.comuna
        into   #TEMP2
        from   #TEMP1
        order by #TEMP1.rutemi
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
        select   @cexecute = 'master.dbo.xp_cmdshell ''copy c:\btchile\manten\emisor\emisor.txt+c:\jfsrvr\'+@carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat'''
        execute (@cexecute)
     -- borra el archivo txt del servidor.-
     --------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell ''del c:\jfsrvr\'+@carchivo+'.txt'''
        execute (@cexecute)
    
     -- borra la tabla que se ha creado
     --------------------------------------
        select @cexecute = 'drop table ' + @carchivo
        execute (@cexecute)
       
end

GO
