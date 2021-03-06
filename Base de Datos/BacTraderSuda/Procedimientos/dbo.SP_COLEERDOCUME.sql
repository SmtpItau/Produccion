USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COLEERDOCUME]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_COLEERDOCUME]
               (@nrutcart numeric (9,0) ,
  @nnumdocu numeric (10,0) )
as
begin
      set nocount on
 select 'rutcart'=dirutcart ,
  'numdocu'=dinumdocu ,
  'correla'=dicorrela ,
  'instser'=diinstser ,
  'nominal'=dinominal  ,
  'tipoper'=ditipoper ,
  'serie'  =diserie  , 
  'minimo' =convert(float,0.0),
  'seriado'= ' '  ,
  'mascara'= space(10) ,
  'vendido'=isnull(( select sum(round(cvcantcort*cvmtocort,4)) from MDCV where cvrutcart=dirutcart and cvnumdocu=dinumdocu and cvcorrela=dicorrela ),0),
  'estado'= 'D'
 into  #TEMPCORTES
 from MDDI
 where dirutcart > 0 and dinumdocu=@nnumdocu
 order by dicorrela 
     -- actualizo compras con pacto 
 update #TEMPCORTES 
 set  seriado = MDCI.ciseriado ,
  mascara = MDCI.cimascara
 from MDCI
 where  #TEMPCORTES.tipoper = 'CI'
 and  #TEMPCORTES.numdocu = MDCI.cinumdocu
 and  #TEMPCORTES.correla = MDCI.cicorrela
 update #TEMPCORTES 
 set  seriado = MDCP.cpseriado ,
  mascara = MDCP.cpmascara
 from MDCP
 where  #TEMPCORTES.tipoper ='CP'
 and  #TEMPCORTES.numdocu = MDCP.cpnumdocu
 and  #TEMPCORTES.correla = MDCP.cpcorrela
 update #TEMPCORTES set minimo = secorte
 from VIEW_SERIE
 where #TEMPCORTES.seriado ='S'
 and  semascara = #TEMPCORTES.mascara 
 select * from  #TEMPCORTES
set nocount off 
end
--select * from MDDI
--execute sp_coleerdocume 0, 27

GO
