USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Infocp]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_infocp    fecha de la secuencia de comandos: 05/04/2001 13:13:32 ******/
create procedure [dbo].[Sp_Infocp]
 as
 begin
set nocount on
        declare @carchivo varchar(30)
        declare @cbuffer  varchar(60)
        declare @cexecute varchar(200)
        declare @user     char(30)
        declare @cmacro   char(30)
        declare @largo    numeric(5)
        declare @ceject   char(80)
     -- determina nombre de archivos temporales
        select @user     = 'inforcp'
        select @largo    = convert(numeric(5,0),datalength(rtrim(@user)))
        select @carchivo = rtrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,10,1,'_')
        select @carchivo = stuff( @carchivo,13,1,'_')
        select @carchivo = stuff( @carchivo,16,1,'_')
        select @carchivo = ltrim(@carchivo)
        select @cbuffer  = "select * into " + @carchivo  + " from #TEMP3"
        SELECT 'EMPRESA'    = 'A,'+isnull(MDAC.acnomprop,''),
             'rutpro'     = isnull(rtrim(convert(char(9),MDAC.acrutprop))+'-'+MDAC.acdigprop,'sin rut') ,
             'fec_pro'    = isnull(convert(char(10),MDAC.acfecproc,103),''),
             'fec_rep'    = isnull(convert(char(10),MDAC.acfecproc,103),''),
      'cliente'    = space(40),
      'cartera'    = space(50),
      't_cartera'  = space(25),
      'nídocumento'= space(14),
      'serie'      = space(12),
             'emisor'     = space(10),
      'f_emi'      = space(10),
      'f_vto'      = space(10),
             'tas_emi'    = convert(numeric(09,4),0),
             'bas_emi'    = convert(numeric(03,0),0),
      'mon_emi'    = space(5),
      'nominal'    = convert(numeric(19,4),0),
      'tir'        = convert(numeric(09,4),0),
             'pvp'        = convert(numeric(07,2),0),
      'tas_est'    = convert(numeric(09,4),0),
      'compra'     = convert(numeric(19,4),0),
             'compra_um'  = convert(numeric(19,4),0),
             'f_pago'     = space(25),
             't_mercado'  = space(25),
             't_custod'   = space(25),
      'pago_hoy'   = space(25),
             'numdoc'     = 0,
             'correla'    = 0
      into #TEMP3
      from MDAC
      select 'empresa'    = isnull(a.acnomprop,''),
             'rutpro'     = isnull(rtrim(convert(char(9),a.acrutprop))+'-'+a.acdigprop,'sin rut') ,
             'fec_pro'    = isnull(convert(char(10),a.acfecproc,103),''),
             'fec_rep'    = isnull(convert(char(10),a.acfecproc,103),''),
      'cliente'    = isnull(c.clnombre,''),
      'cartera'    = isnull(d.rcnombre,''),
      't_cartera'  = isnull(b.motipcart,0),
      'nídocumento'= isnull(rtrim(convert(char(7),b.monumoper))+'-'+convert(char(3),b.mocorrela),''),
      'serie'      = isnull(b.moinstser,''),
             'emisor'     = isnull(e.emgeneric,''),
      'f_emi'      = isnull(convert(char(10),b.mofecemi,103),''),
      'f_vto'      = isnull(convert(char(10),b.mofecven,103),''),
             'tas_emi'    = isnull(b.motasemi,0),
             'bas_emi'    = isnull(b.mobasemi,0),
      'mon_emi'    = isnull(f.mnnemo,''),
      'nominal'    = isnull(b.monominal,0),
      'tir'        = isnull(b.motir,0),
             'pvp'        = isnull(b.mopvp,0),
      'tas_est'    = isnull(b.motasest,0),
      'compra'     = isnull(b.momtps,0),
             'compra_um'  = isnull(b.momtum,0),
             'f_pago'     = isnull(b.moforpagi,0),
             't_mercado'  = case b.motipobono when 's' then 'secundario' else 'primario' end,
             't_custod'   = 'propia',
      'pago_hoy'   = case b.mopagohoy when 'n' then 'pago ma-ana' else ' ' end,
             'numdoc'     = isnull(b.monumoper,0),
             'correla'    = isnull(b.mocorrela,0)
        into #TEMP
 from  MDAC a, 
  MDMO b, 
  VIEW_CLIENTE    c, 
  VIEW_ENTIDAD d, 
  VIEW_EMISOR  e, 
  VIEW_MONEDA f
        where b.motipoper='CP ' and b.mostatreg is null and
              c.clrut=b.morutcli and d.rcrut=b.morutcart and
       e.emrut=b.morutemi and f.mncodmon=b.momonemi
 -- sacar glosa de la forma de pago
        select 'empresa'    = #TEMP.empresa,
               'rutpro'     = #TEMP.rutpro,
               'fec_pro'    = #TEMP.fec_pro,
               'fec_rep'    = #TEMP.fec_rep,
        'cliente'    = #TEMP.cliente,
        'cartera'    = #TEMP.cartera,
        't_cartera'  = isnull(MDTC.tbglosa,''),
        'nídocumento'= #TEMP.nídocumento,
        'serie'      = #TEMP.serie,
               'emisor'     = #TEMP.emisor,
        'f_emi'      = #TEMP.f_emi,
        'f_vto'      = #TEMP.f_vto,
               'tas_emi'    = #TEMP.tas_emi,
               'bas_emi'    = #TEMP.bas_emi,
        'mon_emi'    = #TEMP.mon_emi,
        'nominal'    = #TEMP.nominal,
        'tir'        = #TEMP.tir,
               'pvp'        = #TEMP.pvp,
        'tas_est'    = #TEMP.tas_est, 
        'compra'     = #TEMP.compra,
               'compra_um'  = #TEMP.compra_um,
               'f_pago'     = #TEMP.f_pago,
               't_mercado'  = #TEMP.t_mercado,
               't_custod'   = #TEMP.t_custod,
        'pago_hoy'   = #TEMP.pago_hoy,
               'numdoc'     = #TEMP.numdoc,
               'correla'    = #TEMP.correla
        into #TEMP1
 from #TEMP, VIEW_TABLA_GENERAL_DETALLE
        where MDTC.tbcateg=204 and convert(numeric(6),MDTC.tbcodigo1)=#TEMP.t_cartera
 -- sacar glosa de la forma de pago
        SELECT 'EMPRESA'    = 'B,'+#TEMP1.empresa,
               'rutpro'     = #TEMP1.rutpro,
               'fec_pro'    = #TEMP1.fec_pro,
               'fec_rep'    = #TEMP1.fec_rep,
        'cliente'    = #TEMP1.cliente,
        'cartera'    = #TEMP1.cartera,
        't_cartera'  = #TEMP1.t_cartera,
        'nídocumento'= #TEMP1.nídocumento,
        'serie'      = #TEMP1.serie,
               'emisor'     = #TEMP1.emisor,
        'f_emi'      = #TEMP1.f_emi,
        'f_vto'      = #TEMP1.f_vto,
               'tas_emi'    = #TEMP1.tas_emi,
               'bas_emi'    = #TEMP1.bas_emi,
        'mon_emi'    = #TEMP1.mon_emi,
        'nominal'    = #TEMP1.nominal,
        'tir'        = #TEMP1.tir,
               'pvp'        = #TEMP1.pvp,
        'tas_est'    = #TEMP1.tas_est, 
        'compra'     = #TEMP1.compra,
               'compra_um'  = #TEMP1.compra_um,
               'f_pago'     = isnull(MDTC.tbglosa,''),
               't_mercado'  = #TEMP1.t_mercado,
               't_custod'   = #TEMP1.t_custod,
        'pago_hoy'   = #TEMP1.pago_hoy,
               'numdoc'     = #TEMP1.numdoc,
               'correla'    = #TEMP1.correla
        into #TEMP2
 from #TEMP1, VIEW_TABLA_GENERAL_DETALLE
        where MDTC.tbcateg=1 and convert(numeric(6),MDTC.tbcodigo1)=#TEMP1.f_pago
 order by #TEMP1.numdoc + #TEMP1.correla
 insert into #TEMP3
  select * from #TEMP2
        execute (@cbuffer)
        select  @cexecute = 'master.dbo.xp_cmdshell "bcp bt_chile..' + @carchivo +' out c:\btchile\infocp\' + @carchivo + '.txt /c /t, /r \n /sbac-srv /usa /pethernet"'
        execute  ( @cexecute )
     -- combinar los datos con la cabecera.-
        select  @cexecute = 'master.dbo.xp_cmdshell "copy c:\btchile\infocp\einfocp.txt+c:\btchile\infocp\'+ @carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat"'
        execute (@cexecute)
 select @cmacro= 'drop table ' + @carchivo
 execute (@cmacro)
        select  @ceject = 'master.dbo.xp_cmdshell "del c:\btchile\infocp\' + @carchivo + '.txt"'
        execute (@ceject)
end
GO
