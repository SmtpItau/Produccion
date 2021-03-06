USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RES_OPERACIONES_POR_CALCE]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RES_OPERACIONES_POR_CALCE]( @fecha CHAR(8))
AS BEGIN
 DECLARE @observado2     NUMERIC(12,04)     ,
    @acumula        NUMERIC(21,00)      ,
         @acumula2       NUMERIC(21,00)      ,
         @resultado_dias NUMERIC(21,00)      ,
         @suma_activo    numeric(21,00)      ,
         @suma_pasivo    numeric(21,00)      ,
         @fecha_antes    char(10)            ,
         @suma_total     numeric(21,00)
 DECLARE @observado  NUMERIC(12,04)  ,
       @uf   NUMERIC(12,04)   ,
       @fecha_observado CHAR(10)  ,
       @fecha_uf  CHAR(10)   ,
  @entidad   char(40)
select @entidad = acnomprop from  mfac
    EXECUTE sp_parametros_reporte   @observado  OUTPUT ,
              @uf   OUTPUT ,
        @fecha_observado OUTPUT ,
        @fecha_uf  OUTPUT
        select  @fecha_antes = (select convert (char(8), acfecante,112) from mfac)        
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
                          acumulado2    NUMERIC(21,04) DEFAULT(0)       ,
         fecha_T       DATETIME          ,
                          fecha_A       datetime                        , 
         observado   NUMERIC(12,04)         ,
                          observado2    NUMERIC(12,04)         , 
     uf    NUMERIC(12,04)         ,
     hora   CHAR(8)                     ,
     fecha_uf      CHAR(10)                        ,
     entidad       CHAR(40)
   )
                                   
 -- |-----------------------------------------------------------
 -- | Primero las Glosas de los Resultados a Desplegar
 -- |-----------------------------------------------------------
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 1 ,80 , '1  -1    ' , 'FUTURO FUTURO')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 1 , 1 , '1  -1    ' , 'Resultado Var. T/C' ) 
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 1 , 2 , '1  -1    ' , 'Resultado Var. U.F.')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 1 , 3 , '1  -1    ' , 'Devengo' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 81 , '1  -4    ' , 'FUTURO POSICION')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 4  , '1  -4    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 5  , '1  -4    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 6  , '1  -4    ' , 'Devengo' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 7  , '1  -4    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 8  , '1  -4    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 2 , 9  , '1  -4    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 82 , '1  -6    ' , 'FUTURO HEDGE') 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 10 , '1  -6    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 11 , '1  -6    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 12 , '1  -6    ' , 'Devengo' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 13 , '1  -6    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 14 , '1  -6    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 3 , 15 , '1  -6    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 83 , '1  -5    ' , 'FUTURO 1446')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 16 , '1  -5    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 17 , '1  -5    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 18 , '1  -5    ' , 'Devengo' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 4 , 19 , '1  -5    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 84 , '4  -1    ' , 'POSICION FUTURO')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 20 , '4  -1    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 21 , '4  -1    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 22 , '4  -1    ' , 'Devengo' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 23 , '4  -1    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 24 , '4  -1    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 5 , 25 , '4  -1    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 , 85 , '4  -4    ' , 'POSICION POSICION')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 , 26 , '4  -4    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 , 27 , '4  -4    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 , 28 , '4  -4    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 , 29 , '4  -4    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 6 , 30 , '4  -4    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 86 , '4  -6    ' , 'POSICION HEDGE')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 31 , '4  -6    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 32 , '4  -6    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 33 , '4  -6    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 34 , '4  -6    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 7 , 35 , '4  -6    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 87 , '4  -5    ' , 'POSICION 1446')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 36 , '4  -5    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 38 , '4  -5    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 39 , '4  -5    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 40 , '4  -5    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 8 , 41 , '4  -5    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 88 , '6  -1    ' , 'HEDGE FUTURO')      
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 42 , '6  -1    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 43 , '6  -1    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 44 , '6  -1    ' , 'Devengo' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 45 , '6  -1    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 46 , '6  -1    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 9 , 47 , '6  -1    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10 , 89 , '6  -4    ' , 'HEDGE POSICION')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10 , 48 , '6  -4    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10 , 49 , '6  -4    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10 , 50 , '6  -4    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10 , 51 , '6  -4    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 10 , 52 , '6  -4    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 11 , 90 , '6  -6    ' , 'HEDGE HEDGE')  
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 11 , 53 , '6  -6    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 11 , 54 , '6  -6    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 11 , 55 , '6  -6    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 11 , 56 , '6  -6    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 11 , 57 , '6  -6    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 12 , 91 , '6  -5    ' , 'HEDGE 1446')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 12 , 58 , '6  -5    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 12 , 59 , '6  -5    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 12 , 60 , '6  -5    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 12 , 61 , '6  -5    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 12 , 62 , '6  -5    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 13 , 92 , '5  -1    ' , '1446 FUTURO')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 13 , 63 , '5  -1    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 13 , 64 , '5  -1    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 13 , 65 , '5  -1    ' , 'Devengo' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 13 , 66 , '5  -1    ' , 'Devengo Dolares')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 14 , 93 , '5  -4    ' , '1446 POSICION')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 14 , 67 , '5  -4    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 14 , 68 , '5  -4    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 14 , 69 , '5  -4    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 14 , 70 , '5  -4    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 14 , 71 , '5  -4    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 15 , 94 , '5  -6    ' , '1446 HEDGE')
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 15 , 72 , '5  -6    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 15 , 73 , '5  -6    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 15 , 74 , '5  -6    ' , 'Devengo Dolares' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 15 , 75 , '5  -6    ' , 'Devengo U.F.')
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 15 , 76 , '5  -6    ' , 'Devengo Pesos')  
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 16 , 95 , '5  -5    ' , '1446  1446')        
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 16 , 77 , '5  -5    ' , 'Resultado Var. T/C' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 16 , 78 , '5  -5    ' , 'Resultado Var. U.F.' ) 
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 16 , 79 , '5  -5    ' , 'Devengo Dolares' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 16 , 99 , '5  -5    ' , 'Devengo UF' )
 INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 16 , 100 , '5  -5    ' , 'Devengo Pesos' )
                
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 17 , 96 , '         ' , 'RESULTADO NETO DIA' )
        INSERT INTO #tempo( tipoc , posicion , llave , Glosa ) VALUES ( 17 , 97 , '         ' , 'POSICION DOLARES') 
   UPDATE #tempo set monto = activo_saldo_usd ,
                   fecha_T = @fecha  ,
                 observado = @observado,
                       uf  = @uf
   FROM resultado_calce, 
        #tempo
   
   WHERE ( posicion = 80 or
         posicion = 81 or
         posicion = 82 or
         posicion = 83 or
         posicion = 84 or
         posicion = 85 or
         posicion = 86 or
         posicion = 87 or
         posicion = 88 or
         posicion = 89 or
         posicion = 90 or
         posicion = 91 or
         posicion = 92 or
         posicion = 93 or
         posicion = 94 or
         posicion = 95 ) and
         tipo  = llave  AND
         fecha = @fecha 
   update #tempo set  monto = activo_variacion_tc ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 1  or
            posicion  = 4  or
            posicion  = 10 or
            posicion  = 16 or
            posicion  = 20 or
            posicion  = 26 or        
            posicion  = 31 or
            posicion  = 36 or
            posicion  = 42 or
            posicion  = 48 or
            posicion  = 53 or
            posicion  = 58 or
            posicion  = 63 or
            posicion  = 67 or
            posicion  = 72 or
            posicion  = 77 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto = activo_variacion_uf ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 5  or
            posicion  = 11 or
            posicion  = 17 or
            posicion  = 21 or
            posicion  = 27 or        
            posicion  = 32 or
            posicion  = 37 or
            posicion  = 43 or
            posicion  = 49 or
            posicion  = 54 or
            posicion  = 59 or
            posicion  = 64 or
            posicion  = 68 or
            posicion  = 73 or
            posicion  = 78 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto = activo_devengo ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 3  or
            posicion  = 6  or
            posicion  = 12 or
            posicion  = 18 or
            posicion  = 22 or
            posicion  = 44 or        
            posicion  = 65 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto = activo_devengo_dolares ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 7  or
            posicion  = 13 or
            posicion  = 19 or
            posicion  = 23 or
            posicion  = 28 or
            posicion  = 33 or        
            posicion  = 39 or
     posicion  = 45 or
            posicion  = 50 or
            posicion  = 55 or
            posicion  = 60 or
            posicion  = 66 or
            posicion  = 69 or
            posicion  = 74 or
            posicion  = 79 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto = activo_devengo_uf ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 8  or
            posicion  = 14 or
            posicion  = 24 or
            posicion  = 29 or
            posicion  = 34 or
            posicion  = 40 or        
            posicion  = 46 or
            posicion  = 51 or
            posicion  = 56 or
            posicion  = 61 or
            posicion  = 70 or
            posicion  = 75 or 
     posicion  = 99 ) and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto = activo_devengo_pesos ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 9  or
            posicion  = 25 or
            posicion  = 30 or
            posicion  = 35 or
            posicion  = 41 or
            posicion  = 47 or        
            posicion  = 52 or
            posicion  = 57 or
            posicion  = 62 or
            posicion  = 71 or
            posicion  = 76 or 
     posicion  = 100 )and
            tipo  = llave  AND
     fecha = @fecha 
