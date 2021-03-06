USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_CONTABILIZA_GARANTIAS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LLENA_CONTABILIZA_GARANTIAS]
	(	@dFechaProceso	DATETIME	)
AS
BEGIN

	set nocount on
	declare	 @UsuarioMargen				 varchar(50)
		 ,   @UsuarioVencimiento		 varchar(50)
		 ,	@FechaAnterior			datetime


	set @fechaanterior = (select acfecante from MDAC)

	set @UsuarioMargen	= ISNULL((Select Glosa
									from BDBOMESA.garantia.TBL_GeneralDetalle with(nolock) 
									where IdCategoria = 32
									AND	  IdCodigo = 1), '')

	set @UsuarioVencimiento = ISNULL((Select Glosa
									from BDBOMESA.garantia.TBL_GeneralDetalle with(nolock) 
									where IdCategoria = 32
									AND	  IdCodigo = 2), '')

	-->		Limpia los eventos contables de las Garantias
	delete 	from dbo.BAC_CNT_CONTABILIZA
		  where id_sistema		= 'BTR'
			and tipo_movimiento = 'GAR'
		/*	and (	tipo_operacion  IN( 'OTRG',  'REV',  'VCT')
				or	tipo_operacion  IN( 'OTRGO', 'REVO', 'VCTO')
				or	tipo_operacion  IN( 'OTRGR', 'REVR', 'VCTR')
				or	tipo_operacion  IN( 'OTRGR', 'REVR', 'VCTR')
				)
		*/

		if @@error <> 0
		begin
			return -1
		end 
	-->		Limpia los eventos contables de las Garantias


	-->		Movimiento de Garantias ... Otorgamiento
	insert	into dbo.BAC_CNT_CONTABILIZA
		(	id_sistema
		,	tipo_movimiento
		,	tipo_operacion
		,	operacion
		,	correlativo
		,	codigo_instrumento
		,	moneda_instrumento
		,	valor_presente
		,	valor_venta
		,	forma_pago
		,	Plazo
		,	Tipo_Emisor
		,	dif_valor_mercado_pos
		,	dif_valor_mercado_neg
		,	dif_ant_pacto_pos
		,	dif_ant_pacto_neg
		,   Nominal
		)
	select	id_sistema				= 'BTR'
		,	tipo_movimiento			= 'GAR'
		,	tipo_operacion			= 'TRG' + ltrim(rtrim( car.TipoMovimiento ))
		,	operacion				= car.nGarantia
		,	correlativo				= car.nCorrela
		,	codigo_instrumento		= car.Composicion
		,	moneda_instrumento		= car.IdMoneda
	-----------------------------------------------------------
		,	valor_presente			= car.nValor
		,	valor_venta				= car.nValor
		,	forma_pago				= car.IdMedioPago

		,	Plazo					= cnt.IdMoneda
		,	Tipo_Emisor				= cnt.Id
		-->	Dia
		,	dif_valor_mercado_pos	= case when car.nValor >= 0 then car.nValor else 0.0 end
		,	dif_valor_mercado_neg	= case when car.nValor >= 0 then 0.0 else car.nValor end
		--> Reversas
		,	dif_ant_pacto_pos		= 0.0
		,	dif_ant_pacto_neg		= 0.0
		,	Nominal					= cNominal
	-----------------------------------------------------------
	from	(	select	nGarantia		= enc.NumeroGarantia
					,	nCorrela		= det.CorrelativoGarantia
					,	dFecha			= enc.FechaIngresoGarantia
					,	IdGarantia		= enc.IdTipoGarantia
					,	IdMoneda		= det.MonedaEmision
					,	IdEfectivo		= com.IdEfectivo
					,	IdMedioPago		= Pag.IdPago
					,	nValor			= det.ValorPresenteHaircut
					,	dFechaDet		= det.FechaIngresoCorrelativo
					,	Composicion		= case when det.Instrumento = 'EFECTIVO' THEN 'EFE' ELSE 'VAL' END 
					,	TipoMovimiento	= enc.Tipo
					,   cNominal		= dNominal
				from	(	-->		Cartera de Garantias
							select	tab.NumeroGarantia
								,	tab.FechaIngresoGarantia
								,	tab.IdTipoGarantia
								,	Tipo = iTipo.Nemo
							from	BdBomesa.Garantia.Tbl_CarteraGarantia tab with(nolock)
									inner join	-->	Tabla de Estados
									(	select	IdCodigo
										from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
										where	IdCategoria = 4
										and		Glosa		not in('Anulada', 'Vencida')
									)	iEstado	On iEstado.IdCodigo = tab.IdEstadoGarantia

									left join	-->	Tipos de Movimiento
									(	select	IdCodigo, nemo
										from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
										where	IdCategoria = 7
									)	iTipo	On iTipo.IdCodigo	= tab.TipoMovimiento
						)	enc

						inner join
						(	-->		Cartera de Detalle de Garantias
							select	FechaIngresoCorrelativo	= tdcg.FechaIngresoCorrelativo
								,	NumeroGarantia			= tdcg.NumeroGarantia
								,	CorrelativoGarantia		= tdcg.CorrelativoGarantia
								,	Instrumento				= tdcg.Instrumento
								,	MonedaEmision			= tdcg.MonedaEmision
								,	ValorPresenteHaircut	= case when tdcg.Instrumento = 'EFECTIVO' then tdcg.ValorPresente else tdcg.ValorPresenteHaircut END
								,   dNominal				= tdcg.Nominal
							from	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia tdcg with(nolock) 
									inner join	-->	Tabla de Estados	( RESTRICTIVO ) por estado del movimiento de la garantia
									(	select	Id			= IdCodigo
											,	Descripcion	= upper( Glosa )
										from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
										where	IdCategoria	= 4
										and		Glosa		not in('Anulada', 'Vencida')
									)	EstMov	On EstMov.Id	= tdcg.IdEstadoMovimiento
							where	tdcg.Nominal	<> 0
							and		tdcg.Usuario not in (@UsuarioMargen, @UsuarioVencimiento)
						)	det		on det.NumeroGarantia = enc.NumeroGarantia

						inner join
						(	-->		Cartera de Detalle de Garantias
							select	IdEfectivo		= IdCodigo
								,	IdNemo			= Nemo
							from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
							where	IdCategoria		= 2
						)	com		On com.IdNemo	= case when det.Instrumento = 'EFECTIVO' then 'E' else 'I' end

					,	(	-->		Medio de Pago por Defecto
							select	IdPago			= IdCodigo
								,	IdNemo			= Nemo
							from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
							where	IdCategoria		= 25
						)	Pag
			)	car

				inner join	
				(	-->		Condiciones Variables
					select	Id, IdGarantia, IdMoneda, IdEfectivo, Descripcion
					from	BdBomesa.Garantia.TBL_TipoGarantia_Cnt with(nolock)	
				)	Cnt		On	cnt.IdGarantia	= car.Idgarantia
							and cnt.IdMoneda	= car.IdMoneda
							and cnt.IdEfectivo	= car.IdEfectivo
	where	car.dFechaDet = ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
	
		if @@error <> 0
		begin
			return -2
		end 
	-->		Movimiento de Garantias ... Otorgamiento


	-->		Movimiento de Garantias ... Revalorizacion ( Sobre la Cartera Vigente )
	insert	into dbo.BAC_CNT_CONTABILIZA
		(	id_sistema
		,	tipo_movimiento
		,	tipo_operacion
		,	operacion
		,	correlativo
		,	codigo_instrumento
		,	moneda_instrumento
		,	valor_presente
		,	valor_venta
		,	forma_pago
		,	Plazo
		,	Tipo_Emisor
		,	dif_valor_mercado_pos
		,	dif_valor_mercado_neg
		,	dif_ant_pacto_pos
		,	dif_ant_pacto_neg
		,	Nominal
		)
	select	id_sistema				= 'BTR'
		,	tipo_movimiento			= 'GAR'
		,	tipo_operacion			= 'REV' + ltrim(rtrim( car.Tipo ))
		,	operacion				= det.NumeroGarantia
		,	correlativo				= det.CorrelativoGarantia
		,	codigo_instrumento		= case when det.Instrumento = 'EFECTIVO' then 'EFE' ELSE 'VAL' END
		,	moneda_instrumento		= det.MonedaEmision
		-----------------------------------------------------------
		,	valor_presente			= det.ValorPresenteHaircut
		,	valor_venta				= det.ValorPresenteHaircut
		,	forma_pago				= Pag.IdPago
		,	Plazo					= cnt.IdMoneda
		,	Tipo_Emisor				= cnt.Id
		-----------------------------------------------------------
		-->	Dia
		,	dif_valor_mercado_pos	= case when det.ValorPresenteHaircut >= 0 then det.ValorPresenteHaircut else 0.0 end
		,	dif_valor_mercado_neg	= case when det.ValorPresenteHaircut <  0 then det.ValorPresenteHaircut	else 0.0 end
		--> Reversas
		,	dif_ant_pacto_pos		= isnull(case when reversa.REVValorPresenteHaircut >= 0.0 then reversa.REVValorPresenteHaircut else 0.0 end, 0.0)
		,	dif_ant_pacto_neg		= isnull(case when reversa.REVValorPresenteHaircut <  0.0 then reversa.REVValorPresenteHaircut else 0.0 end, 0.0)
		,   Nominal					= det.Nominal
	from	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia det with(nolock) 
			inner join 	-->	estados del movimiento de las Garantias
			(	select	Id = IdCodigo
				from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
				where	IdCategoria = 4
				and	not(	Glosa		like '%anulacion%' 
						or	Glosa		like '%anula%' 
						or	Glosa		like '%vencida%' 
						)
			)	Estados	On Estados.Id = det.IdEstadoMovimiento	--> Se cambio, originalmente se hacia por el estado de la garantia

			inner join	-->	Enlace con la tabla de Cartera de Garantia (encabezado)
			(	select	Folio			= NumeroGarantia
					,	Tipo			= iTipo.nemo
					,	IdTipoGarantia	= IdTipoGarantia
				from	BdBomesa.Garantia.Tbl_CarteraGarantia with(nolock)
						left join	-->	Tipos de Garantias ( Recibidas | Otorgadas )
						(	select	IdCodigo, nemo
							from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
							where	IdCategoria = 7
						)	iTipo	On iTipo.IdCodigo = TipoMovimiento
			)	Car		On Car.Folio = det.NumeroGarantia

			inner join	-->		Cartera de Detalle de Garantias
			(	select	IdEfectivo		= IdCodigo
					,	IdNemo			= Nemo
				from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
				where	IdCategoria		= 2
			)	com		On com.IdNemo	= case when det.Instrumento = 'EFECTIVO' then 'E' else 'I' end

			inner join	-->		Condiciones Variables
			(	select	Id, IdGarantia, IdMoneda, IdEfectivo, Descripcion
				from	BdBomesa.Garantia.TBL_TipoGarantia_Cnt with(nolock)	
			)	Cnt		On	cnt.IdGarantia	= car.IdTipoGarantia	-->	car.Idgarantia
						and cnt.IdMoneda	= det.MonedaEmision		-->	car.IdMoneda
						and cnt.IdEfectivo	= com.IdEfectivo		--> car.IdEfectivo

			left join	-->		detalle de Garantias, en tabla historica a la fecha anterior, para determinar reverso
			(	select	nFolio					= NumeroGarantia
					,	nCorrela				= CorrelativoGarantia
					,	dFecha					= FechaRespaldo
					,	REVValorPresenteHaircut	= case when Instrumento = 'EFECTIVO' THEN ValorPresente ELSE ValorPresenteHaircut END
				from	BdBomesa.Garantia.Tbl_Respaldo_DetalleCarteraGarantia
				where	FechaRespaldo			= ( select acfecante from bacFwdSuda.dbo.Mfac with(nolock) )
				and		Instrumento			   <> 'EFECTIVO'
			)	reversa	On	reversa.nFolio		= det.NumeroGarantia
						and reversa.nCorrela	= det.CorrelativoGarantia

		,	(	-->		Medio de Pago por Defecto
				select	IdPago			= IdCodigo
					,	IdNemo			= Nemo
				from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
				where	IdCategoria		= 25
			)	Pag
	where	det.Instrumento <> 'EFECTIVO'
	and		det.FechaIngresoCorrelativo	< ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
	and		det.Nominal > 0.0
		
		if @@error <> 0
		begin
			return -3
		end 
	-->		Movimiento de Garantias ... Revalorizacion ( Sobre la Cartera Vigente )

	-->		Movimiento de Garantias ... Revalorizacion ( Sobre las Devoluciones del Día )
	insert	into dbo.BAC_CNT_CONTABILIZA
		(	id_sistema
		,	tipo_movimiento
		,	tipo_operacion
		,	operacion
		,	correlativo
		,	codigo_instrumento
		,	moneda_instrumento
		,	valor_presente
		,	valor_venta
		,	forma_pago
		,	Plazo
		,	Tipo_Emisor
		,	dif_valor_mercado_pos
		,	dif_valor_mercado_neg
		,	dif_ant_pacto_pos
		,	dif_ant_pacto_neg
		,	Nominal
		)
	SELECT	Id_Sistema				= 'BTR'
		,	Tipo_Movimiento			= 'GAR'
		,	Tipo_Operacion			= 'REV' + DevolucionDia.TipoGarantia
		,	Operacion				= DevolucionDia.Folio
		,	Correlativo				= DevolucionDia.Correlativo
		,	Codigo_Instrumento		= case when DevolucionDia.Instrumento = 'Efectivo' then 'EFE' else 'VAL' end
		,	Moneda_Instrumento		= DevolucionDia.Moneda
		----------------------------------------------------------------------------------------------------
		,	Valor_Presente			= DevolucionDia.VPHaircut
		,	Valor_Venta				= DevolucionDia.VPHaircut
		,	Forma_Pago				= DevolucionDia.Pago
		,	Plazo					= DevolucionDia.Plazo
		,	Tipo_Emisor				= DevolucionDia.TipoEmisor
		----------------------------------------------------------------------------------------------------
		,	dif_valor_mercado_pos	= case when DevolucionDia.VPHaircut >= 0 then DevolucionDia.VPHaircut	else 0.0 end
		,	dif_valor_mercado_neg	= case when DevolucionDia.VPHaircut <  0 then DevolucionDia.VPHaircut	else 0.0 end
		----------------------------------------------------------------------------------------------------
		,	dif_ant_pacto_pos		= isnull(case when DevolucionDia.RevVPHaircut >= 0.0 then DevolucionDia.RevVPHaircut else 0.0 end, 0.0)
		,	dif_ant_pacto_neg		= isnull(case when DevolucionDia.RevVPHaircut <  0.0 then DevolucionDia.RevVPHaircut else 0.0 end, 0.0)
		,	Nominal					= Nominal
	FROM	
		(	select	Fecha			= Detalle.Fecha
				,	Folio			= Detalle.Folio
				,	Correlativo		= Detalle.Correlativo
				,	Instrumento		= Detalle.Instrumento
				,	Moneda			= Detalle.Moneda
				,	VPHaircut		= Detalle.VPHaircut
				,	TipoGarantia	= car.Tipo
				,	Estado			= Detalle.IdEstado
				,	Plazo			= Cnt.IdMoneda
				,	TipoEmisor		= Cnt.Id
				,	RevVPHaircut	= Rev.VPHaircut
				,	Pago			= Pag.IdPago
				,	Nominal			= Detalle.Nominal
			from	(	select	Fecha		= det.FechaIngresoCorrelativo
							,	Folio		= det.NumeroGarantia
							,	Correlativo	= det.CorrelativoGarantia
							,	Instrumento	= det.Instrumento
							,	Moneda		= det.MonedaEmision
							,	VPHaircut	= det.ValorPresenteHaircut
							,	IdEstado	= det.IdEstadoMovimiento
							,	Nominal		= det.Nominal
						from	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia det with(nolock) 
								inner join
								(	select	Id = IdCodigo
									from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
									where	IdCategoria = 4
									and	not(	Glosa		like '%anulacion%' 
											or	Glosa		like '%anula%' 
											or	Glosa		like '%vencida%' 
											)
								)	Estados	On Estados.Id	= det.IdEstadoMovimiento

								inner join	--> Devoluciones del Día, debe estar en movimiento del día
								(	select  NumGar	= numerogarantia
										,	CorrGar	= correlativogarantia
									from	BdBomesa.Garantia.Tbl_MovimientoGarantia
									where	IdEstadoMovimiento IN(12, 10)
									and		FechaIngresoCorrelativo	= ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
									and		Nominal					> 0
								)	DevDia	On	DevDia.NumGar		= det.NumeroGarantia
											and	DevDia.CorrGar		= det.CorrelativoGarantia

						where	det.FechaIngresoCorrelativo	< ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
						and		det.Instrumento			   <> 'Efectivo'
						and		det.Nominal					= 0				
					)	Detalle

					inner join	-->	Enlace con la tabla de Cartera de Garantia (encabezado)
					(	select	Folio			= cg.NumeroGarantia
							,	Tipo			= iTipo.nemo
							,	IdTipoGarantia	= cg.IdTipoGarantia
						from	BdBomesa.Garantia.Tbl_CarteraGarantia cg with(nolock)
								left join	-->	Tipos de Movimientos ( Recibidas | Otorgadas )
								(	select	IdCodigo, nemo
									from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
									where	IdCategoria = 7
								)	iTipo	On iTipo.IdCodigo = cg.TipoMovimiento
					)	Car		On Car.Folio = Detalle.Folio

					inner join	-->		Cartera de Detalle de Garantias
					(	select	IdEfectivo		= tgd.IdCodigo
							,	IdNemo			= tgd.Nemo
						from	bdbomesa.Garantia.TBL_GeneralDetalle tgd with(nolock)
						where	tgd.IdCategoria		= 2
					)	com		On com.IdNemo	= case when Detalle.Instrumento = 'EFECTIVO' then 'E' else 'I' end

					inner join	-->		Condiciones Variables
					(	select	Id, IdGarantia, IdMoneda, IdEfectivo, Descripcion
						from	BdBomesa.Garantia.TBL_TipoGarantia_Cnt with(nolock)	
					)	Cnt		On	cnt.IdGarantia	= car.IdTipoGarantia	-->	car.Idgarantia
								and cnt.IdMoneda	= Detalle.Moneda		-->	car.IdMoneda
								and cnt.IdEfectivo	= com.IdEfectivo		--> car.IdEfectivo

					left join	-->		detalle de Garantias, en tabla historica a la fecha anterior, para determinar reverso
					(	select	Folio		= NumeroGarantia
							,	Correla		= CorrelativoGarantia
							,	Fecha		= FechaRespaldo
							,	VPHaircut	= case when Instrumento = 'EFECTIVO' THEN ValorPresente ELSE ValorPresenteHaircut END
						from	BdBomesa.Garantia.Tbl_Respaldo_DetalleCarteraGarantia with(nolock)
						where	FechaRespaldo	 = ( select acfecante from bacFwdSuda.dbo.Mfac with(nolock) )
						and		Instrumento		<> 'EFECTIVO'								
					)	Rev		On	Rev.Folio	 = Detalle.Folio
								and Rev.Correla	 = Detalle.Correlativo

				,	(	-->		Medio de Pago por Defecto
						select	IdPago			= IdCodigo
							,	IdNemo			= Nemo
						from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
						where	IdCategoria		= 25
					)	Pag
		)	DevolucionDia

		if @@error <> 0
		begin
			return -3
		end 
	-->		Movimiento de Garantias ... Revalorizacion ( Sobre las Devoluciones del Día )


	/*
		SE RETIRA A SOLICITUD DE TANIA MONCADA	
		CON FECHA : MIERCOLES 13-01-2016
	*/


	-->		Movimiento de Garantias ... Alzamientos por intercambio
	insert	into dbo.BAC_CNT_CONTABILIZA
		(	id_sistema
		,	tipo_movimiento
		,	tipo_operacion
		,	operacion
		,	correlativo
		,	codigo_instrumento
		,	moneda_instrumento
		,	valor_presente
		,	valor_venta
		,	forma_pago
		,	Plazo
		,	Tipo_Emisor
		,	dif_valor_mercado_pos
		,	dif_valor_mercado_neg
		,	dif_ant_pacto_pos
		,	dif_ant_pacto_neg
		,	Nominal
		)
	select	id_sistema				= 'BTR'
		,	tipo_movimiento			= 'GAR'
		,	tipo_operacion			= 'VCT' + ltrim(rtrim( car.TipoMovimiento ))
		,	operacion				= mov.numerogarantia
		,	correlativo				= mov.correlativogarantia
		,	codigo_instrumento		= case when mov.Instrumento = 'EFECTIVO' THEN 'EFE' ELSE 'VAL' END 
		,	moneda_instrumento		= mov.monedaemision
		-----------------------------------------------------------
		,	valor_presente			= mov.ValorPresenteHaircut
		,	valor_venta				= mov.ValorPresenteHaircut
		,	forma_pago				= Pag.IdPago
		,	Plazo					= cnt.IdMoneda
		,	Tipo_Emisor				= cnt.Id
		-----------------------------------------------------------
		-->	Dia
		,	dif_valor_mercado_pos	= case when mov.ValorPresenteHaircut >= 0 then mov.ValorPresenteHaircut else 0.0 end
		,	dif_valor_mercado_neg	= case when mov.ValorPresenteHaircut <  0 then mov.ValorPresenteHaircut else 0.0 end
		--> Reversas
		,	dif_ant_pacto_pos		= 0.0
		,	dif_ant_pacto_neg		= 0.0
		,	Nominal				=  mov.Nominal
	from	BdBomesa.Garantia.Tbl_MovimientoGarantia mov with(nolock)
			inner join
			(	-->		Estados asociados a garantia
				select	IdCodigo,  Glosa
				from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
				where	IdCategoria = 4
				and	(	Glosa		like '%Recibida%'
					or	Glosa		like '%Entregada%'
					)
			)	EstGar	On EstGar.IdCodigo = mov.IdEstadoGarantia
			inner join
			(	-->		Estados asociados a garantia
				select	IdCodigo,  Glosa
				from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
				where	IdCategoria = 4
				and	(	Glosa		like '%Devolucion%'
					or	Glosa		like '%Intercambio%'
					)
			)	EstMov	On EstMov.IdCodigo = mov.IdEstadoMovimiento

			inner join
			(	-->		Cartera garantia
				select	Folio			= NumeroGarantia
					,	TipoMovimiento	= Tipo.nemo
					,	IdTipoGarantia	= IdTipoGarantia
				from	BdBomesa.Garantia.Tbl_CarteraGarantia with(nolock)
						left join	-->	Tipos de Garantias ( Recibidas | Otorgadas )
						(	select	IdCodigo, nemo
							from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
							where	IdCategoria = 7
						)	Tipo	On Tipo.IdCodigo = TipoMovimiento
			)	Car		On	Car.Folio	= mov.numerogarantia

			inner join	-->		Cartera de Detalle de Garantias
			(	select	IdEfectivo		= IdCodigo
					,	IdNemo			= Nemo
				from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
				where	IdCategoria		= 2
			)	com		On com.IdNemo	= case when mov.Instrumento = 'EFECTIVO' then 'E' else 'I' end

			inner join	-->		Condiciones Variables
			(	select	Id, IdGarantia, IdMoneda, IdEfectivo, Descripcion
				from	BdBomesa.Garantia.TBL_TipoGarantia_Cnt with(nolock)	
			)	Cnt		On	cnt.IdGarantia	= car.IdTipoGarantia	-->	car.Idgarantia
						and cnt.IdMoneda	= mov.MonedaEmision		-->	car.IdMoneda
						and cnt.IdEfectivo	= com.IdEfectivo		--> car.IdEfectivo

		,	(	-->		Medio de Pago por Defecto
				select	IdPago			= IdCodigo
					,	IdNemo			= Nemo
				from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
				where	IdCategoria		= 25
			)	Pag
	where	mov.FechaIngresoCorrelativo = ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
	and		mov.Instrumento				= 'EFECTIVO'
	and		mov.Usuario				    <> @UsuarioMargen

		if @@error <> 0
		begin
			return -4
		end 
	-->		Movimiento de Garantias ... Alzamientos por intercambio

