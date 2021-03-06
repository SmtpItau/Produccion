USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESULTADO_POSICION_1446]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RESULTADO_POSICION_1446]( @fecha_0 CHAR(8),
     @fecha_1   CHAR(8),
     @fecha_2   CHAR(8),
            @fecha_3   CHAR(8)
     )
AS BEGIN
 DECLARE @observado_3   NUMERIC(12,04)     ,
    @observado_2   NUMERIC(12,04)     ,
    @observado_1   NUMERIC(12,04)     ,
    @observado_0   NUMERIC(12,04)     ,
    @uf_3   NUMERIC(12,04)     ,
  @uf_2   NUMERIC(12,04)     ,
  @uf_1   NUMERIC(12,04)     ,
  @uf_0   NUMERIC(12,04)     ,
         @acumula       NUMERIC(21,00)      ,
         @acumula2      NUMERIC(21,00)      ,
         @resultado_dias NUMERIC(21,00)      ,
         @suma          NUMERIC(21,00)      ,
         @suma2         NUMERIC(21,00)      ,
         @tot           NUMERIC(19)      ,
  @entidad     char(40)
 SELECT @observado_3 = vmvalor , @entidad = acnomprop
 FROM view_valor_moneda,
  mfac
 WHERE accodmondolobs = vmcodigo AND
  @fecha_3 = vmfecha
 SELECT @observado_2 = vmvalor
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
  @fecha_0   = vmfecha
 CREATE TABLE #temp_res2( tipoc   CHAR(1)     ,
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
    hora  CHAR(8)              ,     
    entidad char(40)
 )  
 -- |-----------------------------------------------------------
 -- | Primero las Glosas de los Resultados a Desplegar
 -- |-----------------------------------------------------------
