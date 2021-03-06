USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFORMA_TASA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRANSFORMA_TASA]
   (   @nValorTasa         FLOAT
   ,   @iTipoInteres       INTEGER   --> [1 = Simple]; [2 = Compuesto]
   ,   @dFechaInicial      DATETIME
   ,   @dFechaFinal        DATETIME
   ,   @iCodigoBase        NUMERIC(5)
   ,   @TasaTransformada   FLOAT      OUTPUT
   )
AS
BEGIN

   /* 
      Procedimiento Solicitado en Req. Mejoras en Riesgos Financieros
      Fecha      :  Miercoles 30 Enero 2008. 
      Item N° 05 :  Transformación de Curvas según factor de Capitalización.
      Programador:  Adrián González
      Solicitado :  María Paz Navarro
   */

   SET NOCOUNT ON

   CREATE TABLE #TMP_PLAZO
   (   iPlazo   INTEGER   NOT NULL DEFAULT(0) )

      SET @TasaTransformada    = @nValorTasa

   IF @dFechaInicial = @dFechaFinal
   BEGIN
      RETURN
   END

   -->     DETERMINA BISIESTOS   <--
   DECLARE @dFechaBisDesde    DATETIME
   DECLARE @dFechaBisHasta    DATETIME

   --> Determina Las fecha para Calcular Año bisiesto con respecto a la Fecha Inicial
       SET @dFechaBisDesde    = RTRIM(YEAR(@dFechaInicial)) + '0101'
       SET @dFechaBisHasta    = DATEADD(YEAR, 1, @dFechaBisDesde)
   DECLARE @bBisiestoInicial  INTEGER
       SET @bBisiestoInicial  = CASE WHEN DATEDIFF(DAY, @dFechaBisDesde, @dFechaBisHasta) = 366 THEN 1 ELSE 0 END --> [1= Bisiesto]; [0= No Bisiesto]

   --> Determina Las fecha para Calcular Año bisiesto con respecto a la Fecha Final
       SET @dFechaBisDesde    = RTRIM(YEAR(@dFechaFinal)) + '0101'
       SET @dFechaBisHasta    = DATEADD(YEAR, 1, @dFechaBisDesde)
   DECLARE @bBisiestoFinal    INTEGER
       SET @bBisiestoFinal    = CASE WHEN DATEDIFF(DAY, @dFechaBisDesde, @dFechaBisHasta) = 366 THEN 1 ELSE 0 END --> [1= Bisiesto]; [0= No Bisiesto]
   -->     DETERMINA BISIESTOS   <--

   -->     Dias entre FechaInicial y FechaFinal, Calculados por Resta Simple
   DECLARE @iPlazoCurva         INTEGER
       SET @iPlazoCurva         = DATEDIFF(DAY,@dFechaInicial, @dFechaFinal)

   -->     Dias segun base de Calculo del contrato entre FechaInicial y FechaFinal
   DECLARE @iPlazoBaseCalculo   INTEGER
      IF @iCodigoBase IN(1, 2, 3)
      BEGIN
         --> Para las Bases : 1=[ACT/ACT]; 2=[ACT/360]; 3=[ACT/365]. Resta Simple de Fechas
         SET @iPlazoBaseCalculo    = ISNULL(DATEDIFF(DAY,@dFechaInicial, @dFechaFinal),1.0)
      END ELSE
      BEGIN
         --> Para las Bases : 4=[30/360]; 5=[30/365]. Utiliza DifDias30
         INSERT INTO #TMP_PLAZO    EXECUTE SP_DIFDIAS30 @dFechaInicial, @dFechaFinal
         SET @iPlazoBaseCalculo    = (SELECT ISNULL(iPlazo, 1.0) FROM #TMP_PLAZO)
      END

   DECLARE @iBaseTasaOp         INTEGER
      IF @iCodigoBase = 1
      BEGIN
         --> Si Año FechaInicio es Bisiesto Y Año FechaFinal as bisiesto
         SET @iBaseTasaOp   = CASE WHEN @bBisiestoInicial = 1 AND @bBisiestoFinal = 1 THEN 366 ELSE 365 END
      END
      IF @iCodigoBase IN(2, 3, 4, 5)
      BEGIN
         SET @iBaseTasaOp   = (SELECT base FROM BacSwapSuda..BASE WHERE codigo = @iCodigoBase)
      END

   --> TipoInteres SI (@iTipoInteres = 1, 'SIMPLE', 'COMPUESTO')
   IF @iTipoInteres = 1
   BEGIN
      SET @TasaTransformada = (@nValorTasa * @iPlazoCurva * @iBaseTasaOp / 360.0 / @iPlazoBaseCalculo)
   END ELSE
   BEGIN
      SET @TasaTransformada = (POWER( (@nValorTasa / 100.0 + 1.0) 
                                    , (@iPlazoCurva * @iBaseTasaOp / 360.0 / @iPlazoBaseCalculo) ) - 1) * 100.0  --> No es Dividido ( / 100.0 )
   END

   DROP TABLE #TMP_PLAZO

END
GO
