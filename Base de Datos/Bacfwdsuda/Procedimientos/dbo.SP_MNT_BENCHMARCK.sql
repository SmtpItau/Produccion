USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_BENCHMARCK]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_BENCHMARCK]
   (   @MiTag         INT
   ,   @Fecha         DATETIME   = ''
   ,   @Instrumento   INT    = 0
   ,   @Moneda        INT    = 0
   ,   @Desde         NUMERIC(9) = 0
   ,   @Hasta         NUMERIC(9) = 0
   ,   @Tasa          FLOAT      = 0.0
   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TEMPORAL
   (   Fecha         DATETIME   NOT NULL CONSTRAINT [df_TMP_Fecha]         DEFAULT('')
   ,   Instrumento   INT    NOT NULL CONSTRAINT [df_TMP_Instrumento]   DEFAULT(0)
   ,   Moneda        INT    NOT NULL CONSTRAINT [df_TMP_Moneda]        DEFAULT(0)
   ,   Desde         NUMERIC(9) NOT NULL CONSTRAINT [df_TMP_Desde]         DEFAULT(0)
   ,   Hasta         NUMERIC(9) NOT NULL CONSTRAINT [df_TMP_Hasta]         DEFAULT(0)
   ,   Tasa          FLOAT      NOT NULL CONSTRAINT [df_TMP_Tasa]          DEFAULT(0.0)
   )

   IF @MiTag = 1 --> Consulta (pantalla)
   BEGIN
      IF NOT EXISTS( SELECT 1 FROM BENCH_MARCK WHERE Fecha = @Fecha)
      BEGIN
         SELECT DISTINCT cacodmon1 , cabroker INTO #mfca_tmp FROM MFCA WHERE cacodpos1 = 10

         DELETE #TEMPORAL

         INSERT INTO #TEMPORAL
         SELECT @Fecha     as Fecha
         ,      incodigo   as incodigo
         ,      cacodmon1  as Moneda
         ,      0          as Desde 
         ,      5          as Hasta 
         ,      0.0        as Plazo
         FROM   #mfca_tmp  LEFT JOIN bacparamsuda..INSTRUMENTO ON incodigo = cabroker
                           LEFT JOIN bacparamsuda..MONEDA      ON mncodmon = cacodmon1


         INSERT INTO #TEMPORAL
         SELECT @Fecha 
         ,      incodigo 
         ,      cacodmon1
         ,      6 
         ,      10 
         ,      0.0 
         FROM   #mfca_tmp LEFT JOIN bacparamsuda..INSTRUMENTO ON incodigo = cabroker
                          LEFT JOIN bacparamsuda..MONEDA      ON mncodmon = cacodmon1

         INSERT INTO BENCH_MARCK
         SELECT * FROM #TEMPORAL 

         DROP TABLE #mfca_tmp
      END

      SELECT inserie
      ,      mnnemo
      ,      Desde
      ,      Hasta
      ,      Tasa
      ,      Instrumento
      ,      Moneda
      FROM   BENCH_MARCK
                         LEFT JOIN bacparamsuda..INSTRUMENTO ON incodigo = instrumento
                         LEFT JOIN bacparamsuda..MONEDA      ON mncodmon = moneda
      WHERE  Fecha   = @Fecha
   END

   IF @MiTag = 2 --> Borrar
   BEGIN
      DELETE BENCH_MARCK
      WHERE  Fecha = @Fecha
   END

   IF @MiTag = 3 --> Grabar
   BEGIN
      INSERT INTO BENCH_MARCK
      SELECT @Fecha
      ,      @Instrumento
      ,      @Moneda
      ,      @Desde
      ,      @Hasta
      ,      @Tasa
      
   END

   IF @MiTag = 4 --> Carga Instrumento
   BEGIN
      SELECT incodigo 
      ,      inserie 
      FROM   bacparamsuda..INSTRUMENTO
   END

   IF @MiTag = 5 --> Carga Monedas
   BEGIN
      SELECT mncodmon
      ,      mnnemo
      FROM   bacparamsuda..MONEDA
      WHERE  mntipmon in(1,3)
      ORDER BY mntipmon
   END
   DROP TABLE #TEMPORAL
END

GO
