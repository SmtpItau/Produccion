USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_OPER_COT]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_OPER_COT]  
(  
 @nContrato numeric (10)  
, @nOrigen varchar(1)  
)  
AS  
BEGIN  
  
IF @nOrigen = 'O'  
BEGIN  
    -->    Control de Existencia de la Operación  
   IF NOT EXISTS(SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nContrato)  
   BEGIN  
      SELECT -1, 'Operación No se encuentra en Cartera'  
  RETURN  
   END  
  
   -->    Control de Existencia de la Operación como Operación [Si es Cotización, Avisa]  
   IF EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nContrato AND estado = 'C')  
   BEGIN  
      SELECT -1, 'Número de operacion correspone a una cotizacion.'  
      RETURN -1  
   END  
END ELSE  
BEGIN  
   -->    Control de Existencia de la Cotización  
   IF NOT EXISTS(SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nContrato)  
   BEGIN  
      SELECT -1, 'Cotización No se encuentra en Ingresada'  
  RETURN  
   END  
  
   -->    Control de Existencia de la Cotización como Cotización [Si NO es Cotización, Avisa]  
   IF EXISTS( SELECT 1 FROM BacSwapSuda.dbo.CARTERA WHERE numero_operacion = @nContrato AND estado = '')  
   BEGIN  
      SELECT -1, 'Número de cotizacion correspone a una operación.'  
      RETURN -1  
   END  
