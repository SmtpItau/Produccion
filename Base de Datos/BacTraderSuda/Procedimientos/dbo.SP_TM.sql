USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TM]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TM]
AS
BEGIN
   SET NOCOUNT ON
 
        DECLARE @modcal  INTEGER
 DECLARE @cFeccal CHAR(10)
 DECLARE @nCodigo INTEGER
 DECLARE @cMascara CHAR(12)
 DECLARE @nMonemi INTEGER
 DECLARE @cFecemi CHAR(10)
 DECLARE @cFecven CHAR(10)   
 DECLARE @fTasemi FLOAT
 DECLARE @fBasemi FLOAT
 DECLARE @fTasest FLOAT
 DECLARE @fNominal FLOAT
 DECLARE @rNominal NUMERIC(19,4)
 DECLARE @fTir  FLOAT
 DECLARE @fPvp  FLOAT
 DECLARE @fMT  FLOAT
 DECLARE @fMTUM  FLOAT
 DECLARE @fMT_cien FLOAT
 DECLARE @fVan  FLOAT
 DECLARE @fVpar  FLOAT
 DECLARE @nNumucup INTEGER
 DECLARE @dFecucup DATETIME
 DECLARE @fIntucup FLOAT
 DECLARE @fAmoucup FLOAT
 DECLARE @fSalucup FLOAT
 DECLARE @nNumpcup INTEGER
 DECLARE @dFecpcup DATETIME
 DECLARE @fIntpcup FLOAT
 DECLARE @fAmopcup FLOAT
 DECLARE @fSalpcup FLOAT
  
 /*------------------------------
  * Variables de Trabajo
  *------------------------------*/
 DECLARE @nError  INTEGER
 DECLARE @cProg  VARCHAR(20)
 DECLARE @dFeccal DATETIME
 DECLARE @dFecemi DATETIME
 DECLARE @dFecven DATETIME
 DECLARE @suma  INTEGER 
 DECLARE @x  INTEGER
 DECLARE @nRutcart NUMERIC(09,0)
 DECLARE @nNumdocu NUMERIC(10,0)
 DECLARE @nCorrela       NUMERIC(03,0)
 DECLARE @cTipoper       CHAR(3)
 DECLARE @cInstser       CHAR(12)
 DECLARE @cserie  CHAR(12)
 DECLARE @nNominal       NUMERIC(19,4) 
 DECLARE @Codser  NUMERIC(05,0) 
  
 /*---------------------------------
  * Ajuste de Fechas
  *---------------------------------*/
 SELECT @nMonemi  = 0
 SELECT @dFecemi  = ''
 SELECT @dFecven  = ''
 SELECT @fTasemi  = 0.0
 SELECT @fBasemi  = 0.0
 SELECT @fTasest  = 0.0
 SELECT @fNominal = 0.0
 SELECT @fTir  = 0.0
 SELECT @fPvp  = 0.0
 SELECT @fMT  = 0.0
 SELECT @fMTUM  = 0.0
 SELECT @fMT_cien = 0.0
 SELECT @fVan  = 0.0
 SELECT @fVpar  = 0.0
 SELECT @nNumucup = 0
 SELECT @dFecucup = ''
 SELECT @fIntucup = 0.0
 SELECT @fAmoucup = 0.0
 SELECT @fSalucup = 0.0
 SELECT @nNumpcup = 0
 SELECT @dFecpcup = ''
 SELECT @fIntpcup = 0.0
 SELECT @fAmopcup = 0.0
 SELECT @fSalpcup = 0.0
 SELECT @suma   = 0
 SELECT @x   = 1
 SELECT @codser   = 0
 
 -- Crear Tabla temporal
