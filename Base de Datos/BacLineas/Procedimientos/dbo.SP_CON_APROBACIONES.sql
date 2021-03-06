USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_APROBACIONES]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_CON_APROBACIONES]
		(
			@dfechapro		DATETIME
		)
as
begin

	SELECT 	d.Id_Sistema
	,	d.Numero_operacion
	,	d.Operador_Origen
	,	d.Operador_Autoriza
	,	d.Fecha_Operacion
	,	d.Monto_Operacion
	,	d.Monto_Autoriza
	,	p.codigo_producto
	,	t.rut_cliente
	,	t.codigo_cliente
	,	c.clnombre
	,	e.moneda
	,	p.descripcion
	,	d.estado
--	INTO	#TEMP1
	FROM 	DETALLE_APROBACIONES	d
	,	limite_transaccion	l
	,	linea_transaccion	t
	,	view_producto		p
	,	view_cliente		c
	,	linea_transaccion_detalle e
	where 	d.id_sistema = CASE 	WHEN l.id_sistema = 'BEX' THEN 'BTR'
					WHEN l.id_sistema = 'PCS' THEN 'BFW'
					ELSE l.id_sistema
				END
	and	d.numero_Operacion 	= l.numerooperacion
	and	d.fecha_Operacion	= l.Fechaoperacion
	and	d.id_sistema = CASE 	WHEN t.id_sistema = 'BEX' THEN 'BTR'
					WHEN l.id_sistema = 'PCS' THEN 'BFW'
					ELSE t.id_sistema
				END
	and	d.numero_operacion	= t.numerooperacion
	and	d.fecha_operacion	= t.fechainicio
	and	t.codigo_producto	= CASE WHEN p.codigo_producto = 'ST' THEN '1'
					       WHEN p.codigo_producto = 'SM' THEN '2'
					       ELSE p.codigo_producto
					  END
	and	t.id_sistema		= p.id_sistema
	and	t.rut_cliente		= clrut
	and	t.codigo_cliente	= clcodigo
	and	d.numero_operacion	= e.numerooperacion
	and 	t.rut_cliente		= e.rut_cliente
	and	t.codigo_cliente	= e.codigo_cliente
	and	e.Numerocorre_detalle	= 1

	AND	d.estado		= 'A'
	ORDER BY d.numero_Operacion


END	

GO