END  
  
 SELECT TOP 1  
   Contrato                   = CONVERT(INT, cacomp.numero_operacion )  
  ,      Producto                   = CASE WHEN cacomp.tipo_swap = 1 THEN 'SWAP DE TASAS'   
             WHEN cacomp.tipo_swap = 2 THEN 'SWAP DE MONEDAS'  
             WHEN cacomp.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'  
           END  
  ,      Rut                         = CONVERT(INT, cacomp.rut_cliente)  
  ,      Nombre      = CONVERT(VARCHAR(50), SUBSTRING(cli.clnombre, 1,50))  
  ,      FechaCierre     = CONVERT(CHAR(10), cacomp.fecha_cierre, 103)  
  ,      FechaInicio     = CONVERT(CHAR(10), cacomp.fecha_inicio, 103)  
  ,      FechaTermino    = CONVERT(CHAR(10), cacomp.fecha_termino, 103)  
  ,      Moneda      = CONVERT(CHAR(10), LTRIM(RTRIM( mn.mnnemo      )) + ' / ' + LTRIM(RTRIM( pas.Moneda      )))  
  ,      Capital                     = CONVERT(CHAR(50), LTRIM(RTRIM( cacomp.compra_capital   )) + ' / ' + LTRIM(RTRIM( pas.Capital     )))  
  ,      FrecuenciaPago    = CONVERT(CHAR(30), LTRIM(RTRIM( fpa.glosa      )) + ' / ' + LTRIM(RTRIM( pas.FrecPago    )))  
  ,      FrecuenciaCapital   = CONVERT(CHAR(30), LTRIM(RTRIM( fca.glosa      )) + ' / ' + LTRIM(RTRIM( pas.FrecCapit   )))  
  ,      Indicador     = CONVERT(CHAR(30), LTRIM(RTRIM( ind.tbglosa     )) + ' / ' + LTRIM(RTRIM( pas.Indicador   )))  
  ,      Tasa      = CONVERT(CHAR(50), LTRIM(RTRIM( cacomp.compra_valor_tasa )) + ' / ' + LTRIM(RTRIM( pas.Valor       )))  
  ,      Spread      = CONVERT(CHAR(50), LTRIM(RTRIM( cacomp.compra_spread   )) + ' / ' + LTRIM(RTRIM( Pas.Spread      )))  
  ,      ConteoDias     = CONVERT(CHAR(30), LTRIM(RTRIM( bas.glosa      )) + ' / ' + LTRIM(RTRIM( Pas.ConteoDias  )))   
  ,      MonedaPago     = CONVERT(CHAR(10), LTRIM(RTRIM( mnp.mnnemo      )) + ' / ' + LTRIM(RTRIM( pas.MonedaPago  )))  
  ,      MedioPago     = CONVERT(CHAR(30), LTRIM(RTRIM( fdp.glosa      )) + ' / ' + LTRIM(RTRIM( pas.MedioPago   )))  
  ,      CarteraFinanciera   = CONVERT(VARCHAR(30), cfi.tbglosa  )  
  ,      CarteraNormativa   = CONVERT(VARCHAR(30), cno.tbglosa      )  
  ,      SubCartera     = CONVERT(VARCHAR(30), sca.tbglosa      )  
  ,      Libro      = CONVERT(VARCHAR(30), lib.tbglosa      )  
  ,      AreaResponsable    = CONVERT(VARCHAR(30), are.tbglosa      )  
  ,  ModalidadPago    =    CASE WHEN cacomp.modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'E. FISICA'END   
          + ' / ' + CASE WHEN pas.Modalidad    = 'C' THEN 'COMPENSACION' ELSE 'E. FISICA'END   
  ,  TipoSwap     = CASE WHEN cacomp.tipo_swap = 1 THEN 'SWAP DE TASAS'   
              WHEN cacomp.tipo_swap = 2 THEN 'SWAP DE MONEDAS'  
              WHEN cacomp.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'  
            END  
  ,  Operador     = LTRIM(RTRIM( isnull(usr.nombre,cacomp.operador) ))  
  ,  ValorRazobable    = cacomp.Valor_RazonableCLP  
 FROM    BacSwapSuda.dbo.CARTERA     cacomp  
   INNER JOIN (SELECT TOP 1  
        Contrato            = cavent.numero_operacion  
       ,   Moneda              = mn.mnnemo  
       ,   Capital             = cavent.venta_capital  
       ,   Indicador           = ind.tbglosa  
       ,   Valor               = cavent.venta_valor_tasa  
       ,   FrecPago            = fpa.glosa  
       ,   FrecCapit           = fca.glosa  
       ,   Spread              = cavent.venta_spread  
       ,   ConteoDias          = bas.glosa  
       ,   MonedaPago          = mnp.mnnemo  
       ,   MedioPago           = fdp.glosa  
       , Modalidad   = cavent.modalidad_pago  
       , Flujo       = Pasivo_FlujoCLP  
      FROM    BacSwapSuda.dbo.CARTERA                       cavent  
        LEFT JOIN BacparamSuda.dbo.MONEDA                 mn ON mn.mncodmon  = cavent.venta_moneda  
        LEFT JOIN BacparamSuda.dbo.TABLA_GENERAL_DETALLE ind ON ind.tbcateg  = 1042 AND ind.tbcodigo1   = cavent.venta_codigo_tasa  
        LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  fca ON fca.tabla    = 1043 AND fca.codigo      = cavent.venta_codamo_capital  
        LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  fpa ON fpa.tabla    = 1044 AND fpa.codigo      = cavent.venta_codamo_interes  
        LEFT JOIN BacSwapSuda.dbo.BASE                   bas ON bas.codigo   = cavent.venta_base  
        LEFT JOIN BacparamSuda.dbo.MONEDA                mnp ON mnp.mncodmon = cavent.pagamos_moneda  
        LEFT JOIN BacparamSuda.dbo.FORMA_DE_PAGO         fdp ON fdp.codigo   = cavent.pagamos_documento  
        WHERE cavent.numero_operacion    = @nContrato  
       AND    cavent.tipo_flujo          = 2  
     ) Pas   ON Pas.Contrato      = cacomp.numero_operacion  
  
  
            LEFT JOIN BacParamSuda.dbo.MONEDA                  mn ON mn.mncodmon  = cacomp.compra_moneda  
            LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE  ind ON ind.tbcateg  = 1042 AND ind.tbcodigo1 = cacomp.compra_codigo_tasa  
            LEFT JOIN BacParamSuda.dbo.CLIENTE                cli ON cli.clrut    = cacomp.rut_cliente AND cli.Clcodigo = cacomp.codigo_cliente  
            LEFT JOIN BacparamSuda.dbo.TABLA_GENERAL_DETALLE  cfi ON cfi.tbcateg  = 204  AND CONVERT(INT,cfi.tbcodigo1) = cacomp.cartera_inversion  
            LEFT JOIN BacparamSuda.dbo.TABLA_GENERAL_DETALLE  cno ON cno.tbcateg  = 1111 AND cno.tbcodigo1 = cacomp.car_Cartera_Normativa  
            LEFT JOIN BacparamSuda.dbo.TABLA_GENERAL_DETALLE  lib ON lib.tbcateg  = 1552 AND lib.tbcodigo1 = cacomp.car_Libro  
            LEFT JOIN BacparamSuda.dbo.TABLA_GENERAL_DETALLE  are ON are.tbcateg  = 1553 AND are.tbcodigo1 = cacomp.car_area_Responsable  
            LEFT JOIN BacparamSuda.dbo.TABLA_GENERAL_DETALLE  sca ON sca.tbcateg  = 1554 AND sca.tbcodigo1 = cacomp.car_SubCartera_Normativa  
            LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION   fca ON fca.tabla    = 1043 AND fca.codigo             = cacomp.compra_codamo_capital  
            LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION   fpa ON fpa.tabla    = 1044 AND fpa.codigo             = cacomp.compra_codamo_interes  
            LEFT JOIN BacSwapSuda.dbo.BASE                    bas ON bas.codigo   = cacomp.compra_base  
            LEFT JOIN BacparamSuda.dbo.MONEDA                 mnp ON mnp.mncodmon = cacomp.recibimos_moneda  
            LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO          fdp ON fdp.codigo   = cacomp.recibimos_documento  
   LEFT JOIN BacParamSuda.dbo.USUARIO      usr ON usr.usuario  = cacomp.operador  
 WHERE   cacomp.numero_operacion    = @nContrato  
    AND     cacomp.tipo_flujo          = 1  
  
END  
GO
