USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TICKERS_CARGA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TICKERS_CARGA]
(
	@codigo_ticker				as char(2),
	@hora_ticker				as char(10),
	@codigo_accion				as char(1),
	@hora_transaccion			as char(10),
	@folio						as numeric,
	@nemotecnico				as char(10),
	@codigo_isn					as char(12),
	@cantidad					as decimal(17,2),
	@codigo_corredor_comprador	as numeric,
	@codigo_corredor_vendedor	as numeric,
	@codigo_operador_comprador	as numeric,
	@codigo_operador_vendedor	as numeric,
	@condicion_codificada		as char(10),
	@codicion_desplegable		as char(10),
	@monto						as decimal(17,2),
	@plazo						as numeric,
	@plazo_bonos				as numeric,
	@precio						as decimal(15,4),
	@remate						as char(2),
	@tir						as decimal(5,2),
	@tipo_calculo				as char(1),
	@operador_interno_comprador as char(3),
	@operador_interno_vendedor	as char(3),
	@ind_dcv					as char(1),
	@moneda						as char(3),
	@monto_moneda_liquidacion	as decimal(15,2),    
	@emisor						as char(10),
    @familia					as char(2),
	@fecha_vencimiento			as char(8),
    @lamina						as char(1),
	@lugar						as char(1),
	@madurez					as char(1),
	@tiporeajuste				as char(2),
	@val_resc					as decimal(15,4)
)

as
BEGIN
	insert into tbl_tickers_bolsa
	(
		codigo_ticker,
		hora_ticker,
		codigo_accion,
		hora_transaccion,
		folio,
		nemotecnico,
		codigo_isn,
		cantidad,
		codigo_corredor_comprador,
		codigo_corredor_vendedor,
		codigo_operador_comprador,
		codigo_operador_vendedor,
		condicion_codificada,
		codicion_desplegable,
		monto,
		plazo,
		plazo_bonos,
		precio,
		remate,
		tir,
		tipo_calculo,
		estado,
		codigo_bac,
		usuario,
		operador_interno_comprador,
		operador_interno_vendedor,
		ind_dcv,
		moneda,
		monto_moneda_liquidacion,
		emisor,
		familia,
		fecha_Vencimiento,
		lamina,
		lugar,
		madurez,
		tiporeajuste,
		val_resc,
		hora_recepcion)
	values(
		@codigo_ticker,
		@hora_ticker,
		@codigo_accion,
		@hora_transaccion,
		@folio,
		@nemotecnico,
		@codigo_isn,
		@cantidad,
		@codigo_corredor_comprador,
		@codigo_corredor_vendedor,
		@codigo_operador_comprador,
		@codigo_operador_vendedor,
		@condicion_codificada,
		@codicion_desplegable,
		@monto,
		@plazo,
		@plazo_bonos,
		@precio,
		@remate,
		@tir,
		@tipo_calculo,
		0, --Estado
		0, --BAC
		'',--Usuario
		@operador_interno_comprador,
		@operador_interno_vendedor,
		@ind_dcv,
		@moneda,
		@monto_moneda_liquidacion,
		@emisor,
		@familia,
		@fecha_Vencimiento,
		@lamina,
		@lugar,
		@madurez,
		@tiporeajuste,
		@val_resc,
		Getdate()
)	

END
GO
