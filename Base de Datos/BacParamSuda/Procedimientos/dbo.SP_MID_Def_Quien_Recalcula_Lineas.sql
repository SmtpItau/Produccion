USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MID_Def_Quien_Recalcula_Lineas]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_MID_Def_Quien_Recalcula_Lineas]
as
begin

	set nocount on

	/*	Se ejecuta antes de realziar el Inicio de Bonex para New York, el cual determina si se debe ejecutar el re calculo de lineas
		desde el inicio de Día en chile o desde el Inicio de Día para Estados Unidos. 

		Si es habil en Chile, el Recalculo de Lineas se realiza desde BacTrader, de lo contrario desde Bonex Nwe York
	*/

	-- Almacenara las fechas de proximo proceso o fecha a aperturar.
	declare @dFechaNy			datetime
	declare @dFechaChile		datetime
	declare @dFechaProChile		datetime
	-- Indicador de generacion de recalculo de lineas
	declare @SwRecalculoNy		int
		set @SwRecalculoNy		= 0		-->	Por defecto ... chile

	-- Si la fecha próximo proceso de chile fuese mayor a la fecha de próxima apertura para new york, se entiende que en chile es feriado.
	-- Y se debe abrir solo new york, por ende el recalculo se ejecutara solo desde el modulo de Inversiones al Exterior Bonex (New York)
	select	@dFechaChile		= chile.Fecha 
		,	@dFechaNy			= nyork.Fecha
		,	@dFechaProChile		= chile.acfecproc
		,	@SwRecalculoNy		= case	when chile.Fecha  = nyork.Fecha then 0	--> 'Lineas Chile'
										when chile.Fecha  > nyork.Fecha then 1	--> 'Lineas New York'
										when chile.Fecha  < nyork.Fecha then 0	--> 'Lineas Chile'
									end
	from	(	select acfecante, acfecproc, acfecprox, Fecha = acfecprox from BacFwdNy.dbo.Mfac	with(nolock))	nyork
		,	(	select acfecante, acfecproc, acfecprox, Fecha = acfecprox from BacFwdSuda.dbo.Mfac	with(nolock))	chile

	if @SwRecalculoNy = 0
		select Sw = @SwRecalculoNy, NewYork = @dFechaNy, Chile = @dFechaChile, Mensaje = 'Genero proceso de Recalculo desde Chile'
	else
		select Sw = @SwRecalculoNy, NewYork = @dFechaNy, Chile = @dFechaChile, Mensaje = 'Genero proceso de Recalculo desde New York'

	
	-- Si el indicador esta en (1), indica que en chile es feriado y debemos validar y copiar los valores de monedas y curvas
	-- La definición indica que debemos copiar los datos en caso que no existan.
	-- Como refetrencia, debemos leer los datos a la ultima fecha aperturada en chile y revisar a la fecha de proxima apertura para new york

	if (@SwRecalculoNy = 1)
	begin

