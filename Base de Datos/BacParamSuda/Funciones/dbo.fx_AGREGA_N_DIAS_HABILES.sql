USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_AGREGA_N_DIAS_HABILES]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fx_AGREGA_N_DIAS_HABILES]
	(	@fecha datetime  
	  , @CntDias numeric(10) 
	  , @CadenaPaises varchar(30)
	)	returns			datetime
as
Begin
    -- Prueba interna
	/*
	   select bacparamsuda.dbo.fx_AGREGA_N_DIAS_HABILES( '20150621' , 1,  ';6;' )
       select bacparamsuda.dbo.fx_AGREGA_N_DIAS_HABILES( '20150621' , -1,  ';6;' )

    */

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
		set @fechaAux = @fecha 
		select @fechaAux = bacparamsuda.dbo.fx_regla_feriados_internacionales( @fecha, @CadenaPaises )
		if @fechaAux = @fecha 
			-- Se encontró una 
			-- fecha hábil y se cuenta
			set @i = @i + 1			
	end	
	return @fecha
End	
/* Pruebas
    exec SP_AGREGA_N_DIAS_HABILES '20150402', -2, ";6;" 
	exec SP_AGREGA_N_DIAS_HABILES '20150402', 2, ";6;" 
	exec SP_AGREGA_N_DIAS_HABILES '20150402', 0, ";6;" 
	exec SP_AGREGA_N_DIAS_HABILES '20150403', -2, ";6;" 
	exec SP_AGREGA_N_DIAS_HABILES '20150403', 2, ";6;" 
	exec SP_AGREGA_N_DIAS_HABILES '20141020', -1, ";6;255;" 
*/
GO
