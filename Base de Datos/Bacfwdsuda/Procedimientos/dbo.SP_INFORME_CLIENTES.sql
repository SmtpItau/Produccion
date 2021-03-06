USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CLIENTES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INFORME_CLIENTES]
   (   @Fecha         DATETIME
   ,   @RutCliente    NUMERIC(10)
   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TMP_CUADRO
   (   IdCuadro    INT
   ,   Nombre      VARCHAR(50)
   ,   Operacion   VARCHAR(10)
   ,   Inicio      CHAR(10)
   ,   Vencimiento CHAR(10)
   ,   Moneda      CHAR(3)
   ,   Nocional    NUMERIC(21,4)
   ,   Tasa        NUMERIC(21,4)
   ,   Precio      NUMERIC(21,4)
   ,   Contrato    NUMERIC(9)
   ,   Producto    VARCHAR(30)
   ,   MonedaCnv   CHAR(3)
   ,   Origen      VARCHAR(20)
   ,   Cliente     VARCHAR(50)
   ,   Comprador   VARCHAR(50)
   ,   Vendedor    VARCHAR(50)
   ,   iProducto   INT
   ,   iMoneda1    INT
   ,   iMoneda2    INT
   )

   CREATE INDEX #iixt_TMP_CUADRO ON #TMP_CUADRO (IdCuadro, Inicio)

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = (SELECT acfecproc FROM MFAC WHERE acrutprop = 97023000)

   IF @dFechaProceso = @Fecha
   BEGIN
      INSERT INTO #TMP_CUADRO
      SELECT IdCuadro   = cacodcli
      ,      Nombre     = SUBSTRING(clnombre, 1,50)
      ,      Operacion  = CASE WHEN catipoper = 'C' THEN 'COMPRA FW' ELSE 'VENTA FW' END
      ,      Inicio     = CONVERT(CHAR(10),cafecha,103)
      ,      Vencimiento= CONVERT(CHAR(10),cafecvcto,103)
      ,      Moneda     = M.mnnemo --> cacodmon1
      ,      Nocional   = camtomon1
      ,      Tasa       = CaTasaSinteticaM2
      ,      PrecioFut  = catipcam
      ,      Contrato   = canumoper
      ,      Producto   = CASE WHEN cacodpos1 = 1  THEN 'SEGURO CAMBIO'
                               WHEN cacodpos1 = 2  THEN 'ARBITRAJE FUTURO'
                               WHEN cacodpos1 = 3  THEN 'SEGURO INFLACION'
                               WHEN cacodpos1 = 10 THEN 'FORWARD BOND TRADES'
                               WHEN cacodpos1 = 11 THEN 'T-LOOK'
                          END
      ,      MonedaCnv  = C.mnnemo --> cacodmon2
      ,      Origen     = 'CARTERA'
      ,      Cliente    = ''
      ,      Comprador  = CASE WHEN catipoper = 'C' THEN 'CORPBANCA' ELSE SUBSTRING(clnombre, 1,50) END
      ,      Vendedor   = CASE WHEN catipoper = 'V' THEN 'CORPBANCA' ELSE SUBSTRING(clnombre, 1,50) END
      ,      iProducto  = cacodpos1
      ,      iMoneda1   = cacodmon1
      ,      iMoneda2   = cacodmon2
      FROM   BacFwdSuda..MFCA WITH (NoLock)
             LEFT JOIN BacParamSuda..CLIENTE  ON cacodigo   = clrut AND cacodcli = clcodigo
             LEFT JOIN BacParamSuda..MONEDA M ON M.mncodmon = cacodmon1
             LEFT JOIN BacParamSuda..MONEDA C ON C.mncodmon = cacodmon2
      WHERE  cafecvcto >= @Fecha
      AND    cacodigo   = @RutCliente
      AND    cacodpos1  IN(1,2,3)
      ORDER BY cacodcli

   END ELSE
   BEGIN
      INSERT INTO #TMP_CUADRO
      SELECT IdCuadro   = cacodcli
      ,      Nombre     = SUBSTRING(clnombre, 1,50)
      ,      Operacion  = CASE WHEN catipoper = 'C' THEN 'COMPRA FW' ELSE 'VENTA FW' END
      ,      Inicio     = CONVERT(CHAR(10),cafecha,103)
      ,      Vencimiento= CONVERT(CHAR(10),cafecvcto,103)
      ,      Moneda     = M.mnnemo --> cacodmon1
      ,      Nocional   = camtomon1
      ,      Tasa       = CaTasaSinteticaM2
      ,      PrecioFut  = catipcam
      ,      Contrato   = canumoper
      ,      Producto   = CASE WHEN cacodpos1 = 1  THEN 'SEGURO CAMBIO'
                               WHEN cacodpos1 = 2  THEN 'ARBITRAJE FUTURO'
                               WHEN cacodpos1 = 3  THEN 'SEGURO INFLACION'
                               WHEN cacodpos1 = 10 THEN 'FORWARD BOND TRADES'
                               WHEN cacodpos1 = 11 THEN 'T-LOOK'
                          END
      ,      MonedaCnv  = C.mnnemo --> cacodmon2
      ,      Origen     = 'HISTORICO'
      ,      Cliente    = ''
      ,      Comprador  = CASE WHEN catipoper = 'C' THEN 'CORPBANCA' ELSE SUBSTRING(clnombre, 1,50) END
      ,      Vendedor   = CASE WHEN catipoper = 'V' THEN 'CORPBANCA' ELSE SUBSTRING(clnombre, 1,50) END
      ,      iProducto  = cacodpos1
      ,      iMoneda1   = cacodmon1
      ,      iMoneda2   = cacodmon2
      FROM   BacFwdSuda..MFCARES WITH (NoLock)
             LEFT JOIN BacParamSuda..CLIENTE  ON cacodigo   = clrut AND cacodcli = clcodigo
             LEFT JOIN BacParamSuda..MONEDA M ON M.mncodmon = cacodmon1
             LEFT JOIN BacParamSuda..MONEDA C ON C.mncodmon = cacodmon2
      WHERE  CaFechaProceso = @Fecha
      AND    cafecvcto     >= @Fecha
      AND    cacodigo       = @RutCliente
      AND    cacodpos1      IN(1,2,3)
      ORDER BY cacodcli
   END

   DECLARE @nCodigo   INT
       SET @nCodigo   = (SELECT MIN(clcodigo) FROM BacParamSuda..CLIENTE WHERE clrut = @RutCliente)
   

   IF NOT EXISTS( SELECT 1 FROM #TMP_CUADRO)
   BEGIN
      SELECT IdCuadro     = 0
      ,      Nombre       = ' '
      ,      Operacion    = ' '
      ,      Inicio       = ' '
      ,      Vencimiento  = ' '
      ,      Moneda       = ' '
      ,      Nocional     = ' '
      ,      Tasa         = ' '
      ,      Precio       = ' '
      ,      Contrato     = ' '
      ,      Producto     = ' '
      ,      MonedaCnv    = ' '
      ,      Origen       = ' '
      ,      Cliente      = SUBSTRING(clnombre,1,50)
      ,      Fecha        = @Fecha
      ,      Titulo       = 'Contratos Vigentes al ' 
                          + ' ' + RTRIM(DATEPART(DAY,@Fecha)) + ' de ' 
                          + CASE WHEN DATEPART(MONTH,@Fecha) = 1  THEN 'Enero del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 2  THEN 'Febrero del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 3  THEN 'Marzo del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 4  THEN 'Abril del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 5  THEN 'Mayo del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 6  THEN 'Junio del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 7  THEN 'Julio del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 8  THEN 'Agosto del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 9  THEN 'Septiembre del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 10 THEN 'Octubre del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 11 THEN 'Noviembre del ' 
                                 WHEN DATEPART(MONTH,@Fecha) = 12 THEN 'Diciembre del ' 
                            END 
                          + ' ' + LTRIM(RTRIM(DATEPART(YEAR,@Fecha)))
      ,     Comprador     = ''
      ,     Vendedor      = ''
      ,     iProducto     = 0
      ,     iMoneda1      = 0
      ,     iMoneda2      = 0
      FROM  BacParamSuda..CLIENTE
      WHERE clrut         = @RutCliente
      AND   clcodigo      = @nCodigo


      RETURN
   END


   UPDATE #TMP_CUADRO
      SET Cliente    = SUBSTRING(clnombre,1,50)
     FROM BacParamSuda..CLIENTE
    WHERE clrut      = @RutCliente
      AND clcodigo   = @nCodigo

   SELECT IdCuadro
   ,      Nombre
   ,      Operacion
   ,      Inicio
   ,      Vencimiento
   ,      Moneda
   ,      Nocional
   ,      Tasa
   ,      Precio
   ,      Contrato
   ,      Producto
   ,      MonedaCnv
   ,      Origen
   ,      Cliente
   ,      Fecha   = @Fecha
   ,      Titulo  = 'Contratos Vigentes al ' 
                  + ' ' + RTRIM(DATEPART(DAY,@Fecha)) + ' de ' 
                  + CASE WHEN DATEPART(MONTH,@Fecha) = 1  THEN 'Enero del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 2  THEN 'Febrero del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 3  THEN 'Marzo del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 4  THEN 'Abril del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 5  THEN 'Mayo del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 6  THEN 'Junio del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 7  THEN 'Julio del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 8  THEN 'Agosto del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 9  THEN 'Septiembre del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 10 THEN 'Octubre del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 11 THEN 'Noviembre del ' 
                         WHEN DATEPART(MONTH,@Fecha) = 12 THEN 'Diciembre del ' 
                    END 
                   + ' ' + LTRIM(RTRIM(DATEPART(YEAR,@Fecha)))
   ,     Comprador = Comprador
   ,     Vendedor  = Vendedor
   ,     iProducto = iProducto
   ,     iMoneda1  = iMoneda1
   ,     iMoneda2  = iMoneda2
   FROM  #TMP_CUADRO
   ORDER BY IdCuadro, Inicio

END


GO
