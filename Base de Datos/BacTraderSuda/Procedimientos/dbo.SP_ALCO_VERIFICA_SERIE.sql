USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_VERIFICA_SERIE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_ALCO_VERIFICA_SERIE]  
(		@cinstser CHAR (12) 
	,	@Monemis NUMERIC(9) OUTPUT 
)
AS
BEGIN
/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/

 SET NOCOUNT ON
 DECLARE  @nerror		INTEGER  ,
		  @cmascara		CHAR (12) ,
		  @cinstaux		CHAR (12) ,
		  @cinstaux2	CHAR (12) ,
		  @carchivo		CHAR (2) ,
		  @cmesaux		CHAR (2) ,
		  @canoaux		CHAR (4) ,
		  @dfecaux		DATETIME ,
		  @ncodigo		INTEGER  ,
		  @cserie		CHAR (12) ,
		  @crefnomi		CHAR (1) ,
		  @cprog		CHAR (8) ,
		  @ntipfec		INTEGER  ,
		  @ndiavcup		INTEGER  ,
		  @npervcup		INTEGER  ,
		  @ncupones		INTEGER  ,
		  @nrutemi		NUMERIC (9,0) ,
		  @nmonemi		INTEGER  ,
		  @ftasemi		FLOAT  ,
		  @nbasemi		NUMERIC (3,0) ,
		  @dfecemi		DATETIME ,
		  @dfecven		DATETIME ,
		  @cgenemi		CHAR (10) ,
		  @cnemmon		CHAR (5) ,
		  @ncorte		NUMERIC (19,4) ,
		  @cseriado		CHAR (1) ,
		  @clecemi		CHAR (6) ,
		  @dfecpro		DATETIME ,
		  @cfecaux		CHAR (10) ,
		  @nlutil		INTEGER  ,
		  @nlutiling	INTEGER  ,
		  @j			INTEGER  ,
		  @cfamilia		CHAR (12) ,
		  @nmes			INTEGER  ,
		  @nmes_a		INTEGER  ,
		  @nano			INTEGER  ,
		  @cano			CHAR (04) ,
		  @cmascaux		CHAR (12) ,
		  @cTextDia		CHAR(2)

 /*=======================================================================*/
 /* definici¢n de variables para los instrumentos pdp                     */
 /*=======================================================================*/
 DECLARE @cultdia CHAR (24) ,
  @nanoemi INTEGER  ,
  @nmesemi INTEGER  ,
  @ndiaemi INTEGER

 /*=======================================================================*/
 /* definici¢n de variables para los instrumentos br                      */
 /*=======================================================================*/
 DECLARE @iextrae     INTEGER  ,
  @imesemi     INTEGER  ,
  @ianovto     INTEGER  ,
  @ianoemi     INTEGER  ,
  @imesman     INTEGER  ,
  @cfecven     CHAR (10) ,
  @cfecman     CHAR (10) ,
  @cfecemi     CHAR (10) ,
  @dfecman     DATETIME

 SELECT @dfecpro = acfecproc FROM MDAC
 /*=======================================================================*/
 /* guardar la serie, en este punto, llamar a dbo.sp_nemosinast(cinstser)     */
 /* para lchr-chile.-                                                     */
 /*=======================================================================*/
 SELECT @cinstaux2 = @cinstser
 /*=======================================================================*/
 /* cambio para letras con ''*'' y ''&'' / equivale al mes ( siempre es 01)   */
 /*=======================================================================*/
 IF CHARINDEX('*',@cinstser)<>0
 BEGIN
  SELECT @cinstser = SUBSTRING(@cinstser,1,6)+'01'+SUBSTRING(@cinstser,9,2)
 END

 /*=======================================================================*/
 /* equivale al a¤o                                                       */
 /*=======================================================================*/
 IF CHARINDEX('&',@cinstser)<>0
 BEGIN
  SELECT @nmes = CONVERT(INTEGER,SUBSTRING(@cinstser,9,2))
  SELECT @nmes_a = DATEPART(MONTH,@dfecpro)
  IF @nmes>@nmes_a
  BEGIN
   SELECT @nano = DATEPART(YEAR,@dfecpro)-1
  END
  ELSE
  BEGIN
   SELECT @nano = DATEPART(YEAR,@dfecpro)
  END
  SELECT @cano   = CONVERT(CHAR(04),@nano)
  SELECT @cinstser = SUBSTRING(@cinstser,1,6)+SUBSTRING(@cinstser,9,2)+SUBSTRING(@cano,3,2)
 END
 /*=======================================================================*/
 /* guardar la serie, en este punto, llamar a dbo.sp_nemosinast(cinstser)     */
 /* para lchr-chile.-                                                     */
 /*=======================================================================*/
 SELECT @cinstaux = @cinstser
 SELECT @cmascara = '*'
 SELECT @carchivo = 'SE'  ,
  @cmascara = semascara ,
  @ncodigo = secodigo
 FROM VIEW_SERIE
 WHERE seserie=@cinstser
 IF @cmascara='*'
 BEGIN
  SELECT @cfamilia = '*'
  IF (SUBSTRING(@cinstaux,1,3)='PCD' AND SUBSTRING(@cinstaux,1,6)<>'PCDUS$')
  BEGIN
   SELECT @cfamilia = 'PCDUF'
  END
  ELSE
  BEGIN
   SELECT @j = LEN(@cinstaux)
   WHILE @j<>0
