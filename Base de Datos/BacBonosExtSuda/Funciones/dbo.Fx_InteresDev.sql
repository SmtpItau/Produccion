USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_InteresDev]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_InteresDev] (
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
RETURNS numeric(20,4)             --- Valor SELIC acumulado
-- WITH SCHEMABINDING
AS
BEGIN
    declare @INDEV numeric(20,2)
	declare @PRINC numeric(20,2)
	select @INDEV = 0
	select @V001 = dbo.Fx_Cta_Dias_Habiles(@FP,@FV, ';220;' )
	if @Tipo_Calculo = 2
	Begin
	   select @PRINC = dbo.Fx_Principal(@Tipo_Calculo, @Cod_Familia, @V001, @TR, @FP, @NOM,@PVP, @MT, @FV) 
       if @Cod_Familia = 2004
		  select @INDEV = round(@PRINC-dbo.Fx_SelicA( @FV )*1000.0000000000 * @Nom,2) 
       if @Cod_Familia = 2005
	      select @INDEV =  round(@PRINC- @NOM*1000.0000000000,2) 
    end
	if @Tipo_Calculo = 1
	Begin
	   if @Cod_Familia = 2004
	     select @INDEV = round(@NOM*(@PVP-dbo.Fx_SelicA( @FV )*1000.0000000000),2)
	   if @Cod_Familia = 2005
	     select @INDEV = round(@NOM*1000.00*(@PVP/1000.0-1.0),2)
	end
	if @Tipo_Calculo = 3
	Begin
	   if @Cod_Familia = 2004
	      select @INDEV = round(@MT-@NOM*dbo.Fx_SelicA( @FV )*1000.0000000000,2)
	   if @Cod_Familia = 2005
	      select @INDEV = @MT-@NOM*1000.00
	End
    return( @INDEV )
END
/*
  select dbo.Fx_Principal( 2, 2005, 0, 14.36, '20160331', 1000, 0, 0, '20160907' )    -- 942107.3200
  select dbo.Fx_InteresDev( 2, 2004, 0, -0.0027, '20160426', 1000, 0, 0, '20160907' ) -- -394527.5100
*/
GO
