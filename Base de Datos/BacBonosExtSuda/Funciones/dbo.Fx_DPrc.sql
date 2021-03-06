USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_DPrc]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_DPrc] (  -- sp_Helptext Fx_DPrc
    @Plazo   numeric(20,16),  
    @Tasa    numeric(20,16)  )
RETURNS numeric(20,16)             --- Valor SELIC acumulado
-- WITH SCHEMABINDING
AS

BEGIN
   /* return round( 100.000* dbo.Fx_Trunc( 1.0/power( dbo.Fx_Trunc( @Tasa/100.0000, 8) + 1.0000 , dbo.Fx_Trunc( @Plazo/252.0000000000000, 14 ))
                                         , 6), 4 ) */
										 
   return dbo.Fx_trunc( 100.000* ( 1.0/power( @Tasa/100.0000  + 1.0000 ,   ( @Plazo* 1.00000000000 )/252.0000000000000  ) ), 4 ) 

  /*   return  dbo.Fx_trunc( 100.000* ( 1.0 / power( @Tasa /100.0000  + 1.0000 ,   ( @Plazo *1.0 ) / 252.0000000000000  ) ) , 12 ) */
       
 /*	   return(  100.000* ( 1.0 / power( @Tasa /100.0000  + 1.0000 ,   ( @Plazo *1.0 ) / 252.0000000000000  ) ) ) */
		                                  
END
/* 

 select dbo.Fx_Selic_Acumulado( '20000701', '20160509' )
 select dbo.Fx_Selic_Acumulado( '20000701', '20160428' )
 select dbo.Fx_Selic_Acumulado( '20000701', '20000704' )

  select dbo.Fx_Selic_Acumulado( '20000701', '20160429' )

  select dbo.Fx_DPrc(658, -0.0003 ) , dbo.Fx_DPrc(94, -0.0026 )

  select dbo.Fx_DPrc(97,-0.0026)

  select dbo.fx_trunc( dbo.Fx_SelicA( '20000701', '20160428' ) * 1000.0, 6 ) 

  select 100.0 / power( -0.002600/100.0000 + 1.0000, ( 96.000 * 1.0 )/252.0000000000000 )
  select  ( 7713.703 / 7713.618495 ) * 100
  select  15427406 / 2.0

    select dbo.Fx_DPrc(366,-0.0001)

	select 100.000* ( 1.0 / power( -0.01 /100.0000  + 1.0000 ,   ( 366 *1.0 ) / 252.0000000000000  ) ) 

	
    select dbo.Fx_DPrc(94,-0.0027)
	select dbo.Fx_DPrc(93,-0.0027)
	select 7721.72470600000000000000 * 100.000* ( 1.0000000000/power( -0.0027/100.0000  + 1.0000 ,   ( 94* 1.00000000000 )/252.0000000000000  ) ) / 100.0
 */


GO
