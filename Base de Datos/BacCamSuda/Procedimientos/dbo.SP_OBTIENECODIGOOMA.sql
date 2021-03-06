USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTIENECODIGOOMA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OBTIENECODIGOOMA] (	@mercado		varchar(10),
											@rut			INT,
											@codigo		    INT,
											@tipoOperacion  char(1),
											@Cliente		INT=0
										 )
as
begin

	declare @codigoOMA		int
		  , @tipoCliente	int

	select @tipoCliente = isnull(( select clTipcli from bacParamSuda..Cliente where clRut = @rut and clCodigo = @codigo),0)
	
	
	select @codigoOMA = 1
	
	if @mercado = 'PTAS'
	begin
	
		if @tipoCliente = 1
		begin
			if @rut = 97029000
				select @codigoOMA = 5
			else
				select @codigoOMA = case when @tipoOperacion = 'C' then 2
										 else 7
									     end
									     
		end
		else
			select @codigoOMA = case when @tipoOperacion = 'C' then 1
								     else 6
									 end
	
	end


	if @mercado = 'ARBI'
	begin

		IF NOT EXISTS(	SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
	  					where idProducto	= @mercado
	  					and idPlataforma   = @mercado
	  					AND idCliente		= @Cliente)
		BEGIN
	
			select @codigoOMA = isnull(( select Default_sCodigoOMA
										 from bacParamSuda..CargaOperaciones_DefectoValores 
	  									 where idProducto	= @mercado
	  									 and idPlataforma   = @mercado
	  									 AND idCliente		= 0	
									  ),0)
		END

		ELSE
		BEGIN

			select @codigoOMA = isnull(( select Default_sCodigoOMA
										 from bacParamSuda..CargaOperaciones_DefectoValores 
	  									 where idProducto	= @mercado
	  									 and idPlataforma   = @mercado
	  									 AND idCliente		= @Cliente
									  ),0)
		END
						 
		select @codigoOMA = case when @codigoOMA = 0 then 
														case when @tipoOperacion = 'C' then 27
														     else 12
														     end
															 
								 else @codigoOMA
							     end
	
	
	
	end


	if @mercado = 'EMPR'
	begin

		IF NOT EXISTS(	SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
	  					where idProducto	= @mercado
	  					and idPlataforma   = @mercado
	  					AND idCliente		= @Cliente)
		BEGIN	
			select @codigoOMA = isnull(( SELECT Default_sCodigoOMA
										 from bacParamSuda..CargaOperaciones_DefectoValores 
	  									 where idProducto	= @mercado
	  									 and idPlataforma   = @mercado
	  									 AND idCliente		= 0
									  ),0)
		END

		ELSE
		BEGIN
			select @codigoOMA = isnull(( SELECT Default_sCodigoOMA
										 from bacParamSuda..CargaOperaciones_DefectoValores 
	  									 where idProducto	= @mercado
	  									 and idPlataforma   = @mercado
	  									 AND idCliente		= @Cliente
									  ),0)
		END

		select @codigoOMA = case when @codigoOMA = 0 then 
														case when @tipoOperacion = 'C' then 27
														     else 12
														     end
															 
								 else @codigoOMA
							     end
	
	
	
	end


	IF @mercado in('OVER','WEEK')
	BEGIN
		IF NOT EXISTS(	SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
	  					where idProducto	= @mercado
	  					and idPlataforma   = @mercado
	  					AND idCliente		= @Cliente)
		BEGIN
			select @codigoOMA = isnull(( SELECT Default_sCodigoOMA
										 from bacParamSuda..CargaOperaciones_DefectoValores 
	  									 where idProducto	= @mercado
	  									 and idPlataforma   = 'PTAS'
	  									 AND idCliente		= 0
									  ),0)
	
		END

		ELSE
		BEGIN
			select @codigoOMA = isnull(( SELECT Default_sCodigoOMA
										 from bacParamSuda..CargaOperaciones_DefectoValores 
	  									 where idProducto	= @mercado
	  									 and idPlataforma   = 'PTAS'
	  									 AND idCliente		= @Cliente
									  ),0)
		END
	END

	select @codigoOMA

end 
 
 
 
 
 
GO
