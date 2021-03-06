USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFTABLAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_inftablas    fecha de la secuencia de comandos: 05/04/2001 13:13:34 ******/
CREATE PROCEDURE [dbo].[SP_INFTABLAS]
  as
  begin
      
        ------------------------------
 -- definiciones de variables
        ------------------------------
        declare @carchivo varchar(25)
        declare @cbuffer  varchar(250)
        declare @cexecute varchar(200)
        declare @user     varchar(100)
        select @user   = 'Sp_Inftablas'
        select @carchivo = ltrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,15 ,1,'_' )
        select @carchivo = stuff( @carchivo,18,1,'_'  )
        select @carchivo = stuff( @carchivo,21,1,'_'  )
        select @carchivo = ltrim( @carchivo )
        select @cbuffer   = ''
        select @cbuffer   = @cbuffer + 'select * ' + 'into '  + @carchivo + ' from #TEMP3 '
     -----------------------------------------
     -- forma el archivo de datos para el jf.
     -----------------------------------------
     --------------------------------------------------
     -- seleccionamos todos los campos de la tabla MDTC
     -------------------------------------------------- 
        SELECT 'NOMEMP'     = 'B,' + char(34) + isnull( MDAC.acnomprop, '') + char(34) ,
               'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),               
               'fecpro'     = convert(char(10), MDAC.acfecproc, 103),                                                            
               'fecpro1'    = convert(char(10), MDAC.acfecproc, 103),               
               'tbcodtab'   = isnull( VIEW_TABLA_GENERAL_DETALLE.tbcateg, 0),
               'tbglosa'    = space(25),
               'tbtipmnt'   = space(01),
               'tccodigo'   = isnull( convert(numeric(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1), 0),
               'tcglosa'    = isnull( VIEW_TABLA_GENERAL_DETALLE.tbglosa, '')
        into   #TEMP1
        from   VIEW_TABLA_GENERAL_DETALLE, MDAC
        order by VIEW_TABLA_GENERAL_DETALLE.tbcateg, VIEW_TABLA_GENERAL_DETALLE.tbcodigo1
 
     ---------------------------------------------------------------- 
     -- actualizamos la glosa y el campo tipo de mantension
     ----------------------------------------------------------------
        update #TEMP1 set #TEMP1.tbglosa  = mdtb.ctdescrip
        from   view_tabla_general_global mdtb
        where  mdtb.ctcateg    = #TEMP1.tbcodtab
     
     ----------------------------------------------------------------
     -- tabla temporal 3
     ---------------------------------------------------------------- 
        SELECT 'NOMEMP'     = 'A,'+ char(34) + isnull( MDAC.acnomprop, '') + char(34),
               'rutemp'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
               'fecpro'     = convert(char(10), MDAC.acfecproc, 103),
               'fecpro1'    = convert(char(10), MDAC.acfecproc, 103),
               'tbcodtab'   = 0,
               'tbglosa'    = space(25),
               'tbtipmnt'   = space(01),
               'tccodigo'   = 0,
               'tcglosa'    = space(25)
        into   #TEMP3
        from   MDAC
        select 'nomemp'     = #TEMP1.nomemp,
               'rutemp'     = #TEMP1.rutemp,
               'fecpro'     = #TEMP1.fecpro,
               'fecpro1'    = #TEMP1.fecpro1,
               'tbcodtab'   = #TEMP1.tbcodtab,
               'tbglosa'    = #TEMP1.tbglosa,
               'tbtipmnt'   = #TEMP1.tbtipmnt,
               'tccodigo'   = #TEMP1.tccodigo,
               'tcglosa'    = #TEMP1.tcglosa
        into   #TEMP2
        from   #TEMP1
        order by #TEMP1.tbcodtab, #TEMP1.tccodigo
        insert into #TEMP3 select * from #TEMP2 
       
                
     -- seleccionamos solo los campos que necesitamos imprimir de la tabla temporal.-      
     --------------------------------------------------------------------------------
        execute (@cbuffer)
     -- generar datos sdf.-
     ---------------------- 
        select  @cexecute = 'master.dbo.xp_cmdshell "bcp bt_chile..' + @carchivo +' out c:\jfsrvr\' + @carchivo + '.txt /c /r \n /t , /sbac-srv /usa /pethernet"'
        execute  ( @cexecute )
     -- conbinar  los datos con la cabecera.-
     ----------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell "copy c:\btchile\manten\tablas\tablas.txt+c:\jfsrvr\'+@carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat"'
        execute (@cexecute)
     -- borra el archivo txt del servidor.-
     --------------------------------------
        select   @cexecute = 'master.dbo.xp_cmdshell "del c:\jfsrvr\'+@carchivo+'.txt"'
        execute (@cexecute)
    
     -- borra la tabla que se ha creado
     --------------------------------------
        select @cexecute = 'drop table ' + @carchivo
        execute (@cexecute)
     
end
 


GO
