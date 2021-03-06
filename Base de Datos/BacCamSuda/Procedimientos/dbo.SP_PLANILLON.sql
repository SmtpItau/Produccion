USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLANILLON]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_PLANILLON]( @Fecha CHAR(8) = 'yyyymmdd' )
AS 
BEGIN
     SET NOCOUNT     ON
     SET ARITHABORT  OFF
     SET ARITHIGNORE ON
     ------------------------------------------------------------------------------------------------------
     --- SE RECUPERAN LAS FECHAS DE EMISION DEL REPORTE
     ------------------------------------------------------------------------------------------------------
     IF @Fecha = 'yyyymmdd'
        SELECT @Fecha = CONVERT(CHAR(8),acfecpro,112) FROM meac     
     ------------------------------------------------------------------------------------------------------
     --- CARGA TODAS LAS MONEDAS EXTRANJERAS QUE PUEDE TENER POSICION
     ------------------------------------------------------------------------------------------------------            
     SELECT 'fecha'                 = CONVERT( CHAR(10), CONVERT(DATETIME, @Fecha), 103),  --<< INFORMACION GENERAL
            --'orden'                 = orden_planillon  ,
            'orden'                 = IDENTITY(INT,1,1),
            'codigo_moneda'         = mncodmon         ,
            'nemotecnico_moneda'    = mnnemo           ,
            'relacion_dolar'        = mnrrda           ,
             --<< INFORMACION AL DIA DE AYER
            'debe_haber_ayer'       = ' '              ,
            'posicion_origen_ayer'  = CONVERT(NUMERIC(19,4), 0),
            'posicion_dolares_ayer' = CONVERT(NUMERIC(19,2), 0),
            'paridad_finmes_ayer'   = CONVERT(NUMERIC(19,6), 1),
             --<< INFORMACION AL DIA DE HOY
            'debe_haber_hoy'        = ' '              ,
            'posicion_origen_hoy'   = CONVERT(NUMERIC(19,4), 0),
            'posicion_dolares_hoy'  = CONVERT(NUMERIC(19,2), 0),
            'paridad_finmes_hoy'    = CONVERT(NUMERIC(19,6), 1)
       INTO #Posicion
       FROM view_moneda
      WHERE mnmx = 'C'
     ------------------------------------------------------------------------------------------------------
     --- ACTUALIZA LA POSICION MANTENIDA AL DIA DE AYER
     ------------------------------------------------------------------------------------------------------
     UPDATE #Posicion
        SET  posicion_origen_ayer = vmposini ,
             paridad_finmes_ayer  = (CASE WHEN vmparmes = 0 THEN 1.0 ELSE vmparmes END),
             debe_haber_ayer      = (CASE WHEN vmposini > 0 THEN 'H' 
                                          WHEN vmposini < 0 THEN 'D' ELSE ' '      END)
        FROM view_Posicion_SPT
       WHERE vmcodigo = nemotecnico_moneda 
         AND CONVERT(CHAR(8),vmfecha,112) = @Fecha
     ------------------------------------------------------------------------------------------------------
     --- ACTUALIZA LA POSICION MANTENIDA AL DIA DE PROCESO
     ------------------------------------------------------------------------------------------------------
     UPDATE #Posicion
        SET  posicion_origen_hoy = vmposic ,
             paridad_finmes_hoy  = (CASE WHEN vmparmes = 0 THEN 1.0 ELSE vmparmes END),
             debe_haber_hoy      = (CASE WHEN vmposic > 0 THEN 'H' 
                                         WHEN vmposic < 0 THEN 'D' ELSE ' '      END)
        FROM view_Posicion_SPT
       WHERE vmcodigo = nemotecnico_moneda 
         AND CONVERT(CHAR(8),vmfecha,112) = @Fecha
     ------------------------------------------------------------------------------------------------------
     --- CALCULA EL EQUIVALENTE EN 'USD' SEGUN PARIDAD BCCH
     ------------------------------------------------------------------------------------------------------
     UPDATE #Posicion
        SET posicion_dolares_ayer = ROUND( posicion_origen_ayer / paridad_finmes_ayer, 2),
            posicion_dolares_hoy  = ROUND( posicion_origen_hoy  / paridad_finmes_hoy , 2)
     DELETE #Posicion  WHERE posicion_origen_ayer = 0 AND posicion_origen_hoy = 0
     ------------------------------------------------------------------------------------------------------
     --- GENERA ESTADISTICA DE PLANILLAS
     ------------------------------------------------------------------------------------------------------
     ------------------------------------------------------------------------------------------------------
     --- CREA UNA TABLA DE RESUMEN PARA LAS PLANILLAS DE OPERACIONES DE CAMBIO
     ------------------------------------------------------------------------------------------------------
     CREATE TABLE #resumen_planillas (
             Pos            INT             DEFAULT 0       ,
             Tipo           CHAR(1)         DEFAULT 0       ,
             Glosa          VARCHAR(40)     DEFAULT ''      ,
             CodOMA         INT             DEFAULT 0       ,
             Cant           INT             DEFAULT 0       ,
             Monto          FLOAT           DEFAULT 0       ,
             CodOMA_anu     INT             DEFAULT 0       ,
             Cant_anu       INT             DEFAULT 0       ,
             Monto_anu      FLOAT           DEFAULT 0       )            
     -------------------------------------------------------------------------------------------------------------------
     --- CALCULO DE LA SECCION III. GRUPO DE INGRESOS
     -------------------------------------------------------------------------------------------------------------------
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 1,110,1,110,3, '1COMERCIO INVISIBLE'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 2,120,2,120,3, '1TRASPASO'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 3,140,1,140,3, '1COMPRAS A BANCOS Y ARBITRAJES'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 4,  0,0,  0,0, '1CASAS DE CAMBIO Y ARBITRAJES'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 5,130,1,130,3, '1COMPRAS AL BANCO CENTRAL'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 6,  0,0,  0,0, '1COMPRAS POR COB.FUERA DE PLAZO'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 7,540,1,540,3, '1COMPRAS POR PAGO ANTIC.CRED.EXT.'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 8,500,1,500,3, '1COM.VISIBLE EXP. CONTADO'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 9,401,1,401,3, '1COM.VISIBLE EXP. ANTIC. COMP.'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha,10,407,1,407,3, '1COM.VISIBLE EXP. CRED. EXT.'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha,11,403,1,403,3, '1COM.VISIBLE EXP. CRED. INT.'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha,12,  0,0,  0,0, '1COM.VISIBLE EXP. ABLAS'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha,13,  0,8,  0,0, '1INGRESO DE TRANSFERENCIAS'
     -------------------------------------------------------------------------------------------------------------------
     --- CALCULO DE LA SECCION III. GRUPO DE EGRESOS
     -------------------------------------------------------------------------------------------------------------------
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 1,210,2,210,4, '2COMERCIO INVISIBLE'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 2,220,2,220,4, '2TRASPASO'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 3,240,2,240,4, '2VENTAS A BANCOS'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 4,  0,0,  0,0, '2CASAS DE CAMBIO Y ARBITRAJES'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 5,300,2,300,4, '2COBERTURA IMPORTACIONES'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 6,  0,0,  0,0, '2PLANILLA VENTA DE CAMBIOS'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 7,230,2,230,4, '2VENTAS AL BANCO CENTRAL'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 8,  0,0,  0,0, '2VENTAS POR COB.FUERA DE PLAZO'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha, 9,  0,0,  0,0, '2VENTAS POR PAGO ANTIC.CRED.EXT.'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha,10,  0,0,  0,0, '2COBERTURA SBF - IMPORTAC.'
     INSERT INTO #resumen_planillas EXECUTE sp_Planillon_Seccion3 @Fecha,13,  0,9,  0,0, '2EGRESO DE TRANSFERENCIAS'
     -------------------------------------------------------------------------------------------------------------------
     --- AGRUPA LOS RESULTADOS
     -------------------------------------------------------------------------------------------------------------------
     DECLARE @Pos      INT
     DECLARE @Execute  VARCHAR(255)
     SELECT  @Pos   = 0
     SELECT 'FechaInforme' = CONVERT(CHAR(10), CONVERT(DATETIME, @Fecha), 103), 
            'FechaEmision' = DATENAME(WEEKDAY,acfecpro)+','+DATENAME(DAY,acfecpro)+' de '+DATENAME(MONTH,acfecpro)+' de '+DATENAME(YEAR,acfecpro), 
            'Entidad'      = RIGHT( '000' + CONVERT(VARCHAR(3),accodigo),3) , 
            'Nombre'       = acnombre,
            --<< INFORMACION SECCION II, saldos en US$ de posicion segun planillas
            'saldo_ayer'   = CONVERT(NUMERIC(19,2), 0),
            'saldo_hoy'    = CONVERT(NUMERIC(19,2), 0),
            --<< INFORMACION INGRESOS
            'iGlosa_1'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_1 '     = CONVERT(INT         , 0 ) ,
            'iMonto_1'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_2'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_2 '     = CONVERT(INT         , 0 ) ,
            'iMonto_2'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_3'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_3 '     = CONVERT(INT         , 0 ) ,
            'iMonto_3'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_4'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_4 '     = CONVERT(INT         , 0 ) ,
            'iMonto_4'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_5'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_5 '     = CONVERT(INT         , 0 ) ,
            'iMonto_5'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_6'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_6 '     = CONVERT(INT         , 0 ) ,
            'iMonto_6'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_7'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_7 '     = CONVERT(INT         , 0 ) ,
            'iMonto_7'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_8'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_8 '     = CONVERT(INT         , 0 ) ,
            'iMonto_8'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_9'     = CONVERT(VARCHAR(40) , '') ,
            'iCant_9 '     = CONVERT(INT         , 0 ) ,
            'iMonto_9'     = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_10'    = CONVERT(VARCHAR(40) , '') ,
            'iCant_10'     = CONVERT(INT         , 0 ) ,
            'iMonto_10'    = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_11'    = CONVERT(VARCHAR(40) , '') ,
            'iCant_11'     = CONVERT(INT         , 0 ) ,
            'iMonto_11'    = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_12'    = CONVERT(VARCHAR(40) , '') ,
            'iCant_12'     = CONVERT(INT         , 0 ) ,
            'iMonto_12'    = CONVERT(FLOAT       , 0 ) ,
            'iGlosa_13'    = CONVERT(VARCHAR(40) , '') , -- Transferencias
            'iCant_13'     = CONVERT(INT         , 0 ) ,
            'iMonto_13'    = CONVERT(FLOAT       , 0 ) ,
            --<< INFORMACION EGRESOS
            'eGlosa_1'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_1 '     = CONVERT(INT         , 0 ) ,
            'eMonto_1'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_2'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_2 '     = CONVERT(INT         , 0 ) ,
            'eMonto_2'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_3'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_3 '     = CONVERT(INT         , 0 ) ,
            'eMonto_3'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_4'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_4 '     = CONVERT(INT         , 0 ) ,
            'eMonto_4'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_5'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_5 '     = CONVERT(INT         , 0 ) ,
            'eMonto_5'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_6'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_6 '     = CONVERT(INT         , 0 ) ,
            'eMonto_6'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_7'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_7 '     = CONVERT(INT         , 0 ) ,
            'eMonto_7'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_8'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_8 '     = CONVERT(INT         , 0 ) ,
            'eMonto_8'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_9'     = CONVERT(VARCHAR(40) , '') ,
            'eCant_9 '     = CONVERT(INT         , 0 ) ,
            'eMonto_9'     = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_10'    = CONVERT(VARCHAR(40) , '') ,
            'eCant_10'     = CONVERT(INT         , 0 ) ,
            'eMonto_10'    = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_11'    = CONVERT(VARCHAR(40) , '') ,
            'eCant_11'     = CONVERT(INT         , 0 ) ,
            'eMonto_11'    = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_12'    = CONVERT(VARCHAR(40) , '') ,
            'eCant_12'     = CONVERT(INT         , 0 ) ,
            'eMonto_12'    = CONVERT(FLOAT       , 0 ) ,
            'eGlosa_13'    = CONVERT(VARCHAR(40) , '') , -- Transferencias
            'eCant_13'     = CONVERT(INT         , 0 ) ,
            'eMonto_13'    = CONVERT(FLOAT       , 0 ) 
       INTO #Planillon
       FROM meac
     WHILE ( @Pos < 13 )  BEGIN
           SELECT @Pos = @Pos + 1
           ----<< Ingreso
           SELECT @Execute = 'UPDATE #Planillon SET '
           SELECT @Execute = @Execute + 'iGlosa_' + CONVERT(VARCHAR(2),@Pos) + '=Glosa,' 
           SELECT @Execute = @Execute + 'iCant_'  + CONVERT(VARCHAR(2),@Pos) + '=(Cant +Cant_anu ),' 
           SELECT @Execute = @Execute + 'iMonto_' + CONVERT(VARCHAR(2),@Pos) + '=(Monto-Monto_anu)' 
           SELECT @Execute = @Execute + ' FROM #resumen_planillas'
           SELECT @Execute = @Execute + ' WHERE pos=' + CONVERT(VARCHAR(2),@Pos) + ' AND tipo=1'
           EXECUTE (@Execute)
           ----<< Egreso
           SELECT @Execute = 'UPDATE #Planillon SET '
           SELECT @Execute = @Execute + 'eGlosa_' + CONVERT(VARCHAR(2),@Pos) + '=Glosa,' 
           SELECT @Execute = @Execute + 'eCant_'  + CONVERT(VARCHAR(2),@Pos) + '=(Cant +Cant_anu ),' 
           SELECT @Execute = @Execute + 'eMonto_' + CONVERT(VARCHAR(2),@Pos) + '=(Monto-Monto_anu)' 
           SELECT @Execute = @Execute + ' FROM #resumen_planillas'
           SELECT @Execute = @Execute + ' WHERE pos=' + CONVERT(VARCHAR(2),@Pos) + ' AND tipo=2'
           EXECUTE (@Execute)
     END -- WHILE
     ----<< Actualiza saldo US$ seccion II de planillon
--     UPDATE #Planillon   SET saldo_ayer = ISNULL( (SELECT SUM(posini_planilla) FROM view_Posicion_SPT WHERE CONVERT(CHAR(8),vmfecha,112) = @Fecha) , 0),
--                             saldo_hoy  = ISNULL( (SELECT SUM( posic_planilla) FROM view_Posicion_SPT WHERE CONVERT(CHAR(8),vmfecha,112) = @Fecha) , 0)
     UPDATE #Planillon   SET saldo_ayer = ISNULL( (SELECT SUM(posicion_dolares_ayer) FROM #Posicion) , 0),
                             saldo_hoy  = ISNULL( (SELECT SUM(posicion_dolares_hoy ) FROM #Posicion) , 0)
     ----<< Actualizo mi codigo Entidad BCCH
     UPDATE #Planillon   SET entidad = clcodban
                        FROM view_cliente, meac
                       WHERE clrut = acrut 
     
     ----<< resultado para reporte
     SELECT * FROM #Posicion, #Planillon WHERE Fecha = FechaInforme  ORDER BY orden
     SET ARITHIGNORE OFF
     SET ARITHABORT  ON
END



GO
