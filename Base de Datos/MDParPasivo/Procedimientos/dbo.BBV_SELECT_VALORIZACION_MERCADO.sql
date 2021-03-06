USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VALORIZACION_MERCADO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create procedure [dbo].[BBV_SELECT_VALORIZACION_MERCADO]
(@FECHA DATETIME,
 @AREA  VARCHAR(10))
AS
select fecha_valorizacion,id_sistema, codigo_area, tipo_operacion, codigo_carterasuper, rut_cartera,
       numero_documento,numero_operacion, correlativo, instrumento, serie, rut_emisor,  moneda_emision,
       valor_nominal, fecha_vencimiento, valor_compra, plazo_ano, plazo_dia, tasa_compra, tasa_mercado,
       valor_presente, valor_mercado, diferencia_mercado          
from trader..valorizacion_mercado
where fecha_valorizacion = @FECHA
and codigo_area = @AREA
GO
