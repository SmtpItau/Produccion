USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMPARA_RELACION_IBS_DRV]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_COMPARA_RELACION_IBS_DRV]
    (   @dFecha   DATETIME   )
AS
BEGIN    

   SET NOCOUNT ON

   DECLARE @NumPrest        NUMERIC(12)
   DECLARE @NumDrv          NUMERIC(12)
   DECLARE @FechaInicio 	DATETIME
   DECLARE @FechaVcto   	DATETIME
   DECLARE @Moneda          VARCHAR( 3)
   DECLARE @Plazo           NUMERIC(4)
   DECLARE @Mensaje         VARCHAR(1000)
   DECLARE @lFlag  		    INTEGER
   DECLARE @nCodEvento      INTEGER
   DECLARE @nCodError       NUMERIC(6)
   DECLARE @FechaContrato 	DATETIME
   DECLARE @iMax            INTEGER
   DECLARE @iMin            INTEGER  
   DECLARE @iMax_B          INTEGER
   DECLARE @iMin_B          INTEGER
   DECLARE @NumContratoDrv  NUMERIC(12)
   DECLARE @FechaContratodrv DATETIME
   DECLARE @ModuloDrv        VARCHAR(3)
   DECLARE @FechaInicioDrv   DATETIME
   DECLARE @FechaVctoDrv     DATETIME
   DECLARE @MonedaDrv        VARCHAR(3)
   DECLARE @PlazoDrv         NUMERIC(4)
   DECLARE @NumeroDrv        NUMERIC(12)
   DECLARE @DolarUSD         VARCHAR(3)
   DECLARE @habil			 VARCHAR(02)
   DECLARE @Tipo             VARCHAR(3)
   DECLARE @TipoDrv          VARCHAR(3)
   DECLARE @Monto            NUMERIC(20,4)-- FLOAT
   DECLARE @MontoDrv         NUMERIC(20,4)-- FLOAT
   DECLARE @RutCli           NUMERIC(9)
   DECLARE @CodCli           INTEGER
   DECLARE @RutCliDRV        NUMERIC(9)
   DECLARE @CodCliDRV        INTEGER
   DECLARE @Estado           VARCHAR(30)
   DECLARE @EstadoDrv        VARCHAR(30)
   DECLARE @Modulo           VARCHAR(3)
   DECLARE @RelacionPAE      NUMERIC(1)
   DECLARE @TipoAnticipo     VARCHAR(30)
   DECLARE @MsjeError        VARCHAR(1000)
   DECLARE @Evento           VARCHAR(50)
   DECLARE @SwError           NUMERIC(1)
   DECLARE @AnticipoDRV      VARCHAR(1)
   DECLARE @NomCli           VARCHAR(70)
   DECLARE @NomCliDrv        VARCHAR(70)
   
   
  
   DELETE dbo.TBL_ERRORES_RELACION_PAE  WHERE  FechaProceso = @dFecha

   SELECT @DolarUSD = mnnemo  FROM BacParamSuda.dbo.Moneda  WHERE  mncodmon = 13
   SET @SwError = 0

	SELECT  DISTINCT
      	 A.FechaProceso
		,A.NumPrestamo
		,A.CodigoProducto
		,A.CodigoFamilia
		,A.NumDerivado          
		,A.Tipo
		,A.FechaInicio
		,A.FechaVencimiento
		,A.Monto
		,A.CodigoTasa
		,A.TipoTasa
		,A.TasaCliente
		,A.Spread
		,A.MonedaPrestamo
		,A.RutCliente
		,A.TipoPlazo
		,A.Plazo
		,'Estado' = CASE WHEN A.EstadoOperacion = '' THEN 'Activa' END
        ,'Modulo' = CASE WHEN  A.Tipo = 'O' THEN 'OPC'
                         WHEN  A.Tipo = 'B' THEN 'BFW'
                         WHEN  A.Tipo = 'S' THEN 'PCS'
                    ELSE  'ANT' END
        ,'Anticipo' = ISNULL(B.TipoAnticipo,'')

        ,Puntero   = Identity(INT)
   INTO #TMP_TBL_PRESTAMOS_IBS

   FROM TBL_PRESTAMOS_IBS A LEFT OUTER JOIN  TBL_ANTICIPOS_IBS B ON A.NumPrestamo = B.NumPrestamo  AND A.NumDerivado = B.NumDerivado

   CREATE INDEX #ixt_#TMP_TBL_PRESTAMOS_IBS ON #TMP_TBL_PRESTAMOS_IBS (Puntero)

      SET @iMax        = (SELECT MAX(Puntero) FROM #TMP_TBL_PRESTAMOS_IBS)
      SET @iMin        = (SELECT MIN(Puntero) FROM #TMP_TBL_PRESTAMOS_IBS)

   SELECT	    'NumContrato'  = Det.CaNumContrato		
        ,		'Nro_Op'        = rtrim( Det.CaNumContrato ) + '-' + rtrim( Det.CaNumEstructura )
        ,       'FecContrato'   = Enc.CaFechaContrato
        ,       'CodProducto'   = Enc.CaCodEstructura 
        ,       'CompraVenta'  = Enc.CaCVEstructura
        ,       'Tipo'          = 'O'
        ,       'FechaInicio'   = Det.CaFechaInicioOpc
		,		'FechaVcto'     = Det.CaFechaVcto	
        ,		'MontoMon1'     = Det.CaMontoMon1
		,		'RutCli'        = Enc.CaRutCliente
		,		'CodCli'        = Enc.CaCodigo	
		,		'NomCli'        = Cl.Clnombre 
		,		'Compra_vende_MOneda'  = Det.CaCallPut 
		,		'Compra_Vende_Derecho' = Det.CaCVOpc		
		,		'GlosaMoneda1' = (SELECT mo.mnglosa 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Det.CaCodMon1)
        ,		'NemoMoneda1'  = (SELECT mo.mnnemo 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Det.CaCodMon1)
										
		,		'GLosaMoneda2' = (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Det.CaCodMon2)  
        ,		'NemoMoneda2' =	 (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Det.CaCodMon2)  
		,		'DescEstruct' = Est.OpcEstDsc 
		,		'CodMoneda1' = Det.CaCodMon1
		,		'CodMoneda2' = Det.CaCodMon2
        ,       'Plazo'  = DATEDIFF(DAY, Det.CaFechaInicioOpc, Det.CaFechaVcto)
        ,       'Estado' = CASE  WHEN Enc.CaEstado = ''  AND Det.CaFechaVcto >= @dFecha  THEN  'Activa' END
        ,       'Modulo' = 'OPC' 
        ,       'OpRelacionada' = Enc.CaRelacionaPAE
        ,       'AnticipoDRV' = Enc.CaEstado 
        INTO #TMP_TBL_CART
		FROM	Lnkopc.CbmdbOpc.dbo.cadetcontrato Det
				INNER JOIN Lnkopc.CbmdbOpc.dbo.CaEncContrato Enc ON	Enc.CaNumContrato = Det.CaNumContrato  AND Enc.CaEstado = ''
				INNER JOIN Lnkopc.CbmdbOpc.dbo.OpcionEstructura Est ON	Est.OpcEstCod = Enc.CaCodEstructura 
				INNER JOIN Bacparamsuda..Cliente  Cl ON	Enc.CaRutCliente = Cl.Clrut 
												   AND  Enc.CaCodigo     = Cl.Clcodigo

/********** Cartera Swap **********/ 
/*
        INSERT INTO #TMP_TBL_CART
        SELECT	'NumContrato'   = car.numero_operacion	
        ,		'Nro_Op'        = car.numero_operacion	 -- rtrim( Det.CaNumContrato ) + '-' + rtrim( Det.CaNumEstructura )
        ,       'FecContrato'   = Car.fecha_cierre
        ,       'CodProducto'   = Car.tipo_swap
        ,       'CompraVenta'  = Car.tipo_operacion
        ,       'Tipo'          = 'S'
        ,       'FechaInicio'   = Car.fecha_inicio
		,		'FechaVcto'     = Car.fecha_termino	
        ,		'MontoMon1'     = Car.compra_capital
		,		'RutCli'        = Car.rut_cliente
		,		'CodCli'        = Car.codigo_cliente	
		,		'NomCli'        = cli.Clnombre 
		,		'Compra_vende_MOneda'  = ''
		,		'Compra_Vende_Derecho' = ''
		,		'GlosaMoneda1' = (SELECT mo.mnglosa 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Car.compra_moneda)
        ,		'NemoMoneda1'  = (SELECT mo.mnnemo 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Car.compra_moneda)
										
		,		'GLosaMoneda2' = (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Car.venta_moneda)  
        ,		'NemoMoneda2' =	 (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Car.venta_moneda)  
		,		'DescEstruct' = '' 
		,		'CodMoneda1' = Car.compra_moneda
		,		'CodMoneda2' = Car.venta_moneda
        ,       'Plazo'  = DATEDIFF(DAY, Car.fecha_inicio, Car.fecha_termino)
        ,       'Estado' = CASE  WHEN Car.estado = ''  AND Car.fecha_termino >= @dFecha  THEN  'Activa' END
        ,       'Modulo' = 'PCS' 
        ,       'OpRelacionada' = ISNULL(Marca.MarcaRelacion, 0)
        ,       'AnticipoDRV' = CASE WHEN ( SELECT MAX(C2.numero_flujo) 
                                              FROM BacSwapSuda.dbo.CARTERA C2 
                                              WHERE car.numero_operacion = C2.Numero_operacion
                                             ) <> car.Numero_Flujo AND car.estado = 'N' THEN  '' ELSE  'N'  END

      FROM   BacSwapSuda.dbo.CARTERA car
             LEFT JOIN BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO  Marca ON Marca.Modulo = 'PCS'  AND  Marca.NumDerivado = car.numero_operacion
             LEFT JOIN BacSwapSuda.dbo.CARTERA    pas ON pas.numero_operacion = car.numero_operacion and pas.tipo_flujo = 2 
                                                     AND pas.numero_flujo     IN( SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA 
                                                                                   WHERE numero_operacion = pas.numero_operacion
   AND pas.tipo_flujo = 2)
LEFT  JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut      = car.rut_cliente AND cli.clcodigo = car.codigo_cliente
             LEFT  JOIN BacParamSuda.dbo.PRODUCTO pro ON pro.id_sistema = 'PCS' AND pro.codigo_producto = CASE WHEN car.tipo_swap = 1 THEN 'ST'
   WHEN car.tipo_swap = 2 THEN 'SM'
                  WHEN car.tipo_swap = 3 THEN 'FR'
                                                                                                               WHEN car.tipo_swap = 4 THEN 'SP'
                                                                                                          END
             LEFT  JOIN BacParamSuda.dbo.MONEDA   mna ON mna.mncodmon = car.compra_moneda
             LEFT  JOIN BacParamSuda.dbo.MONEDA   mnp ON mnp.mncodmon = pas.venta_moneda
      WHERE  car.numero_flujo      IN( SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA 
                                        WHERE numero_operacion = car.numero_operacion and car.tipo_flujo = 1)
      AND    car.tipo_flujo        = 1
      AND    car.estado            = ''
*/

/********** Cartera Swap **********/ 

/********** Cartera Forward **********/ 
/*

        INSERT INTO #TMP_TBL_CART
        SELECT	'NumContrato'   = car.canumoper
        ,		'Nro_Op'        = car.canumoper	 -- rtrim( Det.CaNumContrato ) + '-' + rtrim( Det.CaNumEstructura )
        ,       'FecContrato'   = car.cafecha
        ,       'CodProducto'   = car.cacodpos1
        ,       'CompraVenta'  =  car.catipoper
        ,       'Tipo'          = 'B'
        ,       'FechaInicio'   = car.cafecha
		,		'FechaVcto'     = car.cafecvcto
        ,		'MontoMon1'     = car.camtomon1
		,		'RutCli'        = car.cacodigo
		,		'CodCli'        = car.cacodcli
		,		'NomCli'        = cli.Clnombre 
		,		'Compra_vende_MOneda'  = ''
		,		'Compra_Vende_Derecho' = ''
		,		'GlosaMoneda1' = (SELECT mo.mnglosa 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = car.cacodmon1)
        ,		'NemoMoneda1'  = (SELECT mo.mnnemo 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = car.cacodmon1)
										
		,		'GLosaMoneda2' = (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = car.cacodmon2)  
        ,		'NemoMoneda2' =	 (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = car.cacodmon2)  
		,		'DescEstruct' = '' 
		,		'CodMoneda1' = car.cacodmon1
		,		'CodMoneda2' = car.cacodmon2
        ,       'Plazo'  = DATEDIFF(DAY, car.cafecha, car.cafecvcto)
        ,       'Estado' = CASE  WHEN car.caestado = ''  AND car.cafecvcto >= @dFecha  THEN  'Activa' END
        ,       'Modulo' = 'BFW' 
        ,       'OpRelacionada' = ISNULL(Marca.MarcaRelacion, 0)
        ,       'AnticipoDRV' = CASE WHEN car.caantici = 'A' and car.canumoper = car.numerocontratocliente THEN 'N' ELSE '' END   -- se asigna N cuandomes anticipo Total.
      FROM   BacFwdSuda.dbo.MFCA                  car
             LEFT JOIN BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO  Marca ON Marca.Modulo = 'BFW'  AND  Marca.NumDerivado = car.canumoper
             LEFT  JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut      = car.cacodigo AND cli.clcodigo = car.cacodcli
             INNER JOIN BacParamSuda.dbo.PRODUCTO pro ON pro.id_sistema = 'BFW'        AND CONVERT(INTEGER, pro.codigo_producto) = car.cacodpos1
             LEFT  JOIN BacParamSuda.dbo.MONEDA   act ON act.mncodmon   = car.cacodmon1
             LEFT  JOIN BacParamSuda.dbo.MONEDA   pas ON pas.mncodmon   = car.cacodmon2
      WHERE  car.caestado       = ''
*/         

/********** Cartera Forward **********/ 

        SELECT	NumContrato
        ,		Nro_Op
        ,       FecContrato
        ,       CodProducto
        ,       CompraVenta
        ,       Tipo
        ,       FechaInicio
		,		FechaVcto
        ,		MontoMon1
		,		RutCli
		,		CodCli
		,		NomCli
		,		Compra_vende_MOneda
		,		Compra_Vende_Derecho
		,		GlosaMoneda1
        ,		NemoMoneda1 										
		,		GLosaMoneda2
        ,		NemoMoneda2
		,		DescEstruct
		,		CodMoneda1
		,		CodMoneda2
        ,       Plazo
        ,       Estado
        ,     Modulo
        ,       OpRelacionada
        ,       AnticipoDRV
        ,       'Puntero'  = Identity(INT)
   INTO #TMP_TBL_CARTERA_DRV
   FROM #TMP_TBL_CART

   CREATE INDEX #ixt_#TMP_TBL_CARTERA_DRV ON #TMP_TBL_CARTERA_DRV (Puntero)


/********** Validación desde datos de Archivo de préstamos IBS a  Cartera Derivasdos Opciones **********/ 

   WHILE @iMax >= @iMin
   BEGIN
      SELECT @NumPrest        = NumPrestamo
      ,      @NumDrv          = NumDerivado
      ,      @FechaInicio     = FechaInicio
      ,      @FechaVcto       = FechaVencimiento
      ,      @Tipo            = Tipo 
      ,      @Moneda          = MonedaPrestamo      
      ,      @Monto           = Monto
      ,      @Plazo           = Plazo 
      ,      @Estado          = Estado  
      ,      @Modulo          = Modulo
      ,      @TipoAnticipo    = Anticipo
      ,      @RutCli          = RutCliente      
      FROM   #TMP_TBL_PRESTAMOS_IBS
      WHERE  Puntero          = @iMin

         SET @lFlag = 0
         set @Mensaje = ''

         SET @iMax_B        = (SELECT MAX(Puntero) FROM #TMP_TBL_CARTERA_DRV)
         SET @iMin_B        = (SELECT MIN(Puntero) FROM #TMP_TBL_CARTERA_DRV)
         set @MsjeError  = ''
         WHILE @iMax_B >= @iMin_B
         BEGIN
 
                    SELECT   DISTINCT
				             @NumContratoDrv   = NumContrato
                      ,      @FechaContratodrv = FecContrato  -- CaFechaContrato
                      ,     @TipoDrv          = Tipo
					  ,      @FechaInicioDrv   = FechaInicio  -- CaFechaInicioOpc
					  ,      @FechaVctoDrv     = FechaVcto    -- CaFechaVcto
					  ,      @MonedaDrv        = NemoMoneda1      
                      ,      @MontoDrv         = MontoMon1    -- CaMontoMon1
					  ,      @PlazoDrv         = Plazo 
                      ,      @EstadoDrv        = Estado 
                      ,      @ModuloDrv        = Modulo 
                      ,      @RelacionPAE      = OpRelacionada
                      ,      @RutCliDrv        = RutCli
                      ,      @CodCliDrv        = CodCli
                      ,      @AnticipoDRV      = AnticipoDRV
                      ,      @NomCliDrv        = NomCli
                     FROM   #TMP_TBL_CARTERA_DRV
                     WHERE  Puntero          = @iMin_B
                       AND  Modulo           = @Modulo           
                   
                     IF @NumDrv   =  @NumContratoDrv  
                     BEGIN                         
                        
                        SET @SwError = 0 
                        SET @lFlag = 1  -- si se encuentra derivado..  
                        SET @nCodEvento = 10                         
                        SET @Evento = ' ' + LTRIM(RTRIM((SELECT DISTINCT tbglosa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 8600 AND tbvalor = @nCodEvento) ))+ ': '                                             

                        IF @RelacionPAE = 0
                        BEGIN                         
                   
							 SET @nCodError = 14      
                             SET @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                             SET @SwError = 1
                        END 

                        IF  @FechaInicio <> @FechaInicioDrv                              
                        BEGIN
                   
                              SET @nCodError = 1                      
                              SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                 SET @SwError = 1   
                        END
                        
              
                        EXECUTE BacParamSuda.dbo.SP_DETECTA_FECHA_HABIL_INHABIL @FechaInicio, @habil output
                        
                       IF  @habil = 'NO'
                        BEGIN
                   
                            SET @nCodError = 3
                            SET @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                            SET @SwError = 1
                        END
                        
                        IF  @FechaVcto <> @FechaVctoDrv                                                   
                        BEGIN 

                              SET @nCodError = 2
                              SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                              SET @SwError = 1
                        END

                        EXECUTE BacParamSuda.dbo.SP_DETECTA_FECHA_HABIL_INHABIL @FechaVcto, @habil output
                        IF  @habil = 'NO'                        BEGIN

                             SET @nCodError = 4
                             SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                             SET @SwError = 1 
                        END


                        IF  (@Moneda <> @MonedaDrv )
                        BEGIN

                          SET @nCodError = 20
                              SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                              SET @SwError = 1
                        END


                        IF  (@Plazo > 180 OR  @PlazoDrv > 180) AND @MonedaDrv = 'OPC'
                        BEGIN

                              SET @nCodError = 6
                              SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                              SET @SwError = 1 
                        END                

                        IF  (@TipoAnticipo <> @AnticipoDRV)   
                        BEGIN      
                            IF @AnticipoDRV = 'N'  and @TipoAnticipo  <> 'Pago Total' 
                            BEGIN                                                    

                              SET @nCodError = 19
                              SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                              SET @SwError = 1
                            END
                            IF @TipoAnticipo = 'Pago Total' and   @AnticipoDRV <> 'N'  
                            BEGIN

                              SET @nCodError = 18
                              SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                              SET @SwError = 1                 
                            
                            END  
                   END 
 
     
                       IF  (@TipoAnticipo <> 'Pago Total'  and @TipoAnticipo <> '' )
                        BEGIN  

                              SET @nCodError = 15
                              SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                              SET @SwError = 1
          END


					
                        IF  (@Plazo <> @PlazoDrv)
                        BEGIN

                              SET @nCodError = 9
                              SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) )) 
                              SET @SwError = 1
                        END
 

                        
                        IF   @Tipo   <>  @TipoDrv 
                        BEGIN 

                             SET @nCodError = 10
                             SET  @MsjeError  = @MsjeError  + ' '  + LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                             SET @SwError = 1
                        END
                        

                        IF   @Monto   <>  @MontoDrv
                        BEGIN

                             SET @nCodError = 11
                             SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                             SET @SwError = 1
                        END

                        IF   @RutCli   =  0
                        BEGIN                             
                             SET @nCodError = 17                             
                             SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                             SET @SwError = 1
                        END


                        IF   @RutCli   <>  @RutCliDRV
                        BEGIN                             
                             SET @nCodError = 12                             
                             SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                             SET @SwError = 1
                        END

                        IF   @Estado <> @EstadoDrv
                        BEGIN

                             SET @nCodError = 13
                             SET  @MsjeError  = @MsjeError  + ' '  +  LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                             SET @SwError = 1
                        END 

                       IF @SwError = 0 
                       BEGIN 
                                SET @Evento = ''
                       END

                            SET @MsjeError = @Evento  + @MsjeError 

                        SET @SwError = 0                       

                                               
                        
                        IF @MsjeError = ''
                        BEGIN 
                               SET @nCodEvento = 7
                           SET @Evento = ' ' + LTRIM(RTRIM((SELECT DISTINCT tbglosa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 8600 AND tbvalor = @nCodEvento) ))+ ': '                                              
                        SET @MsjeError = @MsjeError +   @Evento   
                        END


						SET @Mensaje  = ' Se ha generado evento ' 
                        + @MsjeError 
                        + ', sobre el derivado N° : ' + LTRIM(RTRIM( @NumContratoDrv ))
                        + ', el cual se encuentra asociado al crédito N°: '  + LTRIM(RTRIM( @NumPrest ))                            						   
                        + ', Rut Cliente : ' + LTRIM(RTRIM( @RutCliDrv ))
                        + ', Nombre Cliente : ' + LTRIM(RTRIM( @NomCliDrv ))
                        + ', Monto : ' +  CONVERT (VARCHAR,@MontoDrv)
                        + ', Moneda : ' + LTRIM(RTRIM( @MonedaDrv )) 
           + ', Plazo : ' + LTRIM(RTRIM( @PlazoDrv )) + ' Días.'
   
    
                        IF @nCodEvento  = 7 
                        BEGIN 

         
                               IF NOT EXISTS( SELECT 1 FROM BacParamSuda.dbo.RELACION_CREDITO_DERIVADO
							   WHERE Numero_Credito  = @NumPrest 
							   AND Numero_Derivado   = @NumContratoDrv 
							   AND Modulo_Derivado   = @ModuloDrv
                               AND RutCliente        = @RutCliDrv
                               AND @Monto            = @MontoDrv
                               AND @Moneda           = @MonedaDrv
                               AND @Plazo            = @PlazoDrv)  
                               BEGIN
                                
						
									INSERT INTO BacParamSuda.dbo.RELACION_CREDITO_DERIVADO
										(   Fecha_Relacion
										,   Numero_Credito
										,   Numero_Derivado
										,   Modulo_Derivado
									    ,   Producto_Derivado
										,   Ajuste_Nocionales
										,   Estado
										,   RutCliente
										,   CodCliente
			
										)
										VALUES
										(   @dFecha
										,   @NumPrest
										,   @NumContratoDrv
										,   CONVERT(CHAR(3),@ModuloDrv)
										,   0
										,   'N'
										,   0
										,   @RutCliDRV
										,   1
										)
							    
                            
								END                            

                             
                        END 

							 		
                        BREAK           

		 		 END
                 ELSE
                     BEGIN                                                  
                                                    
                            SET @lFlag = 0 
                            SET @nCodEvento = 10        
                            SET @nCodError = 7         

      

					  END                               
  

                SET @iMin_B = @iMin_B + 1               
                 
  
                 END


                  IF @lFlag = 0 
                   BEGIN  




                            SET @Mensaje  = ' Se ha generado evento ' 
                            + LTRIM(RTRIM((SELECT DISTINCT tbglosa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 8600 AND tbvalor = @nCodEvento) ))+ '. '
                            + LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                            + ', derivado N° : ' + LTRIM(RTRIM( @NumDrv ))
                            + ', el cual se encuentra asociado al crédito N°: '  + LTRIM(RTRIM( @NumPrest ))                          
                            + ', Rut Cliente : ' + LTRIM(RTRIM( @RutCli ))
                            + ', Monto : ' +  CONVERT (VARCHAR,@Monto)
                            + ', Moneda : ' + LTRIM(RTRIM( @Moneda )) 
                            + ', Plazo : ' + LTRIM(RTRIM( @Plazo )) + ' Días.'
        
                            

                            IF @NumDrv = 0 
                            BEGIN                               
                              SET @Mensaje  = ' Préstamo Antiguo '  
                              + ', crédito N°: '  + LTRIM(RTRIM( @NumPrest ))                          
                            END 
              
                                                                    
                            INSERT INTO dbo.TBL_ERRORES_RELACION_PAE   
							SELECT @dFecha 
                                 , @Modulo
                                 , @NumPrest
                                 , @NumDrv
                                 , @Mensaje
                                 , ISNULL(@nCodEvento,'') 
                 
                

                       SET @iMin = @iMin + 1 
         END

                   ELSE
                  BEGIN 


        IF @nCodEvento <>  7
        BEGIN
            INSERT INTO dbo.TBL_ERRORES_RELACION_PAE   
							SELECT @dFecha 
                                 , @Modulo
                                 , @NumPrest
                                 , @NumDrv
                                 , @Mensaje
                                , ISNULL(@nCodEvento,'') 
                    
        END
        ELSE
        BEGIN
           IF  EXISTS( SELECT 1 FROM BacParamSuda.dbo.RELACION_CREDITO_DERIVADO
			   WHERE Numero_Credito  = @NumPrest 
			   AND Numero_Derivado   = @NumContratoDrv 
			   AND Modulo_Derivado   = @ModuloDrv
               AND RutCliente        = @RutCliDrv
               AND @Monto            = @MontoDrv
               AND @Moneda           = @MonedaDrv
               AND @Plazo            = @PlazoDrv
               AND Fecha_Relacion    = @dFecha )  
              BEGIN 
                   INSERT INTO dbo.TBL_ERRORES_RELACION_PAE   
							SELECT @dFecha 
                                 , @Modulo
                                 , @NumPrest
                                 , @NumDrv
                                 , @Mensaje
                                , ISNULL(@nCodEvento,'') 

              END 
              

           END
      
      
            SET @iMin = @iMin + 1 

             
                         
    END  
             
        
   END
/********** Validación desde datos de Archivo de préstamos IBS a  Cartera Derivasdos Opciones **********/ 
  
/* Cartera  OPCIONES  */
   SELECT	    'NumContrato'  = Det.CaNumContrato		
        ,		'Nro_Op'       = rtrim( Det.CaNumContrato ) + '-' + rtrim( Det.CaNumEstructura )
        ,       'FecContrato'  = Enc.CaFechaContrato
        ,       'CodProducto'  = Enc.CaCodEstructura 
        ,       'CompraVenta' = Enc.CaCVEstructura
        ,       'Tipo'         = 'O'
        ,       'FechaInicio'  = Det.CaFechaInicioOpc
		,		'FechaVcto'    = Det.CaFechaVcto	
        ,		'MontoMon1'    = Det.CaMontoMon1
		,		'RutCli'       = Enc.CaRutCliente
		,		'CodCli'       = Enc.CaCodigo	
		,		'NomCli'       = Cl.Clnombre 
		,		'Compra_vende_MOneda' = Det.CaCallPut 
		,		'Compra_Vende_Derecho' = Det.CaCVOpc		
		,		'GlosaMoneda1' = (SELECT mo.mnglosa 
		 		             FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Det.CaCodMon1)
        ,		'NemoMoneda1' = (SELECT mo.mnnemo 
		 		             FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Det.CaCodMon1)
										
		,		'GLosaMoneda2' =	(SELECT mo.mnglosa
		 		           	 FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Det.CaCodMon2)  
        ,		'NemoMoneda2' =	(SELECT mo.mnglosa
		 		           	 FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Det.CaCodMon2)  
		,		'DescEstruct' = Est.OpcEstDsc 
		,		'CodMoneda1' = Det.CaCodMon1
		,		'CodMoneda2' = Det.CaCodMon2
        ,       'Plazo'  = DATEDIFF(DAY, Det.CaFechaInicioOpc, Det.CaFechaVcto)
        ,       'Estado' = CASE  WHEN Enc.CaEstado = ''  AND Det.CaFechaVcto >= @dFecha  THEN  'Activa' END
        ,       'Modulo' = 'OPC' 
        ,       'OpRelacionada' = Enc.CaRelacionaPAE
        ,       'AnticipoDRV' = Enc.CaEstado 
        INTO #TMP_TBL_CART_2
		FROM	Lnkopc.CbmdbOpc.dbo.cadetcontrato Det
				INNER JOIN Lnkopc.CbmdbOpc.dbo.CaEncContrato Enc ON	Enc.CaNumContrato = Det.CaNumContrato AND Enc.CaEstado = '' AND Enc.CaRelacionaPAE = 1  
				INNER JOIN Lnkopc.CbmdbOpc.dbo.OpcionEstructura Est ON	Est.OpcEstCod = Enc.CaCodEstructura 
				INNER JOIN Bacparamsuda..Cliente  Cl ON	Enc.CaRutCliente = Cl.Clrut 
												   AND  Enc.CaCodigo     = Cl.Clcodigo
/* Cartera  OPCIONES  */


/* Cartera  SWAP  */
/*
        INSERT INTO #TMP_TBL_CART_2
        SELECT	'NumContrato'   = car.numero_operacion	
        ,		'Nro_Op'        = car.numero_operacion	 
        ,       'FecContrato'   = Car.fecha_cierre
        ,       'CodProducto'   = Car.tipo_swap
        ,       'CompraVenta'  = Car.tipo_operacion
        ,   'Tipo'          = 'S'
        ,       'FechaInicio'   = Car.fecha_inicio
		,		'FechaVcto'     = Car.fecha_termino	
        ,		'MontoMon1'     = Car.compra_capital
		,		'RutCli'        = Car.rut_cliente
		,		'CodCli'        = Car.codigo_cliente	
		,		'NomCli'        = cli.Clnombre 
		,		'Compra_vende_MOneda'  = ''
		,		'Compra_Vende_Derecho' = ''
		,		'GlosaMoneda1' = (SELECT mo.mnglosa 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Car.compra_moneda)
        ,		'NemoMoneda1'  = (SELECT mo.mnnemo 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = Car.compra_moneda)
										
		,		'GLosaMoneda2' = (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Car.venta_moneda)  
 ,		'NemoMoneda2' =	 (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = Car.venta_moneda)  
		,		'DescEstruct' = '' 
		,		'CodMoneda1' = Car.compra_moneda
		,		'CodMoneda2' = Car.venta_moneda
        ,       'Plazo'  = DATEDIFF(DAY, Car.fecha_inicio, Car.fecha_termino)
        ,       'Estado' = CASE  WHEN Car.estado = ''  AND Car.fecha_termino >= @dFecha  THEN  'Activa' END
        ,       'Modulo' = 'PCS' 
        ,       'OpRelacionada' = ISNULL(Marca.MarcaRelacion, 0)
        ,       'AnticipoDRV' = CASE WHEN ( SELECT MAX(C2.numero_flujo) 
                                              FROM BacSwapSuda.dbo.CARTERA C2 
                                              WHERE car.numero_operacion = C2.Numero_operacion
                                             ) <> car.Numero_Flujo AND car.estado = 'N' THEN  '' ELSE  'N'  END
--        ,        Puntero  = Identity(INT)
      FROM   BacSwapSuda.dbo.CARTERA car
             RIGHT JOIN BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO  Marca ON Marca.Modulo = 'PCS'  AND  Marca.NumDerivado = car.numero_operacion AND Marca.MarcaRelacion = 1
             LEFT JOIN BacSwapSuda.dbo.CARTERA    pas ON pas.numero_operacion = car.numero_operacion and pas.tipo_flujo = 2 
                                                     AND pas.numero_flujo     IN( SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA 
                                                                                   WHERE numero_operacion = pas.numero_operacion
                                                                                     AND pas.tipo_flujo = 2)
             LEFT  JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut      = car.rut_cliente AND cli.clcodigo = car.codigo_cliente
             LEFT  JOIN BacParamSuda.dbo.PRODUCTO pro ON pro.id_sistema = 'PCS' AND pro.codigo_producto = CASE WHEN car.tipo_swap = 1 THEN 'ST'
                                                                                                               WHEN car.tipo_swap = 2 THEN 'SM'
                                                                                         WHEN car.tipo_swap = 3 THEN 'FR'
                                                                                                               WHEN car.tipo_swap = 4 THEN 'SP'
                                                                                                          END
             LEFT  JOIN BacParamSuda.dbo.MONEDA   mna ON mna.mncodmon = car.compra_moneda
             LEFT  JOIN BacParamSuda.dbo.MONEDA   mnp ON mnp.mncodmon = pas.venta_moneda
      WHERE  car.numero_flujo      IN( SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.CARTERA 
                                        WHERE numero_operacion = car.numero_operacion and car.tipo_flujo = 1)
      AND    car.tipo_flujo        = 1
      AND    car.estado            = ''

*/
/* Cartera  SWAP  */


/********** Cartera Forward **********/ 

/*
        INSERT INTO #TMP_TBL_CART_2
        SELECT	'NumContrato'   = car.canumoper
        ,		'Nro_Op'        = car.canumoper	 
        ,       'FecContrato'   = car.cafecha
        ,       'CodProducto'   = car.cacodpos1
        ,       'CompraVenta'  =  car.catipoper
        ,       'Tipo'          = 'B'
        ,       'FechaInicio'   = car.cafecha
		,		'FechaVcto'     = car.cafecvcto
        ,		'MontoMon1'     = car.camtomon1
		,		'RutCli'        = car.cacodigo
		,		'CodCli'        = car.cacodcli
		,		'NomCli'        = cli.Clnombre 
		,		'Compra_vende_MOneda'  = ''
		,		'Compra_Vende_Derecho' = ''
		,		'GlosaMoneda1' = (SELECT mo.mnglosa 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = car.cacodmon1)
        ,		'NemoMoneda1'  = (SELECT mo.mnnemo 
		 		                  FROM 	BacParamSuda..Moneda Mo WHERE Mo.mncodmon = car.cacodmon1)
										
		,		'GLosaMoneda2' = (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = car.cacodmon2)  
        ,		'NemoMoneda2' =	 (SELECT mo.mnglosa
		 		           	      FROM	BacParamSuda..Moneda Mo WHERE   Mo.mncodmon = car.cacodmon2)  
		,		'DescEstruct' = '' 
		,		'CodMoneda1' = car.cacodmon1
		,		'CodMoneda2' = car.cacodmon2
        ,       'Plazo'  = DATEDIFF(DAY, car.cafecha, car.cafecvcto)
        ,       'Estado' = CASE  WHEN car.caestado = ''  AND car.cafecvcto >= @dFecha  THEN  'Activa' END
        ,       'Modulo' = 'BFW' 
        ,       'OpRelacionada' = ISNULL(Marca.MarcaRelacion, 0)
        ,       'AnticipoDRV' = CASE WHEN car.caantici = 'A' and car.canumoper = car.numerocontratocliente THEN 'N' ELSE '' END   -- se asigna N cuandomes anticipo Total.
      FROM   BacFwdSuda.dbo.MFCA                  car
             RIGHT JOIN BacParamSuda.dbo.TBL_MARCA_ESTRUCTURADO  Marca ON Marca.Modulo = 'BFW'  AND  Marca.NumDerivado = car.canumoper AND Marca.MarcaRelacion = 1
             LEFT  JOIN BacParamSuda.dbo.CLIENTE  cli ON cli.clrut      = car.cacodigo AND cli.clcodigo = car.cacodcli
             INNER JOIN BacParamSuda.dbo.PRODUCTO pro ON pro.id_sistema = 'BFW'        AND CONVERT(INTEGER, pro.codigo_producto) = car.cacodpos1
             LEFT  JOIN BacParamSuda.dbo.MONEDA   act ON act.mncodmon   = car.cacodmon1
             LEFT  JOIN BacParamSuda.dbo.MONEDA   pas ON pas.mncodmon   = car.cacodmon2
      WHERE  car.caestado       = ''
*/
         
/********** Cartera Forward **********/ 

        SELECT	NumContrato
        ,		Nro_Op
        ,       FecContrato
        ,       CodProducto
        ,       CompraVenta
        ,       Tipo
        ,       FechaInicio
		,		FechaVcto
        ,		MontoMon1
		,		RutCli
		,		CodCli
		,		NomCli
		,		Compra_vende_MOneda
		,		Compra_Vende_Derecho
		,		GlosaMoneda1
        ,		NemoMoneda1 										
		,		GLosaMoneda2
       ,		NemoMoneda2
		,		DescEstruct
		,		CodMoneda1
		,		CodMoneda2
        ,       Plazo
        ,       Estado
        ,       Modulo
        ,       OpRelacionada
        ,       'Puntero'  = Identity(INT)
   INTO #TMP_TBL_CARTERA_DRV_RELACIONADA
   FROM #TMP_TBL_CART_2


    SET @iMax_B        = (SELECT MAX(Puntero) FROM #TMP_TBL_CARTERA_DRV_RELACIONADA)  
    SET @iMin_B        = (SELECT MIN(Puntero) FROM #TMP_TBL_CARTERA_DRV_RELACIONADA)

/********** Validación desde Cartera Derivasdos Opciones a datos de Archivo de préstamos IBS **********/ 

    WHILE @iMax_B >= @iMin_B
         BEGIN
 
                    SELECT   DISTINCT
				        @NumContratoDrv   = NumContrato -- CaNumContrato
                      ,      @FechaContratodrv = FecContrato -- CaFechaContrato
                      ,      @TipoDrv          = Tipo
					  ,      @FechaInicioDrv   = FechaInicio
					  ,      @FechaVctoDrv     = FechaVcto
					  ,      @MonedaDrv        = NemoMoneda1      
                      ,      @MontoDrv         = MontoMon1
					  ,      @PlazoDrv         = Plazo 
                      ,      @EstadoDrv  = Estado 
                      ,      @ModuloDrv        = Modulo 
                      ,      @RelacionPAE      = OpRelacionada    
                      ,      @RutCliDrv        = RutCli 
                      ,      @NomCliDrv        = NomCli  
                     FROM   #TMP_TBL_CARTERA_DRV_RELACIONADA
                     WHERE  Puntero          = @iMin_B                     
               
                 
                 SET @iMax        = (SELECT MAX(Puntero) FROM #TMP_TBL_PRESTAMOS_IBS)
                 SET @iMin        = (SELECT MIN(Puntero) FROM #TMP_TBL_PRESTAMOS_IBS)     


     WHILE @iMax >= @iMin
                 BEGIN
	    		  SELECT @NumPrest        = NumPrestamo
                  ,      @NumDrv          = NumDerivado
                  ,      @FechaInicio     = FechaInicio
                  ,      @FechaVcto       = FechaVencimiento
                  ,      @Tipo            = Tipo 
                  ,      @Moneda          = MonedaPrestamo      
                  ,      @Monto           = Monto
                  ,      @Plazo           = Plazo 
                  ,      @Estado          = Estado  
                  ,      @Modulo          = Modulo
                  ,      @TipoAnticipo    = Anticipo
                  ,      @RutCli          = RutCliente 
                 FROM   #TMP_TBL_PRESTAMOS_IBS
                 WHERE  Puntero          = @iMin

              
                  IF @NumContratoDrv = @NumDrv 
                  BEGIN                         
                        
                    SET @SwError = 0 
                    SET @lFlag = 1  -- si se encuentra derivado..  
                    SET @nCodEvento = 10                         
                    SET @Evento = ' ' + LTRIM(RTRIM((SELECT DISTINCT tbglosa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 8600 AND tbvalor = @nCodEvento) ))+ ': '                                             
                    BREAK

                  END
                  ELSE 
                  BEGIN  

                       SET @lFlag = 0 
                       SET @nCodEvento = 10        
                       SET @nCodError = 16                              
               END



                  SET @iMin = @iMin + 1 

                END                   

                                 
                  IF @lFlag = 0 
                   BEGIN  

                            SET @Mensaje  = ' Se ha generado evento ' 
                            + LTRIM(RTRIM((SELECT DISTINCT tbglosa FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE WHERE tbcateg = 8600 AND tbvalor = @nCodEvento) ))+ '. '
                            + LTRIM(RTRIM((SELECT DISTINCT Descripcion FROM BacTraderSuda.dbo.TBL_ERRORES_PAE WHERE Codigo = @nCodError) ))
                            + ', derivado N° : ' + LTRIM(RTRIM( @NumContratoDrv ))+ '. '
                            + ', Rut Cliente : ' + LTRIM(RTRIM( @RutCliDrv ))
                            + ', Nombre Cliente : ' + LTRIM(RTRIM( @NomCliDrv ))
                            + ', Monto : ' +  CONVERT (VARCHAR,@MontoDrv)
                            + ', Moneda : ' + LTRIM(RTRIM( @MonedaDrv )) 
                            + ', Plazo : ' + LTRIM(RTRIM( @PlazoDrv )) + ' Días.'

--                             + ' Datos de Contrato : ' + LTRIM(RTRIM( @RutCliDrv ))+  LTRIM(RTRIM( @NomCliDrv ))+  LTRIM(RTRIM( @MontoDrv ))+  LTRIM(RTRIM( @MonedaDrv )) +  LTRIM(RTRIM( @PlazoDrv ))+'. '


                            INSERT INTO dbo.TBL_ERRORES_RELACION_PAE   
							SELECT @dFecha 
                                 , @ModuloDrv
                                 , 0
                                 , @NumContratoDrv 
                                 , @Mensaje
                                 , ISNULL(@nCodEvento,'') 
                    
      

                           SET @iMin = @iMin + 1 
                   END             

                SET @iMin_B = @iMin_B + 1               
                 
  
   END

/********** Validación desde Cartera Derivasdos Opciones a datos de Archivo de préstamos IBS **********/ 
        
END
GO
