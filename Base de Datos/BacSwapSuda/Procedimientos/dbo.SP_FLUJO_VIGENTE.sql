USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJO_VIGENTE]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_FLUJO_VIGENTE]
   (   @Numero_Operacion   NUMERIC(5)   )
WITH RECOMPILE
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @PrimerFlujoCompra     NUMERIC(10)
   DECLARE @PrimerFlujoVenta      NUMERIC(10)
   DECLARE @Fecha_Proceso         DATETIME
   DECLARE @Nro_Flu_Vig_Act       NUMERIC(10)
   DECLARE @Nro_Flu_Vig_Pas       NUMERIC(10)


   SET     @PrimerFlujoCompra = 0 
   SET     @PrimerFlujoVenta  = 0
   SELECT  @PrimerFlujoCompra = MIN(numero_Flujo)
           FROM Cartera WHERE numero_operacion =  @Numero_Operacion 
                              and tipo_flujo = 1 and estado <> 'N' 
                              and Compra_Saldo + Compra_Amortiza + Compra_Flujo_Adicional <> 0 -- MAP 20080429 Para que no considere el flujo efectivo

   SELECT  @PrimerFlujoVenta = MIN(numero_Flujo)
           FROM Cartera WHERE numero_operacion =  @Numero_Operacion 
                              and tipo_flujo = 2 and estado <> 'N'   
                              and Venta_Saldo + Venta_Amortiza + Venta_Flujo_Adicional <> 0 -- MAP 20080429 Para que no considere el flujo efectivo

   SELECT  @Fecha_Proceso  = CONVERT(CHAR(8),fechaproc,112)
   FROM    SWAPGENERAL


   UPDATE  CARTERA
   SET 	   estado_flujo     = (CASE WHEN fecha_vence_flujo <= @Fecha_Proceso  -- CER Se agrega signo menor(<),ya que quedaba mas de un flujo vigente
                                        -- and estado <> 'N'   -- MAP Problemas por anticipo
                                         THEN 2 -- Flujo vencimiento natural y anticipo
                                    WHEN (       fecha_inicio_flujo <= @Fecha_Proceso   
                                             and fecha_vence_flujo  >  @Fecha_Proceso                                         
                                         
                                         or  numero_Flujo = @PrimerFlujoCompra  )
                                         and estado <> 'N'
                                         
                                         THEN 1  -- <= Define el Flujo Vigente                                      
                                    ELSE 0
                              END),
	   fecha_valoriza   = @Fecha_Proceso
   WHERE   numero_operacion = @Numero_Operacion 
           and tipo_flujo = 1


   UPDATE  CARTERA
   SET 	   estado_flujo     = (CASE WHEN fecha_vence_flujo <= @Fecha_Proceso -- CER Se agrega signo menor(<),ya que quedaba mas de un flujo vigente
                                        -- and estado <> 'N'   -- MAP Problemas por anticipo
                                        THEN 2 -- Flujo vencimiento natural y anticipo
                                    WHEN (       fecha_inicio_flujo <= @Fecha_Proceso   
                                             and fecha_vence_flujo  >  @Fecha_Proceso                                         
                                         
                                         or  numero_Flujo = @PrimerFlujoVenta  )
                                         and estado <> 'N' 
                                         THEN 1  -- <= Define el Flujo Vigente 
                                    ELSE 0
                              END),
	   fecha_valoriza   = @Fecha_Proceso
   WHERE   numero_operacion = @Numero_Operacion 
           and tipo_flujo = 2


   if exists( select numero_operacion from MOVDIARIO  where numero_operacion = @Numero_Operacion  ) -- (INDEX=PK_MovDiario) --  REQ. 7619
   begin   

      UPDATE  MOVDIARIO
      SET 	   estado_flujo     = (CASE WHEN fecha_vence_flujo <= @Fecha_Proceso 
                                            and estado <> 'N' 
                                            THEN 2 -- Flujo vencimiento natural
                                       WHEN (       fecha_inicio_flujo <= @Fecha_Proceso   
                                                and fecha_vence_flujo  >  @Fecha_Proceso                                                                                  
                                                or  numero_Flujo = @PrimerFlujoCompra  )
                                            and estado <> 'N'
                                            THEN 1  -- <= Define el Flujo Vigente                                      
                                            ELSE 0
                                       END)
     WHERE   numero_operacion = @Numero_Operacion 
             and tipo_flujo = 1


      UPDATE  MOVDIARIO
      SET 	   estado_flujo     = (CASE WHEN fecha_vence_flujo <= @Fecha_Proceso
                                            and estado <> 'N'  
                                            THEN 2 -- Flujo vencimiento natural
                                       WHEN (       fecha_inicio_flujo <= @Fecha_Proceso   
                                                and fecha_vence_flujo  >  @Fecha_Proceso                                         
                                                or  numero_Flujo = @PrimerFlujoVenta  )
                                            and estado <> 'N' 
                                            THEN 1  -- <= Define el Flujo Vigente 
                                            ELSE 0
                                       END)
      WHERE   numero_operacion = @Numero_Operacion 
           and tipo_flujo = 2

   end


SET NOCOUNT OFF

END

GO
