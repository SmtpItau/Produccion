USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_RESUMEN_PARAMETROS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_RESUMEN_PARAMETROS]
AS
BEGIN
 SET NOCOUNT ON
 
 DECLARE @monto_1 NUMERIC,
  @monto_2 NUMERIC
 
 --recupero registros...
 SELECT  'orden'  = IDENTITY( NUMERIC, 1, 1 ),
  glosa_partida , 
  glosa  , 
  monto  ,
  tipo
 INTO #temporal
 FROM tbtr_pra_rsv_tcn
 WHERE   glosa_partida <> ''
 ORDER BY codigo 
 --calulo el resultado de los tipo 1 contra tipo2
 SELECT @monto_1 = (   ( SELECT SUM(monto) FROM tbtr_pra_rsv_tcn WHERE tipo = 1 ) 
       - ( SELECT SUM(monto) FROM tbtr_pra_rsv_tcn WHERE tipo = 2 AND glosa_partida <> '' ) )
 --inserto linea en blanco
 INSERT INTO  #temporal
   ( glosa_partida,
     glosa,
     monto )
 VALUES  ( '',
     '',
     0 )
 --inserto registro con el resultado 
 INSERT INTO  #temporal
   ( glosa_partida,
     glosa,
     monto )
 VALUES  ( '',
     'TOTAL OBLIGACIONES COMPUTABLES',
     @monto_1 )
 
 --inserto linea en blanco
 INSERT INTO  #temporal
   ( glosa_partida,
     glosa,
     monto )
 VALUES  ( '',
     '',
     0 )
 --inserto registro pendiente
 INSERT INTO #temporal
  ( glosa_partida , 
    glosa  , 
    monto  ,
    tipo )
  SELECT  glosa_partida , 
   glosa  , 
   monto  ,
   tipo
  FROM tbtr_pra_rsv_tcn
  WHERE   glosa_partida = ''
  ORDER BY codigo 
 --inserto linea en blanco
 INSERT INTO  #temporal
   ( glosa_partida,
     glosa,
     monto )
 VALUES  ( '',
     '',
     0 )
 --calulo el resultado 1 tipo pdte
 SELECT @monto_2 = ( @monto_1 - ( SELECT SUM(monto) FROM tbtr_pra_rsv_tcn WHERE tipo = 2 AND glosa_partida = '' ) )
 --inserto registro con el resultado 
 INSERT INTO  #temporal
   ( glosa_partida,
     glosa,
     monto )
 VALUES  ( '',
     'TOTAL RESERVA TECNICA EXIGIBLE',
     @monto_2 )
 SELECT * FROM #temporal ORDER BY orden
END

GO
