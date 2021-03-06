USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Infoib]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_infoib    fecha de la secuencia de comandos: 05/04/2001 13:13:32 ******/
create procedure [dbo].[Sp_Infoib]
 as
 begin
set nocount on
 declare @carchivo varchar(30)
        declare @cbuffer  varchar(60)
        declare @cexecute varchar(200)
 declare @largo    numeric(5)
 declare @user   char(30)
        declare @cmacro   char(30)
 declare @ceject   char(80)
       -- determina nombre de archivos temporales
        select @user     = 'inforib'
 select @largo    = convert(numeric(5,0),datalength(rtrim(@user)))
        select @carchivo = rtrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,10,1,'_')
        select @carchivo = stuff( @carchivo,13,1,'_')
        select @carchivo = stuff( @carchivo,16,1,'_')
        select @carchivo = ltrim(@carchivo)
        select @cbuffer  = "select * into " + @carchivo  + " from #TEMP2"
----- sacar encabezado del reporte------------
 select 'empresa' = 'a,'+isnull(MDAC.acnomprop,''),
              'rutpro' = isnull(rtrim(convert(char(9),MDAC.acrutprop)) +'-'+ MDAC.acdigprop,''),
              'fec_pro' = isnull(convert(char(10),MDAC.acfecproc,103),''),
              'fec_rep'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
  'cliente' = space(40),
  'cartera' = space(50),
  't_cartera' = space(25),
  'numoper' = 0,
  'tipoper' = space(3),
  'plazo'  = 0,
  'f_venci' = space(10),
  'moneda' = space(5),
  'base'  = isnull(convert(numeric(3,0),0),0),
  'valor_moneda' = isnull(convert(numeric(19,2),0),0),
  'monto_inicial' = isnull(convert(numeric(19,2),0),0),
  'interes' = isnull(convert(numeric(09,2),0),0),
  'monto_final' = isnull(convert(numeric(19,2),0),0),
  'f_p_venci' = space(25),
  'pagohoy' = space(25),
  'cod_cartera' = 0,
  'cod_fpven' = 0
 into #TEMP
 from MDAC
-------- obtener la data del reporte --------------------------------
 insert #TEMP
 select 'empresa' = 'b,'+isnull(MDAC.acnomprop,''),
              'rutpro' = isnull(rtrim(convert(char(9),MDAC.acrutprop)) +'-'+ MDAC.acdigprop,''),
              'fec_pro' = isnull(convert(char(10),MDAC.acfecproc,103),''),
              'fec_rep'     = isnull(convert(char(10),MDAC.acfecproc,103),''),
  'cliente' = isnull(VIEW_CLIENTE.clnombre,''),
  'cartera' = isnull(MDRC.rcnombre,''),
  't_cartera' = space(25),
  'numoper' = isnull(MDMO.monumoper,0),
  'tipoper' = case MDMO.moinstser when 'icol' then 'col' else 'cap' end,
  'plazo'  = convert(numeric(4,0),datediff(dd,MDMO.mofecemi,MDMO.mofecven)),
  'f_venci' = isnull(convert(char(10),MDMO.mofecven,103),''),
  'moneda' = isnull(VIEW_MONEDA.mnnemo,''),
  'base'  = convert(numeric(3,0),MDMO.mobaspact),
  'valor_moneda' = convert(numeric(19,2), (MDMO.momtps / MDMO.movpresen)),
  'monto_inicial' = convert(numeric(19,2),MDMO.movalinip),
  'interes' = convert(numeric(09,2),MDMO.motaspact),
  'monto_final' = convert(numeric(19,2),MDMO.movalvenp),
  'f_p_venci' = space(25),
  'pagohoy' = case MDMO.mopagohoy when 'n' then 'pago ma-ana' else '' end,
  'cod_cartera' = isnull(MDMO.motipcart,0),
  'cod_fpven' = isnull(MDMO. moforpagv,0) 
 from  MDAC, MDMO,VIEW_MONEDA VIEW_MONEDA, VIEW_ENTIDAD MDRC, VIEW_CLIENTE   VIEW_CLIENTE
        where MDMO.motipoper = 'IB' 
        and   MDMO.mostatreg is null
 and   VIEW_MONEDA.mncodmon = MDMO.momonpact
        and   MDRC.rcrut = MDMO.morutcart
        and   VIEW_CLIENTE.clrut = MDMO.morutcli
 -- obtiene forma de pago al vencimiento
 update #TEMP
        set f_p_venci =  MDTC.tbglosa
 from VIEW_TABLA_GENERAL_DETALLE, MDMO
        where MDTC.tbcateg=1
        and   convert(numeric(6),MDTC.tbcodigo1) = #TEMP.cod_fpven
 -- obtiene el tipo de cartera
 update #TEMP
        set t_cartera =  MDTC.tbglosa
 from VIEW_TABLA_GENERAL_DETALLE, MDMO
        where MDTC.tbcateg=204
        and   convert(numeric(6),MDTC.tbcodigo1) = #TEMP.cod_cartera
 select * into #TEMP2
        from #TEMP
        order by #TEMP.numoper
        execute (@cbuffer)
        select  @cexecute = 'master.dbo.xp_cmdshell "bcp bt_chile..' + @carchivo +' out c:\btchile\infoib\' + @carchivo + '.txt /c /t, /r \n /sbac-srv /usa /pethernet2"'
        execute  ( @cexecute )
     -- combinar los datos con la cabecera.-
        select  @cexecute = 'master.dbo.xp_cmdshell "copy c:\btchile\infoib\einfoib.txt+c:\btchile\infoib\'+ @carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat"'
        execute (@cexecute)
        select @cmacro = "drop table " + @carchivo
        execute (@cmacro)
        select  @ceject = 'master.dbo.xp_cmdshell "del c:\btchile\infoib\' + @carchivo + '.txt"'
        execute (@ceject)
 end
GO
