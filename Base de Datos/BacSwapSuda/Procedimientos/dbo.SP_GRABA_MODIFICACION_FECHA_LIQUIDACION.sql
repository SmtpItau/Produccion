USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_MODIFICACION_FECHA_LIQUIDACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_MODIFICACION_FECHA_LIQUIDACION] (@C_FECHA_LIQUIDACION	DATETIME
															 ,@C_NUMERO_OPERACION	NUMERIC(7,0)
															 ,@C_NUMERO_FLUJO		NUMERIC(3,0)
															 ,@C_RUT_CLIENTE		NUMERIC(9,0)
															 ,@C_TIPO_FLUJO		NUMERIC(1,0))
 AS
 BEGIN
 	-- fecha liquidacion antigua del flujo	
	declare @fechaLiquidacionAntigua datetime 	
	declare @PataFrenteSeCorrige varchar(1)
	
	set nocount on 
	select  @fechaLiquidacionAntigua = fechaLiquidacion from cartera 
	where numero_operacion	= @C_NUMERO_OPERACION
	  AND numero_flujo		= @C_NUMERO_FLUJO	  
	  AND tipo_flujo		= @C_TIPO_FLUJO

   
   Set     @PataFrenteSeCorrige = 'N'
   select  @PataFrenteSeCorrige = 'S'
      from cartera 
	where numero_operacion	= @C_NUMERO_OPERACION
	  and tipo_flujo   = case when @C_TIPO_FLUJO = 1 then 2 else 1 end
	  and fechaliquidacion = @fechaLiquidacionAntigua

   -- Se corrige el flujo indicado en parametros
	UPDATE Cartera
	SET FechaLiquidacion = @C_FECHA_LIQUIDACION
	WHERE numero_operacion	= @C_NUMERO_OPERACION
	  AND numero_flujo		= @C_NUMERO_FLUJO	  
	  AND tipo_flujo		= @C_TIPO_FLUJO       
	                               
    if 	@PataFrenteSeCorrige = 'S'
	Begin
	    -- Corrige la pata del frente si tiene la
		-- misma fecha original
		UPDATE Cartera
		SET FechaLiquidacion = @C_FECHA_LIQUIDACION
		WHERE numero_operacion	= @C_NUMERO_OPERACION
		  and FechaLiquidacion = @fechaLiquidacionAntigua
		  and  tipo_flujo   = case when @C_TIPO_FLUJO = 1 then 2 else 1 end
	end  
	set nocount off
 END

GO
