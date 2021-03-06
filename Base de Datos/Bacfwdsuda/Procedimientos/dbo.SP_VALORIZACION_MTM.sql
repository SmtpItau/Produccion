USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZACION_MTM]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_VALORIZACION_MTM]
   (   @nnumoper        NUMERIC(10)   
   ,   @Tasa_Forward    NUMERIC(21,4) = 0  
   )   
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @dfechaAnterior   DATETIME  
       SET @dfechaAnterior   = (SELECT acfecante FROM BacFwdSuda.dbo.MFAC with(nolock) )  
  
   DECLARE @dFechaproceso    DATETIME  
       SET @dFechaproceso    = (SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock) )  
  
   DECLARE @dFechaProxima    DATETIME  
       SET @dFechaProxima    = (SELECT acfecprox FROM BacFwdSuda.dbo.MFAC with(nolock) )  
  
   DECLARE @dFechaCalculo    DATETIME  
       SET @dFechaCalculo    = CASE WHEN DATEPART(MONTH, @dFechaproceso) = DATEPART(MONTH, @dFechaProxima) THEN @dFechaproceso  
        ELSE DATEADD(DAY, (DAY(DATEADD(MONTH, 1, @dFechaproceso)) * -1), DATEADD(MONTH, 1, @dFechaproceso))  
          END  
  
   DECLARE @FechaDatosCartera DATETIME  
 --> Si es '1' esta generado el Devengamiento    Fecha de Calculo sera la de Proceso  
 --> Si es '0' no esta generado el devengamiento Fecha de Calculo sera la de Proceso Anterior  
 SET @FechaDatosCartera  = (SELECT CASE WHEN acofimesa = 0 THEN @dfechaAnterior ELSE @dFechaProxima END FROM BacFwdSuda.dbo.MFAC)  
  
   DECLARE @nCodMda1   INT  
   DECLARE @nCodMda2   INT  
   DECLARE @nPlazo    INT  
   DECLARE @nMtoMda1  FLOAT  
   DECLARE @FwdContrato  FLOAT  
   DECLARE @cCodPro  INT  
   DECLARE @BASE  FLOAT  
   DECLARE @nValorUF   FLOAT  
  
 SET @BASE = 360  
  
   DECLARE @cTipOper CHAR(1)  
       SET @cTipOper = ISNULL((SELECT catipoper FROM MFCA WHERE canumoper = @nnumoper),'C')  
  
   DECLARE @cTipOperCnv CHAR(1)  
       SET @cTipOperCnv = CASE WHEN @cTipOper = 'C' THEN 'V' ELSE 'C' END  
  
   SELECT  @nMtoMda1  = camtomon1  
      ,    @FwdContrato = catipcam   
      ,    @nCodMda1  = cacodmon1  
      ,    @nCodMda2  = cacodmon2  
      ,    @cCodPro   = cacodpos1  
      ,    @nPlazo  = DATEDIFF(DAY, @dFechaproceso, cafecEfectiva)  
   FROM    MFCA  
   WHERE   canumoper    = @nnumoper  
  
   CREATE TABLE #TasaMoneda     
   (   Tasa        FLOAT NOT NULL DEFAULT(0.0)  
   ,   Spread      FLOAT NOT NULL DEFAULT(0.0)  
   ,   SpotCompra  FLOAT NOT NULL DEFAULT(0.0)  
   ,   SpotVenta   FLOAT NOT NULL DEFAULT(0.0)  
   )  
  
   CREATE TABLE #VALORUF ( VALUF FLOAT )  
  
   -->Obtengo Curvas Moneda Origen y Convenida  
   DECLARE @nCurvaMda1    FLOAT  
   DECLARE @nCurvaMda2    FLOAT  
   DECLARE @Spread   FLOAT  
   DECLARE @CaPrecioSpotCompraM1  FLOAT  
   DECLARE @CaPrecioSpotVentaM1  FLOAT  
  
   --DECLARE @CaPrecioSpotCompraM2  FLOAT  
   --DECLARE @CaPrecioSpotVentaM2  FLOAT  
  
       SET @Spread            =0.0  
       SET @nCurvaMda1 =0.0  
       SET @nCurvaMda2 =0.0  
  
   DELETE FROM #TasaMoneda  
   INSERT INTO #TasaMoneda  EXECUTE SP_RetornaTasaMoneda @nCodMda1, @nPlazo , 'BFW' , @cCodPro , -1, -1, 0, @cTipOper  
  
   SELECT @nCurvaMda1   = ISNULL(Tasa,   1.0) / 100.0  
      ,   @Spread       = ISNULL(Spread, 0.0)  
   FROM   #TasaMoneda   
  
   DELETE FROM #TasaMoneda   
   INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda @nCodMda2 , @nPlazo , 'BFW' , @cCodPro , -1, -1, 0, @cTipOperCnv  
  
   SELECT @nCurvaMda2    = ISNULL(Tasa,1.0) / 100.0  
      ,   @Spread                 = ISNULL(Spread,0.0)  
   FROM   #TasaMoneda   
  
   DECLARE @TasaForward    FLOAT  
   DECLARE @nSpot          FLOAT  
  
       SET @TasaForward    = 0.0  
       SET @nSpot          = 0.0  
  
   DECLARE @TipoCurvaOri   VARCHAR(20)  
   EXECUTE SP_RETORNA_NOMBRE_CURVA @cCodPro, @nCodMda1, @TipoCurvaOri  OUTPUT  
  
   DECLARE @TipoCurvaCnv   VARCHAR(20)  
   EXECUTE SP_RETORNA_NOMBRE_CURVA @cCodPro, @nCodMda2, @TipoCurvaCnv  OUTPUT  
  
   IF @cCodPro = 1  -->SEGURO DE CAMBIO   
   BEGIN  
  
      DECLARE @dFecha      DATETIME  
      DECLARE @fDoObs      FLOAT  
     
   IF (EXISTS( SELECT 1 FROM BacParamSuda..VALOR_MONEDA_CONTABLE with(nolock) WHERE Fecha = @dFechaproceso AND Codigo_Moneda = 994 ))  
     SET @dFecha = @dFechaproceso  
   ELSE  
     SET @dFecha = @dfechaAnterior  
  
    IF @nCodMda1 = 13 AND @nCodMda2 = 998  
     BEGIN  
    DELETE FROM #TasaMoneda  
    INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 999 , @nPlazo , 'BFW' , @cCodPro , -1, -1, 0, @cTipOper  
  
    --EXECUTE SP_RETORNA_NOMBRE_CURVA @cCodPro, 999, @TipoCurvaOri  OUTPUT  
  
       SELECT @nSpot    =  vmvalor FROM BACPARAMSUDA..VALOR_MONEDA with(nolock) WHERE vmfecha = @dFechaproceso AND vmcodigo=994  
     SELECT @nValorUF =  vmvalor FROM BACPARAMSUDA..VALOR_MONEDA with(nolock) WHERE vmfecha = @dFechaproceso AND vmcodigo=998  
  
    SET @TasaForward = ISNULL( (@nSpot / @nValorUF) * ( (1.0 +( @nCurvaMda1 / @BASE ) * @nPlazo) / (1.0 + (( @nCurvaMda2 + @Spread) / @BASE ) * @nPlazo)), 0.0)  
   --- select '-->@nSpot,@nValorUF,@nCurvaMda1,@BASE,@nPlazo,@nCurvaMda2,@Spread', @nSpot,@nValorUF,@nCurvaMda1,@BASE,@nPlazo,@nCurvaMda2,@Spread  
     END   
    ELSE  
     BEGIN  
      SELECT @nSpot = CASE WHEN @cTipOper= 'C' THEN SpotCompra ELSE SpotVenta END    
     FROM BacParamSuda..VALOR_MONEDA_CONTABLE with(nolock)   
           WHERE Fecha = @dFecha AND Codigo_Moneda = 994   
    
             SET @TasaForward = ISNULL( @nSpot * ( (1.0 +( @nCurvaMda1 / @BASE ) * @nPlazo) / (1.0 + (( @nCurvaMda2 + @Spread) / @BASE ) * @nPlazo)), 0.0)  
     END       
 END  
  
  
 IF @cCodPro = 2 --> ARBITRAJE FUTURO  
 BEGIN  
  IF (EXISTS( SELECT 1 FROM BacParamSuda..VALOR_MONEDA_CONTABLE with(nolock) WHERE Fecha = @dFechaproceso AND Codigo_Moneda = 994 ))  
     SET @dFecha = @dFechaproceso  
  ELSE  
     SET @dFecha = @dfechaAnterior  
  
  SELECT @nSpot    =   ISNULL(Tipo_Cambio, 1.0) FROM BacParamSuda..VALOR_MONEDA_CONTABLE with(nolock)   
           WHERE Fecha = @dFechaproceso AND Codigo_Moneda = 994  
                IF @nSpot = 0.0  
                   SET @nSpot = ( SELECT tipo_cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)  
                                                    WHERE Fecha = @dfechaAnterior and codigo_moneda = 994)  
                 
  
  EXECUTE SP_RETORNA_NOMBRE_CURVA @cCodPro, 13, @TipoCurvaCnv  OUTPUT  
  
   DELETE FROM #TasaMoneda  
   INSERT INTO #TasaMoneda EXECUTE SP_RetornaTasaMoneda 13 , @nPlazo , 'BFW' , @cCodPro , -1, -1, 0, @cTipOperCnv  
  
   SELECT    @nCurvaMda2    = ISNULL(Tasa,1.0) / 100.0  
   ,        @Spread                = ISNULL(Spread,0.0)  
   FROM   #TasaMoneda   
  
 END  
  
  
 IF @cCodPro = 3 or @cCodPro = 13 -->SEGURO DE INFLACION  
 BEGIN  
  DELETE #VALORUF  
  INSERT INTO #VALORUF EXECUTE SP_RetornaValorMoneda @nCodMda1, @dFechaproceso  
  
  SET @nValorUF=0.0  
  SELECT @nValorUF = VALUF FROM #VALORUF  
  
  DECLARE @nFactor       FLOAT  
   SET @nFactor    = 0.0  
   SET @nFactor = POWER( 1.0 + @nCurvaMda2 ,  @nPlazo / @BASE ) / POWER( 1.0 + @nCurvaMda1 ,  @nPlazo / @BASE ) - 1.0  
  
   SET @TasaForward = @nValorUf * ( 1.0 + @nFactor )  
 END  
  
 DECLARE @ResultadoMTM FLOAT  
  SET @ResultadoMTM=0.0  
  
 If @cCodPro = 10 -->BOND TRADES  
 BEGIN  
  
  DECLARE  @fRes_Obtenido   FLOAT   
  DECLARE  @Tir_Benchmarck  FLOAT  
  
  EXECUTE SP_Valoriza_ForwardBondTrades @nnumoper , 0 ,@Tasa_Forward, @fRes_Obtenido OUTPUT, @Tir_Benchmarck OUTPUT  
  SET @ResultadoMTM = @fRes_Obtenido     
  SET @TasaForward  = @Tir_Benchmarck     
  
 END  
  
 IF @cCodPro = 1 OR @cCodPro = 3  
 BEGIN  
  DECLARE @nSigno INT  
   SET @nSigno = CASE WHEN @cTipOper='C' THEN 1 ELSE -1 END  
  
   SET @ResultadoMTM  = (@nMtoMda1 * (@TasaForward - @FwdContrato ) / (1.0 + @nCurvaMda1 * @nPlazo / 360) ) * @nSigno  
      
 END  
  
  
 SELECT   
 /*--01--*/  MtoMda1    = camtomon1  
 /*--02--*/, CodMda1    = cacodmon1  
 /*--03--*/, CodMda2    = cacodmon2  
 /*--04--*/, NemoMon1   = mon1.mnnemo   
 /*--05--*/, NemoMon2   = mon2.mnnemo   
 /*--06--*/, FecProc    = CONVERT(CHAR(10),cafecha,103)    
 /*--07--*/, TasaContrato  = catipcam         
 /*--08--*/, FechaTermino   = cafecEfectiva   
 /*--09--*/, PagoMn   = ISNULL(pagm1.glosa,'NO APLICA')  
 /*--10--*/, PagoMx   = ISNULL(pagm2.glosa,'NO APLICA')  
 /*--11--*/, MtoMda2  = camtomon2  
 /*--12--*/, TipoOper   = catipoper   
 /*--13--*/, TipoModa  = catipmoda  
 /*--14--*/, CodProd  = cacodpos1  
 /*--15--*/, TasaForward  = @TasaForward  
 /*--16--*/, ValorMtm  = fRes_Obtenido   
 /*--17--*/, fCurvaMda1  = @nCurvaMda1   
 /*--18--*/, fCurvaMda2  = @nCurvaMda2   
 /*--19--*/, nPrecioSpot  = @nSpot  
  /*--20--*/, FecValorizacion  = @dFechaCalculo       
 /*--21--*/, FecDatosCartera  = @FechaDatosCartera    
 /*--22--*/, ValorUF  = @nValorUF       
 /*--23--*/, cafecvcto  = CONVERT(CHAR(10),cafecvcto,103)    
 /*--24--*/, paridadDolUF = (@nSpot / @nValorUF)  
 /*--25--*/, caserie  = caserie  
 /*--26--*/, TipoCurvaOri = @TipoCurvaOri  
 /*--27--*/, TipoCurvaCnv = @TipoCurvaCnv  
 /*--28--*/, cMdaFuerte  = mon1.MNRRDA  
	   , cacodigo
	   , cacodcli
 FROM  MFCA  
  LEFT join view_moneda mon1      ON mon1.mncodmon = cacodmon1  
  LEFT join view_moneda mon2      ON mon2.mncodmon = cacodmon2  
  LEFT join view_forma_de_pago pagm1  ON pagm1.codigo  = cafpagomn  
  LEFT join view_forma_de_pago pagm2  ON pagm2.codigo  = cafpagomx  
 WHERE canumoper  = @nnumoper  
END  
GO
