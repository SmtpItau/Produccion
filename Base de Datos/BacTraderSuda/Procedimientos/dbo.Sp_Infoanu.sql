USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Infoanu]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_infoanu    fecha de la secuencia de comandos: 05/04/2001 13:13:32 ******/
create procedure [dbo].[Sp_Infoanu]
  as
  begin
 set nocount on
 -- crear tabla temporal -------------------
 create table #TEMP
        ( nomemp  char(40) null,
   rut_pro char(11) null,
   fecpro  char(10) null,
   fecrep  char(10) null,
          tipoper char(25) null,
   numdocu numeric(10,0) null,
          correla numeric(3,0)  null,
   numoper numeric(10,0) null,
          serie   char(12)      null,
   nominal numeric(19,4) null,
          tir   numeric(09,4) null,
   pvp     numeric(07,2) null,
          mtps    numeric(19,4) null,
   cliente char(40)      null,
          tot_nom numeric(19,4) null,
   tot_tra numeric(19,4) null,
          oper    char(3) null
 )
-- begin transaction
 -- definiciones de variables
        declare @carchivo varchar(30)
        declare @cbuffer  varchar(60)
        declare @cexecute varchar(200)  
 declare @user     char(30)
 declare @cmacro   char(30)
        declare @ceject   char(80)
 declare @largo    integer
 declare @totnom   numeric(19,4)
        declare @tottra   numeric(19,4)
        -- determina nombre de archivos temporales
        select @user     = 'INFOANU'
 select @largo    = convert(numeric(5,0),datalength(rtrim(@user)))
        select @carchivo = rtrim(@user) + convert(char(14),getdate(),114)
        select @carchivo = stuff( @carchivo,10,1,'_')
        select @carchivo = stuff( @carchivo,13,1,'_')
        select @carchivo = stuff( @carchivo,16,1,'_')
        select @carchivo = ltrim(@carchivo)
        select @cbuffer  = "select * into " + @carchivo  + " from #TEMP"
 -- forma el archivo de datos para el jetform.
 if exists ( select * from MDMO  where  MDMO.mostatreg='A' and MDMO.motipoper='CI')
 begin
  insert #TEMP
   select  nomemp   ='a,'+isnull(MDAC.acnomprop,' '),
           rut_pro  = rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
    fecpro   =convert(char(10),MDAC.acfecproc,103),
    fecrep   =convert(char(10),MDAC.acfecproc,103),
           tipoper  ='compras con pacto',
    numdocu  =0,
           correla  =0,
           numoper  =0,
           serie    =space(12),
           nominal  =0,
                  tir      =0,
                  pvp      =0,
            mtps     =0,
                  cliente  =space(40),
                  tot_nom  =0,
                  tot_tra  =0,
                  oper     =space(3)
          from MDAC  
  insert #TEMP
  select nomemp  ='b,'+isnull(MDAC.acnomprop,' '),
                rut_pro =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro  =convert(char(10),MDAC.acfecproc,103),
         fecrep  =convert(char(10),MDAC.acfecproc,103),
                tipoper =case MDMO.motipoper when 'CI' then 'COMPRAS CON PACTO' when 'CP' then 'COMPRAS DEFINITIVAS' when 'VP' then 'VENTAS DEFINITIVAS' when 'VI' then 'VENTAS CON PACTO' when 'IB' then 'INTERBANCARIOS' else '' end,
         numdocu =isnull(MDMO.monumdocu,0),
                correla =isnull(MDMO.mocorrela,0),
                numoper =isnull(MDMO.monumoper,0),
                serie   =isnull(MDMO.moinstser,' '),
                nominal =isnull(MDMO.monominal,0),
                tir     =isnull(MDMO.motir,0),
                pvp     =isnull(MDMO.mopvp,0),
         mtps    =isnull(MDMO.momtps,0),
                cliente =isnull(VIEW_CLIENTE.clnombre,' '),
                tot_nom =0,
                tot_tra =0,
                oper    =isnull(MDMO.motipoper,'')
         from MDAC, MDMO, VIEW_CLIENTE  VIEW_CLIENTE
  where  MDMO.mostatreg='A' 
         and    MDMO.motipoper='CI'
         and    MDMO.morutcli=VIEW_CLIENTE.clrut
  select @totnom=sum(#TEMP.nominal)
         from #TEMP
         where  #TEMP.oper='CI'
 
  select @tottra=sum(#TEMP.mtps)
         from #TEMP
         where  #TEMP.oper='CI'
  insert #TEMP
  select nomemp ='c,'+ space(40),
                rut_pro=space(11),
         fecpro =space(10),
         fecrep =space(10),
                tipoper=space(25),
         numdocu=0,
                correla=0,
                numoper=0,
                serie  =space(12),
                nominal=0,
                tir    =0,
                pvp    =0,
         mtps   =0,
                cliente=space(40),
                tot_nom=@totnom,
                tot_tra=@tottra,
                oper   =space(3)
 end
----------- fin de las compras con pacto ---------------------
----------- inicio de compras propias ------------------------
 if exists ( select * from MDMO  where  MDMO.mostatreg='A' and MDMO.motipoper='CP')
 begin
  insert #TEMP
  select nomemp  ='a,'+isnull(MDAC.acnomprop,' '),
                rut_pro =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro  =convert(char(10),MDAC.acfecproc,103),
         fecrep  =convert(char(10),MDAC.acfecproc,103),
                tipoper ='compras definitivas',
         numdocu =0,
                correla =0,
                numoper =0,
                serie   =space(12),
                nominal =0,
                tir     =0,
                pvp     =0,
         mtps    =0,
                cliente =space(40),
                tot_nom =0,
                tot_tra =0,
                oper    =space(3)
         from MDAC
  insert #TEMP
  select nomemp  ='b,'+isnull(MDAC.acnomprop,' '),
                rut_pro =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro  =convert(char(10),MDAC.acfecproc,103),
         fecrep  =convert(char(10),MDAC.acfecproc,103),
                tipoper =case MDMO.motipoper when 'CI' then 'COMPRAS CON PACTO' when 'CP' then 'COMPRAS DEFINITIVAS' when 'VP' then 'VENTAS DEFINITIVAS' when 'VI' then 'VENTAS CON PACTO' when 'IB' then 'INTERBANCARIOS' else '' end,
         numdocu =isnull(MDMO.monumdocu,0),
                correla =isnull(MDMO.mocorrela,0),
                numoper =isnull(MDMO.monumoper,0),
                serie   =isnull(MDMO.moinstser,' '),
                nominal =isnull(MDMO.monominal,0),
                tir     =isnull(MDMO.motir,0),
                pvp     =isnull(MDMO.mopvp,0),
         mtps    =isnull(MDMO.momtps,0),
                cliente =isnull(VIEW_CLIENTE.clnombre,' '),
                tot_nom =0,
                tot_tra =0,
                oper    =isnull(MDMO.motipoper,'')
         from MDAC, MDMO, VIEW_CLIENTE    VIEW_CLIENTE
  where  MDMO.mostatreg='A' 
         and    MDMO.motipoper='CP'
         and    MDMO.morutcli=VIEW_CLIENTE.clrut
  select @totnom=sum(#TEMP.nominal)
         from #TEMP
         where  #TEMP.oper='CP'
  select @tottra=sum(#TEMP.mtps)
         from #TEMP
         where  #TEMP.oper='CP'
  insert #TEMP
  select nomemp   ='c,'+space(40),
                rut_pro  =space(11),
         fecpro   =space(10),
         fecrep   =space(10),
                tipoper  =space(25),
         numdocu  =0,
                correla  =0,
                numoper  =0,
                serie    =space(12),
                nominal  =0,
                tir      =0,
                pvp      =0,
         mtps     =0,
                cliente  =space(40),
                tot_nom  =@totnom,
                tot_tra  =@tottra,
                oper     =space(3)
 end
---------- fin de compras propias --------------------
---------- inicio de ventas con pacto ----------------
 if exists ( select * from MDMO  where  MDMO.mostatreg='A' and MDMO.motipoper='VI')
 begin
  insert #TEMP
  select nomemp   ='a,'+isnull(MDAC.acnomprop,' '),
                rut_pro  =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro   =convert(char(10),MDAC.acfecproc,103),
         fecrep   =convert(char(10),MDAC.acfecproc,103),
                tipoper  ='ventas con pacto',
         numdocu  =0,
                correla  =0,
                numoper  =0,
                serie    =space(12),
                nominal  =0,
              tir      =0,
                pvp      =0,
         mtps     =0,
                cliente  =space(40),
                tot_nom  =0,
                tot_tra  =0,
                oper     =space(3)
         from MDAC
  insert #TEMP
  select nomemp   ='b,'+isnull(MDAC.acnomprop,' '),
                rut_pro  =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro   =convert(char(10),MDAC.acfecproc,103),
         fecrep   =convert(char(10),MDAC.acfecproc,103),
                tipoper  =case MDMO.motipoper when 'CI' then 'COMPRAS CON PACTO' when 'CP' then 'COMPRAS DEFINITIVAS' when 'VP' then 'VENTAS DEFINITIVAS' when 'VI' then 'VENTAS CON PACTO' when 'IB' then 'INTERBANCARIOS' else '' end,
         numdocu  =isnull(MDMO.monumdocu,0),
                correla  =isnull(MDMO.mocorrela,0),
                numoper  =isnull(MDMO.monumoper,0),
                serie    =isnull(MDMO.moinstser,' '),
                nominal  =isnull(MDMO.monominal,0),
                tir      =isnull(MDMO.motir,0),
                pvp      =isnull(MDMO.mopvp,0),
         mtps     =isnull(MDMO.momtps,0),
                cliente  =isnull(VIEW_CLIENTE.clnombre,' '),
                tot_nom  =0,
                tot_tra  =0,
                oper     =isnull(MDMO.motipoper,'')
         from MDAC, MDMO, VIEW_CLIENTE    VIEW_CLIENTE
  where  MDMO.mostatreg='A' 
         and    MDMO.motipoper='VI'
         and    MDMO.morutcli=VIEW_CLIENTE.clrut
 
  select @totnom=sum(#TEMP.nominal)
         from #TEMP
         where  #TEMP.oper='VI'
  select @tottra=sum(#TEMP.mtps)
         from #TEMP
         where  #TEMP.oper='VI'
  insert #TEMP
  select nomemp   ='c,'+space(40),
                rut_pro  =space(11),
         fecpro   =space(10),
         fecrep   =space(10),
                tipoper  =space(25),
         numdocu  =0,
                correla  =0,
                numoper  =0,
                serie    =space(12),
                nominal  =0,
                tir      =0,
                pvp      =0,
         mtps     =0,
                cliente  =space(40),
                tot_nom  =@totnom,
                tot_tra  =@tottra,
                oper     =space(3)
 end
------------- fin de ventas con pacto ---------------
------------- inicio de ventas definitivas ---------------
 if exists ( select * from MDMO  where  MDMO.mostatreg='A' and MDMO.motipoper='VP')
 begin
  insert #TEMP
  select nomemp   ='a,'+isnull(MDAC.acnomprop,' '),
                rut_pro  =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro   =convert(char(10),MDAC.acfecproc,103),
         fecrep   =convert(char(10),MDAC.acfecproc,103),
                tipoper  ='ventas definitivas',
         numdocu  =0,
                correla  =0,
                numoper  =0,
                serie    =space(12),
                nominal  =0,
                tir      =0,
                pvp      =0,
         mtps     =0,
                cliente  =space(40),
                tot_nom  =0,
                tot_tra  =0,
                oper     =space(3)
         from MDAC
  insert #TEMP
  select nomemp   ='b,'+isnull(MDAC.acnomprop,' '),
                rut_pro  =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro   =convert(char(10),MDAC.acfecproc,103),
         fecrep   =convert(char(10),MDAC.acfecproc,103),
                tipoper  =case MDMO.motipoper when 'CI' then 'COMPRAS CON PACTO' when 'CP' then 'COMPRAS DEFINITIVAS' when 'VP' then 'VENTAS DEFINITIVAS' when 'VI' then 'VENTAS CON PACTO' when 'IB' then 'INTERBANCARIOS' else '' end,
         numdocu  =isnull(MDMO.monumdocu,0),
                correla  =isnull(MDMO.mocorrela,0),
                numoper  =isnull(MDMO.monumoper,0),
                serie    =isnull(MDMO.moinstser,' '),
                nominal  =isnull(MDMO.monominal,0),
                tir      =isnull(MDMO.motir,0),
                pvp      =isnull(MDMO.mopvp,0),
         mtps     =isnull(MDMO.momtps,0),
                cliente  =isnull(VIEW_CLIENTE.clnombre,' '),
                tot_nom  =0,
                tot_tra  =0,
                oper     =isnull(MDMO.motipoper,'')
         from MDAC, MDMO, VIEW_CLIENTE    VIEW_CLIENTE
  where  MDMO.mostatreg='A' 
         and    MDMO.motipoper='VP'
         and    MDMO.morutcli=VIEW_CLIENTE.clrut
  select @totnom=sum(#TEMP.nominal)
         from #TEMP
         where  #TEMP.oper='VP'
 
  select @tottra=sum(#TEMP.mtps)
         from #TEMP
         where  #TEMP.oper='VP'
  insert #TEMP
  select nomemp   ='c,'+space(40),
                rut_pro  =space(11),
         fecpro   =space(10),
         fecrep   =space(10),
                tipoper  =space(25),
         numdocu  =0,
                correla  =0,
                numoper  =0,
                serie    =space(12),
                nominal  =0,
                tir      =0,
                pvp      =0,
         mtps     =0,
                cliente  =space(40),
                tot_nom  =@totnom,
                tot_tra  =@tottra,
                oper     =space(3)
 end
--------- fin de las ventas definitivas -----------------
--------- inicio de interbancarios ----------------------
 if exists ( select * from MDMO  where  MDMO.mostatreg='A' and MDMO.motipoper='IB')
 begin
  insert #TEMP
  select nomemp   ='a,'+isnull(MDAC.acnomprop,' '),
                rut_pro  =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro   =convert(char(10),MDAC.acfecproc,103),
         fecrep   =convert(char(10),MDAC.acfecproc,103),
                tipoper  ='interbancarios',
         numdocu  =0,
                correla  =0,
                numoper  =0,
                serie    =space(12),
                nominal  =0,
                tir      =0,
                pvp      =0,
         mtps     =0,
                cliente  =space(40),
                tot_nom  =0,
                tot_tra  =0,
                oper     =space(3)
         from MDAC
  insert #TEMP
  select nomemp   ='b,'+isnull(MDAC.acnomprop,' '),
                rut_pro  =rtrim(convert(char(11),isnull(MDAC.acrutprop,0)))+'-'+isnull(MDAC.acdigprop,' '),
         fecpro   =convert(char(10),MDAC.acfecproc,103),
         fecrep   =convert(char(10),MDAC.acfecproc,103),
                tipoper  =case MDMO.motipoper when 'ci' then 'compras con pacto' when 'cp' then 'compras definitivas' when 'vp' then 'ventas definitivas' when 'vi' then 'ventas con pacto' when 'ib' then 'interbancarios' else '' end,
         numdocu  =isnull(MDMO.monumdocu,0),
                correla  =isnull(MDMO.mocorrela,0),
                numoper  =isnull(MDMO.monumoper,0),
                serie    =isnull(MDMO.moinstser,' '),
                nominal  =isnull(MDMO.monominal,0),
                tir      =isnull(MDMO.motir,0),
                pvp      =isnull(MDMO.mopvp,0),
         mtps     =isnull(MDMO.momtps,0),
                cliente  =isnull(VIEW_CLIENTE.clnombre,' '),
                tot_nom  =0,
                tot_tra  =0,
                oper     =isnull(MDMO.motipoper,'')
         from MDAC, MDMO, VIEW_CLIENTE    VIEW_CLIENTE
  where  MDMO.mostatreg='A' 
         and    MDMO.motipoper='IB'
         and    MDMO.morutcli=VIEW_CLIENTE.clrut
  select @totnom=sum(#TEMP.nominal)
         from #TEMP
         where  #TEMP.oper='IB'
  select @tottra=sum(#TEMP.mtps)
         from #TEMP
         where  #TEMP.oper='IB'
  insert #TEMP
  select nomemp  ='c,'+space(40),
                rut_pro =space(11),
         fecpro  =space(10),
         fecrep  =space(10),
                tipoper =space(25),
         numdocu =0,
                correla =0,
                numoper =0,
                serie   =space(12),
                nominal =0,
                tir     =0,
                pvp     =0,
         mtps    =0,
                cliente =space(40),
                tot_nom =@totnom,
        tot_tra =@tottra,
                oper    =space(3)
 end
---------- fin de los interbancarios -----------------------
        execute (@cbuffer)
        select  @cexecute = 'master.dbo.xp_cmdshell "bcp bt_chile..' + @carchivo +' out c:\btchile\infoanu\' + @carchivo + '.txt /c /t, /r \n /sbac-srv /usa /pethernet"'
        execute  ( @cexecute )
     -- combinar los datos con la cabecera.-
        select  @cexecute = 'master.dbo.xp_cmdshell "copy c:\btchile\infoanu\einfoanu.txt+c:\btchile\infoanu\'+ @carchivo+'.txt  c:\jfsrvr\'+@carchivo+'.dat"'   
        execute (@cexecute)
 select @cmacro = "drop table " + @carchivo
        execute (@cmacro)
 select  @ceject = 'master.dbo.xp_cmdshell "del c:\btchile\infoanu\' + @carchivo + '.txt"'
        execute (@ceject)
 set nocount off        
-- commit  transaction
end
GO
