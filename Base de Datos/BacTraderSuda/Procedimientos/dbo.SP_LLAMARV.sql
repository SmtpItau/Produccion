USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLAMARV]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LLAMARV]
                  ( @user  char (12) ,
   @terminal char (12)   ) with recompile
as
begin
set nocount on
 declare @operacion numeric (10,0)  ,
  @dfeccal datetime  ,
  @x  integer   ,
  @suma  integer   ,
  @nnumdocu numeric (10,0)  ,
  @ncorrela numeric (03,0)  ,
  @nnumoper numeric (10,0)  ,
  @ctipoper char (03)  ,
  @inid         char (01)  ,
  @nominal        numeric (19,4)  ,
  @vptirc         numeric (19,4)  ,
  @interesc       numeric (19,4)  ,
  @reajustec      numeric (19,4)   ,
  @valcomu        numeric (19,4)  ,
  @valcomp        numeric (19,4)  ,
  @cod_ser        numeric (03,0)  ,
  @monemi  numeric (05,0)  ,
  @tasemi  numeric (19,4)  ,
  @basemi  numeric (03,0)  ,
  @rutemi  numeric (09,0)  ,
  @MDSE   char (01)  ,
  @nnominalp numeric (19,4)  ,
  @cinstser char(12)  ,
  @ntotalreg      numeric(10,0)
 select @x  = 1   ,
  @suma  = 0
 create table #TEMP
   (
   numdocu  numeric (10,0) null ,
   correla  numeric (03,0) null ,
   tipoper  char (03) null ,
   nominal  numeric (19,4) null ,
   vptirc  numeric (19,4) null ,
   interesc numeric (19,4) null ,
   reajustec numeric (19,4) null ,
   valcomu  numeric (19,4) null ,
   valcomp  numeric (19,4) null ,
   cod_ser  numeric (03,0) null ,
   nominalp numeric (19,4) null ,
   cinstser char(12) null ,
   registro integer identity(1,1) not null
   )
  
 select  @dfeccal = acfecproc , 
  @inid   = acsw_pd
 from MDAC
 
 if @inid='0'
 begin
  select 'ESTADO'='NO' , 'MSG'='PROCESO DE INGRESO DE PARAMETROS DIARIOS NO HA SIDO REALIZADO '
  set nocount off
  return
 end
 begin transaction
     /* 
 =================================================================================
 se eliminan interbancarios de la tabla de compras con pactos ( MDCI ), puesto 
 que se dan de baja en el proceso de devengamiento
 ================================================================================= */
 delete MDCI where cifecvenp<=@dfeccal and (ciinstser='ICOL' or ciinstser='ICAP')
     /* ================================================================================= */
 insert #TEMP
 select 
  cinumdocu ,
  cicorrela ,
  'CI'  ,
  cinominal ,
  civptirc ,
  ciinteresc ,
  cireajustc ,
  civalcomu ,
  civalcomp ,
  cicodigo ,
  cinominalp ,
  ciinstser
 from 
  MDCI
 where   
  @dfeccal>=cifecvenp 
 and  (ciinstser<>'ICOL' and ciinstser<>'ICAP') 
 and cimascara<>'CLEAN'
 order by 
  cinumdocu
 if (select count(*) from #TEMP)=0
 begin
  update MDAC set acsw_rv = '1' ,
    acsw_pc = '0'
  update MDFIN
  set  finsw_dv1 = '0' ,
    finsw_dv2 = '0' ,
    finsw_dv3 = '0' ,
    finsw_tm = '0' ,
    finsw_ptw = '0' ,
    finsw_trd = '0' ,
    finsw_btw = '0' ,
    finsw_fd = '0'
       /* 
   =================================================================================
   se eliminan papeles que hayan vencido ( MDCP ), puesto 
   que se dan de baja en el proceso de devengamiento
   ================================================================================= */
   delete MDCP where cpfecven<=@dfeccal
       /* ================================================================================= */
   if @@error<>0
   begin 
    rollback transaction
    select 'ESTADO'='NO', 'MSG'='PROBLEMAS AL ELIMINAR TABLA DE COMPRAS PROPIAS'
    set nocount off
    return
   end
   delete MDDI where difecsal<=@dfeccal
   if @@error<>0
   begin 
    rollback transaction
    select 'ESTADO'='NO', 'MSG'='PROBLEMAS AL ELIMINAR TABLA DE DISPONIBILIDAD'
    set nocount off
    return
   end
   select 'ESTADO'='SI','MSG'=' NO EXISTEN OPERACIONES DE COMPRAS CON PACTOS QUE VENZAN HOY'
   commit transaction
                        select 'OK'
      set nocount off
   return
 end
 while @x=1
 begin
  select @ctipoper = '*'
  set rowcount 1
  select  
   @nnumdocu = numdocu           ,
   @ncorrela = correla   ,
   @ctipoper = isnull(tipoper,'*') ,
   @suma  = registro  ,
   @nominal = nominal  ,
   @vptirc  = vptirc  ,
   @interesc = interesc  ,
   @reajustec = reajustec  ,
   @valcomu = valcomu  ,
   @valcomp = valcomp  ,
   @cod_ser = cod_ser  ,
   @nnominalp = nominalp  ,
   @cinstser = cinstser
  from    
   #TEMP
  where 
   registro>@suma
   
  set rowcount 0
  if @ctipoper='*' break
  select @MDSE=inMDSE from VIEW_INSTRUMENTO where incodigo=@cod_ser
  if @MDSE='S'
   select @tasemi = 0.0 ,
     @basemi = 0.0
    from VIEW_SERIE
    where semascara = @cinstser
  else
    select @monemi = nsmonemi ,
     @tasemi = nstasemi ,
     @basemi = nsbasemi ,
     @rutemi = nsrutemi
    from VIEW_NOSERIE
    where nsnumdocu=@nnumdocu and nscorrela=@ncorrela
  insert into MDMO
   (
   mofecpro   ,
   morutcart   ,
   motipcart   ,
   monumdocu   ,
   mocorrela   ,
   monumdocuo   ,
   mocorrelao   ,
   monumoper    ,
   motipoper    ,
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
   momtps    ,
   momtum    ,
   momtum100   ,
   monumucup   ,
   motir    ,
   mopvp    ,
   movpar    ,
   motasest   ,
   mofecinip   ,
   mofecvenp   ,
   movalinip   ,
   movalvenp   ,
   motaspact   ,
   mobaspact   ,
   momonpact   ,
   moforpagi   ,
   moforpagv   ,
   mopagohoy   ,
   morutcli   ,
   mocodcli   ,
   motipret   ,
   mohora    ,
   mousuario   ,
   moterminal   ,
   mocapitali   ,
   mointeresi   ,
   moreajusti   ,
   movpreseni   ,
   mocapitalp   ,
   mointeresp   ,
   moreajustp   ,
   movpresenp   ,
   motasant   ,
   mobasant   ,
   movalant   ,
   mostatreg   ,
   movpressb   ,
   modifsb    ,
   monominalp   ,
   movalcomp   ,
   movalcomu   ,
   mointeres   ,
   moreajuste   ,
   mointpac   ,
   moreapac   ,
   moutilidad   ,
   moperdida   ,
   movalven
   )
  select
   @dfeccal   ,
   cirutcart   ,
   citipcart   ,
   cinumdocu   ,
   cicorrela   ,
   cinumdocuo   ,
   cicorrelao   ,
   cinumdocu   ,
   'RV'    ,
   'CI'    ,
   ciinstser   ,
   cimascara   ,
   cicodigo   ,
   ciseriado   ,
   cifecemi   ,
   cifecven   ,
   cimonemi   ,
   @tasemi    ,
   @basemi    ,
   cirutemi   ,
   @nominal   ,
   @vptirc    ,
   @vptirc    ,
   civalcomu   ,
   civcum100   ,
   cinumucup   ,
   citircomp   ,
   cipvpcomp   ,
   0    ,
   citasest   ,
   cifecinip   ,
   cifecvenp   ,
   civalinip   ,
   civalinip+ciinteresci+cireajustci ,
   citaspact   ,
   cibaspact   ,
   cimonpact   ,
   ciforpagi   ,
   ciforpagv   ,
   ''    ,
   cirutcli   ,
   cicodcli   ,
   ''    ,
   convert(char(15),@dfeccal,108) ,
   @user    ,
   @terminal   ,
   cicapitalc   ,
   ciinteresc   ,
   cireajustc   ,
   0    ,
   cicapitalci   ,
   ciinteresci   ,
   cireajustci   ,
   0    ,
   0    ,
   0    ,
   0    ,
   ''    ,
   0    ,
   0    ,
   cinominalp   ,
   civalcomp   ,
   civalcomu   ,
   0    ,
   0    ,
   ciinteresci   ,
   cireajustci   ,
   0    ,
   0    ,
   civalinip
   
  from 
   MDCI
  where 
   cinumdocu=@nnumdocu 
  and  cicorrela=@ncorrela
  if @@error<>0
  begin
   select 'ESTADO'='NO', 'MSG'='PROBLEMAS EN GRABACI¢N DEL ARCHIVO DE MOVIMIENTOS'
   rollback transaction
   set nocount off
   return 
  end
  delete from MDCI
  where  cinumdocu=@nnumdocu and cicorrela=@ncorrela
  if @@error<>0
  begin
   select 'ESTADO'='NO', 'MSG'='PROBLEMAS EN ELIMINACI¢N DE TABLA DE COMPRAS CON PACTO'
   rollback transaction
   set nocount off
   return
  end 
  delete from MDCO
  where  conumdocu=@nnumdocu and cocorrela=@ncorrela
  if @@error<>0
  begin
   select 'ESTADO'='NO', 'MSG'='PROBLEMAS EN ELIMINACI¢N DE TABLA DE CORTES'
   rollback transaction
   set nocount off
   return
  end   
  update MDDI
  set dinominal = dinominal - @nominal ,
   divptirc = divptirc + @vptirc
  where dinumdocu=@nnumdocu and dicorrela=@ncorrela and
   ditipoper = 'CI'
 
  if @@error<>0
  begin
   select 'ESTADO'='NO', 'MSG'='PROBLEMAS EN ELIMINACI¢N DE TABLA DE COMPRAS PROPIAS'
   rollback transaction
   set nocount off
   return
  end
  continue  
  
  end
  update MDAC
  set  acsw_rv  = '1' ,
    acsw_pc  = '0'
  update MDFIN
  set  finsw_dv1 = '0' ,
    finsw_dv2 = '0' ,
    finsw_dv3 = '0' ,
    finsw_tm = '0' ,
    finsw_ptw = '0' ,
    finsw_trd = '0' ,
    finsw_btw = '0' ,
    finsw_fd = '0'
  delete MDCP where cpfecven<=@dfeccal
  if @@error<>0
  begin 
   rollback transaction
   select 'ESTADO'='NO', 'MSG'='PROBLEMAS EN ELIMINACI¢N DE TABLA DE COMPRAS PROPIAS'
   set nocount off
   return
  end
  delete MDDI where difecsal=@dfeccal
  if @@error<>0
  begin 
   rollback transaction
   select 'ESTADO'='NO', 'MSG'='PROBLEMAS EN ELIMINACI¢N DE TABLA DISPONIBLE'
   set nocount off
   return
  end
  select @ntotalreg = count(*) from #TEMP
  select 'ESTADO'='SI','MSG'='SE REALIZARON ' + rtrim(convert(char(7),@ntotalreg))+' REVENTAS SATISFACTORIAMENTE '
 
 commit transaction
         
 drop table #TMP


	EXECUTE bactradersuda.dbo.sp_LlamaRcRvIM  @user  

        select 'OK'


set nocount off  
end



GO