-------------------------- pasivos    ----------------------------
   UPDATE #tempo set monto2 = pasivo_saldo_usd ,
                             fecha_T = @fecha  ,
                             observado = @observado,
                             uf = @uf
   FROM resultado_calce, 
        #tempo
   
   WHERE ( posicion = 80 or
         posicion = 81 or
         posicion = 82 or
         posicion = 83 or
         posicion = 84 or
         posicion = 85 or
         posicion = 86 or
         posicion = 87 or
         posicion = 88 or
         posicion = 89 or
         posicion = 90 or
         posicion = 91 or
         posicion = 92 or
         posicion = 93 or
         posicion = 94 or
         posicion = 95 ) and
         tipo  = llave  AND
         fecha = @fecha 
   update #tempo set  monto2 = pasivo_variacion_tc ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 1  or
            posicion  = 4  or
            posicion  = 10 or
            posicion  = 16 or
            posicion  = 20 or
            posicion  = 26 or        
            posicion  = 31 or
            posicion  = 36 or
            posicion  = 42 or
            posicion  = 48 or
            posicion  = 53 or
            posicion  = 58 or
            posicion  = 63 or
            posicion  = 67 or
            posicion  = 72 or
            posicion  = 77 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto2= pasivo_variacion_uf ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 5  or
            posicion  = 11 or
            posicion  = 17 or
            posicion  = 21 or
            posicion  = 27 or        
            posicion  = 32 or
            posicion  = 37 or
            posicion  = 43 or
            posicion  = 49 or
            posicion  = 54 or
            posicion  = 59 or
            posicion  = 64 or
            posicion  = 68 or
            posicion  = 73 or
            posicion  = 78 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto2= pasivo_devengo ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 3  or
            posicion  = 6  or
            posicion  = 12 or
            posicion  = 18 or
            posicion  = 22 or
            posicion  = 44 or        
            posicion  = 65 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto2= pasivo_devengo_dolares ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 7  or
            posicion  = 13 or
            posicion  = 19 or
            posicion  = 23 or
            posicion  = 28 or
            posicion  = 33 or        
            posicion  = 39 or
            posicion  = 45 or
            posicion  = 50 or
            posicion  = 55 or
            posicion  = 60 or
            posicion  = 66 or
            posicion  = 69 or
            posicion  = 74 or
            posicion  = 79 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto2= pasivo_devengo_uf ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 8  or
            posicion  = 14 or
            posicion  = 24 or
            posicion  = 29 or
            posicion  = 34 or
            posicion  = 40 or        
            posicion  = 46 or
            posicion  = 51 or
            posicion  = 56 or
            posicion  = 61 or
            posicion  = 70 or
            posicion  = 75 or 
     posicion  = 99 ) and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  monto2= pasivo_devengo_pesos ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 9  or
            posicion  = 25 or
            posicion  = 30 or
            posicion  = 35 or
            posicion  = 41 or
            posicion  = 47 or        
            posicion  = 52 or
            posicion  = 57 or
            posicion  = 62 or
            posicion  = 71 or
            posicion  = 76 or 
     posicion  = 100 ) and
            tipo  = llave  AND
     fecha = @fecha 
