USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_APRUEBA_RECHAZA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_APRUEBA_RECHAZA](
					@dFecha_Inicio	DATETIME ,
					@dFecha_Termino	DATETIME ,
				    	@cAprueba	CHAR(01)	
				   )
AS
BEGIN

	SET NOCOUNT ON

IF exists(select 1 
	FROM 	DETALLE_APROBACIONES 
	WHERE	Fecha_Operacion >= @dFecha_Inicio	AND
		Fecha_Operacion <= @dFecha_Termino	AND
		Estado		=  @cAprueba  )

	SELECT 	'Sistema' = CASE WHEN Id_Sistema = 'BFW'THEN 'BAC-FORWARD (Montos expresados en Dólares )' 
				 WHEN Id_Sistema = 'BCC'THEN 'BAC-CAMBIO (Montos expresados en Dólares )' 
				 WHEN Id_Sistema = 'BTR'THEN 'BAC-TRADER (Montos expresados en Pesos )'  
				 WHEN Id_Sistema = 'BEX'THEN 'BONOS EXTERIOR (Montos expresados en Dólares )' 
				 WHEN Id_Sistema = 'OPT'THEN 'OPCIONES (Montos expresados en Dólares )' 
				 ELSE 'BAC-PARAMETROS' END,
		Numero_Operacion,
		Fecha_Operacion,
		'Operador_Origen'= (Select nombre from bacparamsuda..Usuario where SUBSTRING(usuario,1,10) = Operador_Origen),
		'Operador_Autoriza' = (Select nombre from bacparamsuda..Usuario where SUBSTRING(usuario,1,10) = Operador_Autoriza),
		Monto_Operacion,
		Monto_Operador,
		Monto_Autoriza,
		Estado,
		'Titulo' = CASE WHEN Estado = 'A'THEN 'APROBACIONES' ELSE 'RECHAZOS' END,
		'Fecha_Inicio' = CONVERT(CHAR(10),@dFecha_Inicio,103),
		'Fecha_Termino'= CONVERT(CHAR(10),@dFecha_Termino,103),
                 'Firma1' = isnull((Select nombre from bacparamsuda..Usuario where SUBSTRING(usuario,1,10) = SUBSTRING(Firma1,1,10)),''),
                 'Firma2' = isnull((Select nombre from bacparamsuda..Usuario where SUBSTRING(usuario,1,10) = SUBSTRING(Firma2,1,10)),'') 
         FROM 	DETALLE_APROBACIONES 
	WHERE	Fecha_Operacion >= @dFecha_Inicio	AND
		Fecha_Operacion <= @dFecha_Termino	AND
		Estado		=  @cAprueba            AND
                firma1          <> 'FALTA'

ELSE
	SELECT 
		'NO EXISTE INFORMACION',
		0,
		CONVERT(CHAR(10),GETDATE(),103),
		'Operador_Origen'= '',
		'Operador_Autoriza' = '',
		0,
		0,
		0,
		'',
		'Titulo' = '',
		'Fecha_Inicio' = CONVERT(CHAR(10),@dFecha_Inicio,103),
		'Fecha_Termino'= CONVERT(CHAR(10),@dFecha_Termino,103)

	SET NOCOUNT OFF

END	
GO