copia_indicadores:
		--		NOTA IMPORTANTE
		--		se excluyen los indicadores que destaco. Estos datos son replicados por protocolo de operaciones para
		--		Sábados Domingos y Festivos, Salvo los Fines de Mes Especial... En este caso, el Departamento de Riesgo envía la información

			/*	mncodmon  mnglosa
				--------- -----------------------------------
				800       INDICE CAMARA PROMEDIO
				801       ICP Real
				802       INDICADOR BANCARIO REFERENCIA
				997       INDICE VALOR PROMEDIO
				998       UNIDAD DE FOMENTO
			*/

		-->		Valor de Moneda
		declare @ivmcodigo		int		-- codigo de la moneda
		declare @fvmvalor		float	-- valor o tipo de cambio
		declare @fSpotCompra	float	-- valor de la punta de compra
		declare @fSpotVenta		float	-- valor de la punta de venta


		--		*******************************************************************		--
		--		********************* V A L O R   M O N E D A *********************		--
		--		*******************************************************************		--


		--		cursor que reccorrera los valores de monedas, a la ultima fecha aperturada en Chile, abajo las condiciones
		declare Cursor_ValoresMonedas scroll cursor for
		select	vmcodigo
			,	vmvalor
		from	BacParamSuda.dbo.Valor_Moneda with(nolock)
		where	vmfecha		= @dFechaProChile					-- fecha de ultima apertura en chile
		and		vmcodigo	not in(	800, 801, 802, 997, 998	)	-- Dejo fuera los valores que son mensuales
		and		vmvalor     <> 0.0								-- Deben tener valor distinto a cero.

		--	Abro el cursor para reccores los valores de monedas a la ultima fecha de proceso en chile.
		open Cursor_ValoresMonedas
		
		--	Preparo el recorrido de la tabla, para preguntar de uno en uno cada registro
		while (1 = 1)
		begin
			--	Asigno los valores desde el cursor a las variables
			fetch next from Cursor_ValoresMonedas    
			into	@ivmcodigo
			,		@fvmvalor

			--	Si no hay mas registros, salgo del cursor
			if (@@fetch_status <> 0)
			begin
				break
			end

			--	Pregunto, Si en la tabla de valores de monedas, esta creado el indicador a la fecha de apertura para New York
			if not exists(	select	1 
							from	BacParamSuda.dbo.Valor_Moneda with(nolock)
							where	vmfecha		= @dFechaNy 
							and		vmcodigo	= @ivmcodigo )
			begin
				-- En caso que el registro no se encuentre, se crea a apartir de los datos recuperados del cursor
				insert into BacParamSuda.dbo.Valor_Moneda 
				(	vmfecha
				,	vmcodigo
				,	vmvalor 
				) 
				values
				(	@dFechaNy
				,	@ivmcodigo
				,	@fvmvalor
				)
			end else
			begin
				--	Pregunto, Si en la tabla de valores de monedas, el indicador tiene valor Cero.
				if (	select	vmvalor 
						from	BacParamSuda.dbo.Valor_Moneda with(nolock)
						where	vmfecha		= @dFechaNy
						and		vmcodigo	= @ivmcodigo ) = 0.0
				begin
					-- si el valor es cero, lo actualizo a valor recuperado
					update	BacParamSuda.dbo.Valor_Moneda
					set		vmvalor		= @fvmvalor
					where	vmfecha		= @dFechaNy
					and		vmcodigo	= @ivmcodigo
				end
			end

		end
		-- cierro el cursor
		close Cursor_ValoresMonedas
		-- descargo el cursor
		deallocate Cursor_ValoresMonedas
		-- Valor de Moneda


		--		*******************************************************************		--
		--		********** V A L O R   M O N E D A ***** C O N T A B L E **********		--
		--		*******************************************************************		--

		-- NOTA : Mismo tratamiento anterior, pero esta vez, será a la tabla de valores de moneda contable.

		--		cursor que reccorrera los valores de monedas, a la ultima fecha aperturada en Chile, abajo las condiciones
		declare Cursor_ValoresMonedasContable scroll cursor for
		select	Codigo_Moneda
			,	Tipo_Cambio
			,	SpotCompra
			,	SpotVenta
		from	BacParamSuda.dbo.Valor_Moneda_Contable with(nolock)
		where	Fecha	= @dFechaProChile

		--	Abro el cursor para reccores la tabla asignada al cursor
		open Cursor_ValoresMonedasContable
		
		while (1 = 1)
		begin
			--	Asigno los valores desde el cursor a las variables
			fetch next from Cursor_ValoresMonedasContable    
			into	@ivmcodigo
			,		@fvmvalor
			,		@fSpotCompra
			,		@fSpotVenta

			--	Si no hay mas registros, salgo del cursor
			if (@@fetch_status <> 0)
			begin
				break
			end

			--	Pregunto, Si en la tabla de valores de monedas contable, esta creado el indicador a la fecha de apertura para New York
			if not exists(	select	1 
							from	BacParamSuda.dbo.Valor_Moneda_Contable with(nolock) 
							where	fecha			= @dFechaNy 
							and		Codigo_Moneda	= @ivmcodigo )
			begin
				-- En caso que el registro no se encuentre, se crea a apartir de los datos recuperados 
				-- desde la tabla valor de moneda contable, pero a fecha de ultimo proceso de chile
				-- y la inserto a la fecha a aperturar (new york)
				insert into BacParamSuda.dbo.Valor_Moneda_Contable
				select	Fecha						= @dFechaNy			-- fecha a aperturar
					,	Codigo_Moneda				= Codigo_Moneda
					,	Nemo_Moneda					= Nemo_Moneda
					,	Codigo_Contable				= Codigo_Contable
					,	Tipo_Cambio					= Tipo_Cambio
					,	Porcentaje_Variacion		= Porcentaje_Variacion 
					,	SpotCompra					= SpotCompra
					,	SpotVenta					= SpotVenta
				from	BacParamSuda.dbo.Valor_Moneda_Contable with(nolock)
				where	Fecha						= @dFechaProChile
				and		Codigo_Moneda				= @ivmcodigo

			end else
			begin
				--	Pregunto, Si en la tabla de valores de monedas contable, el indicador tiene valor Cero.
				if (	select	Tipo_Cambio 
						from	BacParamSuda.dbo.Valor_Moneda_Contable with(nolock)
						where	fecha			= @dFechaNy
						and		Codigo_Moneda	= @ivmcodigo ) = 0.0
				begin 
					-- si el valor es cero, lo actualizo a valor recuperado
					update	BacParamSuda.dbo.Valor_Moneda_Contable
					set		Codigo_Moneda			= @fvmvalor
					,		SpotCompra				= @fSpotCompra
					,		SpotVenta				= @fSpotVenta
					where	Fecha					= @dFechaNy
					and		Codigo_Moneda			= Codigo_Moneda
				end
			end
		end
		-- cierro el cursor
		close Cursor_ValoresMonedasContable
		deallocate Cursor_ValoresMonedasContable
		-- descargo el cursor
		-- Valor de Moneda Contable


		--		*******************************************************************		--
		--		************************** C U R V A S  ***************************		--
		--		*******************************************************************		--

		--		Se valida la existencia de curvas para el cierre a fecha de new york
		if not exists( select 1 from BacParamSuda.dbo.Curvas with(nolock) where FechaGeneracion = @dFechaNy)
		begin
			--	Se copian los datos desde la ultima fecha habil en chile, a la fecha de apetura de New York
			insert into BacParamSuda.dbo.Curvas
			select	FechaGeneracion = @dFechaNy
				,	CodigoCurva
				,	Dias
				,	ValorBid
				,	ValorAsk
				,	Tipo
				,	Origen
			from	BacParamSuda.dbo.Curvas with(nolock)
			where	FechaGeneracion	= @dFechaProChile
		end
		--		Se valida la existencia de curvas para el cierre a fecha de new york
	end
	-->	copia de indicadores

end

GO
