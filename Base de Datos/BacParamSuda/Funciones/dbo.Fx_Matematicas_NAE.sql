USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Matematicas_NAE]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[Fx_Matematicas_NAE]
 ( 
     @X  float			 
 ) 
 Returns float
 As 
 Begin
    -- Funcion que calcula la distribución normal estándar acumulada
    declare @xabs        float
    declare @Exponential float
    declare @Build       float
	declare @NAE         float

    Set @xabs = Abs(@X)
    
    If @xabs > 37 
	begin
        return( 0 )
    end
    Else
	Begin
        select @Exponential = Exp(- power( @xabs , 2 ) / 2)
        If @xabs < 7.07106781186547 
		Begin
            Select @Build = 3.52624965998911E-02 * @xabs + 0.700383064443688
            Select @Build = @Build * @xabs + 6.37396220353165
            Select @Build = @Build * @xabs + 33.912866078383
            Select @Build = @Build * @xabs + 112.079291497871
            Select @Build = @Build * @xabs + 221.213596169931
            Select @Build = @Build * @xabs + 220.206867912376
            Select @NAE = @Exponential * @Build
            Select @Build = 8.83883476483184E-02 * @xabs + 1.75566716318264
            Select @Build = @Build * @xabs + 16.064177579207
            Select @Build = @Build * @xabs + 86.7807322029461
            Select @Build = @Build * @xabs + 296.564248779674
            Select @Build = @Build * @xabs + 637.333633378831
            Select @Build = @Build * @xabs + 793.826512519948
            Select @Build = @Build * @xabs + 440.413735824752
            select @NAE = @NAE / @Build
		End
        Else
		Begin
            select @Build = @xabs + 0.65
            select @Build = @xabs  + 4 / @Build
            select @Build = @xabs  + 3 / @Build
            select @Build = @xabs  + 2 / @Build
            select @Build = @xabs  + 1 / @Build
            select @NAE = @Exponential / @Build / 2.506628274631
        End
    End
    
    select @Nae = case when @X > 0 Then 1 - @NAE else @NAE end
	return @NAE
End 
-- select dbo.Fx_Matematicas_NAE( 2.33 )
GO
