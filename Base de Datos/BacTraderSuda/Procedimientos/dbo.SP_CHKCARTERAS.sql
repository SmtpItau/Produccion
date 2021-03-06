USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHKCARTERAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CHKCARTERAS]
as
begin
set nocount on
 select 'tipoper' = 'CP'      ,
  'numdocu' = cpnumdocu     ,
  'numoper' = convert(numeric(10,0),0)   ,
  'correla' = cpcorrela     ,
  'instser' = cpinstser     ,
  'nominal' = cpnominal     ,
  'vpresen' = cpvptirc     ,
  'difer'  = cpvptirc-(cpcapitalc+cpinteresc+cpreajustc) ,
  'nomemp' = acnomprop     ,
  'rutemp' = str(acrutprop)+'-'+acdigprop
 into #TMP
 from MDCP, MDAC
 where cpvptirc-(cpcapitalc+cpinteresc+cpreajustc)<-50 or
  cpvptirc-(cpcapitalc+cpinteresc+cpreajustc)>50
 insert into #TMP
 select
  'DI'      ,
  dinumdocu     ,
  0.0      ,
  dicorrela     ,
  diinstser     ,
  dinominal     ,
  divptirc     ,
  divptirc-(dicapitalc+diinteresc+direajustc) ,
  acnomprop     ,
  str(acrutprop)+'-'+acdigprop
 from MDDI, MDAC
 where (divptirc-(dicapitalc+diinteresc+direajustc)<-50 or
  divptirc-(dicapitalc+diinteresc+direajustc)>50) and ditipoper='CP'
 insert into #TMP
 select
  'VI'      ,
  vinumdocu     ,
  vinumoper     ,
  vicorrela     ,
  viinstser     ,
  vinominal     ,
  vivptirc     ,
  vivptirc-(vicapitalv+viinteresv+vireajustv) ,
  acnomprop     ,
  str(acrutprop)+'-'+acdigprop
 from MDVI, MDAC
 where vivptirc-(vicapitalv+viinteresv+vireajustv)<-50 or
  vivptirc-(vicapitalv+viinteresv+vireajustv)<-50 and vitipoper='CP'
 if (select count(*) from #TMP)>0
  select * from #TMP
 else
  select 'NO','NO EXISTEN DATOS'
end
-- sp_chkcarteras


GO
