USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MTM_ARBITRAJES_MX_USD]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_MTM_ARBITRAJES_MX_USD] ( @dFechaRevision  DATETIME  
      )  
AS  
BEGIN  
  
 SET NOCOUNT ON   
  
 CREATE TABLE #ARBI_TMP  
 ( NumOperacion  NUMERIC(19,0)  
 , CodigoOperacion  INT  
 , TipoOper  CHAR(1)  -- COMPRA/VENTA  
 , FechaVcto  DATETIME  
 , FechaEfectiva  DATETIME  
 , MonedaPrincipal  CHAR(5)  
 , MonedaSecundaria CHAR(5)  
 , MontoPrincipal   NUMERIC(21,4)  
 , MontoSecundario  NUMERIC(21,4)
 , TipoOperCnv   CHAR(1)  -- SI ES COMPRA SE PONE VENTA Y VISEVBERSA  
 , Plazo         INT  
 , BaseCalculo   INT  
 , PrecioFutOpe  FLOAT  -- catipcam  
 , PrecioFwdCal  FLOAT  
 , TasaCurvaPrinc  FLOAT  
 , TasaCurvaSecun  FLOAT  
	,	CurvaPrinc		CHAR(20) -- CHAR(10) PRDXXXX
	,	CurvaSecun		CHAR(20) -- CHAR(10) PRDXXXX
 , TasaFwd   FLOAT  
 , PuntaSpot  FLOAT  
 , TasaUSD   FLOAT  
 , TasaBidMe  FLOAT  
 , TasaBidMa  FLOAT  
 , TasaAskMe  FLOAT  
 , TasaAskMa  FLOAT  
 , PlazoCalMe  INT  
 , PlazoCalMa  INT  
 , DifTasaBid  FLOAT  
 , DifTasaAsk  FLOAT  
 , DifPlazo  INT  
 , InterpBid  FLOAT  
 , InterpAsk  FLOAT  
 , ReferenciaDolar  CHAR(1)  -- INDICA SI SE DEBE DIVIDIR O MULTIPLICAR POR EL DOLAR  
 , Valor_Futuro				NUMERIC(21,2)  
 , Valor_Mercado			NUMERIC(21,2)  
 , Valor_Activo				NUMERIC(21,2)  
 , Valor_Pasivo				NUMERIC(21,2)  
 , Valor_Obtenido			FLOAT  
 , DifPre					FLOAT  
 , ValorRazonableActivo		FLOAT  
 , ValorRazonablePasivo		FLOAT  
 , ResultadoMTM				FLOAT  
 -- Colateral
 , Marca_Colateral			Varchar(1)
 , Moneda_Colateral			varchar(5)
 , CurvaColPric				varchar(50) 
 , CurvaColSec				varchar(50) 
 , TasaCurvaPrincipal_Col	Float
 , TasaCurvaSecundaria_Col  Float
 , wfPrincipalCol           Float
 , wfSecundariaCol          Float
 , ValorRazonableActivoCol  Float 
 , ValorRazonablePasivoCol  Float 
 , MTM_Col                  Float
 , VMC_Principal            Float
 -- Colateral
)  
   
 CREATE NONCLUSTERED INDEX ARBI_TMP_001 ON #ARBI_TMP  
 ( CodigoOperacion  
 , NumOperacion  
 )  
  
-- DECLARE @dFechaRevision  DATETIME   
 DECLARE @FechaCalculos  DATETIME  
 , @Valor_Dolar  NUMERIC(21,4)  
  
