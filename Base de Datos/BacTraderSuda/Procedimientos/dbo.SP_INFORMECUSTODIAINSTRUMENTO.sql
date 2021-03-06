USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMECUSTODIAINSTRUMENTO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORMECUSTODIAINSTRUMENTO](@numerooperacion    numeric( 6)
      
    )
as
begin
set nocount on
 if exists(select * from MDMO where @numerooperacion = monumoper)
  select  a.acdirprop     ,
   a.acfon_resoma  ,
   d.monumoper     ,
   d.monumdocu     ,
   d.moinstser     ,
   c.emnombre      ,
   d.monominal     ,
   f.mnnemo        ,
   d.mofecven      ,
   b.clrut         ,
   b.cldv          ,
   b.cldirecc      ,
   b.clnombre      ,
   b.clfono        ,
   e.nom_ciu   
  from  MDAC a,
   VIEW_CLIENTE  b,
   VIEW_EMISOR c,
   MDMO d,
   VIEW_CIUDAD_COMUNA e,
   VIEW_MONEDA  f 
    where   @numerooperacion = d.monumoper    and
   d.morutemi    = c.emrut        and
   d.momonemi    = f.mncodmon     and
   d.morutcli    = b.clrut        and
   d.mocodcli    = b.clcodigo     and
   b.clpais      = e.cod_pai     and
   b.clciudad    = e.cod_ciu     and
   b.clcomuna    = e.cod_com   
 else 
  select  a.acdirprop     ,
   a.acfon_resoma  ,
   d.monumoper     ,
   d.monumdocu     ,
   d.moinstser     ,
   c.emnombre      ,
   d.monominal     ,
   f.mnnemo        ,
   d.mofecven      ,
   b.clrut         ,
   b.cldv          ,
   b.cldirecc      ,
   b.clnombre      ,
   b.clfono        ,
   e.nom_ciu   
  from  MDAC a,
   VIEW_CLIENTE  b,
   VIEW_EMISOR c,
   MDMH d,
   VIEW_CIUDAD_COMUNA e,
   VIEW_MONEDA  f 
    where   @numerooperacion = d.monumoper    and
   d.morutemi    = c.emrut        and
   d.momonemi   = f.mncodmon     and
   d.morutcli    = b.clrut        and
   --MDMH.mocodcli    = VIEW_CLIENTE.clcodigo     and
   b.clpais   = e.cod_pai     and
   b.clciudad    = e.cod_ciu     and
   b.clcomuna    = e.cod_com   
 
end


GO
