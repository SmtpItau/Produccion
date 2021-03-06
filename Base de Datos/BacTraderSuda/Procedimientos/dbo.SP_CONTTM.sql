USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTTM]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTTM] 
                           ( @user   char (08) ,
    @terminal  char (12)) with recompile
as
begin
set nocount on
 declare @dfecpro datetime  ,
  @dfectm  datetime  ,
  @dfecsbif datetime  ,
  @csw_dv  char  (01) ,
  @csw_co  char  (01) ,
  @csw_finmes char  (01)
 select @dfecpro = acfecproc ,
  @dfecsbif = acfecvmer ,
  @csw_dv  = acsw_dv ,
  @csw_co  = acsw_co ,
  @csw_finmes = acsw_finmes
 from MDAC
 if @csw_dv='0'
 begin
               set nocount off
  SELECT 'NO','DEVENGAMIENTO AUN NO HA SIDO EJECUTADO.'
  return
 end
 
 set rowcount 1 
 select @dfectm=rmfecha from MDRM
 set rowcount 0
 if @dfectm<>@dfecsbif
 begin
          set nocount off
          SELECT 'NO','VALORIZACIóN TASA DE MERCADO NO CORRESPONDE'
  return
 end
 delete MDMO where motipoper='TM'
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
   momonemi   ,
   mocodigo   ,
   moseriado   ,
   mofecven   ,
   monominal   ,
   movpresen   ,
   mohora    ,
   mousuario   ,
   moterminal   ,
   movpressb   ,
   modifsb    ,
   moutilidad   ,
   moperdida   ,
   morutcli
   )
 select 
   @dfecpro   ,
   MDRM.rmrutcart   ,
   MDCP.cptipcart   ,
   MDRM.rmnumdocu   ,
   MDRM.rmcorrela   ,
   MDRM.rmnumdocu   ,
   MDRM.rmcorrela   ,
   MDRM.rmnumoper   ,
   'TM'    ,
   'CP'    ,
   MDRM.rminstser   ,
   MDCP.cpmascara   ,
   0    , --** no sé moneda emisión **--
   MDCP.cpcodigo   ,
   MDCP.cpseriado   ,
   MDCP.cpfecven   ,
   MDCP.cpnominal   ,
   MDCP.cpvptirc-MDRS.rsreajuste ,
   convert(char(15),@dfecpro,108) ,
   @user    ,
   @terminal   ,
   MDRM.rmvalormer   ,
   0.0    ,
   0.0    ,
   0.0    ,
   MDCP.cprutcli
 from MDRM, MDCP, MDRS
 where MDRM.rmtipoper='CP' and MDRM.rmnumdocu=MDCP.cpnumdocu and
  MDRM.rmcorrela=MDCP.cpcorrela and (MDRS.rsnumdocu=MDCP.cpnumdocu and
  MDRS.rscorrela=MDCP.cpcorrela and MDRS.rscartera='111' and MDRS.rstipoper='DEV')
 update MDMO
 set movpresen = movpresen + isnull(rsvppresenx,0)
 from MDRS
 where monumdocu=rsnumdocu and mocorrela=rscorrela and rscartera='111' and rstipoper='VC'
 update MDMO
 set movpresen = movpresen + isnull(rsvppresenx,0)
 from MDFM
 where monumdocu=rsnumdocu and mocorrela=rscorrela and rscartera='111' and rstipoper='VC'
 update MDMO
 set momonemi = nsmonemi
 from VIEW_NOSERIE
 where moseriado<>'S' and morutcart=nsrutcart and monumdocu=nsnumdocu and mocorrela=nscorrela
 update MDMO
 set momonemi = semonemi
 from VIEW_SERIE
 where moseriado='S' and momascara=semascara
 insert into MDMO
   (
   mofecpro   ,
   morutcart   ,
   monumdocu   ,
   mocorrela   ,
   monumdocuo   ,
   mocorrelao   ,
   monumoper   ,
   motipoper   ,
   motipopero   ,
   moinstser   ,
   momascara   ,
   momonemi   ,
   mocodigo   ,
   moseriado   ,
   mofecven   ,
   monominal   ,
   movpresen   ,
   mohora    ,
   mousuario   ,
   moterminal   ,
   movpressb   ,
   modifsb    ,
   moutilidad   ,
   moperdida   ,
   morutcli
   )
 select
   @dfecpro   ,
   MDRM.rmrutcart   ,
   MDRM.rmnumdocu   ,
   MDRM.rmcorrela   ,
   MDRM.rmnumdocu   ,
   MDRM.rmcorrela   ,
   MDRM.rmnumoper   ,
   'TM'    ,
   'VI'    ,
   MDRM.rminstser   ,
   MDVI.vimascara   ,
   MDVI.vimonemi   ,
   MDVI.vicodigo   ,
   MDVI.viseriado   ,
   MDVI.vifecven   ,
   MDVI.vinominal   ,
   MDVI.vivptirc-MDRS.rsreajuste ,
   convert(char(15),@dfecpro,108) ,
   @user    ,
   @terminal   ,
   MDRM.rmvalormer   ,
   0.0    ,
   0.0    ,
   0.0    ,
   MDVI.virutcli
 from MDRM, MDVI, MDRS
 where MDRM.rmtipoper='VI' and MDRM.rmnumdocu=MDVI.vinumdocu and
  MDRM.rmnumoper=MDVI.vinumoper and MDRM.rmcorrela=MDVI.vicorrela and
  (MDRS.rsnumdocu=MDVI.vinumdocu and MDRS.rsnumoper=MDVI.vinumoper and
  MDRS.rscorrela=MDVI.vicorrela and MDRS.rscartera='114' and MDRS.rstipoper='DEV')
 update MDMO
 set movpresen = movpresen + isnull(rsvppresenx,0)
 from MDRS
 where (motipopero='VI' and motipoper='TM') and (monumdocu=rsnumdocu and monumoper=rsnumoper and
  mocorrela=rscorrela and rscartera='114' and rstipoper='VC')
 update MDMO
 set movpresen = movpresen + isnull(rsvppresenx,0)
 from MDFM
 where (motipopero='VI' and motipoper='TM') and (monumdocu=rsnumdocu and monumoper=rsnumoper and
  mocorrela=rscorrela and rscartera='114' and rstipoper='VC')
 update MDMO set 
   modifsb    = movpressb-movpresen ,
   moutilidad = case
      when movpressb-movpresen>0 then movpressb-movpresen
      else 0
     end ,
   moperdida  =  case
      when movpressb-movpresen<0 then (movpressb-movpresen)*-1
      else 0
     end
 where motipoper='TM'
set nocount off
select 'OK'
end

GO
