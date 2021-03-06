USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICA_MEDIOSPAGO_UNWIND]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_MODIFICA_MEDIOSPAGO_UNWIND]



   (   @nContrato            NUMERIC(10)

   ,   @IdMedioPago			 NUMERIC(3)



   )



AS



BEGIN



   SET NOCOUNT ON



   DECLARE @dFechaHoy         DATETIME,

			@Validacion		  bit



       SET @dFechaHoy   = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))

	  

	   set @Validacion	=  BacParamSuda.dbo.FX_Valida_Pago_SADP(@nContrato, 1, 5, @dFechaHoy)



	  if(@Validacion = 0)

	  begin



	   BEGIN TRANSACTION



		   --Flujo activo

		   UPDATE BacSwapSuda..CARTERA_UNWIND

			  SET recibimos_documento = @IdMedioPago

			WHERE numero_operacion	  = @nContrato

			  AND tipo_flujo = 1





		   -- Flujo Pasivo

		   UPDATE BacSwapSuda..CARTERA_UNWIND

			  SET pagamos_documento = @IdMedioPago

			WHERE numero_operacion  = @nContrato

			  AND tipo_flujo = 2	   

		  

		

		   IF @@error <> 0 

		   BEGIN

			  ROLLBACK TRANSACTION

			  SELECT -1, 'Error: al Actualizar Forma de Pago.'      

			  SET NOCOUNT OFF

			  RETURN

		   END

   

	   COMMIT TRANSACTION

	   SET NOCOUNT OFF

	   

	   END --Fin de condicion

	   else

	   begin

		select -2, 'No se puede modificar el anticipo, ya fue pagado.'

	   end



END
GO
