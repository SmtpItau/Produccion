USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOSCARTERAMONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DATOSCARTERAMONEDA]  
   (   @Operacion       NUMERIC(01)  
   ,   @TipoOperacion       CHAR(01)   
   ,   @Fecha        CHAR(10)   
   ,   @FechaProc       CHAR(08)   
   ,   @Cartera        CHAR(05) --> NUMERIC(5)   
   ,   @Area_Resp       CHAR(10)   
   ,   @Cart_Norm       CHAR(10)   
   ,   @SubCart_Norm       CHAR(10)   
   ,   @Libro        CHAR(10)   
   ,   @Const_Area_Resp       CHAR(10) = '1553'  
   ,   @Const_Cart_Norm       CHAR(10) = '1111'  
   ,   @Const_SubCart_Norm    CHAR(10) = '1554'  
   ,   @Const_Libro       CHAR(10) = '1552'  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   IF @Cartera = ''  
      SET @Cartera = '0'  
  
   DECLARE @cNomBanco  VARCHAR(50)  
       SET @cNomBanco  = ISNULL((SELECT ISNULL(nombre, '*') FROM BacSwapSuda.dbo.SWAPGENERAL), '*')  
  
   DECLARE @nValorUf   FLOAT  
       SET @nValorUf   = ISNULL((SELECT isnull(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = 998 and vmfecha = @fecha), 0.0)  
  
   DECLARE @nValorObs  FLOAT  
       SET @nValorObs  = ISNULL((SELECT isnull(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmcodigo = 994 and vmfecha = @fechaProc), 0.0)  
  
   SELECT tbcateg, tbcodigo1, tbglosa   
     INTO #TABLA_LOCAL_DETALLE  
     FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE   
    WHERE tbcateg IN(204, 1111, 1552, 1553, 1554)  
  
   CREATE INDEX #ix_TABLA_LOCAL_DETALLE ON #TABLA_LOCAL_DETALLE (tbcateg, tbcodigo1)  
  
   SELECT 'Numero_Operacion'    = numero_operacion  
      ,   'Codigo_Cliente'      = codigo_cliente  
      ,   'Nombrecli'  = ISNULL(clnombre, '*')  
      ,   'Tipo_operacion'      = tipo_operacion  
      ,   'NombreOp'  = CASE WHEN tipo_operacion = 'C' THEN'COMPRA ' ELSE 'VENTA  ' END  
      ,   'FechaInicio'  = CONVERT(CHAR(10), fecha_inicio,  103)  
      ,   'FechaCierre'    = CONVERT(CHAR(10), fecha_cierre,  103)  
      ,   'Fechatermino'    = CONVERT(CHAR(10), fecha_termino, 103)  
      ,   'MonedaOperacion' = CASE WHEN tipo_operacion = 'C' THEN compra_moneda ELSE venta_moneda END  
      ,   'NombreMoneda' = ISNULL(mone.mnnemo, '*')  
      ,   'valormoneda'  = ISNULL(valm.vmvalor, 0.0)  
      ,   'MontoOperacion'  = compra_capital  
      ,   'CapitalVigente'  = compra_amortiza  
      ,   'Modalidad'  = ISNULL((CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' ')  
      ,   'rutcli'  = ISNULL(clrut, 0)  
      ,   'digcli'  = ISNULL(cldv , '*')  
      ,   'montouf'  = @nValorUf  
      ,   'montoobs'  = @nValorObs  
      ,   'banco'  = @cNomBanco  
      ,   'fechainicioflujo' = CONVERT(CHAR(10), fecha_inicio_flujo, 103)  
      ,   'fechavenceflujo' = CONVERT(CHAR(10), fecha_vence_flujo,  103)  
      ,   'dias'  = CONVERT(NUMERIC(9), DATEDIFF(DAY, fecha_inicio_flujo, fecha_vence_flujo))  
      ,   'diasDevengo'  = CONVERT(NUMERIC(9), devengo_dias )  
      ,   'cartinversion' = (SELECT DISTINCT ISNULL( rcnombre, '') FROM BacParamSuda..TIPO_CARTERA WHERE rcsistema = 'PCS' AND rcrut = cartera_inversion)  
      ,   'TasaFija'  = compra_valor_tasa + compra_spread  
      ,   'devengodiariom_o' = compra_interes  
      ,   'devengoacumuladom_o' = devengo_compra_acum  
      ,   'devengoacumuladopes' = devengo_monto_peso  
      ,   'Tasavariable' = (compra_valor_tasa + compra_spread)  
      ,   'Flujo'  = 'REC'  
      ,   'hora'  = CONVERT(CHAR(10), GETDATE(), 108)  
      ,   'numero_flujo'        = numero_flujo  
      ,   'Fechaproceso' = SUBSTRING( @fecha    ,7 ,2) + '/' + SUBSTRING( @fecha    , 5, 2) + '/' + SUBSTRING(@fecha    , 1, 4)  
      ,   'FechaDevengo' = SUBSTRING( @fechaProc,7 ,2) + '/' + SUBSTRING( @fechaProc, 5, 2) + '/' + SUBSTRING(@fechaProc, 1, 4)  
      ,   'tipo_swap'           = tipo_swap  
      ,   'SumaCapInicial' = Compra_capital  
      ,   'SumaInteresPAG' = 0  
      ,   'SumaInteresREC' = compra_interes  
      ,   'SumaDiarioPAG' = 0  
      ,   'SumaDiarioREC' = compra_interes  
      ,   'SumaAcumuladoPAG' = 0  
      ,   'SumaAcumuladoREC' = devengo_compra_acum  
      ,   'SumaAcumuladoPesoPAG'= 0  
      ,   'SumaAcumuladoPesoREC'= devengo_monto_peso  
      ,   'Tipo_Cartera'  = cfin.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = '204' AND TBCODIGO1 = cartera_inversion)  
      ,   'Dev_NetoPeso'        = CONVERT(FLOAT, 0.0)  
      ,   'Sum_Dev_NetoPeso'    = CONVERT(FLOAT, 0.0)  
      ,   'Area_Responsable' = area.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Area_Resp    AND TBCODIGO1 = car_area_Responsable)  
      ,   'Cartera_Normativa' = cnor.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Cart_Norm    AND TBCODIGO1 = car_Cartera_Normativa)  
      ,   'SubCartera_Normativa'= subc.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_SubCart_Norm AND TBCODIGO1 = car_SubCartera_Normativa)  
      ,   'Libro'  = libr.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Libro        AND TBCODIGO1 = car_Libro)  
   INTO    #PASO_CARTERA  
   FROM    CARTERA   
           INNER JOIN BacParamSuda.dbo.CLIENTE                    ON clrut   = rut_cliente         AND clcodigo       = codigo_cliente  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ area ON area.tbcateg = @Const_Area_Resp    AND area.tbcodigo1 = car_area_Responsable  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ cnor ON cnor.tbcateg = @Const_Cart_Norm    AND cnor.tbcodigo1 = car_Cartera_Normativa  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ subc ON subc.tbcateg = @Const_SubCart_Norm AND subc.tbcodigo1 = car_SubCartera_Normativa  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ libr ON libr.tbcateg = @Const_Libro        AND libr.tbcodigo1 = car_Libro  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ cfin ON cfin.tbcateg = 204                 AND convert(int,cfin.tbcodigo1) = cartera_inversion  
           LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA          valm ON valm.vmcodigo= compra_moneda       AND vmfecha        = @fechaProc  
           LEFT  JOIN BacParamSuda.dbo.MONEDA                mone ON mone.mncodmon= compra_moneda  
   WHERE  (Fecha_inicio_flujo      <= @Fecha AND Fecha_vence_flujo > @Fecha)  
   AND    (Tipo_swap                = @operacion)  
   AND   (Tipo_Operacion           = @TipoOperacion)  
   AND   (tipo_flujo               = 1)  
   AND   (Estado                  <> 'C')  
   AND   (cartera_inversion        = @Cartera      OR @Cartera      = 0 )  
   AND   (car_area_responsable     = @Area_Resp    OR @Area_Resp    = '')  
   AND   (car_Cartera_Normativa    = @Cart_Norm    OR @Cart_Norm    = '')  
   AND   (car_SubCartera_Normativa = @SubCart_Norm OR @SubCart_Norm = '')  
   AND   (car_Libro                = @Libro        OR @Libro        = '')  
  
  
   UNION  
  
   SELECT 'Numero_Operacion'    = Numero_Operacion  
      ,   'Codigo_Cliente'      = Codigo_Cliente  
      ,   'Nombrecli'  = ISNULL(clnombre ,'*')  
      ,   'Tipo_operacion'      = Tipo_operacion  
      ,   'NombreOp'  = CASE WHEN Tipo_operacion = 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END  
      ,   'FechaInicio'  = CONVERT(CHAR(10), Fecha_inicio,  103)  
      ,   'FechaCierre'    = CONVERT(CHAR(10), Fecha_Cierre,  103)  
      ,   'Fechatermino'    = CONVERT(CHAR(10), Fecha_termino, 103)  
      ,   'MonedaOperacion' = venta_moneda  
      ,   'NombreMoneda' = ISNULL(mone.mnnemo, '*')  --> ISNULL(( SELECT mnnemo  FROM VIEW_MONEDA       WHERE  mncodmon = venta_moneda), '*')  
      ,   'valormoneda'  = ISNULL(valm.vmvalor, 0.0) --> ISNULL(( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = venta_moneda AND vmfecha = @fechaProc ), 0)  
      ,   'MontoOperacion'  = Venta_capital  
      ,   'CapitalVigente'  = Venta_Amortiza  
      ,   'Modalidad'  = ISNULL((CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' ')  
      ,   'rutcli'  = ISNULL(rut_cliente, 0)  
      ,   'digcli'  = ISNULL(cldv, '*')  
      ,   'montouf'  = @nValorUf  
      ,   'montoobs'  = @nValorObs  
      ,   'banco'  = @cNomBanco  
      ,   'fechainicioflujo' = CONVERT(CHAR(10), fecha_inicio_flujo, 103)  
      ,   'fechavenceflujo' = CONVERT(CHAR(10), fecha_vence_flujo,  103)  
      ,   'dias'  = CONVERT(NUMERIC(9), DATEDIFF(DAY, fecha_inicio_flujo, fecha_vence_flujo))  
      ,   'diasDevengo'  = CONVERT(NUMERIC(9), devengo_dias)  
      ,   'cartinversion' = (SELECT DISTINCT ISNULL(rcnombre, '') FROM BacParamSuda..TIPO_CARTERA WHERE rcsistema = 'PCS' AND rcrut = cartera_inversion)  
      ,   'TasaFija'  = (venta_valor_tasa + venta_spread)  
      ,   'devengodiariom_o' = venta_interes      * -1  
      ,   'devengoacumuladom_o' = devengo_venta_acum * -1  
      ,   'devengoacumuladopes' = devengo_monto_peso * -1  
      ,   'Tasavariable' = venta_valor_tasa + venta_spread  
      ,   'Flujo'  = 'PAG'  
      ,   'hora'  = CONVERT(CHAR(10), GETDATE(), 108)  
      ,   'numero_flujo'        = numero_flujo  
      ,   'Fechaproceso' = SUBSTRING( @fecha    , 7, 2) + '/' + SUBSTRING( @fecha    , 5, 2) + '/' + SUBSTRING( @fecha    , 1, 4)  
      ,   'FechaDevengo' = SUBSTRING( @fechaProc, 7, 2) + '/' + SUBSTRING( @fechaProc, 5, 2) + '/' + SUBSTRING( @fechaProc, 1, 4)  
      ,   'tipo_swap'           = tipo_swap  
      ,   'SumaCapInicial' = 0  
      ,   'SumaInteresPAG' = venta_interes      * -1  
      ,   'SumaInteresREC' = 0  
      ,   'SumaDiarioPAG' = venta_interes      * -1  
      ,   'SumaDiarioREC' = 0  
      ,   'SumaAcumuladoPAG' = devengo_venta_acum * -1  
      ,   'SumaAcumuladoREC' = 0  
      ,   'SumaAcumuladoPesoPAG'= devengo_monto_peso * -1  
      ,   'SumaAcumuladoPesoREC'= 0  
      ,   'Tipo_Cartera'  = cfin.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = '204' AND TBCODIGO1 = cartera_inversion)  
      ,   'Dev_NetoPeso'        = 0  
      ,   'Sum_Dev_NetoPeso'    = 0  
  
      ,   'Area_Responsable' = area.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Area_Resp    AND TBCODIGO1 = car_area_Responsable)  
      ,   'Cartera_Normativa' = cnor.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Cart_Norm    AND TBCODIGO1 = car_Cartera_Normativa)  
      ,   'SubCartera_Normativa'= subc.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_SubCart_Norm AND TBCODIGO1 = car_SubCartera_Normativa)  
      ,   'Libro'  = libr.tbglosa --> (SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @Const_Libro        AND TBCODIGO1 = car_Libro)  
   FROM   CARTERA   
           INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = rut_cliente AND clcodigo = codigo_cliente  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ area ON area.tbcateg = @Const_Area_Resp    AND area.tbcodigo1 = car_area_Responsable  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ cnor ON cnor.tbcateg = @Const_Cart_Norm    AND cnor.tbcodigo1 = car_Cartera_Normativa  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ subc ON subc.tbcateg = @Const_SubCart_Norm AND subc.tbcodigo1 = car_SubCartera_Normativa  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ libr ON libr.tbcateg = @Const_Libro        AND libr.tbcodigo1 = car_Libro  
           INNER JOIN #TABLA_LOCAL_DETALLE /*BacParamSuda.dbo.TABLA_GENERAL_DETALLE*/ cfin ON cfin.tbcateg = 204                 AND convert(int, cfin.tbcodigo1) = cartera_inversion  
           LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA          valm ON valm.vmcodigo= venta_moneda        AND vmfecha        = @fechaProc  
           LEFT  JOIN BacParamSuda.dbo.MONEDA                mone ON mone.mncodmon= venta_moneda  
   WHERE  (Fecha_inicio_flujo  <= @Fecha              AND Fecha_vence_flujo >  @Fecha)  
   AND    (Tipo_swap    = @operacion)  
   AND   (Tipo_Operacion   = @TipoOperacion)   
   AND   (tipo_flujo    = 2)  
   AND   (estado                       <> 'C')  
   AND   (cartera_inversion   = @Cartera   OR @Cartera   = 0)  
   AND   (car_area_responsable   = @Area_Resp  OR @Area_Resp   = '')  
   AND   (car_Cartera_Normativa  = @Cart_Norm  OR @Cart_Norm   = '')  
   AND   (car_SubCartera_Normativa  = @SubCart_Norm OR @SubCart_Norm = '')  
   AND   (car_Libro    = @Libro  OR @Libro  = '')  
  
   SELECT   numoper     = numero_operacion  
      ,     devnetopeso = SUM(SumaAcumuladoPesoPAG) + sum(SumaAcumuladoPesoREC)  
   INTO     #paso_sumainte  
   FROM     #PASO_CARTERA  
   GROUP BY numero_operacion  
  
   UPDATE #PASO_CARTERA  
      SET Dev_NetoPeso = isnull(devnetopeso, 0.0)  
     FROM #paso_cartera  
      ,   #paso_sumainte  
    WHERE numoper      = Numero_Operacion   
      and Flujo        = 'PAG'  
  
   DECLARE @SumPesoNetoPeso NUMERIC(21,0)  
   SELECT  @SumPesoNetoPeso = SUM(Dev_NetoPeso)   
     FROM  #PASO_CARTERA  
  
   UPDATE  #PASO_CARTERA   
      SET  sum_dev_netopeso = ISNULL(@SumPesoNetoPeso, 0.0)  
  
   SELECT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #PASO_CARTERA ORDER BY numero_operacion, flujo  
  
END  

GO
