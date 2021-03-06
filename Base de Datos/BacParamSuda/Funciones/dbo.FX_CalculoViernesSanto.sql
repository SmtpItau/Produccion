USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FX_CalculoViernesSanto]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Function [dbo].[FX_CalculoViernesSanto] 
(
     @Ano numeric(4)          --  ejemplo 2015, 2014   
)
Returns datetime  
As 
Begin
    /* algoritmo de Butcher
	   Ejemplos de uso
       select  dbo.FX_CalculoViernesSanto( 2007 )
	   select  dbo.FX_CalculoViernesSanto( 2015 )	   
	   select  dbo.FX_CalculoViernesSanto( 2016 )
	   select  dbo.FX_CalculoViernesSanto( 2017 )
	   select  dbo.FX_CalculoViernesSanto( 2018 )
	   select  dbo.FX_CalculoViernesSanto( 2019 )
	   select  dbo.FX_CalculoViernesSanto( 2028 )
	   select  dbo.FX_CalculoViernesSanto( 2029 )
	*/

	declare @A integer
	declare @B integer
	declare @C integer
	declare @D integer
	declare @E integer
	declare @F integer
	declare @G integer
	declare @H integer
	declare @I integer
	declare @J integer
	declare @K integer
	declare @L integer
	declare @M integer
	declare @N integer
	declare @O integer
	declare @P integer
	declare @Mes integer
	declare @DiaResureccion integer
	declare @fechaAux datetime
	
	
		select  @A = @Ano % 19  -- Resto de la división entera @Ano / 19		
		select  @B = @Ano / 100 -- Division entera
		select  @C = @Ano % 100 -- Resto de la división entera @Ano / 100
		select  @D = @B / 4      
		select  @E = @B % 4     
		-- select  @F = ( @B + 8 ) / 5 -- Copie mal la fórmula de wikipedia
		select  @F = ( @B + 8 ) / 25
		select  @G = ( @B - @F + 1 ) /3
		select  @H = ( 19* @A + @B - @D - @G + 15 ) % 30
		select  @I = @C / 4
		select  @K = @C % 4 
		select  @L = (32 + 2*@E + 2*@I - @H - @K) % 7
		select  @M =  (@A + 11*@H + 22*@L) / 451
		select  @N = @H + @L - 7*@M + 114
		select  @Mes = @N / 31
		select @DiaResureccion = 1 + @N % 31 

		/* Lo unico que se me ocurrió para el control 
		   de error fue checar que siempre salga 
		   un valor de fecha */

		if @Mes not in ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12) 
			select @Mes = 01
		if @Mes = 1 and @DiaResureccion > 31  
			select @DiaResureccion = 01
		if @Mes = 2 and @DiaResureccion > 29 -- no cubierto caso no biciesto  
			select @DiaResureccion = 01
		if @Mes = 3 and @DiaResureccion > 31 
			select @DiaResureccion = 01
		if @Mes = 4 and @DiaResureccion > 30 
			select @DiaResureccion = 01
		if @Mes = 5 and @DiaResureccion > 31 
			select @DiaResureccion = 01
		if @Mes = 6 and @DiaResureccion > 30 
			select @DiaResureccion = 01
		if @Mes = 7 and @DiaResureccion > 31 
			select @DiaResureccion = 01
		if @Mes = 8 and @DiaResureccion > 31 
			select @DiaResureccion = 01
		if @Mes = 9 and @DiaResureccion > 30
			select @DiaResureccion = 01
		if @Mes = 10 and @DiaResureccion > 31 
			select @DiaResureccion = 01
		if @Mes = 11 and @DiaResureccion > 30
			select @DiaResureccion = 01
		if @Mes = 12 and @DiaResureccion > 31 
			select @DiaResureccion = 01

		select @fechaAux = convert( datetime,  convert( varchar(8), @Ano * 10000 + @Mes* 100 + @DiaResureccion  ) ) 
		select @fechaAux = dateAdd(  dd, -2 , @fechaAux )
		return( @fechaAux  )
    
    
End

GO
