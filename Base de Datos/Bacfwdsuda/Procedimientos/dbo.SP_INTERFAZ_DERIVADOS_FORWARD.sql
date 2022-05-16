USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DERIVADOS_FORWARD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_DERIVADOS_FORWARD]
AS
BEGIN
    
   SET NOCOUNT ON    
    
   DECLARE @Fecha    DATETIME
   DECLARE @Max      INT
   DECLARE @Fecha_FM DATETIME

   SELECT @Fecha    = acfecproc     
   FROM   MFAC    

   SELECT @Max      = COUNT(1)     
   FROM   MFCA    

   SELECT @Fecha_FM      = DATEADD(MONTH, -1, @Fecha)    
   SELECT @Fecha_FM      = MAX(vmfecha)     
   FROM   BacParamSuda..VALOR_MONEDA     
   WHERE  MONTH(VMFECHA) = MONTH(@Fecha_FM)     
   AND    YEAR(VMFECHA)  = YEAR(@Fecha_FM)    
    
   SELECT vmcodigo = CASE WHEN vmcodigo = 994 THEN 13 ELSE vmcodigo END    
   ,      vmvalor    
   INTO   #ValMon    
   FROM   BacParamSuda..VALOR_MONEDA    
   WHERE  vmfecha    = @Fecha    
    
   INSERT INTO #ValMon SELECT 999 , 1    
    
   SELECT vmcodigo = Codigo_Moneda    
   ,      vmvalor  = Tipo_Cambio    
   INTO   #VALOR_TC_CONTABLE    
   FROM   BacparamSuda..VALOR_MONEDA_CONTABLE    
   WHERE  Fecha    = @Fecha    
    
   INSERT INTO #VALOR_TC_CONTABLE SELECT vmcodigo, vmvalor FROM #ValMon WHERE vmcodigo = 998    
   INSERT INTO #VALOR_TC_CONTABLE SELECT 999 , 1.0    
   INSERT INTO #VALOR_TC_CONTABLE SELECT 13  , Tipo_Cambio     
                                    FROM BacparamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @Fecha AND Codigo_Moneda = 994    

	select	DEFWD.fecha_contable
		,	DEFWD.cod_producto
		,	DEFWD.T_producto
		,	DEFWD.rut
		,	DEFWD.dig
		,   DEFWD.n_operacion
		,   DEFWD.fecha_inic
		,   DEFWD.fecha_vcto
		,   DEFWD.mda_compra
		,   DEFWD.mto_compra
		,   DEFWD.mda_venta
		,   DEFWD.mto_venta
		,   DEFWD.tip_vcto
		,   DEFWD.activo_mtm
		,	DEFWD.pasivo_mtm
		,	DEFWD.Vpresen_activo
		,   DEFWD.Vpresen_pasivo
		,   DEFWD.Flujos
		,	MdaPagoCompra	= case when len( ltrim(rtrim( DEFWD.MdaPagoCompra )) ) < 3 then '0' + ltrim(rtrim( DEFWD.MdaPagoCompra )) else ltrim(rtrim( DEFWD.MdaPagoCompra )) end
		,	MdaPagoVenta	= case when len( ltrim(rtrim( DEFWD.MdaPagoVenta  )) ) < 3 then '0' + ltrim(rtrim( DEFWD.MdaPagoVenta  )) else ltrim(rtrim( DEFWD.MdaPagoVenta  )) end
	from	
		(  SELECT 'fecha_contable'   = @Fecha    
		   ,      'cod_producto'     = 'MD01'    
		   ,      'T_producto'       = 'MDIR'    
		   ,      'rut'              = CONVERT(CHAR(9),cacodigo)    
		   ,      'dig'              = ISNULL(Cldv,'')    
		   ,      'n_operacion'      = CONVERT(VARCHAR(9),canumoper)    
		   ,      'fecha_inic'       = convert(char(8),cafecha,112)    
		   ,      'fecha_vcto'       = cafecvcto    
		   ,      'mda_compra'       = CASE WHEN catipoper = 'C' THEN cacodmon1 ELSE cacodmon2 END    
		   ,      'mto_compra'       = CASE WHEN catipoper = 'C' THEN camtomon1 ELSE camtomon2 END    
		   ,      'mda_venta'        = CASE WHEN catipoper = 'C' THEN cacodmon2 ELSE cacodmon1 END    
		   ,      'mto_venta'        = CASE WHEN catipoper = 'C' THEN camtomon2 ELSE camtomon1 END    
		   ,      'tip_vcto'         = CASE WHEN catipmoda = 'E' THEN 'D'       ELSE catipmoda END    
		   ,      'activo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' THEN fval_obtenido    
															  WHEN catipoper = 'V' THEN catipcam    
														END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)    
		    
		   ,      'pasivo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' THEN catipcam    
															  WHEN catipoper = 'V' THEN fval_obtenido    
														END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)    
		    
		   ,      'Vpresen_activo'   = ROUND(camtomon1 * CASE WHEN catipoper = 'C' THEN fval_obtenido    
															  WHEN catipoper = 'V' THEN catipcam    
														END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)    
		    
		   ,      'Vpresen_pasivo'   = ROUND(camtomon1 * CASE WHEN catipoper = 'C' THEN catipcam    
															  WHEN catipoper = 'V' THEN fval_obtenido    
														END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)    
		    
		   ,      'Flujos'           =    ' '     

		   ,	  'MdaPagoCompra'	 = case when catipmoda	= 'E' and catipoper = 'C' then cacodmon1
											when catipmoda	= 'E' and catipoper = 'V' then cacodmon2
											else case	when cacodpos1 = 2  and cltipcli  = 2 THEN 13
														when cacodpos1 = 2  and cltipcli <> 2 THEN 999
														when cacodpos1 = 13 and cltipcli  = 2 THEN 13
														when cacodpos1 = 13 and cltipcli <> 2 THEN 999
														else case	when cacalcmpdol = 13	then 13
																	when cacodpos1	 = 3	then 999
																	when cltipcli	 = 2	then 13
																	else						 999
																end
													end
										end

		   ,	  'MdaPagoVenta'	 = case when catipmoda	= 'E' and catipoper = 'C' then cacodmon2
											when catipmoda	= 'E' and catipoper = 'V' then cacodmon1
											else case	when cacodpos1 = 2  and cltipcli  = 2 THEN 13
														when cacodpos1 = 2  and cltipcli <> 2 THEN 999
														when cacodpos1 = 13 and cltipcli  = 2 THEN 13
														when cacodpos1 = 13 and cltipcli <> 2 THEN 999
														else case	when cacalcmpdol = 13	then 13
																	when cacodpos1	 = 3	then 999
																	when cltipcli	 = 2	then 13
																	else						 999
																end
													end
										end
		   FROM   MFCA
				  LEFT JOIN BacParamSuda..CLIENTE     ON cacodigo = clrut and cacodcli = clcodigo    
				  LEFT JOIN BacParamSuda..MONEDA  cnv ON mncodmon = cacodmon2    
		   WHERE  cafecvcto          > @Fecha    
			 AND  cacodpos1          NOT IN(2, 10, 11)    
		    
		   UNION    
		    
		   SELECT 'fecha_contable'   = @Fecha    
		   ,      'cod_producto'     = 'MD01'    
		   ,      'T_producto'       = 'MDIR'    
		   ,      'rut'              = CONVERT(CHAR(9),cacodigo)    
		   ,      'dig'              = ISNULL(Cldv,'')    
		   ,      'n_operacion'      = CONVERT(VARCHAR(9),canumoper)    
		   ,      'fecha_inic'       = convert(char(8),cafecha,112)    
		   ,      'fecha_vcto'       = cafecvcto    
		   ,      'mda_compra'       = CASE WHEN catipoper = 'C' THEN cacodmon1 ELSE cacodmon2 END    
		   ,      'mto_compra'       = CASE WHEN catipoper = 'C' THEN camtomon1 ELSE camtomon2 END    
		   ,      'mda_venta'        = CASE WHEN catipoper = 'C' THEN cacodmon2 ELSE cacodmon1 END    
		   ,      'mto_venta'        = CASE WHEN catipoper = 'C' THEN camtomon2 ELSE camtomon1 END    
		   ,      'tip_vcto'         = CASE WHEN catipmoda = 'E' THEN 'D'       ELSE catipmoda END    
		    
		   ,      'activo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN fval_obtenido    
															  WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)    
															  WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN catipcam    
															  WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)    
														 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)    
		    
		   ,      'pasivo_mtm'       = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN catipcam    
															  WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)    
															  WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN fval_obtenido    
															  WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)    
														 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)    
		    
		   ,      'Vpresen_activo'   = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN fval_obtenido    
															  WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)    
															  WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN catipcam    
															  WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)    
										  END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)    
		   ,      'Vpresen_pasivo'   = ROUND(camtomon1 * CASE WHEN catipoper = 'C' AND cnv.mnrrda = 'M' THEN catipcam    
															  WHEN catipoper = 'C' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN catipcam      = 0 THEN 1 ELSE catipcam      END)    
															  WHEN catipoper = 'V' AND cnv.mnrrda = 'M' THEN fval_obtenido    
															  WHEN catipoper = 'V' AND cnv.mnrrda = 'D' THEN (1 / CASE WHEN fval_obtenido = 0 THEN 1 ELSE fval_obtenido END)    
														 END  * (SELECT vmvalor FROM #VALOR_TC_CONTABLE WHERE cacodmon2 = vmcodigo),0)    
		   ,      'Flujos'           =    ' '    

		   ,	  'MdaPagoCompra'	 = case when catipmoda	= 'E' and catipoper = 'C' then cacodmon1
											when catipmoda	= 'E' and catipoper = 'V' then cacodmon2
											else case	when cacodpos1 = 2  and cltipcli  = 2 THEN 13
														when cacodpos1 = 2  and cltipcli <> 2 THEN 999
														when cacodpos1 = 13 and cltipcli  = 2 THEN 13
														when cacodpos1 = 13 and cltipcli <> 2 THEN 999
														else case	when cacalcmpdol = 13	then 13
																	when cacodpos1	 = 3	then 999
																	when cltipcli	 = 2	then 13
																	else						 999
																end
													end
										end

		   ,	  'MdaPagoVenta'	 = case when catipmoda	= 'E' and catipoper = 'C' then cacodmon2
											when catipmoda	= 'E' and catipoper = 'V' then cacodmon1
											else case	when cacodpos1 = 2  and cltipcli  = 2 THEN 13
														when cacodpos1 = 2  and cltipcli <> 2 THEN 999
														when cacodpos1 = 13 and cltipcli  = 2 THEN 13
														when cacodpos1 = 13 and cltipcli <> 2 THEN 999
														else case	when cacalcmpdol = 13	then 13
																	when cacodpos1	 = 3	then 999
																	when cltipcli	 = 2	then 13
																	else						 999
																end
													end
										end
		   FROM   MFCA    
				  LEFT JOIN BacParamSuda..CLIENTE     ON cacodigo = clrut and cacodcli = clcodigo    
				  LEFT JOIN BacParamSuda..MONEDA  cnv ON mncodmon = cacodmon1    
		   WHERE  cafecvcto          > @Fecha    
			 AND  cacodpos1           IN(2)    
		    
		   UNION    
		    
		   SELECT 'fecha_contable'   = @Fecha    
		   ,      'cod_producto'     = 'MD01'    
		   ,      'T_producto'       = 'MDIR'    
		   ,	  'rut'              = CONVERT(CHAR(9), cacodigo )    
		   ,      'dig'              = ISNULL( cldv, '0')    
		   ,      'n_operacion'      = CONVERT(VARCHAR(9), canumoper )    
		   ,      'fecha_inic'       = CONVERT(CHAR(8), cafecha, 112)    
		   ,      'fecha_vcto'       = cafecvcto    
		   ,      'mda_compra'       = CASE WHEN cacodmon2 = 13  THEN 13        ELSE 999        END    
		   ,      'mto_compra'       = CASE WHEN catipoper = 'C' THEN caequusd2 ELSE caequmon1  END    
		   ,      'mda_venta'        = CASE WHEN cacodmon1 = 13  THEN 13        ELSE 999        END    
		   ,      'mto_venta'        = CASE WHEN catipoper = 'C' THEN caequmon1 ELSE caequusd2  END    
		   ,      'tip_vcto'         = CASE WHEN catipmoda = 'E' THEN 'D'       ELSE catipmoda  END    
		    
		   ,      'activo_mtm'       = mtm_hoy_moneda1    
		   ,      'pasivo_mtm'       = mtm_hoy_moneda2    
		   ,      'Vpresen_activo'   = ISNULL( valorrazonableactivo ,0)    
		   ,      'Vpresen_pasivo'   = ISNULL( valorrazonablepasivo ,0)    
		   ,      'Flujos'           = 'R'    

		   ,	  'MdaPagoCompra'	 = case when catipmoda	= 'E' and catipoper = 'C' then cacodmon1
											when catipmoda	= 'E' and catipoper = 'V' then cacodmon2
											else case	when cacodpos1 = 2  and cltipcli  = 2 THEN 13
														when cacodpos1 = 2  and cltipcli <> 2 THEN 999
														when cacodpos1 = 13 and cltipcli  = 2 THEN 13
														when cacodpos1 = 13 and cltipcli <> 2 THEN 999
														else case	when cacalcmpdol = 13	then 13
																	when cacodpos1	 = 3	then 999
																	when cltipcli	 = 2	then 13
																	else						 999
																end
													end
										end

		   ,	  'MdaPagoVenta'	 = case when catipmoda	= 'E' and catipoper = 'C' then cacodmon2
											when catipmoda	= 'E' and catipoper = 'V' then cacodmon1
											else case	when cacodpos1 = 2  and cltipcli  = 2 THEN 13
														when cacodpos1 = 2  and cltipcli <> 2 THEN 999
														when cacodpos1 = 13 and cltipcli  = 2 THEN 13
														when cacodpos1 = 13 and cltipcli <> 2 THEN 999
														else case	when cacalcmpdol = 13	then 13
																	when cacodpos1	 = 3	then 999
																	when cltipcli	 = 2	then 13
																	else						 999
																end
													end
										end
		   FROM   MFCA    
				  LEFT JOIN BacParamSuda..CLIENTE ON cacodigo = clrut and cacodcli = clcodigo    
		   WHERE  cafecvcto          > @Fecha    
		   AND    cacodpos1          = 10    
		)	DEFWD
    
END
GO
