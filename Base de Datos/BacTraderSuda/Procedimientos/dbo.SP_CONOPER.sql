USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONOPER]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_conoper    fecha de la secuencia de comandos: 05/04/2001 13:13:17 ******/
CREATE PROCEDURE [dbo].[SP_CONOPER]
as 
begin
set nocount on
  select distinct
    'numoper' = monumoper,
    'tipoper' = motipoper,
                  'nombre'  = clnombre,
                  'fecvcto' = convert( char(10),mofecvenp,103),
                  'total'   = convert(float, 0.0)
  into #TEMPORAL1
  from 
  --  REQ. 7619 
         VIEW_CLIENTE  LEFT OUTER JOIN MDMO ON morutcli = clrut
--     , MDMO
  where mostatreg = null 
  --  REQ. 7619
  -- and morutcli *= clrut
  update #TEMPORAL1 set total = (select sum(movalcomp) from MDMO where numoper = monumoper ) where tipoper = 'CP'
  update #TEMPORAL1 set total = (select sum(movalcomp) from MDMO where numoper = monumoper) where tipoper = 'CI'
  update #TEMPORAL1 set total = (select sum(movalven) from MDMO where numoper = monumoper ) where tipoper = 'VP'
  update #TEMPORAL1 set total = (select sum(movalven) from MDMO where numoper = monumoper ) where tipoper = 'VI'
  update #TEMPORAL1 set total = (select sum(movalcomp) from MDMO where numoper = monumoper) where tipoper = 'RC'
  update #TEMPORAL1 set total = (select sum(movalcomp) from MDMO where numoper = monumoper) where tipoper = 'RCA'
  update #TEMPORAL1 set total = (select sum(movalven) from MDMO where numoper = monumoper ) where tipoper = 'RV' 
  update #TEMPORAL1 set total = (select sum(movalven) from MDMO where numoper = monumoper) where tipoper = 'RVA' 
  update #TEMPORAL1 set total = 0 where total = null
  select * from #TEMPORAL1
end


GO