/*
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 1 , 'C-CAR-4  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 2 , 'C-CAR-4  ' , 'Resultado Var. T/C' ) 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 3 , 'C-CAR-4  ' , 'Resultado Var. U.F.')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 4 , 'C-CAR-4  ' , 'Devengo Dolares' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 5 , 'C-CAR-4  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 6 , 'C-CAR-4  ' , 'Devengo Pesos')         
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 7 , 'C-CAR-4  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 8 , 'V-CAR-4  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 9 , 'V-CAR-4  ' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 10 , 'V-CAR-4  ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 11 , 'V-CAR-4  ' , 'Devengo Dolares' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 12 , 'V-CAR-4  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 13 , 'V-CAR-4  ' , 'Devengo Pesos')  
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 14 , 'V-CAR-4  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 15 , 'NETO-4   ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 16 , 'NETO-4   ' , 'Res. Neto Acumulado Anual' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 17 , 'C-CAR-6  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 18 , 'C-CAR-6  ' , 'Resultado Var. T/C' ) 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 19 , 'C-CAR-6  ' , 'Resultado Var. U.F.') 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 20 , 'C-CAR-6  ' , 'Devengo Dolares' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 21 , 'C-CAR-6  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 22 , 'C-CAR-6  ' , 'Devengo Pesos')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 23 , 'C-CAR-6  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 24 , 'V-CAR-6  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 25 , 'V-CAR-6  ' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 26 , 'V-CAR-6  ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 27 , 'V-CAR-6  ' , 'Devengo Dolares' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 28 , 'V-CAR-6  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 29 , 'V-CAR-6  ' , 'Devengo Pesos')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 30 , 'V-CAR-6  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 31 , 'NETO-6   ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 32 , 'NETO-6   ' , 'Res. Neto Acumulado Anual' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 33 , 'O-CAR-5  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 34 , 'O-CAR-5  ' , 'Resultado Var. T/C' ) 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 35 , 'O-CAR-5  ' , 'Devengo')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 36 , 'O-CAR-5  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 37 , 'A-CAR-5  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 38 , 'A-CAR-5  ' , 'Resultado Var. T/C' ) 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 39 , 'A-CAR-5  ' , 'Devengo')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 40 , 'A-CAR-5  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 41 , 'NETO-5   ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 42 , 'NETO-5   ' , 'Res. Neto Acumulado Anual' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 43 , '         ' , 'RESULTADO SEGURO DE CAMBIO') 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 44 , '         ' , 'Resultado Del Dia')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 45 , '         ' , 'RESULTADO TOTAL')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 46 , '         ' , 'Resultado Del Dia')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 48 , '         ' , 'RESUMEN')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 49 , '         ' , 'Futuros con Futuros')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 50 , '         ' , '  ' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 51 , '         ' , 'Futuros con Otros')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 52 , '         ' , '  ' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 53 , '         ' , 'Operaciones Abiertas')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 54 , '         ' , '  ' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 55 , '         ' , 'TOTAL')  
*/
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 1 , 'C-CAR-4  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 2 , 'C-CAR-4  ' , 'Resultado Var. T/C' ) 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 3 , 'C-CAR-4  ' , 'Resultado Var. U.F.')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 4 , 'C-CAR-4  ' , 'Devengo Dolares' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 5 , 'C-CAR-4  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 6 , 'C-CAR-4  ' , 'Devengo Pesos')         
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 7 , 'C-CAR-4  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 8 , 'V-CAR-4  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 9 , 'V-CAR-4  ' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 10 , 'V-CAR-4  ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 11 , 'V-CAR-4  ' , 'Devengo Dolares' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 12 , 'V-CAR-4  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 13 , 'V-CAR-4  ' , 'Devengo Pesos')  
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 14 , 'V-CAR-4  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 15 , 'NETO-4   ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '4' , 16 , 'NETO-4   ' , 'Res. Neto Acumulado Anual' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 17 , 'C-CAR-6  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 18 , 'C-CAR-6  ' , 'Resultado Var. T/C' ) 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 19 , 'C-CAR-6  ' , 'Resultado Var. U.F.') 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 20 , 'C-CAR-6  ' , 'Devengo Dolares' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 21 , 'C-CAR-6  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 22 , 'C-CAR-6  ' , 'Devengo Pesos')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 23 , 'C-CAR-6  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 24 , 'V-CAR-6  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 25 , 'V-CAR-6  ' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 26 , 'V-CAR-6  ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 27 , 'V-CAR-6  ' , 'Devengo Dolares' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 28 , 'V-CAR-6  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 29 , 'V-CAR-6  ' , 'Devengo Pesos')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 30 , 'V-CAR-6  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 31 , 'NETO-6   ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '6' , 32 , 'NETO-6   ' , 'Res. Neto Acumulado Anual' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 33 , 'O-CAR-5  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 34 , 'O-CAR-5  ' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 35 , 'O-CAR-5  ' , 'Resultado Var. U.F.' ) 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 36 , 'O-CAR-5  ' , 'Devengo Dólares')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 37 , 'O-CAR-5  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 38 , 'O-CAR-5  ' , 'Devengo Pesos')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 39 , 'O-CAR-5  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 40 , 'A-CAR-5  ' , 'Saldo Dólares' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 41 , 'A-CAR-5  ' , 'Resultado Var. T/C' ) 
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 42 , 'A-CAR-5  ' , 'Resultado Var. U.F.' ) 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 43 , 'A-CAR-5  ' , 'Devengo Dólares')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 44 , 'A-CAR-5  ' , 'Devengo U.F.')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 45 , 'A-CAR-5  ' , 'Devengo Pesos')
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 46 , 'A-CAR-5  ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 47 , 'NETO-5   ' , 'Resultado Neto del Día' )
 INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( '5' , 48 , 'NETO-5   ' , 'Res. Neto Acumulado Anual' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 49 , '         ' , 'RESULTADO SEGURO DE CAMBIO') 
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 50 , '         ' , 'Resultado Del Dia')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 51 , '         ' , 'RESULTADO TOTAL')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 52 , '         ' , 'Resultado Del Dia')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 54 , '         ' , 'RESUMEN')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 55 , '         ' , 'Futuros con Futuros')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 56 , '         ' , '  ' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 57 , '         ' , 'Futuros con Otros')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 58 , '         ' , '  ' )
  INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 59 , '         ' , 'Operaciones Abiertas')
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 60 , '         ' , '  ' )
        INSERT INTO #temp_res2( tipoc , posicion , llave , Glosa ) VALUES ( ' ' , 61 , '         ' , 'TOTAL')
 -- |---------------------------------------
 -- | Actualiza los Valores Día 3
 -- |---------------------------------------
 UPDATE #temp_res2 SET monto_3 = saldo_usd ,
        fecha3  = @fecha_3 
 FROM resultado ,
  #temp_res2
 WHERE  (posicion = 1  OR
                posicion = 8  OR 
                posicion = 17  OR 
                posicion = 24  OR 
                posicion = 33  OR                 
  posicion = 40 ) AND
  tipo  = llave AND
  fecha = @fecha_3 
  UPDATE #temp_res2 SET Monto_3 = variacion_tc,
        fecha3  = @fecha_3 
 FROM resultado ,
  #temp_res2
        WHERE  (posicion = 2  OR
                posicion  = 9  OR 
                posicion  = 18 OR 
                posicion  = 25 OR 
                posicion  = 34 OR  
  posicion  = 41 ) AND
  tipo  = llave  AND
  fecha = @fecha_3 
 UPDATE #temp_res2 SET Monto_3 = variacion_uf,
        fecha3  = @fecha_3 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 3 OR
                        posicion = 10 OR
                        posicion = 19 OR                        
   posicion = 26 OR
                        posicion = 35 OR
   posicion = 42 ) AND
   tipo  = llave AND
   fecha = @fecha_3
  UPDATE #temp_res2 SET Monto_3 = devengo ,
        fecha3  = @fecha_3 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 4    OR
   posicion = 11   OR
   posicion = 20   OR
                        posicion = 27   OR 
                        posicion = 36   OR
   posicion = 43 ) AND
   tipo  = llave AND
   fecha = @fecha_3
-- cambios
       UPDATE #temp_res2 SET  Monto_3  = devengo_uf ,
                             fecha3 = @fecha_3    
       FROM resultado,
            #temp_res2      
       WHERE  ( posicion = 5 OR
                posicion = 12 OR 
                posicion = 21 OR
  posicion = 28 OR
                posicion = 37 OR
  posicion = 44 ) AND
                tipo     = llave   AND
                fecha    = @fecha_3                 
        UPDATE #temp_res2 SET Monto_3 = devengo_pesos ,
                             fecha3  = @fecha_3      
        FROM resultado,
             #temp_res2        
        WHERE ( posicion  = 6 OR
                posicion = 13 OR
                posicion = 22 OR 
                posicion = 29 OR
  posicion = 38 OR
                posicion = 45   ) AND
                tipo = llave  AND
                fecha = @fecha_3 
