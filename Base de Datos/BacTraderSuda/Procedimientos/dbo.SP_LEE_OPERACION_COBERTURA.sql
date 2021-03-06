USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_OPERACION_COBERTURA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_OPERACION_COBERTURA]
   (   @iTag            INTEGER
   ,   @cModulo         CHAR(3)
   ,   @nDerivado       NUMERIC(9)
   ,   @nCorrelativo    NUMERIC(9)
   ,   @nCobertura      NUMERIC(9) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 1 
   BEGIN
      IF @cModulo = 'BFW'
      BEGIN
         SELECT canumoper
         ,      1
         ,      clnombre
         ,      mnnemo
         ,      camtomon1
         ,      cacartera_normativa
         ,      fRes_Obtenido
         FROM   BacFwdSuda..MFCA   WITH (NoLock)
                LEFT JOIN BacParamSuda..CLIENTE ON clrut     = cacodigo AND  clcodigo = cacodcli
                LEFT JOIN BacParamSuda..MONEDA  ON cacodmon1 = mncodmon
         WHERE  canumoper = @nDerivado
      END
      IF @cModulo = 'PCS'
      BEGIN
         SELECT numero_operacion
         ,      1
         ,      clnombre
         ,      mnnemo
         ,      compra_capital
         ,      car_Cartera_Normativa
         ,      Valor_RazonableCLP
         FROM   BacSwapSuda..CARTERA   WITH (NoLock)
                LEFT JOIN BacParamSuda..CLIENTE ON clrut         = rut_cliente AND clcodigo = codigo_cliente
                LEFT JOIN BacParamSuda..MONEDA  ON compra_moneda = mncodmon
         WHERE  numero_operacion = @nDerivado
         AND    numero_flujo     = (SELECT MIN(numero_flujo) FROM BacSwapSuda..CARTERA WITH (NoLock) WHERE numero_operacion = @nDerivado)
         AND    tipo_flujo       = 1
      END
   END

   IF @iTag = 2
   BEGIN
      IF EXISTS( SELECT 1 FROM BacTraderSuda..COBERTURAS WHERE cModulo = @cModulo AND nDerivado = @nDerivado AND nCorrela = @nCorrelativo )
      BEGIN
         SELECT 0
         ,      dFecha
         ,      nCobertura
         ,      nMontoOperacion
         ,      nMontoOcupado 
         ,      nMontoDisponible
         ,      nVRazonableOcup
         ,      nVRazonableDisp
         ,      nVRazonableMonto
         FROM   BacTraderSuda..COBERTURAS
         WHERE  cModulo   = @cModulo 
         AND    nDerivado = @nDerivado 
         AND    nCorrela  = @nCorrelativo
      END ELSE
      BEGIN
         SELECT -1 ,'operación sin Cobertura Previa.' , 0 -- @nCobertura 
      END
   END

   IF @iTag = 3
   BEGIN
      SELECT /*00*/ cSistema
      ,      /*01*/ nDocumento
      ,      /*02*/ nCorrelativo
      ,      /*03*/ cSerie
      ,      /*04*/ mnnemo + SPACE(100) + ltrim(rtrim(iMoneda))
      ,      /*05*/ nMontoOperacion
      ,      /*06*/ nValorMercado
      ,      /*07*/ nMontoCubrir
      ,      /*08*/ nVRazonableCubrir
      ,      /*09*/ nMontoDerivado
      ,      /*10*/ nRazonableDerivado
      ,      /*11*/ pEfectividad
      FROM   BacTraderSuda..DETALLE_COBERTURAS
             LEFT JOIN BacParamSuda..MONEDA ON mncodmon = iMoneda
      WHERE  nCobertura = @nCobertura
   END

END


GO
