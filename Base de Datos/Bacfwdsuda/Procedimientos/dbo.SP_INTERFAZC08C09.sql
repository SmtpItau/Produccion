USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZC08C09]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE  [dbo].[SP_INTERFAZC08C09] 
AS
BEGIN
SET NOCOUNT ON
DECLARE @dFecPro AS DATETIME
SELECT  @dFecPro = (Select acfecproc from mfac)  
SELECT 'Fecha'    =  convert (char(02),@dFecPro,103)  ,
       'FW'       =  'FW'                             , 
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
       'Monto'    =  a.camtomon1                      ,
       'Numero'   =  a.canumoper                       
into #tmp
FROM  mfca a ,view_cliente b
WHERE a.cafecvcto > @dFecPro and
      a.cacodpos1<>4 and  a.cacodpos1<>5 and  cacodpos1<>6 and (a.cacodigo= b.clrut and a.cacodcli=b.clcodigo )
insert into #tmp
SELECT 'Fecha'    =  convert (char(02),@dFecPro,103),
       'FW'       =  'FW'                             , 
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
       'Monto'    =  a.camtomon2                      ,
       'Numero'   =  a.canumoper                       
FROM  mfca a ,view_cliente b
WHERE a.cafecvcto > @dFecPro  and
      a.cacodpos1<>4 and  a.cacodpos1<>5 and  cacodpos1<>6 and (a.cacodigo=b.clrut and a.cacodcli=b.clcodigo )
select * from #tmp order by numero
SET NOCOUNT OFF
END

GO
