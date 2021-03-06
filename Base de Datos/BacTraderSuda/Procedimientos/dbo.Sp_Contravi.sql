USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Contravi]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_contravi    fecha de la secuencia de comandos: 05/04/2001 13:13:19 ******/
create procedure [dbo].[Sp_Contravi]( @nrutcart numeric(09,0),
                                @nnumoper numeric(10,0) )
  as
  begin
set nocount on
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
    totalc  numeric(19,4)  null,
  totalr  numeric(19,4)  null,
    mtoesc  char(110) null,
  forpai  char(25)        null,
  forpav          char(25)        null,
           fec_venta       char(40)       null,
  custodia        char(25)        null,
           serie    char(12)       null,
           emisor   char(10)       null,
    nominal  numeric(19,4)  null,
  fecemi  char(10) null,
  fecven  char(10) null,
           tasa    numeric(09,4)  null,
           totali  numeric(19,4)  null,
  totalv  numeric(19,4)  null
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
        declare @totalc   numeric(19,4)
        declare @totalr   numeric(19,4)
 declare @ceject   char(80)
 declare @monpac   char(5)
 declare @mtoesc   char(170)
 declare @x   integer
 declare @total   numeric(19,4)
 declare @forpai   char(25)
 declare @forpav   char(25)
 declare @cust     char(1)
 declare @custodia char(25)