--------------------------------------------------------------------------------------------
  UPDATE #temp_res2 SET Monto_3     = neto_dia    ,
        fecha3      = @fecha_3 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 7  OR
   posicion = 14 OR
   posicion = 23 OR
   posicion = 30 OR
   posicion = 39 OR
   posicion = 46 ) AND
   tipo  = llave AND
   fecha = @fecha_3
  UPDATE #temp_res2 SET Monto_3 = acumulado_neto,
        fecha3  = @fecha_3 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 16   OR
   posicion = 32   OR 
   posicion = 48 ) AND
   tipo  = llave AND
   fecha = @fecha_3
-- Suma el Neto del Día
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_3 
 FROM     #temp_res2 
 WHERE   posicion = 7 
 SELECT   @acumula = @acumula + monto_3 
 FROM     #temp_res2 
 WHERE    posicion = 14 
 
  UPDATE #temp_res2 SET Monto_3 = @acumula ,
        fecha3  = @fecha_3 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 15 AND 
  fecha = @fecha_3
              
-- Suma Hedge
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_3 
 FROM     #temp_res2 
 WHERE   posicion = 23
 SELECT   @acumula = @acumula + monto_3 
 FROM     #temp_res2 
 WHERE    posicion = 30 
 
  UPDATE #temp_res2 SET Monto_3 = @acumula ,
        fecha3  = @fecha_3 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 31 AND 
  fecha = @fecha_3
-- Suma 1446
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_3 
 FROM     #temp_res2 
 WHERE   posicion = 39
 SELECT   @acumula = @acumula + monto_3 
 FROM     #temp_res2 
 WHERE    posicion = 46
 
  UPDATE #temp_res2 SET Monto_3 = @acumula ,
        fecha3  = @fecha_3 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 47 AND 
  fecha = @fecha_3
--¦------------------------------------------------------------------------------------------------------------------------
--¦----------------------------------------TOTALES CALCE-------------------------------------------------------------------
--¦------------------------------------------------------------------------------------------------------------------------
-- FUTUROS CON FUTUROS
select @suma = 0
select @suma = (select neto_dia from resultado_calce where fecha = @fecha_3 and tipo = '1  -1')
UPDATE #temp_res2 set  monto_3 = @suma,
       fecha3  = @fecha_3 
from #temp_res2
where posicion = 55
-- FUTUROS CON OTROS
select @suma = 0
select @suma = (select sum(neto_dia) from resultado_calce 
where fecha = @fecha_3 and 
      (tipo like '%  -1'  or
       tipo like '1  -%'  or
       tipo = '3  -3'     or
       tipo = '5  -5'     or    
       tipo = '5  -4'     or 
       tipo = '4  -5'     or    
       tipo = '4  -4')    and 
       tipo not like '%1  -1%')
update #temp_res2 set monto_3 = @suma ,
                     fecha3 = @fecha_3
from #temp_res2 
where posicion = 57
-- OPERACIONES ABIERTAS
select @suma = 0
select @suma = (select sum(neto_dia) from resultado_calce where fecha = @fecha_3 and (tipo like 'C%' or tipo like 'V%') AND ( tipo <> 'C-3  -999' AND tipo <> 'V-3  -999' ) )
update #temp_res2 set monto_3 = @suma,
                      fecha3 = @fecha_3
from #temp_res2
where posicion = 59
-- TOTAL
SELECT @suma = 0
SELECT @suma = (SELECT SUM(MONTO_3) FROM #temp_res2 where posicion = 55 or posicion = 57 or posicion = 59)
update #temp_res2 set monto_3 = @suma,
                      fecha3 = @fecha_3
where posicion = 61
     
        
-- |---------------------------------------
-- | Actualiza los Valores Día 2
-- |---------------------------------------
 UPDATE #temp_res2 SET monto_2 = saldo_usd ,
        fecha2  = @fecha_2 
 FROM resultado ,
  #temp_res2
 WHERE  (posicion = 1  OR
                posicion = 8  OR 
                posicion = 17  OR 
                posicion = 24  OR 
                posicion = 33  OR               
  posicion = 40 ) AND
  tipo  = llave AND
  fecha = @fecha_2 
  UPDATE #temp_res2 SET Monto_2 = variacion_tc,
        fecha2  = @fecha_2 
 FROM resultado ,
  #temp_res2
        WHERE  (posicion = 2  OR
                posicion  = 9  OR 
                posicion  = 18 OR 
                posicion  = 25 OR 
                posicion  = 34 OR  
  posicion  = 41 ) AND
  tipo  = llave  AND
  fecha = @fecha_2 
 UPDATE #temp_res2 SET Monto_2 = variacion_uf,
        fecha2  = @fecha_2 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 3 OR
                        posicion = 10 OR
                        posicion = 19 OR                        
   posicion = 26 OR 
                        posicion = 35 OR
                        posicion = 42  ) AND
   tipo  = llave AND
   fecha = @fecha_2
  UPDATE #temp_res2 SET Monto_2 = devengo ,
        fecha2  = @fecha_2 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 4    OR
   posicion = 11   OR
   posicion = 20   OR
                        posicion = 27   OR 
                        posicion = 36   OR
   posicion = 43 ) AND
   tipo  = llave AND
   fecha = @fecha_2
