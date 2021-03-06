USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_VIGENTE_TIM]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FLUJO_VIGENTE_TIM] 
   (   @Numero_Operacion   NUMERIC(5)   ) WITH RECOMPILE
AS
BEGIN

	SET NOCOUNT ON	;

	DECLARE @PrimerFlujoCompra     NUMERIC(10)
	,	@PrimerFlujoVenta      NUMERIC(10)
	,	@Nro_Flu_Vig_Act       NUMERIC(10)
	,	@Nro_Flu_Vig_Pas       NUMERIC(10)	;

	DECLARE @Fecha_Proceso         DATETIME		;
	
	SET @PrimerFlujoCompra = 0 			;
	SET @PrimerFlujoVenta  = 0			;

	SELECT @PrimerFlujoCompra = MIN(numero_Flujo)
	  FROM tbl_fljticketswap
	 WHERE numero_operacion =  @Numero_Operacion 
	   AND tipo_flujo = 1 
	   AND estado <> 'N' 
	   AND (Compra_Saldo+Compra_Amortiza+Compra_Flujo_Adicional)<> 0 	;

	SELECT @PrimerFlujoVenta = MIN(numero_Flujo)
 	  FROM tbl_fljticketswap
	 WHERE numero_operacion =  @Numero_Operacion 
	   AND tipo_flujo = 2 
	   AND estado <> 'N'   
	   AND (Venta_Saldo+Venta_Amortiza+Venta_Flujo_Adicional<> 0) 		;

	SET @Fecha_Proceso  =  (SELECT CONVERT(CHAR(8),fechaproc,112)	
			 	  FROM swapgeneral )				;



	UPDATE tbl_fljticketswap
	   SET estado_flujo  = (CASE 	WHEN fecha_vence_flujo <= @Fecha_Proceso  	THEN 2
                                    	WHEN (fecha_inicio_flujo <= @Fecha_Proceso   
					 AND fecha_vence_flujo  >  @Fecha_Proceso                                         
                                          OR numero_Flujo = @PrimerFlujoCompra)
                                         AND estado <> 'N'				THEN 1
				ELSE 0 END)	,
		fecha_valoriza = @Fecha_Proceso
	 WHERE numero_operacion = @Numero_Operacion 
           AND tipo_flujo = 1							;

	
	UPDATE tbl_fljticketswap
	   SET estado_flujo = ( CASE 	WHEN fecha_vence_flujo <= @Fecha_Proceso	THEN 2 
					WHEN (fecha_inicio_flujo <= @Fecha_Proceso   
					 AND fecha_vence_flujo  >  @Fecha_Proceso                                         
                                          OR numero_Flujo = @PrimerFlujoVenta)
                                         AND estado <> 'N' 				THEN 1 
				ELSE 0 END)	,
		fecha_valoriza = @Fecha_Proceso
	 WHERE numero_operacion = @Numero_Operacion 
           AND tipo_flujo = 2							;

	SET NOCOUNT OFF	;

END
GO
