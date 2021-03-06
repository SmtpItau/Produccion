USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Principal]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_Principal] (
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
    declare @PRINC numeric(20,2)
	select @V001 = dbo.Fx_Cta_Dias_Habiles(@FP,@FV, ';220;' )
    if @Tipo_Calculo = 2  
	begin 
	     select @PRINC =  round(@NOM * dbo.Fx_Precio(@Tipo_Calculo, @Cod_Familia, @V001, @TR, @FP, @NOM,@MT,@FV) ,2) 
	end  
    if @Tipo_Calculo = 1
	Begin
	     select @PRINC = round(@NOM * @PVP,2)
	end
    return( @PRINC )
END
/*
   select dbo.Fx_Principal( 2, 2004, 0, -0.0027, '20160426', 1000, 0, 0, '20160907' ) -- 7713695.6300
   select dbo.Fx_Principal( 2, 2005, 0, 14.36, '20160331', 1000, 0, 0, '20160907' )   -- 942107.3200
*/
GO
