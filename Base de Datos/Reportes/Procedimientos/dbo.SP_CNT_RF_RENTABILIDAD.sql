USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_CNT_RF_RENTABILIDAD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_CNT_RF_RENTABILIDAD]
as
begin
/*
	replica del proceso de contabilizacion de operaciones y movimientos de sistema BacTraderSuda (Renta Fija)
	- toma los datos de la tabla bac_cnt_contabiliza  --> la cual ya tiene procesados los valores a contabilizar
	- los concentra en una tabla de resumen para luego generar 'vouchers' contables x operacion desagrupada.
*/

set nocount on
set dateformat ymd
set concat_null_yields_null off

declare @fecha date

if @fecha is null begin
	select @fecha = acfecproc from BacTraderSuda.dbo.MDAC	
	--(select max(fecha_proceso)
	--from 
	--bactradersuda.dbo.bac_cnt_contabiliza_resumen
	--where fecha_proceso <> '19000101')	
end

if exists(select distinct 1 from Reportes.dbo.cnt_aux_rentabilidad_rf
			where fecha_ingreso = @fecha) begin
	
	delete Reportes.dbo.cnt_aux_det_rentabilidad_rf
    from  Reportes.dbo.cnt_aux_rentabilidad_rf a
	where a.numero_voucher = cnt_aux_det_rentabilidad_rf.numero_voucher     
	and a.fecha_ingreso  = @fecha

	delete Reportes.dbo.cnt_aux_rentabilidad_rf 
	where fecha_ingreso = @fecha 	
end


if (select count(*) from CNT_AUX_RESUMEN_RF_RENT) >0 begin
	-- print 'truncando: CNT_AUX_RESUMEN_RF_RENT'
	truncate table CNT_AUX_RESUMEN_RF_RENT
end

/************************************************************************************************************************/
/*				CONTABILIZACION DESAGRUPADA PARA RENTABILIDAD BAC MESA DINERO											*/
/************************************************************************************************************************/
	INSERT INTO CNT_AUX_RESUMEN_RF_RENT
	SELECT 
