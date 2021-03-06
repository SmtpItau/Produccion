USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Inforc]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_inforc    fecha de la secuencia de comandos: 05/04/2001 13:13:33 ******/
create procedure [dbo].[Sp_Inforc]
  as
  begin
set nocount on
        declare @carchivo varchar(30)
        declare @cbuffer  varchar(60)
        declare @cexecute varchar(200)
 declare @user     char(30)
 declare @cmacro   char(30)
 declare @largo    numeric(05,0)
 declare @ceject   char(80)
      
    -- determina nombre de archivos temporales
        select @user     = 'inforrc'
 select @largo    = convert(numeric(5,0),datalength(rtrim(@user)))
        select @carchivo = rtrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,10,1,'_')
        select @carchivo = stuff( @carchivo,13,1,'_')
        select @carchivo = stuff( @carchivo,16,1,'_')
        select @carchivo = ltrim(@carchivo)
        select @cbuffer  = "select * into " + @carchivo  + " from #TEMP1"
       select  'nomprop'      = 'a,'+isnull( MDAC.acnomprop, ''),                                                          -- nombre del propietario
  'rutprop'      = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),  -- rut propietario
    'fec_pro'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
              'fec_rep'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
               'cliente'     = space(40),           -- rut del cliente
               'cartera'     = space(40),                                   -- rut de cartera
               'tcartera'     = 0,                                                           -- tipo de cartera
               'ndoc'         = space(14),
                'numdocu'       = 0,
                'correla'       = 0,                                                           -- ní documento
               'serie'        = space(12),                                                          -- serie
               'emisor'      = space(10),                                                           -- rut emisor
               'cmonemi'      = 0,                                                            -- moneda de emision
               'nominal'      = convert(numeric(19,4),0),
               'tir'          = convert(numeric(09,4),0),                                                              -- tir
               'vc'           = convert(numeric(07,2),0),
               'interes'       = convert(numeric(19,4),0),
               'tasest'       = convert(numeric(09,4),0),
               'fecinipacto'   = space(10),
               'tasapacto'    = convert(numeric(9,4),0),
               'basepacto'    = convert(numeric(3,0),0),
               'cmonedapacto' = 0,                                                           -- moneda pacto
               'vinipacto'    = convert(numeric(19,4),0),
               'vvctopacto'   = convert(numeric(19,4),0),
  'fpvctopacto'  = 0,
               'tipocustodia' = space(1),
               'cpagohoy'     = space(1),                                                                           -- nombre de la cartera
                'custodia'      = space(25),
                'pagohoy'       = space(15),
               'tipocartera'  = space(25),                                                                            -- glosa tipo cartera
               'nemomoneda'   = space(5),                                                                            -- nemotecnico moneda
               'nemomonpacto' = space(5),                                                                            -- nemotecnico moneda del pacto 
               'nfpvctopacto' = space(25),                                                                            -- glosa forma de pago vencimiento pacto
  'tipoper' = space(15)
       into   #TEMP
       from   MDAC
       insert #TEMP
         select  'nomprop'      = 'b,'+isnull( MDAC.acnomprop, ''),                                                           -- nombre del propietario
   'rutprop'      = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),   -- rut propietario
     'fec_pro'     = isnull(convert(char(10),MDAC.acfecproc,103),''), 
               'fec_rep'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
                'cliente'     = isnull( VIEW_CLIENTE.clnombre , ''),             -- rut del cliente
                'cartera'     = isnull( MDRC.rcnombre , ''),                                   -- rut de cartera
                'tcartera'     = isnull( MDMO.motipcart, 0),                                                           -- tipo de cartera
                'ndoc'         = isnull(rtrim(convert(char(10),MDMO.monumdocu))+'-'+convert(char(3),MDMO.mocorrela),''),
                        'numdocu'       = isnull( MDMO.monumdocu, 0),
                        'correla'       = isnull( MDMO.mocorrela, 0),
                'serie'        = isnull( MDMO.moinstser, ''),                                                          -- serie
                'emisor'      = isnull( MDEM.emgeneric, ''),                                                           -- rut emisor
                'cmonemi'      = isnull( MDMO.momonemi, 0),                                                            -- moneda de emision
                'nominal'      = isnull( MDMO.monominal,0),                                                            -- nominal 
                'tir'          = isnull( MDMO.motir,  0),                                                              -- tir
                'vc'           = isnull( MDMO.mopvp, 0),                                                               -- porcentage valor compra 
   'interes'       = isnull(MDMO.movalvenp-MDMO.movalinip,0),
                'tasest'       = isnull( MDMO.motasest, 0),                                                            -- tasa estimada
   'fecinipacto'   = isnull(convert(char(10),MDMO.mofecinip,103),''), 
                'tasapacto'    = isnull( MDMO.motaspact, 0),                                                           -- tasa pacto
                'basepacto'    = isnull( MDMO.mobaspact, 0),                                                           -- base pacto
                'cmonedapacto' = isnull( MDMO.momonpact, 0),                                                           -- moneda pacto
                'vinipacto'    = isnull( MDMO.movalinip, 0),                                                           -- valor inicio pacto
                'vvctopacto'   = isnull( MDMO.movalvenp, 0),                                                           -- valor vencimiento pacto
                'fpvctopacto'  = isnull( MDMO.moforpagv, 0),                                                           -- codio forma de pago venciento pacto 
                'tipocustodia' = isnull( MDMO.mocondpacto, ''),                                                          -- tipo de custodia
                'cpagohoy'     = isnull( MDMO.mopagohoy, ''),                                                          -- pago hoy 'n' si es hoy , '' es maana
                        'custodia'      = space(25),
                        'pagohoy'       = space(15),
                'tipocartera'  = space(25),                                                                            -- glosa tipo cartera
                'nemomoneda'   = space(5),                                                                            -- nemotecnico moneda
                'nemomonpacto' = space(5),                                                                            -- nemotecnico moneda del pacto 
                'nfpinipacto'  = space(25),
   'tipoper' = case MDMO.motipoper when 'RCA' then 'ANTICIPADA' else '' end
         from   MDMO, VIEW_CLIENTE   VIEW_CLIENTE, VIEW_ENTIDAD MDRC, VIEW_EMISOR MDEM, MDAC
         where  (MDMO.motipoper = 'RC' or MDMO.motipoper = 'RCA') 
  and MDMO.mostatreg is null
  and MDMO.morutcli = VIEW_CLIENTE.clrut
  and MDMO.morutcart = MDRC.rcrut
  and MDMO.morutemi  *= MDEM. emrut
     -- tipo cartera.-
       update #TEMP set tipocartera  = isnull( MDTC.tbglosa, '')
       from   VIEW_TABLA_GENERAL_DETALLE
       where  MDTC.tbcateg  = 204        
       and    tcartera       = convert(numeric(6),MDTC.tbcodigo1)
     -- nemottcnico moneda emision.-
        update #TEMP 
 set nemomoneda   = isnull( VIEW_MONEDA.mnnemo, '')
        from   VIEW_MONEDA VIEW_MONEDA
        where  cmonemi   = VIEW_MONEDA.mncodmon
     -- nemottcnico moneda pacto.-
        update #TEMP 
 set nemomonpacto = isnull( VIEW_MONEDA.mnnemo, '')
        from   VIEW_MONEDA VIEW_MONEDA
        where  cmonedapacto            = VIEW_MONEDA.mncodmon
     --  glosa forma de pago vencimiento del pacto.-
        update #TEMP 
 set nfpvctopacto    = isnull( MDTC.tbglosa, '') 
        from   VIEW_TABLA_GENERAL_DETALLE
        where  MDTC.tbcateg  = 1  --forma pago 
        and    fpvctopacto    = convert(numeric(6),MDTC.tbcodigo1)
     
     -- custodia.-
       update #TEMP
       set custodia     = case tipocustodia when 'S' then 'CON CUSTODIA' else 'SIN CUSTODIA' end 
     -- pago hoy.-
       update #TEMP 
       set pagohoy = case cpagohoy  when 'N' then 'PAGO MAANA'  else '' end
     -- seleccionamos solo los campos que necesitamos imprimir de la tabla temporal.-      
       select   nomprop      ,
  rutprop      ,
    fec_pro      ,
              fec_rep      ,
                cliente      ,
                cartera      ,
                tipocartera  ,
                ndoc         ,
                serie        ,
                emisor       ,
                nemomoneda   ,
                nominal      ,
                tir          ,
                vc           ,
                tasest       ,
  interes      ,
                fecinipacto  ,
                tasapacto    ,
                basepacto    ,
                nemomonpacto ,
                vinipacto    ,
                vvctopacto   ,
                nfpvctopacto ,
                custodia     ,
                pagohoy      ,
  tipoper      ,
  numdocu      ,
  correla
       into    #TEMP1
       from    #TEMP
       order by numdocu + correla       
       execute (@cbuffer)
       select  @cexecute = 'master.dbo.xp_cmdshell "bcp bt_chile..' + @carchivo +' out c:\btchile\inforc\' + @carchivo + '.txt /c /t, /r \n /sbac-srv /usa /pethernet"'
       execute  ( @cexecute )
     -- combinar los datos con la cabecera.-
       select  @cexecute = 'master.dbo.xp_cmdshell "copy c:\btchile\inforc\inforc.txt+c:\btchile\inforc\'+ @carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat"'
       execute (@cexecute)
       select @cmacro = 'drop table ' + @carchivo
       execute (@cmacro)
       select  @ceject = 'master.dbo.xp_cmdshell "del c:\btchile\inforc\' + @carchivo + '.txt"'
       execute (@ceject)
end
GO