-- cambios
       UPDATE #temp_res2 SET Monto_2  = devengo_uf,
                             fecha2 = @fecha_2    
       FROM resultado,
            #temp_res2
       WHERE  ( posicion = 5 OR
                posicion = 12 OR 
                posicion = 21 OR
                posicion = 28 OR 
  posicion = 37 OR 
  posicion = 44 ) AND
                tipo = llave   AND
                fecha = @fecha_2                 
        UPDATE #temp_res2 SET Monto_2 = devengo_pesos,
                             fecha2  = @fecha_2     
        FROM resultado,
             #temp_res2        
        WHERE ( posicion  = 6 OR
                posicion = 13 OR
                posicion = 22 OR 
                posicion = 29 OR 
  posicion = 38 OR
  posicion = 45 ) AND
                tipo = llave  AND
                fecha = @fecha_2   
--------------------------------------------------------------------------------------------
  UPDATE #temp_res2 SET Monto_2     = neto_dia     ,
        fecha2      = @fecha_2 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 7  OR
   posicion = 14 OR
   posicion = 23 OR
   posicion = 30 OR
   posicion = 39 OR
   posicion = 46 ) AND
   tipo  = llave AND
   fecha = @fecha_2
  UPDATE #temp_res2 SET Monto_2 = acumulado_neto,
        fecha2  = @fecha_2 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 16   OR
   posicion = 32   OR 
   posicion = 48 ) AND
   tipo  = llave AND
   fecha = @fecha_2
-- Suma el Neto del Día
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_2 
 FROM     #temp_res2 
 WHERE   posicion = 7 
 SELECT   @acumula = @acumula + monto_2 
 FROM     #temp_res2 
 WHERE    posicion = 14 
 
  UPDATE #temp_res2 SET Monto_2 = @acumula ,
        fecha2  = @fecha_2 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 15 AND 
  fecha = @fecha_2
-- Suma Hedge
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_2 
 FROM     #temp_res2 
 WHERE   posicion = 23
 SELECT   @acumula = @acumula + monto_2 
 FROM     #temp_res2 
 WHERE    posicion = 30 
 
  UPDATE #temp_res2 SET Monto_2 = @acumula ,
        fecha2  = @fecha_2 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 31 AND 
  fecha = @fecha_2
-- Suma 1446
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_2 
 FROM     #temp_res2 
 WHERE   posicion = 39
 SELECT   @acumula = @acumula + monto_2 
 FROM     #temp_res2 
 WHERE    posicion = 46
 
  UPDATE #temp_res2 SET Monto_2 = @acumula ,
        fecha2  = @fecha_2 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 47 AND 
  fecha = @fecha_2
--¦------------------------------------------------------------------------------------------------------------------------
--¦----------------------------------------TOTALES CALCE-------------------------------------------------------------------
--¦------------------------------------------------------------------------------------------------------------------------
-- FUTUROS CON FUTUROS
select @suma = 0
select @suma = (select neto_dia from resultado_calce where fecha = @fecha_2 and tipo = '1  -1')
UPDATE #temp_res2 set  monto_2 = @suma,
       fecha3  = @fecha_2 
from #temp_res2
where posicion = 55
-- FUTUROS CON OTROS
select @suma = 0
select @suma = (select sum(neto_dia) from resultado_calce 
where fecha = @fecha_2  and 
      (tipo like '%  -1'  or
       tipo like '1  -%'  or
       tipo = '3  -3'     or
       tipo = '5  -5'     or    
       tipo = '5  -4'     or 
       tipo = '4  -5'     or    
       tipo = '4  -4')    and 
       tipo not like '%1  -1%')
update #temp_res2 set monto_2 = @suma ,
                     fecha2 = @fecha_2
from #temp_res2 
where posicion = 57
-- OPERACIONES ABIERTAS
select @suma = 0
select @suma = (select sum(neto_dia) from resultado_calce where fecha = @fecha_2 and (tipo like 'C%' or tipo like 'V%') AND ( tipo <> 'C-3  -999' AND tipo <> 'V-3  -999' ) )
update #temp_res2 set monto_2 = @suma,
                      fecha2 = @fecha_2
from #temp_res2
where posicion = 59
-- TOTAL
SELECT @suma = 0
SELECT @suma = (SELECT SUM(MONTO_2) FROM #temp_res2 where posicion = 55 or posicion = 57 or posicion = 59 )
update #temp_res2 set monto_2 = @suma,
                      fecha2 = @fecha_2
where posicion = 61
-- |---------------------------------------
-- | Actualiza los Valores Día 1
-- |---------------------------------------
 UPDATE #temp_res2 SET monto_1 = saldo_usd ,
        fecha1  = @fecha_1 
 FROM resultado ,
  #temp_res2
 WHERE  (posicion = 1  OR
                posicion = 8  OR 
                posicion = 17  OR 
                posicion = 24  OR 
                posicion = 33  OR 
  posicion = 40 ) AND
  tipo  = llave AND
  fecha = @fecha_1 
  UPDATE #temp_res2 SET Monto_1 = variacion_tc,
        fecha1  = @fecha_1 
 FROM resultado ,
  #temp_res2
        WHERE  (posicion = 2  OR
                posicion  = 9  OR 
                posicion  = 18 OR 
                posicion  = 25 OR 
                posicion  = 34 OR 
  posicion  = 41 ) AND
  tipo  = llave  AND
  fecha = @fecha_1 
 UPDATE #temp_res2 SET Monto_1 = variacion_uf,
        fecha1  = @fecha_1 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 3 OR
                        posicion = 10 OR
                        posicion = 19 OR                        
   posicion = 26 OR 
   posicion = 35 OR
   posicion = 42  ) AND
   tipo  = llave AND
   fecha = @fecha_1
  UPDATE #temp_res2 SET Monto_1 = devengo ,
        fecha1  = @fecha_1 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 4    OR
   posicion = 11   OR
   posicion = 20   OR
                        posicion = 27   OR 
   posicion = 36   OR
   posicion = 43 ) AND
   tipo  = llave AND
   fecha = @fecha_1
