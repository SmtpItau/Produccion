USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_COBERTURAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_COBERTURAS] 
   (   @nCobertura   NUMERIC(9)  = 0  
   ,   @cUsuario     VARCHAR(15) = 'ADMINISTRA'
   )
AS
BEGIN
   SET NOCOUNT ON
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED

   DECLARE @FechaProceso   DATETIME  -- CHAR(10)
   ,       @FechaEmision   DATETIME  -- CHAR(10)
   ,       @HoraEmision   CHAR(10)

   SELECT  @FechaProceso   = acfecproc  -- CONVERT(CHAR(10),acfecproc,103)
   ,       @FechaEmision   = GETDATE()  -- CONVERT(CHAR(10),GETDATE(),103)
   ,       @HoraEmision    = CONVERT(CHAR(10),GETDATE(),108)
   FROM    BacTraderSuda..MDAC WITH (NoLock)

   IF EXISTS(SELECT 1 FROM BacTraderSuda..COBERTURAS WITH (ReadPast) WHERE nCobertura = @nCobertura OR @nCobertura = 0.0) 
   BEGIN
      SELECT 'Cob.dFecha'             = Cob.dFecha
      ,      'Cob.nCobertura'         = Cob.nCobertura
      ,      'Cob.cModulo'            = CONVERT(CHAR(3),Cob.cModulo) + ' - ' + SUBSTRING(Sis.nombre_sistema,1,15)
      ,      'Cob.nDerivado'          = Cob.nDerivado
      ,      'Cob.nCorrela'           = Cob.nCorrela
      ,      'Cob.nMontoOperacion'    = Cob.nMontoOperacion
      ,      'Cob.nMontoOcupado'      = Cob.nMontoOcupado
      ,      'Cob.nMontoDisponible'   = Cob.nMontoDisponible
      ,      'Cob.nVRazonableMonto'   = Cob.nVRazonableMonto
      ,      'Cob.nVRazonableOcup'    = Cob.nVRazonableOcup
      ,      'Cob.nVRazonableDisp'    = Cob.nVRazonableDisp
      ,      'DetcSistema'            = CONVERT(CHAR(3),Det.cSistema) -- + ' - ' + SUBSTRING(Mod.nombre_sistema,1,15)
      ,      'DetnDocumento'          = Det.nDocumento
      ,      'DetnCorrelativo'        = Det.nCorrelativo
      ,      'DetcSerie'              = Det.cSerie
      ,      'DetiMoneda'             = Mon.Mnnemo -- Det.iMoneda
      ,      'DetnMontoOperacion'     = Det.nMontoOperacion
      ,      'DetnValorMercado'       = Det.nValorMercado
      ,      'DetnMontoCubrir'        = Det.nMontoCubrir
      ,      'DetnVRazonableCubrir'   = Det.nVRazonableCubrir
      ,      'DetnMontoDerivado'      = Det.nMontoDerivado
      ,      'DetnRazonableDerivado'  = Det.nRazonableDerivado
      ,      'DetpEfectividad'        = Det.pEfectividad
      ,      'DetdFechaIngreso'       = Det.dFechaIngreso
      ,      'FechaProcesoCab'        = @FechaProceso
      ,      'FechaEmisionCab'        = @FechaEmision
      ,      'HoraEmisionCab'         = @HoraEmision
      ,      'Usuario'                = @cUsuario
      FROM   BacTraderSuda..COBERTURAS                   Cob WITH (ReadPast)
             LEFT JOIN BacTraderSuda..DETALLE_COBERTURAS Det ON Cob.nCobertura = Det.nCobertura
             LEFT JOIN BacParamSuda..SISTEMA_CNT         Sis ON Sis.id_sistema = Cob.cModulo
             LEFT JOIN BacParamSuda..SISTEMA_CNT         Mod ON Mod.id_sistema = Det.cSistema
             LEFT JOIN bacParamSuda..MONEDA              Mon ON Det.iMoneda    = Mon.mncodmon
      WHERE  (Cob.nCobertura = @nCobertura OR @nCobertura = 0.0)
   END ELSE
   BEGIN
      SELECT 'Cob.dFecha'             = ''
      ,      'Cob.nCobertura'         = 0
      ,      'Cob.cModulo'            = ''
      ,      'Cob.nDerivado'          = 0
      ,      'Cob.nCorrela'           = 0
      ,      'Cob.nMontoOperacion'    = 0.0
      ,      'Cob.nMontoOcupado'      = 0.0
      ,      'Cob.nMontoDisponible'   = 0.0
      ,      'Cob.nVRazonableMonto'   = 0.0
      ,      'Cob.nVRazonableOcup'    = 0.0
      ,      'Cob.nVRazonableDisp'    = 0.0
      ,      'DetcSistema'            = ''
      ,      'DetnDocumento'          = 0
      ,      'DetnCorrelativo'        = 0
      ,      'DetcSerie'              = ''
      ,      'DetiMoneda'             = ''
      ,      'DetnMontoOperacion'     = 0.0
      ,      'DetnValorMercado'       = 0.0
      ,      'DetnMontoCubrir'        = 0.0
      ,      'DetnVRazonableCubrir'   = 0.0
      ,      'DetnMontoDerivado'      = 0.0
      ,      'DetnRazonableDerivado'  = 0.0
      ,      'DetpEfectividad'        = 0.0
      ,      'DetdFechaIngreso'       = ''
      ,      'FechaProcesoCab'        = @FechaProceso
      ,      'FechaEmisionCab'        = @FechaEmision
      ,      'HoraEmisionCab'         = @HoraEmision
      ,      'Usuario'                = @cUsuario
   END

END




GO
