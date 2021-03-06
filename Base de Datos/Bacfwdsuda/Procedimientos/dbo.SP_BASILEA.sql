USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BASILEA]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BASILEA]
AS
BEGIN
SET NOCOUNT ON

DECLARE @dolar_observado NUMERIC(12,04) ,
	@valor_uf   NUMERIC(12,04) ,
  	@registros  NUMERIC(10),
  	@entidad    char(40)
 
SELECT  @dolar_observado = vmvalor
FROM  	view_valor_moneda ,
	mfac   
WHERE 	vmcodigo = accodmondolobs AND
  	vmfecha  = acfecproc
  
SELECT	@valor_uf  = vmvalor,
    	@entidad   = acnomprop
FROM  	view_valor_moneda ,
        mfac   
WHERE 	vmcodigo = accodmonuf  AND
  	vmfecha  = acfecproc

SELECT 	'Codigo_Cartera'		= a.cacodpos1    ,
  		'Numero_Operacion'		= a.canumoper    ,
		'Tipo_Operacion'		= a.catipoper    ,
  		'fecha_vence'			= CONVERT(CHAR(10),a.cafecvcto,103) ,
		'moneda_1'				= a.cacodmon1    ,
		'moneda_2'				= a.cacodmon2    ,
		'Monto_moneda2'			= a.camtomon2    ,
		'UF_inicial'			= b.vmvalor    ,
		'Monto_Moneda1'			= a.camtomon1    ,
  		'Monto_Pesos_Moneda1'	= a.caequmon1    ,
  		'Precio Futuro'			= a.catipcam    ,
  		'Dias_Residuales'		= a.caplazovto    ,
  		'Paridad_Valorizacion'	= a.catipcamval    ,
  		'Perdida_Devengada'		= a.caperddevenga   ,
  		'Utilidad_Devengada'	= a.cautildevenga   ,
  		'Reajuste_UF'			= a.cadifuf * ( CASE WHEN a.cacodpos1 = 1 AND a.catipoper = 'C' THEN -1 ELSE 1 END )  ,
  		'Reajuste_TC'			= a.cadiftipcam * ( CASE WHEN a.cacodpos1 = 1 AND a.catipoper = 'V' THEN -1 ELSE 1 END ) ,
  		'Valor_Moneda1_Hoy'		= 	CASE WHEN 	a.cacodpos1 = 2 AND a.catipoper = 'C' THEN a.cavalordia ELSE 0  END ,
  		'Valor_Basilea'			= CASE a.catipoper  WHEN 'C' THEN a.camtomon1 ELSE a.camtomon2  END     ,
  		'Moneda_Basilea'		= CASE a.catipoper WHEN 'C' THEN a.cacodmon1 ELSE a.cacodmon2 END     ,
  		'Valor_Basilea_Pesos'	= a.camtomon2    ,
  		'Valor_Basilea_Porcent' = a.camtomon2    ,
  		'Canasta'				= SPACE(6)     ,
  		'Tramo'					= 0     ,
  		'Porcentaje'			= 10.512    ,
  		'Fecha_Proceso'			= CONVERT(CHAR(10),c.acfecproc,103) ,
  		'Hora'					= CONVERT(CHAR(8),GETDATE(),108) ,
  		'NemMonedaBasilea'		= SPACE(6),
		'entidad'				= @entidad
INTO 	#temp
FROM 	mfca   a,
  	view_valor_moneda b,
  	mfac   c
WHERE   a.fRes_Obtenido > 0
   AND  a.cacodpos1    IN(1,2,3,7)
   AND (c.accodmonuf = b.vmcodigo
   AND  a.cafecha    = b.vmfecha)

/*
WHERE 	a.cavalordia > 0   AND
  	( a.cacodpos1 = 1   OR
    	a.cacodpos1 = 2  OR
    	a.cacodpos1 = 3  OR
    	a.cacodpos1 = 7 )   AND
  	( c.accodmonuf = b.vmcodigo AND
    	a.cafecha = b.vmfecha )
*/
 -- Rescata el Código de la Canasta y Actualiza el Nemotecnico de la Moneda de Basilea
 
UPDATE  #temp
SET 	Canasta = mncanasta  ,
	NemMonedaBasilea = mnnemo  
FROM  	view_moneda
WHERE   Moneda_Basilea = mncodmon

 -- Actualiza el Valor en Pesos de Basilea
UPDATE  #temp
SET  Valor_Basilea_Pesos =  CASE
	WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 7 ) AND Tipo_Operacion = 'C' THEN ROUND(Valor_Basilea * @dolar_observado,0)
       	WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 7 ) AND Tipo_Operacion = 'V' AND moneda_2 = 999 THEN Valor_Basilea
       	WHEN ( Codigo_Cartera = 1 OR Codigo_Cartera = 7 ) AND Tipo_Operacion = 'V' AND moneda_2 = 998 THEN ROUND(Valor_Basilea * @valor_uf,0)
       	WHEN Codigo_Cartera = 2 AND Tipo_Operacion = 'C' THEN Valor_Moneda1_Hoy
       	WHEN Codigo_Cartera = 2 AND Tipo_Operacion = 'V' THEN ROUND(Monto_moneda2 * @dolar_observado,0)
       	WHEN Codigo_Cartera = 3 AND Tipo_Operacion = 'C' THEN ROUND(Monto_moneda1 * @valor_uf,0)
       	WHEN Codigo_Cartera = 3 AND Tipo_Operacion = 'V' THEN Monto_moneda2
       	ELSE 0
       	END

 -- Rescata el tramo y el Porcentaje de la Canasta
UPDATE  #temp
SET 	#temp.tramo  = a.tramo    ,
  	#temp.porcentaje = ( a.porcentaje / 100 )
FROM  	view_canasta a
WHERE   #temp.canasta = a.canasta AND
	#temp.Dias_Residuales >= a.plazo_inicial and 
	#temp.Dias_Residuales <= a.plazo_final 

 -- Actualiza el Valor de Basilea de Acuerdo al Porcentaje
UPDATE  #temp
SET 	Valor_Basilea_Porcent = ROUND( Valor_Basilea_Pesos * porcentaje , 0 )

SELECT 		* 
FROM 		#temp 
where 		tramo > 0 
order by  	Tipo_Operacion, 
		Moneda_Basilea, 
		Tramo, 
		Dias_Residuales 

SET NOCOUNT OFF

END

GO
