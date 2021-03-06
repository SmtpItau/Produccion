USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGO_INTERBANCARIOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DEVENGO_INTERBANCARIOS] 
   (
   @dfechoy DATETIME ,
   @dfecprox DATETIME ,
   @devengo_dolar CHAR (01)
   )
AS
BEGIN
 SET NOCOUNT ON 
 DECLARE @modcal  INTEGER  ,
  @ncodigo INTEGER  ,
  @cmascara CHAR (10) ,
  @nmonemi INTEGER  ,
  @cfecemi CHAR (10) ,
  @cfecven CHAR (10)    ,
  @ftasemi FLOAT  ,
  @fbasemi FLOAT  ,
  @ftasest FLOAT  ,
  @fnominal FLOAT  ,
  @ftir  FLOAT  ,
  @fpvp  FLOAT  ,
  @fmt  FLOAT  ,
  @fmtum  FLOAT  ,
  @fmt_cien FLOAT  ,
  @fvan  FLOAT  ,
  @fvpar  FLOAT  ,
  @fvpar2  FLOAT  ,
  @nnumucup INTEGER  ,
  @dfecucup DATETIME ,
  @fintucup FLOAT  ,
  @famoucup FLOAT  ,
  @fsalucup FLOAT  ,
  @nnumpcup INTEGER  ,
  @dfecpcup DATETIME ,
  @fintpcup FLOAT  ,
  @famopcup FLOAT  ,
  @fsalpcup FLOAT  ,
  @nerror  INTEGER  ,
  @cprog  CHAR (10) ,
  @fdurat  FLOAT  ,
  @fconvx  FLOAT  ,
  @fdurmo  FLOAT  ,
  @nintmes  FLOAT  ,
  @nreames FLOAT  
 DECLARE @dfecemi DATETIME ,
  @dfecven DATETIME ,
  @dfecinip DATETIME ,
  @dfecvtop DATETIME ,
  @cinstser CHAR (10) ,
  @cinstorg CHAR (10) ,
  @cseriado CHAR (01) ,
  @ctipopero CHAR(03) ,
  @nrutcart NUMERIC (09,0) ,
  @ntipcart NUMERIC (03,0) ,
  @nrutclip NUMERIC (09,0) ,
  @nrutcli NUMERIC (09,0) ,
  @nrutemi NUMERIC (09,0) ,
  @nnumdocu NUMERIC (10,0) ,
  @ncorrela NUMERIC (03,0) ,
  @nnumoper NUMERIC (10,0) ,
  @fvpresen NUMERIC (19,4) ,
  @nvalmon_h FLOAT  ,
  @nvalmon_m FLOAT  ,
  @nvalmon_o FLOAT  ,
  @fvalcomu FLOAT  ,
  @fvalcupo FLOAT  ,
  @fintcupo FLOAT  ,
  @famocupo FLOAT  ,
  @dfeccomp DATETIME ,
  @dfpxreal DATETIME ,
  @dfecoriginal DATETIME ,
  @bcupon  INTEGER  ,
  @ffactor FLOAT  ,
  @nvalmon_c FLOAT  ,
  @nvalmon_i FLOAT  ,
  @nmoncupon FLOAT  ,
  @fcapital FLOAT  ,
  @nnumcupant INTEGER  ,
  @fcapital_um FLOAT  ,
  @ninterpacto NUMERIC (19,0) ,
  @ctipoper CHAR (02) ,
  @nvpresenci NUMERIC (19,0) ,
  @ninterpactoci NUMERIC (19,0) ,
  @nreajpactoci NUMERIC (19,0) ,
  @ntaspactoci NUMERIC (08,4) ,
  @nmonpactoci INTEGER  ,
  @nbaspactoci INTEGER  ,
  @ninteres NUMERIC (19,4) ,
  @nreajuste NUMERIC (19,4),
  @nintdia NUMERIC (19,4) ,
  @nreadia NUMERIC (19,4) ,
  @nvalinip NUMERIC (19,4) ,
  @nbaspacto INTEGER  ,
  @ntaspacto NUMERIC (08,4) ,
  @nvpresen NUMERIC (19,4) ,
  @nmonpacto INTEGER  ,
  @nreajpacto NUMERIC (19,4) ,
  @nbasemi INTEGER  ,
  @ntasemi NUMERIC (08,4) ,
  @nreacup NUMERIC (19,4) ,
  @nintcup NUMERIC (19,4) ,
  @ndifcup NUMERIC (19,4) ,
  @npagcup NUMERIC (19,4) ,
  @npagcupo NUMERIC (19,4) ,
  @pago_nohabil INTEGER  ,
  @nmes  INTEGER  ,
  @ndia  INTEGER  ,
  @nano  INTEGER  ,
  @nmes_a  INTEGER  ,
  @nast  INTEGER  ,
  @cmes  CHAR (02) ,
  @cdia  CHAR (02) ,
  @cano  CHAR (04) ,
  @nuf  INTEGER  ,
  @nivp  INTEGER  ,
  @ndo  INTEGER  ,
  @ndifreacup NUMERIC(19,0) ,
  @ncodcli NUMERIC(09,0) ,
  @nvpresen1 NUMERIC(19,4),
  @cmx  CHAR (01) ,
  @id_libro	CHAR(06)

 DECLARE @cestado  CHAR(02)  ,  
  @cmensa    varCHAR(255) ,
  @redondeo  NUMERIC(1) ,
  @ndecimal  NUMERIC(2),
  @redondeo1 NUMERIC(1) 
 
 DECLARE @sw_contab CHAR (01) ,
  @sw_deven CHAR (01) ,
  @x1  INTEGER  ,
  @contador INTEGER  ,
  @nvalcomp NUMERIC (19,4) ,
  @nnominal NUMERIC (19,4) ,
  @ccartera CHAR (03) ,
  @nForpagv NUMERIC (04,0) ,
  @nforpagi NUMERIC (04,0) ,
  @nmonib  NUMERIC (19,4)  ,
  @fecdevengo     DATETIME ,
  @nValorpara FLOAT 