/*1*/			   id_sistema,
/*2*/		       tipo_movimiento,
/*3*/		       tipo_operacion,
/*4*/		       operacion,
/*5*/		       correlativo,
/*6*/		       codigo_instrumento,
/*7*/		       moneda_instrumento,
/*8*/		       SUM(valor_compra),
/*9*/		       SUM(valor_presente),
/*10*/		       SUM(valor_venta),
/*11*/		       SUM(utilidad),
/*12*/		       SUM(perdida),
/*13*/		       SUM(interes_papel),
/*14*/		       SUM(reajuste_papel),
/*15*/		       SUM(interes_pacto),
/*16*/		       SUM(reajuste_pacto),
/*17*/		       SUM(valor_cupon),
/*18*/		       SUM(nominalpesos),
/*19*/		       SUM(valor_comprahis),
/*20*/		       SUM(dif_ant_pacto_pos),
/*21*/		       SUM(dif_ant_pacto_neg),
/*22*/		       SUM(dif_valor_mercado_pos),
/*23*/		       SUM(dif_valor_mercado_neg),
/*24*/		       condicion_pacto,
/*25*/		       forma_pago,
/*26*/		       tipo_instrumento,
/*27*/		       tipo_cliente,
/*28*/		       tipo_emisor,
/*29*/		       forma_pago_entregamos,
/*30*/		       SUM(valor_futuro),
/*31*/		       condicion_entrega,
/*32*/		       tipo_operacion_or,
/*33*/		       comquien,
/*34*/		       '',
/*35*/		       0,
/*36*/		       0,
/*37*/		       tipo_bono,
/*38*/		       clasificacion_cliente,
/*39*/		       SUM(valor_final),
/*40*/		       cartera_origen,
/*41*/		       SUM(interes_positivo),
/*42*/		       SUM(interes_negativo),
/*43*/		       SUM(reajuste_positivo),
/*44*/		       SUM(reajuste_negativo),
/*45*/		       plazo,
/*46*/		       0,
/*47*/		       0,
/*47*/		       fecha_proceso,
/*48*/		       SUM(interes_reajuste),
/*49*/		       SUM(nominal),
/*50*/		       SUM(valor_tasa_emision),
/*51*/		       SUM(prima_total),
/*52*/		       SUM(descuento_total),
/*53*/		       SUM(prima_dia),
/*54*/		       SUM(descuento_dia),
/*55*/		       SUM(valor_pte_emision),
/*56*/		       SUM(dif_par_pos),
/*57*/		       SUM(dif_par_neg),
/*58*/		       Tipo_Cartera,
/*59*/		       CondPactoCliente,
/*60*/			   SUM(monto_pagomañana),
/*61*/				SUM(Utilidad_Avr_Patrimonio),		--> Ventas AFS
/*62*/				SUM(Perdida_Avr_Patrimonio),		--> Ventas AFS
/*63*/				SUM(Diferencia_Precio_Pos),			--> Ventas AFS
/*64*/				SUM(Diferencia_Precio_Neg)			--> Ventas AFS
	FROM   BactraderSuda.dbo.BAC_CNT_CONTABILIZA
	WHERE  LEFT(instser, 3) <> 'DPX'
	  AND tipo_movimiento <> 'TMF'
	GROUP       
	BY
		   id_sistema,      
	       tipo_movimiento,
	       tipo_operacion,
		   operacion,
		   correlativo,
	       codigo_instrumento,
	       moneda_instrumento,
	       condicion_pacto,
	       forma_pago,
	       tipo_instrumento,
	       tipo_cliente,
	       tipo_emisor,
	       forma_pago_entregamos,
	       condicion_entrega,
	       tipo_operacion_or,
	       comquien,
	       tipo_bono,
	       clasificacion_cliente,
	       cartera_origen,
	       plazo,
	       fecha_proceso,
	       Tipo_Cartera,
	       CondPactoCliente      

	INSERT INTO CNT_AUX_RESUMEN_RF_RENT
	SELECT id_sistema,
	       tipo_movimiento,
	       tipo_operacion,
		   operacion,
	       correlativo,
	       codigo_instrumento,
	       moneda_instrumento,
	       valor_compra,
	       valor_presente,
	       valor_venta,
	       utilidad,
	       perdida,
	       interes_papel,
	       reajuste_papel,
	       interes_pacto,
	       reajuste_pacto,
	       valor_cupon,
	       nominalpesos,
	       valor_comprahis,
	       dif_ant_pacto_pos,
	       dif_ant_pacto_neg,
	       dif_valor_mercado_pos,
	       dif_valor_mercado_neg,
	       condicion_pacto,
	       forma_pago,
	       tipo_instrumento,
	       tipo_cliente,
	       tipo_emisor,
	       forma_pago_entregamos,
	       valor_futuro,
	       condicion_entrega,
	       tipo_operacion_or,
	       comquien,
	       instser,
	       documento,
	       Emisor,
	       tipo_bono,
	       clasificacion_cliente,
	       valor_final,
	       cartera_origen,
	       interes_positivo,
	       interes_negativo,
	       reajuste_positivo,
	       reajuste_negativo,
	       plazo,
	       cliente,
	       codcli,
	       fecha_proceso,
	       interes_reajuste,
	       nominal,
	       valor_tasa_emision,
	       prima_total,
	       descuento_total,
	       prima_dia,
	       descuento_dia,
	       valor_pte_emision,
	       dif_par_pos,
	       dif_par_neg,
	       Tipo_Cartera,
	       CondPactoCliente,
	       monto_pagomañana,
		   Utilidad_Avr_Patrimonio,	--> Ventas AFS
		   Perdida_Avr_Patrimonio,		--> Ventas AFS
		   Diferencia_Precio_Pos,		--> Ventas AFS
		   Diferencia_Precio_Neg		--> Ventas AFS

	FROM   BacTraderSuda.dbo.BAC_CNT_CONTABILIZA
	WHERE  LEFT(instser, 3) = 'DPX'
	       OR  tipo_movimiento = 'TMF'     

