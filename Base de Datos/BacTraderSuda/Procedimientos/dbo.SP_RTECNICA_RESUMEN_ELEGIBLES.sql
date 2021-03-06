USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_RESUMEN_ELEGIBLES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_RESUMEN_ELEGIBLES]
AS
BEGIN
 SET NOCOUNT ON
 
 SELECT  'rango'   = 1,
  'partida' = partida, 
  'glosa'   = UPPER( glosa_menos ), 
  'saldo'   = CONVERT( NUMERIC(18), Sum( saldo_menos ) ),
  'reserva' = CONVERT( NUMERIC(18), Sum( reserva_menos ) )
 INTO #temporal
 FROM  tbtr_cod_elg 
 GROUP BY glosa_menos, partida
 
 INSERT INTO #temporal
  SELECT  'rango'   = 2,
   'partida' = partida, 
   'glosa'   = UPPER( glosa_mas ), 
   'saldo'   = CONVERT( NUMERIC(18), Sum( saldo_mas ) ),
   'reserva' = CONVERT( NUMERIC(18), Sum( reserva_mas ) )
  FROM tbtr_cod_elg
  GROUP BY glosa_mas, partida
 
 SELECT * FROM #temporal ORDER BY rango, partida
END

GO
