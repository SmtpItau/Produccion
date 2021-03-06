USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AGREGA_N_DIAS_HABILES]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_AGREGA_N_DIAS_HABILES]( @fecha datetime output  , @CntDias numeric(10) , @CadenaPaises varchar(30), @salida varchar(1) = 'S' )
As 
Begin
    set nocount on 
    declare @fechaAux datetime
	declare @i        numeric(10)
	declare @MaxIteracion numeric(10)
	select  @fechaAux = @fecha
	

	set @i = 0

	
	set @MaxIteracion = case when @CntDias < 0 then -@CntDias else @CntDias end 
	while @i < @MaxIteracion           
    begin
		-- 1) Se retrocede 1 dia corrido
		set @fecha = DATEADD( d, case when @CntDias < 0 then -1 else 1 end , @fecha )
		-- 2) Se revisa si la @fecha es
		--    hábil.

		--exec SP_MUESTRAFECHAVALIDA @fecha, @CadenaPaises
		set @fechaAux = bacparamsuda.dbo.fx_regla_feriados_internacionales( @fecha, @CadenaPaises )

		if @fechaAux = @fecha 
			-- Se encontró una 
			-- fecha hábil y se cuenta
			set @i = @i + 1			
	end	
	if @salida='v'  select @fecha 
	
	set nocount off
End	
/* Pruebas
    exec SP_AGREGA_N_DIAS_HABILES '20150402', -2, ';6;' , 'v'
	exec SP_AGREGA_N_DIAS_HABILES '20150402', 2, ';6;' , 'v'
	exec SP_AGREGA_N_DIAS_HABILES '20150402', 0, ';6;' , 'v'
	exec SP_AGREGA_N_DIAS_HABILES '20150403', -2, ';6;' , 'v'
	exec SP_AGREGA_N_DIAS_HABILES '20150403', 2, ';6;' , 'v'
	exec SP_AGREGA_N_DIAS_HABILES '20141020', -1, ';6;255;' , 'v'
*/
/* Permiso para poder ejecutar la planilla */
GO
