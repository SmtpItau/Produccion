USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECOMPRA_AUTOMATICA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RECOMPRA_AUTOMATICA]
       (
        @user           CHAR(12),
        @terminal       CHAR(12)
       ) WITH RECOMPILE
AS
BEGIN

   /*===========================================================================================*/
   /*===========================================================================================*/
   SET nocount on 

   DECLARE @Operacion   NUMERIC(10,0)
   DECLARE @dFeccal     DATETIME
   DECLARE @x           INTEGER
   DECLARE @xx          INTEGER
   DECLARE @xcort       INTEGER
   DECLARE @suma        INTEGER
   DECLARE @nRutcart    NUMERIC( 9,0)
   DECLARE @nNumdocu    NUMERIC(10,0)
   DECLARE @nCorrela    NUMERIC(03,0)
   DECLARE @nNumoper    NUMERIC(10,0)
   DECLARE @ctipoper    CHAR(03)
   DECLARE @Inid        CHAR(01)
   DECLARE @numoper     NUMERIC(10,0)
   DECLARE @nominal     NUMERIC(19,4)
   DECLARE @vptirc      NUMERIC(19,4)
   DECLARE @interesc    NUMERIC(19,4)
   DECLARE @reajustec   NUMERIC(19,4)
   DECLARE @valcomu     NUMERIC(19,4)
   DECLARE @valcomp     NUMERIC(19,4)
   DECLARE @cod_ser     NUMERIC(03,0)
   DECLARE @monemi      NUMERIC(05,0)
   DECLARE @tasemi      NUMERIC(19,4)
   DECLARE @basemi      NUMERIC(03,0)
   DECLARE @rutemi      NUMERIC(09,0)
   DECLARE @nNominalp   NUMERIC(19,4)
   DECLARE @mdse        CHAR(01)
   DECLARE @fecpcup     DATETIME
   DECLARE @valcompori  NUMERIC(19,4)
   DECLARE @nCantCort   NUMERIC(19,4)
   DECLARE @nMontCort   NUMERIC(19,4)
   DECLARE @cMascara    CHAR(10)
   DECLARE @cInstser    CHAR(10)
   DECLARE @ntotalreg   NUMERIC(10,0)      

   /*===========================================================================================*/
   /*===========================================================================================*/
   SELECT @x         = 1
   SELECT @xx        = 1
   SELECT @xcort     = 2
   SELECT @suma      = 0
   SELECT @numoper   = 0
   SELECT @nNominalp = 0

   /*===========================================================================================*/
   /*===========================================================================================*/
   CREATE TABLE #TMP
          (
           rutcart    NUMERIC(09,0)         NOT NULL,
           numdocu    NUMERIC(10,0)         NOT NULL,
           correla    NUMERIC(03,0)         NOT NULL,
           tipoper    CHAR(03)              NOT NULL,
           numoper    NUMERIC(10,0)         NOT NULL,
           nominal    NUMERIC(19,4)         NOT NULL,
           vptirc     NUMERIC(19,4)         NOT NULL,
           interesc   NUMERIC(19,4)         NOT NULL,
           reajustec  NUMERIC(19,4)         NOT NULL,
           valcomu    NUMERIC(19,4)         NOT NULL,
           valcomp    NUMERIC(19,4)         NOT NULL,
           nominalp   NUMERIC(19,4)         NOT NULL,
           fecpcup    DATETIME              NOT NULL,
           valcompori NUMERIC(19,4)         NOT NULL,
           mascara    CHAR(10)              NOT NULL,
           registro   INTEGER IDENTITY(1,1) NOT NULL
          )

   /*===========================================================================================*/
   /*===========================================================================================*/
   CREATE TABLE #TMP2
          (
           numdocu    NUMERIC(10,0)         NOT NULL,           correla    NUMERIC(03,0)         NOT NULL,
           cantidad   NUMERIC(19,4)         NOT NULL,
           monto      NUMERIC(19,4)         NOT NULL,
           instser    CHAR(10)              NOT NULL,
           registro   INTEGER IDENTITY(1,1) NOT NULL
          )

   /*===========================================================================================*/
   /*===========================================================================================*/
   SELECT       @dFeccal = acfecproc
          FROM  MDAC
   /*===========================================================================================*/
   /*===========================================================================================*/
   INSERT INTO #TMP
          SELECT          virutcart,
                          vinumdocu,
                          vicorrela,
                          vitipoper,
                          vinumoper,
                          vinominal,
                          vivptirc,
                          viinteresv,
                          vireajustv,
                          vivalcomu,
                          vivalcomp,
                          vinominalp,
                          vifecpcup,
                          vivcompori,
                          vimascara
                 FROM     MDVI
                 WHERE    @dFeccal >= vifecvenp
                 ORDER BY vinumoper

   /*===========================================================================================*/
   /*===========================================================================================*/
   IF (SELECT COUNT(*) FROM #TMP)=0 BEGIN
      SELECT 'Estado' = 'SI',
             'msg'    = 'No existen Operaciones para Recomprar '
      UPDATE MDAC SET acsw_rc = '1'	,
			acsw_dvprop	= '0'	,
			acsw_dvci	= '0'	,
			acsw_dvvi	= '0'	,
			acsw_dvib	= '0'
      SET nocount off 
      RETURN

   END

   /*===========================================================================================*/
   /*===========================================================================================*/
--   BEGIN TRANSACTION

   /*===========================================================================================*/
   /*===========================================================================================*/
   WHILE @x = 1 BEGIN
      SELECT   @ctipoper   = '*'

      SET ROWCOUNT 1   
      SELECT       @nRutcart   = rutcart,
                   @nNumdocu   = numdocu,
                   @nCorrela   = correla,
                   @ctipoper   = ISNULL( Tipoper, '*' ),
                   @nNumoper   = numoper,
                   @suma       = registro,
                   @nominal    = nominal,
                   @vptirc     = vptirc,
                   @interesc   = interesc,
                   @reajustec  = reajustec,
                   @valcomu    = valcomu,
                   @valcomp    = valcomp,
                   @nNominalp  = nominalp,
                   @fecpcup    = fecpcup,
                   @valcompori = valcompori,
                   @cMascara   = mascara
             FROM  #TMP
             WHERE registro > @suma
      SET ROWCOUNT 0   

      IF @cTipoper = '*' BEGIN
         BREAK

      END
 
      IF @cTipoper='CP' BEGIN
         SELECT       @cod_ser  = cpcodigo
                FROM  MDCP
                WHERE cpnumdocu = @nnumdocu AND
                      cpcorrela = @ncorrela

      END ELSE BEGIN
         SELECT       @cod_ser  = cicodigo
                FROM  MDCI
                WHERE cinumdocu = @nnumdocu AND cicorrela = @ncorrela

      END

      SELECT @mdse = inmdse FROM view_instrumento WHERE incodigo=@cod_ser

      IF @mdse = 'S' BEGIN
         SELECT       @monemi   = semonemi,
                      @tasemi   = setasemi,
                      @basemi   = sebasemi,
                      @rutemi   = serutemi
                FROM  VIEW_SERIE
                WHERE semascara = @cMascara

      END ELSE BEGIN
         SELECT       @monemi   = nsmonemi,
                      @tasemi   = nstasemi,
                      @basemi  = nsbasemi,
                      @rutemi   = nsrutemi
                FROM  VIEW_NOSERIE
                WHERE nsnumdocu = @nNumdocu AND nscorrela = @nCorrela
      END

      IF @cTipoper = 'CP' BEGIN
         INSERT INTO MDMO
                          (
                           mofecpro,
                           morutcart,
      			   motipcart,
                           monumdocu,
                           mocorrela,
                           monumdocuo,
                           mocorrelao,
                           monumoper,
                           motipoper,
                           motipopero,
                           moinstser,
                           momascara,
                           mocodigo,
                           moseriado,
                           mofecemi,
                           mofecven,
                           momonemi,
                           motasemi,
                           mobasemi,
                           morutemi,
                           monominal,
                           movpresen,
                           motir,
                           mopvp,
                           movpar,
                           motasest,
                           mofecinip,
                           mofecvenp,
                           movalinip,
                           movalvenp,--30
                           motaspact,
                           mobaspact,
                           momonpact,
                           moforpagi,
                           moforpagv,
                           mopagohoy,
                           morutcli,
                           mocodcli,
                           motipret,
                           mohora,
                           mousuario,
                           moterminal,
                           mocapitali,
                           mointeresi,
                           moreajusti,
                           movpreseni,
                           mocapitalp,
                           mointeresp, --48
                           moreajustp,
                           movpresenp,
                           motasant,
                           mobasant,
                           movalant,
                           mostatreg,
                           movpressb,
                           modifsb,
                           monominalp,
                           movalcomp,
                           movalcomu,
                           mointeres,
                           moreajuste,
                           mointpac,
                           moreapac,--63
                           moutilidad,
                           moperdida,
                           movalven,
                           mocorvent,
			   momtoPFE
		,	id_libro
                          )
             SELECT
                           @dFeccal,
                           cprutcart,
                           cptipcart,
                           cpnumdocu,
                           cpcorrela,
                           cpnumdocuo,
                           cpcorrelao,
                           vinumoper,
                           'RC',
                           'CP',
                           cpinstser,
                           cpmascara,
                           cpcodigo,
                           cpseriado,
                           cpfecemi,
                           cpfecven,
                           @monemi,
                           @tasemi,
                           @basemi,
                           @rutemi,
                           @nominal,
                           @vptirc,
                           vitirvent,
                           vipvpvent,
                           0,
                           vitasest,
			   vifecinip,
			   vifecvenp,
			   vivalinip,  -- 29
			   CASE WHEN mnmx = 'C' And vimonpact = 13 Then Round(vivalinip + viinteresvi + vireajustvi,2)	
				WHEN mnmx = 'C' And vimonpact <> 13 Then Round(Round(vivalinip/vitcinicio,2) + viinteresvi + vireajustvi,2)
			   ELSE  vivalinip + viinteresvi + vireajustvi END,  -- VGS   vivalinip + viinteresvi + vireajustvi, -- 30
                           vitaspact,
         vibaspact,
                           vimonpact,
                           viforpagi,
                           viforpagv,
                           '',
                           virutcli,
                           vicodcli,
                           '',
                           CONVERT( CHAR(15), @dfeccal, 108 ),
                           @User,
                           @Terminal,
                           ISNULL( vicapitalv, 0 ),
                           ISNULL( viinteresv, 0 ),
                           ISNULL( vireajustv, 0 ),
                           0,
                           vicapitalvi,
                           viinteresvi,
                           vireajustvi,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           vinominalp,
			   CASE WHEN mnmx = 'C' And vimonpact  = 13  Then vivalcomp -- vivalinip
				WHEN mnmx = 'C' And vimonpact <> 13  Then Round(vivalinip/vitcinicio,2)
			   	ELSE vivalinip 
			   END,  -- vivalcomp VGS
                           vivalcomu,
                           @interesc,   -- viinteresv,
                           @reajustec,  -- vireajustv,
                           viinteresvi,
                           vireajustvi,
                           0,
                           0,
                           vivalinip,
                           @suma    ,
			   vitcinicio
		,	ISNULL(MDVI.id_libro,MDCP.id_libro)
                     FROM  MDCP, MDVI , View_Moneda
                     WHERE cpnumdocu = @nnumdocu AND
                           cpcorrela = @nCorrela AND
                           vinumdocu = @nnumdocu AND
                           vicorrela = @nCorrela AND
                           vinumoper = @nNumoper AND
			   vimonpact = mncodmon


         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'MSG'    = 'Problemas en actualización de movimientos en proceso de recompras'
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN 

         END
         UPDATE       MDCP
                SET   cpnominal  = cpnominal  + @nominal,
                      cpvptirc   = cpvptirc   + @vptirc,
                      cpinteresc = cpinteresc + @interesc,
                      cpreajustc = cpreajustc + @reajustec,
                      cpvalcomu  = cpvalcomu  + ISNULL(    @valcomu, 0.0 ),
                      cpcapitalc = cpvalcomp  + ISNULL(    @valcomp, 0.0 ),
                      cpvalcomp  = cpvalcomp  + ISNULL(    @valcomp, 0.0 ),
                      cpvcompori = cpvcompori + ISNULL( @valcompori, 0.0 ),
                      cpfecpcup  = @fecpcup
                WHERE cpnumdocu  = @nnumdocu AND
                      cpcorrela  = @ncorrela

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = 'Problemas en actualización de compras propias en proceso de recompras'
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN

         END         

         UPDATE       MDDI
                SET   dinominal  = dinominal  + @nominal,
                      divptirc   = divptirc   + @vptirc,
                      dicapitalc = dicapitalc + ISNULL( @valcomp, 0.0 ),
                      diinteresc = diinteresc + @interesc,
                      direajustc = direajustc + @reajustec
                WHERE dinumdocu  = @nnumdocu AND
                      dicorrela  = @ncorrela AND
                      ditipoper  = 'CP'

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = 'Problemas en actualización de disponibilidad en proceso de recompras'
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN

         END         

         DELETE MDVI WHERE vinumdocu = @nnumdocu AND 
                           vicorrela = @nCorrela AND 
                        vinumoper = @nNumoper           

         IF @@ERROR <> 0 BEGIN
      SELECT 'ESTADO' = 'NO',
                   'Msg'    = 'Problemas en eliminación de registros de ventas con pacto en proceso de recompras'
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN

         END

         DELETE #TMP2

         INSERT INTO #TMP2
                          (
                             numdocu,
							 correla,
                             cantidad,
                             monto,
                             instser
                          )
                SELECT       cvnumdocu,
                             cvcorrela,
                             cvcantcort,
                             cvmtocort,
                             'RECOMPRA'
                       FROM  MDCV
                       WHERE cvnumdocu = @nNumdocu AND
                             cvcorrela = @nCorrela AND
                             cvnumoper = @nNumoper

         SELECT @xx    = 1
         SELECT @xcort = 0         WHILE @xx = 1 BEGIN
            SELECT @nCantCort = 0
            SELECT @nMontCort = 0
            SELECT @cInstser  = '*'            SET ROWCOUNT 1
            SELECT       @nCantCort = cantidad,
                         @nMontCort = Monto,
                         @cInstser  = instser,
                         @xCort     = registro
                   FROM  #TMP2
                   WHERE registro > @xCort
            SET ROWCOUNT 0            IF @cInstser = '*' BEGIN
               BREAK

            END

            IF EXISTS( SELECT       cocantcortd
                              FROM  MDCO
                              WHERE conumdocu = @nNumdocu AND
                                    cocorrela = @nCorrela AND
                                    comtocort = @nMontCort
                     ) BEGIN
               UPDATE       MDCO
                      SET   cocantcortd = cocantcortd + @nCantCort
                      WHERE conumdocu   = @nNumdocu AND
                            cocorrela   = @nCorrela AND
                            comtocort   = @nMontCort               IF @@ERROR <> 0 BEGIN
                  SELECT 'ESTADO' = 'NO', 
                         'Msg'    = 'Problemas en actualización de cortes en proceso de recompras'
--                  ROLLBACK TRANSACTION
  		  SET nocount off 
                  RETURN

               END   

            END ELSE BEGIN
               INSERT INTO MDCO
                               (
                                corutcart,
                                conumdocu,
                                cocorrela,
                                comtocort,
                                cocantcortd,
                                cocantcorto
                               )
                      VALUES   (
                                @nRutcart,
                                @nNumdocu,
                                @nCorrela,
                                @nMontCort,
                                @nCantCort,
                                @nCantCort
                               )

               IF @@ERROR <> 0 BEGIN
                  SELECT 'ESTADO' = 'NO',
                         'Msg'    = 'Problemas en actualización de cortes en proceso de recompras'
--                  ROLLBACK TRANSACTION
	          SET nocount off 
                  RETURN

               END

            END

         END

      END

      IF @cTipoper = 'CI' BEGIN
         INSERT INTO MDMO 
                         (
                             mofecpro,
                             morutcart,
                             motipcart,
                             monumdocu,
                             mocorrela,
                  monumdocuo,
                             mocorrelao,
			     monumoper,
			     motipoper,
		             motipopero,
                             moinstser,
                 	     momascara,
                             mocodigo,
                             moseriado,
                             mofecemi,
                             mofecven,
                             momonemi,
                             motasemi,
                             mobasemi,
                             morutemi,
   			     monominal,
                             movpresen,
                             momtps,
                             momtum,
                             momtum100,
                             monumucup,
                             motir,
                             mopvp,
                             movpar,
                             motasest,
                             mofecinip,
                             mofecvenp,
                             movalinip,
                             movalvenp, -- 34
                             motaspact,
                             mobaspact,
                             momonpact,
                             moforpagi,
                             moforpagv,
                             mopagohoy,
                             morutcli,
                             mocodcli,
                             motipret,
                             mohora,
                             mousuario,
                             moterminal,
                             mocapitali,
                             mointeresi,
                             moreajusti,
                             movpreseni,
                             mocapitalp,
                             mointeresp, -- 52
                             moreajustp,
                             movpresenp,
                             motasant,
                             mobasant,
                             movalant,
                             mostatreg,
                             movpressb,
                             modifsb,
                             monominalp,
                             movalcomp,
                             movalcomu,
                             mointeres,
                             moreajuste,
                             mointpac,
                             moreapac, -- 67
                             moutilidad,
                             moperdida,
                             movalven,
                             mocorvent,
			     momtoPFE
		,	id_libro
                         )
                SELECT       @dFeccal,
                             cirutcart,
                             citipcart,
                             cinumdocu,
                             cicorrela,
                             cinumdocuo,
                             cicorrelao,
                             vinumoper,
                             'RC',
                             'CI',
                             ciinstser,
                             cimascara,
                             cicodigo,
                             ciseriado,
                             cifecemi,
                             cifecven,
                             @monemi,
                             @tasemi,
                             @basemi,
                             @rutemi,
                             @nominal,
                             @vptirc,
                             @vptirc,
                             vivalvemu,
                             vivvum100,
                             cinumucup,
                             vitirvent,
                             vipvpvent,
                             0,
                             vitasest,
                             vifecinip,
                             vifecvenp,
                             vivalinip,
			     CASE WHEN mnmx = 'C' And vimonpact = 13 Then Round(vivalinip + viinteresvi + vireajustvi,2)
				 WHEN mnmx = 'C' And vimonpact <> 13 Then Round(Round(vivalinip/vitcinicio,2) + viinteresvi + vireajustvi,2)
			     ELSE  vivalinip + viinteresvi + vireajustvi END,  -- VGS   vivalinip + viinteresvi + vireajustvi, -- 34
                             vitaspact,
			     vibaspact,
                             vimonpact,
		             viforpagi,
                             viforpagv,
                             '',
                             virutcli,
                             vicodcli,
                             '',
                             CONVERT( CHAR(15), @dFeccal, 108 ),
                             @User,
                             @Terminal,
                             ISNULL( vicapitalv, 0 ),
        		     ISNULL( viinteresv, 0 ),
                             ISNULL( vireajustv, 0 ),
                             0,
                             ISNULL( vicapitalvi, 0 ),
                             ISNULL( viinteresvi, 0 ), -- 52
                             ISNULL( vireajustvi, 0 ),
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             vinominalp,
			     CASE WHEN mnmx = 'C' And vimonpact = 13 Then vivalinip
				  WHEN mnmx = 'C' And vimonpact <> 13 Then Round(vivalinip/vitcinicio,2)
			     ELSE  vivalinip END,  -- vivalcomp VGS
                             vivalcomu,
                             viinteresv,
                             vireajustv,
                             viinteresvi,
                             vireajustvi,
                             0,
                             0,
                             vivalinip,
                             @suma,
			     vitcinicio
			,	ISNULL(mdvi.id_libro,mdci.id_libro)
                       FROM  MDCI, MDVI , View_Moneda
                       WHERE cinumdocu = @nnumdocu AND
                             cicorrela = @nCorrela AND
                             vinumdocu = @nnumdocu AND
                             vicorrela = @nCorrela AND
                             vinumoper = @nNumoper AND
			     vimonpact = mncodmon

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = 'Problemas en proceso de recompras, Actualización de cartera  '
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN 1

         END

         UPDATE       MDDI
                SET   dinominal = dinominal + @nominal,
                      divptirc  = civptirc * (dinominal/cinominal),
                      divptirci = civptirc * (dinominal/cinominal)
                FROM  MDDI, MDCI
                WHERE dinumdocu = @nnumdocu AND
                      dicorrela = @ncorrela AND
                      ditipoper = 'CI'      AND
                      cinumdocu = @nnumdocu AND
                      cicorrela = @ncorrela

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = 'Problemas en proceso de recompras, Actualización de disponiblidad '
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN 1

         END   

         DELETE MDVI WHERE vinumdocu = @nnumdocu AND
                           vicorrela = @nCorrela AND
                           vinumoper = @nNumoper                                       

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = 'Problemas en proceso de Recompras, Rebajar pacto'
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN 1

         END      

         DELETE #TMP2
         INSERT INTO #TMP2
                          (
                              numdocu,
                      correla,
                              cantidad,
                              monto,
  instser
                          )
                SELECT        cvnumdocu,
                              cvcorrela,
                              cvcantcort,                  
                              cvmtocort,
                             'RECOMPRA'
		       FROM  MDCV
                       WHERE cvnumdocu = @nNumdocu AND
                             cvcorrela = @nCorrela AND 
                  cvnumoper = @nnumoper 

         SELECT @xx    = 1
         SELECT @xcort = 0

         WHILE @xx = 1 BEGIN
            SELECT @nCantCort = 0
            SELECT @nMontCort = 0
            SELECT @cInstser   = '*'

            SET ROWCOUNT 1
            SELECT       @nCantCort = cantidad,
                         @nMontCort = monto,
                         @cInstser  = instser,
                         @xCort     = registro
                   FROM  #TMP2
                   WHERE registro > @xCort
            SET ROWCOUNT 0

            IF @cInstser='*' BEGIN
               BREAK

            END

            IF EXISTS( SELECT       cocantcortd 
                              FROM  mdco 
                              WHERE conumdocu = @nNumdocu AND
                                    cocorrela = @nCorrela AND
                                    comtocort = @nCantCort
                     ) BEGIN
               UPDATE       MDCO
                      SET   cocantcortd = cocantcortd + @nCantCort
                      WHERE conumdocu   = @nNumdocu AND
                            cocorrela   = @nCorrela AND
                            comtocort   = @nCantCort

               IF @@ERROR <> 0 BEGIN
                  SELECT 'ESTADO' = 'NO',
                         'Msg' = 'Problemas en proceso de Recompras, actualización de cortes'
--                  ROLLBACK TRANSACTION
  	   	  sET nocount off 
                  RETURN 1

               END      

            END ELSE BEGIN
               INSERT INTO MDCO
                               (
                                corutcart,
                                conumdocu,
                                cocorrela,
                                comtocort,
                                cocantcortd,
                                cocantcorto
                               )
                      VALUES   (
                                @nRutcart,
                                @nNumdocu,
                                @nCorrela,
                                @nMontCort,
                                @nCantCort,
                                @nCantCort
                               )

               IF @@ERROR <> 0 BEGIN
                  SELECT 'ESTADO' = 'NO',
                         'Msg'    = 'Problemas en proceso de Recompras , actualización de cortes'
--                  ROLLBACK TRANSACTION
  	          SET nocount off 
                  RETURN 1

               END

            END

         END

      END

      CONTINUE

   END

   /*===========================================================================================*/
   /*===========================================================================================*/
		UPDATE MDAC
		SET	acsw_rc		= '1'	,
			acsw_dvprop	= '0'	,
			acsw_dvci	= '0'	,
			acsw_dvvi	= '0'	,
			acsw_dvib	= '0'


   /*===========================================================================================*/
   /*===========================================================================================*/
   SELECT @ntotalreg = COUNT(*) FROM #TMP

   /*===========================================================================================*/
   /*===========================================================================================*/
   SELECT 'ESTADO'='SI',
          'msg' = 'TOTAL ' + RTRIM( CONVERT( VARCHAR(7), @ntotalreg ) )

   /*===========================================================================================*/
   /*===========================================================================================*/
--   COMMIT TRANSACTION
   
END

GO
