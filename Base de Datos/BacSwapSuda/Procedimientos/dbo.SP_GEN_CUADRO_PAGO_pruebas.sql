USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GEN_CUADRO_PAGO_pruebas]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GEN_CUADRO_PAGO_pruebas]
   (   @iPeriodoInteres       INTEGER
   ,   @iPeriodoCapilal       INTEGER
   ,   @dFechaEfectiva        DATETIME
   ,   @dFechaPrimerPago      DATETIME
   ,   @dFechaPenultimoPago   DATETIME
   ,   @dFechaMadurez         DATETIME
   ,   @iGeneracionNormal     INTEGER
   ,   @nMontoNocional        NUMERIC(21,4)
   ,   @iRedondeo             INTEGER
   )
AS
BEGIN

   SET NOCOUNT ON

   --> Tabla para Almacenar los Flujos
   CREATE TABLE #Detalle_Flujos
   (   nNumeroFlujo         INTEGER
   ,   dFechaVcto           DATETIME
   ,   dFechaAmortiza       CHAR(10)
   ,   nMontoAmortizacion   NUMERIC(21,4)
   )

   CREATE INDEX #ixcn_Detalle_Flujos ON #Detalle_Flujos (nNumeroFlujo)
   CREATE INDEX #ixcd_Detalle_Flujos ON #Detalle_Flujos (dFechaVcto)

   --> 00.- Correlativo MultiProposito
   DECLARE @nCorrelativo     INTEGER
   SET     @nCorrelativo     = 1

   --> 01.- Determina Periodo Minimo de Corte Entre Flujos y Flujo
   DECLARE @nPeriodoMinimo   INTEGER
   SET     @nPeriodoMinimo   = 0
   SET     @nPeriodoMinimo   = CASE WHEN @iPeriodoCapilal > @iPeriodoInteres THEN @iPeriodoInteres
                                    ELSE CASE WHEN @iPeriodoCapilal > 0 THEN @iPeriodoCapilal ELSE @iPeriodoInteres END
                               END

   --> 02.- (a) Ajusta las fechas entre las cuales se generar'a el calculo del Calendario.   
   IF @dFechaEfectiva >= @dFechaPrimerPago
      SET @dFechaPrimerPago = DATEADD( MONTH, @nPeriodoMinimo, @dFechaEfectiva)

   --> 02.- (b) Ajusta las fechas entre las cuales se generar'a el calculo del Calendario.   
   IF @iGeneracionNormal = 0 --> @dFechaPenultimoPago  >= @dFechaMadurez
      SET @dFechaPenultimoPago = DATEADD( MONTH, (@nPeriodoMinimo *-1), @dFechaMadurez)

   --> 03.- Determina Fecha de Inicio del Calculo del Calendario
   DECLARE @dFechaInicio     DATETIME
   SET     @dFechaInicio     = CASE WHEN @iGeneracionNormal = 0 THEN @dFechaPrimerPago ELSE @dFechaPenultimoPago END

   --> 04.- Determina la Cantidad de Flujos
   DECLARE @iCantidadFlujos  INTEGER
   SET     @iCantidadFlujos  = DATEDIFF(MONTH,@dFechaPrimerPago,@dFechaPenultimoPago) / @nPeriodoMinimo
   
   IF @iCantidadFlujos < 0
      SET @iCantidadFlujos = 0

   --> 05.- Determina la Fecha PenultimoPago, Cuando se Esta haciendo Calculo Normal hacia adelante
   IF @iGeneracionNormal = 0
      SET @dFechaPenultimoPago = DATEADD(MONTH,(@nPeriodoMinimo * @iCantidadFlujos),@dFechaInicio)

   --> 06.- Determina la Fecha PrimerPago, Cuando se Esta haciendo Calculo hacia Atras
   IF @iGeneracionNormal = 1
      SET @dFechaPrimerPago    = DATEADD(MONTH,(@nPeriodoMinimo * (@iCantidadFlujos*-1)),@dFechaInicio)

   --> 07.- Inicializacion del Contador de Flujos
   DECLARE @iContadorFlujo     INTEGER
   SET     @iContadorFlujo     = 0

   --> 08.- Fecha del Calculo
   DECLARE @dFechaCalculo      DATETIME

   --> 09.- Determina Fecha de Inicio de Amortizaciones
   DECLARE @dFechaAmortiza     DATETIME
   SET     @dFechaAmortiza     = DATEADD(MONTH, @iPeriodoCapilal , @dFechaPrimerPago)   

   --> 10.- Determina el Factor para calcular el Monto a Amortizar.
   DECLARE @iFactorDivision    INTEGER
   SET     @iFactorDivision    = CASE WHEN @iPeriodoCapilal > 0 THEN DATEDIFF(MONTH, @dFechaAmortiza, @dFechaMadurez) / @iPeriodoCapilal
                                      ELSE                           0
                                 END + 1.0

   --> 11.- Calculo del Monto de Amortización
   DECLARE @nMontoAmortizacion NUMERIC(21,4)
   SET     @nMontoAmortizacion = ROUND(@nMontoNocional / @iFactorDivision,@iRedondeo)

   --> 12.- Determina el Remanente de acuerdo al Cálculo
   DECLARE @nMontoDiferencia   NUMERIC(21,4)
   SET     @nMontoDiferencia   = @nMontoNocional - (@nMontoAmortizacion * @iFactorDivision)

   --> 13.- Generación de Calendario
   WHILE  ABS(@iCantidadFlujos) >= @iContadorFlujo
   BEGIN

      --> 14.- Calcula Fecha en Base al Calculo Normal
      IF @iGeneracionNormal = 0
         SET @dFechaCalculo = DATEADD(MONTH, (@nPeriodoMinimo * @iContadorFlujo ) , @dFechaInicio)
      ELSE
         SET @dFechaCalculo = DATEADD(MONTH, (@nPeriodoMinimo * (@iCantidadFlujos - @iContadorFlujo) *-1) , @dFechaInicio)

      --> 15.- Inserta Fecha Vcto
      INSERT INTO #Detalle_Flujos ( nNumeroFlujo   , dFechaVcto    , dFechaAmortiza, nMontoAmortizacion )
                           VALUES ( @iContadorFlujo, @dFechaCalculo, ' '           , 0.0)

      --> 16.- Avanza Contador de Flujos         
      SET @iContadorFlujo  = @iContadorFlujo + 1
   END

   IF NOT EXISTS(SELECT 1 FROM #Detalle_Flujos WHERE dFechaVcto = dFechaVcto)
   BEGIN
      --> 17.- Inserta el Flujo que Representa la Madures de la Operación Diferencia existente entre el ultimo flujo y esta ultima fecha ingresada (No Se Calcula)
      INSERT INTO #Detalle_Flujos ( nNumeroFlujo   , dFechaVcto    , dFechaAmortiza, nMontoAmortizacion )
                           VALUES ( @iContadorFlujo, @dFechaMadurez, ''            , 0.0)
   END

   --> 18.- Contador de Amorizaciones
   DECLARE @iContadorAmortiza INTEGER
   SET     @iContadorAmortiza = 1

   --> 19.- Determina Cantidad de Flujos
   SELECT @iCantidadFlujos = MAX(nNumeroFlujo)
   ,      @iContadorFlujo  = CASE WHEN @iPeriodoCapilal >  @iPeriodoInteres THEN @iPeriodoCapilal / @iPeriodoInteres
                                  WHEN @iPeriodoCapilal <= 0                THEN MAX(nNumeroFlujo)
                                  ELSE                                           1
                             END 
   FROM   #Detalle_Flujos

   --> 20.- Proceso de generación de Amortizaciones
   WHILE  @iCantidadFlujos >= @iContadorFlujo
   BEGIN
      UPDATE #Detalle_Flujos 
         SET dFechaAmortiza     = CONVERT(CHAR(10),dFechaVcto,103)
         ,   nMontoAmortizacion = @nMontoAmortizacion
       WHERE nNumeroFlujo       = @iContadorFlujo
      IF @iCantidadFlujos = @iContadorFlujo
      BEGIN
         UPDATE #Detalle_Flujos 
            SET dFechaAmortiza     = CONVERT(CHAR(10),dFechaVcto,103)
            ,   nMontoAmortizacion = @nMontoAmortizacion + @nMontoDiferencia
          WHERE nNumeroFlujo       = @iContadorFlujo
      END

      IF @iPeriodoCapilal > @iPeriodoInteres
         SET @iContadorFlujo = @iContadorFlujo + (@iPeriodoCapilal / @iPeriodoInteres)
      ELSE
         SET @iContadorFlujo = @iContadorFlujo + 1 
   END

   IF @iCantidadFlujos < @iContadorFlujo
   BEGIN
      UPDATE #Detalle_Flujos 
         SET dFechaAmortiza     = CONVERT(CHAR(10),dFechaVcto,103)
         ,   nMontoAmortizacion = @nMontoAmortizacion + @nMontoDiferencia
       WHERE nNumeroFlujo       = @iCantidadFlujos
   END

   /*   
   SELECT Vencimiento    = dFechaVcto
   ,      Amortizacion   = dFechaAmortiza
   ,      Monto          = nMontoAmortizacion
   ,      Flujo          = Identity(INT)      
   INTO   #DETALLE_FINAL
   FROM   #Detalle_Flujos
   ORDER BY dFechaVcto
   */

   SELECT nNumeroFlujo,  dFechaVcto, dFechaAmortiza, nMontoAmortizacion
     FROM #Detalle_Flujos
   ORDER BY dFechaVcto

/*   SELECT Flujo , Vencimiento, Amortizacion, Monto
     FROM #DETALLE_FINAL 
 ORDER BY Vencimiento*/

END
   
GO