-- cambios
       UPDATE #temp_res2 SET Monto_1  = devengo_uf ,
                             fecha1 = @fecha_1    
       FROM resultado ,
            #temp_res2        
       WHERE  ( posicion = 5 OR
                posicion = 12 OR 
                posicion = 21 OR
                posicion = 28 OR
  posicion = 37 OR
  posicion = 44   ) AND
                tipo = llave   AND
                fecha = @fecha_1                 
        UPDATE #temp_res2 SET Monto_1 = devengo_pesos ,
                             fecha1  = @fecha_1     
        FROM resultado,
             #temp_res2        
        WHERE ( posicion  = 6 OR
                posicion = 13 OR
                posicion = 22 OR 
                posicion = 29 OR
  posicion = 38 OR 
  posicion = 45 ) AND
                tipo = llave  AND
                fecha = @fecha_1   
--------------------------------------------------------------------------------------------
  UPDATE #temp_res2 SET Monto_1     = neto_dia     ,
        fecha1      = @fecha_1 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 7  OR
   posicion = 14 OR
   posicion = 23 OR
   posicion = 30 OR
   posicion = 39 OR
   posicion = 46 ) AND
   tipo  = llave AND
   fecha = @fecha_1
  UPDATE #temp_res2 SET Monto_1 = acumulado_neto,
        fecha1  = @fecha_1 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 16   OR
   posicion = 32   OR 
   posicion = 48 ) AND
   tipo  = llave AND
   fecha = @fecha_1
-- Suma el Neto del Día
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_1 
 FROM     #temp_res2 
 WHERE   posicion = 7 
 SELECT   @acumula = @acumula + Monto_1 
 FROM     #temp_res2 
 WHERE    posicion = 14 
 
  UPDATE #temp_res2 SET Monto_1 = @acumula ,
        fecha1  = @fecha_1 
        FROM resultado ,
  #temp_res2
 WHERE  posicion = 15 AND 
  fecha = @fecha_1
-- Suma Hedge
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_1 
 FROM     #temp_res2 
 WHERE   posicion = 23
 SELECT   @acumula = @acumula + monto_1 
 FROM     #temp_res2 
 WHERE    posicion = 30 
 
  UPDATE #temp_res2 SET Monto_1 = @acumula ,
        fecha1  = @fecha_1 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 31 AND 
  fecha = @fecha_1
-- Suma 1446
 SELECT   @acumula = 0
 SELECT   @acumula = Monto_1 
 FROM     #temp_res2 
 WHERE   posicion = 39
 SELECT   @acumula = @acumula + monto_1 
 FROM     #temp_res2 
 WHERE    posicion = 46
 
  UPDATE #temp_res2 SET Monto_1 = @acumula ,
        fecha1  = @fecha_1 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 47 AND 
  fecha = @fecha_1
--¦------------------------------------------------------------------------------------------------------------------------
--¦----------------------------------------TOTALES CALCE-------------------------------------------------------------------
--¦------------------------------------------------------------------------------------------------------------------------
-- FUTUROS CON FUTUROS
select @suma = 0
select @suma = (select neto_dia from resultado_calce where fecha = @fecha_1 and tipo = '1  -1')
UPDATE #temp_res2 set  monto_1 = @suma,
       fecha1  = @fecha_1 
from #temp_res2
where posicion = 55
-- FUTUROS CON OTROS
select @suma = 0
select @suma = (select sum(neto_dia) from resultado_calce 
where fecha = @fecha_1  and 
      (tipo like '%  -1'  or
       tipo like '1  -%'  or
       tipo = '3  -3'     or
       tipo = '5  -5'     or    
       tipo = '5  -4'     or 
       tipo = '4  -5'     or    
       tipo = '4  -4')    and 
       tipo not like '%1  -1%')
update #temp_res2 set monto_1 = @suma ,
                     fecha1 = @fecha_1 
from #temp_res2 
where posicion = 57
-- OPERACIONES ABIERTAS
select @suma = 0
select @suma = (select sum(neto_dia) from resultado_calce where fecha = @fecha_1 and (tipo like 'C%' or tipo like 'V%') AND ( tipo <> 'C-3  -999' AND tipo <> 'V-3  -999' ) )
update #temp_res2 set monto_1 = @suma,
                      fecha1 = @fecha_1
