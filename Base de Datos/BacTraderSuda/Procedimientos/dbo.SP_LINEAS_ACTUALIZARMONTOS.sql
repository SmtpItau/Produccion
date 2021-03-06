USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ACTUALIZARMONTOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_ACTUALIZARMONTOS]    
   (   @dFecPro     DATETIME    
   ,   @idSistema   CHAR(03)    
   )    
AS    
BEGIN

--+++jcamposd 20180730 Se solicita que proceso actualice lineas SOL: Camilo Pino
	--+++jcamposd 20170421 implementación control IDD (no debe controlar lineas BAC)
	--RETURN
	-----jcamposd 20170421 implementación control IDD
----jcamposd 20180730 Se solicita que proceso actualice lineas SOL: Camilo Pino    
    
 SET NOCOUNT ON    
    
 Execute BacLineas.dbo.ProcesoActualizacionLineas 0  
-- EXECUTE BacLineas.dbo.Sp_Recalculo_Lineas_Derivados 0 --> Genera Todos los Clientes.  
        
RETURN  
    
 EXECUTE Lnkopc.CbmdbOpc.dbo.SP_RECALCULO_LINEAS_OPCIONES_OTRO 'OPT'  
 EXECUTE CALCULO_LINEAS_UNIFICADO2 @dFecPro    
     
    
