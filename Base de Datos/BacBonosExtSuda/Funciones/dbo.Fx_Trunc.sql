USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Trunc]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_Trunc](
     @Valor     numeric(20,16)  
   , @Decimales integer	 	    
)
RETURNS numeric(30,20)             --- Valor SELIC acumulado
-- WITH SCHEMABINDING
AS

BEGIN  
   return Floor(  @Valor * power( 10.0, @Decimales ) )  / power( 10.0, @Decimales ) 
END
/* 

  select dbo.Fx_trunc(4.567567 , 3 ), round(4.567567, 3)
 */

 /*
 -- Ejecucion directa
  declare @Valor float  = 4672.285674
  declare @Cadena varchar(100)
  declare @CadenaDecimales varchar(100)
  declare @decimales integer = 6
   select @Cadena = convert( varchar(100), convert(numeric(20,15), @Valor ) )

   if charindex( '.', @cadena ) <> 0 begin
       select @CadenaDecimales = SUBSTRING( @Cadena, charindex( '.', @Cadena ) + 1, len(@cadena) )
   end
   select @cadena, @CadenaDecimales
   
   select Floor(  @Valor * power( 10.0, @Decimales ) )  / power( 10.0, @Decimales ) 
   */
GO
