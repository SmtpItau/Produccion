USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOVP]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_infovp    fecha de la secuencia de comandos: 05/04/2001 13:13:34 ******/
CREATE PROCEDURE [dbo].[SP_INFOVP]
  as
  begin
 declare @carchivo varchar(30)
        declare @cbuffer  varchar(60)
        declare @cexecute varchar(200)
 declare @user     char(30)
 declare @cmacro   char(30)
 declare @ceject   char(80)
 declare @largo    integer
      
    -- determina nombre de archivos temporales
        select @user     = 'inforvp'
 select @largo    = convert(numeric(5,0),datalength(rtrim(@user)))
        select @carchivo = rtrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,10,1,'_')
        select @carchivo = stuff( @carchivo,13,1,'_')
        select @carchivo = stuff( @carchivo,16,1,'_')
        select @carchivo = ltrim(@carchivo)
        select @cbuffer  = 'select * into ' + @carchivo  + ' from #TEMP1'
        SELECT 'NOMPROP'     = 'A,'+isnull( MDAC.acnomprop, ''),
              'rutprop'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
              'fec_pro'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
              'fec_rep'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
              'rutcli'      = 0,
              'rutcart'     = 0,
              'tipcart'     = 0,
              'numdocu'     = space(14),
       'numdoc'      = 0,
              'correla'     = 0,
              'serie'       = space(12),
              'emisor'      = space(10),
              'fecemi'      = space(10),
              'fecven'      = space(10),
              'tasemi'      = convert(numeric(9,4),0),
              'base'        = convert(numeric(3,0),0),
              'monemi'      = space(05),
              'nominal'     = convert(numeric(19,4),0),
              'tirventa'    = convert(numeric(9,4),0),
              'vcventa'     = convert(numeric(7,2),0),
              'tasest'      = convert(numeric(9,4),0),
              'vpresen'     = convert(numeric(19,4),0),
              'valorventa'  = convert(numeric(19,4),0),
              'utilidad'    = convert(numeric(19,4),0),
              'formapago'   = 0,
              'tipocustodia'= space(25),
              'pagohoy'     = space(1),
              'cliente'     = space(40),
              'cartera'     = space(50),
              'tipocartera' = space(25),
              'cformapago'  = space(25),
              'custodia'    = space(25),  
              'cpagohoy'    = space(25)
       into   #TEMP
       from   MDAC
       insert into #TEMP        
         select  'nomprop'     ='b,'+ isnull( MDAC.acnomprop, ''),
                       'rutprop'     = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
   'fec_pro'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
                'fec_rep'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
                       'rutcli'      = isnull( MDMO.morutcli , 0),
                'rutcart'     = isnull( MDMO.morutcart, 0),
                'tipcart'     = isnull( MDMO.motipcart, 0),
                'numdocu'     = isnull(rtrim(convert(char(10),MDMO.monumdocuo))+'-'+convert(char(3),MDMO.mocorrelao),''),
   'numdoc'      = isnull( MDMO.monumdocuo, 0),
                'correla'     = isnull(MDMO.mocorrelao,0),
                'serie'       = isnull( MDMO.moinstser, ''), 
                        'emisor'      = isnull( MDEM.emgeneric,''),
                'fecemi'      = isnull( convert(char(10), MDMO.mofecemi, 103), ''),  
                'fecven'      = isnull( convert(char(10), MDMO.mofecven, 103), ''),
                'tasemi'      = isnull( MDMO.motasemi, 0),
                'base'        = isnull( MDMO.mobasemi, 0),
                'monemi'      = isnull( VIEW_MONEDA.mnnemo,''),
                'nominal'     = isnull( MDMO.monominal,0),
                'tirventa'    = isnull( MDMO.motir,  0),
                'vcventa'     = isnull( MDMO.mopvp, 0),
                'tasest'      = isnull( MDMO.motasest, 0),
           'vpresen'     = isnull( MDMO.movpresen, 0),
                'valorventa'  = isnull( MDMO.movalvenp, 0),
                'utilidad'    = isnull( ( MDMO.movalvenp - MDCP.cpvalcomp ), 0),
                'formapago'   = isnull( MDMO.moforpagi, 0),
                'tipocustodia'= isnull( MDMO.mocondpacto, ''),
                'pagohoy'     = isnull( MDMO.mopagohoy, ''),
                'cliente'     = space(40),
                'cartera'     = space(50),
                'tipocartera' = space(25),
                'cformapago'  = space(25),
                'custodia'    = space(25),  
          'cpagohoy'    = space(25)
         from    MDMO, MDCP, MDAC, VIEW_EMISOR MDEM, VIEW_MONEDA VIEW_MONEDA
         where   MDMO.motipoper = 'VP' and MDMO.mostatreg is null
         and     MDMO.morutcart = MDCP.cprutcart
         and     MDMO.monumdocu = MDCP.cpnumdocu
         and     MDMO.mocorrela = MDCP.cpcorrela
  and MDEM.emrut     = MDMO.morutemi 
  and  VIEW_MONEDA.mncodmon  = MDMO.momonemi
     -- clientes.-
       update #TEMP set cliente      = isnull( VIEW_CLIENTE.clnombre, '')
       from   VIEW_CLIENTE  
       where  rutcli                 = VIEW_CLIENTE.clrut
     -- cartera.-
       update #TEMP set cartera      = isnull( MDRC.rcnombre, '')
       from   VIEW_ENTIDAD MDRC
       where  rutcart                = MDRC.rcrut
     -- tipo cartera.-
       update #TEMP set tipocartera  = isnull( VIEW_TABLA_GENERAL_DETALLE.tbglosa, '')
       from   VIEW_TABLA_GENERAL_DETALLE
       where  VIEW_TABLA_GENERAL_DETALLE.tbcateg           = 204        
       and    tipcart                = convert(numeric(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
     --  glosa forma de pago.-
       update #TEMP set cformapago   = isnull( VIEW_FORMA_DE_PAGO.glosa, '') 
       from   VIEW_FORMA_DE_PAGO
       where   formapago      = convert(numeric(6),VIEW_FORMA_DE_PAGO.codigo) --forma pago 
       
     
     -- custodia.-
       update #TEMP set custodia     = case tipocustodia when 's' then 'con custodia' else 'sin custodia' end 
     -- pago hoy.-
       update #TEMP set cpagohoy = case pagohoy  when 'n' then 'pago maana'  else '' end
     -- seleccionamos solo los campos que necesitamos imprimir de la tabla temporal.-      
       select   nomprop       ,
  rutprop       ,
         fec_pro  , 
                fec_rep  ,   
                cliente      ,
                cartera      ,
                tipocartera  ,
                numdocu      ,
                serie        ,
         emisor       ,
                fecemi       ,
                fecven       ,
                tasemi       ,
                base         ,
                monemi       ,
                nominal      ,
                tirventa     ,
                vcventa      ,
                tasest       ,
                vpresen      ,
                valorventa   ,
                utilidad     ,
                cformapago    ,
                custodia     ,
                cpagohoy ,
         numdoc  ,
               correla     
   into  #TEMP1 
          from  #TEMP
          order by numdoc+correla
       execute (@cbuffer)
       select  @cexecute = 'master.dbo.xp_cmdshell "bcp bt_chile.." + @carchivo +" out c:\btchile\infovp\" + @carchivo + ".txt /c /t, /r \n /sbac-srv /usa /pethernet"'
       execute  ( @cexecute )
     -- combinar los datos con la cabecera.-
        select  @cexecute = 'master.dbo.xp_cmdshell "copy c:\btchile\infovp\einfovp.txt+c:\btchile\infovp\'+ @carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat"'
        execute (@cexecute)
 select @cmacro = 'drop table ' + @carchivo
        execute (@cmacro)
        select  @ceject = 'master.dbo.xp_cmdshell "del c:\btchile\infovp\' + @carchivo + '.txt"'
        execute (@ceject)
end


GO