RETURN    
    
 DECLARE @Contador  INTEGER      
 , @sw   CHAR(1)      
 , @cSistema  CHAR (03)        
 , @nNumoper  NUMERIC (10,0)     
 , @nNumdocu  NUMERIC (10,0)     
 , @nCorrela  NUMERIC (10,0)     
 , @ctranssaccion  CHAR(15)           
 , @ctipo_detalle  CHAR(1)            
 , @cactualizo_linea CHAR(1)            
 , @nmontotransaccion NUMERIC(19,4)      
 , @ctipo_movimiento CHAR(1)            
 , @nrutcli  NUMERIC(09,0)      
 , @ncodigo  NUMERIC(09,0)      
 , @nplazodesde  NUMERIC(09,0)      
 , @nplazohasta  NUMERIC(09,0)      
 , @csistematras  CHAR (03)          
 , @nmonto   NUMERIC(19,4)      
 , @dfecvctop  DATETIME           
 , @dfecInip  DATETIME           
 , @ccontrolaplazo  CHAR(01)           
 , @nRutcasamatriz  NUMERIC (09,0)     
 , @nCodigocasamatriz NUMERIC (09,0)     
 , @dfecproc  DATETIME    
    
 DECLARE @nRegs   INTEGER    
 , @nCont   INTEGER    
 , @Posicion1  CHAR (03)       
 , @Numoper  NUMERIC (10)       
 , @rut   NUMERIC (09)       
 , @CodCli   NUMERIC (09)       
 , @MtoMda1  NUMERIC (21,04)     
 , @fecvcto  CHAR (08)       
 , @fechini  CHAR (08)       
 , @MercadoLc  CHAR (01)       
 , @correla  NUMERIC (03)       
 , @moneda   NUMERIC (03)       
 , @codigo   NUMERIC (05)       
 , @seriado  CHAR (01)       
 , @nDolar   NUMERIC (19,4)      
 , @cInstser  CHAR (10)       
 , @cMascara  CHAR (10)       
 , @dFeccomp  DATETIME     
 , @nforpago  NUMERIC (03)     
 , @nmoneda  NUMERIC(05)    
    
 UPDATE  BACLINEAS..LINEA_SISTEMA     
 SET TotalOcupado = 0    
 , TotalExceso = 0    
 , TotalDisponible = TotalAsignado    
 WHERE  id_sistema = 'BTR'    
    
 UPDATE  BACLINEAS..LINEA_PRODUCTO_POR_PLAZO    
 SET TotalOcupado = 0    
 , TotalExceso = 0    
 , TotalDisponible = TotalAsignado    
 WHERE  id_sistema = 'BTR'    
    
 ----------------------------------------    
 DELETE BACLINEAS..LINEA_CHEQUEAR    
 WHERE FECHAOPERACION = @DFECPRO    
 AND  id_sistema = 'BTR'    
    
 SELECT @dfecproc = acfecproc     
 FROM MDAC    
    
 DELETE BACLINEAS..LINEA_TRANSACCION    
 WHERE id_sistema   = @idSistema    
    
 SELECT  *    
 , sw = 'N'    
 INTO #TMP_DI    
 FROM MDDI    
 WHERE dirutcart > 0    
 AND ditipoper = 'CP'    
 ORDER BY dinumdocu    
 ,  dicorrela    
    
         UPDATE #TMP_DI    
         SET    divptirc  = divptirc  + vivptirc    
         ,      dinominal = dinominal + vinominal    
         FROM   MDVI    
         WHERE  vinumdocu = dinumdocu and vicorrela = dicorrela    
    
         DELETE FROM #TMP_DI    
         WHERE  dinominal <= 0     
     
 CREATE CLUSTERED INDEX TMP_DI_001 ON #TMP_DI (SW)    
     
 SELECT @nRegs = COUNT(1)    
 FROM #TMP_DI    
    
 SELECT @nCont = 1    
    
 WHILE 1 = 1  BEGIN      
  SET ROWCOUNT 1    
    
  SELECT  @seriado  = '*'    
    
  SELECT  @Numoper  = dinumdocu        
  , @correla  = dicorrela        
  , @MtoMda1  = divptirc     --> cpvptirc         
  , @rut      = cprutcli         
  , @CodCli   = cpcodcli         
  , @codigo   = incodigo         
  , @seriado  = inmdse           
  , @fecvcto  = CONVERT(CHAR(8),difecsal,112)       
  , @fechini  = CONVERT(CHAR(8),cpfeccomp,112)      
  , @dFeccomp = cpfeccomp         
  , @nDolar   = CASE WHEN SUBSTRING(diinstser,1,3)='DPX' THEN 0 ELSE vmvalor END     
  , @cInstser = cpinstser         
  , @cMascara = cpmascara       
  , @nforpago = cpforpagi       
  , @nmoneda  = dimoneda     
  FROM #TMP_DI      
  , VIEW_INSTRUMENTO    
  , VIEW_VALOR_MONEDA    
  , MDCP    
  WHERE diserie  = inserie    
  AND dinumdocu = cpnumdocu    
  AND dicorrela = cpcorrela    
  AND vmcodigo = 994    
  AND vmfecha  = @dfecproc --> acfecproc    
  AND SW  = 'N'    
  AND ditipoper = 'CP'    
  AND dinominal > 0    
    
  SET ROWCOUNT 0    
    
  IF @seriado = '*'     
   BREAK    
    
  IF @seriado = 'N' AND @codigo <> 98    
   SELECT  @moneda = nsmonemi    
   , @rut  = nsrutemi    
   , @moneda = nsmonemi    
   FROM VIEW_NOSERIE    
   WHERE nsnumdocu = @Numoper    
   AND nscorrela = @correla    
    
  IF @seriado = 'S' AND @codigo <> 98    
   SELECT  @rut  = serutemi    
   , @moneda = semonemi    
   FROM VIEW_SERIE    
   WHERE semascara = @cMascara    
    
                /*    
  IF EXISTS( SELECT 1 FROM MDVI WHERE vinumdocu = @Numoper AND vicorrela = @correla ) BEGIN    
   SELECT @MtoMda1 = @MtoMda1 + (SELECT SUM(vivptirv) FROM MDVI WHERE vinumdocu = @Numoper AND vicorrela = @correla)    
  END    
         */    
    
  SELECT @ncont = @ncont + 1    
    
  IF @MtoMda1 > 0     
                BEGIN    
   IF @CodCli = 10    
    SELECT @CodCli = 1      
    
   EXECUTE BACLINEAS..Sp_Lineas_Grabar @dfecproc , 'BTR', 'CP', @rut, @CodCli, @Numoper, @Numoper, @Correla, @fechini, @MtoMda1, @nDolar, @fecvcto , '', @nmoneda, 'N', @codigo, @nforpago    
    
   UPDATE MDMO    
   SET  mostatreg = ''    
   WHERE  monumoper = @Numoper    
   AND monumdocu = @Numoper    
  END    
    
  UPDATE #TMP_DI    
  SET sw = 'S'    
  WHERE @Numoper = dinumdocu    
  AND @correla  = dicorrela      
 END        
 ---------------------------------------------------------------------------------------    
    
 SELECT *    
 , sw = 'N'    
 INTO #TMP_CI    
 FROM MDCI    
 WHERE ciinstser = 'ICOL'    
    
 CREATE CLUSTERED INDEX TMP_CI_001 ON #TMP_CI (SW)    
    
 SELECT @nRegs = COUNT(1)    
 FROM #TMP_CI    
    
 WHILE 1 = 1     
        BEGIN      
    
  SELECT @seriado = '*'    
    
  SET ROWCOUNT 1    
    
  SELECT  @Numoper = cinumdocu        
  , @correla = cicorrela        
  , @rut    = cirutcli         
  , @CodCli  = cicodcli         
  , @MtoMda1 = civptirci        
  , @moneda  = cimonemi         
  , @codigo  = cicodigo         
  , @seriado = 'N'           
  , @fecvcto = CONVERT(CHAR(8),cifecvenp,112)      
  , @fechini = CONVERT(CHAR(8),cifecinip,112)      
  , @nDolar  = vmvalor     
  , @nforpago = ciforpagi     
  , @nmoneda  = cimonpact    
  FROM #TMP_CI    
  , VIEW_VALOR_MONEDA    
  WHERE (vmcodigo = 994 AND vmfecha = @dfecproc) --acfecproc)    
  AND sw = 'N'    
      
  SET ROWCOUNT 0    
      
  IF @seriado = '*'     
   BREAK    
      
  IF @MtoMda1 > 0 BEGIN      
   EXECUTE BACLINEAS..Sp_Lineas_Grabar @dfecproc, 'BTR', 'ICOL', @Rut, @codcli, @Numoper, @Numoper, @correla, @fechini, @MtoMda1, @nDolar, @fecvcto, '', @nmoneda, 'N', @codigo, @nforpago    
       
   UPDATE MDMO    
   SET  mostatreg = ''    
   WHERE  monumoper = @Numoper    
   AND monumdocu = @Numoper    
  END    
    
  UPDATE #TMP_CI    
  SET sw='S'    
  WHERE @Numoper = cinumdocu    
  AND @correla = cicorrela    
 END        
    
        --------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<-------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------    
 SELECT *    
 , sw = 'N'    
 INTO #TMP_CAP    
 FROM MDCI    
 WHERE ciinstser = 'ICAP'    
    
        --------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<-------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------            
        --> Segun Roberto Fuentes. hay que excluirlos de los Calculoes ICAP    
        DELETE FROM #TMP_CAP    
        --------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<-------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------    
    
 SELECT @nRegs = COUNT(1)    
 FROM #TMP_CAP    
    
 WHILE 1 = 1     
        BEGIN    
    
  SELECT @seriado = '*'    
    
  SET ROWCOUNT 1    
    
  SELECT  @Numoper  = cinumdocu        
  , @correla  = cicorrela        
  , @rut     = cirutcli         
  , @CodCli   = cicodcli         
  , @MtoMda1  = civptirci        
  , @moneda   = cimonemi         
  , @codigo   = cicodigo         
  , @seriado  = 'N'           
  , @fecvcto  = CONVERT(CHAR(8),cifecvenp,112)      
  , @fechini  = CONVERT(CHAR(8),cifecinip,112)      
  , @nDolar   = vmvalor     
  , @nforpago = ciforpagi     
  , @nmoneda  = cimonpact    
  FROM #TMP_CAP    
  , VIEW_VALOR_MONEDA    
  WHERE  (vmcodigo  = 994 AND vmfecha = @dfecproc)    
  AND sw = 'N'    
    
  SET ROWCOUNT 0    
      
  IF @seriado = '*'     
   BREAK    
    
  IF @MtoMda1 > 0     
                BEGIN    
     EXECUTE BACLINEAS..Sp_Lineas_Grabar @dfecproc, 'BTR', 'ICAP', @Rut, @codcli, @Numoper, @Numoper, @correla, @fechini, @MtoMda1, @nDolar, @fecvcto, '', @nmoneda, 'N', @codigo, @nforpago    
    
                   UPDATE MDMO    
                      SET mostatreg = ''    
     WHERE  monumoper = @Numoper    
       AND  monumdocu = @Numoper    
  END    
    
  UPDATE #TMP_CAP    
  SET sw = 'S'    
  WHERE @Numoper = cinumdocu    
  AND @correla = cicorrela    
 END     
    
     
 SELECT *    
 , sw = 'N'    
 INTO #TMP_CII    
 FROM MDCI    
 WHERE ciinstser NOT IN ('ICOL','ICAP')    
     
 SELECT @nRegs = COUNT(*)    
 FROM #TMP_CI    
    
 WHILE 1 = 1 BEGIN      
    
  SELECT @seriado = '*'    
    
  SET ROWCOUNT 1    
    
  SELECT  @Numoper = cinumdocu        
  , @correla = cicorrela        
  , @rut    = cirutcli         
  , @CodCli  = cicodcli         
  , @MtoMda1 = civptirci        
  , @moneda  = cimonemi         
  , @codigo  = cicodigo         
  , @seriado = 'N'           
  , @fecvcto = CONVERT(CHAR(8),cifecvenp,112)      
  , @fechini = CONVERT(CHAR(8),cifecinip,112)      
  , @nDolar  = vmvalor     
  , @nforpago = ciforpagi     
  , @nmoneda  = cimonpact    
  FROM #TMP_CII    
  , VIEW_VALOR_MONEDA    
--  , MDAC    
  WHERE (vmcodigo=994 AND vmfecha = @dfecproc ) --acfecproc)    
  AND sw  = 'N'    
      
  SET ROWCOUNT 0    
      
  IF @seriado = '*'     
   BREAK    
      
  IF @MtoMda1 > 0 BEGIN    
   EXECUTE BACLINEAS..Sp_Lineas_Grabar @dfecproc, 'BTR', 'CI', @Rut, @codcli, @Numoper, @Numoper, @correla, @fechini, @MtoMda1, @nDolar, @fecvcto, '', @nmoneda, 'N', @codigo, @nforpago    
       
   UPDATE MDMO    
   SET  mostatreg = ''    
   WHERE  monumoper = @Numoper    
   AND monumdocu = @Numoper    
  END    
      
  UPDATE #TMP_CII    
  SET sw = 'S'    
  WHERE @Numoper = cinumdocu    
  AND @correla = cicorrela    
 END        
    
 EXECUTE BACLINEAS..SP_LINEAS_ACTUALIZA    
 EXECUTE BACLINEAS..SP_RECALCULA_GENERAL    
    
 SET NOCOUNT OFF    
    
END
GO
