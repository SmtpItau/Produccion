USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFMTM_TASMON]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_INFMTM_TASMON]  (     
                                               @FechaProc CHAR(08)      
     , @CatLibro CHAR(10) = '1552'  
     , @CatCartNorm CHAR(10) = '1111'  
     , @CatSubCart CHAR(10) = '1554'  
     , @CatCartFin CHAR(10) = '204'  
     , @CatAreaResp CHAR(10) = '1553'  
     )  
                   
AS  
BEGIN  
-- Swap: Guardar Como  
 SET NOCOUNT ON  
  
 DECLARE @ACTIVO_FljDescCLP NUMERIC(19,4)  
        , @PASIVO_FljDescCLP NUMERIC(19,4)  
  
 CREATE TABLE #INFORME  
 ( Cartera  CHAR(50)  
 , NumOper  NUMERIC(07,0)  
 , NumFlu  NUMERIC(03,0)  
 , NomCli  CHAR(70)        -- REQ. 7619   
 , TipOper  CHAR(08)  
 , Modalidad CHAR(08)  
 , Periodo  CHAR(03)  
 , FecIni  DATETIME  
 , FecVnc  DATETIME  
 , Moneda  CHAR(08)  
 , Capital  NUMERIC(21,4)  
 , Amortiza NUMERIC(21,4)  
 , Tasa  CHAR(15)  
 , Base  CHAR(15)  
 , ValTasa  NUMERIC(12,8)  
 , MntoMTM  NUMERIC(19,4)  
 , MntoMTMCLP NUMERIC(19,0)  
 , TasaDescto NUMERIC(12,8)  
 , FlujoDesc NUMERIC(19,4)  
 , FljDescCLP NUMERIC(19,0)  
 , DifDescCLP NUMERIC(19,4)  
 , TipoFlu  NUMERIC(01,0)  
 , FechaProc DATETIME  
 , Libro  CHAR(50)  
 , CarteraSuper CHAR(50)  
 , SubCartera CHAR(50)  
 , AreaResp CHAR(50)  
 , ValLibTrading NUMERIC(19,4)  
 , ValLTTM  NUMERIC(19,4)  
 , DiferenciaLT NUMERIC(19,4)  
 , RazonSocial VARCHAR(50)
 )  
  
 CREATE CLUSTERED INDEX INF_001 ON #INFORME (TipoFlu)  
  
  
 CREATE TABLE #TOTAL_ACTIVO  
 ( TipoFlu  NUMERIC(01,00)  
 , LIBRO  CHAR(50)  
 , CARTERASUPER CHAR(50)  
 , SUBCARTERA CHAR(50)  
 , TOTAL_ACTIVO NUMERIC(24,00)  
 )  
 CREATE CLUSTERED INDEX TOACT_001 ON  #TOTAL_ACTIVO (TipoFlu)-- , LIBRO , CARTERASUPER , SUBCARTERA)  
  
 CREATE TABLE #TOTAL_PASIVO  
 ( TipoFlu  NUMERIC(01,00)  
 , LIBRO  CHAR(50)  
 , CARTERASUPER CHAR(50)  
 , SUBCARTERA CHAR(50)  
 , TOTAL_PASIVO NUMERIC(24,00)  
 )  
   
 CREATE CLUSTERED INDEX TOPAS_001 ON  #TOTAL_PASIVO (TipoFlu )--, LIBRO , CARTERASUPER , SUBCARTERA)  
  
 IF EXISTS(SELECT 1 FROM SWAPGENERAL WHERE FechaProc = @FechaProc) BEGIN  
  
  INSERT  INTO #INFORME  
         SELECT 'Cartera' = ISNULL((SELECT TbGlosa FROM view_tabla_general_detalle WHERE tbcateg = @CatCartFin AND CONVERT(INT,Tbcodigo1) = cartera_inversion),'*')  
  , 'NumOper' = Numero_Operacion  
  , 'NumFlu' = Numero_flujo  
  , 'NomCli' = cl.ClNombre     
  , 'TipOper' = CASE Tipo_Swap WHEN 1 THEN 'S.TASA'  
        WHEN 2 THEN 'S.MONEDA'  
        WHEN 3 THEN 'FRA'  
        WHEN 4 THEN 'S.P.CAM.'  
        ELSE 'S/N' END --ISNULL((SELECT TbGlosa FROM view_tabla_general_detalle WHERE tbcateg = 1050 AND Tbcodigo1 = Tipo_Swap),'*')  
  , 'Modalidad' = CASE WHEN Modalidad_Pago = 'C' THEN 'Comp.' ELSE 'E.Fís.' END  
  , 'Periodo' = LEFT(per.Glosa,3)  
  , 'FecIni' = Fecha_Inicio_Flujo  
  , 'fecVnc' = Fecha_Vence_Flujo  
  , 'Moneda' = mn.MnNemo  
  , 'capital' = CASE WHEN Tipo_Flujo = 1 THEN Compra_Saldo + Compra_Amortiza ELSE Venta_Saldo + Venta_Amortiza  END  
  , 'Amortiza' = CASE WHEN Tipo_Flujo = 1 THEN Compra_Amortiza ELSE Venta_amortiza END  
  , 'Tasa'  = ISNULL((SELECT TbGlosa FROM view_tabla_general_detalle WHERE Tbcateg = 1042 AND TbCodigo1 = CASE WHEN Tipo_Flujo = 1  THEn Compra_Codigo_Tasa ELSE Venta_Codigo_Tasa END),'*')  
  , 'Base'  = bs.Glosa  
  , 'ValTasa' = CASE WHEN Fecha_Inicio_Flujo > @FechaProc    
      THEN (CASE WHEN Tipo_Flujo = 1 THEN Tasa_Compra_Curva ELSE Tasa_Venta_Curva END)  
      ELSE (CASE WHEN Tipo_Flujo = 1 THEN Compra_Valor_Tasa ELSE Venta_Valor_Tasa END) END  
  , 'mntoMTM' = CASE WHEN Tipo_Flujo = 1 THEN Activo_MO_C08  ELSE Pasivo_MO_C08  END  
  , 'mntoMTMCLP' = CASE WHEN Tipo_Flujo = 1 THEN Activo_CLP_C08 ELSE Pasivo_CLP_C08 END  
  , 'TasaDescto' = CASE WHEN Tipo_Flujo = 1 THEN Tasa_Compra_CurvaVR ELSE Tasa_Venta_CurvaVR END   
  , 'FlujoDesc' = CASE WHEN Tipo_Flujo = 1 THEN Activo_FlujoMO ELSE Pasivo_FlujoMO END  
  , 'FljDescCLP' = CASE WHEN Tipo_Flujo = 1 THEN Activo_FlujoCLP ELSE Pasivo_FlujoCLP END  
  , 'DifDescCLP' = CAST (0 AS NUMERIC (19,4))  
  , 'TipoFlu' = Tipo_Flujo  
  , 'FechaProc' = CONVERT(DATETIME,@FechaProc)  
  , 'Libro'  = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = car_Libro),'NO ESPECIFICADO')  
  , 'CarteraSuper' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = car_Cartera_Normativa),'NO ESPECIFICADO')  
  , 'SubCartera' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatSubCart AND TBCODIGO1 = car_SubCartera_Normativa),'NO ESPECIFICADO')  
  , 'AreaResp' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = car_area_Responsable),'NO ESPECIFICADO')  
  ,  ISNULL(Clt_VPTC_ValAct,0)  
  ,  ISNULL(Clt_VPTM_ValAct,0)  
  ,  ISNULL(Clt_Res_VM_VP,0)   
  , 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
  FROM CARTERA  
       LEFT JOIN BACTRADERSUDA..TBL_CARTERA_LIBRE_TRADING ON Clt_FechaProc  = @FechaProc AND Clt_Sistema = 'PCS' AND Clt_NumOper = numero_operacion AND Clt_NumCorr = numero_flujo  
  , View_Periodo_Amortizacion per  
  , View_Cliente              cl  
  , View_Moneda               mn   
  , Base                      bs  
    WHERE cl.ClRut       = Rut_Cliente  
  AND cl.ClCodigo = Codigo_Cliente  
  AND per.Sistema = 'PCS'   
  AND per.Tabla = 1044  
  AND mn.MnCodMon = CASE WHEN Tipo_Flujo = 1 THEN Compra_Moneda         ELSE Venta_Moneda END  
  AND bs.Codigo = CASE WHEN Tipo_Flujo = 1 THEN Compra_Base           ELSE Venta_Base   END  
  AND per.Codigo = CASE WHEN Tipo_Flujo = 1 THEN Compra_CodAmo_Interes ELSE Venta_CodAmo_Interes END  
                AND     Fecha_Termino <> @FechaProc  -- MAP 20060726  
                AND     Estado  <> 'C'  
  
 END  
 ELSE BEGIN  
  
  INSERT  INTO #INFORME  
         SELECT 'Cartera' = ISNULL((SELECT TbGlosa FROM view_tabla_general_detalle WHERE tbcateg = @CatCartFin AND CONVERT(INT,Tbcodigo1) = cartera_inversion),'*')  
  , 'NumOper' = Numero_Operacion  
  , 'NumFlu' = Numero_flujo  
  , 'NomCli' = cl.ClNombre     
  , 'TipOper' = Case Tipo_Swap WHEN 1 THEN 'S.TASA'  
        WHEN 2 THEN 'S.MONEDA'  
        WHEN 3 THEN 'FRA'  
        WHEN 4 THEN 'S.P.CAM.'  
        ELSE 'S/N' END --ISNULL((SELECT TbGlosa FROM view_tabla_general_detalle WHERE tbcateg = 1050 AND Tbcodigo1 = Tipo_Swap),'*')  
  , 'Modalidad' = CASE WHEN Modalidad_Pago = 'C' THEN 'Comp.' ELSE 'E.Fís.' END  
  , 'Periodo' = LEFT(per.Glosa,3)  
  , 'FecIni' = Fecha_Inicio_Flujo  
  , 'fecVnc' = Fecha_Vence_Flujo  
  , 'Moneda' = mn.MnNemo  
  , 'capital' = CASE WHEN Tipo_Flujo = 1 THEN Compra_Saldo + Compra_Amortiza ELSE Venta_Saldo + Venta_Amortiza  END  
  , 'Amortiza' = CASE WHEN Tipo_Flujo = 1 THEN Compra_Amortiza ELSE Venta_amortiza END  
  , 'Tasa'  = ISNULL((SELECT TbGlosa FROM view_tabla_general_detalle WHERE Tbcateg = 1042 AND TbCodigo1 = CASE WHEN Tipo_Flujo = 1  THEn Compra_Codigo_Tasa ELSE Venta_Codigo_Tasa END),'*')  
  , 'Base'  = bs.Glosa  
  , 'ValTasa' = CASE WHEN Fecha_Inicio_Flujo > @FechaProc    
      THEN (CASE WHEN Tipo_Flujo = 1 THEN Tasa_Compra_Curva ELSE Tasa_Venta_Curva END)  
      ELSE (CASE WHEN Tipo_Flujo = 1 THEN Compra_Valor_Tasa ELSE Venta_Valor_Tasa END) END  
  , 'mntoMTM' = CASE WHEN Tipo_Flujo = 1 THEN Activo_MO_C08  ELSE Pasivo_MO_C08  END  
  , 'mntoMTMCLP' = CASE WHEN Tipo_Flujo = 1 THEN Activo_CLP_C08 ELSE Pasivo_CLP_C08 END  
  , 'TasaDescto' = CASE WHEN Tipo_Flujo = 1 THEN Tasa_Compra_CurvaVR ELSE Tasa_Venta_CurvaVR END   
  , 'FlujoDesc' = CASE WHEN Tipo_Flujo = 1 THEN Activo_FlujoMO ELSE Pasivo_FlujoMO END  
  , 'FljDescCLP' = CASE WHEN Tipo_Flujo = 1 THEN Activo_FlujoCLP ELSE Pasivo_FlujoCLP END  
  , 'DifDescCLP' = CAST (0 AS NUMERIC (19,4))  
  , 'TipoFlu' = Tipo_Flujo  
  , 'FechaProc' = CONVERT(DATETIME,@FechaProc)  
  , 'Libro'  = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro AND TBCODIGO1 = cre_Libro),'NO ESPECIFICADO')  
  , 'CarteraSuper' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = cre_Cartera_Normativa),'NO ESPECIFICADO')  
  , 'SubCartera' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatSubCart AND TBCODIGO1 = cre_SubCartera_Normativa),'NO ESPECIFICADO')  
  , 'AreaResp' = ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = cre_area_Responsable),'NO ESPECIFICADO')  
  , ISNULL(Clt_VPTC_ValAct,0)  
  , ISNULL(Clt_VPTM_ValAct,0)  
  , ISNULL(Clt_Res_VM_VP,0)    
  , 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
  FROM CARTERARES  
   LEFT JOIN BACTRADERSUDA..TBL_CARTERA_LIBRE_TRADING ON Clt_FechaProc = @FechaProc AND Clt_Sistema = 'PCS' AND Clt_NumOper = numero_operacion AND Clt_NumCorr = numero_flujo  
  , View_Periodo_Amortizacion per  
  , View_Cliente              cl  
  , View_Moneda               mn   
  , Base                      bs  
  WHERE Fecha_Proceso = @FechaProc  
  AND cl.ClRut = Rut_Cliente  
  AND cl.ClCodigo = Codigo_Cliente  
  AND per.Sistema = 'PCS'   
  AND per.Tabla = 1044  
  AND mn.MnCodMon = CASE WHEN Tipo_Flujo = 1 THEN Compra_Moneda         ELSE Venta_Moneda END  
  AND bs.Codigo = CASE WHEN Tipo_Flujo = 1 THEN Compra_Base           ELSE Venta_Base   END  
  AND per.Codigo = CASE WHEN Tipo_Flujo = 1 THEN Compra_CodAmo_Interes ELSE Venta_CodAmo_Interes END  
                AND     Fecha_Termino <> @FechaProc -- MAP 20060726  
                AND     Estado  <> 'C'  
  
 END  
  
 INSERT  INTO #TOTAL_ACTIVO  
 SELECT TipoFlu  
 , LIBRO  
 , CARTERASUPER  
 , SUBCARTERA  
 , SUM(FljDescCLP)   
 FROM #Informe  
 WHERE TipoFlu = 1  
 GROUP  
 BY LIBRO  
 , CARTERASUPER  
 , SUBCARTERA  
 , TipoFlu  
  
 INSERT INTO #TOTAL_PASIVO   
 SELECT TipoFlu  
 , LIBRO  
 , CARTERASUPER  
 , SUBCARTERA  
 , SUM(FljDescCLP)    
 FROM #Informe  
 WHERE TipoFlu = 2   
 GROUP  
 BY LIBRO  
 , CARTERASUPER  
 , SUBCARTERA  
 , TipoFlu  
  
 UPDATE #Informe  
 SET DifDescCLP = ( ISNULL(A.TOTAL_ACTIVO,0) - ISNULL(B.TOTAL_PASIVO,0))  
 FROM #Informe   
  LEFT JOIN #TOTAL_ACTIVO A ON #Informe.LIBRO = A.LIBRO AND #Informe.CARTERASUPER = A.CARTERASUPER AND #Informe.SUBCARTERA = A.SUBCARTERA  
     LEFT JOIN #TOTAL_PASIVO B ON #Informe.LIBRO = B.LIBRO AND #Informe.CARTERASUPER = B.CARTERASUPER AND #Informe.SUBCARTERA = B.SUBCARTERA  
  
 IF @@RowCount = 0   
  INSERT #Informe      
                SELECT 'Cartera'    = 'SIN INFO'  
                      ,'NumOper'    = 0  
                      ,'NumFlu'     = 0  
                      ,'NomCli'     = ''  
                      ,'TipOper'    = ''  
                      ,'Modalidad'  = ''  
                      ,'Periodo'    = ''  
                      ,'FecIni'     = ''  
                      ,'fecVnc'     = ''  
                      ,'Moneda'     = ''  
                      ,'capital'    = 0  
                      ,'Amortiza'   = 0  
                      ,'Tasa'       = ''  
                      ,'Base'       = ''  
                      ,'ValTasa'    = 0  
                      ,'mntoMTM'    = 0  
                      ,'mntoMTMCLP' = 0  
                      ,'TasaDescto' = 0  
                      ,'FlujoDesc'  = 0  
                      ,'FljDescCLP' = 0  
                      ,'DifDescCLP' = 0  
                      ,'TipoFlu'    = 0  
                      ,'FechaProc'  = CONVERT(DATETIME,@FechaProc)  
  , 'Libro'  = ''  
  , 'CarteraSuper' = ''  
  , 'SubCartera' = ''  
  , 'AreaResp' = ''  
  , 'ValLibTrading' = 0  
  , 'ValLTTM' = 0  
  , 'DiferenciaLT' = 0   
  , 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales)
  
        -->Salida       
        SELECT * FROM #Informe ORDER BY NumOper ,NumFlu ,TipoFlu  
  
 SET NOCOUNT OFF  
  
END  

GO
