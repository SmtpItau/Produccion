USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VALORIZACION_MERCADO_NEW]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[BBV_SELECT_VALORIZACION_MERCADO_NEW]
@fecha_cartera 		datetime,
@fecha_valorizacion 	datetime,
@area 			varchar(10)

as

declare @id_valorizacion int

select @id_valorizacion = (select id_valorizacion 
from trader..valorizacion 
where   datediff(day, Fecha_Valorizacion, @Fecha_Valorizacion) = 0
	and datediff(day, fecha_Cartera, @fecha_Cartera) = 0
	and Comentarios = 'Valorizacion Automatica')


select fecha_valorizacion, sistema, area, tipo_operacion, tipo_cartera, rut_cartera = ''
, numero_documento, numero_operacion, correlativo, instrumento, nemotecnico, emisor_rut, codigo_moneda1
, nominal, fecha_vencimiento, valor_compra = -1, plazo_ano = -1, plazo_residual, tasa_compra, tasa_mercado
, valor_presente, valor_mercado, ajuste_mercado

from trader..VALORIZACION_DETALLE where id_valorizacion = @id_valorizacion and sistema = 'btr'

GO