-- IF @devengo_dolar='S'
--  SELECT @fecdevengo = @dfecprox
-- ELSE
 SELECT @fecdevengo = @dfechoy
 UPDATE MDAC SET acsw_pc='1'
 SELECT @sw_contab = acsw_co ,
  @sw_deven = acsw_dvib ,
  @dfpxreal = acfecprox
 FROM MDAC
 --** variables chequeo fin de mes no hÿbil **--
 SELECT @x1  = 0  ,
  @nmes  = 0  ,
  @ndia  = 0  ,
  @cmes  = ''  ,
  @cdia  = ''
 --** se realiza la validaci¢n de las monedas necesarias para procesar devengamiento
 WHILE @x1<=DATEDIFF(DAY,@dfechoy,@dfecprox)
 BEGIN
  SELECT @nValorpara = 0.0
  IF @devengo_dolar='N'
  BEGIN
   SELECT @nValorpara = vmvalor FROM VIEW_Valor_MONEDA WHERE  vmcodigo=998 AND vmfecha=DATEADD(DAY,@x1,@dfechoy)
   IF @nValorpara IS NULL OR @nValorpara=0.0
   BEGIN
    SELECT 'NO', 'Valor U.F. '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
    RETURN
   END
 
   SELECT @nValorpara = vmvalor FROM VIEW_Valor_MONEDA WHERE vmcodigo=997 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
   IF @nValorpara IS NULL OR @nValorpara = 0.0
   BEGIN
    SELECT 'NO', 'Valor I.V.P. '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
    RETURN
   END
  END
  IF @devengo_dolar='S'
  BEGIN
   SELECT @nValorpara = vmvalor FROM VIEW_Valor_MONEDA WHERE vmcodigo=994 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
   IF @nValorpara IS NULL OR @nValorpara=0.0
   BEGIN
    SELECT 'NO', 'Valor Dolar '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
    RETURN
   END
  END
  SELECT @x1 = @x1 + DATEDIFF(DAY,@dfechoy,@dfecprox)
 END
 SELECT @nmonemi = 0  ,
  @dfecemi = ''  ,
  @dfecven = ''  ,
  @ftasemi = 0.0  ,
  @fbasemi = 0  ,
  @ftasest = 0.0  ,
  @fnominal = 0.0  ,
  @ftir  = 0.0  ,
  @fpvp  = 0.0  ,
  @fmt  = 0.0000  ,
  @fmtum  = 0.0  ,
  @fmt_cien = 0.0  ,
  @fvan  = 0.0  ,
  @fvpar  = 0.0  ,
  @fvpar2  = 0.0  ,
  @nnumucup = 0.0  ,
  @dfecucup = ''  ,
  @fintucup = 0.0  ,
  @famoucup = 0.0  ,
  @fsalucup = 0.0  ,
  @nnumpcup = 0.0  ,
  @dfecpcup = ''  ,
  @fintpcup = 0.0  ,
  @famopcup = 0.0  ,
  @fsalpcup = 0.0  ,
  @nerror  = 0  ,
  @cprog  = ''  ,
  @nvalcomp = 0.0,
  @redondeo = 0,
  @redondeo1 = 0
 IF @devengo_dolar='N' 
 BEGIN
  DELETE MDRS WHERE rstipopero='IB' AND rsfecha=@dfecprox
  IF @@error<>0
  BEGIN
   SELECT 'NO', 'Problemas en Borrado de MDRS'
   RETURN
  END
 END
 ELSE
 BEGIN
  DELETE MDRS WHERE rstipopero='IB' AND rsfecha=@dfecprox AND ( rsmonpact=994 OR rsmonpact=995 OR rsmonpact=988 )
  IF @@error<>0
  BEGIN
   SELECT 'NO', 'Problemas en Borrado de MDRS'
   RETURN
  END
 END
 UPDATE MDAC SET acsw_dv='1'
 -- D e v e n g a m i e n t o    I n t e r b a n c a r i o s   --
 -- _________________________________________________________________
 SELECT @x1  = 1   ,
  @contador = 0   ,
  @cinstser = ''   ,
  @ninteres = 0.0   ,
  @nreajuste = 0.0   ,
  @nmonemi = 0.0   ,
  @nbasemi = 0.0   ,
  @ftasemi = 0.0   ,
  @nnumdocu = 0.0   ,
  @ncorrela = 0.0   ,
  @dfecven = ''   ,
  @nvalcomp = 0.0   ,
  @fvalcomu = 0.0   ,
  @nnominal = 0.0   ,
  @fvpresen = 0.0   ,
  @nmonib  = 0.0,
  @redondeo = 0,
  @redondeo1 = 0
 SELECT  @contador =  COUNT(*) FROM MDCI WHERE cimascara='ICAP' OR cimascara='ICOL'
 WHILE @x1<=@contador
 BEGIN
  SELECT @cinstser='*'
  SET ROWCOUNT @x1
  SELECT  @cinstser = cimascara  ,
   @nmonemi = cimonpact  ,
   @nbasemi = cibaspact  ,
   @ftasemi = citaspact  ,
   @nrutcart = cirutcart  ,
   @nnumdocu = cinumdocu  ,
   @ncorrela = cicorrela  ,
   @dfecven = cifecvenp  ,
   @nvalinip = ISNULL(civalcomp,0) ,
   @nvalcomp = civalcomp  ,
   @fvalcomu = civalcomu  ,
   @nnominal = civalvenp  ,
   @nvpresen = ISNULL(civptirci,0) ,
   @fvpresen = ISNULL(civptirc,0) ,
   @nrutclip = cirutcli  ,
   @ncodcli = cicodcli  ,
   @ntipcart = citipcart  ,
   @dfecinip = cifecinip  ,
   @ncodigo = cicodigo  ,
   @ninteres = ISNULL(ciinteresc,0) ,
   @nreajuste = ISNULL(cireajustc,0) ,
   @nforpagv = ciforpagv  ,
   @nforpagi = ciforpagi  ,
   @nmonib  = ISNULL(cinominalp,0) ,
   @nintmes = ciintermes  ,
   @nreames = cireajumes  ,
   @fnominal = cinominal  ,
   @dfeccomp = cifeccomp  ,
   @nvpresen1      = cicapitalc+ciinteresc+cireajustc,
   @ndecimal  = mndecimal,
   @redondeo1 = mndecimal	,
   @id_libro	= id_libro
  FROM MDCI, view_moneda
  WHERE (cimascara='ICAP' OR cimascara='ICOL') and cimonpact=mncodmon
  SET ROWCOUNT 0

                SELECT @x1 = @x1 + 1
                /* dolares existentes =================================================== */
                /* 994 : dolar observado                      */
        /* 995 : dolar acuerdo             */
                /* 996 : dolar interbancario                                              */
                /* ====================================================================== */
                IF @devengo_dolar='S'
                BEGIN
   IF @nmonemi<>994 AND @nmonemi<>995 AND @nmonemi<>988
    CONTINUE
  END
                ELSE
               BEGIN
   IF @nmonemi=994 OR @nmonemi=995 OR @nmonemi=988
    CONTINUE
  END

  IF @nmonemi=994 or @nmonemi= 999 or @nmonemi=998 
     BEGIN
          SELECT @redondeo = 0
  END ELSE BEGIN
	  SELECT @redondeo = @ndecimal
  END

  IF @cinstser='*'
   BREAK

   SELECT @nvalmon_h = 1.0 ,
   @nvalmon_m = 1.0 ,
   @nvalmon_c = 1.0 ,
   @nreadia = 0.0 ,
   @nintdia = 0.0

  IF @nrutclip=97029000
   SELECT @ccartera='130'
  ELSE
   SELECT @ccartera='121'

  SELECT @cmx = (CASE WHEN MNMX = 'C' THEN 'S' ELSE 'N' END) FROM VIEW_MONEDA WHERE MNCODMON = @nmonemi

  IF @nmonemi<>999 AND @cmx<>'S'
  BEGIN
   SELECT @nvalmon_h=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@dfechoy
   SELECT @nvalmon_m=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@dfecprox
   SELECT @nvalmon_c=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonemi AND vmfecha=@dfecinip
  END

  IF DATEDIFF(MONTH,@dfechoy,@dfecprox)>0
   SELECT @nintmes = 0.0 ,
          @nreames = 0.0

  IF @dfechoy=@dfecinip
   SELECT @fvpresen = @nvalcomp

  SELECT  @nValinip  = Round(@nvalinip/@nvalmon_c , 4)

  SELECT @fmt    = ROUND(@nvalinip*(((@ftasemi/(@nbasemi*100.0))*DATEDIFF(DAY,@dfecinip,@dfecprox))+1.0),@redondeo1)

  --SELECT @fMt    = @nNominal/(1.0+(@fTasemi/@nBasemi)*DATEDIFF(DAY,@dFecprox,@dFecven)/100.00)
 
  SELECT @fMt = ROUND(@fMt*@nvalmon_m, @redondeo)
  SELECT @nreadia   = ROUND((@nvalmon_m-@nvalmon_h)*@nvalinip,@redondeo)
  SELECT @nintdia   = ROUND(@fMt - @nvpresen1 - @nreadia,@redondeo)

  SELECT @ninteres  = @ninteres  + @nintdia
  SELECT @nreajuste = @nreajuste + @nreadia
  SELECT @nintmes   = @nintmes  + @nintdia
  SELECT @nreames   = @nreames  + @nreadia

  INSERT INTO MDRS
    (
    rsfecha  , --1
    rsrutcart , --2
    rstipcart , --3
    rsnumdocu , --4
    rscorrela , --5
    rsnumoper , --6
    rscartera , --7
    rstipoper , --8
    rsrutcli , --9
    rscodcli , --10
    rsinstser , --11 
    rsvppresen , --12
    rsvppresenx , --13
    rscupamo , --14
    rscupint , --15
    rsflujo  , --16
    rsfecprox , --17
    rsfecctb , --18
    rsnominal , --19
    rstir  , --20
    rstasfloat , --21
    rsmonemi , --22
    rsmonpact , --23
    rstasemi , --24
    rsbasemi , --25
    rscodigo , --26
    rsinteres , --27
    rsreajuste , --28
    rsintermes , --29
    rsreajumes , --30
    rsinteres_acum , --31  
    rsreajuste_acum , --32  
    rsforpagv , --33
    rsvalcomp , --34
    rsvalcomu , --35
    rsvalvenc , --36
    rsvpcomp , --37
    rstipopero , --38 
    rsfeccomp , --40
    rsfecpcup , --41
    rsforpagi , --42
    rsfecinip , --43
    rsfecvtop , --44
    rsid_libro
    )
  VALUES
    (
    @dfecprox ,
    @nrutcart ,
    @ntipcart ,
    @nnumdocu ,
    @ncorrela ,
    @nnumdocu ,
    @ccartera ,
    'DEV'  ,
    @nrutclip ,
    @ncodcli ,
    @cinstser ,
    @nvpresen ,
    @fmt  ,
    0.0  ,
    @nmonib   ,
    @nmonib   ,
    @dfecprox ,
    @dfechoy ,
    @fnominal ,
    @ftasemi ,
    0.0  ,
    @nmonemi ,
    @nmonemi ,
    @ftasemi ,
    @nbasemi ,
    @ncodigo ,
    @nintdia ,
    @nreadia ,
    @nintmes , -- interes del mes   -- 29
    @nreames , -- reajuste del mes --30
    @ninteres ,   --31
    @nreajuste ,   --32
    @nforpagv ,   --33
    @nvalcomp , -- valcomp  --34
    0.0  , -- valcomu  --35
    0.0  , -- valvenc  --36
    0.0  , -- vpcomp  --37
    'IB'  ,   --38
    @dfeccomp ,   --39
    @dfecven ,   --40
    @nforpagi ,   --41
    @dFecinip ,   --42
    @dFecven  ,
    @id_libro
    )
  IF @@error<>0
  BEGIN