BEGIN
    SELECT @cfamilia = inserie
    FROM VIEW_INSTRUMENTO
    WHERE inserie=SUBSTRING(@cinstaux,1,@j)
    IF @cfamilia<>'*'
    BEGIN
     BREAK
    END
    SELECT @j = @j-1
   END
  END
  IF @cfamilia='*'
  BEGIN
   SELECT @cfamilia = 'LCHR'
  END
  IF (@cfamilia='BR' OR @cfamilia='PRBC' OR @cfamilia='PDBC' OR @cfamilia='DPF' OR @cfamilia='DPD' OR
   @cfamilia='DPR' OR @cfamilia='CERO' OR @cfamilia='ZERO' OR @cfamilia='FMUTUO' OR 
                        @cfamilia='DPXA' OR @cfamilia='DPXB' OR @cfamilia='DPXC' OR @cfamilia='DPXD' OR 
                        @cfamilia='DPXE')
  BEGIN
   SELECT @cmascara = @cfamilia
  END
--select * from view_mascara_instrumento  /*====================================================================*/
  /* buscar en tabla de mascaras por msfamilia para extraer largo util  */
  /* de la serie                 */
  /*====================================================================*/
  SET ROWCOUNT 1
  SELECT @nlutil  = LEN(LTRIM(RTRIM(msmascara))) ,
   @nlutiling = LEN(LTRIM(RTRIM(msnemo)))
  FROM VIEW_MASCARA_INSTRUMENTO
  WHERE msfamilia=@cfamilia
  SET ROWCOUNT 0
  /*====================================================================*/
  /* buscar en archivo de series.                                       */
  /*====================================================================*/
  SELECT @cmascaux = @cmascara
  SELECT @cmascara = '*'
  SELECT @carchivo = 'SE',
   @cmascara = semascara ,
   @ncodigo = secodigo
  FROM VIEW_SERIE
  WHERE seserie=SUBSTRING(@cinstaux,1,@nlutil)
  IF @nlutiling<>LEN(RTRIM(LTRIM(@cinstser)))
  BEGIN
   SELECT 'ERROR' = 15 ,
    'DESC' = 'NEMOTECNICO INGRESADO INCOMPLETAMENTE'
   SET NOCOUNT OFF
   SELECT 'ERR'
   RETURN 15
  END
 END
 IF @cmascara='*'
 BEGIN
  SELECT @carchivo = 'IN'
 END
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
   SET NOCOUNT OFF
   SELECT 'ERROR' = 9
   RETURN 9
  END
 END
 /*=======================================================================*/
 /* el instrumento esta definido en la tabla serie.                       */
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
  WHERE inserie=@cmascaux
  /*====================================================================*/
  /* existe la mascara pero no esta en instrumento                      */
  /*====================================================================*/
  IF @ncodigo=0
  BEGIN
   SET NOCOUNT OFF
 SELECT 'ERROR' = 8
 RETURN 8
 END
 END
 /*=======================================================================*/
 /* problemas para el chequeo de la familia.                */
 /*=======================================================================*/
 IF @cfamilia=NULL
 BEGIN
  SET NOCOUNT OFF
  SELECT 'ERROR' = 12
  RETURN 12
 END
 IF @cfamilia='PTF'
 BEGIN
  IF @ndiavcup < 10  SELECT @cTextDia = '0'+ CONVERT(CHAR(1),@ndiavcup)
  ELSE   SELECT @cTextDia = CONVERT(CHAR(2),@ndiavcup)
  SELECT @dfecemi = CONVERT(DATETIME,SUBSTRING(@cinstaux,9,2)+SUBSTRING(@cinstaux,7,2)+@cTextDia)
  SELECT @dfecven = DATEADD(MONTH,(@ncupones*@npervcup),@dfecemi)
  IF @dfecemi=NULL OR @dfecven=NULL
  BEGIN
   SET NOCOUNT OFF
   SELECT 'ERROR' = 9
   RETURN 9
  END
 END
 ELSE
  IF @cfamilia='DPF' OR @cfamilia='DPR' OR @cfamilia='DPD' OR @cfamilia='PDBC' OR @cfamilia='PRBC' OR
  @cfamilia='CERO' OR @cfamilia='ZERO' OR @cfamilia='DPXA' OR @cfamilia='DPXB' OR @cfamilia='DPXC' OR 
  @cfamilia='DPXD' OR @cfamilia='DPXE'
  BEGIN
   SELECT @dfecemi = @dfecpro
   SELECT @dfecven = CONVERT(DATETIME, (CASE WHEN SUBSTRING(@cinstaux,9,2) <= 50 THEN '20' ELSE '19' END) + SUBSTRING(@cinstaux,9,2)+SUBSTRING(@cinstaux,7,2)+SUBSTRING(@cinstaux,5,2))
