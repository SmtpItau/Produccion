USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Contraci]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_contraci    fecha de la secuencia de comandos: 05/04/2001 13:13:19 ******/
create procedure [dbo].[Sp_Contraci](@nrutcart numeric(09,0),
                               @nnumoper numeric(10,0))
  as
  begin
 create table #TEMP
        ( nomemp   char(40) null,
    diremp   char(40) null,
    comemp   char(25) null,
    numoper  numeric(10,0)  null,
  fecpro  char(10) null,
  nomcli  char(40) null,
           dircli         char(40)  null,
         comcli         char(25)       null,
           foncli         char(15)  null,
           rutcli         numeric(09,0)   null,
    digveri  char(1)  null,
    monpacto  char(5)         null,
    totalc  numeric(19,2)  null,
    mtoesc  char(110) null,
         serie    char(12)       null,
           emisor   char(10)       null,
   nominal  numeric(19,2)  null,
  fecemi  char(10) null,
  fecven  char(10) null,
         tasa    numeric(09,4)  null,
         total  numeric(19,2)  null,
         fec_venta       char(40)       null,
  plazo           numeric(04,0)   null,
  tasapacto       numeric(09,4)   null,
  totalr  numeric(19,4)  null,
         serie2    char(12)       null,
         emisor2   char(10)       null,
    nominal2  numeric(19,2)  null,
  fecemi2  char(10) null,
  fecven2  char(10) null,
         tasa2    numeric(09,4)  null,
         total2  numeric(19,2)  null
 )
        -- declaro variables
        declare @ndiasem  integer
        declare @ndia     integer
        declare @nmes     integer
        declare @nann     integer
        declare @cfecven  char(40)
        declare @rutcli   numeric(9,0)
        declare @dig      char(1)
        declare @nomcli   char(40)
        declare @dircli   char(40)
        declare @foncli   char(15)
        declare @comcli   char(25)
        declare @carchivo varchar(30)
        declare @cbuffer  varchar(60)
        declare @cexecute varchar(200)
        declare @user     varchar(100)
        declare @nomemp   char(40)
        declare @fecpro   char(10)
        declare @diremp   char(40)
        declare @comemp   char(25)
        declare @cmacro   char(30)
        declare @totalc   numeric(19,2)
        declare @totalr   numeric(19,4)
        declare @ceject   char(80)
        declare @monpac   char(5)
        declare @mtoesc   char(170)
        declare @x   integer
        declare @total   numeric(19,2)
        select @user   = 'contrci'      
        select @carchivo = ltrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,10 ,1,'_')
        select @carchivo = stuff( @carchivo,13,1,'_')      
        select @carchivo = stuff( @carchivo,16,1,'_')
        select @carchivo = ltrim(@carchivo)
        select @cbuffer  = "select * into " + @carchivo  + " from #TEMP"
 select @x=1
 -- obtiene monto total de compra
 select @totalc=(select convert(numeric(19,2),round(sum(movalinip),2)) from MDMO
   where  monumoper = @nnumoper
         and    morutcart = @nrutcart
 and    motipoper = 'CI'
 and    mostatreg is null
 )
 -- obtiene monto total de reventa
 select @totalr=(select round(sum(movalvenp),2) from MDMO
   where  monumoper = @nnumoper
         and    morutcart = @nrutcart
 and    motipoper = 'CI'
 and    mostatreg is null
 )
        -- formateamos fecha de vencimiento del pacto
 select @ndiasem = datepart(weekday,MDMO.mofecvenp)  ,
               @ndia    = datepart(day,MDMO.mofecvenp)  ,
               @nmes    = datepart(month,MDMO.mofecvenp),
               @nann    = datepart(year,MDMO.mofecvenp)
        from   MDMO
        where  MDMO.monumoper = @nnumoper 
 and MDMO.morutcart = @nrutcart
 and    motipoper = 'CI'
 and    mostatreg is null
        if @nmes =  1  select @cfecven = convert(char(2),@ndia) + ' de enero de '      + convert(char(4),@nann)
        if @nmes =  2  select @cfecven = convert(char(2),@ndia) + ' de febrero de '    + convert(char(4),@nann)
        if @nmes =  3  select @cfecven = convert(char(2),@ndia) + ' de marzo de '  + convert(char(4),@nann)
        if @nmes =  4  select @cfecven = convert(char(2),@ndia) + ' de abril de '      + convert(char(4),@nann)
        if @nmes =  5  select @cfecven = convert(char(2),@ndia) + ' de mayo de '       + convert(char(4),@nann)
        if @nmes =  6  select @cfecven = convert(char(2),@ndia) + ' de junio de '      + convert(char(4),@nann)
        if @nmes =  7  select @cfecven = convert(char(2),@ndia) + ' de julio de '      + convert(char(4),@nann)
        if @nmes =  8  select @cfecven = convert(char(2),@ndia) + ' de agosto de '     + convert(char(4),@nann)
        if @nmes =  9  select @cfecven = convert(char(2),@ndia) + ' de septiembre de ' + convert(char(4),@nann)
        if @nmes = 10  select @cfecven = convert(char(2),@ndia) + ' de octubre de '    + convert(char(4),@nann)
        if @nmes = 11  select @cfecven = convert(char(2),@ndia) + ' de noviembre de '  + convert(char(4),@nann)
        if @nmes = 12  select @cfecven = convert(char(2),@ndia) + ' de diciembre de '  + convert(char(4),@nann)
        if @ndiasem = 1 select @cfecven = 'domingo '   + @cfecven
        if @ndiasem = 2 select @cfecven = 'lunes '     + @cfecven
        if @ndiasem = 3 select @cfecven = 'martes '    + @cfecven
        if @ndiasem = 4 select @cfecven = 'mitrcoles ' + @cfecven
        if @ndiasem = 5 select @cfecven = 'jueves '    + @cfecven
        if @ndiasem = 6 select @cfecven = 'viernes '   + @cfecven
        if @ndiasem = 7 select @cfecven = 'sabado '    + @cfecven
        -- obtiene rut del cliente
        
 select  @rutcli = MDMO.morutcli
        from  MDMO
        where MDMO.morutcart = @nrutcart 
        and   MDMO.monumoper = @nnumoper
 and   MDMO.motipoper = 'CI'
 and   MDMO.mostatreg is null
 -- con el rut del cliente trae datos varios del cliente desde VIEW_CLIENTE
 
 select  @nomcli = a.clnombre , 
  @dircli = a.cldirecc , 
  @foncli = a.clfono ,
                @dig    = a.cldv 
        from  VIEW_CLIENTE a, VIEW_TABLA_GENERAL_DETALLE s
 where a.clrut = @rutcli
 select   @comcli = nom_ciu   
        from  VIEW_CLIENTE a, VIEW_CIUDAD_COMUNA b
 where a.clrut = @rutcli  
       and   b.cod_ciu = a.clciudad  
       and   b.cod_com = a.clcomuna
 -- obtiene la moneda del pacto
 
 select   @monpac = x.mnnemo
      from     VIEW_MONEDA  x, MDMO y
        where    y.morutcart = @nrutcart 
        and      y.monumoper = @nnumoper
 and      y.motipoper = 'CI'
 and      y.mostatreg is null
 and  y.momonpact = x.mncodmon
 -- datos de la empresa y fecha de proceso
        select @nomemp      = isnull( MDAC.acnomprop,'') ,
               @fecpro      = isnull( convert (char(10), MDAC.acfecproc, 103), ''),
        @diremp     = isnull( MDAC.acdirprop,''), 
        @comemp      = isnull( MDAC.accomprop,'') 
 from MDAC
 -- obtiene el monto a pagar expresado en palabras
  execute @mtoesc= Sp_MontoEscrito @totalc, @mtoesc output
        -- inserta registros en la tabla TEMPORAL
 select  'nomemp'       = isnull( @nomemp,'') ,
  'diremp' = isnull( @diremp,''),
  'comemp' = isnull( @comemp,''),
         'numoper'      = isnull( a.monumoper,0),
         'fecpro'       = isnull( @fecpro,'') ,
         'nomcli'      = isnull( @nomcli ,''),
         'dircli'       = isnull( @dircli ,''), 
  'comcli' = isnull( @comcli ,''),
         'foncli'        = isnull( @foncli ,''),
  'rutcli' = isnull( @rutcli,0 ),
    'digveri' = isnull( @dig,''),
  'monpacto' = isnull( @monpac,''),
         'totalc'       = isnull( @totalc,0),
  'mtoesc' = isnull( substring(@mtoesc,1,110),''),
         'serie'        = isnull( a.moinstser,'') ,
  'emisor'       = isnull( b.emgeneric,''),
         'nominal'      = isnull( convert(numeric(19,2),a.monominal),0) ,
  'fecemi' = isnull( convert(char(10), a.mofecemi,103) ,'') ,
  'fecven' = isnull( convert(char(10), a.mofecven,103) ,'') ,
         'tasa'         = convert(numeric(9,4),isnull( a.motir, 0) ),
         'total'        = convert(numeric(19,2),isnull( a.movpresen, 0)),
  'fec_venta' = isnull( @cfecven, ''),
  'plazo'  = isnull( datediff( day, a.mofecinip, a.mofecvenp),0) ,
  'tasapacto'    = isnull( a.motaspact, 0) ,
         'totalr'       = isnull( @totalr,0),
         'serie2'        = isnull( a.moinstser,'') ,
  'emisor2'       = isnull( b.emgeneric,''),
         'nominal2'      = isnull( convert(numeric(19,2),a.monominal),0) ,
  'fecemi2' = isnull( convert(char(10), a.mofecemi,103) ,'') ,
  'fecven2' = isnull( convert(char(10), a.mofecven,103) ,'') ,
         'tasa2'         = convert(numeric(9,4),isnull( a.motir, 0) ),
         'total2'        = convert(numeric(19,2),isnull( a.movpresen, 0))
 into #TEMP1
        from  MDMO a, VIEW_EMISOR  b
        where a.morutcart = @nrutcart
        and   a.monumoper = @nnumoper
 and   a.motipoper = 'CI'
 and   a.mostatreg is null
  and   a.morutemi  = b.emrut
  set rowcount 1
 if exists ( select * from #TEMP1)
 begin
   insert #TEMP
   select  nomemp       = 'A,'+#TEMP1.nomemp,
    diremp  = #TEMP1.diremp,
    comemp  = #TEMP1.comemp,
           numoper      = #TEMP1.numoper,          
           fecpro       = #TEMP1.fecpro,
           nomcli      = #TEMP1.nomcli,
           dircli       = #TEMP1.dircli,
    comcli  = #TEMP1.comcli,
           foncli         = #TEMP1.foncli,
    rutcli  = #TEMP1.rutcli,
      digveri  = #TEMP1.digveri,
    monpacto = #TEMP1.monpacto,
           totalc       = #TEMP1.totalc,
    mtoesc  = #TEMP1.mtoesc,
           serie        = space(12),
    emisor       = space(10),
           nominal      = 0,
    fecemi  = space(10),
    fecven  = space(10),
           tasa         = 0,
           total        = 0,
    fec_venta = space(40),
    plazo  = 0,
    tasapacto    = 0,
           totalr       = 0,
           serie2        = space(12),
    emisor2       = space(10),
           nominal2      = 0,
    fecemi2  = space(10),
    fecven2  = space(10),
           tasa2         = 0,
           total2        = 0
                 from #TEMP1
   set rowcount 0
 end
 if exists ( select * from #TEMP1)
 begin
   insert #TEMP
   select  nomemp       = 'b,'+space(40),
    diremp  = space(40),
    comemp  = space(25),
           numoper      = 0,          
           fecpro       = space(10),
           nomcli      = space(40),
           dircli       = space(40),
    comcli  = space(25),
           foncli         = space(15),
    rutcli  = 0,
      digveri  = space(1),
    monpacto = space(5),
           totalc       = 0,
    mtoesc  = space(110),
           serie        = #TEMP1.serie,
    emisor       = #TEMP1.emisor,
           nominal      = #TEMP1.nominal,
    fecemi  = #TEMP1.fecemi,
    fecven  = #TEMP1.fecven,
           tasa         = #TEMP1.tasa,
           total        = #TEMP1.total,
    fec_venta = space(40),
    plazo  = 0,
    tasapacto    = 0,
    totalr       = 0,
           serie2        = space(12),
    emisor2       = space(10),
           nominal2      = 0,
    fecemi2  = space(10),
    fecven2  = space(10),
           tasa2         = 0,
    total2        = 0
                 from #TEMP1
   set rowcount 1
   insert #TEMP
   select  nomemp       = 'c,'+space(40),
    diremp  = space(40),
    comemp  = space(25),
           numoper      = 0,          
           fecpro       = space(10),
           nomcli      = space(40),
           dircli       = space(40),
    comcli  = space(25),
           foncli         = space(15),
    rutcli  = 0,
      digveri  = space(1),
    monpacto = space(5),
           totalc       = 0,
    mtoesc  = space(110),
           serie        = space(12),
    emisor       = space(10),
           nominal      = 0,
    fecemi  = space(10),
    fecven  = space(10),
           tasa         = 0,
           total        = 0,
    fec_venta = #TEMP1.fec_venta,
    plazo  = #TEMP1.plazo,
    tasapacto    = #TEMP1.tasapacto,
    totalr  = #TEMP1.totalr,
           serie2        = space(12),
    emisor2       = space(10),
           nominal2      = 0,
    fecemi2  = space(10),
    fecven2  = space(10),
           tasa2         = 0,
    total2        = 0
                 from #TEMP1
   set rowcount 0
   insert #TEMP
   select  nomemp       = 'D,' + space(40),
    diremp  = space(40),
    comemp  = space(25),
           numoper      = 0,          
           fecpro       = space(10),
           nomcli      = space(40),
           dircli       = space(40),
    comcli  = space(25),
           foncli         = space(15),
    rutcli  = 0,
      digveri  = space(1),
    monpacto = space(5),
           totalc       = 0,
    mtoesc  = space(110),
           serie        = space(12),
    emisor       = space(10),
           nominal      = 0,
    fecemi  = space(10),
    fecven  = space(10),
           tasa         = 0,
           total        = 0,
    fec_venta = space(40),
    plazo  = 0,
    tasapacto    = 0,
    totalr  = 0,
           serie2        = #TEMP1.serie2,
    emisor2       = #TEMP1.emisor2,
           nominal2      = #TEMP1.nominal2,
    fecemi2  = #TEMP1.fecemi2,
    fecven2  = #TEMP1.fecven2,
           tasa2         = #TEMP1.tasa2,
    total2        = #TEMP1.total2
                 from #TEMP1
        end
        execute (@cbuffer)
        select  @cexecute = "master.dbo.xp_cmdshell 'bcp bt_chile..' + @carchivo +' out c:\btchile\papelci\' + @carchivo + '.txt /c /t, /r \n /sbac-srv /usa /pethernet'"
        execute  ( @cexecute )
     -- combinar  los datos con la cabecera.-
        select   @cexecute = "master.dbo.xp_cmdshell 'copy c:\btchile\papelci\contci.txt+c:\btchile\papelci\'+@carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat'"
        execute (@cexecute)
        select @cmacro = "DROP TABLE " + @carchivo
        execute (@cmacro)
 select  @ceject = "master.dbo.xp_cmdshell 'del c:\btchile\papelci\' + @carchivo + '.txt'"
        execute (@ceject)
end
GO
