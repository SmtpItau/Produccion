USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMLEERNOMBRESFM]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_EMLEERNOMBRESFM]
            (@emnombre1 char (30))
as
begin   
set rowcount 50

select 	c.Clcodigo,
	c.Clrut,
       	c.Cldv,
 	c.Clnombre,
--	c.Clgeneric,
	emgeneric = c.Clgeneric,
	c.Cldirecc,
	c.Clcomuna,
	c.Cltipemp
FROM BacParamSuda..CLIENTE c WHERE Clfmutuo = 'S' AND Clnombre > @emnombre1
ORDER BY Clnombre

/*
select 	c.Clcodigo,
	c.Clrut,
       	c.Cldv,
 	c.Clnombre,
--	c.Clgeneric,
	e.emgeneric,
	c.Cldirecc,
	c.Clcomuna,
	c.Cltipemp
from BACPARAMsuda..cliente C,BACPARAMSUDA..emisor E
where	c.Clfmutuo = 'S' 		AND
        c.Clnombre  > @emnombre1 	AND
        c.Clrut =e.emrut 		and
        c.Clcodigo=1 			and
        e.emtipo=2
order by Clnombre
*/
 set rowcount 0
   return
end  

GO
