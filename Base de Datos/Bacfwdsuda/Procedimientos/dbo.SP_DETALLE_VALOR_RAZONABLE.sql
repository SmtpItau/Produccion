USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_VALOR_RAZONABLE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DETALLE_VALOR_RAZONABLE]
   (   @Fecha_Proceso   DATETIME
   ,   @Fecha_Proxima   DATETIME
   ,   @Fecha_Anterior  DATETIME
   ,   @Tipo_Valoriza   CHAR(2)   = ''
   )
AS
BEGIN

   -- @Tipo_Valoriza = '' --> NORMAL  -  @Tipo_Valoriza = 'BT' --> BACK TEST

   SET NOCOUNT ON

   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos
   DECLARE @FechaCalculos    DATETIME
       SET @FechaCalculos    = CASE WHEN DATEPART(MONTH, @Fecha_Proceso) = DATEPART(MONTH, @Fecha_Proxima) THEN @Fecha_Proceso
                                    ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, @Fecha_Proceso)) *-1, DATEADD(MONTH, 1, @Fecha_Proceso) )
                               END
   --> Asigna fecha de cierre de Mes <-- Para valores de Monedas y Calculos


   CREATE TABLE #MFCA_TEMPORAL
   (   Nro_Contrato              numeric  (10,0)
   ,   Producto                  numeric  (05,0)
   ,   Tipo_Operacion            char     (1)
   ,   Moneda_Contrato           numeric  (05,0)
   ,   D_M_Mda1                  char     (1)
   ,   Moneda_Pago               numeric  (05,0)
   ,   VC                        float             NULL
   ,   Spot_ini                  float             NULL
   ,   Fecha_Inicio_Contrato     datetime
   ,   Fecha_Efec_Fin_Contrato   datetime
   ,   fecha_Fin_Contrato        datetime
   ,   M                         numeric  (21,4)
   ,   PF                        float             NULL
   ,   Tm2                       float             NULL
   ,   TCM_Mon_Cont_Mda_Pago     float             NULL
   ,   Spot_Compra               float             NULL
   ,   Spot_Venta                float             NULL
   ,   Spot                      float             NULL
   ,   Valor_Razonable           float             NULL
   ,   Fclp                      float             NULL
   ,   FF_Cont                   float
   ,   P_cont                    int
   ,   P                         int
   ,   P_Efec                    int
   ,   Base                      numeric (19,8)
   ,   Resultado_devengo         FLOAT --> numeric (19,8)
   ,   Resultado_Tasa            FLOAT --> numeric (19,8)
   ,   Resultado_Moneda          FLOAT --> numeric (19,8)
   )

   CREATE NONCLUSTERED INDEX MFCA_TEMPORAL_001 ON #MFCA_TEMPORAL (Nro_Contrato)
   CREATE NONCLUSTERED INDEX MFCA_TEMPORAL_002 ON #MFCA_TEMPORAL (Producto)

   SELECT 'VmCodigo'      = Codigo_moneda 
   ,      'VmValor'       = Tipo_cambio 
   INTO   #TC_CONTABLE_TEMPORAL
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
   WHERE  1 = 2

   CREATE NONCLUSTERED INDEX TCCONTABLETEMPORAL_001 ON #TC_CONTABLE_TEMPORAL (VmCodigo)

   INSERT INTO #TC_CONTABLE_TEMPORAL
   SELECT 13
   ,      Tipo_Cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   
   WHERE  Fecha         = @Fecha_Proceso
   AND    Codigo_Moneda = 994

   INSERT INTO #TC_CONTABLE_TEMPORAL
   SELECT Codigo_Moneda
   ,      Tipo_Cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
   WHERE  Fecha          = @Fecha_Proceso
   AND    Codigo_Moneda  NOT IN(13,994,995,997,998,999)
   AND    Tipo_Cambio   <> 0.0

   INSERT INTO #TC_CONTABLE_TEMPORAL
   SELECT vmcodigo
   ,      vmvalor
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE  vmfecha          = @Fecha_Proceso
   AND    vmcodigo         IN(995, 997, 999) --> IN(995,997,998,999)

   INSERT INTO #TC_CONTABLE_TEMPORAL
   SELECT vmcodigo
   ,      vmvalor
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE  vmfecha          = @FechaCalculos
   AND    vmcodigo         IN(998)

   INSERT INTO #TC_CONTABLE_TEMPORAL
   SELECT 999
   ,      1

   IF @Tipo_Valoriza = '' 
   BEGIN
      INSERT INTO #MFCA_TEMPORAL
      SELECT   'Nro_Contrato'		= Canumoper 
      ,        'Producto'		= caCodPos1           
      ,        'Tipo_Operacion'		= CaTipOper           
      ,        'Moneda_Contrato'	= Cacodmon1           
      ,        'D_M_Mda1'		= ISNULL(mnrrda,'')   
      ,        'Moneda_Pago'		= CaCodMon2           
      ,        'VC'			= (CASE WHEN (ISNULL(mnrrda,'')) = 'M' THEN catipCam 
						ELSE 1.0 / catipCam END)       
      --       Si es UF debe convertir precio inicial a UF.
      ,        'Spot_ini'			= ( CASE WHEN (ISNULL(mnrrda,'')) = 'M' 
							 THEN catipcamSpot / ( CASE WHEN CaCodMon2 = 998 
										    THEN  ( SELECT vmvalor FROM BACPARAMSUDA..VALOR_MONEDA
											    WHERE vmcodigo = cacodmon2 AND vmfecha = cafecha ) 
										    ELSE 1 END )
							 ELSE 1.0/ catipcamSpot / ( CASE WHEN CaCodMon2 = 998 
										         THEN  ( SELECT vmvalor FROM BACPARAMSUDA..VALOR_MONEDA
											         WHERE vmcodigo = cacodmon2 AND vmfecha = cafecha ) 
											 ELSE 1 END ) 
							 END )   
      ,        'Fecha_Inicio_Contrato'	= caFecha             
      ,        'Fecha_Efec_Fin_Contrato'= cafecEfectiva       
      ,        'fecha_Fin_Contrato'	= CaFecVcto           
      ,        'M'			= caMtoMon1           
      ,        'PF'			= CASE WHEN (ISNULL(mnrrda,'')) = 'M' 
					       THEN fVal_Obtenido 
					       ELSE 1.0/ fVal_Obtenido 
                                          END       
      ,        'Tm2'			= CAtasasinteticam2   
      ,        'TCM_Mon_Cont_Mda_Pago'	= ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL WHERE vmcodigo = CaCodMon2 )  
      ,        'Spot_Compra'		= CaPrecioSpotCompraM1 / ( CASE WHEN CaCodMon2 = 998 
										THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
											WHERE vmcodigo = CaCodMon2 ) 
										ELSE 1.0 END )  
      ,        'Spot_Venta'		= CaPrecioSpotVentaM1 / ( CASE WHEN CaCodMon2 = 998 
								       THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
									       WHERE vmcodigo = CaCodMon2 ) 
				                                       ELSE 1.0 END )  
      ,        'Spot'			= ( CASE WHEN (ISNULL(mnrrda,'')) = 'M' 
						 THEN CASE WHEN CaTipOper = 'C' 
							   THEN (CaPrecioSpotVentaM1 / ( CASE WHEN CaCodMon2 = 998 
							 				      THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
												      WHERE vmcodigo = CaCodMon2 ) 
											      ELSE 1.0 END ))
							   ELSE (CaPrecioSpotCompraM1 / ( CASE WHEN CaCodMon2 = 998 
											       THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
												       WHERE vmcodigo = CaCodMon2 ) 
											       ELSE 1.0 END ))
							   END
						 ELSE 1.0 / CASE WHEN CaTipOper = 'C' 
								 THEN (CaPrecioSpotVentaM1 / ( CASE WHEN CaCodMon2 = 998 
												    THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
													    WHERE vmcodigo = CaCodMon2 ) 
												    ELSE 1.0 END ))
								 ELSE (CaPrecioSpotCompraM1 / ( CASE WHEN CaCodMon2 = 998 
												     THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
													     WHERE vmcodigo = CaCodMon2 ) 
												     ELSE 1.0 END )) 
							         END
					         END )  

      ,        'Valor_Razonable'		= fRes_Obtenido      
      ,        'Fclp'			= ( CASE WHEN caCodMon2 = 999 
   						 THEN 1.0 
						 ELSE ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL WHERE vmcodigo = CaCodMon2 ) END )  
      ,        'FF_Cont'			= -1 + CaTipCam  / ( catipcamSpot / ( CASE WHEN CaCodMon2 = 998 
											   THEN  ( SELECT vmvalor FROM BACPARAMSUDA..VALOR_MONEDA
											           WHERE  vmcodigo = CaCodMon2 and    VmFecha  = cafecha )
											   ELSE 1.0 END  ))  
      ,        'P_cont'			= datediff( dd, cafecha, cafecVcto )
      ,        'P'			= datediff( dd, @Fecha_Proceso, cafecVcto )
      ,        'P_Efec'			= datediff( dd, @Fecha_Proceso, CaFecEfectiva )
      ,        'Base'			= 360.0000000           
      ,        'Resultado_devengo'	= 10000000000.00000000  
      ,        'Resultado_Tasa'		= 10000000000.00000000  
      ,        'Resultado_Moneda'	= 10000000000.00000000  
      FROM     MFCA                  LEFT JOIN BACPARAMSUDA..MONEDA 
                                     ON   mncodmon = CaCodmon1 
      WHERE    cacodpos1 IN ( 1, 2 , 12 )
      AND      cafecvcto > @Fecha_Proceso
   END --> ELSE 
   IF @Tipo_Valoriza = 'BT' 
   BEGIN 
      INSERT INTO #MFCA_TEMPORAL
      SELECT   'Nro_Contrato'		= MFCARES.Canumoper 
      ,        'Producto'		= MFCARES.caCodPos1           
      ,        'Tipo_Operacion'		= MFCARES.CaTipOper           
      ,        'Moneda_Contrato'	= MFCARES.Cacodmon1           
      ,        'D_M_Mda1'		= ISNULL(mnrrda,'')   
      ,        'Moneda_Pago'		= MFCARES.CaCodMon2           
      ,        'VC'			= (CASE WHEN (ISNULL(mnrrda,'')) = 'M' THEN MFCARES.catipCam
						ELSE 1.0 / MFCARES.catipCam END)       
      --       Si es UF debe convertir precio inicial a UF.
      ,        'Spot_ini'		= ( CASE WHEN (ISNULL(mnrrda,'')) = 'M' 
							 THEN MFCARES.catipcamSpot / ( CASE WHEN MFCARES.CaCodMon2 = 998 
										    THEN  ( SELECT vmvalor FROM BACPARAMSUDA..VALOR_MONEDA
											    WHERE vmcodigo = MFCARES.CaCodMon2 AND VmFecha = MFCARES.cafecha ) 
										    ELSE 1 END )
							 ELSE 1.0/ MFCARES.catipcamSpot / ( CASE WHEN MFCARES.CaCodMon2 = 998 
										         THEN  ( SELECT vmvalor FROM BACPARAMSUDA..VALOR_MONEDA
											         WHERE vmcodigo = MFCARES.CaCodMon2 AND VmFecha = MFCARES.cafecha ) 
											 ELSE 1 END ) 
							 END )   
      ,        'Fecha_Inicio_Contrato'	= MFCARES.caFecha             
      ,        'Fecha_Efec_Fin_Contrato'= MFCARES.cafecEfectiva       
      ,        'fecha_Fin_Contrato'	= MFCARES.CaFecVcto           
      ,        'M'			= MFCARES.caMtoMon1           
      ,        'PF'			= CASE WHEN (ISNULL(mnrrda,'')) = 'M' 
					       THEN MFCARES.fVal_Obtenido 
					       ELSE 1.0/ MFCARES.fVal_Obtenido END       
      ,        'Tm2'			= CARDIA.catasasinteticam2 
      ,        'TCM_Mon_Cont_Mda_Pago'	= ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL WHERE vmcodigo = MFCARES.CaCodMon2 )  
      ,        'Spot_Compra'		= MFCARES.CaPrecioSpotCompraM1 / ( CASE WHEN MFCARES.CaCodMon2 = 998 
										THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
											WHERE vmcodigo = MFCARES.CaCodMon2 ) 
										ELSE 1.0 END )  
      ,        'Spot_Venta'		= MFCARES.CaPrecioSpotVentaM1 / ( CASE WHEN MFCARES.CaCodMon2 = 998 
								       THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
									       WHERE vmcodigo = MFCARES.CaCodMon2 ) 
				                                       ELSE 1.0 END )  
      ,        'Spot'			= ( CASE WHEN (ISNULL(mnrrda,'')) = 'M' 
						 THEN CASE WHEN MFCARES.CaTipOper = 'C' 
							   THEN (MFCARES.CaPrecioSpotVentaM1 / ( CASE WHEN MFCARES.CaCodMon2 = 998 
							 				      THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
												      WHERE vmcodigo = MFCARES.CaCodMon2 ) 
											      ELSE 1.0 END ))
							   ELSE (MFCARES.CaPrecioSpotCompraM1 / ( CASE WHEN MFCARES.CaCodMon2 = 998 
											       THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
												       WHERE vmcodigo = MFCARES.CaCodMon2 ) 
											       ELSE 1.0 END ))
							   END
						 ELSE 1.0 / CASE WHEN MFCARES.CaTipOper = 'C' 
								 THEN (MFCARES.CaPrecioSpotVentaM1 / ( CASE WHEN MFCARES.CaCodMon2 = 998 
												    THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
													    WHERE vmcodigo = MFCARES.CaCodMon2 ) 
												    ELSE 1.0 END ))
								 ELSE (MFCARES.CaPrecioSpotCompraM1 / ( CASE WHEN MFCARES.CaCodMon2 = 998 
												     THEN  ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL 
													     WHERE vmcodigo = MFCARES.CaCodMon2 )
												     ELSE 1.0 END )) 
							         END
					         END )  

      ,        'Valor_Razonable'		= MFCARES.fRes_Obtenido
      ,        'Fclp'			= ( CASE WHEN MFCARES.caCodMon2 = 999 
   						 THEN 1.0 
						 ELSE ( SELECT vmvalor FROM #TC_CONTABLE_TEMPORAL WHERE vmcodigo = MFCARES.CaCodMon2 ) END )  
      ,        'FF_Cont'			= -1 + MFCARES.CaTipCam  / ( MFCARES.catipcamSpot / ( CASE WHEN MFCARES.CaCodMon2 = 998 
											   THEN  ( SELECT vmvalor FROM   BACPARAMSUDA..VALOR_MONEDA
											           WHERE  vmcodigo = MFCARES.CaCodMon2 and    VmFecha  = MFCARES.cafecha )
											   ELSE 1.0 END  ))  
      ,        'P_cont'			= datediff( dd, MFCARES.cafecha, MFCARES.cafecVcto )
      ,        'P'				= datediff( dd, @Fecha_Proceso, MFCARES.cafecVcto )
      ,        'P_Efec'			= datediff( dd, @Fecha_Proceso, MFCARES.CaFecEfectiva )
      ,        'Base'			= 360.0000000           
      ,        'Resultado_devengo'	= 10000000000.00000000 
      ,        'Resultado_Tasa'		= 10000000000.00000000  
      ,        'Resultado_Moneda'	= 10000000000.00000000  
      FROM     MFCARES                  LEFT JOIN BACPARAMSUDA..MONEDA 
                                        ON   mncodmon = MFCARES.CaCodmon1 
      ,        MFCA                     CARDIA
      WHERE    CaFechaProceso     =  @Fecha_Proceso
      AND      MFCARES.cacodpos1  IN ( 1, 2 , 12 )
      AND      MFCARES.cafecvcto  >  @Fecha_Proceso
      AND      CARDIA.canumoper   =  MFCARES.canumoper

   END

   UPDATE   #MFCA_TEMPORAL
   SET      Spot_Compra   = ( CASE WHEN Spot_Compra = 0 THEN  Spot_venta  ELSE Spot_Compra END )
   ,        Spot_Venta    = ( CASE WHEN Spot_Venta  = 0 THEN  Spot_compra ELSE Spot_venta  END )
   WHERE    (Spot_Compra   = 0 
   OR       Spot_Venta    = 0)

   UPDATE   #MFCA_TEMPORAL
   SET      Resultado_devengo   =  M  * ( Spot_ini  * ( 1 + FF_Cont * P / P_Cont ) - VC ) / ( 1.0 + Tm2*P_Efec/Base ) * Fclp
   ,        Resultado_Tasa      =  M  * ( PF - Spot * ( 1 + FF_Cont * P / P_Cont )) / ( 1.0 + Tm2*P_Efec/Base ) * Fclp
   ,        Resultado_Moneda    =  M  * ( Spot * ( 1 + FF_Cont * P / P_Cont ) - Spot_ini * ( 1 + FF_Cont * P / P_Cont )) / ( 1.0 + Tm2*P_Efec/Base ) * Fclp
   WHERE    p_Cont <> 0

   UPDATE   #MFCA_TEMPORAL
   SET      Resultado_devengo   = Resultado_devengo  * -1
   ,        Resultado_Tasa      = Resultado_Tasa   * -1
   ,        Resultado_Moneda    = Resultado_Moneda * -1
   WHERE    Tipo_Operacion   = 'V'

   IF @Tipo_Valoriza = '' 
   BEGIN
      UPDATE   MFCA
      SET      VrCambio   = Resultado_Moneda
      ,        VrDevengo  = Resultado_devengo
      ,        VrTasa     = Resultado_Tasa
      FROM     #MFCA_TEMPORAL
      WHERE    canumoper   = Nro_Contrato

      UPDATE   MFCA
      SET      VrTasa     =  fRes_Obtenido
      WHERE    cacodpos1  IN ( 3,10,11 )
      AND      cafecvcto  >  @Fecha_Proceso      
   END --ELSE 

   IF @Tipo_Valoriza = 'BT' 
   BEGIN
      UPDATE   MFCARES
      SET      VrCambioParPrx   = Resultado_Moneda
      ,        VrDevengoParPrx  = Resultado_devengo
      ,        VrTasaParPrx     = Resultado_Tasa
      FROM     #MFCA_TEMPORAL
      WHERE    CaFechaProceso   = @Fecha_Proceso
      AND      canumoper        = Nro_Contrato
 
      UPDATE   MFCARES
      SET      VrTasaParPrx     =  fRes_ObtenidoParPrx
      WHERE    CaFechaProceso   =  @Fecha_Proceso
      AND      cacodpos1        IN ( 3,10,11 )
   END

END
GO