from #temp_res2
where posicion = 59
-- TOTAL
SELECT @suma = 0
SELECT @suma = (SELECT SUM(MONTO_1) FROM #temp_res2 where posicion = 55 or posicion = 57 or posicion = 59 )
update #temp_res2 set monto_1 = @suma,
                      fecha1 = @fecha_1
where posicion = 61
-- |---------------------------------------
-- | Actualiza los Valores Día de Hoy
-- |---------------------------------------
 UPDATE #temp_res2 SET monto_0 = saldo_usd ,
        fecha0  = @fecha_0 
 FROM resultado ,
  #temp_res2
 WHERE  (posicion = 1  OR
                posicion = 8  OR 
                posicion = 17  OR 
                posicion = 24  OR 
                posicion = 33  OR 
  posicion = 40  ) AND
  tipo  = llave AND
  fecha = @fecha_0 
  UPDATE #temp_res2 SET Monto_0 = variacion_tc,
        fecha0  = @fecha_0 
 FROM resultado ,
  #temp_res2
        WHERE  (posicion = 2  OR
                posicion  = 9  OR 
                posicion  = 18 OR 
                posicion  = 25 OR 
                posicion  = 34 OR 
  posicion  = 41 ) AND
  tipo  = llave  AND
  fecha = @fecha_0 
 UPDATE #temp_res2 SET Monto_0 = variacion_uf,
        fecha0  = @fecha_0 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 3 OR
                        posicion = 10 OR
                        posicion = 19 OR
   posicion = 26 OR 
   posicion = 35 OR 
   posicion = 42 ) AND
   tipo  = llave AND
   fecha = @fecha_0
  UPDATE #temp_res2 SET Monto_0 = devengo ,
        fecha0  = @fecha_0 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 4    OR
   posicion = 11   OR
   posicion = 20   OR
                        posicion = 27   OR
                        posicion = 36   OR
   posicion = 43 ) AND
   tipo  = llave AND
   fecha = @fecha_0
-- cambios
       UPDATE #temp_res2 SET Monto_0  = devengo_uf,
                             fecha0 = @fecha_0    
       FROM resultado,
            #temp_res2        
       WHERE  ( posicion = 5 OR
                posicion = 12 OR 
                posicion = 21 OR
                posicion = 28 OR 
  posicion = 37 OR 
  posicion = 44 ) AND
                tipo = llave   AND
                fecha = @fecha_0                 
        UPDATE #temp_res2 SET Monto_0 = devengo_pesos,
                             fecha0  = @fecha_0     
        FROM resultado,
             #temp_res2        
        WHERE ( posicion  = 6 OR
                posicion = 13 OR
                posicion = 22 OR 
                posicion = 29 OR 
  posicion = 38 OR 
  posicion = 45 ) AND
                tipo = llave  AND
                fecha = @fecha_0   
--------------------------------------------------------------------------------------------
  UPDATE #temp_res2 SET Monto_0    = neto_dia     ,
        fecha0      = @fecha_0 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 7  OR
   posicion = 14 OR
   posicion = 23 OR
   posicion = 30 OR
   posicion = 39 OR
   posicion = 46 ) AND
   tipo  = llave AND
   fecha = @fecha_0
  UPDATE #temp_res2 SET Monto_0 = acumulado_neto,
        fecha0  = @fecha_0 
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 16   OR
   posicion = 32   OR 
   posicion = 48 ) AND
   tipo  = llave AND
   fecha = @fecha_0
-- acumulado tc
  UPDATE #temp_res2 SET acumulado = acumulado_tc
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 2  OR
   posicion = 9  OR
   posicion = 18 OR
     posicion = 25 OR
   posicion = 34 OR
   posicion = 41 ) AND
   tipo  = llave AND
   fecha = @fecha_0
-- acumulado uf
  UPDATE #temp_res2 SET acumulado = acumulado_uf
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 3  OR
   posicion = 10 OR
   posicion = 19 OR
     posicion = 26 OR 
   posicion = 35 OR 
   posicion = 42 ) AND
   tipo  = llave AND
   fecha = @fecha_0
-- acumulado devengo dolares
  UPDATE #temp_res2 SET acumulado = acumulado_devengo
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 4  OR
   posicion = 11 OR
   posicion = 20 OR
     posicion = 27 OR
   posicion = 36 OR
   posicion = 43 ) AND
   tipo  = llave AND
   fecha = @fecha_0
-- acumulado devengo uf
  UPDATE #temp_res2 SET acumulado = acumulado_devengo_uf
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 5  OR
   posicion = 12 OR
   posicion = 21 OR
     posicion = 28 OR 
   posicion = 37 OR
   posicion = 44 ) AND
   tipo  = llave AND
   fecha = @fecha_0
-- acumulado devengo pesos
  UPDATE #temp_res2 SET acumulado = acumulado_devengo_pesos
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 6  OR
   posicion = 13 OR
   posicion = 22 OR
     posicion = 29 OR 
   posicion = 38 OR 
   posicion = 45  ) AND
   tipo  = llave AND
   fecha = @fecha_0
-- acumulado devengo neto
  UPDATE #temp_res2 SET acumulado = acumulado_neto
 FROM resultado ,
  #temp_res2
 WHERE  (  posicion = 7  OR
   posicion = 14 OR
   posicion = 23 OR
     posicion = 30 OR
   posicion = 39 OR
   posicion = 46 ) AND
   tipo  = llave AND
   fecha = @fecha_0
