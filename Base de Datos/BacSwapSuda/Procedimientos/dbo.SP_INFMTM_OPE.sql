USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFMTM_OPE]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFMTM_OPE] ( @FechaProc CHAR(08)  
     , @CatLibro CHAR(10) = '1552'   
     , @CatCartNorm CHAR(10) = '1111'  
     , @CatSubCart CHAR(10) = '1554'  
     , @CatCartFin CHAR(10) = '204'  
     , @CatAreaResp CHAR(10) = '1553'  
     )  
AS  
BEGIN  
  
 SET NOCOUNT ON  
-- Swap: Guardar Como            
 --> PREPARA TABLA PARA OBTENER DATA X FECHA DE PROCESO  
 SELECT   Fecha_Proceso  
                ,numero_operacion  
                ,numero_flujo  
                ,tipo_flujo  
                ,tipo_swap  
                ,cartera_inversion  
                ,tipo_operacion  
                ,codigo_cliente  
                ,rut_cliente  
                ,fecha_cierre  
                ,fecha_inicio  
                ,fecha_termino  
                ,compra_moneda  
                ,compra_capital  
                ,compra_codigo_tasa  
                ,compra_codamo_interes  
                ,venta_moneda  
                ,venta_capital                     
                ,venta_codigo_tasa  
                ,venta_codamo_interes  
                ,modalidad_pago  
                ,Activo_USD_C08  
                ,Pasivo_USD_C08  
                ,Activo_CLP_C08  
                ,Pasivo_CLP_C08  
                ,Valor_RazonableUSD  
                ,Valor_RazonableCLP  
                ,cre_area_responsable  
                ,cre_cartera_normativa  
                ,cre_subcartera_normativa  
                ,cre_libro  
                ,ActivoTir  
                ,PasivoTir  
                ,ActivoTirCnv  
                ,PasivoTirCnv  
        INTO #DATAXFECHA FROM CARTERARES WHERE 1=0  
  
 --> VALIDA DESDE DONDE RECUPERAR LA INFO  
 IF EXISTS(SELECT 1 FROM SWAPGENERAL WHERE FechaProc = @FechaProc) BEGIN  
  
  INSERT #DATAXFECHA   
                SELECT   @FechaProc                  
                        ,numero_operacion  
                        ,numero_flujo  
                        ,tipo_flujo  
                        ,tipo_swap  
                        ,cartera_inversion  
                        ,tipo_operacion  
                        ,codigo_cliente  
                        ,rut_cliente  
                        ,fecha_cierre  
                        ,fecha_inicio  
                        ,fecha_termino  
                        ,compra_moneda  
                        ,compra_capital  
                        ,compra_codigo_tasa  
                        ,compra_codamo_interes  
                        ,venta_moneda  
                        ,venta_capital                     
                        ,venta_codigo_tasa  
                        ,venta_codamo_interes  
                        ,modalidad_pago  
                        ,Activo_USD_C08  
                        ,Pasivo_USD_C08  
                        ,Activo_CLP_C08  
                        ,Pasivo_CLP_C08  
                        ,Valor_RazonableUSD  
                        ,Valor_RazonableCLP  
                        ,car_area_responsable  
                        ,car_cartera_normativa  
                        ,car_subcartera_normativa  
                        ,car_libro  
                        ,ActivoTir  
                        ,PasivoTir  
                        ,ActivoTirCnv  
                        ,PasivoTirCnv    
                FROM CARTERA  
                where fecha_termino <> @FechaProc -- MAP 20060726 No se despliega el VR de un SWAP que vence globalmente  
                and   estado        <> 'C'  
                and   estado_flujo  = 1  -- CER 20081118  Para que no se dupliquen flujos que se pagan en una misma fecha.  
 END  
 ELSE BEGIN  
  INSERT #DATAXFECHA   
                SELECT   Fecha_Proceso  
                        ,numero_operacion  
                        ,numero_flujo  
                        ,tipo_flujo  
                        ,tipo_swap  
                        ,cartera_inversion  
                        ,tipo_operacion  
                        ,codigo_cliente  
                        ,rut_cliente  
                        ,fecha_cierre  
              ,fecha_inicio  
                        ,fecha_termino  
                        ,compra_moneda  
              ,compra_capital  
                        ,compra_codigo_tasa  
                        ,compra_codamo_interes  
                        ,venta_moneda  
                        ,venta_capital                     
                        ,venta_codigo_tasa  
                        ,venta_codamo_interes  
                        ,modalidad_pago  
                        ,Activo_USD_C08  
                        ,Pasivo_USD_C08  
                        ,Activo_CLP_C08  
                        ,Pasivo_CLP_C08  
                        ,Valor_RazonableUSD  
                        ,Valor_RazonableCLP  
                        ,cre_area_responsable  
                        ,cre_cartera_normativa  
                        ,cre_subcartera_normativa  
                        ,cre_libro  
                        ,ActivoTir  
                        ,PasivoTir  
                        ,ActivoTirCnv  
                        ,PasivoTirCnv   
                FROM CARTERARES WHERE fecha_proceso = @FechaProc  
                AND fecha_termino <> @FechaProc -- MAP 20060726 No se despliega el VR de un SWAP que vence globalmente  
                AND estado        <> 'C'  
                AND estado_flujo  = 1     -- CER 20081118  Para que no se dupliquen flujos que se pagan en una misma fecha.  
 END  
  
          
          
  
 --> TABLA TEMPORAL PARA IGUALAR REGISTROS PASIVOS.  
 SELECT * INTO #CARTERA FROM #DATAXFECHA  
  
        --> ELIMINANDO REGISTROS PASIVOS  
 DELETE #CARTERA WHERE Tipo_Flujo = 2  
      
 --> ACTUALIZANDO REGISTROS PASIVOS EN FLUJO ACTIVO  
 UPDATE #CARTERA    
 SET venta_codamo_interes = CTR.venta_codamo_interes  
 , venta_codigo_tasa = CTR.venta_codigo_tasa  
 , venta_capital  = CTR.venta_capital  
 , venta_moneda  = CTR.venta_moneda    
 , pasivo_usd_c08  = CTR.pasivo_usd_c08  
 , pasivo_clp_c08  = CTR.pasivo_clp_c08  
        ,       PasivoTirCnv            = CTR.PasivoTirCnv  
 FROM #DATAXFECHA Ctr  
 WHERE CTR.numero_operacion = #CARTERA.numero_operacion  
 AND CTR.tipo_flujo  <> #CARTERA.tipo_flujo  
  
   
 -->DATOS DEL INFORME  
 SELECT DISTINCT  
  'Cartera' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 204 AND CONVERT(INT,Tbcodigo1) = cartera_inversion),'*')  
 , 'NumOper' = numero_operacion  
 , 'NomCli' = CL.clnombre     
 , 'TipOper' = CASE tipo_swap WHEN 1 THEN 'IRS'   
       WHEN 2 THEN 'CCS'  
       WHEN 3 THEN 'FRA'  
       WHEN 4 THEN 'SPC'  
       ELSE LTRIM(RTRIM(CONVERT(CHAR,tipo_swap))) END  
 , 'Modalidad' = modalidad_pago  
 , 'PeriodoPag' = ISNULL((SELECT LEFT(glosa,3) FROM VIEW_PERIODO_AMORTIZACION WHERE tabla = 1044 AND sistema = 'PCS' AND codigo = venta_codamo_interes),'*')  
 , 'PeriodoRec' = ISNULL((SELECT LEFT(glosa,3) FROM VIEW_PERIODO_AMORTIZACION WHERE tabla = 1044 AND sistema = 'PCS' AND codigo = compra_codamo_interes),'*')  
 , 'FecIni' = fecha_cierre  
 , 'fecVnc' = fecha_termino  
 , 'MonedaPag' = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = venta_moneda),'*')  
 , 'MonedaREc' = ISNULL((SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = compra_moneda),'*')  
 , 'capitalPag' = venta_capital  
 , 'capitalRec' = compra_capital  
 , 'TasaPag' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 AND tbcodigo1 = venta_codigo_tasa),'*')  
 , 'TasaRec' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 1042 AND tbcodigo1 = Compra_Codigo_Tasa),'*')  
 , 'mntoMTMUSD' = CAST (0 AS NUMERIC(19,4))  
 , 'mntoMTMCLP' = CAST (0 AS NUMERIC(19,4))  
 , 'ValRazUSD' = valor_razonableusd  
 , 'ValRazCLP' = valor_razonableclp  
 , 'FechaProc' = CONVERT(DATETIME,@FechaProc)  
 , 'Libro'  = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = cre_Libro),'NO ESPECIFICADO')  
 , 'CarteraSuper' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = cre_Cartera_Normativa),'NO ESPECIFICADO')  
 , 'SubCartera' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatSubCart AND TBCODIGO1 = cre_SubCartera_Normativa),'NO ESPECIFICADO')  
 , 'AreaResp' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = cre_area_Responsable),'NO ESPECIFICADO')  
        ,       'ActivoTirCnv'  = ActivoTirCnv   
        ,       'PasivoTirCnv'  = PasivoTirCnv   
		, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
         
 INTO #INFORME  
 FROM #CARTERA  
 , VIEW_CLIENTE CL  
 WHERE CL.ClRut = Rut_Cliente  
 AND CL.ClCodigo = Codigo_Cliente  
  
  
 IF @@ROWCOUNT > 0 BEGIN  -->OBTIENE SUMAS TOTALES DIFERIDAS ENTRE MONTOS MTM C08.   
  UPDATE #INFORME  
  SET mntoMTMUSD = (SELECT SUM(CTR.activo_usd_c08  - CTR.pasivo_usd_c08) FROM CARTERA CTR WHERE CTR.numero_operacion = #INFORME.numoper)  
  , mntoMTMCLP = (SELECT SUM(CTR.activo_clp_c08  - CTR.pasivo_clp_c08) FROM CARTERA CTR WHERE CTR.numero_operacion = #INFORME.numoper)  
 END   
 ELSE BEGIN  
  --> NO EXISTE INFORMACION EN EL REPORTE  
  INSERT #INFORME  
  SELECT 'cartera' = 'sin info'  
  , 'numoper' = 0  
  , 'nomcli' = ''  
  , 'tipoper' = ''  
  , 'modalidad' = ''  
  , 'periodopag' = ''  
  , 'periodorec' = ''  
  , 'fecini' = ''  
  , 'fecvnc' = ''  
  , 'monedapag' = ''  
  , 'monedarec' = ''  
  , 'capitalpag' = 0  
  , 'capitalrec' = 0  
  , 'tasapag' = ''  
  , 'tasarec' = ''  
  , 'mntomtm' = 0  
  , 'mntomtmclp' = 0  
  , 'valrazusd' = 0  
  , 'fljdescclp' = 0  
  , 'fechaproc' = CONVERT(DATETIME,@fechaproc)  
  , 'Libro'  = ''  
  , 'CarteraSuper' = ''  
  , 'SubCartera' = ''  
  , 'AreaResp' = ''  
  ,       'ActivoTirCnv'  = 0  
  ,       'PasivoTirCnv'  = 0  
  , 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
  
 END  
            -->salida       
 SELECT *    
 FROM #INFORME   
 ORDER  
 BY numoper   
  
 SET NOCOUNT OFF  
END

GO
