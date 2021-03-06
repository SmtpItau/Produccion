USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLAMARC]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LLAMARC]
                  ( @user   char (12) ,
					@terminal  char (12)  ) with recompile
as
begin
set nocount on
 declare @operacion numeric (10,0)  ,
  @dfeccal datetime  ,
  @x  integer   ,
  @xx  integer   ,
  @xcort  integer   ,
  @suma  integer   ,
  @nrutcart numeric ( 9,0)  ,
  @nnumdocu numeric (10,0)  ,
  @ncorrela numeric (03,0)  ,
  @nnumoper numeric (10,0)  ,
  @ctipoper char (03)  ,
  @inid  char (01)  ,
  @numoper numeric (10,0)  ,
  @nominal numeric (19,4)  ,
  @vptirc  numeric (19,4)  ,
  @interesc numeric (19,4)  ,
  @reajustec numeric (19,4)   ,
  @valcomu numeric (19,4)  ,
  @valcomp numeric (19,4)  ,
  @cod_ser numeric (03,0)  ,
  @monemi  numeric (05,0)  ,
  @tasemi  numeric (19,4)  ,
  @basemi  numeric (03,0)  ,
  @rutemi  numeric (09,0)  ,
  @nnominalp numeric (19,4)  ,
  @MDSE  char (01)  ,
  @fecpcup datetime  ,
  @valcompori numeric (19,4)  ,
  @ncantcort numeric (19,4)  ,
  @nmontcort numeric (19,4)  ,
  @cmascara char (10)  ,
  @cinstser char (10)  ,
  @ntotalreg numeric(10,0)  
 select @x  = 1   ,
  @xx  = 1   ,
  @xcort  = 2   ,
  @suma  = 0   ,
  @numoper  = 0   ,
  @nnominalp  = 0
 create table #TMP
   (
   rutcart  numeric (9,0) null ,
   numdocu  numeric (10,0) null ,
   correla  numeric (03,0) null ,
   tipoper  char (03) null ,
   numoper  numeric (10,0) null ,
   nominal  numeric (19,4) null ,
   vptirc  numeric (19,4) null ,
   interesc numeric (19,4) null ,
   reajustec numeric (19,4) null ,
   valcomu  numeric (19,4) null ,
   valcomp  numeric (19,4) null ,
   nominalp numeric (19,4) null ,
   fecpcup  datetime null ,
   valcompori numeric (19,4) null ,
   mascara  char (10) null ,
   registro integer identity(1,1) not null
   )
 create table #TMP2
   (
   numdocu  numeric (10,0) null ,
   correla  numeric (03,0) null ,
   cantidad numeric (19,4) null ,
   monto  numeric (19,4) null ,
   instser  char (10) null ,
   registro integer identity(1,1) not null
   )
 select  @dfeccal = acfecproc , 
  @inid   = acsw_pd
        from MDAC
 
 if @inid='0'  
 begin
  select 'ESTADO'='NO','MSG'='PROCESO DE INICIO DE D¡A NO SE HA REALIZADONO HA HECHO INICIO DE DIA '
  set nocount off
  return
 end
 insert #TMP
 select virutcart ,
  vinumdocu ,
  vicorrela ,
  vitipoper ,
  vinumoper ,
  vinominal ,
  vivptirc ,
  viinteresv ,
  vireajustv ,
  vivalcomu ,
  vivalcomp ,
  vinominalp ,
  vifecpcup ,
  vivcompori ,
  vimascara
 from MDVI
 where @dfeccal>=vifecvenp
 order by vinumoper
 if (select count(*) from #TMP)=0
 begin
  select 'ESTADO'='SI','MSG'='NO EXISTEN OPERACIONES PARA RECOMPRAR '
  update MDAC set acsw_rc = '1'
  set nocount off
                   select 'OK'
  return
 end
 begin transaction
  while @x=1
  begin
   select @ctipoper = '*'
   set rowcount 1 
   select @nrutcart = rutcart  ,
    @nnumdocu = numdocu  ,
    @ncorrela = correla  ,
    @ctipoper = isnull(tipoper,'*') ,
    @nnumoper = numoper  ,
    @suma  = registro  ,
    @nominal = nominal  ,
         @vptirc  = vptirc  ,
           @interesc = interesc  ,
           @reajustec = reajustec  ,
           @valcomu = valcomu  ,
           @valcomp = valcomp  ,
    @nnominalp = nominalp  ,
    @fecpcup = fecpcup  ,
           @valcompori = valcompori  ,
    @cmascara = mascara
   from #TMP
   where registro>@suma  
   set rowcount 0 
   if @ctipoper='*'
    break
   if @ctipoper='CP' 
    select @cod_ser  = cpcodigo
    from MDCP
    where cpnumdocu=@nnumdocu and cpcorrela=@ncorrela
   else
    select @cod_ser = cicodigo
    from MDCI
    where cinumdocu=@nnumdocu and cicorrela=@ncorrela
 
   select @MDSE = inMDSE from VIEW_INSTRUMENTO where incodigo=@cod_ser
   if @MDSE='S'
    select @monemi = semonemi ,
     @tasemi = setasemi ,
     @basemi = sebasemi ,
     @rutemi = serutemi
    from VIEW_SERIE
    where semascara=@cmascara
   else
    select @monemi = nsmonemi ,
     @tasemi = nstasemi ,
     @basemi = nsbasemi ,
     @rutemi = nsrutemi
    from VIEW_NOSERIE
    where   nsnumdocu=@nnumdocu and nscorrela=@ncorrela
   if @ctipoper='CP'
   begin
    insert into MDMO
      (
      mofecpro   ,
      morutcart   ,
      motipcart   ,
      monumdocu   ,
      mocorrela   ,
      monumdocuo   ,
      mocorrelao   ,
      monumoper   ,
      motipoper   ,
      motipopero   ,
      moinstser   ,
      momascara   ,
      mocodigo   ,
      moseriado   ,
      mofecemi   ,
      mofecven   ,
      momonemi   ,
      motasemi   ,
      mobasemi   ,
      morutemi   ,
      monominal   ,
      movpresen   ,
      motir    ,
      mopvp                           ,
      movpar                          ,
      motasest                        ,
      mofecinip                       ,
      mofecvenp                       ,
      movalinip                       ,
      movalvenp                       ,
      motaspact                       ,
      mobaspact                       ,
      momonpact                       ,
      moforpagi                       ,
      moforpagv                       ,
      mopagohoy                       ,
      morutcli                        ,
      mocodcli   ,
      motipret                        ,
      mohora                          ,
      mousuario                       ,
      moterminal                      ,
      mocapitali                      ,
      mointeresi                      ,
      moreajusti                      ,
      movpreseni                      ,
      mocapitalp                      ,
      mointeresp                      ,
      moreajustp                      ,
      movpresenp                      ,
      motasant                        ,
      mobasant                        ,
      movalant                        ,
      mostatreg                       ,
      movpressb                       ,
      modifsb                         ,
      monominalp                      ,
      movalcomp                       ,
      movalcomu                       ,
      mointeres                      ,
      moreajuste                      ,
      mointpac                        ,
      moreapac                        ,
      moutilidad                      ,
      moperdida                       ,
      movalven                        ,
      mocorvent   
      )
    select
      @dfeccal   ,
      MDCP.cprutcart   ,
      MDCP.cptipcart   ,
      MDCP.cpnumdocu   ,
      MDCP.cpcorrela   ,
      MDCP.cpnumdocuo   ,
      MDCP.cpcorrelao   ,
      MDVI.vinumoper   ,
      'RC'    ,
      'CP'    ,
      MDCP.cpinstser   ,
      MDCP.cpmascara   ,
      MDCP.cpcodigo   ,
      MDCP.cpseriado   ,
      MDCP.cpfecemi   ,
      MDCP.cpfecven   ,
      @monemi    ,
      @tasemi    ,
      @basemi    ,
      @rutemi    ,
      @nominal   ,
      @vptirc    ,
      MDVI.vitirvent   ,
      MDVI.vipvpvent   ,
      0    ,
      MDVI.vitasest   ,
      MDVI.vifecinip   ,
      MDVI.vifecvenp   ,
      MDVI.vivalinip   ,
      MDVI.vivalinip+MDVI.viinteresvi+MDVI.vireajustvi,
      MDVI.vitaspact   ,
      MDVI.vibaspact   ,
      MDVI.vimonpact   ,
      MDVI.viforpagi   ,
      MDVI.viforpagv   ,
      ''    ,
      MDVI.virutcli   ,
      MDVI.vicodcli   ,
      ''    ,
      convert(char(15),@dfeccal,108) ,
      @user    ,
      @terminal   ,
      isnull(MDVI.vicapitalv,0) ,
      isnull(MDVI.viinteresv,0)   ,
      isnull(MDVI.vireajustv,0)   ,
      0    ,
      MDVI.vicapitalvi  ,
      MDVI.viinteresvi  ,
      MDVI.vireajustvi  ,
      0    ,
      0    ,
      0    ,
      0    ,
      ''    ,
      0    ,
      0    ,
      MDVI.vinominalp   ,
      MDVI.vivalcomp     ,
      MDVI.vivalcomu   ,
      MDVI.viinteresv   ,
      MDVI.vireajustv   ,
      MDVI.viinteresvi  ,
      MDVI.vireajustvi  ,
      0    ,
      0    ,
      MDVI.vivalinip   ,
      @suma    
    from MDCP, MDVI
    where MDCP.cpnumdocu=@nnumdocu and MDCP.cpcorrela=@ncorrela and
     MDVI.vinumdocu=@nnumdocu and MDVI.vicorrela=@ncorrela and
     MDVI.vinumoper=@nnumoper
   
    if @@error<>0
    begin
     SELECT 'ESTADO'='NO','MSG'='PROBLEMAS EN ACTUALIZACI¢N DE MOVIMIENTOS EN PROCESO DE RECOMPRAS'
     rollback transaction
                                        SELECT 'ERR'
     set nocount off
     return 
    end
    update MDCP
    set  cpnominal  = cpnominal  + @nominal   ,
      cpvptirc   = cpvptirc   + @vptirc   ,
      cpinteresc = cpinteresc + @interesc   ,
      cpreajustc = cpreajustc + @reajustec   ,
      cpvalcomu  = cpvalcomu  + isnull(@valcomu,0.0)  ,
      cpcapitalc = cpvalcomp  + isnull(@valcomp,0.0)  ,
      cpvalcomp  = cpvalcomp  + isnull(@valcomp,0.0)  ,
      cpvcompori = cpvcompori + isnull(@valcompori,0.0) ,
      cpfecpcup  = @fecpcup
    where cpnumdocu=@nnumdocu and cpcorrela=@ncorrela
    if @@error<>0
    begin
     select 'ESTADO'='NO','MSG'='PROBLEMAS EN ACTUALIZACI¢N DE COMPRAS PROPIAS EN PROCESO DE RECOMPRAS'
     rollback transaction
                                        select 'ERR'
     set nocount off
     return
    end   
    update MDDI
    set   dinominal  = dinominal  + @nominal  ,
      divptirc   = divptirc   + @vptirc  ,
      dicapitalc = dicapitalc + isnull(@valcomp,0.0) ,
      diinteresc = diinteresc + @interesc  ,
      direajustc = direajustc + @reajustec
    where dinumdocu=@nnumdocu and dicorrela=@ncorrela and ditipoper='CP'
    if @@error<>0
    begin
     select 'ESTADO'='NO','MSG'='PROBLEMAS EN ACTUALIZACI¢N DE DISPONIBILIDAD EN PROCESO DE RECOMPRAS'
     rollback transaction
     SELECT 'ERR'
                                        set nocount off
     return
    end   
    delete from MDVI 
    where vinumdocu=@nnumdocu and vicorrela=@ncorrela and
     vinumoper=@nnumoper                                       
    if @@error<>0
    begin
     select 'ESTADO'='NO','MSG'='PROBLEMAS EN ELIMINACI¢N DE REGISTROS DE VENTAS CON PACTO EN PROCESO DE RECOMPRAS'
     rollback transaction
                                        select 'ERR'
     set nocount off
     return
    end
    delete #TMP2
    insert into #TMP2
      (
      numdocu  ,
      correla  ,
      cantidad ,
      monto  ,
      instser
      )
    select
      cvnumdocu ,
      cvcorrela ,
      cvcantcort ,
      cvmtocort ,
      'recompra'
    from MDCV
    where  cvnumdocu=@nnumdocu and cvcorrela=@ncorrela and
     cvnumoper=@nnumoper
    select @xx = 1 ,
     @xcort = 0
    while @xx = 1
    begin
          select @ncantcort = 0 ,
      @nmontcort = 0 ,
      @cinstser = '*'
          set rowcount 1
          select  @ncantcort = cantidad ,
      @nmontcort = monto  ,
      @cinstser = instser ,
      @xcort  = registro
          from #TMP2
          where registro>@xcort
          set rowcount 0
          if @cinstser='*'
      break
     if exists(select cocantcortd from MDCO where conumdocu=@nnumdocu and cocorrela=@ncorrela and comtocort=@nmontcort)
      update MDCO
      set cocantcortd = cocantcortd + @ncantcort
      where conumdocu=@nnumdocu and cocorrela=@ncorrela and comtocort=@nmontcort
      if @@error<>0
      begin
       select 'ESTADO'='NO','MSG'='PROBLEMAS EN ACTUALIZACI¢N DE CORTES EN PROCESO DE RECOMPRAS'
       rollback transaction 
                                                        select 'ERR'
       set nocount off
       return
      end 
     else
      insert into MDCO
        (
        corutcart ,
        conumdocu ,
        cocorrela ,
        comtocort ,
        cocantcortd ,
        cocantcorto
        )
      select
        @nrutcart ,
        @nnumdocu ,
        @ncorrela ,
        @nmontcort ,
        @ncantcort ,
        @ncantcort
    end
    if @@error<>0
    begin
     select 'ESTADO'='NO','MSG'='PROBLEMAS EN ACTUALIZACI¢N DE CORTES EN PROCESO DE RECOMPRAS'
     rollback transaction
                                        select 'ERR'
     set nocount off
     return
    end 
   end
   if @ctipoper='CI'
   begin
     insert into MDMO 
      (
      mofecpro  ,
      morutcart  ,
      motipcart  ,
      monumdocu  ,
      mocorrela  ,
      monumdocuo  ,
      mocorrelao  ,
      monumoper  ,
      motipoper  ,
      motipopero  ,
      moinstser  ,
      momascara  ,
      mocodigo  ,
      moseriado  ,
      mofecemi  ,
      mofecven  ,
      momonemi  ,
      motasemi  ,
      mobasemi  ,
      morutemi  ,
      monominal  ,
      movpresen  ,
      momtps   ,
      momtum   ,
      momtum100  ,
      monumucup  ,
      motir   ,
      mopvp   ,
      movpar   ,
      motasest  ,
      mofecinip  ,
      mofecvenp  ,
      movalinip  ,
      movalvenp  ,
      motaspact  ,
      mobaspact  ,
      momonpact  ,
      moforpagi  ,
      moforpagv  ,
      mopagohoy  ,
      morutcli  ,
      mocodcli  ,
      motipret  ,
      mohora   ,
      mousuario  ,
      moterminal  ,
      mocapitali  ,
      mointeresi  ,
      moreajusti  ,
      movpreseni  ,
      mocapitalp  ,
      mointeresp  ,
      moreajustp  ,
      movpresenp  ,
      motasant  ,
      mobasant  ,
      movalant  ,
      mostatreg  ,
      movpressb  ,
      modifsb   ,
      monominalp  ,
      movalcomp  ,
      movalcomu  ,
      mointeres  ,
      moreajuste  ,
      mointpac  ,
      moreapac  ,
      moutilidad  ,
      moperdida  ,
      movalven  ,
      mocorvent  
      )
    select
      @dfeccal  ,
      MDCI.cirutcart  ,
      MDCI.citipcart  ,
      MDCI.cinumdocu  ,
      MDCI.cicorrela  ,
      MDCI.cinumdocuo  ,
      MDCI.cicorrelao  ,
      MDVI.vinumoper  ,
      'RC'   ,
      'CI'   ,
      MDCI.ciinstser  ,
      MDCI.cimascara  ,
      MDCI.cicodigo  ,
      MDCI.ciseriado  ,
      MDCI.cifecemi  ,
      MDCI.cifecven  ,
      @monemi   ,
      @tasemi   ,
      @basemi   ,
      @rutemi   ,
      @nominal  ,
      @vptirc   ,
      @vptirc   ,
      MDVI.vivalvemu  ,
      MDVI.vivvum100  ,
      MDCI.cinumucup  ,
      MDVI.vitirvent  ,
      MDVI.vipvpvent  ,
      0   ,
      MDVI.vitasest  ,
      MDVI.vifecinip  ,
      MDVI.vifecvenp  ,
      MDVI.vivalinip  ,
      MDVI.vivalinip+MDVI.viinteresvi+MDVI.vireajustvi,
      MDVI.vitaspact  ,
      MDVI.vibaspact  ,
      MDVI.vimonpact  ,
      MDVI.viforpagi  ,
      MDVI.viforpagv  ,
      ''   ,
      MDVI.virutcli  ,
      MDVI.vicodcli  ,
      ''   ,
      convert(char(15),@dfeccal,108) ,
      @user   ,
      @terminal  ,
      isnull(MDVI.vicapitalv,0)  ,
      isnull(MDVI.viinteresv,0)  ,
      isnull(MDVI.vireajustv,0)  ,
      0   ,
      isnull(MDVI.vicapitalvi,0) ,
      isnull(MDVI.viinteresvi,0) ,
      isnull(MDVI.vireajustvi,0) ,
      0   ,
      0   ,
      0   ,
      0   ,
      ''   ,
      0   ,
      0   ,
      MDVI.vinominalp  ,
      MDVI.vivalcomp    ,
      MDVI.vivalcomu  ,
      MDVI.viinteresv  ,
      MDVI.vireajustv  ,
      MDVI.viinteresvi ,
      MDVI.vireajustvi ,
      0   ,
      0   ,
      MDVI.vivalinip  ,
      @suma
    from  MDCI, MDVI
    where  MDCI.cinumdocu=@nnumdocu and MDCI.cicorrela=@ncorrela
     and MDVI.vinumdocu=@nnumdocu and MDVI.vicorrela=@ncorrela
     and MDVI.vinumoper=@nnumoper
    if @@error<>0
    begin
     select 'ESTADO'='NO','MSG'='PROBLEMAS EN PROCESO DE RECOMPRAS, ACTUALIZACI¢N DE CARTERA  '
     rollback transaction
                                        select 'ERR'
     set nocount off
     return 1
    end
    update MDDI
    set  dinominal = dinominal + @nominal    ,
      divptirc = civptirc * (dinominal/cinominal) ,
      divptirci = civptirc * (dinominal/cinominal)
    from MDDI, MDCI
    where dinumdocu=@nnumdocu and dicorrela=@ncorrela and ditipoper='CI' and
     cinumdocu=@nnumdocu and cicorrela=@ncorrela
    if @@error<>0
    begin
     select 'ESTADO'='NO', 'MSG'='PROBLEMAS EN PROCESO DE RECOMPRAS, ACTUALIZACI¢N DE DISPONIBLIDAD '
     rollback transaction
                                        select 'ERR'
     set nocount off
     return 1
    end 
    delete from MDVI 
    where vinumdocu=@nnumdocu and vicorrela=@ncorrela and
     vinumoper=@nnumoper                                       
    if @@error<>0
    begin
     select 'ESTADO'='NO','MSG'='PROBLEMAS EN PROCESO DE RECOMPRAS, REBAJAR PACTO'
     rollback transaction
                                        select 'ERR'
     set nocount off
     return 1
    end  
    delete #TMP2
    insert into #TMP2
      (
      numdocu  ,
      correla  ,
      cantidad ,
      monto  ,
      instser
      )
    select
      cvnumdocu ,
      cvcorrela ,
      cvcantcort ,      
      cvmtocort ,
      'recompra'
    from MDCV
    where cvnumdocu=@nnumdocu and cvcorrela=@ncorrela and 
     cvnumoper=@nnumoper 
    select @xx = 1 ,
     @xcort = 0
    while @xx=1
    begin
     select @ncantcort = 0 ,
      @nmontcort = 0 ,
      @cinstser = '*'
     set rowcount 1
     select  @ncantcort = cantidad ,
      @nmontcort = monto  ,
      @cinstser = instser ,
      @xcort  = registro
     from #TMP2
     where registro>@xcort
     set rowcount 0
     if @cinstser='*'
      break
       
     if exists(select cocantcortd from MDCO where conumdocu=@nnumdocu and cocorrela=@ncorrela and comtocort=@ncantcort)
      update MDCO
      set cocantcortd = cocantcortd + @ncantcort
      where conumdocu=@nnumdocu and cocorrela=@ncorrela and comtocort=@ncantcort
      if @@error<>0
      begin
       select 'ESTADO'='NO','MSG'='PROBLEMAS EN PROCESO DE RECOMPRAS, ACTUALIZACI¢N DE CORTES'
       rollback transaction
                     select 'ERR'
                                               set nocount off
       return 1
      end  
     else
      insert into MDCO
        (
        corutcart ,
        conumdocu ,
        cocorrela ,
        comtocort ,
        cocantcortd ,
        cocantcorto
        )
      select
        @nrutcart ,
        @nnumdocu ,
        @ncorrela ,
        @nmontcort ,
        @ncantcort ,
        @ncantcort
    end
    if @@error<>0
    begin
     select 'ESTADO'='NO','MSG'='PROBLEMAS EN PROCESO DE RECOMPRAS , ACTUALIZACI¢N DE CORTES'
     rollback transaction
                                        select 'ERR'
     set nocount off
     return 1
    end
   end
   continue  
  end
  update MDAC set acsw_rc = '1'
  select @ntotalreg = count(*) from #TMP
  select 'ESTADO'='SI','MSG'='SE REALIZARON ' + rtrim(convert(char(7),@ntotalreg))+' RECOMPRA(S) SATISFACTORIAMENTE '
 commit transaction
        set nocount off
end



GO
