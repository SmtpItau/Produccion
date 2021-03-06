USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_BENCHMARCK_INV_EXT]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_BENCHMARCK_INV_EXT]
   (   @MiTag         INT
   ,   @Fecha         DATETIME   = ''
   ,   @Instrumento   CHAR(20)   = ''
   ,   @Moneda        INT    = 0
   ,   @Desde         NUMERIC(9) = 0
   ,   @Hasta         NUMERIC(9) = 0
   ,   @Tasa          FLOAT      = 0.0
   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TEMPORAL
   (   Fecha         DATETIME   NOT NULL     DEFAULT('')
   ,   Serie         CHAR(20)    NOT NULL DEFAULT('')
   ,   Moneda        INT    NOT NULL DEFAULT(0)
   ,   Desde         NUMERIC(9) NOT NULL DEFAULT(0)
   ,   Hasta         NUMERIC(9) NOT NULL DEFAULT(0)
   ,   Tasa          FLOAT      NOT NULL DEFAULT(0.0)
   )

   IF @MiTag = 1 --> Consulta (pantalla)
   BEGIN
      IF NOT EXISTS( SELECT 1 FROM BENCH_MARCK_INVEX WHERE Fecha = @Fecha)
      BEGIN
         SELECT DISTINCT cacodmon1 , caserie INTO #mfca_tmp FROM MFCA WHERE cacodpos1 = 11
                                                        
         DELETE #TEMPORAL

         INSERT INTO #TEMPORAL
         SELECT @Fecha     as Fecha
         ,      cod_nemo   as incodigo
         ,      cacodmon1  as Moneda
         ,      0          as Desde 
         ,      5          as Hasta 
         ,      0.0        as Plazo


         FROM   #mfca_tmp   LEFT JOIN INSTRUMENTOS_SUBYACENTES_INV_EXT ON Cod_nemo = caserie
                         --  LEFT JOIN bacparamsuda..MONEDA             ON mncodmon = cacodmon1


         INSERT INTO #TEMPORAL
         SELECT @Fecha 
         ,      cod_nemo 
         ,      cacodmon1
         ,      6 
         ,      10 
         ,      0.0 
       FROM   #mfca_tmp   LEFT JOIN INSTRUMENTOS_SUBYACENTES_INV_EXT ON Cod_nemo= caserie
                    --       LEFT JOIN bacparamsuda..MONEDA      ON mncodmon = cacodmon1

         INSERT INTO BENCH_MARCK_INVEX
         SELECT * FROM #TEMPORAL 

         DROP TABLE #mfca_tmp
      END

      SELECT  Instrumento,mnnemo -- Moneda
      ,      Desde
      ,      Hasta
      ,      Tasa
      ,      Instrumento
      ,      mncodmon               --    select * from bacparamsuda..MONEDA      ON Moneda = moneda
  FROM   BENCH_MARCK_INVEX     
                     --    LEFT JOIN INSTRUMENTOS_SUBYACENTES_INV_EXT ON Cod_nemo = Instrumento
                        LEFT JOIN bacparamsuda..MONEDA      ON Moneda = mncodmon
      WHERE  Fecha   = @Fecha
   END

   IF @MiTag = 2 --> Borrar
   BEGIN
      DELETE BENCH_MARCK_INVEX
      WHERE  Fecha = @Fecha
   END

   IF @MiTag = 3 --> Grabar
   BEGIN
      INSERT INTO BENCH_MARCK_INVEX
      SELECT @Fecha
      ,      @Instrumento
      ,      @Moneda
      ,      @Desde
      ,      @Hasta
      ,      @Tasa
      
   END

   IF @MiTag = 4 --> Carga Instrumento
   BEGIN
      SELECT Cod_Familia, Cod_Nemo
      FROM  INSTRUMENTOS_SUBYACENTES_INV_EXT
   END

   IF @MiTag = 5 --> Carga Monedas
   BEGIN
      SELECT mncodmon
      ,      mnnemo
      FROM   bacparamsuda..MONEDA
      WHERE  mntipmon in(2)  and mncodmon = 13
      ORDER BY mntipmon
   END
   DROP TABLE #TEMPORAL
END


GO
