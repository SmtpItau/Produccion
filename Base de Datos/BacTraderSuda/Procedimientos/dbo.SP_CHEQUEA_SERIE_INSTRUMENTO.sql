USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHEQUEA_SERIE_INSTRUMENTO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CHEQUEA_SERIE_INSTRUMENTO]  
      (     @cinstser         CHAR(12)  
      ,     @Retorno          CHAR(2)           = ' '  
      ,     @cChequeando      CHAR(1)           = 'N'  
      ,     @cEmisor          CHAR(15)  
      )  
 AS  
 BEGIN  
  
       SET NOCOUNT ON  
   
      DECLARE @nerror      INT  
            ,     @cmascara    CHAR(12)  
            ,     @cinstaux    CHAR(12)  
            ,     @cinstaux2   CHAR(12)  
            ,     @carchivo    CHAR(2)  
            ,     @cmesaux     CHAR(2)  
            ,     @canoaux     CHAR(4)  
            ,     @dfecaux     DATETIME  
            ,     @ncodigo     INT  
            ,     @cserie      CHAR(12)  
            ,     @crefnomi    CHAR(1)  
            ,     @cprog       CHAR(8)  
            ,     @ntipfec     INT  
            ,     @ndiavcup    INT  
            ,     @npervcup    INT  
            ,     @ncupones    INT  
            ,     @nrutemi     NUMERIC(9,0)  
            ,     @nmonemi     INT  
            ,     @ftasemi     FLOAT  
            ,     @nbasemi     NUMERIC(3,0)  
            ,     @dfecemi     DATETIME  
            ,     @dfecven     DATETIME  
            ,     @cgenemi     CHAR(10)  
            ,     @cnemmon     CHAR(5)  
            ,     @ncorte      NUMERIC(19,4)  
            ,     @cseriado    CHAR(1)  
            ,     @clecemi     CHAR(6)  
            ,     @dfecpro     DATETIME  
            ,     @cfecaux     CHAR(10)  
            ,     @nlutil      INT  
            ,     @nlutiling   INT  
            ,     @j           INT  
            ,     @cfamilia    CHAR(12)  
            ,     @nmes        INT  
            ,     @nmes_a      INT  
            ,     @nano        INT  
            ,     @cano        CHAR(04)  
            ,     @cmascaux    CHAR(12)  
            ,     @cTextDia    CHAR(2)  
            ,     @cSigla     CHAR(10)  
  
         SET @nerror = 0  
  
  /*=======================================================================*/  
 /* definici¢n de variables para los instrumentos pdp                     */  
 /*=======================================================================*/  
 DECLARE @cultdia CHAR (24) ,  
             @nanoemi INT           ,  
             @nmesemi INT           ,  
             @ndiaemi INT  
  
 /*=======================================================================*/  
 /* definici¢n de variables para los instrumentos br                      */  
 /*=======================================================================*/  
 DECLARE @iextrae     INT          ,  
         @imesemi     INT          ,  
         @ianovto     INT          ,  
         @ianoemi     INT          ,  
         @imesman     INT          ,  
         @cfecven     CHAR(10)     ,  
         @cfecman     CHAR(10)     ,  
         @cfecemi     CHAR(10)     ,  
         @dfecman   DATETIME  
   
 SELECT @dfecpro = acfecproc FROM MDAC  
  
 /*=======================================================================*/  
 /* guardar la serie, en este punto, llamar a sp_nemosinast(cinstser)     */  
 /* para lchr-chile.-                                                     */  
 /*=======================================================================*/  
      SET @cinstaux2 = @cinstser  
  
 /*=======================================================================*/  
 /* cambio para letras con '*' y '&' / equivale al mes ( siempre es 01)   */  
 /*=======================================================================*/  
      SET @ncodigo = 0  
  
      SELECT      @ncodigo = secodigo FROM VIEW_SERIE WHERE seserie = @cinstser  
  
      IF CHARINDEX('*',@cinstser) > 6 and @ncodigo = 0 ---mymy  
            SET @cinstser = SUBSTRING(@cinstser,1,6)+'01'+SUBSTRING(@cinstser,9,2)  
  
  
 /*=======================================================================*/  
 /* equivale al año                                                       */  
 /*=======================================================================*/  
  
      IF CHARINDEX('&',@cinstser) > 6 and @ncodigo = 0 ----mymy  
