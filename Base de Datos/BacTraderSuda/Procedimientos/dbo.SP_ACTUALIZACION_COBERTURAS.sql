USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZACION_COBERTURAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZACION_COBERTURAS]
AS
BEGIN

   SET NOCOUNT    ON
   -- REQ. 7619
   

   DECLARE @dFecaProceso   DATETIME
   SELECT  @dFecaProceso   = acfecproc
   FROM    BacTraderSuda.dbo.MDAC

   -- * ( A Partir del 13/06/2006 Se va a Utilizar la Diferencia de Mercado para los Calculos)


   --> Actualiza los Valores Razonables para Derivados
      --> Actualiza Valor Razonable para el Monto del Derivado de Forward
      UPDATE BacTraderSuda.dbo.COBERTURAS
      SET    nVRazonableMonto = fres_obtenido
      FROM   BacFwdSuda.dbo.MFCA                   WITH (NoLock)
      WHERE  cModulo          = 'BFW'
      AND    nDerivado        = canumoper
      --> Actualiza Valor Razonable para el Monto del Derivado de Forward

      --> Actualiza Valor Razonable para el Monto del Derivado de Swap
      UPDATE BacTraderSuda.dbo.COBERTURAS
      SET    nVRazonableMonto = Valor_RazonableCLP
      FROM   BacSwapSuda.dbo.CARTERA               WITH (NoLock) 
      WHERE  cModulo          = 'PCS'
      AND    nDerivado        = numero_operacion
      --> Actualiza Valor Razonable para el Monto del Derivado de Swap
   --> Actualiza los Valores Razonables para Derivados


   --> Actualiza los Valores de Mercado u/o Valor Razonable para Operaciones
      --> Actualizacion de Valor Mercado Renta Fija Moneda Nacional
      UPDATE BacTraderSuda.dbo.DETALLE_COBERTURAS
      SET    nValorMercado      = ISNULL(diferencia_mercado,0.0) -- ISNULL(valor_mercado,0.0)
      ,      nMontoOperacion    = valor_nominal
      FROM   BacTraderSuda.dbo.VALORIZACION_MERCADO WITH (NoLock)
      WHERE  fecha_valorizacion = @dFecaProceso
      AND    cSistema           = 'BTR' 
      AND    nDocumento         = rmnumdocu
      AND    nCorrelativo       = rmcorrela
      --> Actualizacion de Valor Mercado Renta Fija Moneda Nacional

      --> Actualizacion de Valor Mercado Renta Fija Moneda Extranjera
      UPDATE BacTraderSuda.dbo.DETALLE_COBERTURAS
      SET    nValorMercado      = ISNULL(rsDiferenciaMerc,0.0)  -- ISNULL(rsvalmerc,0.0)
      ,      nMontoOperacion    = rsnominal
      FROM   BacBonosExtSuda.dbo.TEXT_RSU          WITH (NoLock)
      WHERE  rsfecpro           = @dFecaProceso
      AND    cSistema           = 'BEX' 
      AND    nDocumento         = rsnumdocu
      AND    nCorrelativo       = rscorrelativo
      --> Actualizacion de Valor Mercado Renta Fija Moneda Extranjera

      --> Actualizacion de Valor Razonable para Forward
      UPDATE BacTraderSuda.dbo.DETALLE_COBERTURAS
      SET    nValorMercado      = fres_obtenido
      ,      nMontoOperacion    = camtomon1
      FROM   BacFwdSuda.dbo.MFCA                   WITH (NoLock)
      WHERE  cSistema           = 'BFW' 
      AND    nDocumento         = canumoper
      AND    nCorrelativo       = 1
      --> Actualizacion de Valor Razonable para Forward

      --> Actualizacion de Valor Razonable para Swap
      UPDATE BacTraderSuda.dbo.DETALLE_COBERTURAS
      SET    nValorMercado      = Valor_RazonableCLP
      FROM   BacSwapSuda.dbo.CARTERA               WITH (NoLock)
      WHERE  cSistema           = 'PCS' 
      AND    nDocumento         = numero_operacion
      AND    nCorrelativo       = 1
      --> Actualizacion de Valor Razonable para Swap
   --> Actualiza los Valores de Mercado u/o Valor Razonable para Operaciones   


   --> Calculos de Cobertura y Porcentaje de Efectividad
      --> Elimina las Coberturas con Monto de la Operacion Cubierta igual a Cero
      DELETE BacTraderSuda.dbo.DETALLE_COBERTURAS WITH (RowLock)
      WHERE  nMontoOperacion = 0.0
      --> Elimina las Coberturas con Monto de la Operacion Cubierta igual a Cero

      --> Recalcula el Valor Razonable del Derivado a Ocupar
      UPDATE BacTraderSuda.dbo.DETALLE_COBERTURAS WITH (RowLock)
      SET    nRazonableDerivado = CASE WHEN cob.nVRazonableMonto = 0.0 THEN 0.0
                                       ELSE                          ((Det.nMontoDerivado * cob.nVRazonableMonto) / cob.nMontoOperacion)
                                  END
      FROM   BacTraderSuda.dbo.COBERTURAS         cob
      ,      BacTraderSuda.dbo.DETALLE_COBERTURAS Det
      WHERE  cob.nCobertura = Det.nCobertura
      --> Recalcula el Valor Razonable del Derivado a Ocupar

      --> Recalcula el Valor Razonable del Monto a Cubrir
      UPDATE BacTraderSuda.dbo.DETALLE_COBERTURAS WITH (RowLock)
      SET    nVRazonableCubrir  = CASE WHEN nMontoOperacion = 0.0 THEN 0.0 
                                                                  ELSE ((nMontoCubrir * nValorMercado) / nMontoOperacion)
                                       END
      --> Recalcula el Valor Razonable del Monto a Cubrir

      --> Recalcula del porcentaje de Efectividad para el Detalle de cada operación 
      UPDATE BacTraderSuda.dbo.DETALLE_COBERTURAS WITH (RowLock)
      SET    pEfectividad = CASE WHEN nVRazonableCubrir = 0.0 THEN 0.0 
                                 ELSE                              ((nRazonableDerivado / nVRazonableCubrir) *100.0) 
                            END
      --> Recalcula del porcentaje de Efectividad para el Detalle de cada operación 


      --> Suma el ocupado general para cada derivado (Ocupado o Monto Cubridor General)
      SELECT gCobertura  =  nCobertura , gMontoDerivado = SUM(nMontoDerivado)
      INTO   #Ocupado_Derivado
      FROM   BacTraderSuda.dbo.DETALLE_COBERTURAS  WITH (NoLock)
      GROUP BY nCobertura

      UPDATE BacTraderSuda.dbo.COBERTURAS          WITH (RowLock)
      SET    nMontoOcupado = gMontoDerivado
      FROM   #Ocupado_Derivado
      WHERE  nCobertura    = gCobertura
      --> Suma el ocupado general para cada derivado (Ocupado o Monto Cubridor General)

      --> Determina el Monto Disponible para Coberturas
      UPDATE BacTraderSuda.dbo.COBERTURAS          WITH (RowLock)
      SET    nMontoDisponible = ABS(nMontoOperacion - nMontoOcupado)
      --> Determina el Monto Disponible para Coberturas

      --> ReCalculo de Valor Razonable al Ocupado del Derivado
      UPDATE BacTraderSuda.dbo.COBERTURAS          WITH (RowLock)
      SET    nVRazonableOcup  = (nMontoOcupado    * nVRazonableMonto) / nMontoOperacion
      --> ReCalculo de Valor Razonable al Ocupado del Derivado

      --> ReCalculo de Valor Razonable al Disponible del Derivado
      UPDATE BacTraderSuda.dbo.COBERTURAS          WITH (RowLock)
      SET    nVRazonableDisp  = (nMontoDisponible * nVRazonableMonto) / nMontoOperacion
      --> ReCalculo de Valor Razonable al Disponible del Derivado

   -- REQ. 7619
   

END



GO