-- Suma el Neto del Día
 SELECT   @acumula = 0
        SELECT   @acumula2 = 0
        SELECT   @acumula = Monto_0 , @acumula2 = acumulado
 FROM     #temp_res2 
 WHERE   posicion = 7 
 SELECT   @acumula = @acumula + monto_0 , @acumula2 = @acumula2 + acumulado
 FROM     #temp_res2 
 WHERE    posicion = 14 
 
  UPDATE #temp_res2 SET Monto_0 = @acumula ,
                             acumulado = @acumula2 ,
        fecha0  = @fecha_0 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 15 AND 
  fecha = @fecha_0
-- Suma Hedge
 SELECT   @acumula = 0 
        SELECT   @acumula2 = 0
 SELECT   @acumula = Monto_0 , @acumula2 = acumulado
 FROM     #temp_res2 
 WHERE   posicion = 23
 SELECT   @acumula = @acumula + monto_0 , @acumula2 = @acumula2 + acumulado
 FROM     #temp_res2 
 WHERE    posicion = 30 
 
  UPDATE #temp_res2 SET Monto_0 = @acumula  ,
                              acumulado = @acumula2  , 
                              fecha0  = @fecha_0 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 31 AND 
  fecha = @fecha_0
-- Suma 1446
 SELECT   @acumula = 0 
        SELECT   @acumula2 = 0 
 SELECT   @acumula = Monto_0 , @acumula2  = acumulado
 FROM     #temp_res2 
 WHERE   posicion = 39
 SELECT   @acumula = @acumula + monto_0 , @acumula2 = @acumula2 + acumulado
 FROM     #temp_res2 
 WHERE    posicion = 46
 
  UPDATE #temp_res2 SET Monto_0 = @acumula ,
                             acumulado = @acumula2 , 
        fecha0  = @fecha_0 
 FROM resultado ,
  #temp_res2
 WHERE  posicion = 47 AND 
  fecha = @fecha_0
  UPDATE #temp_res2 SET hora = CONVERT(CHAR(8),GETDATE(),108)
--- total final monto 3 
 SELECT @resultado_dias = SUM(neto_dia)
 FROM  resultado      
 WHERE  fecha = @fecha_3  and
        tipo LIKE '%13 -99%'
 
 UPDATE #temp_res2 SET monto_3 = @resultado_dias                                    
 FROM   #temp_res2         
 WHERE  posicion = 50
-- total 3
SELECT @suma = 0 
SELECT @suma2 = 0
SELECT @tot= 0 
SELECT @suma = SUM (neto_dia) 
FROM resultado 
WHERE tipo like '%car-%' and 
     fecha = @fecha_3
SELECT @suma2 = monto_3 FROM #temp_res2 WHERE posicion = 50
SELECT @tot = (@suma + @suma2)
UPDATE #temp_res2 SET monto_3 = @tot
FROM #temp_res2 
WHERE posicion = 52
-- total final monto 2
SELECT @resultado_dias = 0 
SELECT @resultado_dias = sum(neto_dia)
FROM resultado
WHERE  fecha = @fecha_2 and 
       tipo like '%13 -99%'
UPDATE #temp_res2 SET monto_2  = @resultado_dias
FROM #temp_res2
WHERE  posicion = 50
-- total 2
SELECT @suma = 0 
SELECT @suma2 = 0 
SELECT @tot= 0
SELECT @suma = SUM (neto_dia) 
FROM resultado 
WHERE tipo like '%car-%' and 
     fecha = @fecha_2
SELECT @suma2 = monto_2 FROM #temp_res2 WHERE posicion = 50
SELECT @tot = (@suma + @suma2)
UPDATE #temp_res2 SET monto_2 = @tot
FROM #temp_res2 
WHERE posicion = 52
-- total final monto 1
SELECT @resultado_dias = 0 
SELECT @resultado_dias = SUM(neto_dia)
FROM resultado
WHERE  fecha = @fecha_1 and 
       tipo like '%13 -99%'
UPDATE #temp_res2 SET monto_1  = @resultado_dias
FROM #temp_res2
WHERE  posicion = 50
-- total 1
SELECT @suma = 0 
SELECT @suma2 = 0 
SELECT @tot= 0
SELECT @suma = SUM (neto_dia) 
FROM resultado 
WHERE tipo like '%car-%' and 
     fecha = @fecha_1
SELECT @suma2 = monto_1 FROM #temp_res2 WHERE posicion = 50
SELECT @tot = (@suma + @suma2)
UPDATE #temp_res2 SET monto_1 = @tot
FROM #temp_res2 
WHERE posicion = 52
-- total final monto 0
SELECT @resultado_dias = 0 
SELECT @resultado_dias = sum(neto_dia)
FROM resultado
WHERE  fecha = @fecha_0 and 
       tipo like '%13 -99%'
UPDATE #temp_res2 SET monto_0  = @resultado_dias
FROM #temp_res2
WHERE  posicion = 50
-- total 0
select @suma = 0 
select @suma2 = 0 
select @tot= 0
select @suma = sum (neto_dia) 
from resultado 
where tipo like '%car-%' and 
     fecha = @fecha_0