/************************************************************************************************************************/
/*				CONTABILIZACION DESAGRUPADA PARA RENTABILIDAD BAC MESA DINERO											*/
/************************************************************************************************************************/
	declare @numero_voucher numeric(10)
	
	
	-- print 'limpieza de vouchers ya generados.'
	delete CNT_AUX_DET_RENTABILIDAD_RF 
	from CNT_AUX_RENTABILIDAD_RF a
	where a.Numero_Voucher = CNT_AUX_DET_RENTABILIDAD_RF.Numero_Voucher
	and a.Fecha_Ingreso = @fecha

	delete Reportes.dbo.CNT_AUX_RENTABILIDAD_RF 
	where fecha_ingreso = @fecha 	

	-- print 'buscando numero de folio.'
	set @numero_voucher = 
		(
		select isnull(max(numero_voucher),0) + 1
		from Reportes.dbo.CNT_AUX_DET_RENTABILIDAD_RF
		--where Fecha_Ingreso = (select acfecante from bactradersuda.dbo.mdac) 
		)
	
	-- print 'limpieza de tablas de auxiliares de vouchers.'
	--truncate table CNT_AUX_RENTABILIDAD_RF -- cabecera
	--truncate table CNT_AUX_DET_RENTABILIDAD_RF --detalle

	-- print 'declaracion variables cursorsh' + char(13)
	declare 
	@id_sistema			char(3),
	@tipo_movimiento	char(3),
	@tipo_operacion		char(5),
	@correlativo		numeric(10),
	@operacion			numeric(10),
	@documento			numeric(10),
	@moneda_instrumento	char(6),
	@codigo_instrumento char(10),
	@instrumento		char(12),
	@tipo_cliente		char(1),
	@fecha_proceso		char(10),
	@id_automatico		numeric(10),
	@t_operacion_org	char(3)



	declare cur_movimiento scroll cursor for
	select 
		id_sistema,
		tipo_movimiento,
		tipo_operacion,
		operacion,
		correlativo,
		codigo_instrumento,
		moneda_instrumento,
		instser,
		documento,
		tipo_cliente,
		convert(char(10),fecha_proceso,112),
		cartera_origen,
		id_automatico
	from CNT_AUX_RESUMEN_RF_RENT
	order by instser

	open cur_movimiento
	fetch first from cur_movimiento
	into @id_sistema,@tipo_movimiento,@tipo_operacion,
	@operacion,@correlativo,@codigo_instrumento,@moneda_instrumento
	,@instrumento,@documento,@tipo_cliente,@fecha_proceso,
	@t_operacion_org,@id_automatico

	
	-- print 'inicio ciclo de contabilizacion'
	while @@fetch_status = 0 begin
		-- print @id_automatico

		declare 
			@existe						char(1)
			,@glosa_perfil				char(70)
			,@tipo_voucher				char(1)
			,@tipo_perfil				char(1)
			,@folio_perfil				numeric(5)
			,@iMonedaInstrumentoPaso	char(06)
			-- variables conformacion detalle voucher		
			,@codigo_campo				numeric(3)
			,@codigo_campo_variable		numeric(3)
			,@tipo_movimiento_cuenta	char(1)
			,@perfil_fijo				char(1)
			,@codigo_cuenta				char(20)
			,@correlativo_perfil		numeric(3)
			,@correlativo_voucher		numeric(10)
			,@total_debe				numeric(21,4)
			,@total_haber				numeric(21,4)
			,@monto						numeric(21,4)
		
		
		set @existe = 'N'

		if @codigo_instrumento = 'PDBC110703' begin
			set @codigo_instrumento = substring(@codigo_instrumento,1,4)
		end

		-- print 'verificano perfil contable'
		if exists(select 1 
			from BacTraderSuda.dbo.view_perfil_cnt
			where 
				id_sistema		= @id_sistema
			and tipo_movimiento = @tipo_movimiento
			and tipo_operacion	= @tipo_operacion
			and codigo_instrumento = @codigo_instrumento
			and moneda_instrumento = @moneda_instrumento
			) begin

			select 
				 @existe		= 'S'
				,@tipo_voucher	= tipo_voucher
				,@glosa_perfil	= glosa_perfil
				,@folio_perfil	= folio_perfil
			from BacTraderSuda.dbo.view_perfil_cnt
			where 
				id_sistema		= @id_sistema
			and tipo_movimiento = @tipo_movimiento
			and tipo_operacion	= @tipo_operacion
			and codigo_instrumento = @codigo_instrumento
			and moneda_instrumento = @moneda_instrumento
		end

		-- print 'Instrumento Paso (moneda)'
		set @iMonedaInstrumentoPaso = 
		(
			select 
			case 
				when @codigo_instrumento = 'LCHR' then '999' 
				else convert(char(6),isnull(inmonemi,'0'))
			end
			from BacParamSuda.dbo.Instrumento
			where inserie = @codigo_instrumento		
		)
			
		-- print 'Generacion del detalle de voucher'
		if @existe = 'S' begin
		
			declare cur_detalle scroll cursor for
			select
				codigo_campo,
				tipo_movimiento_cuenta,
				perfil_fijo,
				codigo_cuenta,
				correlativo_perfil,
				codigo_campo_variable
			from bactradersuda.dbo.view_perfil_detalle_cnt
			where folio_perfil = @folio_perfil
			order by folio_perfil,correlativo_perfil
		
			open cur_detalle 
			fetch first from cur_detalle 
			into 
				@codigo_campo,
				@tipo_movimiento_cuenta,
				@perfil_fijo,
				@codigo_cuenta,
				@correlativo_perfil,
				@codigo_campo_variable
			
			set @correlativo_voucher	= 1
			set @total_debe				= 0.0
			set @total_haber			= 0.0

			-- print 'iniciando detalle del voucher'
			while @@fetch_status = 0 begin
				declare @sqlcmd			varchar(max)
				declare @nombre_campo	char(30)
				declare @concepto		varchar(70)
				declare @valor_campo	varchar(40)

				-- print 'limpiando almacen intermedio.(otros valores)'
				delete BacTraderSuda.dbo.BAC_CNT_CONTABILIZA_PASO

				-- print 'buscando nombre de campo a contabilizar'
				set @nombre_campo = 
				(select top 1 ltrim(rtrim(nombre_campo_tabla)) 
				 from bactradersuda.dbo.view_campo_cnt
				 where 
					 id_sistema					= @id_sistema
				 and tipo_movimiento			= @tipo_movimiento
				 and tipo_operacion				= @tipo_operacion
				 and codigo_campo				= @codigo_campo
				 and tipo_administracion_campo	= 'F')
				 			 

				 set @sqlcmd = 
				 'insert into BacTraderSuda.dbo.bac_cnt_contabiliza_paso( monto ) 
				  select ' + rtrim(@nombre_campo) +'
				  from Reportes.dbo.CNT_AUX_RESUMEN_RF_RENT 
				  where 
						ID_Sistema		='''	+ rtrim(ltrim(@id_sistema))			+ ''' 
					and Tipo_Movimiento	='''	+ rtrim(ltrim(@tipo_movimiento))	+ ''' 
					and Tipo_Operacion	='''	+ rtrim(ltrim(@tipo_operacion))		+ ''' 
					and Operacion		='		+ ltrim(rtrim(str(@operacion)))		+ ' 
					and Correlativo		='		+ ltrim(rtrim(str(@correlativo)))	+ ' 
					and Documento		='		+ ltrim(rtrim(str(@documento)))		+ ' 
					and id_automatico	='		+ ltrim(rtrim(str(@id_automatico))) + '
					and fecha_proceso	='''	+ ltrim(rtrim(str(@fecha_proceso)))	+''''

				execute (@sqlcmd)

				set @monto = (select isnull(monto,0) from bactradersuda.dbo.bac_cnt_contabiliza_paso)
				-- print 'limpiando almacen intermedio.(monto)'
				delete BacTraderSuda.dbo.BAC_CNT_CONTABILIZA_PASO

				if @monto<> 0.0 begin
					if @perfil_fijo='N' begin
						select 
							@nombre_campo	= ltrim(rtrim(nombre_campo_tabla))
							,@concepto		= ltrim(rtrim(isnull(descripcion_campo,'No encontrado')))
						from bactradersuda.dbo.view_campo_cnt
						where id_sistema	= @id_sistema
						and tipo_movimiento = @tipo_movimiento
						and tipo_operacion	= @tipo_operacion
						and codigo_campo	= @codigo_campo_variable
						and tipo_administracion_campo = 'V'

						-- print 'limpiando almacen intermedio.(valores otros procesos)'
						delete BacTraderSuda.dbo.BAC_CNT_CONTABILIZA_PASO

						set @sqlcmd = 
						'insert into BacTraderSuda.dbo.bac_cnt_contabiliza_paso(valor_campo) 
						 select ' + ltrim(rtrim(@Nombre_Campo)) + '
						 from Reportes.dbo.CNT_AUX_RESUMEN_RF_RENT
						 where
							 ID_Sistema			='''	+ rtrim(ltrim(@id_sistema))			+ ''' 
						 and Tipo_Movimiento	='''	+ rtrim(ltrim(@tipo_movimiento))	+ ''' 
						 and Tipo_Operacion		='''	+ rtrim(ltrim(@tipo_operacion))		+ ''' 
						 and Operacion			='		+ ltrim(rtrim(str(@operacion)))		+ ' 
						 and Correlativo		='		+ ltrim(rtrim(str(@correlativo)))	+ '
						 and id_automatico		='		+ ltrim(rtrim(str(@id_automatico))) + ' 
						 and Documento			='		+ ltrim(rtrim(str(@documento)))		+ ''

						 execute (@sqlcmd)

						 set @valor_campo = (select top 1 isnull(valor_campo,'') from bactradersuda.dbo.bac_cnt_contabiliza_paso)

						 -- print 'limpiando almacen intermedio.(valor_campo)'
						 delete BacTraderSuda.dbo.BAC_CNT_CONTABILIZA_PASO

						 --select  * from bactradersuda.dbo.bac_cnt_contabiliza_paso
						 
						 set @sqlcmd = 
						 'insert into BacTraderSuda.dbo.bac_cnt_contabiliza_paso(codigo_cuenta)
						  select codigo_cuenta 
						  from bactradersuda.dbo.view_perfil_variable_cnt
						  where
						  	  folio_perfil			= ' + rtrim(ltrim(str(@folio_perfil))) + '
						  and correlativo_perfil	= ' + rtrim(ltrim(str(@correlativo_perfil))) + '
						  and valor_dato_campo		= ''' + rtrim(ltrim(@valor_campo)) + ''''


						  execute(@sqlcmd)
						  set @codigo_cuenta = ltrim(rtrim((select top 1 isnull(codigo_cuenta,'') from BacTraderSuda.dbo.bac_cnt_contabiliza_paso )))

						  -- print 'limpiando almacen intermedio.(codigo_cuenta)'
						  delete BacTraderSuda.dbo.BAC_CNT_CONTABILIZA_PASO
					end	-- if @perfil_fijo ='N'

					if @codigo_cuenta<>'' begin
						if @monto<0.0 begin
							if @tipo_movimiento_cuenta = 'D' begin
								set @tipo_movimiento_cuenta='H'
							end else begin
								set @tipo_movimiento_cuenta='D' 
							end
							set @monto=@monto * -1.0
						end									
					
						if @tipo_operacion='RC' and @moneda_instrumento=13 begin
							set @monto = round(@monto,4)
						end else begin
							if not (@tipo_operacion = 'RV' and @moneda_instrumento <> 999) begin
								if @iMonedaInstrumentoPaso = 999 begin
									set @monto = round(@monto,0)
								end
							end
						end

						if @tipo_movimiento_cuenta='D' begin
							set @total_debe = @total_debe + @monto
						end else begin
							set @total_haber = @total_haber + @monto
						end

						if (@codigo_campo in (46,52,53)) and (@tipo_operacion in ('VI','RC')) begin
							set @moneda_instrumento = @imonedainstrumentopaso
						end
						
						if (@codigo_campo=99) and (@tipo_operacion in ('CI','RV')) begin
							if @moneda_instrumento = 13 and @imonedainstrumentopaso = 994 
								set @moneda_instrumento=13
							else 
								set @moneda_instrumento = @imonedainstrumentopaso						
						end

			
						-- print 'Grabando detalle del voucher'
						insert into Reportes.dbo.CNT_AUX_DET_RENTABILIDAD_RF
						(numero_voucher,correlativo,cuenta,tipo_monto,monto,moneda)
						values
						(@numero_voucher
						,@correlativo_voucher
						,@codigo_cuenta
						,@tipo_movimiento_cuenta
						,@monto
						,@moneda_instrumento)

						set @correlativo_voucher = @correlativo_voucher + 1

						end -- if @codigo_cuenta <> ''
					end -- if @monto<>0.0								
				fetch next from cur_detalle 
				into @codigo_campo,@tipo_movimiento_cuenta,
					@perfil_fijo,@codigo_cuenta,
					@correlativo_perfil,@codigo_campo_variable		
			end -- while @@fetch_status

			close cur_detalle
			deallocate cur_detalle
		end

		-- print 'Grabando el encabezado del voucher auxiliar.'
		insert into Reportes.dbo.CNT_AUX_RENTABILIDAD_RF
		(numero_voucher,
		fecha_ingreso,
		glosa,
		tipo_voucher,
		tipo_operacion,
		tipo_operacion_original,
		operacion,
		correlativo,
		instser,
		documento,
		codigo_producto,
		id_automatico)
		values
		(@numero_voucher
		,@fecha
		,(case 
			when @codigo_instrumento = 'LCHR' and @tipo_cliente = '2' then rtrim(@Glosa_Perfil) + ' ESTADO'    
			when @codigo_instrumento = 'LCHR' and @tipo_cliente = '3' then rtrim(@Glosa_Perfil) + ' VIV.'     
			when @codigo_instrumento = 'LCHR' and @tipo_cliente = '4' then rtrim(@Glosa_Perfil) + ' FG' 
			else rtrim(@Glosa_Perfil) 
			end)
		,@tipo_voucher
		,@tipo_operacion
		,@t_operacion_org
		,@operacion
		,@correlativo
		,@instrumento
		,@documento
		,@codigo_instrumento
		,@id_automatico
		)

		set @numero_voucher = @numero_voucher +1

		fetch next from cur_movimiento
		into @id_sistema,@tipo_movimiento,@tipo_operacion,
		@operacion,@correlativo,@codigo_instrumento,@moneda_instrumento
		,@instrumento,@documento,@tipo_cliente,@fecha_proceso,
		@t_operacion_org,@id_automatico
	end
	close cur_movimiento
	deallocate cur_movimiento

	update CNT_AUX_RENTABILIDAD_RF
	set 
		fpagoentre				= forma_pago_entregamos
		,fpago					= forma_pago
		,plazo					= c.plazo
		,condicion_pacto		= c.condicion_pacto
		,clasificacion_cliente	= c.clasificacion_cliente
	from 
		CNT_AUX_RESUMEN_RF_RENT c
	where 
		fecha_ingreso			= @fecha
	AND c.operacion				= CNT_AUX_RENTABILIDAD_RF.operacion    
	AND c.correlativo			= CNT_AUX_RENTABILIDAD_RF.correlativo     
	AND c.documento				= CNT_AUX_RENTABILIDAD_RF.documento         
	AND c.tipo_operacion		= CNT_AUX_RENTABILIDAD_RF.tipo_operacion    
	AND c.codigo_instrumento	= CNT_AUX_RENTABILIDAD_RF.codigo_producto 
	and	c.id_automatico			= CNT_AUX_RENTABILIDAD_RF.id_automatico   
    
	--close cur_movimiento
	--deallocate cur_movimiento
	
	--close cur_detalle
	--deallocate cur_detalle
	
end
GO
