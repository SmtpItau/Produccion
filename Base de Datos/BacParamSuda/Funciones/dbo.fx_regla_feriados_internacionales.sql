USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_regla_feriados_internacionales]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fx_regla_feriados_internacionales]
	(	@Fecha			datetime
	,	@Codigo			varchar(100)
	)	returns			datetime
as
begin

	/*
	-->		lo utilice para las pruebas
	declare @Fecha			datetime;		set @Fecha			= '20290101'
	declare @Codigo			varchar(100);	set @Codigo			= ';6;225;510;'
	declare @Profundidad	int;			set @Profundidad	= 0
	select dbo.fx_regla_feriados_internacionales( '20160205' , ';220;' )
	*/
	
	DECLARE @Profundidad INT
	SET @Profundidad = 1
	
	set @Fecha					= CONVERT(DATETIME, dbo.FX_EvitaFinDeSemana(@Fecha))
		
	declare	@AnoFecha				varchar(4);		set	@AnoFecha		= year(@Fecha)
	declare @MesFecha				varchar(4);		set	@MesFecha		= month(@Fecha)
	declare @DiaFecha				varchar(4);		set @DiaFecha		= day(@Fecha)

	declare @ReglaAjuste			int
	declare @DIAFERIADO				int
	declare @MESFERIADO				int
	declare @sMesFeriado			varchar(2)
	declare @sDiaFeriado			varchar(2)
	declare @FerNemo				varchar(6)
	declare @Rescata				int
	
	declare @ParmaetroProfundidad	int
	declare @FechaSanto				datetime
	declare @FechaFeriadoConstruida	datetime
	declare	@DiaSemana				int
	declare @FechaGringa			datetime
	
	declare @CntFeriados			int;			set	@CntFeriados	= 0
	declare @nPuntero				int;			set	@nPuntero		= -1
	
	-->		inicio ciclo
	while ( @CntFeriados	>= 0 )
	begin

		set		@CntFeriados			= @CntFeriados +1

		set		@Rescata				=	0
		set		@nPuntero				=	-1

		select	@nPuntero				=	feriados.Identifica
			,	@FerNemo				=	feriados.fer_nemo
			,	@DIAFERIADO				=	feriados.fer_dia_feriado
			,	@MESFERIADO				=	feriados.fer_mes
			,	@sMesFeriado			=	case	when feriados.fer_mes			<= 9 then '0' +	convert(varchar(1),feriados.fer_mes)
													else											convert(varchar(2),feriados.fer_mes)
												end
			,	@sDiaFeriado			=	case	when feriados.fer_dia_feriado	<= 9 then '0' + convert(varchar(1),feriados.fer_dia_feriado)
													else											convert(varchar(2),feriados.fer_dia_feriado)
												end
			,	@ReglaAjuste			=	feriados.fer_cod_regla_ajuste
			,	@Rescata				=	1
		--	,	Identifica				=	feriados.Identifica
		from	(	select	fer_nemo				=	fer.fer_nemo
						,	fer_dia_feriado			=	fer.fer_dia_feriado
						,	fer_mes					=	fer.fer_mes
						,	fer_cod_regla_ajuste	=	fer.fer_cod_regla_ajuste
						,	Identifica				=	row_number() over (order by fer.fer_nemo, fer.fer_dia_feriado, fer.fer_mes, fer.fer_cod_regla_ajuste)
					from	(	select	distinct
										fer_nemo				= ff.fer_nemo
									,	fer_dia_feriado			= ff.fer_dia_feriado
									,	fer_mes					= ff.fer_mes
									,	fer_cod_regla_ajuste	= ff.fer_cod_regla_ajuste
								from	bacparamsuda.dbo.TBL_FestivosFijos  ff
								where	ff.fer_estado  = 'Activo'
								and		charindex( ltrim(rtrim(ff.fer_origen_pais)), @Codigo ) > 0
							)	fer
				)	feriados
		where	feriados.Identifica		= @CntFeriados

		if (@nPuntero = -1)
		begin
			break
		end
		
		if (@Rescata = 1)
		begin

			if (@DIAFERIADO = @DiaFecha and @MESFERIADO = @MesFecha and @ReglaAjuste = 0) -- Feriado Fijo-Fijo
			begin
				set @Fecha				=	dateadd(day, 1, @Fecha)
				set @profundidad		=	@profundidad + 1
				set @fecha				= ( select dbo.fx_regla_feriados_internacionales( @fecha, @Codigo) )

				--	execute SP_MUESTRAFECHAVALIDA	@fecha	output,	@Codigo, @profundidad
			end


		    /*------- INICIO Feriados Agregados a Fiestas patrias -------*/
			if @Codigo like '%;6;%'  and @MesFecha = '9' and @DiaFecha <> 18 and @MESFERIADO = 9 and @DIAFERIADO = 18 
			begin
				set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + '18' )

				/* Mar */
				if (datepart(weekday, @FechaFeriadoConstruida) = 3)
				begin
					set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + '17' )

					if @fecha = @FechaFeriadoConstruida
					begin
						Set @Fecha			= DATEADD(DAY,3,@Fecha)						
						Set @profundidad	= @profundidad + 1
						set @fecha			= ( select dbo.fx_regla_feriados_internacionales( @fecha, @Codigo) )
						--	execute SP_MUESTRAFECHAVALIDA	@fecha	output, @Codigo, @profundidad
					end
				end	 
			end


			if @Codigo like '%;6;%'  and @MesFecha = '9' and @DiaFecha <> 19 and @MESFERIADO = 9 and @DIAFERIADO = 19
			begin
				set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + '19')

				/* Jue */
				if (datepart(weekday, @FechaFeriadoConstruida) = 5)
				begin
					set @FechaFeriadoConstruida = convert(datetime, @AnoFecha + @sMesFeriado + '20')
				
					if @fecha = @FechaFeriadoConstruida
					begin
						set	@Fecha			= DATEADD(DAY,3,@Fecha)
						set @profundidad	= @profundidad + 1
						set @fecha			= ( select dbo.fx_regla_feriados_internacionales( @fecha, @Codigo) )
						--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad
					end
				end
			end
            /*-----------FIN FIESTAS PATRIAS----------------*/


			/*------- INICIO Feriados Agregados a Navidad Inglaterra -------*/
			if @Codigo like '%;510;%'  and @MesFecha = '12' and @DiaFecha <> 25 and @MESFERIADO = 12 and @DIAFERIADO = 25
			begin
				set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + '25' )
				
				/* 7 = sab */ /* 1 = Dom */
				if (datepart(weekday, @FechaFeriadoConstruida) in(7, 1))
				begin
					set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + '27' )
					
					if @fecha = @FechaFeriadoConstruida
					begin
						set @Fecha			= DATEADD(DAY,1,@Fecha) 
						Set @profundidad	= @profundidad + 1
						set @fecha			= ( select dbo.fx_regla_feriados_internacionales( @fecha, @Codigo) )
						--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo,  @profundidad
					end
				end 
			end 
			/*------- FIN    Feriados Agregados a Navidad Inglaterra -------*/  


			/*------- INICIO Feriados Agregados a Boxing Date -------*/
			if @Codigo like '%;510;%'  and @MesFecha = '12' and @DiaFecha <> 26 and @MESFERIADO = 12 and @DIAFERIADO = 26
			Begin
				set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + '26' )
				
				/* 7 = sab */ /* 1 = Dom */
				if (datepart(weekday, @FechaFeriadoConstruida ) in(7, 1))
				begin
					set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + '28' )
					
					if @fecha = @FechaFeriadoConstruida
					begin
						Set @Fecha			= DATEADD(DAY,1,@Fecha) 
						Set @profundidad	= @profundidad + 1
						set @fecha			= ( select dbo.fx_regla_feriados_internacionales( @fecha, @Codigo) )
						--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo,  @profundidad
					end
				end 			   
			end 
			/*------- FIN    Feriados Agregados a Boxing Date -------*/  

            
			/*----------INICIO MARTES, MIERCOLES O JUEVES --------------------------------*/
			IF @ReglaAjuste = 1  -- Si cae Mar, Mie o Jue -> Lun Ant. Si cae Vie -> Lu Pos.
			Begin
				Set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + @sDiaFeriado )
				Set @DiaSemana				= DATEPART( weekday, @FechaFeriadoConstruida )

				if  @DiaSemana in ( 3 /* Mar */, 4 /* Mie */ , 5 /* Jue */ )
					Set @FechaFeriadoConstruida = dbo.FX_Lunes_Anterior( @FechaFeriadoConstruida ) 
					
				if  @DiaSemana in ( 6 /* Vier */  ) 
					Set @FechaFeriadoConstruida = dbo.FX_Lunes_Posterior( @FechaFeriadoConstruida ) 

				if @fecha = @FechaFeriadoConstruida 
				begin
					set @Fecha			= DATEADD(DAY,1,@Fecha)
					set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales(@fecha, @Codigo))
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 
				end
			End
			/*---------FIN MARTES, MIERCOLES O JUEVES -----------------------*/


			/*---------INICIO MARTES O MIERCOLES ---------------------------*/
			IF @ReglaAjuste = 2  -- Si cae Mar -> Vie Ant. Si cae Mie -> Vie sig.
			Begin
				Set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + @sDiaFeriado )
				Set @DiaSemana = DATEPART( weekday, @FechaFeriadoConstruida )

				if  @DiaSemana in ( 3 /* Mar */  )
					Set @FechaFeriadoConstruida = dbo.FX_Viernes_Anterior( @FechaFeriadoConstruida )

				if  @DiaSemana in ( 4 /* Mie */  )
					Set @FechaFeriadoConstruida = dbo.FX_Viernes_Posterior( @FechaFeriadoConstruida )

				if @fecha = @FechaFeriadoConstruida 
				begin
					Set @Fecha			= DATEADD(DAY,1,@Fecha)
					Set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales( @fecha, @Codigo) )
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 
				end
			End
			/*-------FIN MARTES O MIERCOLES -----------*/
			
			
			/*---------INICIO 1L, 2L, 3L...ETC------------------*/
			if  @reglaAjuste = 3 		
			Begin			    
				select @FechaGringa = CONVERT(DATETIME, dbo.FX_FeriadoFijoGringoTraducidoAFecha(@AnoFecha, @FerNemo)) 
				
				IF @Fecha = @FechaGringa
				BEGIN
					set @Fecha			= DATEADD(DAY,1,@Fecha)	
					set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales( @fecha, @Codigo) )
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 					
				END
			END
			/*----------FIN 1L, 2L, 3L...ETC-----------------*/

			/*------INICIO FIN DE SEMANA--------------*/
			IF @ReglaAjuste = 4  -- Si cae Sab -> Vi o Si cae Dom -> Lu
			Begin
				Set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + @sDiaFeriado )
				Set @DiaSemana				= DATEPART( weekday, @FechaFeriadoConstruida )

				if  @DiaSemana in ( 7 /* Sab */  )
					Set @FechaFeriadoConstruida = dbo.FX_Viernes_Anterior( @FechaFeriadoConstruida )

				if  @DiaSemana in ( 1 /* Dom */  ) 
					Set @FechaFeriadoConstruida = dbo.FX_Lunes_Posterior( @FechaFeriadoConstruida )

				if @fecha = @FechaFeriadoConstruida 
				begin
					Set @Fecha			= DATEADD(DAY,1,@Fecha)
					Set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales( @fecha, @Codigo) )
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 
				end
			End
			/*-------FIN FIN DE SEMANA----------------------------*/


			/*---------INICIO SEMANA SANTA ---------------------------------*/
			IF @reglaAjuste = 5   -- Semana Santa sin lunes de Pascua
			Begin
				SELECT @FechaSanto = CONVERT(DATETIME, dbo.FX_CalculoViernesSanto(@AnoFecha)) 
				
				IF @Fecha=@FechaSanto
				BEGIN
					SET @Fecha			= DATEADD(DAY,1,@FechaSanto)	
					Set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales(@fecha, @Codigo))
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 					
				END
			end			
			/*----------FIN SEMANA SANTA------------------------*/

			/*---------Carnaval: INICIO SEMANA SANTA - 45 días  ----------------------------*/
			/* Carnaval siempre cae día Martes, el día anterior también es feriado **********/
			IF @reglaAjuste = 8   
			Begin
				SELECT @FechaSanto = DATEADD( dd, -45, CONVERT(DATETIME, dbo.FX_CalculoViernesSanto(@AnoFecha)) )
				Set @DiaSemana = DATEPART( weekday, @FechaSanto )
				IF @Fecha= dateadd( dd, -1, @FechaSanto )  -- Dia Anterior Carnaval es feriado.
				BEGIN
					SET @Fecha			= DATEADD(DAY,1,@FechaSanto)	
					Set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales(@fecha, @Codigo))
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 					
				END
				ELSE
				BEGIN
				   IF @Fecha = @FechaSanto
				   Begin
					SET @Fecha			= DATEADD(DAY,1,@FechaSanto)	
					Set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales(@fecha, @Codigo))
				   End
				END
			end			
			/*----------FIN SEMANA SANTA------------------------*/

			/*---------Corpus Christi: INICIO SEMANA SANTA + 62 días  ----------------------------*/
			IF @reglaAjuste = 9   
			Begin
				SELECT @FechaSanto = DATEADD( dd, 62, CONVERT(DATETIME, dbo.FX_CalculoViernesSanto(@AnoFecha)) )
				
				IF @Fecha=@FechaSanto
				BEGIN
					SET @Fecha			= DATEADD(DAY,1,@FechaSanto)	
					Set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales(@fecha, @Codigo))
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 					
				END
			end			
			/*----------FIN SEMANA SANTA------------------------*/



			/*---------INICIO SEMANA SANTA ---------------------------------*/
			if @reglaAjuste = 7   -- Semana Santa con sig. Lunes
			begin
				select @FechaSanto = convert(datetime, dbo.FX_CalculoViernesSanto(@AnoFecha)) 
				
				if @Fecha=@FechaSanto
				begin
					set @fecha			= DATEADD(DAY,1,@FechaSanto)	
					set @profundidad	= @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales(@fecha, @Codigo))
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 					
				end else
				begin
					SET @FechaSanto = DATEADD(DAY,3, @FechaSanto ) -- Lunes de Pascua
					
					if @Fecha = @FechaSanto
					begin
						SET @Fecha			= DATEADD(DAY,1,@FechaSanto)	
						Set @profundidad	= @profundidad + 1
						set @fecha			= ( select dbo.fx_regla_feriados_internacionales(@fecha, @Codigo))
						--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 					
					end
				end
			end			
			/*----------FIN SEMANA SANTA------------------------*/

			/*------INICIO FIN DE SEMANA--------------*/
			/* debería ser usada para el 04 de Julio */
			IF @ReglaAjuste = 6  -- Si cae Dom -> Lu
			Begin
				Set @FechaFeriadoConstruida = convert( datetime, @AnoFecha + @sMesFeriado + @sDiaFeriado )
				Set @DiaSemana = DATEPART( weekday, @FechaFeriadoConstruida )

				if  @DiaSemana in ( 1 /* Dom */  ) 
					Set @FechaFeriadoConstruida = DATEADD(DAY,1,@FechaFeriadoConstruida)

				if @fecha = @FechaFeriadoConstruida 
				begin
					Set @Fecha = DATEADD(DAY,1,@Fecha)
					Set @profundidad = @profundidad + 1
					set @fecha			= ( select dbo.fx_regla_feriados_internacionales(@fecha, @Codigo))
					--	execute SP_MUESTRAFECHAVALIDA @fecha output, @Codigo, @profundidad 
				end
			End
			/*-------FIN FIN DE SEMANA----------------------------*/







		end	-->	(@Rescata = 1)
		
	end
	-->		Finalizo ciclo

/*
	if @ParmaetroProfundidad = 0
		return @Fecha
*/

	return @Fecha

end

GO
