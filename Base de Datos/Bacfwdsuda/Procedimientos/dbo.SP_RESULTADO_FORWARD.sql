USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADO_FORWARD]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RESULTADO_FORWARD]( @fecha_0   CHAR(8),
     @fecha_1   CHAR(8),
     @fecha_2   CHAR(8),
            @fecha_3   CHAR(8),
     @fecha_4   CHAR(8)
     )
AS BEGIN
 
 SET NOCOUNT ON
 
 DECLARE @observado_3  NUMERIC(12,04)     ,
  @observado_2  NUMERIC(12,04)     ,
  @observado_1  NUMERIC(12,04)     ,
  @observado_0  NUMERIC(12,04)     ,
  @uf_3  NUMERIC(12,04)     ,
  @uf_2  NUMERIC(12,04)     ,
  @uf_1  NUMERIC(12,04)     ,
  @uf_0  NUMERIC(12,04)     ,
  @acumula_c  NUMERIC(21,00)     ,
  @acumula_v  NUMERIC(21,00)     ,
  @acumula_c1  NUMERIC(21,00)     ,
  @acumula_v1  NUMERIC(21,00)     ,
  @acumula_uf  NUMERIC(21,00)     ,
  @acumula_dev  NUMERIC(21,00)     ,
  @acumula_net  NUMERIC(21,00)     ,
  @entidad     char(40)
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT   @acumula_c1 = 0
 SELECT   @acumula_v1 = 0
 SELECT   @acumula_uf = 0
 SELECT   @acumula_dev = 0
 SELECT   @acumula_net = 0
 SELECT @observado_3 = vmvalor
 FROM view_valor_moneda,
  mfac
 WHERE accodmondolobs = vmcodigo AND
  @fecha_3 = vmfecha
 SELECT @observado_2 = vmvalor ,@entidad = acnomprop
 FROM view_valor_moneda,
  mfac
 WHERE accodmondolobs = vmcodigo AND
  @fecha_2 = vmfecha
 SELECT @observado_1 = vmvalor
 FROM view_valor_moneda,
  mfac
 WHERE accodmondolobs = vmcodigo AND
  @fecha_1 = vmfecha
 SELECT @observado_0 = vmvalor
 FROM view_valor_moneda,
  mfac
 WHERE accodmondolobs = vmcodigo AND
  @fecha_0 = vmfecha
 SELECT @uf_3 = vmvalor
 FROM view_valor_moneda,
  mfac
 WHERE accodmonuf = vmcodigo AND
  @fecha_3 = vmfecha
 SELECT @uf_2 = vmvalor
 FROM view_valor_moneda,
  mfac
 WHERE accodmonuf = vmcodigo AND
  @fecha_2 = vmfecha
 SELECT @uf_1 = vmvalor
 FROM view_valor_moneda,
  mfac
 WHERE accodmonuf = vmcodigo AND
  @fecha_1 = vmfecha
 SELECT @uf_0 = vmvalor
 FROM view_valor_moneda,
  mfac
 WHERE accodmonuf = vmcodigo AND
  @fecha_0 = vmfecha
 CREATE TABLE #temp_res( tipoc       CHAR(1)     ,
    posicion    NUMERIC(3)    ,
    llave     CHAR(9)     ,
    Glosa       CHAR(30)         ,
    monto_3     NUMERIC(21,04) DEFAULT(0) ,
    monto_2     NUMERIC(21,04) DEFAULT(0) ,
    monto_1     NUMERIC(21,04) DEFAULT(0) ,
    monto_0     NUMERIC(21,04) DEFAULT(0) ,  
    acumulado   NUMERIC(21,04) DEFAULT(0) ,
    fecha3     DATETIME       ,
    fecha2     DATETIME       ,
    fecha1     DATETIME       ,
    fecha0     DATETIME       ,
    observado_3  NUMERIC(12,04)       ,
    observado_2  NUMERIC(12,04)       ,
    observado_1  NUMERIC(12,04)       ,
    observado_0  NUMERIC(12,04)       ,
    uf_3  NUMERIC(12,04)       ,
    uf_2  NUMERIC(12,04)       ,
    uf_1  NUMERIC(12,04)       ,
    uf_0  NUMERIC(12,04)       ,
    hora  CHAR(8)    ,
    entidad char(40),
    )
 -- |-----------------------------------------------------------
 -- | Primero las Glosas de los Resultados a Desplegar
 -- |-----------------------------------------------------------
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 1 , 'C-13 -999' , 'Saldo Dólares' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 2 , 'C-13 -999' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 3 , 'C-13 -999' , 'Devengo' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 4 , 'C-13 -999' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 5 , 'C-13 -998' , 'Saldo Dólares' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 6 , 'C-13 -998' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 7 , 'C-13 -998' , 'Resultado Var. U.F.' ) 
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 8 , 'C-13 -998' , 'Devengo' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 9 , 'C-13 -998' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 10 , 'C-NET-1  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '1' , 11 , 'C-NET-1  ' , 'Res. Neto Acumulado Anual' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 12 , 'V-13 -999' , 'Saldo Dólares' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 13 , 'V-13 -999' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 14 , 'V-13 -999' , 'Devengo' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 15 , 'V-13 -999' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 16 , 'V-13 -998' , 'Saldo Dólares' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 17 , 'V-13 -998' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 18 , 'V-13 -998' , 'Resultado Var. U.F.' ) 
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 19 , 'V-13 -998' , 'Devengo' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 20 , 'V-13 -998' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 21 , 'V-NET-1  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '2' , 22 , 'V-NET-1  ' , 'Res. Neto Acumulado Anual' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '3' , 23 , 'RES'       , 'Resultado del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '3' , 24 , 'RES'       , 'Ajus.Contable Modif. Contrato' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '3' , 25 , 'RES'       , 'Resultado Acumulado Anual' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 26 , '998-999' , 'Resultado Variación U.F.' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 27 , '998-999' , 'Devengo' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 28 , '998-999' , 'Resultado del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 29 , '998-999' , 'Resultado Acumulado Anual' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 30 , 'M/X-13 ' , 'Resultado del Día' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 31 , 'M/X-13 ' , 'Resultado Acumulado Anual' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 32 , 'TOT-FWD' , 'RESULTADO TOTAL FORWARD' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '7' , 33 , 'STOCK' , 'Seg.Cmb. Stock en Dólares' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '7' , 34 , 'STOCK' , 'Seg.Inf. Stock en Dólares' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '7' , 35 , 'STOCK' , 'Arbitrajes Stock en Dólares' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '8' , 36 , 'VAR' , 'Compra' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '8' , 37 , 'VAR' , 'Venta' )
 INSERT INTO #temp_res( tipoc , posicion , llave , Glosa ) VALUES ( '8' , 38 , 'VAR' , 'Total' )
 -- |---------------------------------------
 -- | Actualiza los Valores Día 3
 -- |---------------------------------------
 UPDATE #temp_res SET monto_3 = saldo_usd 
 FROM resultado ,
  #temp_res
 WHERE  (posicion = 1  OR
  posicion = 5  OR
  posicion = 12 OR
  posicion = 16 ) AND
  tipo  = llave AND
  fecha = @fecha_3 
  UPDATE #temp_res SET Monto_3 = variacion_tc
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 2  OR
   posicion = 6  OR
   posicion = 13 OR
   posicion = 17 ) AND
   tipo  = llave AND
   fecha = @fecha_3
 UPDATE #temp_res SET Monto_3 = variacion_uf
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 7  OR
   posicion = 18 ) AND
 tipo  = llave AND
   fecha = @fecha_3
  UPDATE #temp_res SET Monto_3 = devengo
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 3  OR
   posicion = 8  OR
   posicion = 14 OR
   posicion = 19 ) AND
   tipo  = llave AND
   fecha = @fecha_3
  UPDATE #temp_res SET Monto_3 = neto_dia
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 4  OR
   posicion = 9  OR
   posicion = 15 OR
   posicion = 20 ) AND
   tipo  = llave AND
   fecha = @fecha_3
  UPDATE #temp_res SET Monto_3 = acumulado_neto
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 11 OR
   posicion = 22 ) AND
   tipo  = llave AND
   fecha = @fecha_3
 -- Esto Para Sumar el Neto del Día
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT @acumula_c = monto_3 -- Primero las Compras
 FROM #temp_res 
 WHERE  posicion = 4 
 SELECT @acumula_c = @acumula_c + monto_3 -- Primero las Compras
 FROM #temp_res 
 WHERE  posicion = 9 
 
 SELECT  @acumula_v = monto_3 -- Segundo las Ventas
 FROM  #temp_res 
 WHERE  posicion = 15 
 SELECT  @acumula_v = @acumula_v + monto_3 -- Segundo las Ventas
 FROM  #temp_res 
 WHERE  posicion = 20 
 
  UPDATE #temp_res SET Monto_3 = @acumula_c
 FROM resultado ,
  #temp_res
 WHERE  posicion = 10 AND
  fecha = @fecha_3
  UPDATE #temp_res SET Monto_3 = @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 21 AND
  fecha = @fecha_3
  UPDATE #temp_res SET Monto_3 = @acumula_c + @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 23 AND
  fecha = @fecha_3
 -- Esto Para Sumar el Neto Acumulado
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT @acumula_c = monto_3 
 FROM #temp_res 
 WHERE  posicion = 11 
 SELECT @acumula_v = monto_3 
 FROM #temp_res 
 WHERE  posicion = 22 
  UPDATE #temp_res SET Monto_3 = @acumula_c + @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 25 AND
  fecha = @fecha_3
 ----------------------
 -- Resultados UF Pesos
 ----------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_v1 = 0
 SELECT  @acumula_c = SUM(variacion_uf) ,
  @acumula_v = SUM(devengo) ,
  @acumula_c1 = SUM(neto_dia) ,
  @acumula_v1 = SUM(saldo_usd) 
 FROM resultado
 WHERE  fecha = @fecha_3 AND
  tipo LIKE '%998-999%'
  UPDATE #temp_res SET Monto_3 = @acumula_c 
 WHERE  posicion = 26
  UPDATE #temp_res SET Monto_3 = @acumula_v 
 WHERE  posicion = 27
  UPDATE #temp_res SET Monto_3 = @acumula_c1 
 WHERE  posicion = 28
 UPDATE #temp_res SET monto_3 = acumulado_neto 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 29  AND
  tipo  = 'NETO-3' AND
  fecha = @fecha_3
  UPDATE #temp_res SET Monto_3 = @acumula_v1 
 WHERE  posicion = 34
 ------------------------------------
 -- Resultado Arbitrajes
 -----------------------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c = SUM(variacion_tc) ,
  @acumula_v = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_3 AND
  tipo LIKE '%M/X%'
  UPDATE #temp_res SET Monto_3 = @acumula_c 
 WHERE  posicion = 30
 UPDATE #temp_res SET monto_3 = acumulado_neto 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 31  AND
  tipo  = 'NETO-2' AND
  fecha = @fecha_3
  UPDATE #temp_res SET Monto_3 = @acumula_v
 WHERE  posicion = 35
 -- |------------------------------------------------------------------------------------------------------------
 -- | Actualiza los Valores Día 2
 -- |-------------------------------------------------------------------------------------------------------------
 UPDATE #temp_res SET monto_2 = saldo_usd
 FROM resultado ,
  #temp_res
 WHERE  (posicion = 1  OR
  posicion = 5  OR
  posicion = 12 OR
  posicion = 16 ) AND
  tipo  = llave AND
  fecha = @fecha_2
  UPDATE #temp_res SET Monto_2 = variacion_tc
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 2  OR
   posicion = 6  OR
   posicion = 13 OR
   posicion = 17 ) AND
   tipo  = llave AND
   fecha = @fecha_2
 UPDATE #temp_res SET Monto_2 = variacion_uf
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 7  OR
   posicion = 18 ) AND
   tipo  = llave AND
   fecha = @fecha_2
  UPDATE #temp_res SET Monto_2 = devengo
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 3  OR
   posicion = 8  OR
   posicion = 14 OR
   posicion = 19 ) AND
   tipo  = llave AND
   fecha = @fecha_2
  UPDATE #temp_res SET Monto_2 = neto_dia
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 4  OR
   posicion = 9  OR
   posicion = 15 OR
   posicion = 20 ) AND
   tipo  = llave AND
   fecha = @fecha_2
  UPDATE #temp_res SET Monto_2 = acumulado_neto
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 11 OR
   posicion = 22 ) AND
   tipo  = llave AND
   fecha = @fecha_2
 -- Esto Para Sumar el Neto del Día
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT @acumula_c = monto_2 -- Primero las Compras
 FROM #temp_res 
 WHERE  posicion = 4 
 SELECT @acumula_c = @acumula_c + monto_2 -- Primero las Compras
 FROM #temp_res 
 WHERE  posicion = 9 
 
 SELECT  @acumula_v = monto_2 -- Segundo las Ventas
 FROM  #temp_res 
 WHERE  posicion = 15 
 SELECT  @acumula_v = @acumula_v + monto_2 -- Segundo las Ventas
 FROM  #temp_res 
 WHERE  posicion = 20 
 
  UPDATE #temp_res SET Monto_2 = @acumula_c
 FROM resultado ,
  #temp_res
 WHERE  posicion = 10 AND
  fecha = @fecha_2
  UPDATE #temp_res SET Monto_2 = @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 21 AND
  fecha = @fecha_2
  UPDATE #temp_res SET Monto_2 = @acumula_c + @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 23 AND
  fecha = @fecha_2
 -- Esto Para Sumar el Neto Acumulado
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT @acumula_c = monto_2 
 FROM #temp_res 
 WHERE  posicion = 11 
 SELECT @acumula_v = monto_2
 FROM #temp_res 
 WHERE  posicion = 22 
  UPDATE #temp_res SET Monto_2 = @acumula_c + @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 25 AND
  fecha = @fecha_2
 ----------------------
 -- Resultados UF Pesos
 ----------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_v1 = 0
 SELECT  @acumula_c = SUM(variacion_uf) ,
  @acumula_v = SUM(devengo) ,
  @acumula_c1 = SUM(neto_dia) ,
  @acumula_v1 = SUM(saldo_usd) 
 FROM resultado
 WHERE  fecha = @fecha_2 AND
  tipo LIKE '%998-999%'
  UPDATE #temp_res SET Monto_2 = @acumula_c 
 WHERE  posicion = 26
  UPDATE #temp_res SET Monto_2 = @acumula_v 
 WHERE  posicion = 27
  UPDATE #temp_res SET Monto_2 = @acumula_c1 
 WHERE  posicion = 28
 UPDATE #temp_res SET monto_2 = acumulado_neto 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 29    AND
  tipo  = 'NETO-3' AND
  fecha = @fecha_2
  UPDATE #temp_res SET Monto_2 = @acumula_v1 
 WHERE  posicion = 34
 ------------------------------------
 -- Resultado Arbitrajes
 -----------------------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c = SUM(variacion_tc) ,
  @acumula_v = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_2 AND
  tipo LIKE '%M/X%'
  UPDATE #temp_res SET Monto_2 = @acumula_c 
 WHERE  posicion = 30
 UPDATE #temp_res SET monto_2 = acumulado_neto 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 31  AND
  tipo  = 'NETO-2'  AND
  fecha = @fecha_2
  UPDATE #temp_res SET Monto_2 = @acumula_v
 WHERE  posicion = 35
 -- |---------------------------------------
 -- | Actualiza los Valores Día 1
 -- |---------------------------------------
 UPDATE #temp_res SET monto_1 = saldo_usd
 FROM resultado ,
  #temp_res
 WHERE  (posicion = 1  OR
  posicion = 5  OR
  posicion = 12 OR
  posicion = 16 ) AND
  tipo  = llave AND
  fecha = @fecha_1
  UPDATE #temp_res SET Monto_1 = variacion_tc
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 2  OR
   posicion = 6  OR
   posicion = 13 OR
   posicion = 17 ) AND
   tipo  = llave AND
   fecha = @fecha_1
 UPDATE #temp_res SET Monto_1 = variacion_uf
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 7  OR
   posicion = 18 ) AND
   tipo  = llave AND
   fecha = @fecha_1
  UPDATE #temp_res SET Monto_1 = devengo
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 3  OR
   posicion = 8  OR
   posicion = 14 OR
   posicion = 19 ) AND
   tipo  = llave AND
   fecha = @fecha_1
  UPDATE #temp_res SET Monto_1 = neto_dia
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 4  OR
   posicion = 9  OR
   posicion = 15 OR
   posicion = 20 ) AND
   tipo  = llave AND
   fecha = @fecha_1
  UPDATE #temp_res SET Monto_1 = acumulado_neto
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 11 OR
   posicion = 22 ) AND
   tipo  = llave AND
   fecha = @fecha_1
 -- Esto Para Sumar el Neto del Día
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT @acumula_c = monto_1 -- Primero las Compras
 FROM #temp_res 
 WHERE  posicion = 4 
 SELECT @acumula_c = @acumula_c + monto_1 -- Primero las Compras
 FROM #temp_res 
 WHERE  posicion = 9 
 
 SELECT  @acumula_v = monto_1 -- Segundo las Ventas
 FROM  #temp_res 
 WHERE  posicion = 15 
 SELECT  @acumula_v = @acumula_v + monto_1 -- Segundo las Ventas
 FROM  #temp_res 
 WHERE  posicion = 20 
 
  UPDATE #temp_res SET Monto_1 = @acumula_c
 FROM resultado ,
  #temp_res
 WHERE  posicion = 10 AND
  fecha = @fecha_1
  UPDATE #temp_res SET Monto_1 = @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 21 AND
  fecha = @fecha_1
  UPDATE #temp_res SET Monto_1 = @acumula_c + @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 23 AND
  fecha = @fecha_1
 -- Esto Para Sumar el Neto Acumulado
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT @acumula_c = monto_1 
 FROM #temp_res 
 WHERE  posicion = 11 
 SELECT @acumula_v = monto_1 
 FROM #temp_res 
 WHERE  posicion = 22 
  UPDATE #temp_res SET Monto_1 = @acumula_c + @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 25 AND
  fecha = @fecha_1
 ----------------------
 -- Resultados UF Pesos
 ----------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_v1 = 0
 SELECT  @acumula_c = SUM(variacion_uf) ,
         @acumula_v = SUM(devengo) ,
  @acumula_c1 = SUM(neto_dia) ,
  @acumula_v1 = SUM(saldo_usd)
 FROM resultado
 WHERE  fecha = @fecha_1 AND
  tipo LIKE '%998-999%'
  UPDATE #temp_res SET Monto_1 = @acumula_c 
 WHERE  posicion = 26
  UPDATE #temp_res SET Monto_1 = @acumula_v 
 WHERE  posicion = 27
  UPDATE #temp_res SET Monto_1 = @acumula_c1 
 WHERE  posicion = 28
 UPDATE #temp_res SET monto_1 = acumulado_neto 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 29    AND
  tipo  = 'NETO-3' AND
  fecha = @fecha_1
  UPDATE #temp_res SET Monto_1 = @acumula_v1 
 WHERE  posicion = 34
 ------------------------------------
 -- Resultado Arbitrajes
 -----------------------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c = SUM(variacion_tc) ,
  @acumula_v = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_1 AND
  tipo LIKE '%M/X%'
  UPDATE #temp_res SET Monto_1 = @acumula_c 
 WHERE  posicion = 30
 UPDATE #temp_res SET monto_1 = acumulado_neto 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 31  AND
  tipo  = 'NETO-2'  AND
  fecha = @fecha_1
  UPDATE #temp_res SET Monto_1 = @acumula_v
 WHERE  posicion = 35
 -- |---------------------------------------
 -- | Actualiza los Valores Día de Hoy
 -- |---------------------------------------
 UPDATE #temp_res SET monto_0   = saldo_usd
 FROM resultado ,
  #temp_res
 WHERE  (posicion = 1  OR
  posicion = 5  OR
  posicion = 12 OR
  posicion = 16 ) AND
  tipo  = llave AND
  fecha = @fecha_0
  UPDATE #temp_res SET Monto_0 = variacion_tc,
        acumulado = acumulado_tc
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 2  OR
   posicion = 6  OR
   posicion = 13 OR
   posicion = 17 ) AND
   tipo  = llave AND
   fecha = @fecha_0
 UPDATE #temp_res SET Monto_0 = variacion_uf,
        acumulado = acumulado_uf
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 7  OR
   posicion = 18 ) AND
   tipo  = llave AND
   fecha = @fecha_0
  UPDATE #temp_res SET Monto_0 = devengo,
        acumulado = acumulado_devengo
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 3  OR
   posicion = 8  OR
   posicion = 14 OR
   posicion = 19 ) AND
   tipo  = llave AND
   fecha = @fecha_0
  UPDATE #temp_res SET Monto_0 = neto_dia,
        acumulado = acumulado_uf
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 4  OR
   posicion = 9  OR
   posicion = 15 OR
   posicion = 20 ) AND
   tipo  = llave AND
   fecha = @fecha_0
  UPDATE #temp_res SET Monto_0 = acumulado_neto
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 11 OR
   posicion = 22 ) AND
   tipo  = llave AND
   fecha = @fecha_0
 -- Totales Columna de Acumulado
  UPDATE #temp_res SET acumulado = acumulado_neto
 FROM resultado ,
  #temp_res
 WHERE  (  posicion = 4  OR
   posicion = 9  OR
   posicion = 15 OR
   posicion = 20 ) AND
   tipo  = llave AND
   fecha = @fecha_0
 -- Esto Para Sumar el Neto del Día
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT   @acumula_c1 = 0
 SELECT   @acumula_v1 = 0
 SELECT  @acumula_c = monto_0  ,-- Primero las Compras
  @acumula_c1 = acumulado 
 FROM #temp_res 
 WHERE  posicion = 4 
 SELECT  @acumula_c = @acumula_c + monto_0  ,-- Primero las Compras
  @acumula_c1 = @acumula_c1 + acumulado 
 FROM #temp_res 
 WHERE  posicion = 9 
 
 SELECT  @acumula_v = monto_0  ,-- Segundo las Ventas
  @acumula_v1 = acumulado
 FROM  #temp_res 
 WHERE  posicion = 15 
 SELECT  @acumula_v = @acumula_v + monto_0  ,-- Segundo las Ventas
  @acumula_v1 = @acumula_v1 + acumulado 
 FROM  #temp_res 
 WHERE  posicion = 20 
 
  UPDATE #temp_res SET Monto_0 = @acumula_c ,
        acumulado = @acumula_c1 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 10 AND
  fecha = @fecha_0
  UPDATE #temp_res SET Monto_0 = @acumula_v ,
        acumulado = @acumula_v1 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 21 AND
  fecha = @fecha_0
  UPDATE #temp_res SET Monto_0 = @acumula_c + @acumula_v  ,
        acumulado = @acumula_c1 + @acumula_v1 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 23 AND
  fecha = @fecha_0
 -- Esto Para Sumar el Neto Acumulado
 SELECT   @acumula_c = 0
 SELECT   @acumula_v = 0
 SELECT @acumula_c = monto_0 
 FROM #temp_res 
 WHERE  posicion = 11 
 SELECT @acumula_v = monto_0 
 FROM #temp_res 
 WHERE  posicion = 22 
  UPDATE #temp_res SET Monto_0 = @acumula_c + @acumula_v
 FROM resultado ,
  #temp_res
 WHERE  posicion = 25 AND
  fecha = @fecha_0
 ----------------------
 -- Resultados UF Pesos
 ----------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_v1 = 0
 SELECT  @acumula_c = SUM(variacion_uf)  ,
         @acumula_v = SUM(devengo)  ,
         @acumula_c1 = SUM(neto_dia)  ,
  @acumula_uf = SUM(acumulado_uf)  ,
  @acumula_dev = SUM(acumulado_devengo) ,
  @acumula_net = SUM(acumulado_neto) ,
  @acumula_v1 = SUM(saldo_usd) 
 FROM resultado
 WHERE  fecha = @fecha_0 AND
  tipo LIKE '%998-999%'
  UPDATE #temp_res SET Monto_0 = @acumula_c 
 WHERE  posicion = 26
  UPDATE #temp_res SET Monto_0 = @acumula_v 
 WHERE  posicion = 27
  UPDATE #temp_res SET Monto_0 = @acumula_c1 
 WHERE  posicion = 28
 UPDATE #temp_res SET monto_0 = acumulado_neto 
 FROM resultado ,
  #temp_res
 WHERE  posicion = 29    AND
  tipo  = 'NETO-3' AND
  fecha = @fecha_0
 UPDATE #temp_res SET acumulado  = @acumula_uf 
 FROM #temp_res
 WHERE  posicion = 26
 UPDATE #temp_res SET acumulado  = @acumula_dev 
 FROM #temp_res
 WHERE  posicion = 27
 UPDATE #temp_res SET acumulado  = @acumula_net 
 FROM #temp_res
 WHERE  posicion = 28
  UPDATE #temp_res SET Monto_0 = @acumula_v1 
 WHERE  posicion = 34
 ------------------------------------
 -- Resultado Arbitrajes
 -----------------------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_c = SUM(variacion_tc) ,
  @acumula_c1 = SUM(acumulado_tc) ,
  @acumula_v = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_0 AND
  tipo LIKE '%M/X%'
  UPDATE #temp_res SET Monto_0 = @acumula_c 
 WHERE  posicion = 30
 UPDATE #temp_res SET monto_0 = acumulado_neto
 FROM resultado ,
  #temp_res
 WHERE  posicion = 31  AND
  tipo  = 'NETO-2'  AND
  fecha = @fecha_0
 UPDATE #temp_res SET acumulado = @acumula_c1
 FROM #temp_res
 WHERE  posicion = 30
  UPDATE #temp_res SET Monto_0 = @acumula_v
 WHERE  posicion = 35
 ----------------------------------------------------------
 -- Actualiza Total Forward
 ----------------------------------------------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_c = SUM(acumulado) 
 FROM  #temp_res
 WHERE  posicion = 23 OR
  posicion = 28 OR
  posicion = 30
 UPDATE #temp_res SET acumulado = @acumula_c
 FROM #temp_res
 WHERE  posicion = 32
 
 ----------------------------------------------------------
 -- Actualiza Stock USD Seguros de Cambio
 ----------------------------------------------------------
 SELECT  @acumula_c = 0
 SELECT  @acumula_c = SUM(monto_3) 
 FROM  #temp_res
 WHERE  posicion = 1   OR
  posicion = 5   OR
  posicion = 12  OR
  posicion = 16 
 UPDATE #temp_res SET monto_3 = @acumula_c
 FROM #temp_res
 WHERE  posicion = 33
 SELECT  @acumula_c = 0
 SELECT  @acumula_c = SUM(monto_2) 
 FROM  #temp_res
 WHERE  posicion = 1   OR
  posicion = 5   OR
  posicion = 12  OR
  posicion = 16 
 UPDATE #temp_res SET monto_2 = @acumula_c
 FROM #temp_res
 WHERE  posicion = 33
 SELECT  @acumula_c = 0
 SELECT  @acumula_c = SUM(monto_1) 
 FROM  #temp_res
 WHERE  posicion = 1   OR
  posicion = 5   OR
  posicion = 12  OR
  posicion = 16 
 UPDATE #temp_res SET monto_1 = @acumula_c
 FROM #temp_res
 WHERE  posicion = 33
 SELECT  @acumula_c = 0
 SELECT  @acumula_c = SUM(monto_0) 
 FROM  #temp_res
 WHERE  posicion = 1   OR
  posicion = 5   OR
  posicion = 12  OR
  posicion = 16 
 UPDATE #temp_res SET monto_0 = @acumula_c
 FROM #temp_res
 WHERE  posicion = 33
 ----------------------------------------------------------
 -- Actualiza Variación de Cartera
 ----------------------------------------------------------
 -- Dia 0
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_c = 0
 SELECT  @acumula_v1 = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_0 AND
  tipo LIKE '%C-13 -99%'
 SELECT  @acumula_c1 = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_1 AND
  tipo LIKE '%C-13 -99%'
 SELECT  @acumula_v = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_0 AND
  tipo LIKE '%V-13 -99%'
 SELECT  @acumula_v1 = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_1 AND
  tipo LIKE '%V-13 -99%'
 UPDATE #temp_res SET monto_0 = @acumula_c - @acumula_c1 
 FROM #temp_res
 WHERE  posicion = 36
 UPDATE #temp_res SET monto_0 = @acumula_v - @acumula_v1
 FROM #temp_res
 WHERE  posicion = 37
 UPDATE #temp_res SET monto_0 = ( @acumula_c - @acumula_c1 ) + ( @acumula_v - @acumula_v1 )
 FROM #temp_res
 WHERE  posicion = 38
 -- Dia 1
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_c = 0
 SELECT  @acumula_v1 = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_1 AND
  tipo LIKE '%C-13 -99%'
 SELECT  @acumula_c1 = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_2 AND
  tipo LIKE '%C-13 -99%'
 SELECT  @acumula_v = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_1 AND
  tipo LIKE '%V-13 -99%'
 SELECT  @acumula_v1 = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_2 AND
  tipo LIKE '%V-13 -99%'
 UPDATE #temp_res SET monto_1 = @acumula_c - @acumula_c1 
 FROM #temp_res
 WHERE  posicion = 36
 UPDATE #temp_res SET monto_1 = @acumula_v - @acumula_v1
 FROM #temp_res
 WHERE  posicion = 37
 UPDATE #temp_res SET monto_1 = ( @acumula_c - @acumula_c1 ) + ( @acumula_v - @acumula_v1 )
 FROM #temp_res
 WHERE  posicion = 38
 -- Dia 2
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_c = 0
 SELECT  @acumula_v1 = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_2 AND
  tipo LIKE '%C-13 -99%'
 SELECT  @acumula_c1 = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_3 AND
  tipo LIKE '%C-13 -99%'
 SELECT  @acumula_v = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_2 AND
  tipo LIKE '%V-13 -99%'
 SELECT  @acumula_v1 = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_3 AND
  tipo LIKE '%V-13 -99%'
 UPDATE #temp_res SET monto_2 = @acumula_c - @acumula_c1 
 FROM #temp_res
 WHERE  posicion = 36
 UPDATE #temp_res SET monto_2 = @acumula_v - @acumula_v1
 FROM #temp_res
 WHERE  posicion = 37
 UPDATE #temp_res SET monto_2 = ( @acumula_c - @acumula_c1 ) + ( @acumula_v - @acumula_v1 )
 FROM #temp_res
 WHERE  posicion = 38
 -- Dia 3
 SELECT  @acumula_c1 = 0
 SELECT  @acumula_c = 0
 SELECT  @acumula_v1 = 0
 SELECT  @acumula_v = 0
 SELECT  @acumula_c = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_3 AND
  tipo LIKE '%C-13 -99%'
 SELECT  @acumula_c1 = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_4 AND
  tipo LIKE '%C-13 -99%'
 SELECT  @acumula_v = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_3 AND
  tipo LIKE '%V-13 -99%'
 SELECT  @acumula_v1 = SUM(saldo_usd)
 FROM  resultado
 WHERE  fecha = @fecha_4 AND
  tipo LIKE '%V-13 -99%'
 UPDATE #temp_res SET monto_3 = @acumula_c - @acumula_c1 
 FROM #temp_res
 WHERE  posicion = 36
 UPDATE #temp_res SET monto_3 = @acumula_v - @acumula_v1
 FROM #temp_res
 WHERE  posicion = 37
 UPDATE #temp_res SET monto_3 = ( @acumula_c - @acumula_c1 ) + ( @acumula_v - @acumula_v1 )
 FROM #temp_res
 WHERE  posicion = 38
 ----------------------------------------------------------
 -- Actualiza Hora y Valores de Monedas
 ----------------------------------------------------------
  UPDATE #temp_res SET hora = CONVERT(CHAR(8),GETDATE(),108)
  UPDATE #temp_res SET fecha0    = CONVERT( CHAR(10) , @fecha_0 , 103 ) ,
        observado_0  = @observado_0  ,
        uf_0 = @uf_0
  UPDATE #temp_res SET fecha1    = CONVERT( CHAR(10) , @fecha_1 , 103 ) ,
                       observado_1  = @observado_1  ,
        uf_1 = @uf_1
  UPDATE #temp_res SET fecha2    = CONVERT( CHAR(10) , @fecha_2 , 103 ) ,
                       observado_2  = @observado_2  ,
        uf_2 = @uf_2
 UPDATE #temp_res SET fecha3    = CONVERT( CHAR(10) , @fecha_3 , 103 ) ,
                      observado_3  = @observado_3  ,
        uf_3 = @uf_3
update  #temp_res SET  entidad = @entidad
 SELECT * FROM #temp_res ORDER BY posicion
 DROP TABLE #temp_res
 SET NOCOUNT OFF
END

GO
