USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_FECHAS_REFERENCIA_MERCADO_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZA_FECHAS_REFERENCIA_MERCADO_SWAP]
     (  @NumeroOperacion numeric(10)	  
	 )
As
Begin
     /* Pruebas
	     exec SP_ACTUALIZA_FECHAS_REFERENCIA_MERCADO_SWAP 9629 -- 9636
	 */
     declare @i               numeric(10) 
	 declare @Max             numeric(10)
	 declare @FechaReferencia datetime
	 declare @tipo_swap        numeric(5)
	 declare @Tipo_flujo       numeric(10)	
	 declare @Numero_Flujo     numeric(10) 
	 declare @fechaLiquidacion datetime
	 declare @ReferenciaUSDCLP numeric(10)
	 declare @ReferenciaMEXUSD numeric(10)
	 declare @modalidad_pago   varchar(1)
	 declare @DiasValor        numeric(5)
	 declare @Paises           varchar(50)
	 declare @FechaUSDCLPVacia varchar(1)
	 declare @FechaMExUSDVacia varchar(1)
	 

	 set nocount on
	 CREATE TABLE #Fecha( Fecha datetime )

	 select numero_operacion 
	     , tipo_swap
		 , tipo_Flujo
		 , Numero_Flujo
		 , FechaLiquidacion 
		 , ReferenciaUSDCLP 
		 , ReferenciaMEXUSD  
		 , modalidad_pago   
		 , FeriadoLiquiChile
		 , FeriadoliquiEEUU
		 , FeriadoLiquiEnglan
		 , Corr = identity(INT) 
		 into #Cartera
		 from BacSwapSuda.dbo.Cartera 
		 where numero_operacion = @NumeroOperacion -- Una sola o 
		    or @NumeroOperacion = 0                -- todas
    
	 set @Max = 0
	 select @Max = count(1) from #Cartera 	 
	 set @i = 1
	 while @i <= @Max -- Pendiente revisar el "<="
	 begin
	     
		 select @numeroOperacion  = numero_operacion
		     ,  @tipo_swap        = tipo_swap 
		     ,  @Tipo_Flujo       = Tipo_Flujo
			 ,  @Numero_Flujo     = Numero_Flujo
			 ,  @fechaLiquidacion = FechaLiquidacion 
			 ,  @FechaReferencia  = FechaLiquidacion 
			 ,  @ReferenciaUSDCLP = isnull( ReferenciaUSDCLP, 0 )
			 ,  @ReferenciaMExUsd = isnull( ReferenciaMExUsd, 0 )
			 ,  @Modalidad_pago   = Modalidad_pago
			 ,  @Paises           = case when FeriadoLiquiChile = 1 then ';6' else '' end
			                     +  case when FeriadoLiquiChile = 1 then ';255' else '' end
								 +  case when FeriadoLiquiEnglan = 1 then ';510' else '' end
								 +  ';'
             ,  @FechaUSDCLPVacia = isnull(convert(varchar(3), ReferenciaUSDCLP) ,'S')
			 ,  @FechaMExUsdVacia = isnull(convert(varchar(3), ReferenciaMExUsd),'S') 
			 from #Cartera where Corr = @i

			-- select '@ReferenciaUSDCLP' = @ReferenciaUSDCLP , '@FechaUSDCLPVacia' = @FechaUSDCLPVacia
			 if @ReferenciaUSDCLP <> 0  -- Con referencia de mercado
			 Begin
					-- Referencia USDCLP
					set @DiasValor = 0
					set @DiasValor    = 0   
					select @DiasValor = DiasValor  from bacParamSuda.dbo.REFERENCIA_MERCADO_PRODUCTO 
					where id_sistema = 'PCS'
					and  Producto = @TIpo_Swap 
					and  Modalidad = @Modalidad_pago
					and  Referencia = @ReferenciaUSDCLP

					--select  '@fechaLiquidacion', @fechaLiquidacion  , '@DiasValor', @DiasValor  , '@Paises', @Paises , '@Max', @Max

					if @DiasValor <> 0 -- Con Días valor
					Begin
					    
						set @FechaReferencia = @fechaLiquidacion 

					    Exec BacParamSuda.dbo.SP_AGREGA_N_DIAS_HABILES  @FechaReferencia output  , @DiasValor  , @Paises  
					
						update BacswapSuda.dbo.cartera 
							set FechaUSDCLP = @FechaReferencia 
							  , ReferenciaUSDCLP = @ReferenciaUSDCLP
							where Numero_operacion = @numeroOperacion
							  and tipo_flujo   = @Tipo_Flujo
							  and numero_Flujo = @Numero_Flujo 
							  and fechaLiquidacion = @fechaLiquidacion
					End
					else
					begin             -- Sin Dias Valor
					   	update BacswapSuda.dbo.cartera 
							set FechaUSDCLP = fechaliquidacion							
							where Numero_operacion = @numeroOperacion
							  and tipo_flujo   = @Tipo_Flujo
							  and numero_Flujo = @Numero_Flujo					
							  and fechaLiquidacion = @fechaLiquidacion
					end
			  End
			  else
			  Begin 
			  -- Sin referencia de mercado quedaría la
			  -- fecha de liquidacion como fechas
			  -- de referencia de mercado
			  		update BacswapSuda.dbo.cartera 
						set FechaUSDCLP = fechaLiquidacion 						  
						where Numero_operacion = @numeroOperacion
						  and tipo_flujo   = @Tipo_Flujo
						  and numero_Flujo = @Numero_Flujo 
						  and fechaLiquidacion = @fechaLiquidacion

			  End
			  
			  if @ReferenciaMExUsd <> 0 -- Con referencia
			  Begin
                    -- Referencia MXUSD
					set @DiasValor = 0
					set @DiasValor    = 0   
					select @DiasValor = DiasValor from bacParamSuda.dbo.REFERENCIA_MERCADO_PRODUCTO 
					where id_sistema = 'PCS'
					and  Producto = @TIpo_Swap 
					and  Modalidad = @Modalidad_pago
					and  Referencia = @ReferenciaMExUsd

					

					if @DiasValor <> 0  -- Con Dias Valor
					begin

					    set @FechaReferencia = @fechaLiquidacion 

						Exec BacParamSuda.dbo.SP_AGREGA_N_DIAS_HABILES  @FechaReferencia output  , @DiasValor  , @Paises  	 			  

						--select  '@fechaLiquidacion', @fechaLiquidacion  , '@FechaReferencia', @FechaReferencia, '@DiasValor', @DiasValor  , '@Paises', @Paises , '@Max', @Max

						update BacswapSuda.dbo.cartera 
							set FechaMExUsd = @FechaReferencia 
							, ReferenciaMExUSD = @ReferenciaMExUSD
							where Numero_operacion = @numeroOperacion
							  and tipo_flujo   = @Tipo_Flujo
							  and numero_Flujo = @Numero_Flujo					
							  and fechaLiquidacion = @fechaLiquidacion
					end
					else
					begin   -- Sin dias valor
						update BacswapSuda.dbo.cartera 
							set FechaMExUsd = fechaliquidacion							
							where Numero_operacion = @numeroOperacion
							  and tipo_flujo   = @Tipo_Flujo
							  and numero_Flujo = @Numero_Flujo					
							  and fechaLiquidacion = @fechaLiquidacion
               end
               end
			   else			       	
			   Begin  -- Sin referencia
			     update BacswapSuda.dbo.cartera 
							set FechaMExUsd = fechaLiquidacion 
							, ReferenciaMExUSD = 0
							where Numero_operacion = @numeroOperacion
							  and tipo_flujo   = @Tipo_Flujo
							  and numero_Flujo = @Numero_Flujo					
							  and fechaLiquidacion = @fechaLiquidacion

			   end

			   set @i = @i + 1
			   --select '@i', @i
	 end
	 set nocount off
End

/*
select distinct numero_operacion
              , tipo_Flujo
			  , numero_Flujo
			  , fechaliquidacion 
			  , ReferenciaMEXUSD 
			  , ReferenciaUSDCLP 
			  , FechaMEXUSD 
			  , FechaUSDCLP, modalidad_pago, tipo_swap
 from cartera  where numero_operacion between 9620 and  9630
order by numero_operacion, tipo_Flujo, numero_Flujo

select distinct numero_operacion from cartera order by numero_operacion desc

*/

-- select * from bacParamSuda.dbo.REFERENCIA_MERCADO_PRODUCTO where id_sistema = 'PCS' and referencia in (6,5) and producto = 1
GO