-- SET @dFechaRevision = '20100421' --@fechaproceso   
 SELECT @FechaCalculos = CASE WHEN DATEPART(MONTH, acfecproc) = DATEPART(MONTH, acfecprox) THEN acfecproc  
     ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, acfecproc)) *-1, DATEADD(MONTH, 1, acfecproc) )  
     END  
 FROM MFAC  
  
 	SELECT  CP.CodigoCurva
	,	CP.Producto
	,	CP.Moneda
	,	CP.CurAlter
	,	IsValid    = 0
	,   DF.CurvaLocal  -- Homologar Por Favor */
	INTO    #TMPCURVASFORWARD
	FROM    BACPARAMSUDA.DBO.CURVAS_PRODUCTO  CP 
	LEFT join BacParamSuda.dbo.Definicion_Curvas  DF on DF.CodigoCurva = CP.CodigoCurva
	WHERE   modulo     = 'BFW'
	AND     TipoTasa   = 'N'
	AND      producto in ( 2 ) 
  
 CREATE NONCLUSTERED INDEX TMPCURVASFORWARD_001 ON #TMPCURVASFORWARD  
 ( CodigoCurva  
 , Producto  
 , Moneda  
 )  
  
 INSERT INTO #ARBI_TMP  
 SELECT 'NumOperacion'  = canumoper  
 , 'CodigoOperacion' = cacodpos1  
 , 'TipoOper'  = catipoper  
 , 'FechaVcto'  = cafecvcto  
 , 'FechaEfectiva'  = cafecEfectiva  
 , 'MonedaPrincipal' = cacodmon1  
 , 'MonedaSecundaria' = cacodmon2  
 , 'MontoPrincipal' = camtomon1  
 , 'MontoSecundario' = caMtoMon2 -- Desarrollo Colateral
 , 'TipoOperCnv'  = CASE WHEN catipoper = 'C' THEN 'V' ELSE 'C' END  
 , 'Plazo'   = DATEDIFF( DAY, @dFechaRevision,cafecEfectiva ) -- OJO CON LAS FECHAS --  
 , 'BaseCalculo'  = 360  
 , 'PrecioFutOpe'  = catipcam  
 , 'PrecioFwdCal'  = 0  
 , 'TasaCurvaPrinc' = 0  
 , 'TasaCurvaSecud' = 0  
 , 'CurvaPrinc'  = ISNULL(C1.CodigoCurva,'')  
 , 'CurvaSecun'  = ISNULL(C2.CodigoCurva,'')  
 , 'TasaFwd'  = 0  
 , 'PuntaSpot'  = 0  
 , 'TasaUSD'  = 0  
 , 'TasaBidMe'  = 0  
 , 'TasaBidMa'  = 0  
 , 'TasaAskMe'  = 0  
 , 'TasaAskMa'  = 0  
 , 'PlazoCalMe'  = 0  
 , 'PlazoCalMa'  = 0  
 , 'DifTasaBid'  = 0  
 , 'DifTasaAsk'  = 0  
 , 'DifPlazo'  = 0  
 , 'InterpBid'  = 0  
 , 'InterpAsk'  = 0  
 , 'ReferenciaDolar' = ''  
 , 'Valor_Futuro'  = 0  
 , 'Valor_Mercado'  = 0  
 , 'Valor_Activo'  = 0  
 , 'Valor_Pasivo'  = 0  
 , 'Valor_Obtenido' = 0  
 , 'DifPre'  = 0  
 , 'ValorRazonableActivo' = 0  
 , 'ValorRazonablePasivo' = 0  
 , 'ResultadoMTM'  = 0  
 /* valorizacion Colateral */
 , 'Marca_Colateral'               = case when isnull(o.cod_colateral,'')='' then 'N' else 'S' end
 , 'Moneda_Colateral'              = case when isnull(o.cod_colateral,'')='USD' then o.cod_colateral else 'CLP' end
 , 'CurvaColPric'                  = C1_Col.CodigoCurva
 , 'CurvaColSec'                   = C2_Col.CodigoCurva 
 , 'TasaCurvaPrincipal_Col'        = CONVERT( FLOAT, 0 )
 , 'TasaCurvaSecundaria_Col'       = CONVERT(FLOAT,0)
 , 'wfPrincipalCol'                = COnvert(Float,0)
 , 'wfSecundariaCol'               = Convert(Float,0)
 , 'ValorRazonableActivoCol'        = convert( float,0)
 , 'ValorRazonablePasivoCol'        = convert( float,0)
 , 'MTM_Col'                        = convert( float,0 )
 , 'VMC_Principal'                  = convert( float, ISNULL(VMC.Tipo_Cambio, 1.0 ) )
 /* Valorizacion Colateral */
   FROM MFCA   
	LEFT JOIN BacParamSuda..OPE_COLATERAL o ON o.id_sistema='FWD' and o.rut_cliente=cacodigo and o.cod_cliente=cacodcli and o.numero_operacion=canumoper
	LEFT JOIN #tmpCurvasForward C1 ON  c1.Producto = 2 AND c1.moneda = cacodmon1  and C1.CurvaLocal = 'S' 
  
	LEFT JOIN #tmpCurvasForward C2 ON  c2.Producto = 2 AND c2.moneda = cacodmon2  and C2.CurvaLocal = 'S' 

	 /* Curvas Colateral */
	LEFT JOIN #tmpCurvasForward C1_Col ON  C1_Col.Producto = 2 AND C1_Col.moneda = cacodmon1  and C1_Col.CurvaLocal = 'N' 

	LEFT JOIN #tmpCurvasForward C2_Col ON  C2_Col.Producto = 2 AND C2_Col.moneda = cacodmon2  and C2_Col.CurvaLocal = 'N'

	LEFT JOIN BacParamSuda..VALOR_MONEDA_CONTABLE VMC On VMC.Codigo_Moneda = CaCodmon1 and VMC.Fecha = @dFechaRevision
 WHERE cacodpos1 = 2   
  
 DECLARE @iFound      INT  
 SET @iFound      = -1  
  
 SELECT @iFound      = 0  
 FROM BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)  
 WHERE Fecha        = @dFechaRevision --CASE WHEN @Indice = 1 THEN @dFechaAnterior ELSE @dFechaProceso END /************************ ARREGLAR ESTO ***************************/  
 AND Tipo_Cambio <> 0  
  
 IF @iFound = -1 BEGIN  
  RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA. ! ',16,6,'ERROR.')  
  RETURN  
 END  
  
 SET @Valor_Dolar = 1.0  
 SELECT @Valor_Dolar = ISNULL(Tipo_Cambio, 1.0)  
 FROM BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)  
 WHERE Codigo_Moneda = 994  
 AND Fecha = @dFechaRevision --CASE WHEN @Indice = 1 THEN @dFechaAnterior ELSE @dFechaProceso END /************************ ARREGLAR ESTO ***************************/  
  
 --******************************************************************************************************************************--  
 --******************************************************************************************************************************--  
 --******************************************************************************************************************************--  
  
     --> Creo Tabla temporal con informacion   
 SELECT DISTINCT   
  A.CodigoCurva           AS cCurva  
 , cacodmon1             AS cMoneda   
 , CONVERT(FLOAT,0 )            AS vTasa  
 , CONVERT(FLOAT,0 )            AS vTasaMenor  
 , CONVERT(FLOAT,0 )            AS vTasaMayor  
 , CONVERT(INT,0 )           AS iPlazoMenor  
 , CONVERT(INT,0 )           AS iPlazoMayor  
 , DATEDIFF(DAY,@dFechaRevision,cafecEfectiva) AS iPlazo  
 , 'N'        AS sDirection  
 INTO #tmpCurvas2  
 FROM BACFWDSUDA.DBO.MFCA 
 INNER JOIN  BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK) ON modulo  = 'BFW'  AND producto = cacodpos1   AND moneda  = cacodmon1  
 WHERE cacodpos1 = 2  
  
 UNION   
  
 SELECT A.CodigoCurva  
 , cacodmon2  
 , 0  
 , 0  
 , 0  
 , 0  
 , 0  
 , DATEDIFF(DAY, @dFechaRevision, cafecEfectiva) , 'N'  
 FROM BACFWDSUDA.DBO.MFCA 
 INNER JOIN BACPARAMSUDA.DBO.CURVAS_PRODUCTO A WITH(NOLOCK) ON modulo  = 'BFW' AND producto = cacodpos1 AND moneda  = cacodmon2  
 WHERE cacodpos1 = 2  
  
 CREATE NONCLUSTERED INDEX TMPCURVAS2_001 ON #TMPCURVAS2   
 ( cCurva  
 , iPlazo  
 )  
  
    --> Actualizo Datos   
 UPDATE #tmpCurvas2   
 SET vTasa  = ISNULL(valorbid,0)  
 , vTasaMenor = ISNULL(valorbid,0)  
 , vTasaMayor = ISNULL(valorbid,0)  
 , iPlazoMenor = iPlazo  
 , iPlazoMayor = iPlazo  
 FROM #tmpCurvas2 
 LEFT JOIN BACPARAMSUDA.DBO.CURVAS B with(nolock) ON B.FechaGeneracion  = @dFechaRevision AND B.CodigoCurva = cCurva AND dias = iplazo  
  
 UPDATE  #tmpCurvas2   
	SET iPlazoMenor = ISNULL((SELECT MAX(dias)    
 FROM BACPARAMSUDA.DBO.CURVAS  B WITH(NOLOCK)  
 WHERE B.FechaGeneracion = @dFechaRevision  
 AND CodigoCurva  = cCurva  
 AND dias   < iplazo),0), iPlazoMayor = ISNULL((SELECT MIN(dias)   
     FROM BACPARAMSUDA.DBO.CURVAS  B WITH(NOLOCK)  
     WHERE B.FechaGeneracion = @dFechaRevision  
     AND CodigoCurva  = cCurva  
     AND dias   > iplazo),0)  
 FROM #tmpCurvas2   
 WHERE vTasa = 0  
  
 UPDATE #tmpCurvas2   
 SET iPlazoMenor = #tmpCurvas2.iPlazoMayor  
 , iPlazoMayor = (SELECT MIN(dias)   
    FROM BACPARAMSUDA.DBO.CURVAS  B WITH(NOLOCK)  
    WHERE B.FechaGeneracion = @dFechaRevision   
    AND CodigoCurva  = cCurva  
    AND Dias   > #tmpCurvas2.iPlazoMayor)  
 , sDirection = 'I'  
 FROM #tmpCurvas2   
 WHERE vTasa  = 0  
 AND iPlazoMenor = 0  
  
 UPDATE #tmpCurvas2   
 SET iPlazoMayor = #tmpCurvas2.iPlazoMenor  
 , iPlazoMenor = (SELECT MAX(dias)   
    FROM BACPARAMSUDA.DBO.CURVAS  B WITH(NOLOCK)  
    WHERE B.FechaGeneracion = @dFechaRevision  
    AND CodigoCurva  = cCurva  
    AND Dias  < #tmpCurvas2.iPlazoMenor)  
 ,       sDirection = 'S'  
 FROM #tmpCurvas2   
 WHERE vTasa  = 0  
 AND iPlazoMayor = 0   
   
 UPDATE #tmpCurvas2   
 SET vTasaMayor = ISNULL(x.valorbid,0)  
 , vTasaMenor = ISNULL(b.valorbid,0)  
 , sDirection = 'N'  
 FROM #tmpCurvas2 
 INNER JOIN BACPARAMSUDA.DBO.CURVAS  B WITH(NOLOCK)  
     ON b.fechageneracion  = @dFechaRevision  
     AND b.codigocurva      = cCurva  
     AND dias=iplazomenor  
    INNER JOIN BACPARAMSUDA.DBO.CURVAS  x WITH(NOLOCK)  
     ON x.fechageneracion  = @dFechaRevision  
     AND x.codigocurva      = cCurva  
     AND x.dias=iplazomayor  
 WHERE vTasa = 0   
    
 UPDATE #tmpCurvas2   
 SET vTasa = vTasaMenor + CASE WHEN sDirection ='N' THEN ((iPlazo-iplazoMenor) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) )   
      WHEN sDirection ='I' THEN ((iPlazoMenor-iPlazo) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) * - 1   
      WHEN sDirection ='S' THEN ((iPlazo-iPlazoMayor) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) )   
           END  
      WHERE vTasa = 0  
  
 --******************************************************************************************************************************--  
 --******************************************************************************************************************************--  
 --******************************************************************************************************************************--  
  
 UPDATE #ARBI_TMP  
 SET TasaCurvaPrinc = (vTasa / 100.0)  
 FROM #tmpCurvas2  
 WHERE CurvaSecun  = cCurva  
 AND Plazo   = iPlazo  
    
 UPDATE #ARBI_TMP  
 SET TasaCurvaSecun = (vTasa / 100.0)  
 FROM #tmpCurvas2  
 WHERE CurvaPrinc  = cCurva  
 AND Plazo   = iPlazo  

 -- Colateral
 UPDATE #ARBI_TMP  
 SET TasaCurvaPrincipal_Col = (vTasa / 100.0)  
 FROM #tmpCurvas2  
 WHERE CurvaColPric  = cCurva  
 AND Plazo   = iPlazo 

 UPDATE #ARBI_TMP  
 SET TasaCurvaSecundaria_Col = (vTasa / 100.0)  
 FROM #tmpCurvas2  
 WHERE CurvaColSec  = cCurva  
 AND Plazo   = iPlazo 
 -- Colateral


  
 UPDATE #ARBI_TMP  
 SET TasaBidMe = (SELECT TOP 1 ISNULL(bidcal,0)   FROM VIEW_MFBIDASK WHERE fecha = @dFechaRevision AND moneda = MonedaPrincipal AND plazocal <= Plazo ORDER BY plazocal DESC) -- ISNULL(bidcal,0)  
 , TasaAskMe = (SELECT TOP 1 ISNULL(askcal,0)   FROM VIEW_MFBIDASK WHERE fecha = @dFechaRevision AND moneda = MonedaPrincipal AND plazocal <= Plazo ORDER BY plazocal DESC) -- ISNULL(askcal,0)  
 , PlazoCalMe = (SELECT TOP 1 ISNULL(plazocal,0) FROM VIEW_MFBIDASK WHERE fecha = @dFechaRevision AND moneda = MonedaPrincipal AND plazocal <= Plazo ORDER BY plazocal DESC) -- ISNULL(plazocal,0)  
  
 UPDATE #ARBI_TMP  
 SET TasaBidMa = (SELECT TOP 1 ISNULL(bidcal,0)   FROM VIEW_MFBIDASK WHERE fecha = @dFechaRevision AND moneda = MonedaPrincipal AND plazocal > Plazo ORDER BY plazocal ASC) -- ISNULL(bidcal,0)  
 , TasaAskMa = (SELECT TOP 1 ISNULL(askcal,0)   FROM VIEW_MFBIDASK WHERE fecha = @dFechaRevision AND moneda = MonedaPrincipal AND plazocal > Plazo ORDER BY plazocal ASC) -- ISNULL(askcal,0)  
 , PlazoCalMa = (SELECT TOP 1 ISNULL(plazocal,0) FROM VIEW_MFBIDASK WHERE fecha = @dFechaRevision AND moneda = MonedaPrincipal AND plazocal > Plazo ORDER BY plazocal ASC) -- ISNULL(plazocal,0)  
  
 ---------------------------------------  
  
 UPDATE #ARBI_TMP  
 SET TasaBidMe = 0  
 WHERE TasaBidMe IS NULL  
  
 UPDATE #ARBI_TMP  
 SET TasaAskMe = 0  
 WHERE TasaAskMe IS NULL  
  
 UPDATE #ARBI_TMP  
 SET PlazoCalMe = 0  
 WHERE PlazoCalMe IS NULL  
  
 ---------------------------------------   
   
 UPDATE #ARBI_TMP  
 SET TasaBidMa = TasaBidMe  
 WHERE TasaBidMa IS NULL  
  
 UPDATE #ARBI_TMP  
 SET TasaAskMa = TasaAskMe  
 WHERE TasaAskMa IS NULL  
  
 UPDATE #ARBI_TMP  
 SET PlazoCalMa = PlazoCalMe  
 WHERE PlazoCalMa IS NULL  
   
 ---------------------------------------  
  
 UPDATE #ARBI_TMP  
 SET DifTasaBid = TasaBidMa  - TasaBidMe  
        , DifTasaAsk = TasaAskMa  - TasaAskMe  
        , DifPlazo = PlazoCalMa - PlazoCalMe  
 WHERE Plazo > PlazoCalMe  
  
 UPDATE #ARBI_TMP  
 SET InterpBid = DifTasaBid / DifPlazo  
 , InterpAsk = DifTasaAsk / DifPlazo  
 WHERE Plazo  > PlazoCalMe  
 AND DifPlazo <> 0  
  
 UPDATE #ARBI_TMP  
 SET TasaUSD  = ROUND(((TasaAskMe + InterpAsk * ( Plazo - PlazoCalMe ) ) + ( TasaBidMe + InterpBid * ( Plazo - PlazoCalMe))) / 2 ,6)  
 , Valor_Obtenido = ((TasaAskMe + InterpAsk * ( Plazo - PlazoCalMe ) ) + ( TasaBidMe + InterpBid * ( Plazo - PlazoCalMe))) / 2   
 WHERE Plazo > PlazoCalMe  
  
 UPDATE #ARBI_TMP  
 SET TasaUSD  = ROUND(( TasaBidMe + TasaAskMe ) / 2 ,6)  
 , Valor_Obtenido = ( TasaBidMe + TasaAskMe ) / 2  
 WHERE Plazo <= PlazoCalMe  
  
 UPDATE #ARBI_TMP  
 SET PuntaSpot = vmptacmp  
 , TasaFwd  = vmptacmp  
 FROM VIEW_VALOR_MONEDA   
 WHERE vmcodigo = MonedaPrincipal  
 AND vmfecha        = @dFechaRevision  
  
 ------------------------------------------  
  
 UPDATE #ARBI_TMP  
 SET PrecioFwdCal     = TasaUSD + TasaFWD  --PrecioForward  
  
 UPDATE #ARBI_TMP  
 SET ReferenciaDolar = mnrrda  
 FROM BacParamSuda..MONEDA with (nolock)  
 WHERE mncodmon = MonedaPrincipal  
  
 UPDATE #ARBI_TMP  
 SET ReferenciaDolar = 'D'  
 WHERE ReferenciaDolar IS NULL  
 OR ReferenciaDolar = ''  
  
 UPDATE #ARBI_TMP  
 SET Valor_Futuro = ROUND(MontoPrincipal / PrecioFwdCal,2)  
 , Valor_Mercado = ROUND(MontoPrincipal / PrecioFutOpe   ,2)  
 WHERE ReferenciaDolar = 'D'  
  
 UPDATE #ARBI_TMP  
 SET Valor_Futuro = ROUND(MontoPrincipal * PrecioFwdCal,2)  
 , Valor_Mercado = ROUND(MontoPrincipal * PrecioFutOpe   ,2)  
 WHERE ReferenciaDolar <> 'D'  
   
 UPDATE #ARBI_TMP  
 SET Valor_Activo = ROUND(Valor_Futuro  * @Valor_Dolar,0)  
 , Valor_Pasivo = ROUND(Valor_Mercado * @Valor_Dolar,0)  
 WHERE TipoOper = 'C'  
  
 UPDATE #ARBI_TMP  
 SET Valor_Mercado = ROUND(Valor_Activo  - Valor_Pasivo,0)  
 WHERE TipoOper = 'C'  
  
 UPDATE #ARBI_TMP  
 SET Valor_Activo = ROUND(Valor_Mercado * @Valor_Dolar,0)  
 , Valor_Pasivo = ROUND(Valor_Futuro  * @Valor_Dolar,0)  
 WHERE TipoOper = 'V'  
  
 UPDATE #ARBI_TMP  
 SET Valor_Mercado = ROUND(Valor_Activo  - Valor_Pasivo,0)  
  
 -------------------------------------------------------------------------------------------------------------------------  
 -------------------------------------------------------------------------------------------------------------------------  
 --------------------------------------------- P A R I D A D - F O R W A R D ---------------------------------------------  
 -------------------------------------------------------------------------------------------------------------------------  
 -------------------------------------------------------------------------------------------------------------------------  
  
 CREATE TABLE #TMPEXTRA  
 ( nMoneda   INT  
 , cFound   CHAR(1)  
 , iMinParidadBid  FLOAT  
 , iMinParidadAsk  FLOAT  
 , iMaxParidadBid  FLOAT  
 , iMaxParidadAsk  FLOAT  
 , iMinDias  INT  
 , iMaxDias  INT  
 , iPlazo   INT  
 , nFactor   FLOAT   
 , nDifDias  INT  
 , nRateBid  FLOAT  
 , nRateAsk  FLOAT  
 , iPrecioPuntaCompra FLOAT  
 , iPrecioPuntaVenta FLOAT  
 , nParidadForwardBid FLOAT  
 , nParidadForwardAsk FLOAT  
 )  
  
 INSERT #TMPEXTRA  
 SELECT DISTINCT  
  cacodmon1   
 , 'N'  
 , 0  
 , 0  
 , 0  
 , 0  
 , 0  
 , 0  
 , DATEDIFF( DAY, @dFechaRevision ,cafecEfectiva )  
 , 0  
 , 0  
 , 0  
 , 0  
 , ISNULL(vmptavta,0)  
 , ISNULL(vmptacmp,0)  
 , 0   
 , 0  
 FROM MFCA LEFT JOIN BacParamSuda..VALOR_MONEDA   
    ON vmcodigo      = cacodmon1  
    AND vmfecha       = @dFechaRevision  
 WHERE cacodpos1 = 2  
   
 SELECT 'ParidadBid' = Bid  
 , 'ParidadAsk' = Ask  
 , 'Intervalo' = penumero  
 , 'Conversion' = petipo  
 , 'Periodo' = CASE WHEN petipo = 'D' THEN (penumero * 1.00)  
     WHEN petipo = 'M' THEN (penumero * 30.00)  
     WHEN petipo = 'Y' THEN (penumero * 365.00) END  
 , 'Factor' = factor   
 , 'Moneda' = moneda  
 INTO #Paridades_BidAsk  
 FROM MFBIDASK     LEFT JOIN BacParamSuda..PERIODO_TASA_BIDASK ON periodo = pecodigo  
 WHERE moneda       IN ((SELECT DISTINCT cacodmon1 from MFCA WHERE cacodpos1 = 2))  
 AND fecha        = @dFechaRevision  
 ORDER   
 BY moneda  
 , periodo  
  
 UPDATE #TMPEXTRA  
 SET cFound  = 'S'  
 , iMinParidadBid = ParidadBid  
 , iMinParidadAsk = ParidadAsk  
 , iMaxParidadBid = ParidadBid  
 , iMaxParidadAsk = ParidadAsk  
 , nRateBid = paridadBid  
 , nRateAsk = paridadAsk  
 , nFactor  = Factor  
 FROM #Paridades_BidAsk  
 WHERE Periodo = iPlazo  
 AND moneda = nMoneda  
  
 UPDATE #TMPEXTRA  
 SET iMinDias = ISNULL( (SELECT MAX(Periodo)  
      FROM #Paridades_BidAsk  
      WHERE moneda  = nMoneda  
      AND Periodo <= iPlazo) ,0)  
 , iMaxDias = ISNULL( (SELECT MIN(Periodo)  
      FROM #Paridades_BidAsk  
      WHERE moneda  = nMoneda  
      AND Periodo >= iPlazo) ,0)  
 WHERE cFound = 'N'  
  
 UPDATE #TMPEXTRA  
 SET cFound  = 'X'  
 , iMaxDias = ISNULL( (SELECT MAX(Periodo) FROM #Paridades_BidAsk WHERE Moneda = nMoneda) ,0)     
 , nFactor  = ISNULL( (SELECT MAX(Factor ) FROM #Paridades_BidAsk WHERE Moneda = nMoneda) ,0)  
 WHERE cFound  = 'N'  
 AND iMaxDias = 0  
  
 UPDATE #TMPEXTRA  
 SET cFound  = 'X'  
 , iMinDias = ISNULL( (SELECT MAX(Periodo) FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo < iMaxDias) ,0)  
 WHERE cFound  = 'X'  
  
 UPDATE #TMPEXTRA  
 SET cFound  = 'A'  
-- , iMaxDias = ISNULL( (SELECT MAX(Periodo) FROM #Paridades_BidAsk WHERE Moneda = nMoneda) ,0)     
-- , iMinDias = ISNULL( (SELECT MAX(Periodo) FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo < iMaxDias) ,0)  
 , iMinParidadBid = ISNULL( (SELECT paridadBid   FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMinDias) ,0)  
 , iMinParidadAsk = ISNULL( (SELECT paridadAsk   FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMinDias) ,0)  
 , iMaxParidadBid = ISNULL( (SELECT paridadBid   FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMaxDias) ,0)  
 , iMaxParidadAsk = ISNULL( (SELECT paridadAsk   FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMaxDias) ,0)  
-- , nFactor  = ISNULL( (SELECT MAX(Factor ) FROM #Paridades_BidAsk WHERE Moneda = nMoneda) ,0)  
 WHERE cFound  = 'X'  
-- AND iMaxDias = 0  
  
   
 UPDATE #TMPEXTRA  
 SET cFound  = 'Y'  
 , iMinDias = ISNULL( (SELECT MIN(Periodo) FROM #Paridades_BidAsk WHERE Moneda = nMoneda ) ,0)  
 , nFactor  = ISNULL( (SELECT MIN(Factor ) FROM #Paridades_BidAsk WHERE Moneda = nMoneda) ,0)  
 WHERE cFound  = 'N'  
 AND iMinDias = 0  
  
 UPDATE #TMPEXTRA  
 SET cFound  = 'Y'  
 , iMaxDias = ISNULL( (SELECT MIN(Periodo) FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo > iMinDias), 0 )  
 WHERE cFound  = 'Y'  
  
  
 UPDATE #TMPEXTRA  
 SET cFound  = 'A'  
-- , iMinDias = ISNULL( (SELECT MIN(Periodo) FROM #Paridades_BidAsk WHERE Moneda = nMoneda ) ,0)  
-- , iMaxDias = ISNULL( (SELECT MIN(Periodo) FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo > iMinDias), 0 )  
 , iMinParidadBid = ISNULL( (SELECT paridadBid   FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMinDias) ,0)  
 , iMinParidadAsk = ISNULL( (SELECT paridadAsk   FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMinDias) ,0)  
 , iMaxParidadBid = ISNULL( (SELECT paridadBid   FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMaxDias) ,0)  
 , iMaxParidadAsk = ISNULL( (SELECT paridadAsk   FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMaxDias) ,0)  
-- , nFactor  = ISNULL( (SELECT MIN(Factor ) FROM #Paridades_BidAsk WHERE Moneda = nMoneda) ,0)  
 WHERE cFound  = 'Y'  
-- AND iMinDias = 0  
  
 UPDATE #TMPEXTRA  
 SET cFound  = 'A'  
 , iMinParidadBid = ISNULL( (SELECT paridadBid FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMinDias) ,0)  
 , iMinParidadAsk = ISNULL( (SELECT paridadAsk FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMinDias) ,0)  
 , iMaxParidadBid = ISNULL( (SELECT paridadBid FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMaxDias) ,0)  
 , iMaxParidadAsk = ISNULL( (SELECT paridadAsk FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMaxDias) ,0)  
 , nFactor  = ISNULL( (SELECT Factor     FROM #Paridades_BidAsk WHERE Moneda = nMoneda AND Periodo = iMaxDias) ,0)  
 WHERE cFound  = 'N'  
 AND iMinDias <> 0  
 AND iMaxDias <> 0  
  
   
 UPDATE #TMPEXTRA  
 SET nDifDias = iMaxDias - iMinDias  
 WHERE cFound = 'A'  
  
 UPDATE #TMPEXTRA  
 SET nRateBid = ( iMaxParidadBid - iMinParidadBid ) / nDifDias  
 , nRateAsk = ( iMaxParidadAsk - iMinParidadAsk ) / nDifDias  
 WHERE cFound  = 'A'  
 AND nDifDias <> 0  
  
 UPDATE #TMPEXTRA  
 SET nRateBid =  iMinParidadBid + ( nRateBid * ( iplazo - iMinDias))  
 , nRateAsk =  iMinParidadAsk + ( nRateAsk * ( iplazo - iMinDias))  
 WHERE cFound = 'A'  
 AND (iPlazo >= iMinDias  
 AND iPlazo <= iMaxDias)  
  
 UPDATE #TMPEXTRA  
 SET nRateBid =  iMinParidadBid - ( nRateBid * ( iMinDias - iPlazo))  
 , nRateAsk =  iMinParidadAsk - ( nRateAsk * ( iMinDias - iPlazo))  
 WHERE cFound = 'A'  
 AND iPlazo < iMinDias  
  
 UPDATE #TMPEXTRA  
 SET nRateBid =  iMaxParidadBid + ( nRateBid * ( iPlazo - iMaxDias))  
 , nRateAsk =  iMaxParidadAsk + ( nRateAsk * ( iPlazo - iMaxDias))  
 WHERE cFound = 'A'  
 AND iPlazo > iMaxDias  
  
 UPDATE #TMPEXTRA  
 SET iMinParidadBid = paridadBid  
 , iMinParidadAsk = paridadAsk  
 , iMaxParidadBid = paridadBid  
 , iMaxParidadAsk = paridadAsk  
 , nRateBid = paridadBid  
 , nRateAsk = paridadAsk  
 , nFactor  = Factor  
 FROM #Paridades_BidAsk  
 WHERE Periodo  = iMinDias  
 AND cFound  = 'S'  
  
 UPDATE #TMPEXTRA  
 SET nParidadForwardBid = CASE WHEN nFactor > 0   
      THEN iPrecioPuntaVenta + ( nRateBid * 1.0 ) / ( nFactor * 1.0 )  
       ELSE iPrecioPuntaVenta + ( nRateBid * 1.0 ) / 1.0 END  
 , nParidadForwardAsk = CASE WHEN nFactor > 0   
      THEN iPrecioPuntaCompra + ( nRateAsk * 1.0 ) / ( nFactor * 1.0 )  
       ELSE iPrecioPuntaCompra + ( nRateAsk * 1.0 ) / 1.0 END  
  
 UPDATE #ARBI_TMP  
 SET Valor_Obtenido = CASE TipoOper WHEN 'C' THEN nParidadForwardAsk   
      WHEN 'V' THEN nParidadForwardBid   
        ELSE 0. END  
 FROM #TMPEXTRA WHERE MonedaPrincipal = nMoneda  
 AND Plazo  = iPlazo  
  
 -------------------------------------------------------------------------------------------------------------------------  
 -------------------------------------------------------------------------------------------------------------------------  
 -------------------------------------------------------------------------------------------------------------------------  
 -------------------------------------------------------------------------------------------------------------------------  
  
 -------------------  
 -- C O M P R A S --  
 -------------------  
 UPDATE #ARBI_TMP  
 SET DifPre               = (1.0 / (Valor_Obtenido * 1.0) - 1.0 / (PrecioFutOpe * 1.0))  
 , ValorRazonableActivo = (1.0 /  Valor_Obtenido * 1.0) * MontoPrincipal / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
 , ValorRazonablePasivo = (1.0 /  PrecioFutOpe   * 1.0) * MontoPrincipal / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
 , ValorRazonableActivoCol = MontoPrincipal / ( 1.0 + TasaCurvaPrincipal_Col * Plazo / BaseCalculo ) * VMC_Principal
 , ValorRazonablePasivoCol = MontoSecundario / (1.0 + TasaCurvaSecundaria_Col * Plazo / BaseCalculo ) * @Valor_Dolar
                             -- * ValorMdaContable de M1.
 WHERE TipoOper  = 'C'  
 AND ReferenciaDolar  = 'D'  
  
 UPDATE #ARBI_TMP  
 SET DifPre   =  Valor_Obtenido - PrecioFutOpe  
 , ValorRazonableActivo =  Valor_Obtenido * MontoPrincipal / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
 , ValorRazonablePasivo =  PrecioFutOpe   * MontoPrincipal / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
 , ValorRazonableActivoCol = MontoPrincipal / ( 1.0 + TasaCurvaPrincipal_Col * Plazo / BaseCalculo ) * VMC_Principal
 , ValorRazonablePasivoCol = MontoSecundario / (1.0 + TasaCurvaSecundaria_Col * Plazo / BaseCalculo ) * @Valor_Dolar
 WHERE TipoOper  =  'C'  
 AND ReferenciaDolar  <> 'D'  
   
 UPDATE #ARBI_TMP  
 SET ResultadoMTM = MontoPrincipal * DifPre / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar 
  ,  MTM_Col      = ValorRazonableActivoCol - ValorRazonablePasivoCol
  
 WHERE TipoOper  =  'C'   
  
 -------------------------------------------------------------------------------------------------------------------------  
 -------------------------------------------------------------------------------------------------------------------------  
  
 -----------------  
 -- V E N T A S --  
 -----------------  
 UPDATE #ARBI_TMP  
 SET DifPre   = (1.0 / (PrecioFutOpe   * 1.0) - 1.0 / (Valor_Obtenido * 1.0))  
 , ValorRazonableActivo = (1.0 /  PrecioFutOpe   * 1.0) *  MontoPrincipal / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
 , ValorRazonablePasivo = (1.0 /  Valor_Obtenido * 1.0) *  MontoPrincipal / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
 , ValorRazonablePasivoCol = MontoPrincipal / ( 1.0 + TasaCurvaPrincipal_Col * Plazo / BaseCalculo ) * VMC_Principal
 , ValorRazonableActivoCol = MontoSecundario / (1.0 + TasaCurvaSecundaria_Col * Plazo / BaseCalculo ) * @Valor_Dolar

 WHERE TipoOper  = 'V'  
 AND ReferenciaDolar  = 'D'  
  
 UPDATE #ARBI_TMP  
 SET DifPre   =  PrecioFutOpe   - Valor_Obtenido  
 , ValorRazonableActivo =  PrecioFutOpe   * MontoPrincipal / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
 , ValorRazonablePasivo =  Valor_Obtenido * MontoPrincipal / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
 , ValorRazonablePasivoCol = MontoPrincipal / ( 1.0 + TasaCurvaPrincipal_Col * Plazo / BaseCalculo ) * VMC_Principal
 , ValorRazonableActivoCol = MontoSecundario / (1.0 + TasaCurvaSecundaria_Col * Plazo / BaseCalculo ) * @Valor_Dolar

 WHERE TipoOper  =  'V'  
 AND ReferenciaDolar  <> 'D'  
  
 UPDATE #ARBI_TMP  
 SET ResultadoMTM = MontoPrincipal * DifPre / (1.0 + TasaCurvaPrinc * Plazo / BaseCalculo) * @Valor_Dolar  
   ,  MTM_Col      = ValorRazonableActivoCol - ValorRazonablePasivoCol
 WHERE TipoOper  =  'V'   
  
 --  
 UPDATE MFCA      
 SET fVal_Obtenido    = TMP.Valor_Obtenido  
 , fRes_Obtenido   = Case when TMP.Moneda_Colateral = 'USD' then TMP.MTM_Col else  TMP.ResultadoMTM end  
 , CaTasaSinteticaM1                  = TMP.TasaCurvaPrincipal_Col  * 100.0 
 , CaTasaSinteticaM2                  = TMP.TasaCurvaSecundaria_Col * 100.0 
-- , CaPrecioSpotVentaM1                = @CaPrecioSpotVentaM1   
-- , CaPrecioSpotVentaM2                = @CaPrecioSpotVentaM2   
-- , CaPrecioSpotCompraM1               = @CaPrecioSpotCompraM1  
-- , CaPrecioSpotCompraM2		= @CaPrecioSpotCompraM2
-- , CaFecEfectiva			= @dFecEfectiva		-- SE ACTUALIZA EN EL NUEVO PROCESO DE DEVENGAMIENTO
,	ValorRazonableActivo            = Case when TMP.Moneda_Colateral = 'USD' then TMP.ValorRazonableActivoCol else TMP.ValorRazonableActivo end
,	ValorRazonablePasivo            = Case when TMP.Moneda_Colateral = 'USD' then TMP.ValorRazonablePasivoCol else TMP.ValorRazonablePasivo end 
, catasadolar                          = (TMP.TasaCurvaPrinc * 100.0) -- @nTasa1  
 , catasaufclp                          = (TMP.TasaCurvaSecun * 100.0) -- @nTasa2  
 , caOrgCurvaMon                        = 'MC'  
 , caOrgCurvaCnv                        = 'MC'  
 FROM #ARBI_TMP TMP  
 WHERE canumoper                = NumOperacion  
  
/*  
 SELECT NumOperacion  
 , 'MTM' = CONVERT(NUMERIC(21,2), ROUND(ResultadoMTM,2))  
 , Plazo  
 , PrecioFutOpe                                            
 , 'PrecioFwdCal'  = CONVERT(NUMERIC(19,2),ROUND(PrecioFwdCal,2))  
 , 'TasaCurvaPrinc' = CONVERT(NUMERIC(19,4),ROUND(TasaCurvaPrinc*100.,4))  
 , 'TasaCurvaSecun' = CONVERT(NUMERIC(19,4),ROUND(TasaCurvaSecun*100.,4))  
 , TasaFwd  
 , *   
 FROM #ARBI_TMP    
-- WHERE NumOperacion = 29014  
 ORDER   
 BY NumOperacion   
*/  
 SET NOCOUNT OFF  
  
END  
GO