--   ROLLBACK TRANSACTION
   SELECT 'NO','Devengamiento ha fallado en grabacion de Interbancario'
   RETURN
  END

  IF @dfecven<=@dfecprox
   INSERT INTO MDRS
     (
     rsfecha  ,
     rsrutcart ,
     rstipcart ,
     rsnumdocu ,
     rscorrela ,
     rsnumoper ,
     rscartera ,
     rstipoper ,
     rsrutcli ,
     rscodcli ,
     rsinstser ,
     rsvppresen ,
     rsvppresenx ,
     rscupamo ,
     rscupint ,
--     rscuprea ,
     rscuprea ,
     rsflujo  ,
     rsfecprox ,
     rsfecctb ,
     rsnominal ,
     rstir  ,
     rstasfloat ,
     rsmonemi ,
     rsmonpact ,
     rstasemi ,
     rsbasemi ,
     rscodigo ,
     rsinteres ,
     rsreajuste ,
     rsintermes ,
     rsreajumes ,
     rsinteres_acum ,
     rsreajuste_acum ,
     rsforpagv ,
     rsvalcomp ,
     rsvalcomu ,
     rsvalvenc ,
     rsvpcomp ,
     rstipopero ,
     rsfeccomp ,
     rsforpagi ,
     rsfecinip ,
     rsfecvtop ,
     rsid_libro
     )
   VALUES
     (
     @dfecprox ,
     @nrutcart ,
     @ntipcart ,
     @nnumdocu ,
     @ncorrela ,
     @nnumdocu ,
     @ccartera ,
     'VC'  ,
     @nrutclip ,
     @ncodcli ,
     @cinstser ,
     @nvalcomp ,
     @nvalcomp+@ninteres+@nreajuste ,
     @nvalcomp ,
     @ninteres ,
     @nReajuste ,
--     @nReajuste ,
     @nvalcomp+@ninteres+@nreajuste ,
                                 @dfecprox ,
     @dfechoy ,
     @fnominal ,
     @ftasemi ,
     0.0  ,
     @nmonemi ,
     @nmonemi ,
     @ftasemi ,
     @nbasemi ,
     @ncodigo ,
     @ninteres , -- interes del día
     @nreajuste , -- reajuste del día
     @nintmes , -- interes del mes
     @nreames , -- reajuste del mes
     @ninteres , -- int acum 
     @nreajuste , -- rea acum     
     @nforpagv ,
     @nvalcomp , -- valcomp
     0.0  , -- valcomu
     0.0  , -- valvenc
     0.0  , -- vpcomp
     'IB'  ,
     @dfeccomp ,
     @nforpagi ,
     @dFecinip , --42
     @dFecven  ,
     @id_libro
     )

   IF @devengo_dolar='N'
	BEGIN
	  IF DATEDIFF(MONTH,@fecdevengo,@dfecprox)=0 and DATEDIFF(MONTH,@fecdevengo,@dfpxreal)>0
	  BEGIN
		UPDATE MDCI SET ciinteresc = @ninteres,
				cireajustc = @nreajuste,
  				civptirci  = @nvalcomp+@ninteres+@nreajuste  ,
  				civptirc   = @nvalcomp+@ninteres+@nreajuste  ,
  				cicapitalc = @nvalcomp  ,
  				ciintermes = @nintmes  ,
  				cireajumes = @nreames
		WHERE  cirutcart=@nrutcart AND cinumdocu=@nnumdocu AND cicorrela=@ncorrela
	  END
	END


/* */
	EXECUTE bactradersuda.dbo.SP_LLENA_RES_TCKRTAFIJA   @dfechoy ,   @dfecprox ,   @devengo_dolar 
/* */

   IF @@error<>0
   BEGIN
--    ROLLBACK TRANSACTION
    SELECT 'NO','Devengamiento ha fallado en grabación de Interbancario'
    RETURN
   END
 END
 IF @devengo_dolar='N'
  UPDATE MDAC SET acsw_dvib='1'
 SELECT 'OK','Proceso de Devengamiento ha finalizado en forma correcta'

 RETURN
END 

GO