BEGIN  
            SET @nmes = CONVERT(INTEGER,SUBSTRING(@cinstser,9,2))  
            SET @nmes_a = DATEPART(MONTH,@dfecpro)  
  
            IF @nmes>@nmes_a  
                  SET @nano = DATEPART(YEAR,@dfecpro)-1  
            ELSE  
                  SET @nano = DATEPART(YEAR,@dfecpro)  
    
            SET @cano   = CONVERT(CHAR(04),@nano)  
            SET @cinstser = SUBSTRING(@cinstser,1,6)+SUBSTRING(@cinstser,9,2)+SUBSTRING(@cano,3,2)  
  
            IF CHARINDEX(' ',@cinstser)=0  
                  SET @cinstser = @cinstaux2  
      END  
   
/*=======================================================================*/  
 /* guardar la serie, en este punto, llamar a sp_nemosinast(cinstser)     */  
 /* para lchr-chile.-                                                     */  
 /*=======================================================================*/  
  
 SET @cinstaux = @cinstser  
 SET @cmascara = '*'  
  
 SELECT @carchivo = 'SE'  ,  
        @cmascara = semascara ,  
        @ncodigo  = secodigo  
 FROM VIEW_SERIE  
 WHERE      seserie           = @cinstser  
  
      IF @cmascara='*'  
      BEGIN  
            SET @cfamilia = '*'  
  
            IF (SUBSTRING(@cinstaux,1,3)='PCD' AND SUBSTRING(@cinstaux,1,6)<>'PCDUS$')  
                  SET @cfamilia = 'PCDUF'  
            ELSE  
            BEGIN  
                  SET @j = LEN(@cinstaux)  
  
                  WHILE @j<>0  
                  BEGIN  
  
                  SELECT  @cfamilia = msfamilia  
                  FROM  VIEW_MASCARA_INSTRUMENTO  
                  WHERE msmascara=SUBSTRING(@cinstaux,1,@j)  
       
                  IF @cfamilia<>'*'  
                        BREAK  
                        SET @j = @j-1  
                  END  
            END  
    
      IF @cfamilia='*'  
            SET @cfamilia = 'LCHR'  
  