SELECT @suma2 = monto_0 FROM #temp_res2 WHERE posicion = 50
select @tot = (@suma + @suma2)
update #temp_res2 set monto_0 = @tot
FROM #temp_res2 
WHERE posicion = 52
-- total acumulado
SELECT @resultado_dias = 0 
SELECT @resultado_dias = sum(acumulado_neto)
FROM resultado
WHERE  fecha = @fecha_0 and 
       tipo like '%13 -99%'
UPDATE #temp_res2 SET acumulado  = @resultado_dias
FROM #temp_res2
WHERE  posicion = 50
-- total final acumulado
SELECT @suma = 0
SELECT @suma= sum (acumulado)
FROM #temp_res2    
WHERE (posicion = 15 or
      posicion = 31 or 
      posicion = 47 ) 
SELECT @suma2= 0
SELECT @tot = 0
SELECT @suma2 = acumulado FROM #temp_res2 WHERE posicion = 50
SELECT @tot = (@suma + @suma2)
UPDATE #temp_res2 SET acumulado = @tot
FROM #temp_res2,
     resultado  
WHERE posicion = 52 and
      fecha = @fecha_0
--¦------------------------------------------------------------------------------------------------------------------------
--¦----------------------------------------TOTALES CALCE-------------------------------------------------------------------
--¦------------------------------------------------------------------------------------------------------------------------
-- FUTUROS CON FUTUROS
select @suma = 0
select @suma = (select neto_dia from resultado_calce where fecha = @fecha_0 and tipo = '1  -1')
UPDATE #temp_res2 set  monto_0 = @suma,
   fecha0  = @fecha_0 
from #temp_res2
where posicion = 55
-- FUTUROS CON OTROS
select @suma = 0
select @suma = (select sum(neto_dia) from resultado_calce 
where fecha = @fecha_0 and 
      (tipo like '%  -1'  or
       tipo like '1  -%'  or
       tipo = '3  -3'     or
       tipo = '5  -5'     or    
       tipo = '5  -4'     or 
       tipo = '4  -5'     or    
       tipo = '4  -4')    and 
       tipo not like '%1  -1%')
update #temp_res2 set monto_0 = @suma ,
                     fecha0 = @fecha_0
from #temp_res2 
where posicion = 57
-- Operaciones Abiertas
select @suma = 0
select @suma = (select sum(neto_dia) from resultado_calce where fecha = @fecha_0 and (tipo like 'C%' or tipo like 'V%') AND ( tipo <> 'C-3  -999' AND tipo <> 'V-3  -999' ) )
update #temp_res2 set monto_0 = @suma,
                      fecha0 = @fecha_0
from #temp_res2
where posicion = 59
-- TOTAL
SELECT @suma = 0
SELECT @suma = (SELECT SUM(MONTO_0) FROM #temp_res2 where posicion = 55 or posicion = 57 or posicion = 59 )
update #temp_res2 set monto_0 = @suma,
                      fecha0 = @fecha_0
where posicion = 61
-------------------------------------- acumulados del calce -----------------------
select @suma = 0
select @suma = (select neto_acumulado from resultado_calce where fecha = @fecha_0 and tipo = '1  -1')
UPDATE #temp_res2 set  acumulado = @suma,
       fecha0  = @fecha_0 
from #temp_res2
where posicion = 55
-------------------------------------------------------------------------------
select @suma = 0
select @suma = (select sum(neto_acumulado) from resultado_calce 
where fecha = @fecha_0 and 
      (tipo like '%  -1'  or
       tipo like '1  -%'  or
       tipo = '3  -3'     or
       tipo = '5  -5'     or    
       tipo = '5  -4'     or 
       tipo = '4  -5'     or    
       tipo = '4  -4')    and 
       tipo not like '%1  -1%')
update #temp_res2 set acumulado = @suma ,
                     fecha0 = @fecha_0
from #temp_res2 
where posicion = 57
--------------------------------------------------------------------------------------------------------
select @suma = 0
select @suma = (select sum(neto_acumulado) from resultado_calce where fecha = @fecha_0 and (tipo like 'C%' or tipo like 'V%') AND ( tipo <> 'C-3  -999' AND tipo <> 'V-3  -999' ) )
update #temp_res2 set acumulado = @suma,
                      fecha0 = @fecha_0
from #temp_res2
where posicion = 59
--------------------------------------------------------------------------------------------------------
SELECT @suma = 0
SELECT @suma = (SELECT SUM(MONTO_0) FROM #temp_res2 where posicion = 55 or posicion = 57 or posicion = 59 )
update #temp_res2 set monto_0 = @suma,
                      fecha0 = @fecha_0
where posicion = 61
---------------------------------------------------------------------------------------------------------
SELECT @suma = 0
SELECT @suma = (SELECT SUM(acumulado) FROM #temp_res2 where posicion = 55 or posicion = 57 or posicion = 59 )
update #temp_res2 set acumulado = @suma,
                      fecha0 = @fecha_0
where posicion = 61
UPDATE  #temp_res2 
SET   observado_3   = @observado_3  ,
  observado_2   = @observado_2  ,
  observado_1   = @observado_1  ,
  observado_0   = @observado_0  ,
  uf_3    = @uf_3   ,
  uf_2    = @uf_2   ,
  uf_1     = @uf_1   ,
  uf_0    = @uf_0   ,
 entidad  = @entidad
 SELECT * FROM #temp_res2 ORDER BY posicion
 DROP TABLE #temp_res2         
END

GO
