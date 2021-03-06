USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSCONTRATO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DATOSCONTRATO]  
   (   @numoper   NUMERIC (09)   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @SwDevengo  NUMERIC(01)  
   DECLARE @fechaproc  DATETIME  
  
   SELECT  @SwDevengo = devengo   
         , @fechaproc = fechaproc  
   FROM    SWAPGENERAL  
  
   SELECT 'Tipo_operacion'     = Tipo_operacion  
   ,      'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END  
   ,      'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END  
   ,      'Modalidad'          = ISNULL(CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END,' ')  
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
   ,   'TituloModEF_1'      = 'Las Amortizaciones e Interés se pagarán en Pago Pasivo: '   
   ,   'TituloModEF_2'         = ' y se recibiran en Pago Activo: '   
   ,      'Tipo_Swap'             = CASE tipo_swap WHEN 1 THEN 'TASA'  
       WHEN 2 THEN 'MONEDA'  
       WHEN 3 THEN 'FRA'  
       WHEN 4 THEN 'TASA' --> 'CAMARA'  
        END  
   ,   'INTER_NOCIONAL'   = IntercPrinc  
   ,   'CompraGlosaBase'   = ISNULL((SELECT Glosa FROM Base Base WHERE Base.codigo  = compra_base),'N/A')   
   ,   'VentaGlosaBase'    = ISNULL((SELECT Glosa FROM Base Base WHERE Base.codigo  = Venta_base),'N/A')   
   
   INTO   #TMP_CARTERA_SWAP  
   FROM   CARTERA  
   WHERE  numero_operacion    = @numoper  
   AND    Fecha_inicio_flujo  <> Fecha_vence_flujo  
   ORDER BY tipo_flujo, numero_flujo  
  
   IF @@ROWCOUNT = 0  
   BEGIN  
      DECLARE @dFecha   DATETIME  
          SET @dFecha   = (SELECT MIN(Fecha_Proceso) FROM CARTERARES WHERE numero_operacion = @numoper)  
  
      INSERT INTO #TMP_CARTERA_SWAP  
      SELECT 'Tipo_operacion'     = Tipo_operacion  
      ,      'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END  
      ,      'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END  
      ,      'Modalidad'          = ISNULL(CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END,' ')  
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
   
      FROM   CARTERARES  
      WHERE  numero_operacion    = @numoper  
      AND    Fecha_Proceso       = @dFecha  
      AND    Fecha_inicio_flujo  <> Fecha_vence_flujo  
      ORDER BY tipo_flujo, numero_flujo  
   END  
  
   SELECT * FROM #TMP_CARTERA_SWAP  
 ORDER BY tipo_flujo, numero_flujo   
  
END

GO
