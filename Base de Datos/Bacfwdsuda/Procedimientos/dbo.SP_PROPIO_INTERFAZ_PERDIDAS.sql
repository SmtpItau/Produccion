USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROPIO_INTERFAZ_PERDIDAS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SP_AUTORIZA_EJECUTAR 'bacuser' select * from mfac
create procedure [dbo].[SP_PROPIO_INTERFAZ_PERDIDAS]
AS 
BEGIN 
 DECLARE @dolar_observado NUMERIC(12,04) ,
  @valor_uf   NUMERIC(12,04) ,
  @entidad    char(40)
 SET NOCOUNT ON
 SELECT  @dolar_observado = vmvalor
 FROM   view_valor_moneda ,
  mfac   
 WHERE  vmcodigo = accodmondolobs AND
    vmfecha  = acfecante
 
 SELECT  @valor_uf  = vmvalor,
  @entidad   = acnomprop
        FROM   view_valor_moneda ,
               mfac   
 WHERE  vmcodigo = accodmonuf  AND
  vmfecha  = acfecante
   
 SELECT  'CRUT '   = STR(a.cacodigo) + b.Cldv 
  ,'tipope'  = a.catipoper
  ,'numope' = a.canumoper
  ,'codmon' = isnull((select mnnemo from VIEW_MONEDA where mncodmon=  a.cacodmon1),'XXX')
  ,'codcnv' = isnull((select mnnemo from VIEW_MONEDA where mncodmon=  a.cacodmon2),'XXX')
  ,'monpag' = (case  when catipoper = 'C' AND catipmoda = 'C' and cacodmon1 = 13 and cacodmon2 = 999 then 1
     when catipoper = 'C' AND catipmoda = 'E' and cacodmon1 = 13 and cacodmon2 = 999 then 1
     when catipoper = 'C' AND catipmoda = 'C' and cacodmon1 = 13 and cacodmon2 = 998 then 2
     when catipoper = 'C' AND catipmoda = 'E' and cacodmon1 = 13 and cacodmon2 = 998 then 2
     when catipoper = 'V' AND catipmoda = 'C' and cacodmon1 = 13 and cacodmon2 = 999 then 1
     when catipoper = 'V' AND catipmoda = 'E' and cacodmon1 = 13 and cacodmon2 = 999 then 3
     when catipoper = 'V' AND catipmoda = 'C' and cacodmon1 = 13 and cacodmon2 = 998 then 2
     when catipoper = 'V' AND catipmoda = 'E' and cacodmon1 = 13 and cacodmon2 = 998 then 3
     when catipmoda = 'E' and cacodmon2 = 13 then 3
     when catipmoda = 'C' and cacodmon2 = 13 then 1
     else 0
         END)
  ,'mtomex'  = a.camtomon1
  ,'modal'  = a.catipmoda
  ,'diasrse'  = a.caplazo
  ,'valdia'  = a.cavalordia
  ,'Codigo_Cartera'  = a.cacodpos1
  ,'Moneda1'   = a.cacodmon1
  ,'Moneda2'   = a.cacodmon2
  ,'Dias_Residuales'  = a.caplazovto    
  ,'Monto_Moneda1'   = a.camtomon1    
  ,'Monto_moneda2'   = a.camtomon2    
  ,'Valor_Moneda1_Hoy'  = (CASE WHEN a.cacodpos1 = 2 AND a.catipoper = 'C' THEN a.cavalordia
         ELSE 0
             END   )  
  ,'Valor_Basilea'   = (CASE a.catipoper WHEN 'C' THEN a.camtomon1
                            ELSE a.camtomon2
          END     )
  ,'Moneda_Basilea'  = (CASE a.catipoper WHEN 'C' THEN a.cacodmon1
              ELSE a.cacodmon2
          END     )
  ,'Valor_Basilea_Pesos'  = a.camtomon2    
  ,'Valor_Basilea_Porcent' = a.camtomon2    
  ,'Canasta'    = '      '     
  ,'Tramo'     = 0     
  ,'Porcentaje'    = 10.512    
  ,'Fecha_Proceso'   = CONVERT(CHAR(10),C.acfecante,103) 
  ,'Hora'     = CONVERT(CHAR(8),GETDATE(),108) 
  ,'NemMonedaBasilea'  = '       '
 INTO  #temp 
 FROM  mfca a    ,
  view_cliente b    ,
  mfac   C
 WHERE a.cacodigo = b.Clrut 
  and a.cacodcli  = b.Clcodigo
         and  a.cafecvcto > C.acfecante
 --ORDER BY a.canumoper
 -- Rescata el Código de la Canasta y Actualiza el Nemotecnico de la Moneda de Basilea
 UPDATE  #temp
 SET  Canasta = mncanasta  ,
  NemMonedaBasilea = mnnemo  
 FROM   view_moneda
 WHERE   Moneda_Basilea = mncodmon
 -- Actualiza el Valor en Pesos de Basilea
 UPDATE  #temp
 SET   Valor_Basilea_Pesos =  CASE WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 7 ) AND tipope = 'C' THEN ROUND(Valor_Basilea * @dolar_observado,0)
      WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 7 ) AND tipope = 'V' AND moneda2 = 999 THEN Valor_Basilea
      WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 7 ) AND tipope = 'V' AND moneda2 = 998 THEN ROUND(Valor_Basilea * @valor_uf,0)
      WHEN Codigo_Cartera = 2 AND tipope = 'C' THEN Valor_Moneda1_Hoy
      WHEN Codigo_Cartera = 2 AND tipope = 'V' THEN ROUND(Monto_moneda2 * @dolar_observado,0)
      WHEN Codigo_Cartera = 3 AND tipope = 'C' THEN ROUND(Monto_moneda1 * @valor_uf,0)
      WHEN Codigo_Cartera = 3 AND tipope = 'V' THEN Monto_moneda2
      ELSE 0
     END
 -- Rescata el tramo y el Porcentaje de la Canasta
 UPDATE  #temp
 SET  #temp.tramo  = a.tramo    ,
  #temp.porcentaje = ( a.porcentaje / 100 )
 FROM   view_canasta a
 WHERE   #temp.canasta = a.canasta AND
  #temp.Dias_Residuales >= a.plazo_inicial and #temp.Dias_Residuales <= a.plazo_final 
 -- Actualiza el Valor de Basilea de Acuerdo al Porcentaje
 UPDATE  #temp
 SET Valor_Basilea_Porcent = ROUND( Valor_Basilea_Pesos * porcentaje , 0 )
 SELECT  CRUT ,
  tipope ,
  numope ,
  codmon ,
  codcnv ,
  monpag ,
  mtomex ,
  modal ,
  diasrse ,
  Valor_Basilea_Porcent
 FROM #temp
  
 SET NOCOUNT OFF
END
 
-- SP_HELPTEXT sp_interfaz_perdidas
-- UPDATE MFCA SET caplazovto = DATEDIFF(DD,ACFECPROC,CAFECVCTO) FROM MFAC

GO
