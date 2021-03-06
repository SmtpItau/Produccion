USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Tir]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_Tir] (
    @Tipo_Calculo numeric(1) , -- 1: Precio 2: Pago 3: Mto a Pagar
	@Cod_Familia numeric(10),
    @V001   float,  
    @TR    numeric(20,8),
	@FP   datetime,
	@NOM numeric(20,2),
	@PVP numeric(20,6),
	@MT  numeric(20,2),
	@FV   datetime	   
)
RETURNS numeric(20,8)             --- Valor SELIC acumulado
-- WITH SCHEMABINDING
AS
BEGIN
    declare @INDEV numeric(20,2)
	declare @PRINC numeric(20,2)
	select @V001 = dbo.Fx_Cta_Dias_Habiles(@FP,@FV, ';220;' )
	select @INDEV = 0
	if @Tipo_Calculo = 1
	Begin
	   select @PRINC = dbo.Fx_Principal(@Tipo_Calculo, @Cod_Familia, @V001, @TR, @FP, @NOM, @PVP, @MT, @FV) 
       if @Cod_Familia = 2004
		  select @TR =  round((power(dbo.Fx_SelicA( @FP )*1000.0000000000/@PVP,252.0/(@V001*1.000000000000))-1.0)*100.0,8)
       if @Cod_Familia = 2005
	      select @TR =  round((power(1000.0/@PVP, 252.0/(@V001*1.000000000000))-1.0)*100.000,8)
    end
	if @Tipo_Calculo = 3
	begin
	   if @Cod_Familia = 2004
	       select @TR = round((power(dbo.Fx_SelicA(@FP)*1000.0000000000/round(@MT/@NOM,3),252.0/(@V001*1.00000000))-1.0)*100.0,8)
	   if @Cod_Familia = 2005
	       select @TR = round((power(1000.0/round(@MT/@NOM,6),252.0/(@V001*1.000000000000) ) - 1.0)*100.00,8)
	end
    return( round( @TR, 4) )
END
/*
    select dbo.Fx_Tir( 1, 2005, 536, 0, '20110512',  10000, 776.155764, 7761557.64 , '20130701' ) -- 12.65240000
*/
GO