--SELECT @dfecven
   IF @cFamilia='DPXC'
   BEGIN
    IF DATEDIFF(DAY,@dfecpro,@dfecven)>180
    BEGIN
      SET NOCOUNT OFF
     SELECT 'ERROR' = 30
     RETURN 30
    END
   END
   IF @cFamilia='DPXD'
   BEGIN
    IF DATEDIFF(DAY,@dfecpro,@dfecven)<=180
    BEGIN
      SET NOCOUNT OFF
     SELECT 'ERROR' = 31
     RETURN 31
    END
   END
  /*=======================================================================*/
  /* determina fecha de emisi¢n / vencimiento.                             */
  /*=======================================================================*/
  END
  ELSE
  BEGIN
   EXECUTE @nerror = dbo.sp_Fecemiven @carchivo ,
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
   /* devuelve errores desde ''sp_fecemiven''                              */
   /*====================================================================*/
   IF @nerrOR<>0 OR @@error<>0
   BEGIN
    SET NOCOUNT OFF
    SELECT 'ERROR' = @nerror
    RETURN @nerror
   END
  END
  /*=======================================================================*/
  /* generico del emisor.                                                  */
  /*=======================================================================*/
  SELECT @cgenemi = emgeneric FROM VIEW_EMISOR WHERE emrut=@nrutemi
  IF @@ROWCOUNT=0
  BEGIN
   SELECT @cgenemi = '?????'
  END
  /*=======================================================================*/ 
  /* nemotecnico de la moneda.                                             */
  /*=======================================================================*/
  SELECT @cnemmon = mnnemo FROM VIEW_MONEDA WHERE mncodmon=@nmonemi
  IF @@ROWCOUNT=0
  BEGIN
   SELECT @cnemmon = '?????'
  END
  /*=======================================================================*/
  /* generar mascara de lectura de datos de emision.                       */
  /*=======================================================================*/
  SELECT @clecemi = 'NNNNNN'
  IF @nrutemi=0
   SELECT @clecemi = 'S'
  IF @nmonemi=0
   SELECT @clecemi = 'S'
  IF @ftasemi=0.0 AND @cfamilia<>'PCDUF' AND @cfamilia<>'PCDUS$' AND @cfamilia<>'PRBC' AND @cfamilia<>'PDBC' AND
     @cfamilia<>'DPR' AND @cfamilia<>'DPF' AND @cfamilia<>'DPX' AND @cfamilia<>'ECP' AND @cfamilia<>'ECU' AND @cfamilia<>'CERO'  AND @cfamilia<>'ZERO' 
   SELECT @clecemi = 'S'
  IF @nbasemi=0
   SELECT @clecemi = 'S'
  /*=======================================================================*/
  /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - lchr       */
  /*=======================================================================*/
  IF @cfamilia='LCHR'
  BEGIN
   SELECT @dfecemi = CONVERT(DATETIME,SUBSTRING(@cinstaux,9,2)+SUBSTRING(@cinstaux,7,2)+'01')
   SELECT @dfecven = DATEADD(MONTH,(@ncupones*@npervcup),@dfecemi)
  END
  /*=======================================================================*/
  /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - pcduf      */
  /*=======================================================================*/
  IF @cfamilia='PCDUF'
  BEGIN
   SELECT @dfecemi = CONVERT(DATETIME,SUBSTRING(@cinstaux,9,2)+SUBSTRING(@cinstaux,7,2)+SUBSTRING(@cinstaux,5,2))
   SELECT @dfecven = DATEADD(MONTH,(@ncupones*@npervcup),@dfecemi)
  END
  /*=======================================================================*/
  /* c lculo de fechas emisi¢n y vcto. para papeles no unicos - pdp        */
  /*=======================================================================*/
  IF @cfamilia='PDP'
  BEGIN
   SELECT @cultdia = '312831303130313130313031'
   SELECT @nanoemi = CONVERT(INTEGER,'19'+SUBSTRING(@cinstaux,9,2))
   SELECT @nmesemi = CONVERT(INTEGER,SUBSTRING(@cinstaux,7,2))
   IF @nmesemi=2 AND (@nanoemi % 4)=0
   BEGIN
    SELECT @ndiaemi = 29
   END
   ELSE
   BEGIN
    SELECT @ndiaemi = CONVERT(INTEGER,SUBSTRING(@cultdia,@nmesemi*2-1,2))
  END
  SELECT @dfecemi = CONVERT(DATETIME,CONVERT(VARCHAR(4),@nanoemi)+CONVERT(VARCHAR(2),@nmesemi)+CONVERT(CHAR(2),@ndiaemi))
  SELECT @dfecven = DATEADD(MONTH,(@ncupones*@npervcup),DATEADD(DAY,DATEPART(DAY,@dfecemi)*-1,@dfecemi))
 END
 /*=======================================================================*/
 /* Calculo de fechas emisi¢n y vcto. para papeles no unicos - br         */
 /*=======================================================================*/
 IF @cfamilia='BR'
 BEGIN
  SELECT @iExtrae = ASCII(SUBSTRING(@cInstser,3,1))
  SELECT @iMesemi = CASE WHEN @iExtrae=48 THEN CONVERT(INT,CHAR(@iExtrae))+10
      WHEN @iExtrae>48 AND @iExtrae<58 THEN CONVERT(INT,CHAR(@iExtrae))
      ELSE CONVERT(INT,@iExtrae)-54
     END
  IF @iMesemi>12
  BEGIN
   SELECT 1, 'Serie Mal Ingresada'
   RETURN
  END
  SELECT @iExtrae = ASCII(SUBSTRING(@cInstser,4,1))
  SELECT @iAnoemi = 1980 + CASE WHEN @iExtrae=48 THEN CONVERT(INT,CHAR(@iExtrae))+10
       WHEN @iExtrae>48 AND @iExtrae<58 THEN CONVERT(INT,CHAR(@iExtrae))
       ELSE CONVERT(INT,@iExtrae)-54
       END
  SELECT @iAnovto = CONVERT(INT,SUBSTRING(@cInstser,9,2))
  IF @iAnovto>=0 AND @iAnovto<95
   SELECT @iAnovto = 2000 + @iAnovto
  ELSE
   SELECT @iAnovto = 1900 + @iAnovto
  SELECT @iMesman = DATEPART(DAY,@dFecpro)*-1
  DECLARE @cMesemi CHAR (02)
  IF @iMesemi<10
   SELECT @cMesemi = '0'+CONVERT(CHAR(02),@iMesemi)
  ELSE
   SELECT @cMesemi = CONVERT(CHAR(02),@iMesemi)
  SELECT @cFecven = CONVERT(CHAR(04),@iAnovto)+SUBSTRING(@cInstser,7,2)+SUBSTRING(@cInstser,5,2)
  SELECT @cFecemi = CONVERT(CHAR(04),@iAnoemi)+@cMesemi+'01'
  SELECT @cFecman = CONVERT(CHAR(8),DATEADD(DAY,@iMesman,@dFecpro),112)
  SELECT @dFecman = SUBSTRING(@cFecman,1,4)+SUBSTRING(@cFecman,5,2)+'01'
  SELECT @dFecemi = CONVERT(DATETIME,@cFecemi)
  SELECT @dFecven = CONVERT(DATETIME,@cFecven)
 END
 IF @dfecemi=NULL
  SELECT @dfecemi = @dfecpro
 IF @dfecemi>@dfecpro
 BEGIN
  SELECT @nerror = 12
 END
 IF @dfecven=NULL
 BEGIN
  SELECT @cfecaux = SUBSTRING(@cinstser,5,6)
  EXECUTE @nerror  = dbo.sp_EsFecDma @cfecaux, @dfecven OUTPUT
 END
 IF @dfecven<=@dfecpro
 BEGIN
  SELECT @nerror = 11
 END
 SELECT 'ERROR'  = ISNULL(@nerror,0)   ,
  'mascara' = @cinstaux2    ,
  'codigo' = @ncodigo    ,
  'serie'  = @cserie    ,
  'rutemi' = @nrutemi    ,
  'monemi' = @nmonemi    ,
  'tasemi' = @ftasemi    ,
  'basemi' = @nbasemi    ,
  'fecemi' = CONVERT(CHAR(10),@dfecemi,103) ,
  'fecven' = CONVERT(CHAR(10),@dfecven,103) ,

  'refnomi' = @crefnomi    ,
  'genemi' = @cgenemi    ,
  'nemmon' = @cnemmon    ,
  'corte'  = @ncorte    ,
  'seriado' = @cseriado    ,
  'lecemi' = @clecemi    ,
  'fecpro' = CONVERT(CHAR(10),@dfecpro,103)
 INTO #PASO_SERIE

	SET @Monemis = @nmonemi

 SET NOCOUNT OFF
-- SELECT ''OK''
 RETURN 0
END
--sp_chkinstser ''BOT65D &11''


GO
