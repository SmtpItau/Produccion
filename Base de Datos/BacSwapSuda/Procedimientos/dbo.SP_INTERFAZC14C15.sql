USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZC14C15]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZC14C15]    
AS
BEGIN
SET NOCOUNT ON
-- Swap: Guardar Como
DECLARE @dolar_observado 	FLOAT,
	@valor_uf   		FLOAT ,
	@registros  		NUMERIC(10)
 
SELECT  @dolar_observado = vmvalor FROM view_valor_moneda, swapgeneral WHERE vmcodigo = 994 AND vmfecha= fechaproc
SELECT  @valor_uf  = vmvalor FROM view_valor_moneda, swapgeneral WHERE vmcodigo=998 AND vmfecha= fechaproc

SELECT 	 'FechaPro' =  convert(char(10),c.fechaproc,112),
       	 'Sistema'  =  'SW',
       	 'Rut'      =  cliente.clrut,
       	 'dv'       =  cliente.cldv,
       	 'cuenta'   =  case when tipo_operacion ='C' and devengo_monto_peso < 0 then '2127111111' 
                          when tipo_operacion = 'C' and devengo_monto_peso >=0 then '4127222222' 
                          when tipo_operacion = 'V' and devengo_monto_peso < 0 then '2127333333'  
                          when tipo_operacion = 'V' and devengo_monto_peso >=0 then '4127444444' else '0000000000' end  ,
       	 'Valor_Basilea_Porcent' = compra_capital    ,
       	 'codmon2'   	= 999,
       	 'fechav'    	= convert(char(10),fecha_termino,112),
   	 'Codigo_Cartera' = cartera_inversion    , -- select * from cartera
	 'Tipo_Operacion' = tipo_operacion    ,
	 'moneda_2'  	= venta_moneda    ,
	 'Monto_moneda2'= a.compra_capital    ,
	 'Monto_Moneda1'= a.compra_capital    ,
	 'Dias_Residuales' = datediff(day ,c.fechaproc, fecha_termino)    ,
	 'Valor_Moneda1_Hoy' =  a.devengo_monto_peso   ,
	 'Valor_Basilea'  = CASE a.tipo_operacion   WHEN 'C' THEN a.compra_capital ELSE a.venta_capital  END   ,
	 'Moneda_Basilea' = CASE a.tipo_operacion   WHEN 'C' THEN a.compra_moneda ELSE a.venta_moneda  END   ,
	 'Valor_Basilea_Pesos' = a.compra_capital    ,
	 'Canasta'  	= '  '     ,
	 'Tramo'   	= 0     ,
	 'Porcentaje'  	= 10.512    ,
	 'NemMonedaBasilea' = '   '                                 
INTO 	#temp
FROM 	cartera a, view_cliente cliente,swapgeneral c
WHERE 	(a.rut_cliente = cliente.clrut  and a.codigo_cliente = cliente.clcodigo) 
	and  c.fechaproc between fecha_inicio_flujo and fecha_vence_flujo
	and (cliente.cltipcli=1 or cliente.cltipcli=2 or cliente.cltipcli=3 ) 
	AND tipo_flujo = 1
        AND a.Estado <> 'C'
ORDER BY a.numero_operacion

INSERT   INTO #temp
SELECT 	 'FechaPro' =  convert(char(10),c.fechaproc,112),
       	 'Sistema'  =  'SW',
       	 'Rut'      =  cliente.clrut,
       	 'dv'       =  cliente.cldv,
       	 'cuenta'   =  case when tipo_operacion ='C' and devengo_monto_peso < 0 then '2127111111' 
                          when tipo_operacion = 'C' and devengo_monto_peso >=0 then '4127222222' 
                          when tipo_operacion = 'V' and devengo_monto_peso < 0 then '2127333333'  
                          when tipo_operacion = 'V' and devengo_monto_peso >=0 then '4127444444' else '0000000000' end  ,
       	 'Valor_Basilea_Porcent' = compra_capital    ,
       	 'codmon2'   	= 999,
       	 'fechav'    	= convert(char(10),fecha_termino,112),
   	 'Codigo_Cartera' = cartera_inversion    , -- select * from cartera
	 'Tipo_Operacion' = tipo_operacion    ,
	 'moneda_2'  	= venta_moneda    ,
	 'Monto_moneda2'= a.compra_capital    ,
	 'Monto_Moneda1'= a.compra_capital    ,
	 'Dias_Residuales' = datediff(day ,c.fechaproc, fecha_termino)    ,
	 'Valor_Moneda1_Hoy' =  a.devengo_monto_peso   ,
	 'Valor_Basilea'  = CASE a.tipo_operacion   WHEN 'C' THEN a.compra_capital ELSE a.venta_capital  END   ,
	 'Moneda_Basilea' = CASE a.tipo_operacion   WHEN 'C' THEN a.compra_moneda ELSE a.venta_moneda  END   ,
	 'Valor_Basilea_Pesos' = a.compra_capital    ,
	 'Canasta'  	= '  '     ,
	 'Tramo'   	= 0     ,
	 'Porcentaje'  	= 10.512    ,
	 'NemMonedaBasilea' = '   '                                 
FROM 	cartera a, view_cliente cliente,swapgeneral c
WHERE (a.rut_cliente = cliente.clrut  and a.codigo_cliente = cliente.clcodigo) 
	and  c.fechaproc between fecha_inicio_flujo and fecha_vence_flujo
	and (cliente.cltipcli=1 or cliente.cltipcli=2 or cliente.cltipcli=3 ) 
	AND tipo_flujo = 2
        AND a.Estado <> 'C'
ORDER BY a.numero_operacion



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
UPDATE  #temp SET #temp.tramo = a.tramo ,#temp.porcentaje = ( a.porcentaje / 100 )
  FROM  view_canasta a 
 WHERE   #temp.canasta = a.canasta AND #temp.Dias_Residuales >= a.plazo_inicial and
         #temp.Dias_Residuales <= a.plazo_final 


-- Actualiza el Valor de Basilea de Acuerdo al Porcentaje
UPDATE  #temp SET Valor_Basilea_Porcent = ROUND( Valor_Basilea_Pesos * porcentaje , 0 )


select * from #temp

SET NOCOUNT OFF
END 

GO