----------------------------------------            acumulado           -----------------------------------------
-- ACTIVO 
   update #tempo set  acumulado =  activo_acumulado_tc  ,  
         fecha_T = @fecha ,
         observado = @observado ,
         uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 1  or
            posicion  = 4  or
            posicion  = 10 or
            posicion  = 16 or
            posicion  = 20 or
            posicion  = 26 or        
            posicion  = 31 or
            posicion  = 36 or
            posicion  = 42 or
            posicion  = 48 or
            posicion  = 53 or
            posicion  = 58 or
            posicion  = 63 or
            posicion  = 67 or
            posicion  = 72 or
            posicion  = 77 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  acumulado =  activo_acumulado_uf,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 5  or
            posicion  = 11 or
            posicion  = 17 or
            posicion  = 21 or
            posicion  = 27 or        
            posicion  = 32 or
            posicion  = 37 or
            posicion  = 43 or
            posicion  = 49 or
            posicion  = 54 or
            posicion  = 59 or
            posicion  = 64 or
            posicion  = 68 or
            posicion  = 73 or
            posicion  = 78 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  acumulado =  activo_acumulado_devengo ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 3  or
            posicion  = 6  or
            posicion  = 12 or
            posicion  = 18 or
            posicion  = 22 or
            posicion  = 44 or        
            posicion  = 65 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  acumulado =  activo_acumulado_devengo_dolares  ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 7  or
            posicion  = 13 or
            posicion  = 19 or
            posicion  = 23 or
            posicion  = 28 or
            posicion  = 33 or        
            posicion  = 39 or
            posicion  = 45 or
            posicion  = 50 or
            posicion  = 55 or
            posicion  = 60 or
            posicion  = 66 or
            posicion  = 69 or
            posicion  = 74 or
            posicion  = 79 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set acumulado = activo_acumulado_devengo_uf  ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 8  or
            posicion  = 14 or
            posicion  = 24 or
            posicion  = 29 or
            posicion  = 34 or
            posicion  = 40 or        
            posicion  = 46 or
            posicion  = 51 or
            posicion  = 56 or
            posicion  = 61 or
            posicion  = 70 or
            posicion  = 75 or
     posicion  = 99 ) and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  acumulado =  activo_acumulado_devengo_pesos  ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 9  or
            posicion  = 25 or
            posicion  = 30 or
            posicion  = 35 or
            posicion  = 41 or
            posicion  = 47 or        
            posicion  = 52 or
            posicion  = 57 or
            posicion  = 62 or
            posicion  = 71 or
            posicion  = 76 or 
     posicion  = 100 ) and
            tipo  = llave  AND
     fecha = @fecha 
