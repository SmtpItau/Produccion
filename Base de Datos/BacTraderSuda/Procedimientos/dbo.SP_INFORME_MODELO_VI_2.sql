USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_MODELO_VI_2]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- EXECUTE SP_INFORME_MODELO_VI_2 '20091231'

CREATE PROCEDURE [dbo].[SP_INFORME_MODELO_VI_2]
   (   @dFecha   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT IndFila         = CASE WHEN emgeneric = 'BCCH' THEN 2
                                 WHEN emgeneric = 'TGR'  THEN 3
                                 WHEN emtipo    = 3      THEN 4

                                 WHEN emtipo    = 2      THEN 6
                                 WHEN emtipo    = 1      THEN 7
                                 WHEN emtipo    = 4      THEN 10
                                 ELSE                         99
                            END
      ,   IndColumna      = CASE WHEN DATEDIFF(DAY,   @dFecha, rsfecvtop) >= 1 AND DATEDIFF(MONTH, @dFecha, rsfecvtop) <= 1  THEN 7
                                 WHEN DATEDIFF(MONTH, @dFecha, rsfecvtop) >= 1 AND DATEDIFF(MONTH, @dFecha, rsfecvtop) <= 3  THEN 8
                                 WHEN DATEDIFF(MONTH, @dFecha, rsfecvtop) >= 3 AND DATEDIFF(YEAR,  @dFecha, rsfecvtop) <= 1  THEN 9
                                 WHEN DATEDIFF(YEAR,  @dFecha, rsfecvtop) >  1 AND DATEDIFF(YEAR,  @dFecha, rsfecvtop) <= 3  THEN 10
                                 WHEN DATEDIFF(YEAR,  @dFecha, rsfecvtop) >  3                                               THEN 11
                            END
      ,   Emisor          = emnombre
      ,   ValorDevengado  = rsvppresenx / 1000000 --> rsvalvtop
      ,   Plazo           = DATEDIFF(DAY, @dFecha, rsfecvtop)
   INTO   #TBL_PASO
   FROM   MDRS
          LEFT  JOIN BacParamSuda.dbo.EMISOR      ON emrut    = rsrutemis
          LEFT  JOIN BacParamSuda.dbo.INSTRUMENTO ON incodigo = rscodigo
   WHERE  rsfecha         = @dFecha
     AND  rscartera       = 115

CREATE TABLE #TBL_RETORNO
   (   Grupo      VARCHAR(50)
   ,   Titulo     INTEGER
   ,   CodOrden   INTEGER
   ,   Periodo1   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo2   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo3   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo4   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo5   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo6   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo7   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo8   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo9   NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo10  NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo11  NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Periodo12  NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   )

   INSERT INTO #TBL_RETORNO SELECT 'Instrumentos del Estado y del Banco Central',        1, 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Instrumentos del Banco Central',                     0, 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Bonos o pagares de la Tesoreria',                    0, 3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Otras instituciones fiscales',                       0, 4, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

   INSERT INTO #TBL_RETORNO SELECT 'Otros instrumentos emitidos por el Pais',            1, 5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Instrumentos de otros bancos del Pais',              0, 6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Bonos y efectos de comercio de empresas',            0, 7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Otros instrumentos emitidos por el Pais',            0, 8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

   INSERT INTO #TBL_RETORNO SELECT 'Instrumentos emitidos en el Exterior',               1, 9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Instrumentos de gobiernos y bancos centrales',       0, 10, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Otros instrumentos emitidos en el exterior',         0, 11, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

   INSERT INTO #TBL_RETORNO SELECT 'Inversiones en fondos mutuos',                       1, 12, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Forndos administrados por sociedades relacionadas',  0, 13, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
   INSERT INTO #TBL_RETORNO SELECT 'Forndos administrados por terceros',                 0, 14, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

   INSERT INTO #TBL_RETORNO SELECT 'Totales',                             1, 15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

   SELECT IndFila, IndColumna, Monto = SUM( ValorDevengado ) 
   INTO   #TBL_GRUPO
   FROM   #TBL_PASO 
   GROUP BY IndFila, IndColumna

   UPDATE #TBL_RETORNO
      SET Periodo1   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 1

   UPDATE #TBL_RETORNO
      SET Periodo2   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 2

   UPDATE #TBL_RETORNO
      SET Periodo3   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 3

   UPDATE #TBL_RETORNO
      SET Periodo4   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 4

   UPDATE #TBL_RETORNO
      SET Periodo5   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 5

   UPDATE #TBL_RETORNO
      SET Periodo6   = Periodo1 + Periodo2 + Periodo3 + Periodo4 + Periodo5
 
   UPDATE #TBL_RETORNO
      SET Periodo7   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 7

   UPDATE #TBL_RETORNO
      SET Periodo8   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 8

   UPDATE #TBL_RETORNO
      SET Periodo9   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 9

   UPDATE #TBL_RETORNO
      SET Periodo10   = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 10

   UPDATE #TBL_RETORNO
      SET Periodo11  = Monto
     FROM #TBL_GRUPO
    WHERE Titulo     = 0
      AND CodOrden   = IndFila
      AND IndColumna = 11

   UPDATE #TBL_RETORNO
      SET Periodo12   = Periodo7 + Periodo8 + Periodo9 + Periodo10 + Periodo11

   UPDATE #TBL_RETORNO
      SET Periodo1 = (SELECT SUM( Periodo1 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo2 = (SELECT SUM( Periodo2 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo3 = (SELECT SUM( Periodo3 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo4 = (SELECT SUM( Periodo4 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo5 = (SELECT SUM( Periodo5 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo6 = (SELECT SUM( Periodo6 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo7 = (SELECT SUM( Periodo7 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo8 = (SELECT SUM( Periodo8 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo9 = (SELECT SUM( Periodo9 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo10 = (SELECT SUM( Periodo10 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo11 = (SELECT SUM( Periodo11 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15

   UPDATE #TBL_RETORNO
      SET Periodo12 = (SELECT SUM( Periodo12 ) FROM #TBL_RETORNO WHERE Titulo = 0 AND CodOrden < 15)
    WHERE Titulo   = 1
      AND CodOrden = 15


   SELECT Grupo
      ,   '1 Dia Hasta 1 mes'          = Periodo1
      ,   'Más de 1 mes hasta 3 Meses' = Periodo2
      ,   'Mas de 3 meses hasta 1 año' = Periodo3
      ,   'Más de 1 año hasta 3 años'  = Periodo4
      ,   'Más de 3 años'              = Periodo5
      ,   'Total'                      = Periodo6
      ,   '1 Dia Hasta 1 mes'          = Periodo7
      ,   'Más de 1 mes hasta 3 Meses' = Periodo8
      ,   'Mas de 3 meses hasta 1 año' = Periodo9
      ,   'Más de 1 año hasta 3 años'  = Periodo10
      ,   'Más de 3 años'              = Periodo11
      ,   'Total'                      = Periodo12
     FROM #TBL_RETORNO 
 ORDER BY CodOrden

END




GO
