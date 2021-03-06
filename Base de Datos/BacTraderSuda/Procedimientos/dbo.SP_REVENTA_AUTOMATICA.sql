USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REVENTA_AUTOMATICA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_REVENTA_AUTOMATICA]
       (
        @user           CHAR(12)   ,
        @terminal       CHAR(12)
       ) WITH RECOMPILE
AS
BEGIN

   /*===========================================================================================*/
   /*===========================================================================================*/

   SET NOCOUNT ON

   DECLARE @Operacion      NUMERIC(10,0)
   DECLARE @dFeccal        DATETIME
   DECLARE @x              INTEGER
   DECLARE @suma           INTEGER
   DECLARE @nNumdocu       NUMERIC(10,0)
   DECLARE @nCorrela       NUMERIC(03,0)
   DECLARE @nNumoper       NUMERIC(10,0)
   DECLARE @ctipoper       CHAR(03)
   DECLARE @Inid           CHAR(01)
   DECLARE @nominal        NUMERIC(19,4)
   DECLARE @vptirc         NUMERIC(19,4)
   DECLARE @interesc       NUMERIC(19,4)
   DECLARE @reajustec      NUMERIC(19,4)
   DECLARE @valcomu        NUMERIC(19,4)
   DECLARE @valcomp        NUMERIC(19,4)
   DECLARE @cod_ser        NUMERIC(03,0)
   DECLARE @monemi         NUMERIC(05,0)
   DECLARE @tasemi         NUMERIC(19,4)
   DECLARE @basemi         NUMERIC(03,0)
   DECLARE @rutemi         NUMERIC(09,0)
   DECLARE @mdse           CHAR(01)
   DECLARE @nNominalp      NUMERIC(19,4)
   DECLARE @cinstser       CHAR(12)
   DECLARE @ntotalreg      NUMERIC(10,0)

   /*===========================================================================================*/
   /*===========================================================================================*/
   SELECT @x      = 1
   SELECT @suma   = 0

   /*===========================================================================================*/
   /*===========================================================================================*/
   CREATE TABLE #Temp
         (
          numdocu      NUMERIC(10,0)         NOT NULL,
          correla      NUMERIC(03,0)         NOT NULL,
          tipoper      CHAR(03)              NOT NULL,
          nominal      NUMERIC(19,4)         NOT NULL,
          vptirc       NUMERIC(19,4)         NOT NULL,
          interesc     NUMERIC(19,4)         NOT NULL,
          reajustec    NUMERIC(19,4)         NOT NULL,
          valcomu      NUMERIC(19,4)         NOT NULL,
          valcomp      NUMERIC(19,4)         NOT NULL,
          cod_ser      NUMERIC(03,0)         NOT NULL,
          nominalp     NUMERIC(19,4)         NOT NULL,
          cinstser     CHAR(12)              NOT NULL,
          registro     INTEGER IDENTITY(1,1) NOT NULL
         )
      
   /*===========================================================================================*/
   /*===========================================================================================*/
   SELECT       @dFeccal  = acfecproc  