--------------- pasivo
   update #tempo set  acumulado2=  pasivo_acumulado_tc  ,  
         fecha_T = @fecha ,
         observado = @observado ,
         uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 1  or
            posicion  = 4  or
            posicion  = 10 or
            posicion  = 16 or
            posicion  = 20 or
            posicion  = 26 or        
            posicion  = 31 or
            posicion  = 36 or
            posicion  = 42 or
            posicion  = 48 or
            posicion  = 53 or
            posicion  = 58 or
            posicion  = 63 or
            posicion  = 67 or
            posicion  = 72 or
            posicion  = 77 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  acumulado2=  pasivo_acumulado_uf,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 2  or
            posicion  = 5  or
            posicion  = 11 or
            posicion  = 17 or
            posicion  = 21 or
            posicion  = 27 or        
            posicion  = 32 or
            posicion  = 37 or
            posicion  = 43 or
            posicion  = 49 or
            posicion  = 54 or
            posicion  = 59 or
            posicion  = 64 or
            posicion  = 68 or
            posicion  = 73 or
            posicion  = 78 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  acumulado2=  pasivo_acumulado_devengo ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 3  or
            posicion  = 6  or
            posicion  = 12 or
            posicion  = 18 or
            posicion  = 22 or
            posicion  = 44 or        
            posicion  = 65 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  acumulado2=  pasivo_acumulado_devengo_dolares  ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 7  or
            posicion  = 13 or
            posicion  = 19 or
            posicion  = 23 or
            posicion  = 28 or
            posicion  = 33 or        
            posicion  = 39 or
            posicion  = 45 or
            posicion  = 50 or
            posicion  = 55 or
            posicion  = 60 or
            posicion  = 66 or
            posicion  = 69 or
            posicion  = 74 or
            posicion  = 79 )and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set acumulado2= pasivo_acumulado_devengo_uf  ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 8  or
            posicion  = 14 or
            posicion  = 24 or
            posicion  = 29 or
            posicion  = 34 or
            posicion  = 40 or        
            posicion  = 46 or
            posicion  = 51 or
            posicion  = 56 or
            posicion  = 61 or
            posicion  = 70 or
            posicion  = 75 or 
     posicion  = 99 ) and
            tipo  = llave  AND
     fecha = @fecha 
   update #tempo set  acumulado2=  pasivo_acumulado_devengo_pesos  ,  
        fecha_T = @fecha ,
        observado = @observado ,
        uf = @uf    
   from resultado_calce,
        #tempo
   where   (posicion  = 9  or
            posicion  = 25 or
            posicion  = 30 or
            posicion  = 35 or
            posicion  = 41 or
            posicion  = 47 or        
            posicion  = 52 or
            posicion  = 57 or
            posicion  = 62 or
            posicion  = 71 or
            posicion  = 76 or 
     posicion  = 100 )and
            tipo  = llave  AND
     fecha = @fecha 
        
   select @suma_total = 0
   select @suma_total = (select sum(monto) from #tempo 
         WHERE ( posicion <> 80 and
         posicion <> 81 and
         posicion <> 82 and
         posicion <> 83 and
         posicion <> 84 and
         posicion <> 85 and
         posicion <> 86 and
         posicion <> 87 and
         posicion <> 88 and
         posicion <> 89 and
         posicion <> 90 and
         posicion <> 91 and
         posicion <> 92 and
         posicion <> 93 and
         posicion <> 94 and
         posicion <> 95 ) )
        update #tempo set monto = @suma_total where posicion = 96
       
   select @suma_total = 0
   select @suma_total = (select sum(monto2) from #tempo 
         WHERE ( posicion <> 80 and
         posicion <> 81 and
         posicion <> 82 and
         posicion <> 83 and
         posicion <> 84 and
         posicion <> 85 and
         posicion <> 86 and
         posicion <> 87 and
         posicion <> 88 and
         posicion <> 89 and
         posicion <> 90 and
         posicion <> 91 and
         posicion <> 92 and
         posicion <> 93 and
         posicion <> 94 and
         posicion <> 95 ) )
        update #tempo set monto2 = @suma_total where posicion = 96
       
 select @suma_total = 0 
 select @suma_total = (select sum(acumulado) from #tempo 
         WHERE ( posicion <> 80 or
         posicion <> 81 or
         posicion <> 82 or
         posicion <> 83 or
         posicion <> 84 or
         posicion <> 85 or
         posicion <> 86 or
         posicion <> 87 or
         posicion <> 88 or
         posicion <> 89 or
         posicion <> 90 or
         posicion <> 91 or
         posicion <> 92 or
         posicion <> 93 or
         posicion <> 94 or
         posicion <> 95 ) )
         update #tempo set acumulado = @suma_total where posicion = 96
 select @suma_total = 0 
 select @suma_total = (select sum(acumulado2) from #tempo 
         WHERE ( posicion <> 80 or
         posicion <> 81 or
         posicion <> 82 or
         posicion <> 83 or
         posicion <> 84 or
         posicion <> 85 or
         posicion <> 86 or
         posicion <> 87 or
         posicion <> 88 or
         posicion <> 89 or
         posicion <> 90 or
         posicion <> 91 or
         posicion <> 92 or
         posicion <> 93 or
         posicion <> 94 or
         posicion <> 95 ) )
         update #tempo set acumulado2 = @suma_total where posicion = 96
   select @suma_total = 0
   select @suma_total = (select sum(monto) from #tempo 
         WHERE ( posicion = 80 or
         posicion = 81 or
         posicion = 82 or
         posicion = 83 or
         posicion = 84 or
         posicion = 85 or
         posicion = 86 or
         posicion = 87 or
         posicion = 88 or
         posicion = 89 or
         posicion = 90 or
         posicion = 91 or
         posicion = 92 or
         posicion = 93 or
         posicion = 94 or
         posicion = 95 ) )
        update #tempo set monto = @suma_total where posicion = 97
   select @suma_total = 0
   select @suma_total = (select sum(monto2) from #tempo 
         WHERE ( posicion = 80 or
         posicion = 81 or
         posicion = 82 or
         posicion = 83 or
         posicion = 84 or
         posicion = 85 or
         posicion = 86 or
         posicion = 87 or
         posicion = 88 or
         posicion = 89 or
         posicion = 90 or
         posicion = 91 or
         posicion = 92 or
         posicion = 93 or
         posicion = 94 or
         posicion = 95 ) )
        update #tempo set monto2 = @suma_total where posicion = 97                                           
 update #tempo set hora = CONVERT(CHAR(8),GETDATE(),108)   ,
     fecha_T  = CONVERT( CHAR(10) , @fecha , 103 )  ,
                          fecha_a  = CONVERT( CHAR(10) , @fecha_antes , 103 )  ,
     fecha_uf = @fecha_uf     ,
     observado2 = @observado2    ,
                          observado = @observado    ,
                          uf = @uf
update #tempo set entidad = @entidad
 SELECT *FROM #tempo ORDER BY tipoc
 DROP TABLE #tempo         
END
-- Sp_Res_Operaciones_Por_Calce '20010703'

GO
