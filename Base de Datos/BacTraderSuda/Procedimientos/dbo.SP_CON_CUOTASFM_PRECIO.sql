USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CUOTASFM_PRECIO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_CUOTASFM_PRECIO]
   (
   @cfecha datetime
   )
AS
BEGIN
-- SET NOCOUNT ON 
select a.monumoper,a.mocorrela,a.morutemi,1,b.Clnombre,a.moinstser,a.monominal,a.mopvp,a.movpresen,a.mofecven 
from mdmo a, view_cliente b 
where 
a.momascara='FMUTUO' 	and 
a.motipoper='VFM' 	and 
a.mofecven=@cfecha	and
a.morutemi=b.Clrut 	and
b.Clcodigo=1
order by a.monumoper,a.mocorrela,a.morutemi,a.moinstser

/*
--select a.cpnumdocu,a.cpcorrela,b.nsrutemi,1,c.Clnombre,a.cpinstser,a.cpnominal,a.cppvpcomp,a.cpvalcomp,a.cpfecven
select a.cpnumdocu,a.cpcorrela,b.nsrutemi,1,c.Clnombre,a.cpinstser,a.cpnominal,0,a.cpvalcomp,a.cpfecven
from mdcp a, view_noserie b, view_cliente c
where 
a.cpmascara='FMUTUO' 	and 
--a.cpfecven=@cfecha	and
a.cpnumdocu=b.nsnumdocu and
a.cpcorrela=b.nscorrela and
b.nsrutemi=c.Clrut 	and
c.Clcodigo=1		and
a.cpnominal > 0
order by a.cpnumdocu,a.cpcorrela,b.nsrutemi,a.cpinstser
*/


--   SET NOCOUNT OFF
END


GO
