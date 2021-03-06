USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_RESPALDO_COBERTURAS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GENERA_RESPALDO_COBERTURAS]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
   SELECT  @dFechaProceso   = acfecproc
   FROM    BacTraderSuda..MDAC

   IF EXISTS(SELECT 1 FROM COBERTURAS_HISTORICO WHERE dFechaProceso = @dFechaProceso)
   BEGIN
      DELETE DETALLE_COBERTURAS_HISTORICO 
      WHERE  dFechaProceso = @dFechaProceso

      DELETE COBERTURAS_HISTORICO
      WHERE  dFechaProceso = @dFechaProceso
   END

   INSERT INTO COBERTURAS_HISTORICO
   SELECT @dFechaProceso 
   ,      dFecha
   ,      nCobertura
   ,      cModulo
   ,      nDerivado
   ,      nCorrela
   ,      nMontoOperacion
   ,      nMontoOcupado
   ,      nMontoDisponible
   ,      nVRazonableOcup
   ,      nVRazonableDisp
   ,      nVRazonableMonto        
   FROM   BacTraderSuda..COBERTURAS

   INSERT INTO DETALLE_COBERTURAS_HISTORICO
   SELECT @dFechaProceso 
   ,      nCobertura
   ,      cSistema
   ,      nDocumento
   ,      nCorrelativo
   ,      cSerie
   ,      iMoneda
   ,      nMontoOperacion
   ,      nValorMercado
   ,      nMontoCubrir
   ,      nVRazonableCubrir
   ,      nMontoDerivado
   ,      nRazonableDerivado
   ,      pEfectividad
   ,      dFechaIngreso
   FROM   DETALLE_COBERTURAS

END



GO
