USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_BALANCE_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_BALANCE_SWAP]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso    DATETIME
   SELECT  @dFechaProceso    = fechaproc 
   FROM    SWAPGENERAL

   DECLARE @iFound      INTEGER
       SET @iFound      = -1

   SELECT  @iFound      = 0
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE
   WHERE   Fecha        = @dFechaProceso
   AND     Tipo_Cambio <> 0

   IF @iFound = -1
   BEGIN
      RAISERROR( '¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. !', 16, 6, 'ERROR.' )
      RETURN
   END


   CREATE TABLE #TMP_CARTERA_SWAP
   (   Numero_Contrato   NUMERIC(9)   )   

   CREATE INDEX #ix_TMP_CARTERA_SWAP ON #TMP_CARTERA_SWAP (Numero_Contrato)
   
   INSERT INTO #TMP_CARTERA_SWAP
      SELECT DISTINCT numero_operacion FROM BacSwapSuda.dbo.CARTERA with(nolock) WHERE fecha_termino > @dFechaProceso



   DECLARE @dFechaFinMes     DATETIME
   EXECUTE BacparamSuda..SP_RETORNA_FECHA_CIERRE_ANTERIOR @dFechaProceso , @dFechaFinMes OUTPUT

   SELECT  vmcodigo , vmvalor INTO #nValMon                      FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha  = @dFechaFinMes
                       INSERT INTO #nValMon SELECT 13  , vmvalor FROM #nValMon                   WHERE vmcodigo = 994
                       INSERT INTO #nValMon SELECT 999 , 1.0
   
   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo      = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor       = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
   WHERE  Fecha         = @dFechaProceso
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)
   
   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --
   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmcodigo
   ,      vmvalor
   FROM   #nValMon 
   WHERE  vmcodigo  IN(994,995,997,998,999)


   DECLARE @FechaGen      DATETIME
   SELECT  @FechaGen      = @dFechaProceso

   SELECT Registros       = CONVERT(NUMERIC(9), 0) --> @iRegistros
   ,      Pais            = 'CL'
   ,      Fecha           = @FechaGen
   ,      Identificacion  = 'BO52'
   ,      Empresa         = '001'
   ,      CProducto       = 'MDIR'
   ,      TProducto       = 'MDIR'
   ,      Interno         = 'MD02'
   ,      CProductoi      = ' '
   ,      TipoProducto    = 'M'
   ,      Operacion       = CONVERT(NUMERIC(9),SUBSTRING(LTRIM(RTRIM(vh.Operacion)),1,LEN(LTRIM(RTRIM(vh.Operacion))) - 3 ))
   ,      FechaContable   = CONVERT(DATETIME,vh.fecha_ingreso,112)
   ,      Cuenta          = CONVERT(CHAR(16),LTRIM(RTRIM(vd.cuenta)) + REPLICATE('0',16 - LEN(LTRIM(RTRIM(vd.cuenta)))))
   ,      Moneda          = CASE WHEN mn.mncodmon IN (999,998,994) THEN '00' ELSE mncodfox END
   ,      Indicador       = CASE WHEN vd.Tipo_Monto = 'D'          THEN 'D'  ELSE 'C'      END
   ,      EvtoContable    = '0'
   ,      SgnoMdaOrig     = '+'
   ,      MontoOriginal   = CASE WHEN mn.mncodmon = 999 THEN ROUND(vd.monto,0) ELSE ROUND(vd.monto,4) END
   ,      SgnoMdaCnv      = '+'
   ,      MontoMonedaMn   = CASE WHEN mn.mncodmon = 999 THEN ROUND(vd.monto,0)
                                 WHEN mn.mncodmon = 998 THEN ROUND(vd.monto,4)
                                 ELSE                        ROUND(vd.monto *  (SELECT vmvalor FROM #VALOR_TC_CONTABLE /*#nValMon*/ WHERE vmcodigo = mn.mncodmon),4)
                            END
   ,      SgnoMdaxxx      = '+'
   ,      Montoxxx        = 0.0
   ,      Sucursal        = 1
   ,      Centro          = ' '
   INTO   #TMP_RETORNO_FINAL
   FROM   BAC_CNT_VOUCHER_BALANCE vh
          INNER JOIN BAC_CNT_DETALLE_VOUCHER_BALANCE vd ON vh.numero_voucher = vd.numero_voucher
          INNER JOIN BacParamSuda..PLAN_DE_CUENTA    pc ON vd.cuenta         = pc.cuenta
          INNER JOIN BacParamSuda..MONEDA            mn ON mn.mncodmon       = vd.moneda
   WHERE  vh.fecha_ingreso = @dFechaProceso
   AND    pc.tipo_cuenta   IN('ACT','PAS')
   AND    vd.Tipo_Monto    = CASE WHEN pc.tipo_cuenta = 'ACT' THEN 'D' ELSE 'H' END
   ORDER BY CONVERT(NUMERIC(9),vh.Operacion) , vh.tipo_operacion


   DELETE #TMP_RETORNO_FINAL 
    WHERE Operacion        NOT IN(SELECT Numero_Contrato FROM #TMP_CARTERA_SWAP)   

   DECLARE @iRegistros     NUMERIC(9)
       SET @iRegistros     = (SELECT COUNT(1) FROM #TMP_RETORNO_FINAL)

   UPDATE #TMP_RETORNO_FINAL SET Registros = @iRegistros

   
   SELECT Registros
      ,   Pais
      ,   Fecha
      ,   Identificacion
      ,   Empresa
      ,   CProducto
      ,   TProducto
      ,   Interno
      ,   CProductoi
      ,   TipoProducto
      ,   Operacion
      ,   FechaContable
      ,   Cuenta
      ,   Moneda
      ,   Indicador
      ,   EvtoContable
      ,   SgnoMdaOrig
      ,   MontoOriginal
      ,   SgnoMdaCnv
      ,   MontoMonedaMn
      ,   SgnoMdaxxx
      ,   Montoxxx
      ,   Sucursal
      ,   Centro 
     FROM #TMP_RETORNO_FINAL


END
GO
