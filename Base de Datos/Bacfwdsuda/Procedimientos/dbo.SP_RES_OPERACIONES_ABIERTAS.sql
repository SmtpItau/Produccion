USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RES_OPERACIONES_ABIERTAS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RES_OPERACIONES_ABIERTAS]( @fecha CHAR(8))
AS BEGIN
 DECLARE @observado2     NUMERIC(12,04)     ,
                @acumula        NUMERIC(21,00)      ,
                @acumula2       NUMERIC(21,00)      ,
                @resultado_dias NUMERIC(21,00)      ,
                @suma_activo    numeric(21,00)      ,
                @suma_pasivo    numeric(21,00)      ,
                @fecha_antes    char(10)            ,
                @suma_total     numeric(21,00)
  DECLARE @observado    NUMERIC(12,04)  ,
        @uf     NUMERIC(12,04)  ,
        @fecha_observado  CHAR(10)  ,
        @fecha_uf    CHAR(10)  ,
   @entidad  char(40)
    EXECUTE sp_parametros_reporte   @observado  OUTPUT ,
              @uf   OUTPUT ,
        @fecha_observado OUTPUT ,
        @fecha_uf  OUTPUT
    set  @fecha_antes = (select convert (char(8), acfecante,112)  from mfac)        
    set @entidad      = (select acnomprop from mfac)        
 
                        
        select @observado2 = vmvalor
        from   view_valor_moneda,
               mfac              
        where  accodmondolobs = vmcodigo and
              @fecha_antes = vmfecha    
 CREATE TABLE #tempo    ( tipoc    Numeric(2)        ,
         posicion     NUMERIC(3)       ,
     llave      CHAR(9)        ,
     Glosa        CHAR(50)           ,
     monto      NUMERIC(21,04) DEFAULT(0)  ,  
     monto2      NUMERIC(21,04) DEFAULT(0)  ,
     acumulado    NUMERIC(21,04) DEFAULT(0)  ,
     acumulado2    NUMERIC(21,04) DEFAULT(0)      ,
     fecha_T      DATETIME          ,
     fecha_A       datetime                       , 
     observado   NUMERIC(12,04)         ,
     observado2    NUMERIC(12,04)         , 
     uf    NUMERIC(12,04)         ,
     hora   CHAR(8)                  ,
     fecha_uf      CHAR(10)                        ,
     entidad char(40)
   )
                                   
 -- |-----------------------------------------------------------
 -- | Primero las Glosas de los Resultados a Desplegar
 -- |-----------------------------------------------------------
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 1 ,40 ,  'C-1  -999' , 'COMPRA USD-$')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 1 , 1 ,  'C-1  -999' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 1 , 2 ,  'C-1  -999' , 'Devengo' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 41 , 'C-1  -998' , 'COMPRA USD-UF')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 3  , 'C-1  -998' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 4  , 'C-1  -998' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 5  , 'C-1  -998' , 'Devengo' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 42 , 'C-5  -13 ' , 'COMPRA 1446')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 6  , 'C-5  -13 ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 52  , 'C-5  -13 ' , 'Resultado Var. UF' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 7  , 'C-5  -13 ' , 'Devengo Dolares' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 53  , 'C-5  -13 ' , 'Devengo UF' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 54  , 'C-5  -13 ' , 'Devengo Pesos' ) 
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 43 , 'C-4  -13 ' , 'COMPRA POSICION')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 8  , 'C-4  -13 ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 9  , 'C-4  -13 ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 10 , 'C-4  -13 ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 11 , 'C-4  -13 ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 12 , 'C-4  -13 ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 44 , 'C-6  -13 ' , 'COMPRA HEDGE')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 13 , 'C-6  -13 ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 14 , 'C-6  -13 ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 15 , 'C-6  -13 ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 16 , 'C-6  -13 ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 17 , 'C-6  -13 ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 ,45 ,  'V-1  -999' , 'VENTA USD-$')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 ,18 ,  'V-1  -999' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 ,19 ,  'V-1  -999' , 'Devengo' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 46 , 'V-1  -998' , 'VENTA USD-UF')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 20 , 'V-1  -998' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 21 , 'V-1  -998' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 22 , 'V-1  -998' , 'Devengo' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 47 , 'V-5  -13 ' , 'VENTA 1446')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 23 , 'V-5  -13 ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 55 , 'V-5  -13 ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 24 , 'V-5  -13 ' , 'Devengo Dolares' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 56 , 'V-5  -13 ' , 'Devengo UF' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 57 , 'V-5  -13 ' , 'Devengo Pesos' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 48 , 'V-4  -13 ' , 'VENTA POSICION')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 25 , 'V-4  -13 ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 26 , 'V-4  -13 ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 27 , 'V-4  -13 ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 28 , 'V-4  -13 ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 29 , 'V-4  -13 ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10, 49 , 'V-6  -13 ' , 'VENTA HEDGE')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10, 30 , 'V-6  -13 ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10, 31 , 'V-6  -13 ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10, 32 , 'V-6  -13 ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10, 33 , 'V-6  -13 ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10, 34 , 'V-6  -13 ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 11 , 50 , '         ' , 'RESULTADO NETO DIA' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 11 , 51 , '         ' , 'POSICION DOLARES') 
   UPDATE #tempo set monto = activo_saldo_usd
   FROM resultado_calce, 
        #tempo  
   WHERE(posicion = 40 or
         posicion = 41 or
         posicion = 42 or
         posicion = 43 or
         posicion = 44 or
         posicion = 45 or
         posicion = 46 or
         posicion = 47 or
         posicion = 48 or
         posicion = 49 ) and
         tipo  = llave  AND
         CONVERT(CHAR(8),fecha,112) = @fecha 
   update #tempo set  monto = activo_variacion_tc
   from resultado_calce,
        #tempo
   where   (posicion  = 1  or
            posicion  = 3  or
            posicion  = 6  or
            posicion  = 8  or
            posicion  = 13 or
            posicion  = 18 or        
            posicion  = 20 or
            posicion  = 23 or
            posicion  = 25 or
            posicion  = 30 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto = activo_variacion_uf 
   from resultado_calce,
        #tempo
   where   (posicion  = 4  or
            posicion  = 9  or
            posicion  = 14 or
            posicion  = 21 or
            posicion  = 26 or
            posicion  = 31 or 
     posicion  = 52 or 
     posicion  = 55 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto = activo_devengo 
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 5  or
            posicion  = 19 or        
            posicion  = 22 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto = activo_devengo_dolares 
   from resultado_calce,
        #tempo
   where   (posicion  = 7  or
            posicion  = 10 or
            posicion  = 15 or
            posicion  = 27 or
            posicion  = 32 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto = activo_devengo_uf 
   from resultado_calce,
        #tempo
   where   (posicion  = 11 or
            posicion  = 16 or
            posicion  = 28 or
            posicion  = 33 or 
     posicion  = 53 or 
     posicion  = 56 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto = activo_devengo_pesos
   from resultado_calce,
        #tempo
   where   (posicion  = 12 or
            posicion  = 17 or
            posicion  = 29 or
            posicion  = 34 or 
     posicion  = 54 or 
     posicion  = 57 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
-------------------------- pasivos    ----------------------------
   update #tempo set  monto2= pasivo_variacion_tc
   from resultado_calce,
        #tempo
   where   (posicion  = 1  or
            posicion  = 3  or
            posicion  = 6  or
            posicion  = 8  or
            posicion  = 13 or
            posicion  = 18 or        
            posicion  = 20 or
            posicion  = 23 or
            posicion  = 25 or
            posicion  = 30 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto2= pasivo_variacion_uf
   from resultado_calce,
        #tempo
   where   (posicion  = 4  or
            posicion  = 9  or
            posicion  = 14 or
            posicion  = 21 or
            posicion  = 26 or
            posicion  = 31 or 
     posicion  = 52 or 
     posicion  = 55 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto2= pasivo_devengo
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 5  or
            posicion  = 19 or        
            posicion  = 22 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto2= pasivo_devengo_dolares
   from resultado_calce,
        #tempo
   where   (posicion  = 7  or
            posicion  = 10 or
            posicion  = 15 or
            posicion  = 27 or 
            posicion  = 32 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto2= pasivo_devengo_uf
   from resultado_calce,
        #tempo
   where   (posicion  = 11 or
            posicion  = 16 or
            posicion  = 28 or
            posicion  = 33 or 
     posicion  = 53 or 
     posicion  = 56 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  monto2= pasivo_devengo_pesos
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 17 or
            posicion  = 29 or
            posicion  = 34 or 
     posicion  = 54 or 
     posicion  = 57 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
----------------------------------------            acumulado           -----------------------------------------
-- ACTIVO 
   update #tempo set  acumulado = activo_acumulado_tc
   from resultado_calce,
        #tempo
   where   (posicion  = 1  or
            posicion  = 3  or
            posicion  = 6  or
            posicion  = 8  or
            posicion  = 13 or
            posicion  = 18 or        
            posicion  = 20 or
            posicion  = 23 or
            posicion  = 25 or
            posicion  = 30 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado = activo_acumulado_uf 
   from resultado_calce,
        #tempo
   where   (posicion  = 4  or
            posicion  = 9  or
            posicion  = 14 or
            posicion  = 21 or
            posicion  = 26 or
            posicion  = 31 or 
     posicion  = 52 or 
     posicion  = 55 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado = activo_acumulado_devengo
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 5  or
            posicion  = 19 or        
            posicion  = 22 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado = activo_acumulado_devengo_dolares
   from resultado_calce,
        #tempo
   where   (posicion  = 7  or
            posicion  = 10 or
            posicion  = 15 or
            posicion  = 27 or
            posicion  = 32 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado = activo_acumulado_devengo_uf
   from resultado_calce,
        #tempo
   where   (posicion  = 11 or 
            posicion  = 16 or
            posicion  = 28 or
            posicion  = 33 or 
     posicion  = 53 or 
     posicion  = 56 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado = activo_acumulado_devengo_pesos
   from resultado_calce,
        #tempo
   where   (posicion  = 12  or
            posicion  = 17 or
            posicion  = 29 or
            posicion  = 34 or 
     posicion  = 54 or 
     posicion  = 57 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
--------------- PASIVOS
   UPDATE #tempo set monto2 = pasivo_saldo_usd
   FROM resultado_calce, 
        #tempo
   WHERE(posicion = 40 or
         posicion = 41 or
         posicion = 42 or
         posicion = 43 or
         posicion = 44 or
         posicion = 45 or
         posicion = 46 or
         posicion = 47 or
         posicion = 48 or
         posicion = 49 ) and
         tipo  = llave  AND
         CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado2 = pasivo_acumulado_tc
   from resultado_calce,
        #tempo
   where   (posicion  = 1  or
            posicion  = 3  or
            posicion  = 6  or
            posicion  = 8  or
            posicion  = 13 or
            posicion  = 18 or        
            posicion  = 20 or
            posicion  = 23 or
  posicion  = 25 or
            posicion  = 30 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado2 = pasivo_acumulado_uf
   from resultado_calce,
        #tempo
   where   (posicion  = 4  or
            posicion  = 9  or
            posicion  = 14 or
            posicion  = 21 or
            posicion  = 26 or
            posicion  = 31 or 
     posicion  = 52 or 
     posicion  = 55 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado2 = pasivo_acumulado_devengo
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 5  or
            posicion  = 19 or        
            posicion  = 22 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado2 = pasivo_acumulado_devengo_dolares
   from resultado_calce,
        #tempo
   where   (posicion  = 7  or
            posicion  = 10 or
            posicion  = 15 or
            posicion  = 27 or
            posicion  = 32 )and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado2 = pasivo_acumulado_devengo_uf
   from resultado_calce,
        #tempo
   where   (posicion  = 11 or
            posicion  = 16 or
            posicion  = 28 or
            posicion  = 33 or 
     posicion  = 53 or 
     posicion  = 56 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   update #tempo set  acumulado2 = pasivo_acumulado_devengo_pesos
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 17 or
            posicion  = 29 or
            posicion  = 34 or 
     posicion  = 54 or 
     posicion  = 57 ) and
            tipo  = llave  AND
     CONVERT(CHAR(8),fecha,112)= @fecha 
   select @suma_total = 0
   select @suma_total = (select sum(monto) from #tempo 
   WHERE(posicion <> 40 and
         posicion <> 41 and
         posicion <> 42 and
         posicion <> 43 and
         posicion <> 44 and
         posicion <> 45 and
         posicion <> 46 and
         posicion <> 47 and
         posicion <> 48 and
         posicion <> 49 ))
   update #tempo set monto = @suma_total where posicion = 50
       
   select @suma_total = 0
   select @suma_total = (select sum(monto2) from #tempo 
   WHERE(posicion <> 40 and
         posicion <> 41 and
         posicion <> 42 and
         posicion <> 43 and
         posicion <> 44 and
         posicion <> 45 and
         posicion <> 46 and
         posicion <> 47 and
         posicion <> 48 and
         posicion <> 49 ))
  update #tempo set monto2 = @suma_total where posicion = 50
       
   select @suma_total = 0 
   select @suma_total = (select sum(acumulado) from #tempo 
   WHERE(posicion <> 40 or
         posicion <> 41 or
         posicion <> 42 or
         posicion <> 43 or
         posicion <> 44 or
         posicion <> 45 or
         posicion <> 46 or
         posicion <> 47 or
         posicion <> 48 or
         posicion <> 49 ))
  update #tempo set acumulado = @suma_total where posicion = 50
   select @suma_total = 0 
   select @suma_total = (select sum(acumulado2) from #tempo 
   WHERE(posicion <> 40 or
         posicion <> 41 or
         posicion <> 42 or
         posicion <> 43 or
         posicion <> 44 or
         posicion <> 45 or
         posicion <> 46 or
         posicion <> 47 or
         posicion <> 48 or
         posicion <> 49 ))
   update #tempo set acumulado2 = @suma_total where posicion = 50
   select @suma_total = 0
   select @suma_total = (select sum(monto) from #tempo 
   WHERE(posicion = 40 or
         posicion = 41 or
         posicion = 42 or
         posicion = 43 or
         posicion = 44 or
         posicion = 45 or
         posicion = 46 or
         posicion = 47 or
         posicion = 48 or
     posicion = 49 ))
   update #tempo set monto = @suma_total where posicion = 51
   select @suma_total = 0
   select @suma_total = (select sum(monto2) from #tempo 
   WHERE(posicion = 40 or
         posicion = 41 or
         posicion = 42 or
         posicion = 43 or
         posicion = 44 or
         posicion = 45 or
         posicion = 46 or
         posicion = 47 or
         posicion = 48 or
         posicion = 49 )) 
   update #tempo set monto2 = @suma_total where posicion = 51
  UPDATE #tempo SET hora = CONVERT(CHAR(8),GETDATE(),108),
     fecha_T = @fecha  ,
     fecha_A = @fecha_antes ,
     observado = @observado,
     observado2 = @observado2,
     uf = @uf    
 update #tempo set fecha_T  = CONVERT( CHAR(10) , @fecha, 103 ) ,
                   fecha_a  = CONVERT( CHAR(10) , @fecha_antes , 103 ) ,
                   fecha_uf = @fecha_uf    ,
     entidad = @entidad
    
 
 SELECT * FROM #tempo ORDER BY tipoc
 DROP TABLE #tempo         
END

GO
