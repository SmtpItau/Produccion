USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_SelicA]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[Fx_SelicA] (
     @toDate     date    --- End date
)
RETURNS numeric(24,18)             --- Valor SELIC acumulado
-- WITH SCHEMABINDING
AS

BEGIN
    declare @retorno numeric(24,18) = 1.0
	declare @ultimaFecha datetime
	declare @ultimoValor float
	declare @fecAux2 datetime
	declare @fromDate   date = '20000701'   --- Start date
	-- Debe crearse un tasa que se llame SELIC en la tabla de monedas
	-- CÓDIGO 700
    -- esta funcion debe cuadrar hasta el último decimal
	-- con http://www.bcb.gov.br/htms/selic/selicacumul.asp
	 
	if @toDate < '20000701'
	    set @toDate = '20000701'

    select @retorno = 1.00000000000000  -- 14 dec
	select @ultimaFecha = '19000101'
	select @Retorno = convert( numeric(24,18), convert( numeric(24,18) , @retorno ) 
	                                           * round( convert( numeric(20,18), power ( convert( numeric(20,18), 1.0 + vmvalor /100.0000000000000000 ) /* 16 dec*/  
	                                                                           , convert( numeric(17,17), 1.0/252.0000000000000 ) )
															    )
									                    , 8 ) 														        
											)
         , @ultimaFecha = vmfecha
		 , @ultimoValor = vmvalor
	   from BacParamSuda.dbo.VALOR_MONEDA
	   where vmcodigo = 700
	      and vmfecha >= @fromDate
		  and vmfecha < @toDate
		  and vmvalor <> 0
	   order by vmfecha 

       -- Si ultimaFecha no es hábil anterior
	   -- en Brasil se debe seguir calculando. 

       select @fecAux2 = BacParamSuda.dbo.fx_AGREGA_N_DIAS_HABILES(  @toDate, -1, ';220;' )

	   if @fecAux2 > @ultimaFecha
	   Begin
	      select @ultimaFecha = BacParamSuda.dbo.fx_AGREGA_N_DIAS_HABILES( @ultimaFecha, 1, ';220;') 
	      while @ultimaFecha < @toDate
		  Begin
		      select @Retorno = convert( numeric(24,18), convert( numeric(24,18) , @retorno ) 
	                                           * round( convert( numeric(20,18), power ( convert( numeric(20,18), 1.0 + @ultimoValor /100.0000000000000000 ) /* 16 dec*/  
	                                                                           , convert( numeric(17,17), 1.0/252.0000000000000 ) )
															    )
									                    , 8 ) 														        
											)
		      select @ultimaFecha = BacParamSuda.dbo.fx_AGREGA_N_DIAS_HABILES( @ultimaFecha, 1, ';220;')			  
		  End
	   End
       return round( @retorno * 1.00000000000000, 14 )
END
/* select dbo.Fx_SelicA( '20000701', '20160509' )
 select dbo.Fx_SelicA( '20000701', '20160428' )
  select dbo.Fx_SelicA( '20000701', '20160426' )
 select dbo.Fx_SelicA( '20000701', '20000704' )

  select dbo.Fx_SelicA( '20000701', '20160509' )
    select dbo.Fx_SelicA( '20000701', '20160513' )
	select dbo.Fx_SelicA( '20000701', '20080521' )
 */

GO
