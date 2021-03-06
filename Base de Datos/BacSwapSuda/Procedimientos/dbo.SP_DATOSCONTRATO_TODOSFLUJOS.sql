USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSCONTRATO_TODOSFLUJOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_DATOSCONTRATO_TODOSFLUJOS]  
   (   
    @numoper   NUMERIC (09)   
   )  
AS  
BEGIN  
   SET NOCOUNT ON  
  
   DECLARE @SwDevengo  NUMERIC(01)  
   DECLARE @fechaproc  DATETIME  
  
   SELECT  @SwDevengo = devengo   
         , @fechaproc = fechaproc  
   FROM    SWAPGENERAL  
  
  
  
   /*************************************************************************************************************************/
   -- PRD 12712 -21707
   DECLARE @Banco				VARCHAR(100)
   DECLARE @Cliente				VARCHAR(MAX)    
   DECLARE @Termino_anticipado	VARCHAR(1000)
   
   SELECT  @Banco = (SELECT ltrim(rtrim(Nombre)) From SwapGeneral)
     
   SELECT @Cliente          = ISNULL(ltrim(rtrim(clnombre)),'**')--, mov.* 
     FROM MOVDIARIO mov LEFT JOIN BacParamSuda..CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo
    WHERE estado_flujo   = 1  
      AND   ((cltipcli       <  5 /*AND @FINANCIEROS = 'S'*/)
         OR  (cltipcli       >  4 /*AND @EMPRESAS    = 'S'*/)
            ) and estado <> 'C'
      AND   numero_operacion = @numoper
	  AND   fecha_cierre     = @fechaproc
		   
		   
   SELECT	@Termino_anticipado = CASE WHEN bearlytermination = 1 THEN 
   									'Las partes acuerdan que dentro del plazo  de diez (10) Días Hábiles contados desde el día ' 
   									+ right('00'+convert(varchar(2),DATEPART(day,fechainicio)) ,2) + ' de ' 
   									+  case when datepart(month,fechainicio	) = 1  THEN 'Enero'
										    when datepart(month,fechainicio	) = 2  THEN 'Febrero'
										    when datepart(month,fechainicio	) = 3  THEN 'Marzo'
										    when datepart(month,fechainicio	) = 4  THEN 'Abril'
										    when datepart(month,fechainicio	) = 5  THEN 'Mayo'
										    when datepart(month,fechainicio	) = 6  THEN 'Junio'
										    when datepart(month,fechainicio	) = 7  THEN 'Julio'
										    when datepart(month,fechainicio	) = 8  THEN 'Agosto'
										    when datepart(month,fechainicio	) = 9  THEN 'Septiembre'
										    when datepart(month,fechainicio	) = 10 THEN 'Octubre'
										    when datepart(month,fechainicio	) = 11 THEN 'Noviembre'
										    when datepart(month,fechainicio	) = 12 THEN 'Diciembre' end
   									+ ' del ' + rtrim(DATEPART(year,fechainicio)) + ' , y con una periodicidad '   																	
   									+ CASE WHEN Periodicidad = 0 THEN ''
   									       ELSE (SELECT ltrim(rtrim(gd.tbglosa))   
   												 FROM   BacParamSuda..TABLA_GENERAL_DETALLE GD 
   									             WHERE  GD.tbcateg			 = 9920
   												 AND    ca.Periodicidad      = gd.tbcodigo1 )
   									  END 
   									+ ', cualquiera de las partes tendrá la facultad de terminar en forma unilateral y anticipada el presente contrato.' 
   									+ ' La terminación deberá comunicarse a la otra parte antes de las 11:00 horas a.m. de cualquiera de los días comprendidos en el citado plazo ' 
   									+ '(en adelante, la “Fecha de Terminación Anticipada”). Dentro de los 2 Días Hábiles siguientes a la Fecha de Terminación Anticipada deberá procederse al pago,'
   									+ ' por la parte que resulte deudora, del Valor de Mercado del contrato, calculado conforme a la Tasa de Valorización Referencial de Mercado y al Plazo residual a la Fecha de Terminación Anticipada.'

                                  ELSE 'No Aplica' END    
   
   FROM BacSwapSuda..cartera ca
   WHERE ca.numero_operacion    = @numoper  
   AND ca.TIPO_FLUJO			= 1

   DECLARE @InterNocIni AS INT
	,	   @InterNocFin AS INT

	SELECT top 1 
			@InterNocIni	 = InterNocIni
	,		@InterNocFin	 = InterNocFin
	FROM	BacSwapSuda..Cartera 
	WHERE	numero_operacion = @numoper 
	 
	
   -- PRD 12712 - 21707
   /*************************************************************************************************************************/
   
   
  
   SELECT 'Tipo_operacion'     = Tipo_operacion  
   ,      'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END  
   ,      'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END  
   ,      'Modalidad'          = ISNULL(CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END,' ')  
   ,      'fechainicioflujo'   = CONVERT(CHAR(10),Fecha_inicio_flujo,103)  
   ,      'fechavenceflujo'    = CONVERT(CHAR(10),Fecha_vence_flujo,103)  
   ,      'dias'               = PlazoFlujo  
   ,      'MontoCompra'        = compra_valor_tasa + compra_spread  
   ,      'MontoVenta'         = venta_valor_tasa  + venta_spread  
   ,      'nombretasacompra'   = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = compra_codigo_tasa AND tbcateg = 1042),' ')  
   ,      'nombretasaventa'    = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = venta_codigo_tasa  AND tbcateg = 1042),' ')  
   ,      'pagamosdoc'         = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = pagamos_documento),' ')  
   ,      'recibimosdoc'       = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = recibimos_documento),' ')  
   ,      'numero_flujo'       = numero_flujo  
   ,      'compra_capital'     = ISNULL(Compra_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  compra_flujo_adicional ELSE 0 END),0)  
   ,      'compra_amortiza'    = compra_amortiza  
   ,      'compra_saldo'       = compra_saldo  
   ,      'compra_interes'     = compra_interes  
   ,      'compra_spread'      = compra_spread  
   ,      'venta_capital'      = ISNULL(Venta_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  Venta_flujo_adicional ELSE 0 END),0)  
   ,      'venta_amortiza'     = venta_amortiza  
   ,      'venta_saldo'        = venta_saldo  
   ,      'venta_interes'      = venta_interes  
   ,      'venta_spread'       = venta_spread  
   ,      'pagamos_moneda'     = pagamos_moneda  
   ,      'recibimos_moneda'   = recibimos_moneda  
   ,      'tipo_flujo'         = tipo_flujo  
   ,      'compra_moneda'      = compra_moneda  
   ,      'venta_moneda'       = venta_moneda  
   ,      'compra_capital1'    = compra_capital  
   ,      'venta_capital1'     = venta_capital  
   ,   'nemo_compra_moneda' = isnull((select MNNEMO from view_moneda where compra_moneda=MNCODMON),'')  
   ,   'nemo_venta_moneda'  = isnull((select MNNEMO from view_moneda where venta_moneda =MNCODMON) ,'')  
   ,   'VALUTA'        = isnull((select Diasvalor from VIEW_FORMA_DE_PAGO where pagamos_documento=Codigo),0)  
   ,      'EstadoFlujo'        = estado_flujo     
   ,      'Amortiza'           = Case when (select TOP 1 IntercPrinc from cartera where numero_operacion = @numoper  and Tipo_Swap=2 and Tipo_flujo=1 and (fecha_inicio_flujo=fecha_vence_flujo)  )<>0    --numero_flujo=1  
             then 'Intercambio Nocionales al Inicio. '  else ' '   
                                    end  
   ,   'FechaFijacionTasa'     = CONVERT(CHAR(10),fecha_fijacion_tasa,103)   
   ,   'FechaLiquidacion'      = CONVERT(CHAR(10),FechaLiquidacion,103)   
   ,   'nemo_pagamos_moneda'   = isnull((select mnnemo from view_moneda where MNCODMON=(CASE WHEN pagamos_moneda=998 THEN 999 ELSE pagamos_moneda END)),'')  
   ,   'nemo_recibimos_moneda' = isnull((select mnnemo from view_moneda where MNCODMON=(CASE WHEN recibimos_moneda=998 THEN 999 ELSE recibimos_moneda END)) ,'')  
   ,      'TituloModComp'         = 'El Diferencial de Amortización y el Diferencial de Intereses se pagarán en: '   
   ,   'TituloModEF_1'         = 'Las Amortizaciones e Interés se pagarán en Pago Pasivo: '   
   ,   'TituloModEF_2'         = ' y se recibiran en Pago Activo: '   
   ,      'Tipo_Swap'             = CASE tipo_swap WHEN 1 THEN 'TASA'  
       WHEN 2 THEN 'MONEDA'  
       WHEN 3 THEN 'FRA'  
       WHEN 4 THEN 'TASA' --> 'CAMARA'  
        END  
   ,   'INTER_NOCIONAL'   = IntercPrinc  
   ,   'CompraGlosaBase'   = ISNULL((SELECT Glosa FROM Base Base WHERE Base.codigo  = compra_base),'N/A')   
   ,   'VentaGlosaBase'    = ISNULL((SELECT Glosa FROM Base Base WHERE Base.codigo  = Venta_base),'N/A')   
   ,      'Termino_anticipado' = @Termino_anticipado 
   ,      'ItercambioInicial'  = @InterNocIni
   /*CASE WHEN @InterNocIni = 0 then 'Sin Intercambio'
									  ELSE	'-  Fecha Intercambio Inicial: ' --+ CONVERT(CHAR(10),Fecha_inicio_flujo,103) 
											+ right('00'+convert(varchar(2),DATEPART(day,Fecha_inicio_flujo)) ,2) + ' de ' 
   											+  case when datepart(month,Fecha_inicio_flujo	) = 1  THEN 'Enero'
													when datepart(month,Fecha_inicio_flujo	) = 2  THEN 'Febrero'
													when datepart(month,Fecha_inicio_flujo	) = 3  THEN 'Marzo'
													when datepart(month,Fecha_inicio_flujo	) = 4  THEN 'Abril'
													when datepart(month,Fecha_inicio_flujo	) = 5  THEN 'Mayo'
													when datepart(month,Fecha_inicio_flujo	) = 6  THEN 'Junio'
													when datepart(month,Fecha_inicio_flujo	) = 7  THEN 'Julio'
													when datepart(month,Fecha_inicio_flujo	) = 8  THEN 'Agosto'
													when datepart(month,Fecha_inicio_flujo	) = 9  THEN 'Septiembre'
													when datepart(month,Fecha_inicio_flujo	) = 10 THEN 'Octubre'
													when datepart(month,Fecha_inicio_flujo	) = 11 THEN 'Noviembre'
													when datepart(month,Fecha_inicio_flujo	) = 12 THEN 'Diciembre' end
   											+ ' del ' + rtrim(DATEPART(year,Fecha_inicio_flujo)) +
											+ CHAR(13) + CHAR(10) +
											SPACE(12) + '-  Monto Intercambio Inicial para ' + @Banco + ' : ' 
											+ isnull((select rtrim(MNNEMO) from view_moneda where compra_moneda=MNCODMON),'') 
											+ ' ' + replace(replace(replace(rtrim(compra_amortiza),'.',';'),',','.'),';',',') 
											+ CHAR(13) + CHAR(10) +
											SPACE(12) + '-  Monto Intercambio Inicial para ' + @Cliente + ' : '
											+ isnull((select rtrim(mnnemo) from view_moneda where MNCODMON=(CASE WHEN recibimos_moneda=998 THEN 999 ELSE recibimos_moneda END)) ,'') 
											+ ' ' + replace(replace(replace(rtrim(compra_amortiza),'.',';'),',','.'),';',',') 
											+ CHAR(13) + CHAR(10) 
                                 END*/
   ,   'InterNocFinal'		= @InterNocFin
   
   INTO   #TMP_CARTERA_SWAP  
   FROM   CARTERA  
   WHERE  numero_operacion    = @numoper  
   ---AND    Fecha_inicio_flujo  <> Fecha_vence_flujo  
   ORDER BY tipo_flujo, numero_flujo  
  
 DECLARE @dFecha   DATETIME  
          SET @dFecha   = (SELECT MIN(Fecha_Proceso) FROM CARTERARES WHERE numero_operacion = @numoper)  
  
  
	
   /*************************************************************************************************************************/
   -- PRD 12712 -21707
   
	SELECT top 1 
			@InterNocIni	 = InterNocIni
	,		@InterNocFin	 = InterNocFin
	FROM	BacSwapSuda..CARTERAHIS 
	WHERE	numero_operacion = @numoper 
	--AND		numero_flujo     = 1 
  
   -- PRD 12712 -21707
   /*************************************************************************************************************************/
  
  
  
      INSERT INTO #TMP_CARTERA_SWAP  
      SELECT 'Tipo_operacion'     = Tipo_operacion  
      ,      'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END  
      ,      'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END  
      ,      'Modalidad'          = ISNULL(CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END,' ')  
      ,      'fechainicioflujo'   = CONVERT(CHAR(10),Fecha_inicio_flujo,103)  
      ,      'fechavenceflujo'    = CONVERT(CHAR(10),Fecha_vence_flujo,103)  
      ,      'dias'               = PlazoFlujo  
      ,      'MontoCompra'        = compra_valor_tasa + compra_spread  
      ,      'MontoVenta'         = venta_valor_tasa  + venta_spread  
      ,      'nombretasacompra'   = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = compra_codigo_tasa AND tbcateg = 1042),' ')  
      ,      'nombretasaventa'    = ISNULL((SELECT tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE tbcodigo1 = venta_codigo_tasa  AND tbcateg = 1042),' ')  
      ,      'pagamosdoc'         = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = pagamos_documento),' ')  
      ,      'recibimosdoc'       = ISNULL((SELECT glosa   FROM BacParamSuda..FORMA_DE_PAGO         WHERE codigo    = recibimos_documento),' ')  
      ,      'numero_flujo'       = numero_flujo  
      ,      'compra_capital'     = ISNULL(Compra_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  compra_flujo_adicional ELSE 0 END),0)  
      ,      'compra_amortiza'    = compra_amortiza  
      ,      'compra_saldo'       = compra_saldo  
      ,      'compra_interes'     = compra_interes  
      ,      'compra_spread'      = compra_spread  
      ,      'venta_capital'      = ISNULL(Venta_Capital + (CASE WHEN (@SwDevengo =0 and fecha_cierre = @fechaproc) THEN  Venta_flujo_adicional ELSE 0 END),0)  
      ,      'venta_amortiza'     = venta_amortiza  
      ,      'venta_saldo'        = venta_saldo  
      ,      'venta_interes'      = venta_interes  
      ,      'venta_spread'       = venta_spread  
      ,      'pagamos_moneda'     = pagamos_moneda  
      ,      'recibimos_moneda'   = recibimos_moneda  
      ,      'tipo_flujo'         = tipo_flujo  
      ,      'compra_moneda'      = compra_moneda  
      ,      'venta_moneda'       = venta_moneda  
      ,      'compra_capital1'     = compra_capital  
      ,      'venta_capital1'      = venta_capital  
      ,      'nemo_compra_moneda' = isnull((select mnnemo from view_moneda where compra_moneda = mncodmon),'')  
      ,      'nemo_venta_moneda'  = isnull((select mnnemo from view_moneda where venta_moneda  = mncodmon) ,'')  
      ,      'VALUTA'           = isnull((select Diasvalor from VIEW_FORMA_DE_PAGO where pagamos_documento=Codigo),0)  
      ,      'EstadoFlujo'   = estado_flujo     
      ,      'Amortiza'           = Case when (select TOP 1 IntercPrinc from CARTERARES where Fecha_Proceso = @dFecha and numero_operacion = @numoper  and Tipo_Swap=2 and Tipo_flujo=1 and (fecha_inicio_flujo=fecha_vence_flujo)  )<>0    --numero_flujo=1  
									then 'Intercambio Nocionales al Inicio. '  else ' '   
                                    end  
      ,      'FechaFijacionTasa'     = CONVERT(CHAR(10),fecha_fijacion_tasa,103)   
      ,      'FechaLiquidacion'      = CONVERT(CHAR(10),FechaLiquidacion,103)   
      ,      'nemo_pagamos_moneda'   = isnull((select MNNEMO from view_moneda where MNCODMON = (CASE WHEN pagamos_moneda=998 THEN 999 ELSE pagamos_moneda END)),'')  
      ,      'nemo_recibimos_moneda' = isnull((select MNNEMO from view_moneda where MNCODMON = (CASE WHEN recibimos_moneda=998 THEN 999 ELSE recibimos_moneda END)) ,'')  
      ,      'TituloModComp'         = 'El Diferencial de Amortización y el Diferencial de Intereses se pagarán en: '   
      ,      'TituloModEF_1'         = 'Las Amortizaciones e Interés se pagarán en Pago Pasivo: '   
      ,      'TituloModEF_2'         = ' y se recibiran en Pago Activo: '   
      ,      'Tipo_Swap'             = CASE tipo_swap WHEN 1 THEN 'TASA'  
														WHEN 2 THEN 'MONEDA'  
														WHEN 3 THEN 'FRA'  
														WHEN 4 THEN 'TASA' -- 'CAMARA'  
										END  
      ,   'INTER_NOCIONAL'   = IntercPrinc  
      ,      'CompraGlosaBase'   = ISNULL((SELECT Glosa FROM Base Base WHERE Base.codigo  = compra_base),'N/A')   
      ,      'VentaGlosaBase'    = ISNULL((SELECT Glosa FROM Base Base WHERE Base.codigo  = Venta_base),'N/A')   
      ,      'Termino_anticipado' = @Termino_anticipado 
      ,      'ItercambioInicial'  = @InterNocIni
      /*CASE WHEN @InterNocIni = 0 then 'Sin Intercambio'
									  ELSE	'-  Fecha Intercambio Inicial: ' --+ CONVERT(CHAR(10),Fecha_inicio_flujo,103) 
											+ right('00'+convert(varchar(2),DATEPART(day,Fecha_inicio_flujo)) ,2) + ' de ' 
   											+  case when datepart(month,Fecha_inicio_flujo	) = 1  THEN 'Enero'
													when datepart(month,Fecha_inicio_flujo	) = 2  THEN 'Febrero'
													when datepart(month,Fecha_inicio_flujo	) = 3  THEN 'Marzo'
													when datepart(month,Fecha_inicio_flujo	) = 4  THEN 'Abril'
													when datepart(month,Fecha_inicio_flujo	) = 5  THEN 'Mayo'
													when datepart(month,Fecha_inicio_flujo	) = 6  THEN 'Junio'
													when datepart(month,Fecha_inicio_flujo	) = 7  THEN 'Julio'
													when datepart(month,Fecha_inicio_flujo	) = 8  THEN 'Agosto'
													when datepart(month,Fecha_inicio_flujo	) = 9  THEN 'Septiembre'
													when datepart(month,Fecha_inicio_flujo	) = 10 THEN 'Octubre'
													when datepart(month,Fecha_inicio_flujo	) = 11 THEN 'Noviembre'
													when datepart(month,Fecha_inicio_flujo	) = 12 THEN 'Diciembre' end
   											+ ' del ' + rtrim(DATEPART(year,Fecha_inicio_flujo)) +
											+ CHAR(13) + CHAR(10) +
											SPACE(12) + '-  Monto Intercambio Inicial para ' + @Banco + ' : ' 
											+ isnull((select rtrim(MNNEMO) from view_moneda where compra_moneda=MNCODMON),'') 
											+ ' ' + replace(replace(replace(rtrim(compra_amortiza),'.',';'),',','.'),';',',') 
											+ CHAR(13) + CHAR(10) +
											SPACE(12) + '-  Monto Intercambio Inicial para ' + @Cliente + ' : '
											+ isnull((select rtrim(mnnemo) from view_moneda where MNCODMON=(CASE WHEN recibimos_moneda=998 THEN 999 ELSE recibimos_moneda END)) ,'') 
											+ ' ' + replace(replace(replace(rtrim(compra_amortiza),'.',';'),',','.'),';',',') 
											+ CHAR(13) + CHAR(10) 
                                    END*/
	 ,   'InterNocFinal'		= @InterNocFin
   
      FROM   CARTERAHIS  
      WHERE  numero_operacion    = @numoper  
---      AND    Fecha_Proceso       = @dFecha  
---      AND    Fecha_inicio_flujo  <> Fecha_vence_flujo  
      ORDER BY tipo_flujo, numero_flujo  
  
  
   SELECT * FROM #TMP_CARTERA_SWAP  
   --WHERE numero_flujo > 1
 ORDER BY tipo_flujo, numero_flujo   
  
--- DROP TABLE #TMP_CARTERA_SWAP  
END  


GO
