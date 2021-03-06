USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZFLUJOVCTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE  [dbo].[SP_INTERFAZFLUJOVCTO] (@dFechaGen datetime )
AS
BEGIN
SET NOCOUNT ON
SELECT 'Fecha'    =  convert (char(08),@dFechaGen,112),
       'Ft'       =  'FT'                             , 
       'Numero'   =  a.canumoper                      ,
       'Cuenta'   =  case when a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 then  '2127630189'                     
                          when a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 then  '2127630189'                     
                          when a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 then  '4127630084'                     
                          when a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 then  '4127630084'                     
                          when a.catipoper='C' and  a.cacodpos1=2 and b.clpais=6    then  '2127631088'                     
                          when a.catipoper='C' and  a.cacodpos1=2 and b.clpais<>6   then  '2127631282'                     
                          when a.catipoper='V' and  a.cacodpos1=2 and b.clpais=6    then  '4127631080'                     
                          when a.catipoper='V' and  a.cacodpos1=2 and b.clpais<>6   then  '4127631285'                    
                          when a.catipoper='C' and  a.cacodpos1=3  then  '2127633013'                     
                          when a.catipoper='V' and  a.cacodpos1=3  then  '4127635019'                     
                          else '0000000000' end,
       'Moneda'   =  a.cacodmon1                      ,
       'Tasa'     =  0                                ,
       'FechaVcto'= convert (char(08),a.cafecvcto,112), 
       'Monto'    =  a.camtomon1                      
into #tmp
FROM  mfca a ,view_cliente b
WHERE convert (char(08),a.cafecvcto,112) > convert (char(08),@dFechaGen,112) and
      a.cacodpos1<>4 and  a.cacodpos1<>5 and  cacodpos1<>6 and (a.cacodigo= b.clrut and a.cacodcli=b.clcodigo )
insert into #tmp
SELECT 'Fecha'    =  convert (char(08),@dFechaGen,112),
       'Ft'       =  'FT'                             , 
       'Numero'   =  a.canumoper                      ,
       'Cuenta'   =  case when a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 then  '4127630106'                     
                          when a.catipoper='C' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 then  '4127630114'                     
                          when a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=999 then  '2127630006'                     
                          when a.catipoper='V' and  (a.cacodpos1=1 or a.cacodpos1=7) and cacodmon2=998 then  '2127630014'                     
                          when a.catipoper='C' and  a.cacodpos1=2 and b.clpais=6    then  '4127631080'                     
                          when a.catipoper='C' and  a.cacodpos1=2 and b.clpais<>6   then  '4127631285'                     
                          when a.catipoper='V' and  a.cacodpos1=2 and b.clpais=6    then  '2127631080'                     
                          when a.catipoper='V' and  a.cacodpos1=2 and b.clpais<>6   then  '2127631282'                    
                          when a.catipoper='C' and  a.cacodpos1=3  then  '4127633008'                     
                          when a.catipoper='V' and  a.cacodpos1=3  then  '2127635008'                     
                          else '0000000000' end,
       'Moneda'   =  a.cacodmon2                      ,
       'Tasa'     =  0                                ,
       'FechaVcto'= convert (char(08),a.cafecvcto,112), 
       'Monto'    =  a.camtomon2                      
FROM  mfca a ,view_cliente b
WHERE convert (char(08),a.cafecvcto,112) > convert (char(08),@dFechaGen,112) and
      a.cacodpos1<>4 and  a.cacodpos1<>5 and  cacodpos1<>6 and (a.cacodigo=b.clrut and a.cacodcli=b.clcodigo )
select * from #tmp order by numero
SET NOCOUNT OFF
END

GO