CREATE TABLE #TEMP
  (  rutcart  NUMERIC(09,0) NOT NULL,
   numdocu  NUMERIC(10,0) NOT NULL,
     correla  NUMERIC(03,0) NOT NULL,
   codser  NUMERIC(5,0)  not null,
     tipoper  CHAR(3)       NOT NULL,
   instser  CHAR(12)      NOT NULL,
     nominal  NUMERIC(19,4) NOT NULL,
   serie   CHAR(12)      NOT NULL,
     registro INTEGER  IDENTITY(1,1) PRIMARY KEY NOT NULL
  )
  INSERT #TEMP
  SELECT  rutcart   = MDDI.dirutcart,
          numdocu   = MDDI.dinumdocu,
          correla   = MDDI.dicorrela,
   codser  = 0,
          tipoper   = ISNULL(mddi.ditipoper,'*'),
   instser  = MDDI.diinstser,
   nominal   = MDDI.dinominal,
   serie     = MDDI.diserie
  FROM    MDDI
  WHERE   MDDI.ditipoper='CP' 
  OR  MDDI.ditipoper='CI'
 /*--------------------------------------
  * Sacar fecha de proceso
  *-------------------------------------*/ 
 
 SELECT @dFeccal = mdac.acfecproc
        FROM  MDAC
 
 WHILE ( @x=1 )
 BEGIN   
                SELECT @cTipoper = '*'
  SET ROWCOUNT 1 
  SELECT  @nRutcart  = #TEMP.rutcart,
          @nNumdocu  = #TEMP.numdocu,
   @codser    = #TEMP.codser,
          @nCorrela  = #TEMP.correla,
          @cTipoper  = ISNULL(#TEMP.tipoper,'*'),
   @cInstser  = #TEMP.instser,
   @rNominal  = ISNULL(#TEMP.nominal,0.0),
   @cserie    = #TEMP.serie,
   @suma      = #TEMP.registro
  FROM    #TEMP
  WHERE #TEMP.registro > @suma
  SET ROWCOUNT 0 
  
  IF @cTipoper='*' BREAK
  /*----------------------------------------------
                 * Sacar la Tasa Estimada, dependiendo de donde
   * venga la disponibilidad de una CP = CI  
   *---------------------------------------------*/
  IF @cTipoper='CP'
  BEGIN
   SELECT @fTasest = ISNULL(MDCP.cptasest,0.0),
          @Codser = MDCP.cpcodigo
   FROM   MDCP
   WHERE  MDCP.cprutcart= @nRutcart 
   AND    MDCP.cpnumdocu= @nNumdocu
   AND    MDCP.cpcorrela= @nCorrela 
  END
    
  IF @cTipoper='CI'
  BEGIN
   SELECT @fTasest = ISNULL(mdci.citasest ,0.0),
          @Codser = mdci.cicodigo
   FROM   MDCI
   WHERE  mdci.cirutcart= @nRutcart 
   AND    mdci.cinumdocu= @nNumdocu
   AND    mdci.cicorrela= @nCorrela 
  END
  SELECT @fTir = ISNULL(mdtm.tmtir,0.0)
/* revisar */   FROM   MDTM
  WHERE  mdtm.tmserie = @cInstser
  /*------------------------------------
   * Buscar nombre de Rutina de Calculo
   *------------------------------------*/
   SELECT @cProg = 'Sp_'+RTRIM(view_instrumento.inprog)
  FROM   VIEW_INSTRUMENTO
  WHERE  view_instrumento.incodigo= @codser
  SELECT @fNominal = CONVERT(FLOAT,@rNominal)
  EXECUTE @nError = @cProg 2, 
      @dFeccal,
      @nCodigo,
      @cInstser,
      @nMonemi,
      @dFecemi,
      @dFecven,
      @fTasemi,
      @fBasemi,
      @fTasest,
      @fNominal OUTPUT,      
      @fTir     OUTPUT,
      @fPvp     OUTPUT,
      @fMt     OUTPUT,
      @fMtum    OUTPUT,
      @fMt_cien OUTPUT,
      @fVan     OUTPUT,
      @fVpar    OUTPUT,
      @nNumucup OUTPUT,
      @dFecucup OUTPUT,
      @fIntucup OUTPUT,
      @fAmoucup OUTPUT,
      @fSalucup OUTPUT,
      @nNumpcup OUTPUT,
      @dFecpcup OUTPUT,
      @fIntpcup OUTPUT,
      @fAmopcup OUTPUT,
      @fSalpcup OUTPUT
  BEGIN TRANSACTION
           
  UPDATE MDDI 
  SET  dipvpmcd  = @fPvp,
       ditirmcd  = @fTir,
       divpmcd100 = @fMt_cien,
       divpmcd  = @fMt
  WHERE MDDI.dirutcart = @nRutcart 
  AND   MDDI.dinumdocu = @nNumdocu 
  AND   MDDI.dicorrela = @nCorrela
 
  IF @@ERROR <> 0 BEGIN
   ROLLBACK TRANSACTION
                        SELECT 'OK'
                        SET NOCOUNT OFF
   RETURN
  END  
  COMMIT TRANSACTION
 END
   SELECT 'OK'
   SET NOCOUNT OFF
END

GO
