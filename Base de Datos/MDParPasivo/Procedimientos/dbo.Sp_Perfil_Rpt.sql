USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Perfil_Rpt]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_Perfil_Rpt]
	(	@id_sistema			CHAR(3)     ='X'
	,	@codigo_producto 	CHAR(5)     ='X'
	,	@codigo_evento		CHAR(5)     ='X'
	,	@codigo_moneda1		NUMERIC(5)  = 0 
	,	@Saldo				CHAR(1)     ='N'
	)
as
begin

	SET NOCOUNT ON

	SELECT	'hora_reporte'          = CONVERT(CHAR(10),GETDATE(),108)   
		,	'fecha_reporte'         = CONVERT(CHAR(10),GETDATE(),103) 	
		,	'Campo'					= d.codigo_campo
		,	'descripcion_campo'		= d.descripcion_campo
		,	'tipo_monto'			= b.tipo_movimiento_cuenta
		,	'perfil_fijo'			= b.perfil_fijo
		,	'cuenta'				= b.codigo_cuenta

		,	'descripcion_cuenta'	= case	when b.perfil_fijo = 'N' then '' 
											else h.descripcion 
										end
		
		,	'codigo_campo'          = b.codigo_campo_variable
		,	'codigo_condicion'		= isnull(g.descripcion_campo, '')
		,	'descripcion_condicion'	= case	when b.perfil_fijo = 'N' then (select top 1 tbglosa from tabla_general_detalle where tbcateg = 101 and tbcodigo1 = e.valor_dato_campo)
											else ''
										end
		,	'cuenta1'               = case	when b.perfil_fijo = 'N' then e.codigo_cuenta
											else ''--b.codigo_cuenta
										end
		,	'correlativo_perfil'	= b.correlativo_perfil
		,   'TITULO'				= '     PERFIL CONTABLE     '
	FROM	PERFIL_CNT						a with(nolock)

			inner join PERFIL_DETALLE_CNT	b with(nolock)	On	b.Folio_Perfil				= a.Folio_Perfil

			inner join CAMPO_CNT			d with(nolock)	On	d.id_sistema				= a.id_sistema
															and	d.tipo_movimiento			= a.tipo_movimiento
															and d.tipo_operacion			= a.tipo_operacion
															and d.codigo_campo				= b.codigo_campo


			left  join PERFIL_VARIABLE_CNT	e with(nolock)	On	e.Folio_Perfil				= b.Folio_Perfil
															and e.correlativo_perfil		= b.correlativo_perfil

			left  join CAMPO_CNT			g with(nolock)	On	g.id_sistema				= a.id_sistema
															and	g.tipo_movimiento			= a.tipo_movimiento
															and g.tipo_operacion			= a.tipo_operacion
															and g.codigo_campo				= b.codigo_campo_variable

			left  join PLAN_DE_CUENTA		h with(nolock)	On	ltrim(rtrim( h.cuenta ))	= CASE	WHEN b.perfil_fijo = 'S' THEN	ltrim(rtrim( b.codigo_cuenta ))
																									ELSE							ltrim(rtrim( e.codigo_cuenta ))
																								END
	WHERE	(	A.id_sistema			= @id_sistema			or @id_sistema		= ''	)
	AND		(	A.codigo_instrumento	= @codigo_producto		or @codigo_producto	= ''	)
	AND		(	A.tipo_movimiento		= @codigo_evento		or @codigo_evento	= ''	)
	AND		(	A.moneda_instrumento	= @codigo_moneda1		or @codigo_moneda1	= 0		)
	ORDER 
	BY		b.correlativo_perfil

end

GO