--                @Inid     = acsw_pd
          FROM  MDAC
   
   /*===========================================================================================*/
   /*===========================================================================================*/
  /* IF @Inid='0' BEGIN
      SELECT 'Estado' = 'NO','Msg' = 'Proceso de Ingreso de parametros diarios no ha sido realizado '
      RETURN

   END
*/
--   BEGIN TRANSACTION

   /*===========================================================================================*/
   /* Se Eliminan interbancarios de la tabla de compras con pactos ( mdci ), puesto que se dan  */
   /* de baja en el proceso de devengamiento.                                                   */
   /*===========================================================================================*/
   DELETE MDCI WHERE cifecvenp<=@dFeccal AND (ciinstser='ICOL' OR ciinstser='ICAP')

   /*===========================================================================================*/
  /*===========================================================================================*/
   INSERT #Temp
          SELECT cinumdocu,
                          cicorrela,
                          'CI',
                          cinominal   ,
                          civptirc   ,
                          ciinteresc   ,
                          cireajustc   ,
                          civalcomu   ,
                          civalcomp   ,
                          cicodigo   ,
                          cinominalp   ,
                          ciinstser
                 FROM     MDCI
                 WHERE    @dFeccal  >= cifecvenp AND
                         (ciinstser <> 'ICOL'    AND
                          ciinstser <> 'ICAP' )  AND
                          cimascara <> 'CLEAN'
                 ORDER BY cinumdocu

	IF (SELECT COUNT(*) FROM #Temp)=0
	BEGIN
		UPDATE	MDAC
		SET	acsw_rv   = '1',
			acsw_pc   = '0'

		DELETE MDCP WHERE cpfecven <= @dFeccal

		IF @@ERROR<>0
		BEGIN 
--			ROLLBACK TRANSACTION
			SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS AL ELIMINAR TABLA DE COMPRAS PROPIAS'
			SET NOCOUNT OFF
			RETURN
		END

		DELETE MDDI WHERE difecsal <= @dFeccal

		IF @@ERROR<>0
		BEGIN 
--			ROLLBACK TRANSACTION
			SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS AL ELIMINAR TABLA DE DISPONIBILIDAD'
			SET NOCOUNT OFF
			RETURN
		END

		SELECT 'ESTADO' ='SI','MSG'=' NO EXISTEN OPERACIONES DE COMPRAS CON PACTOS QUE VENZAN HOY'

--		COMMIT TRANSACTION
		SET NOCOUNT OFF	

		RETURN

	END

   WHILE @x = 1 BEGIN

      SELECT   @ctipoper   = '*'

      SET ROWCOUNT 1
      SELECT       @nNumdocu  = numdocu,
                   @nCorrela  = correla,
                   @ctipoper  = ISNULL( tipoper, '*' ),
                   @suma      = registro,
                   @nominal   = nominal,
                   @vptirc    = vptirc,
                   @interesc  = interesc,
                   @reajustec = reajustec,
                   @valcomu   = valcomu,
                   @valcomp   = valcomp,
                   @cod_ser   = cod_ser,
                   @nNominalp = nominalp,
                   @cinstser  = cinstser
             FROM  #Temp
             WHERE registro   > @suma
      SET ROWCOUNT 0

      IF @cTipoper = '*' BEGIN
         BREAK

      END

      SELECT @mdse = inmdse FROM VIEW_INSTRUMENTO WHERE incodigo=@cod_ser

      SET ROWCOUNT 1
      IF @mdse = 'S' BEGIN
        SELECT       @tasemi   = 0.0,
                     @basemi   = 0.0
                FROM  VIEW_SERIE
                WHERE semascara = @cinstser

      END ELSE BEGIN
         SELECT       @monemi   = nsmonemi,
                      @tasemi   = nstasemi,
                      @basemi   = nsbasemi,
                      @rutemi   = nsrutemi
                FROM  VIEW_NOSERIE
                WHERE nsnumdocu = @nNumdocu    AND
                  nscorrela = @nCorrela

      END
      SET ROWCOUNT 0

      SELECT @basemi = ISNULL( @basemi, 0 ),
             @monemi = ISNULL( @monemi, 0 ),
             @tasemi = ISNULL( @tasemi, 0 ),
             @rutemi = ISNULL( @rutemi, 0 )

      INSERT INTO MDMO (
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
                         mointeresp,  -- 52
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
                         moreapac,
                         moutilidad,
                         moperdida,
                         movalven,
			 momtoPFE
		,	id_libro
                       )
             SELECT      @dFeccal,
                         cirutcart,
                         citipcart,
                         cinumdocu,
                         cicorrela,
                         cinumdocuo,
                         cicorrelao,
                         cinumdocu,
                         'RV',
                         'CI',
                         ciinstser,
                         cimascara,
                         cicodigo,
                         ciseriado,
                         cifecemi,
                         cifecven,
                         cimonemi,
                         @tasemi,
                         @basemi,
                         cirutemi,
                         @nominal,
                         @vptirc,
                         @vptirc,
                         civalcomu,
              		 civcum100,
                         cinumucup,
                         citircomp,
          		 cipvpcomp,
                         0,
                         citasest,
                         cifecinip,
                         cifecvenp,
                         civalinip,
			 CASE WHEN mnmx = 'C' And cimonpact = 13 Then Round(civalinip+ciinteresci+cireajustci,2)
			      WHEN mnmx = 'C' And cimonpact <> 13 Then Round(Round(civalinip/citcinicio,2)+ciinteresci+cireajustci,2)
			 ELSE  civalinip + ciinteresci+cireajustci END,  -- VGS   civalinip+ciinteresci+cireajustci, -- 30
                         citaspact,
                         cibaspact,
  			 cimonpact,
          		 ciforpagi,
                         ciforpagv,
                         '',
                         cirutcli,
                         cicodcli,
                         '',
                         CONVERT(CHAR(15),@dFeccal,108),
                         @User,
                         @Terminal,
                         cicapitalc,
                         ciinteresc,
                         cireajustc,
                         0,
                         cicapitalci,
                         ciinteresci,
                         cireajustci,
                         0,
                         0,
                         0,
                         0,
                         '',
    0,
                         0,
                         cinominalp,
           		 CASE WHEN mnmx = 'C' And cimonpact = 13 Then civalinip
			      WHEN mnmx = 'C' And cimonpact <> 13 Then Round(civalinip/citcinicio,2)
			 ELSE civalinip END,  -- civalcomp VGS
                         civalcomu,
                         0,
                         0,
                         ciinteresci,
               		 cireajustci,
                   	 0,
                         0,
                         civalinip,
			 citcinicio
		,	id_libro
                   FROM  MDCI, View_Moneda
                   WHERE cinumdocu = @nnumdocu    AND
           		 cicorrela = @nCorrela	  AND
			 cimonpact = mncodmon

      IF @@ERROR <> 0 BEGIN
         SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN GRABACIóN DEL ARCHIVO DE MOVIMIENTOS'
--         ROLLBACK TRANSACTION
  	 set nocount off
         RETURN 

      END

      DELETE MDCI WHERE cinumdocu = @nnumdocu AND cicorrela = @ncorrela

      IF @@ERROR <> 0 BEGIN
         SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DE COMPRAS CON PACTO'
--         ROLLBACK TRANSACTION
	set nocount off
         RETURN

      END   

      DELETE MDCO WHERE conumdocu = @nnumdocu AND cocorrela = @ncorrela

      IF @@ERROR <> 0 BEGIN
         SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DE CORTES'
--         ROLLBACK TRANSACTION
	set nocount off
         RETURN

      END         

      UPDATE       MDDI
             SET   dinominal = dinominal - @nominal,
                   divptirc  = divptirc + @vptirc
             WHERE dinumdocu = @nnumdocu    AND
                   dicorrela = @ncorrela    AND
                   ditipoper = 'CI'
   
      IF @@ERROR <> 0 BEGIN
         SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DE COMPRAS PROPIAS'
--         ROLLBACK TRANSACTION
 	 set nocount off
         RETURN

      END

      CONTINUE      
      
   END

   UPDATE       MDAC
          SET   acsw_rv   = '1',
                acsw_pc   = '0'

   DELETE MDCP WHERE cpfecven <= @dFeccal

   IF @@ERROR <> 0 BEGIN 
--      ROLLBACK TRANSACTION
      SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DE COMPRAS PROPIAS'
	set nocount off
      RETURN

   END

   DELETE MDDI WHERE difecsal = @dFeccal

   IF @@ERROR <> 0 BEGIN 
--      ROLLBACK TRANSACTION
      SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DISPONIBLE'
	set nocount off
      RETURN

   END

   SELECT @ntotalreg = COUNT(*) FROM #Temp

--   EXECUTE Sp_Interfaz_Bacmetrics_Irf @dFeccal

   SELECT 'ESTADO' = 'SI',
          'msg' = 'TOTAL ' + RTRIM( CONVERT( VARCHAR(7), @ntotalreg ) )
--          'Msg' = RTRIM( CONVERT(VARCHAR(7),@ntotalreg))+' Vencimientos'
   
--   COMMIT TRANSACTION
   
   DROP TABLE #TEMP
   SET NOCOUNT OFF
      
END

GO
