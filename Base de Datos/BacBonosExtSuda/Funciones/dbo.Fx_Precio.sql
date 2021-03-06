USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Precio]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_Precio] (
    @Tipo_Calculo numeric(1) , -- 1: Precio 2: Pago 3: Mto a Pagar
	@Cod_Familia numeric(10),
    @V001   float,  
    @TR    numeric(20,8),
	@FP   datetime,
	@NOM  numeric(20,2),
	@MT   numeric(20,2),
	@FV   datetime	    
)
RETURNS numeric(20,6)             --- 
-- WITH SCHEMABINDING
AS
BEGIN
    declare @PVP numeric(20,16)
	select @V001 = dbo.Fx_Cta_Dias_Habiles(@FP,@FV, ';220;' )
    if @Tipo_Calculo = 2 
	Begin
	  if @cod_familia = 2004
	  -- select dbo.fx_trunc( dbo.Fx_SelicA( '20000701', '20110511' ) * 1000.0 * dbo.Fx_DPrc(658,-0.0003)/100.000, 6 )
        select @PVP = dbo.fx_trunc( dbo.Fx_SelicA(  @FP ) *1000.0, 6 )  -- Redondeo al sexto decimal
		            * dbo.Fx_DPrc(@V001,@TR)                                       -- Truncado al cuarto decimal
					/ 100.000                         
	  if @cod_familia = 2005
	    select @PVP = 1000.0/power(@TR/100.0 + 1.0, @V001/252.0000000000)
    end
	if @Tipo_Calculo = 3
	Begin
	   if @Cod_Familia = 2004
	     select @PVP = @MT/@NOM
	   if @Cod_Familia = 2005
	     select @PVP = @MT/@NOM
	End
    return( dbo.Fx_trunc( @PVP, 6 ) )  -- Precio se trunca al 6to decimal
END
/*
select dbo.Fx_precio( 2, 2004, 0, -0.06, '20120711', 10000, 0, '20170307' )  -- 5282.357691
select dbo.Fx_precio( 2, 2005, 0, 12.6524, '20110512', 1000, 0, '20130701' ) -- 776.155764
*/
GO
