USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZGESTION]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZGESTION](@dFechaDesde  DATETIME,  @dFechaHasta as DATETIME )
AS
BEGIN
SET NOCOUNT ON
Select  'FechaIni'=a.cafecha,
        'FechaVen'=a.cafecvcto,
        'Monto'   =a.caequmon1,
        'CodMon'  =a.camtomon1,
        'CodCnv'  =a.camtomon2,
        'CodPro'  =a.cacodpos1,
        'Costo'   =CASE b.clcosto WHEN 0 THEN 7110 ELSE b.clcosto END ,
        'Prod'    =CASE WHEN  a.cacodmon1=13 and a.cacodmon2=999 THEN '033105' 
   WHEN  a.cacodmon1=13 and a.cacodmon2=998 THEN '033205' 
   ELSE  '033405' 
      END
into  #tmpcartera
from  mfca a ,
 view_cliente b
where (a.cacodigo = b.clrut    AND
         a.cacodcli = b.clcodigo )
insert into  #tmpcartera
Select  'FechaIni'=a.cafecha,
        'FechaVen'=a.cafecvcto,
        'Monto'   =a.caequmon1,
        'CodMon'  =a.camtomon1,
        'CodCnv'  =a.camtomon2,
        'CodPro'  =a.cacodpos1,
        'Costo'   =CASE b.clcosto WHEN 0 THEN 7110 ELSE b.clcosto END ,
        'Prod'    =CASE WHEN a.cacodmon1=13 and a.cacodmon2=999 THEN '033105' 
   WHEN a.cacodmon1=13 and a.cacodmon2=998 THEN '033205' 
   ELSE '033405' 
      END
from  mfcah  a      ,
 view_cliente b
where (a.cacodigo = b.clrut   AND
         a.cacodcli = b.clcodigo )
--*/**********Cartera Nueva********/
Select 'Insumo' = '001',
       'TOper'  = count(*),
       'TMonto' = sum(Monto),
       'cPro'   = Prod,
       'costo'  = costo
into   #tmpnueva      
from   #tmpcartera
where  fechaini >= @dFechaDesde and fechaini <= @dFechaHasta AND 
       ( codpro = 1  OR
         codpro = 2  OR
  codpro = 7    )
group by prod,costo
--*/**********Cartera Vigente********/
Select 'Insumo' = '002',
       'TOper'  = count(*),
       'TMonto' = sum(Monto),
       'cPro'   = Prod,
       'costo'  = costo
into  #tmpvigente
from  #tmpcartera
where fechaven > @dFechaHasta   and  fechaini < @dFechaDesde  AND 
       ( codpro = 1  OR
         codpro = 2  OR
  codpro = 7   )
group by prod,costo
--*/**********Cartera Vencida********/
Select 'Insumo' = '003',
       'TOper'  = count(*),
       'TMonto' = sum(Monto),
       'cPro'   = Prod,
       'costo'  = costo
into  #tmpvencidas
from  #tmpcartera
where fechaven >= @dFechaDesde   and  fechaven <= @dFechaHasta  AND 
       ( codpro = 1  OR
         codpro = 2  OR
  codpro = 7   )
group by prod,costo
Select  'CodInsumo' = cpro+Insumo       ,
        'Filler1'   = '000000000000'    ,
        'CantOper'  = TOper             , 
        'MonTotal'  = TMonto            ,
        'CodProd'   = cPro              ,
        'CenCosto'  = costo             ,
        'Filler2'   = '000'             ,
        'Año'       = Left(Convert(char(08),@dFechaDesde,112),4)              ,
        'Mes'       = right(convert(char(06), @dFechaDesde,112),2)      ,
        'CostoSer'  = '007110'          ,
        'Filler3'   = '000000'          
into #tmpTodo
from #tmpnueva  
insert into #tmpTodo
Select  'CodInsumo' = cpro+Insumo            ,
        'Filler1'   = '000000000000'    ,
        'CantOper'  = TOper             , 
        'MonTotal'  = TMonto            ,
        'CodProd'   = cPro              ,
        'CenCosto'  = costo             ,
        'Filler2'   = '000'             ,
        'Año'       = Left(Convert(char(08),@dFechaDesde,112),4)              ,
        'Mes'       = right(convert(char(06), @dFechaDesde,112),2)      ,
        'CostoSer'  = '007110'          ,
        'Filler3'   = '000000'          
from #tmpvigente
insert into #tmpTodo
Select  'CodInsumo' = cpro+Insumo             ,
        'Filler1'   = '000000000000'    ,
        'CantOper'  = TOper             , 
        'MonTotal'  = TMonto            ,
        'CodProd'   = cPro              ,
        'CenCosto'  = costo             ,
        'Filler2'   = '000'             ,
        'Año'       = Left(Convert(char(08),@dFechaDesde,112),4)              ,
        'Mes'       = right(convert(char(06), @dFechaDesde,112),2)      ,
        'CostoSer'  = '007110'          ,
        'Filler3'   = '000000'          
from #tmpvencidas
SELECT * 
FROM   #tmpTodo 
ORDER BY CodInsumo
SET NOCOUNT OFF
END

GO