-->VB+-18/06/2010  
      IF (@cfamilia='BR'  OR @cfamilia='PRBC' OR @cfamilia='PDBC' OR @cfamilia='DPF' OR @cfamilia='DPD' OR  
            @cfamilia='ICPN'OR @cfamilia='ICPR' OR @cfamilia='DPU$' OR  
            @cfamilia='DPR' OR @cfamilia='DPX' OR  @cfamilia='CERO' OR @cfamilia='ZERO' OR @cfamilia='FMUTUO' OR   
                        @cfamilia='DPXA' OR @cfamilia='DPXB' OR @cfamilia='DPXC' OR @cfamilia='DPXD' OR   
                        @cfamilia='DPXE' or @cfamilia='DPE'  OR @cfamilia='PRTR')  
      BEGIN  
            SET @cmascara = @cfamilia  
      END  
  
  
  /*====================================================================*/  
  /* buscar en tabla de mascaras por msfamilia para extraer largo util  */  
  /* de la serie                 */  
  /*====================================================================*/  
  SET ROWCOUNT 1  
  
  SELECT @nlutil  = LEN(LTRIM(RTRIM(msmascara))) ,  
             @nlutiling = LEN(LTRIM(RTRIM(msnemo)))  
  FROM      VIEW_MASCARA_INSTRUMENTO  
  WHERE  msfamilia      = @cfamilia  
  
  SET ROWCOUNT 0  
  
  /*====================================================================*/  
  /* buscar en archivo de series.                                       */  
  /*====================================================================*/  
            SET @cmascaux  = @cmascara  
            SET @cmascara  = '*'  
  
            SELECT  @carchivo  = 'SE',  
                        @cmascara  = semascara ,  
                        @ncodigo    = secodigo  
            FROM  VIEW_SERIE  
            WHERE   seserie   = SUBSTRING(@cinstaux,1,@nlutil)  
  
            IF @nlutiling <> LEN(RTRIM(LTRIM(@cinstser)))  
            BEGIN  
                  IF @cChequeando = 'S'  
                        SELECT 'ERROR' = 15 , 'DESC' = 'NEMOTECNICO INGRESADO INCOMPLETAMENTE', 'SERIE' = @cinstser  
  
                  RETURN  
            END  
  
      END  
  
  
  
      IF @cmascara='*'  
            SET @carchivo = 'IN'  
  
      /*=======================================================================*/  
      /* el instrumento esta definido en la tabla serie.                       */  
      /*=======================================================================*/  
  
   IF @carchivo='SE'  
      BEGIN  
  
            SELECT @ncodigo = incodigo ,  
                     @cserie  = inserie ,  
                     @crefnomi = inrefnomi ,  
                     @cprog  = inprog ,  
                     @ntipfec = intipfec ,  
                     @cseriado = inmdse ,  
                     @ndiavcup = sediavcup ,  
                     @npervcup = sepervcup ,  
                     @ncupones = secupones ,  
                     @nrutemi = serutemi ,  
                     @nmonemi = semonemi ,  
                     @ftasemi = setasemi ,  
                     @nbasemi = sebasemi ,  
                     @dfecemi = sefecemi ,  
                     @dfecven = sefecven ,  
                     @ncorte  = secorte ,  
                     @cfamilia = inserie  
                    FROM VIEW_SERIE, VIEW_INSTRUMENTO  
                    WHERE semascara=@cmascara AND incodigo=secodigo  
  
  /*====================================================================*/  
  /* existe la mascara pero no esta en tabla serie                      */  
  /*====================================================================*/  
  
      IF @@ROWCOUNT=0  
      BEGIN  
            IF @cChequeando = 'S'  
                  SELECT 'ERROR' = 9 , 'DESC' = 'EXISTE LA MASCARA PERO NO ESTA EN TABLA SERIE  ', 'SERIE' = @cinstser  
  
            RETURN 9  
      END  
  
 END  
  
 /*=======================================================================*/  
 /* el instrumento esta definido en la tabla serie.             */  
 /*=======================================================================*/  
  
 IF @carchivo='IN'  
 BEGIN  
  SELECT @ncodigo = 0  
  SELECT @ncodigo = incodigo ,  
   @cserie  = inserie ,  
   @crefnomi = inrefnomi ,  
   @cprog  = inprog ,  
   @ntipfec = intipfec ,  
 @cseriado = inmdse ,  
   @ndiavcup = 1  ,  
   @npervcup = 0  ,  
   @ncupones = 1  ,  
   @nrutemi = inrutemi ,  
   @nmonemi = inmonemi ,  
   @ftasemi = 0.0  ,  
   @nbasemi = inbasemi ,  
   @dfecemi = NULL  ,  
   @dfecven = NULL  ,  
   @ncorte  = 0  
  FROM VIEW_INSTRUMENTO  
  WHERE inserie = @cmascaux  
  
  
  /*====================================================================*/  
  /* existe la mascara pero no esta en instrumento                             */  
  /*====================================================================*/  
      IF @ncodigo = 0  
      BEGIN  
            IF @cChequeando = 'S'  
                  SELECT 'ERROR' = 8,     'DESC' = 'EXISTE LA MASCARA PERO NO ESTA EN INSTRUMENTO', 'SERIE' = @cinstser  
            RETURN 8  
      END  
   
