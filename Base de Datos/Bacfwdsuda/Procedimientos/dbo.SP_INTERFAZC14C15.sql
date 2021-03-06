USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZC14C15]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZC14C15]
AS
BEGIN
SET NOCOUNT ON
DECLARE @dolar_observado NUMERIC(12,04) ,
 @valor_uf  NUMERIC(12,04) ,
 @registros  NUMERIC(10)
 
SELECT  @dolar_observado = vmvalor FROM view_valor_moneda, mfac WHERE vmcodigo=accodmondolobs AND vmfecha= acfecproc
SELECT  @valor_uf  = vmvalor FROM view_valor_moneda, mfac WHERE vmcodigo=accodmonuf AND vmfecha= acfecproc
SELECT 'FechaPro' =  convert(char(10),c.acfecproc,112),
       'FW'       =  'FW',
       'Rut'      =  cliente.clrut,
       'dv'       =  cliente.cldv,
       'cuenta'   =  case when catipoper='C' and cavalordia < 0 then '2127634109' 
                          when catipoper='C' and cavalordia >=0 then '4127634101' 
                          when catipoper='V' and cavalordia < 0 then '2127634001'  
                          when catipoper='V' and cavalordia >=0 then '4127634004' else '0000000000' end  ,
       'Valor_Basilea_Porcent' = a.camtomon2    ,
       'codmon2'   = 999,
       'fechav'   = convert(char(10),cafecvcto,112),
 'Codigo_Cartera' = a.cacodpos1    ,
 'Tipo_Operacion' = a.catipoper    ,
 'moneda_2'  = a.cacodmon2    ,
 'Monto_moneda2'  = a.camtomon2    ,
 'Monto_Moneda1'  = a.camtomon1    ,
 'Dias_Residuales' = a.caplazovto    ,
 'Valor_Moneda1_Hoy' = CASE   WHEN a.cacodpos1 = 2 AND a.catipoper = 'C' THEN a.cavalordia   ELSE 0   END  ,
 'Valor_Basilea'  = CASE a.catipoper   WHEN 'C' THEN a.camtomon1  ELSE a.camtomon2  END   ,
 'Moneda_Basilea' = CASE a.catipoper   WHEN 'C' THEN a.cacodmon1  ELSE a.cacodmon2  END   ,
 'Valor_Basilea_Pesos' = a.camtomon2    ,
 'Canasta'  = '     '     ,
 'Tramo'   = 0     ,
 'Porcentaje'  = 10.512    ,
 'NemMonedaBasilea' = '      '                                 
INTO #temp
from mfca a, view_cliente cliente,mfac c
where (cacodigo=cliente.clrut  and cacodcli=cliente.clcodigo) and (cacodpos1=1 or cacodpos1=3 or cacodpos1=8) and cafecvcto > c.acfecproc
      and (cliente.cltipcli=1 or cliente.cltipcli=2 or cliente.cltipcli=3 ) 
order by a.canumoper
-- Rescata el Código de la Canasta y Actualiza el Nemotecnico de la Moneda de Basilea
UPDATE  #temp SET Canasta= mncanasta, NemMonedaBasilea = mnnemo FROM view_moneda WHERE   Moneda_Basilea = mncodmon
-- Actualiza el Valor en Pesos de Basilea
UPDATE  #temp SET Valor_Basilea_Pesos = CASE
     WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 8 ) AND Tipo_Operacion = 'C' THEN ROUND(Valor_Basilea * @dolar_observado,0)
       WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 8 ) AND Tipo_Operacion = 'V' AND moneda_2 = 999 THEN Valor_Basilea
       WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 8 ) AND Tipo_Operacion = 'V' AND moneda_2 = 998 THEN ROUND(Valor_Basilea * @valor_uf,0)
       WHEN Codigo_Cartera = 2 AND Tipo_Operacion = 'C' THEN Valor_Moneda1_Hoy
       WHEN Codigo_Cartera = 2 AND Tipo_Operacion = 'V' THEN ROUND(Monto_moneda2 * @dolar_observado,0)
       WHEN Codigo_Cartera = 3 AND Tipo_Operacion = 'C' THEN ROUND(Monto_moneda1 * @valor_uf,0)
       WHEN Codigo_Cartera = 3 AND Tipo_Operacion = 'V' THEN Monto_moneda2
       ELSE 0
       END
-- Rescata el tramo y el Porcentaje de la Canasta
UPDATE  #temp SET #temp.tramo = a.tramo ,#temp.porcentaje = ( a.porcentaje / 100 )FROM  view_canasta a 
              WHERE   #temp.canasta = a.canasta AND #temp.Dias_Residuales >= a.plazo_inicial and
                      #temp.Dias_Residuales <= a.plazo_final 
-- Actualiza el Valor de Basilea de Acuerdo al Porcentaje
UPDATE  #temp SET Valor_Basilea_Porcent = ROUND( Valor_Basilea_Pesos * porcentaje , 0 )
select * from #temp
SET NOCOUNT OFF
END 

GO