-------------
-- declare @nrutcart numeric(09,0)
--        declare @nnumoper numeric(10,0)
-- select  @nrutcart =1
--        select  @nnumoper = 21
--------------
        select @user   = 'CONTRVI'      
        select @carchivo = ltrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,10 ,1,'_')
        select @carchivo = stuff( @carchivo,13,1,'_')      
        select @carchivo = stuff( @carchivo,16,1,'_')
        select @carchivo = ltrim(@carchivo)
        select @cbuffer  = "select * into " + @carchivo  + " from #TEMP"
 select @x=1
 -- obtiene la forma de pago de la compra
 select @forpai = a.glosa 
 from   VIEW_FORMA_DE_PAGO a, MDMO b
        where  a.codigo = b .moFORPAGi 
        and    b.monumoper = @nnumoper                
        and    b.morutcart = @nrutcart
 and    motipoper = 'VI'
 and    mostatreg  <> 'A'
 -- obtiene la forma de pago al vencimiento de la compra con pacto
 select @forpav = a.glosa 
 from   VIEW_FORMA_DE_PAGO a, MDMO b
        where  a.codigo  = b.moFORPAGv
        and    b.monumoper = @nnumoper
        and    b.morutcart = @nrutcart
 and    motipoper = 'VI'
 and    mostatreg <> 'A'
 -- obtiene la custodia
        select @cust = b.mocondpacto 
        from   MDMO b
        where  b.monumoper = @nnumoper
        and    b.morutcart = @nrutcart
 and    motipoper = 'VI'
 and    mostatreg  <> 'A'
        if @cust = 'S'
           select @custodia = 'Con Custodia'
        else
           select @custodia = 'Sin Custodia'
 -- obtiene monto total de compra
 select @totalc= (select round(sum(movalinip),2) from MDMO
   where  monumoper = @nnumoper
        and    morutcart = @nrutcart
 and    motipoper = 'VI'
 and    mostatreg  <> 'A'
 )
 -- obtiene monto total de recompra
 select @totalr= (select round(sum(movalvenp),2) from MDMO
   where  monumoper = @nnumoper
        and    morutcart = @nrutcart
 and    motipoper = 'VI'
 and    mostatreg <> 'A' )
 
        -- formateamos fecha de vencimiento del pacto
 select @ndiasem = datepart(weekday,MDMO.mofecvenp)  ,
               @ndia    = datepart(day,MDMO.mofecvenp)  ,
               @nmes    = datepart(month,MDMO.mofecvenp),
               @nann    = datepart(year,MDMO.mofecvenp)
        from   MDMO
        where  MDMO.monumoper = @nnumoper 
 and MDMO.morutcart = @nrutcart
 and    motipoper = 'VI'
 and    mostatreg <> 'A'
        if @nmes =  1  select @cfecven = convert(char(2),@ndia) + ' de Enero de '      + convert(char(4),@nann)
        if @nmes =  2  select @cfecven = convert(char(2),@ndia) + ' de Febrero de '    + convert(char(4),@nann)
        if @nmes =  3  select @cfecven = convert(char(2),@ndia) + ' de Marzo de '      + convert(char(4),@nann)
        if @nmes =  4  select @cfecven = convert(char(2),@ndia) + ' de Abril de '      + convert(char(4),@nann)
        if @nmes =  5  select @cfecven = convert(char(2),@ndia) + ' de Mayo de '       + convert(char(4),@nann)
        if @nmes =  6  select @cfecven = convert(char(2),@ndia) + ' de Junio de '      + convert(char(4),@nann)
        if @nmes =  7  select @cfecven = convert(char(2),@ndia) + ' de Julio de '      + convert(char(4),@nann)
        if @nmes =  8  select @cfecven = convert(char(2),@ndia) + ' de Agosto de '     + convert(char(4),@nann)
        if @nmes =  9  select @cfecven = convert(char(2),@ndia) + ' de Septiembre de ' + convert(char(4),@nann)
        if @nmes = 10  select @cfecven = convert(char(2),@ndia) + ' de Octubre de '    + convert(char(4),@nann)
        if @nmes = 11  select @cfecven = convert(char(2),@ndia) + ' de Noviembre de '  + convert(char(4),@nann)
        if @nmes = 12  select @cfecven = convert(char(2),@ndia) + ' de Diciembre de '  + convert(char(4),@nann)
        if @ndiasem = 1 select @cfecven = 'Domingo '   + @cfecven
        if @ndiasem = 2 select @cfecven = 'Lunes '     + @cfecven
        if @ndiasem = 3 select @cfecven = 'Martes '    + @cfecven
        if @ndiasem = 4 select @cfecven = 'Mitrcoles ' + @cfecven
        if @ndiasem = 5 select @cfecven = 'Jueves '    + @cfecven
        if @ndiasem = 6 select @cfecven = 'Viernes '   + @cfecven
        if @ndiasem = 7 select @cfecven = 'Sabado '    + @cfecven
        -- obtiene rut del cliente
        
 select  @rutcli = MDMO.morutcli
        from  MDMO
        where MDMO.morutcart = @nrutcart 
        and   MDMO.monumoper = @nnumoper
 and   MDMO.motipoper = 'VI'
 and   MDMO.mostatreg is null
 -- con el rut del cliente trae datos varios del cliente desde VIEW_CLIENTE
 
 select  @nomcli = c.clnombre , 
  @dircli = c.cldirecc , 
  @foncli = c.clfono ,
                @dig    = c.cldv 
        from  VIEW_CLIENTE c, VIEW_TABLA_GENERAL_DETALLE  v
 where c.clrut    = @rutcli
 
 select  @comcli = v.nom_ciu
        from  VIEW_CLIENTE c, VIEW_CIUDAD_COMUNA v
 where c.clrut    = @rutcli
 and   v.cod_ciu = c.clciudad
 and   v.cod_com = c.clcomuna 
 
 -- obtiene la moneda del pacto
 
 select   @monpac = q.mnnemo
      from     VIEW_MONEDA  q, MDMO w
        where    w.morutcart = @nrutcart 
        and      w.monumoper = @nnumoper
 and      w.motipoper = 'VI'
 and      w.mostatreg is null
 and  w.momonpact = q.mncodmon
 -- datos de la empresa y fecha de proceso
        select @nomemp      = isnull( MDAC.acnomprop,'') ,
               @fecpro      = isnull( convert (char(10), MDAC.acfecproc, 103), ''),
        @diremp     = isnull( MDAC.acdirprop,''), 
        @comemp      = isnull( MDAC.accomprop,'') 
 from MDAC
 -- obtiene el monto a pagar expresado en palabras
  execute @mtoesc= Sp_MontoEscrito @totalc, @mtoesc output
        -- inserta registros en la tabla TEMPORAL
 select  'nomemp'       = isnull( @nomemp,''),
  'diremp' = isnull( @diremp,''),
  'comemp' = isnull( @comemp,''),
         'numoper'      = isnull( a.monumoper,0),
         'fecpro'       = isnull( @fecpro,''),
         'nomcli'      = isnull( @nomcli ,''),
         'dircli'       = isnull( @dircli ,''), 
  'comcli' = isnull( @comcli ,''),
         'foncli'        = isnull( @foncli ,''),
  'rutcli' = isnull( @rutcli,0 ),
    'digveri' = isnull( @dig,''),
  'monpacto' = isnull( @monpac,''),
         'totalc'       = isnull( @totalc,0),
  'totalr' = isnull( @totalr,0),
  'mtoesc' = isnull( substring(@mtoesc,1,110),''),
  'forpai'        = isnull( @forpai,'') ,
  'forpav'        = isnull( @forpav,'') ,
  'fec_venta'     = isnull( @cfecven,'') ,
  'custodia'      = isnull( @custodia,''), 
         'serie'        = isnull( a.moinstser,''),
  'emisor'       = isnull( s.emgeneric,''),
         'nominal'      = isnull( a.monominal,0),
  'fecemi' = isnull( convert(char(10), a.mofecemi,103) ,'') ,
  'fecven' = isnull( convert(char(10), a.mofecven,103) ,'') ,
         'tasa'         = isnull( a.motir ,0),
         'totali'        = isnull( round(a.movalinip,2),0),
  'totalv'        = isnull( round(a.movalvenp,2),0)
 into #TEMP1
        from  MDMO a, VIEW_EMISOR s
        where a.morutcart = @nrutcart
        and   a.monumoper = @nnumoper
 and   a.motipoper = 'VI'
 and   a.mostatreg is null
  and   a.morutemi  = s.emrut
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
    totalr  = #TEMP1.totalr,
    mtoesc  = #TEMP1.mtoesc,
    forpai          = #TEMP1.forpai,
    forpav          = #TEMP1.forpav,
    fec_venta       = #TEMP1.fec_venta,
    custodia        = #TEMP1.custodia,
           serie        = space(12),
    emisor       = space(10),
           nominal      = 0,
    fecemi  = space(10),
    fecven  = space(10),
           tasa         = 0,
           totali        = 0,
           totalv        = 0
                 from #TEMP1
   set rowcount 0
 end
 if exists ( select * from #TEMP1)
 begin
   insert #TEMP
   select  nomemp       = 'b,'+#TEMP1.nomemp,
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
    totalr  = #TEMP1.totalr,
    mtoesc  = #TEMP1.mtoesc,
    forpai          = space(25),
    forpav          = space(25),
    fec_venta       = space(40),
    custodia        = space(25),
           serie        = #TEMP1.serie,
    emisor       = #TEMP1.emisor,
           nominal      = #TEMP1.nominal,
    fecemi  = #TEMP1.fecemi,
    fecven  = #TEMP1.fecven,
           tasa         = #TEMP1.tasa,
           totali        = #TEMP1.totali,
    totalv         = #TEMP1.totalv
                 from #TEMP1
        end
        execute (@cbuffer)
        select  @cexecute = "master.dbo.xp_cmdshell 'bcp bt_chile..' + @carchivo +' out c:\btchile\papelvi\' + @carchivo + '.txt /c /t, /r \n /sbac-srv /usa /pethernet'"
        execute  ( @cexecute )
     -- combinar  los datos con la cabecera.-
        select   @cexecute = "master.dbo.xp_cmdshell 'copy c:\btchile\papelvi\contvi.txt+c:\btchile\papelvi\'+@carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat'"
        execute (@cexecute)
        select @cmacro = "drop table " + @carchivo
        execute (@cmacro)
 select  @ceject = "master.dbo.xp_cmdshell 'del c:\btchile\papelvi\' + @carchivo + '.txt'"
        execute (@ceject)
end
GO
