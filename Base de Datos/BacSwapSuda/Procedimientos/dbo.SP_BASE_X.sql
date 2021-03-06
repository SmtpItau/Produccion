USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BASE_X]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BASE_X]( @BaseOrigen FLOAT,  
                            @BaseNueva  FLOAT,
                            @Tasa       FLOAT = 0.0 OUTPUT )
AS
BEGIN
     IF @BaseOrigen <> @BaseNueva
     BEGIN
          --<< Convierte a Base 360
          IF @BaseOrigen <> 360      
             SELECT @Tasa = (@Tasa / (@BaseOrigen*1.)) * 360.

          --<< Convierte a Base Solicitada ( (1+Div(nTasa,100))^(basNueva/360) - 1 ) * (360/basNueva) * 100
          SELECT @Tasa = ( POWER(1. + @Tasa/100., @BaseNueva/ 360.) - 1. ) * (360./ (@BaseNueva*1.)) * 100.
     END

     SELECT 'Base_X' = @Tasa
 
END -- PROCEDURE

GO
