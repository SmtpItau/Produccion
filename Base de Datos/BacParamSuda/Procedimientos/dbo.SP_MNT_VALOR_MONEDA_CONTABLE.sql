USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_VALOR_MONEDA_CONTABLE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MNT_VALOR_MONEDA_CONTABLE]
   (   @iEvento                INTEGER
   ,   @Fecha                  DATETIME    = ''
   ,   @Codigo_Moneda          NUMERIC(5)  = 0
   ,   @Nemo_Moneda            CHAR(5)     = ''
   ,   @Codigo_Contable        CHAR(5)     = ''
   ,   @Tipo_Cambio            FLOAT       = 0.0
   ,   @Porcentaje_Variacion   FLOAT       = 0.0
   ,   @Punta_Bid              FLOAT       = 0.0
   ,   @Punta_Ask              FLOAT       = 0.0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaAnte DATETIME
       SET @dFechaAnte = (SELECT acfecante FROM BacTraderSuda..MDAC WITH (NoLock) )

   IF @iEvento = 1 --> Consulta de valores de moneda Contable
   BEGIN
      SELECT Fecha
      ,      Codigo_Moneda
      ,      Nemo_Moneda
      ,      Codigo_Contable
      ,      Tipo_Cambio
      ,      Porcentaje_Variacion
      ,      SpotCompra
      ,      SpotVenta
      FROM   VALOR_MONEDA_CONTABLE WITH (NoLock)
      WHERE  Fecha      = @Fecha
   END

   IF @iEvento = 2 --> Eliminación de Registros
   BEGIN
      DELETE VALOR_MONEDA_CONTABLE 
       WHERE Fecha = @Fecha
   END

   IF @iEvento = 3 --> Actualización de Registros
   BEGIN
      SET    @Codigo_Contable      = (SELECT mncodfox FROM MONEDA WITH (NoLock) WHERE mncodmon = @Codigo_Moneda)
      SET    @Porcentaje_Variacion = ISNULL((SELECT tbvalor
                                               FROM BacParamSuda..TABLA_GENERAL_DETALLE WITH (NoLock)
                                              WHERE tbcateg = 7500 AND tbtasa = @Codigo_Moneda),0.0)

      INSERT INTO VALOR_MONEDA_CONTABLE
      (   Fecha,  Codigo_Moneda,  Nemo_Moneda,  Codigo_Contable,  Tipo_Cambio,  Porcentaje_Variacion,  SpotCompra, SpotVenta )
      VALUES
      (   @Fecha, @Codigo_Moneda, @Nemo_Moneda, @Codigo_Contable, @Tipo_Cambio, @Porcentaje_Variacion, @Punta_Bid, @Punta_Ask )

      UPDATE BacParamSuda..VALOR_MONEDA
         SET vmptacmp = @Punta_Bid
           , vmptavta = @Punta_Ask
       WHERE vmfecha  = @Fecha
         AND vmcodigo = @Codigo_Moneda
   END

   IF @iEvento = 4 --> Ultima Carga Conocida de Valores
   BEGIN
      DECLARE @iFound     INTEGER
          SET @iFound     = 0

      IF NOT EXISTS(SELECT 1 FROM VALOR_MONEDA_CONTABLE WITH (NoLock) WHERE Fecha = @Fecha)
      BEGIN
         SET @Fecha  = ISNULL( (SELECT MAX(Fecha) FROM VALOR_MONEDA_CONTABLE WITH (NoLock)), @dFechaAnte)
         SET @iFound = 1
      END

      SELECT Fecha                = Fecha
      ,      Codigo_Moneda        = Codigo_Moneda
      ,      mnglosa              = LTRIM(RTRIM(SUBSTRING(Nemo_Moneda,1,3))) + '-' + LTRIM(RTRIM(mnglosa))
      ,      Tipo_Cambio          = CASE WHEN @iFound = 0 THEN Tipo_Cambio ELSE 0.0 END
      ,      Porcentaje_Variacion = Porcentaje_Variacion
      ,      SpotCompra           = SpotCompra
      ,      SpotVenta            = SpotVenta
      ,      Codigo_Contable      = Codigo_Contable
      FROM   VALOR_MONEDA_CONTABLE WITH (NoLock)
             LEFT JOIN MONEDA     ON mncodmon = Codigo_Moneda
      WHERE  Fecha                = @Fecha
   END

   IF @iEvento = 5 --> Lee Monedas
   BEGIN
      SELECT CodigoSbif     = mncodmon 
      ,      NemoMoneda     = mnnemo 
      ,      GlosaMoneda    = mnglosa 
      ,      CodigoContable = mncodfox
      FROM   MONEDA         WITH (NoLock)
      WHERE (mntipmon       = 2 AND mnmx = 'C' AND mncodmon <> 13)
      OR    (mncodmon      IN(14,994,995,999,998))
      ORDER BY mnglosa
   END

   IF @iEvento = 6 --> Genera Variacion
   BEGIN
      SET    @Porcentaje_Variacion = isnull((SELECT tbvalor 
                                               FROM BacParamSuda..TABLA_GENERAL_DETALLE WITH (NoLock)
                                              WHERE tbcateg = 7500 AND tbtasa = @Codigo_Moneda),0.0)

      SELECT isnull(Ayer.Tipo_Cambio, 0.0)
      ,	     Porcentaje_Variacion = @Porcentaje_Variacion   -->     Ayer.Porcentaje_Variacion
      ,	     isnull(Hoy.Tipo_Cambio, 0.0)
      FROM   VALOR_MONEDA_CONTABLE           Ayer WITH (NoLock)
             LEFT JOIN VALOR_MONEDA_CONTABLE Hoy  ON Hoy.Fecha = @Fecha AND Hoy.Codigo_Moneda = Ayer.Codigo_Moneda
      WHERE  Ayer.Fecha	        = @dFechaAnte
      AND    Ayer.Codigo_Moneda = @Codigo_Moneda
   END

END
GO
