USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[car]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create view [dbo].[car]
as
select b.* from bacfwdsuda..mfca a, bacfwdsuda..mfcares b 
where a.cacodpos1 in (1,2,3,10,13)
and a.cafecvcto>='20100629' 
and a.canumoper=b.canumoper 
and b.cafechaproceso='20100625'

GO