/*PRD24171: CONTABILIDAD REGISTRO DE EFECTIVOS NPV Y VENCIMIENTOS (COMDER)*/

	

--> Movimiento de Garantias ... Revalorizacion NPV
insert	into dbo.BAC_CNT_CONTABILIZA
		(	id_sistema
		,	tipo_movimiento
		,	tipo_operacion
		,	operacion
		,	correlativo
		,	codigo_instrumento
		,	moneda_instrumento
		,	valor_presente
		,	valor_venta
		,	forma_pago
		,	Plazo
		,	Tipo_Emisor
		,	dif_valor_mercado_pos
		,	dif_valor_mercado_neg
		,	dif_ant_pacto_pos
		,	dif_ant_pacto_neg
		,	Nominal
		)
/*npv*/
		SELECT	Id_Sistema			= 'BTR'
		,	Tipo_Movimiento			= 'GAR'
		,	Tipo_Operacion			= 'GNPV'
		,	Operacion				= DevolucionDia.Folio
		,	Correlativo				= DevolucionDia.Correlativo
		,	Codigo_Instrumento		= 'EFE' 
		,	Moneda_Instrumento		= DevolucionDia.Moneda
		----------------------------------------------------------------------------------------------------
		,	Valor_Presente			= ROUND(DevolucionDia.VPHaircut, 0)
		,	Valor_Venta				= CASE WHEN ISNULL (DevolucionDia.RevVPHaircut, 0) <> 0 then ROUND(DevolucionDia.RevVPHaircut, 0) else ROUND(DevolucionDia.VPHaircut, 0)  end
		,	Forma_Pago				= 0
		,	Plazo					= 0
		,	Tipo_Emisor				= 0
		----------------------------------------------------------------------------------------------------
		,	dif_valor_mercado_pos	= case when DevolucionDia.VPHaircut >= 0 then ABS(ROUND(DevolucionDia.VPHaircut,0))	else 0.0 end
		,	dif_valor_mercado_neg	= case when DevolucionDia.VPHaircut <  0 then ABS(ROUND(DevolucionDia.VPHaircut, 0))	else 0.0 end
		----------------------------------------------------------------------------------------------------
		,	dif_ant_pacto_pos		= isnull(case when DevolucionDia.RevVPHaircut >= 0.0 then ABS(ROUND(DevolucionDia.RevVPHaircut, 0)) else 0.0 end, 0.0)
		,	dif_ant_pacto_neg		= isnull(case when DevolucionDia.RevVPHaircut <  0.0 then ABS(ROUND(DevolucionDia.RevVPHaircut, 0)) else 0.0 end, 0.0)
		,	Nominal					= DevolucionDia.Nominal
	FROM	
		(	select	Fecha			= Detalle.Fecha
				,	Folio			= Detalle.Folio
				,	Correlativo		= Detalle.Correlativo
				,	Instrumento		= Detalle.Instrumento
				,	Moneda			= Detalle.Moneda
				,	VPHaircut		= Detalle.VPHaircut
				,	TipoGarantia	= car.Tipo
				,	Estado			= Detalle.IdEstado		
				,	RevVPHaircut	= Rev.VPHaircut		
				,	Nominal			= Detalle.Nominal
			from	(	select	Fecha		= det.FechaIngresoCorrelativo
							,	Folio		= det.NumeroGarantia
							,	Correlativo	= det.CorrelativoGarantia
							,	Instrumento	= det.Instrumento
							,	Moneda		= det.MonedaEmision
							,	VPHaircut	= det.ValorPresenteHaircut
							,	IdEstado	= det.IdEstadoMovimiento
							,	Nominal		= det.Nominal
						from	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia det with(nolock) 
								inner join
								(	select	Id = IdCodigo
									from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
									where	IdCategoria = 4
									and	not(	Glosa		like '%anulacion%' 
											or	Glosa		like '%anula%' 
											or	Glosa		like '%vencida%' 
											)
								)	Estados	On Estados.Id	= det.IdEstadoMovimiento

								left join	--> Devolucion del Día, debe estar en movimiento del día para npv
								(	select  NumGar	= numerogarantia
										,	CorrGar	= correlativogarantia
									from	BdBomesa.Garantia.Tbl_MovimientoGarantia
									where	IdEstadoMovimiento		= 17 --> Devolucion ajuste Saldo
									and		Usuario					=  @UsuarioMargen
									and		FechaIngresoCorrelativo	=( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
									--and		Nominal					> 0
								)	DevDia	On	DevDia.NumGar		= det.NumeroGarantia
											and	DevDia.CorrGar		= det.CorrelativoGarantia

						where	det.FechaIngresoCorrelativo	<= ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
						and		det.Instrumento			   = 'Efectivo'
						and		det.Usuario		 		   = @UsuarioMargen
					)	Detalle

					inner join	-->	Enlace con la tabla de Cartera de Garantia (encabezado)
					(	select	Folio			= cg.NumeroGarantia
							,	Tipo			= iTipo.nemo
							,	IdTipoGarantia	= cg.IdTipoGarantia
						from	BdBomesa.Garantia.Tbl_CarteraGarantia cg with(nolock)
								left join	-->	Tipos de Movimientos ( Recibidas | Otorgadas )
								(	select	IdCodigo, nemo
									from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
									where	IdCategoria = 7
								)	iTipo	On iTipo.IdCodigo = cg.TipoMovimiento
					)	Car		On Car.Folio = Detalle.Folio

					inner join	-->		Cartera de Detalle de Garantias
					(	select	IdEfectivo		= tgd.IdCodigo
							,	IdNemo			= tgd.Nemo
						from	bdbomesa.Garantia.TBL_GeneralDetalle tgd with(nolock)
						where	tgd.IdCategoria		= 2
					)	com		On com.IdNemo	= 'E' 

					inner join	-->		Condiciones Variables
					(	select	Id, IdGarantia, IdMoneda, IdEfectivo, Descripcion
						from	BdBomesa.Garantia.TBL_TipoGarantia_Cnt with(nolock)	
					)	Cnt		On	cnt.IdGarantia	= car.IdTipoGarantia	-->	car.Idgarantia
								and cnt.IdMoneda	= Detalle.Moneda		-->	car.IdMoneda
								and cnt.IdEfectivo	= com.IdEfectivo		--> car.IdEfectivo

					left join	-->		detalle de Garantias, en tabla historica a la fecha anterior, para determinar reverso
					(	select	Folio		= NumeroGarantia
							,	Correla		= CorrelativoGarantia
							,	Fecha		= FechaRespaldo
							,	VPHaircut	= ValorPresente 
						from	BdBomesa.Garantia.Tbl_Respaldo_DetalleCarteraGarantia with(nolock)
						where	FechaRespaldo	 = ( select acfecante from bacFwdSuda.dbo.Mfac with(nolock) )
						and		Instrumento		= 'EFECTIVO'
						AND		Usuario			= @UsuarioMargen
					)	Rev		On	Rev.Folio	 = Detalle.Folio
								and Rev.Correla	 = Detalle.Correlativo
		)	DevolucionDia
		if @@error <> 0
		begin
			return -5
		end 
		
		/*fin de npv*/

/*liquidacion*/
insert	into dbo.BAC_CNT_CONTABILIZA
		(	id_sistema
		,	tipo_movimiento
		,	tipo_operacion
		,	operacion
		,	correlativo
		,	codigo_instrumento
		,	moneda_instrumento
		,	valor_presente
		,	valor_venta
		,	forma_pago
		,	Plazo
		,	Tipo_Emisor
		,	dif_valor_mercado_pos
		,	dif_valor_mercado_neg
		,	dif_ant_pacto_pos
		,	dif_ant_pacto_neg
		,	Nominal
		)

		select	id_sistema			= 'BTR'
		,	tipo_movimiento			= 'GAR'
		,	tipo_operacion			= 'GLIQ'
		,	operacion				= car.nGarantia
		,	correlativo				= car.nCorrela
		,	codigo_instrumento		= 'EFE' 
		,	moneda_instrumento		= car.IdMoneda 
	-----------------------------------------------------------
		,	valor_presente			= car.nValor
		,	valor_venta				= car.nValor
		,	forma_pago				= 0
		,	Plazo					= cnt.IdMoneda
		,	Tipo_Emisor				= cnt.Id
		-->	Dia
		,	dif_valor_mercado_pos	= case when car.nValor >= 0 then ABS(car.nValor) else 0.0 end
		,	dif_valor_mercado_neg	= case when car.nValor >= 0 then 0.0 else ABS(car.nValor) end
		--> Reversas
		,	dif_ant_pacto_pos		= 0.0
		,	dif_ant_pacto_neg		= 0.0
		,   Nominal					= car.cNominal
	-----------------------------------------------------------
	from	(	select	nGarantia		= enc.NumeroGarantia
					,	nCorrela		= det.CorrelativoGarantia
					,	dFecha			= enc.FechaIngresoGarantia
					,	IdGarantia		= enc.IdTipoGarantia
					,	IdMoneda		= det.MonedaEmision
					,	IdEfectivo		= com.IdEfectivo					
					,	nValor			= det.ValorPresenteHaircut
					,	dFechaDet		= det.FechaIngresoCorrelativo
					,	Composicion		=  'EFE' 
					,	TipoMovimiento	= enc.Tipo
					,	Usuario			= det.Usuario
					,   cNominal		= dNominal
				from	(	-->		Cartera de Garantias
							select	tab.NumeroGarantia
								,	tab.FechaIngresoGarantia
								,	tab.IdTipoGarantia
								,	Tipo = iTipo.Nemo
							from	BdBomesa.Garantia.Tbl_CarteraGarantia tab with(nolock)
									inner join	-->	Tabla de Estados
									(	select	IdCodigo
										from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
										where	IdCategoria = 4
										and		Glosa		not in('Anulada', 'Vencida')
									)	iEstado	On iEstado.IdCodigo = tab.IdEstadoGarantia

									left join	-->	Tipos de Movimiento
									(	select	IdCodigo, nemo
										from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
										where	IdCategoria = 7
									)	iTipo	On iTipo.IdCodigo	= tab.TipoMovimiento
						)	enc

						inner join
						(	-->		Cartera de Detalle de Garantias
							select	FechaIngresoCorrelativo	= tdcg.FechaIngresoCorrelativo
								,	NumeroGarantia			= tdcg.NumeroGarantia
								,	CorrelativoGarantia		= tdcg.CorrelativoGarantia
								,	Instrumento				= tdcg.Instrumento
								,	MonedaEmision			= tdcg.MonedaEmision
							--	,	ValorPresenteHaircut	= case when tdcg.Instrumento = 'EFECTIVO' then tdcg.ValorPresente else tdcg.ValorPresenteHaircut end
								,	ValorPresenteHaircut	= tdcg.ValorPresente 
								,	Usuario					= tdcg.Usuario
								,	dNominal				= tdcg.Nominal
							from	BdBomesa.Garantia.Tbl_DetalleCarteraGarantia tdcg with(nolock) 
									inner join	-->	Tabla de Estados	( RESTRICTIVO ) por estado del movimiento de la garantia
									(	select	Id			= IdCodigo
											,	Descripcion	= upper( Glosa )
										from	BdBomesa.Garantia.Tbl_GeneralDetalle with(nolock)
										where	IdCategoria	= 4
										and		Glosa		not in('Anulada', 'Vencida')
									)	EstMov	On EstMov.Id	= tdcg.IdEstadoMovimiento
							where	tdcg.Nominal				<> 0
							AND		tdcg.Usuario				 = @UsuarioVencimiento
							AND		tdcg.FechaIngresoCorrelativo =  ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) ) /*Se contabiliza sólo el registro del día*/
						)	det		on det.NumeroGarantia = enc.NumeroGarantia

						inner join
						(	-->		Cartera de Detalle de Garantias
							select	IdEfectivo		= IdCodigo
								,	IdNemo			= Nemo
							from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
							where	IdCategoria		= 2
						)	com		On com.IdNemo	=  'E' 

					--,	(	-->		Medio de Pago por Defecto
					--		select	IdPago			= IdCodigo
					--			,	IdNemo			= Nemo
								
					--		from	bdbomesa.Garantia.TBL_GeneralDetalle with(nolock)
					--		where	IdCategoria		= 33
					--	)	Pag
			)	car

				inner join	
				(	-->		Condiciones Variables
					select	Id, IdGarantia, IdMoneda, IdEfectivo, Descripcion
					from	BdBomesa.Garantia.TBL_TipoGarantia_Cnt with(nolock)	
				)	Cnt		On	cnt.IdGarantia	= car.Idgarantia
							and cnt.IdMoneda	= car.IdMoneda
							and cnt.IdEfectivo	= car.IdEfectivo
	where	car.dFechaDet =  ( select acfecproc from BacFwdSuda.dbo.Mfac with(nolock) )
	and		car.Usuario	  = @UsuarioVencimiento
	if @@error <> 0
		begin
			return -6
		end 

		/*fin de liquidacion*/

END
GO