END  
 /*=======================================================================*/  
 /* problemas para el chequeo de la familia.                */  
 /*=======================================================================*/  
 IF @cfamilia=NULL  
 BEGIN  
      IF @cChequeando = 'S'  
            SELECT 'ERROR' = 12, 'DESC' = 'PROBLEMAS PARA EL CHEQUEO DE LA FAMILIA.', 'SERIE' = @cinstser  
        
      RETURN 12  
 END  
  
 IF @cfamilia='PTF'  
 BEGIN  
      IF @ndiavcup<10  
            SET @cTextDia = '0'+CONVERT(CHAR(1),@ndiavcup)  
      ELSE  
            SET @cTextDia = CONVERT(CHAR(2),@ndiavcup)  
            SET @dfecemi = CONVERT(DATETIME,SUBSTRING(@cinstaux,9,2)+SUBSTRING(@cinstaux,7,2)+@cTextDia)  
            SET @dfecven = DATEADD(MONTH,(@ncupones*@npervcup),@dfecemi)  
  
            IF @dfecemi=NULL OR @dfecven=NULL  
            BEGIN  
                  IF @cChequeando = 'S'  
                        SELECT 'ERROR' = 9, 'DESC' = 'EXISTE LA MASCARA PERO NO ESTA EN TABLA SERIE  ', 'SERIE' = @cinstser  
                    
                  RETURN 9  
            END  
 END  
 ELSE  
  
  IF @cfamilia='DPF' OR @cfamilia='DPR' OR @cfamilia='DPD' OR @cfamilia='PDBC' OR @cfamilia='PRBC' OR  
  @cfamilia='CERO' OR @cfamilia='ZERO' OR  @cfamilia='DPX'  OR @cfamilia='DPXA' OR @cfamilia='DPXB' OR @cfamilia='DPXC' OR   
  @cfamilia='DPXD' OR @cfamilia='DPXE' OR @cfamilia='DPE' OR @cfamilia='PRTR' OR @cfamilia='DPU$' OR   
  @cfamilia='ICPN'  OR @cfamilia='ICPR'    --> VB+- 18/06/2010  
  BEGIN  
   SET @dfecemi = @dfecpro  
   SET @dfecven = CONVERT(DATETIME, SUBSTRING(@cinstaux,9,2)+SUBSTRING(@cinstaux,7,2)+SUBSTRING(@cinstaux,5,2))  
  
      IF @cFamilia='DPXC'  
      BEGIN  
            IF DATEDIFF(DAY,@dfecpro,@dfecven)>180  
            BEGIN  
                  IF @cChequeando = 'S'  
                        SELECT 'ERROR' = 30, 'DESC' = '', 'SERIE' = @cinstser  
  
                  RETURN 30  
            END  
      END  
  
      IF @cFamilia='DPXD'  
      BEGIN  
            IF DATEDIFF(DAY,@dfecpro,@dfecven)<=180  
            BEGIN  
                  IF @cChequeando = 'S'  
                        SELECT 'ERROR' = 31, 'DESC' = '', 'SERIE' = @cinstser  
  
                  RETURN 31  
            END  
      END  
  
  /*=======================================================================*/  
  /* determina fecha de emisi¢n / vencimiento.                             */  
  /*=======================================================================*/  
  END ELSE  
  BEGIN  
            EXECUTE @nerror = SP_FECEMIVEN   @carchivo ,  
                                                            @cmesaux   ,  
                                                            @canoaux   ,  
                                                            @dfecaux   ,  
                                                            @crefnomi   ,  
                                                            @ntipfec   ,  
                                                            @ndiavcup   ,  
                                                            @npervcup   ,  
                                                            @ncupones   ,  
                                                            @dfecemi OUTPUT  ,  
                                                            @dfecven OUTPUT  
   /*====================================================================*/  
   /* devuelve errores desde 'sp_fecemiven'                              */  
   /*====================================================================*/  
            IF @nerror<>0 OR @@error<>0  
            BEGIN  
                  IF @cChequeando = 'S'  
                        SELECT 'ERROR' = @nerror, 'DESC' = 'DEVUELVE ERRORES DESDE SP_FECEMIVEN', 'SERIE' = @cinstser  
  
                  RETURN @nerror  
            END  
      END     
  
  /*=======================================================================*/  
  /* generico del emisor.              */  
  /*=======================================================================*/  
  SELECT @cgenemi = emgeneric FROM VIEW_EMISOR WHERE emrut=@nrutemi  
  
  IF @@ROWCOUNT=0  
            SET @cgenemi = '?????'  
            --SET @cgenemi = @cgenemi   
  IF @cgenemi='?????'  
            BEGIN  
            SELECT @cgenemi = (SELECT Nemo_BAC FROM VIEW_TBL_NEMOS_BCS_BAC WHERE Nemo_BCS=@cEmisor)  
            SELECT @nrutemi = (SELECT RUT FROM VIEW_TBL_NEMOS_BCS_BAC WHERE Nemo_BCS=@cEmisor)  
        
      END   
        
  
  
  /*=======================================================================*/   
  /* nemotecnico de la moneda.            */  
  /*=======================================================================*/  
  
  SELECT @cnemmon = mnnemo FROM VIEW_MONEDA WHERE mncodmon=@nmonemi  
  
  IF @@ROWCOUNT=0  
            SET @cnemmon = '?????'  
  
  /*=======================================================================*/  
  /* generar mascara de lectura de datos de emision.                       */  
  /*=======================================================================*/  
  
  SET @clecemi = 'NNNNNN'  
  
  IF @nrutemi=0  
   SET @clecemi = 'S'  
  IF @nmonemi=0  
   SET @clecemi = 'S'  
  IF @ftasemi=0.0 AND @cfamilia<>'PCDUF' AND @cfamilia<>'PCDUS$' AND @cfamilia <>'PRBC' AND @cfamilia<>'PDBC' AND  
     @cfamilia<>'DPR' AND @cfamilia<>'DPF' AND @cfamilia<>'DPX' AND @cfamilia <>'ECP' AND @cfamilia<>'ECU' AND   
       @cfamilia<>'CERO' AND @cfamilia <>'ZERO' AND @cfamilia <> 'PRTR' AND @cfamilia='DPU$' AND   
     @cfamilia<>'ICPN'  AND @cfamilia<>'ICPR'    --> VB+- 18/06/2010  
        
      SET @clecemi = 'S'  
      IF @nbasemi=0  
            SET @clecemi = 'S'  
  
  /*=======================================================================*/  
  /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - lchr       */  
  /*=======================================================================*/  
  IF @cfamilia='LCHR'  
  BEGIN  
      SET @dfecemi = CONVERT(DATETIME,SUBSTRING(@cinstaux,9,2)+SUBSTRING(@cinstaux,7,2)+'01')  
      SET @dfecven = DATEADD(MONTH,(@ncupones*@npervcup),@dfecemi)  
  END  
  /*=======================================================================*/  
  /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - pcduf      */  
  /*=======================================================================*/  
  IF @cfamilia='PCDUF'  
  BEGIN  
      SET @dfecemi = CONVERT(DATETIME,SUBSTRING(@cinstaux,9,2)+SUBSTRING(@cinstaux,7,2)+SUBSTRING(@cinstaux,5,2))  
      SET @dfecven = DATEADD(MONTH,(@ncupones*@npervcup),@dfecemi)  
  END  
  /*=======================================================================*/  
  /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - pdp        */  
  /*=======================================================================*/  
  IF @cfamilia='PDP'  
  BEGIN  
   SET @cultdia = '312831303130313130313031'  
   SET @nanoemi = CONVERT(INT,'19'+SUBSTRING(@cinstaux,9,2))  
   SET @nmesemi = CONVERT(INT,SUBSTRING(@cinstaux,7,2))  
  
   IF @nmesemi=2 AND (@nanoemi % 4)=0  
   BEGIN  
            SET @ndiaemi = 29  
   END ELSE  
   BEGIN  
            SET @ndiaemi = CONVERT(INT,SUBSTRING(@cultdia,@nmesemi*2-1,2))  
  END  
  
  SET @dfecemi = CONVERT(DATETIME,CONVERT(VARCHAR(4),@nanoemi)+CONVERT(VARCHAR(2),@nmesemi)+CONVERT(CHAR(2),@ndiaemi))  
  SET @dfecven = DATEADD(MONTH,(@ncupones*@npervcup),DATEADD(DAY,DATEPART(DAY,@dfecemi)*-1,@dfecemi))  
 END  
  
 /*=======================================================================*/  
 /* Calculo de fechas emisi¢n y vcto. para papeles no unicos - br         */  
 /*=======================================================================*/  
 IF @cfamilia='BR'  
 BEGIN  
  
  SET @clecemi      = 'NNNNNN'  
  SET @iExtrae      = ASCII(SUBSTRING(@cInstser,3,1))  
  SET @iMesemi      = CASE WHEN @iExtrae=48 THEN CONVERT(INT,CHAR(@iExtrae))+10  
                                    WHEN @iExtrae>48 AND @iExtrae<58 THEN CONVERT(INT,CHAR(@iExtrae))  
                                    ELSE CONVERT(INT,@iExtrae)-54  
                             END  
  IF @iMesemi>12  
  BEGIN  
      IF @cChequeando = 'S'  
            SELECT 'ERROR' = 1, 'DESC' = 'Serie Mal Ingresada', 'SERIE' = @cinstser  
  
      RETURN  
  
  END  
  
  SET @iExtrae = ASCII(SUBSTRING(@cInstser,4,1))  
  SET @iAnoemi = 1980 + CASE WHEN @iExtrae=48                    THEN CONVERT(INT,CHAR(@iExtrae))+10  
                                               WHEN @iExtrae>48 AND @iExtrae<58 THEN CONVERT(INT,CHAR(@iExtrae))  
                                               ELSE                                             CONVERT(INT,@iExtrae)-54  
                                         END  
  SET @iAnovto = CONVERT(INT,SUBSTRING(@cInstser,9,2))  
  
      IF @iAnovto>=0 AND @iAnovto<95  
            SET @iAnovto = 2000 + @iAnovto  
      ELSE  
            SET @iAnovto = 1900 + @iAnovto  
            SET @iMesman = DATEPART(DAY,@dFecpro)*-1  
  
            DECLARE @cMesemi CHAR (02)  
  
            IF @iMesemi<10  
                  SET @cMesemi = '0'+CONVERT(CHAR(02),@iMesemi)  
            ELSE  
                  SET @cMesemi = CONVERT(CHAR(02),@iMesemi)  
  
            SET @cFecven = CONVERT(CHAR(04),@iAnovto)+SUBSTRING(@cInstser,7,2)+SUBSTRING(@cInstser,5,2)  
            SET @cFecemi = CONVERT(CHAR(04),@iAnoemi)+@cMesemi+'01'  
            SET @cFecman = CONVERT(CHAR(8),DATEADD(DAY,@iMesman,@dFecpro),112)  
            SET @dFecman = SUBSTRING(@cFecman,1,4)+SUBSTRING(@cFecman,5,2)+'01'  
     SET @dFecemi = CONVERT(DATETIME,@cFecemi)  
            SET @dFecven = CONVERT(DATETIME,@cFecven)  
      END  
  
 IF @dfecemi = NULL  
      SET @dfecemi = @dfecpro  
  
 IF @dfecemi > @dfecpro  
 BEGIN  
      SET @nerror = 12  
 END  
  
 IF @dfecven = NULL  
 BEGIN  
                  SET @cfecaux = SUBSTRING(@cinstser,5,6)  
            EXECUTE @nerror  = SP_ESFECDMA @cfecaux, @dfecven OUTPUT  
 END  
  
 IF @dfecven<=@dfecpro  
 BEGIN  
      SET @nerror = 11  
 END  
  
  
 IF @cChequeando = 'S'  
      SELECT  'ERROR' = ISNULL(@nerror, 0), 'DESC' = 'OK', 'SERIE' = @cinstser  
 ELSE   
       SELECT 'ERROR' = ISNULL(@nerror,0)   ,  
                  'mascara' = @cinstaux2    ,  
                  'codigo'  = @ncodigo    ,  
                  'serie'   = @cserie    ,  
                  'rutemi'  = isnull(@nrutemi,0)     ,  
                  'monemi'  = @nmonemi    ,  
                  'tasemi'  = @ftasemi    ,  
                  'basemi'  = @nbasemi    ,  
                  'fecemi'  = CONVERT(CHAR(10),@dfecemi,103) ,  
                  'fecven'  = CONVERT(CHAR(10),@dfecven,103) ,  
                  'refnomi' = @crefnomi    ,  
                  'genemi'  = isnull(@cgenemi,'?????')    ,  
                  'nemmon'  = @cnemmon    ,  
                  'corte'   = @ncorte    ,  
                  'seriado' = @cseriado    ,  
                  'lecemi'  = @clecemi    ,  
                  'fecpro'  = CONVERT(CHAR(10),@dfecpro,103)  
  
      RETURN 0  
END  
GO
