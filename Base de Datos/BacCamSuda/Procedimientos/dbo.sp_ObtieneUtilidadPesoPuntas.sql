USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtieneUtilidadPesoPuntas]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_ObtieneUtilidadPesoPuntas]
		  ( @tipoOperacion	char(1)
		  , @moneda			char(3)
		  , @montoUsd		numeric (19,4)
		  , @tipoCambio		numeric (19,4)
		  )
as
begin

 declare @acpmeco					numeric(19,4)
	   , @acpmeve					numeric(19,4)
	   , @PrecioMedioCompras		numeric(19,4)
	   , @PrecioMedioVentas			numeric(19,4)
	   , @RentabilidadPorOperacion  numeric(19,4)


	 IF @Moneda = 'USD'    
		BEGIN
		   SELECT @acpmeco = acpmeco
				, @acpmeve = acpmeve
				, @PrecioMedioCompras = acpreini
				, @PrecioMedioVentas = acprecie
			 FROM MEAC
		END
	 ELSE
		BEGIN
		   SELECT @acpmeco = vmpmeco
				, @acpmeve = vmpmeve
				, @PrecioMedioCompras = vmpreini
				, @PrecioMedioVentas = vmprecierre
			 FROM VIEW_POSICION_SPT
				, MEAC
			WHERE CONVERT(CHAR(8),acfecpro,112) = CONVERT(CHAR(8),vmfecha,112) 
			  AND vmcodigo  = @Moneda 
				  
		END

	
	 if @tipoOperacion = 'C'
	 begin
	 
		if @acpmeve = 0 and @acpmeco = 0
			select @RentabilidadPorOperacion = (@montoUsd * (@PrecioMedioCompras - @tipoCambio))
		else
			if @acpmeve = 0 and @acpmeco <> 0
				select @RentabilidadPorOperacion = (@montoUsd * (@acpmeco - @tipoCambio))
			else 
				select @RentabilidadPorOperacion = (@montoUsd * (@acpmeve - @tipoCambio))
	 
	 end
	 else
	 begin
	 
		if @acpmeve = 0 and @acpmeco = 0
			select @RentabilidadPorOperacion = (@montoUsd * (@tipoCambio - @PrecioMedioVentas))
		else
			if @acpmeve <> 0 and @acpmeco = 0
				select @RentabilidadPorOperacion = (@montoUsd * (@tipoCambio - @acpmeve))
			else 
				select @RentabilidadPorOperacion = (@montoUsd * (@tipoCambio - @acpmeco))
	 
	 end	


	select round(@RentabilidadPorOperacion,0)

end
GO
