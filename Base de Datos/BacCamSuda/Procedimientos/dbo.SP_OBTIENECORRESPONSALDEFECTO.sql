USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTIENECORRESPONSALDEFECTO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_OBTIENECORRESPONSALDEFECTO]
		  ( @moneda				varchar(10)
		  , @producto			varchar(10)		  
		  , @tipoOperacion		char(1)
		  , @tipoCorresponsal	varchar(10)
		  , @swOplaza			varchar(10)
		  )
as
begin


	select 'Corresponsal'			= case when @swOplaza = 'SW' then
												  case when @tipoOperacion = 'C' then
															case when @tipoCorresponsal = 'Desde'   then compra_desde
																 when @tipoCorresponsal = 'EnDonde' then compra_donde
																 when @tipoCorresponsal = 'AQuien'  then compra_corresponsal
															 end
													   when @tipoOperacion = 'V' then
															case when @tipoCorresponsal = 'Desde'   then venta_desde
																 when @tipoCorresponsal = 'EnDonde' then venta_donde
																 when @tipoCorresponsal = 'AQuien'  then venta_corresponsal
															 end
												  end
										   else 
												  case when @tipoOperacion = 'C' then
															case when @tipoCorresponsal = 'Desde'   then dbo.fn_ObtienePlazaCorresponsal(compra_desde)
																 when @tipoCorresponsal = 'EnDonde' then dbo.fn_ObtienePlazaCorresponsal(compra_donde)
																 when @tipoCorresponsal = 'AQuien'  then dbo.fn_ObtienePlazaCorresponsal(compra_corresponsal)
															 end
													   when @tipoOperacion = 'V' then
															case when @tipoCorresponsal = 'Desde'   then dbo.fn_ObtienePlazaCorresponsal(venta_desde)
																 when @tipoCorresponsal = 'EnDonde' then dbo.fn_ObtienePlazaCorresponsal(venta_donde)
																 when @tipoCorresponsal = 'AQuien'  then dbo.fn_ObtienePlazaCorresponsal(venta_corresponsal)
															 end
												  end
										   end
									   
	
	  from bacParamSuda..ValoresDefecto
	 where moneda   = @moneda
	   and producto = @producto
	
end
GO
