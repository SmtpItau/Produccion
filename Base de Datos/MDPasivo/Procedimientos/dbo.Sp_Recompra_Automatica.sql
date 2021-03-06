USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Recompra_Automatica]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Recompra_Automatica]
       (
        @user           CHAR(12),
        @terminal       CHAR(12)
       ) WITH RECOMPILE
AS
BEGIN

   /*===========================================================================================*/
   /*===========================================================================================*/
   SET DATEFORMAT dmy
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
   DECLARE @valvenc     NUMERIC(19,6)      
   DECLARE @durat     FLOAT
   DECLARE @duratmod     FLOAT
   DECLARE-- @vmonto_Traspaso FLOAT                   ,
           --@vDiferencia_Traspaso FLOAT              ,
           @monto_Traspaso FLOAT                   ,
           @Diferencia_Traspaso FLOAT              ,
           @Tir_Traspaso Float                    ,
           @Libro_Origen_Traspaso  INT    ,
           @Precio_transferencia  FLOAT    ,
           @Libro_transferencia   FLOAT    ,
           @Interes_transferencia FLOAT    


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
           valvenc    NUMERIC(19,6)          NOT NULL,
           duration   FLOAT                NOT NULL,
           duratmod   FLOAT                NOT NULL, 
           registro   INTEGER IDENTITY(1,1) NOT NULL,
           monto_Traspaso FLOAT NOT NULL           ,
           Diferencia_Traspaso FLOAT  NOT NULL     ,
           Precio_transferencia  FLOAT   NOT NULL ,
           Libro_transferencia   FLOAT   NOT NULL ,
           Interes_transferencia FLOAT   NOT NULL      
          )

   /*===========================================================================================*/
   /*===========================================================================================*/
   CREATE TABLE #TMP2
          (
           numdocu    NUMERIC(10,0)         NOT NULL,

           correla    NUMERIC(03,0)         NOT NULL,
           cantidad   NUMERIC(19,4)         NOT NULL,
           monto      NUMERIC(19,4)         NOT NULL,
           instser    CHAR(10)              NOT NULL,
           registro   INTEGER IDENTITY(1,1) NOT NULL
          )

   /*===========================================================================================*/
   /*===========================================================================================*/
   SELECT @dFeccal = Fecha_proceso
--                @Inid    = acsw_pd
          FROM  VIEW_DATOS_GENERALES

   /*===========================================================================================*/
   /*===========================================================================================*/
/*   IF @Inid='0' BEGIN
      SELECT "Estado" = "NO",
             "Msg"    = "Proceso de Inicio de día no se ha realizadoNo ha hecho Inicio de dia "
      RETURN

   END
*/
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
                          vimascara,
                          vivalvenc,
                          vidurat,
                          vidurmod,
                          monto_Traspaso,
                          Diferencia_Traspaso  ,  
                          Precio_transferencia   ,
                          Libro_transferencia   ,
                          Interes_transferencia 
                 FROM     CARTERA_VENTA_PACTO
                 WHERE    @dFeccal >= vifecvenp
                 ORDER BY vinumoper

	IF (SELECT COUNT(*) FROM #TMP)=0
	BEGIN
		SELECT	'Estado' = 'SI', 'msg' = 'No Existen '
--		UPDATE VIEW_DATOS_GENERALES SET acsw_rc = '1'
		SET NOCOUNT OFF 
		RETURN
	END

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
                   @cMascara   = mascara ,
                   @valvenc    = valvenc,
                   @durat      = duration,
                   @duratmod   = duratmod ,
                   @monto_Traspaso =monto_Traspaso  ,
                   @Diferencia_Traspaso = Diferencia_Traspaso ,
                   @Precio_transferencia  = Precio_transferencia ,
                   @Libro_transferencia   =  Libro_transferencia  ,
                   @Interes_transferencia = Interes_transferencia 
             FROM  #TMP
             WHERE registro > @suma
      SET ROWCOUNT 0   

      IF @cTipoper = '*' BEGIN
         BREAK

      END
 
      IF @cTipoper='CP' BEGIN
         SELECT       @cod_ser  = cpcodigo
         FROM  CARTERA_PROPIA
                WHERE cpnumdocu = @nnumdocu AND
                      cpcorrela = @ncorrela

      END ELSE BEGIN
         SELECT       @cod_ser  = cicodigo
                FROM  CARTERA_COMPRA_PACTO
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
         SELECT @monemi   = nsmonemi,
                      @tasemi   = nstasemi,
                      @basemi  = nsbasemi,
                      @rutemi   = nsrutemi
                FROM  NOSERIE
                WHERE nsnumdocu = @nNumdocu AND nscorrela = @nCorrela
      END

      IF @cTipoper = 'CP' BEGIN
         INSERT INTO MOVIMIENTO_TRADER
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
                           movalvenp,
                           motaspact,
                           mobaspact,
                           momonpact,
                           moforpagi,
                           moforpagv,
                           mopagohoy,
                           morutcli,
                           mocodcli,
                           motipret,
                           mohora,           -- hora
                           mousuario,        -- usuario 
                           moterminal,       -- terminal
                           mocapitali,
                           mointeresi,
                           moreajusti,
                           movpreseni,
                           mocapitalp,
                           mointeresp,
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
                           mocorvent,
                           Cuenta_Corriente_Inicio,
                           Cuenta_Corriente_Final,
                           Sucursal_Inicio,
                           Sucursal_Final,
                           codigo_carterasuper,
                           moimpreso,
                           Tipo_Inversion,
			   codigo_subproducto,
                           swift_corresponsal,
                           swift_pagamos,
                           fecha_compra_original,
                           CODIGO_AREA ,
                           monto_Traspaso ,
                           Diferencia_Traspaso,
                           Tir_Traspaso,
                           Libro_Origen_Traspaso,
                           Precio_transferencia  ,
                           Libro_transferencia   ,
                           Interes_transferencia    )
             SELECT
                           @dFeccal,
                           cprutcart,
                           cptipcart,
                           cpnumdocu,
                           cpcorrela,
                           cpnumdocuo,
                           cpcorrelao,
                           vinumoper,
                           CASE WHEN CARTERA_VENTA_PACTO.codigo_subproducto = 'FLP' THEN 'VFL'
				WHEN CARTERA_VENTA_PACTO.codigo_subproducto = 'RP'  THEN 'VRP'
				ELSE 'RC' END, --'RC',
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
                           vivalinip,
                           vivalinip + viinteresvi + vireajustvi,
                           vitaspact,
                           vibaspact,
                           vimonpact,
                           viforpagi,
                           viforpagv,
                           '',
                           virutcli,
                           vicodcli,
                           '',

                           CONVERT( CHAR(15), GETDATE(), 108 ),
                           ISNULL(( SELECT mousuario  FROM MOVIMIENTO_TRADER WHERE monumoper = @nNumoper
                                                           AND monumdocu = @nnumdocu
                                                           AND mocorrela = @nCorrela
							   AND motipoper IN('VI','VIX')	
                           ),@User) , 

                           ISNULL(( SELECT moterminal FROM MOVIMIENTO_TRADER WHERE monumoper = @nNumoper
                                                           AND monumdocu = @nnumdocu
                                                           AND mocorrela = @nCorrela
							   AND motipoper IN('VI','VIX')
                           ),@Terminal)    , 

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
                           vivalcomp,
                           vivalcomu,
                           viinteresv,
                           vireajustv,
                           viinteresvi,
                           vireajustvi,
                           0,
                           0,
                           vivalinip,
                           @suma,
                           Cuenta_Corriente_Inicio,
                           Cuenta_Corriente_Final,
                           Sucursal_Inicio,
                           Sucursal_Final,
                           CARTERA_VENTA_PACTO.codigo_carterasuper,
                           '',   
                           CARTERA_VENTA_PACTO.Tipo_Inversion,
			   CASE WHEN CARTERA_VENTA_PACTO.codigo_subproducto = 'FLP' THEN 'VFL'
				WHEN CARTERA_VENTA_PACTO.codigo_subproducto = 'RP'  THEN 'VRP'
				ELSE 'RC' END,
                           CARTERA_VENTA_PACTO.swift_corresponsal,
                           CARTERA_VENTA_PACTO.swift_pagamos,
                           cpfeccomp,
                           a.Codigo_Area ,
                           CARTERA_VENTA_PACTO.monto_Traspaso ,
                           CARTERA_VENTA_PACTO.Diferencia_Traspaso,
                           a.Tir_Traspaso,
                           a.Libro_Origen_Traspaso,
                           CARTERA_VENTA_PACTO.Precio_transferencia  ,
                           CARTERA_VENTA_PACTO.Libro_transferencia   ,
                           CARTERA_VENTA_PACTO.Interes_transferencia 
                     FROM  CARTERA_PROPIA a, CARTERA_VENTA_PACTO 
                     WHERE cpnumdocu = @nnumdocu AND
                           cpcorrela = @nCorrela AND
                           vinumdocu = @nnumdocu AND
                           vicorrela = @nCorrela AND
                           vinumoper = @nNumoper

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'MSG'    = 'Problemas en actualización de movimientos en proceso de recompras'
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN 

         END

         UPDATE       CARTERA_PROPIA

          SET  cpnominal  = cpnominal  + @nominal,
                      cpvptirc   = cpvptirc   + @vptirc,
                      cpinteresc = cpinteresc + @interesc,
                      cpreajustc = cpreajustc + @reajustec,
                      cpvalcomu  = cpvalcomu  + ISNULL( @valcomu, 0.0 ),
                      cpcapitalc = cpvalcomp  + ISNULL( @valcomp, 0.0 ),
                      cpvalcomp  = cpvalcomp  + ISNULL( @valcomp, 0.0 ),
                      valor_compra_original = valor_compra_original + ISNULL( @valcomp, 0.0 ),
                      valor_compra_um_original = valor_compra_um_original + ISNULL( @valcomu, 0.0 ),
                      cpvcompori = cpvcompori + ISNULL( @valcompori, 0.0 ),
                      cpfecpcup  = @fecpcup,
                      cpdurmod   = @duratmod,  
                      cpdurat    = @durat,
                      monto_Traspaso = monto_traspaso + @monto_traspaso ,
                      Diferencia_Traspaso = diferencia_traspaso+ @diferencia_traspaso                         
                WHERE cpnumdocu  = @nnumdocu AND
                      cpcorrela  = @ncorrela

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = 'Problemas en actualización de compras propias en proceso de recompras'
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN

         END         

         UPDATE CARTERA_DISPONIBLE
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

         DELETE CARTERA_VENTA_PACTO WHERE vinumdocu = @nnumdocu AND 
                           vicorrela = @nCorrela AND 
                           vinumoper = @nNumoper                                     

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = "Problemas en eliminación de registros de ventas con pacto en proceso de recompras"
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
/* revisar  */   FROM  CORTE_VENDIDO
                 WHERE cvnumdocu = @nNumdocu AND
                             cvcorrela = @nCorrela AND
                             cvnumoper = @nNumoper

         SELECT @xx    = 1
         SELECT @xcort = 0

         WHILE @xx = 1 BEGIN
            SELECT @nCantCort = 0
            SELECT @nMontCort = 0
            SELECT @cInstser  = '*'

            SET ROWCOUNT 1
            SELECT       @nCantCort = cantidad,
      @nMontCort = Monto,
                  @cInstser  = instser,
                         @xCort     = registro
                   FROM  #TMP2
                   WHERE registro > @xCort
            SET ROWCOUNT 0

            IF @cInstser = '*' BEGIN
               BREAK

            END

            IF EXISTS( SELECT       cocantcortd
                              FROM  CORTE
                              WHERE conumdocu = @nNumdocu AND
                                    cocorrela = @nCorrela AND
                                    comtocort = @nMontCort
                     ) BEGIN
               UPDATE       CORTE
                      SET   cocantcortd = cocantcortd + @nCantCort
                      WHERE conumdocu   = @nNumdocu AND
                            cocorrela   = @nCorrela AND
                            comtocort   = @nMontCort

               IF @@ERROR <> 0 BEGIN
                  SELECT 'ESTADO' = 'NO', 
                         'Msg'    = "Problemas en actualización de cortes en proceso de recompras"
--                  ROLLBACK TRANSACTION
  		  SET nocount off 
                  RETURN

               END   

            END ELSE BEGIN

               INSERT INTO CORTE
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
                         'Msg'    = "Problemas en actualización de cortes en proceso de recompras"
--                  ROLLBACK TRANSACTION
	          SET nocount off 
                  RETURN

               END

            END

         END

      END

      IF @cTipoper = 'CI' BEGIN
         INSERT INTO MOVIMIENTO_TRADER 
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
                             movalvenp,
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
                             mointeresp,
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
                             mocorvent,
                             Cuenta_Corriente_Inicio,
                             Cuenta_Corriente_Final,
                             Sucursal_Inicio,
                             Sucursal_Final,
                             codigo_carterasuper,
			     codigo_subproducto,
                             swift_corresponsal,
                             swift_pagamos,
                             fecha_compra_original,
                             Codigo_Area ,
                             Precio_transferencia  ,
                             Libro_transferencia   ,
                             Interes_transferencia  )
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
                             vi.vivalvemu,
                             vi.vivvum100,
                             cinumucup,
                             vi.vitirvent,
                             vi.vipvpvent,

                             0,
                             vi.vitasest,
                             vi.vifecinip,
                             vi.vifecvenp,
                             vi.vivalinip,
                             vi.vivalinip + vi.viinteresvi + vi.vireajustvi,
                             vi.vitaspact,
                             vi.vibaspact,
                             vi.vimonpact,
                             vi.viforpagi,
                             vi.viforpagv,
                             '',
                             vi.virutcli,
                             vi.vicodcli,
                             '',
                           CONVERT( CHAR(15), GETDATE(), 108 ),
                           ISNULL(( SELECT mousuario  FROM MOVIMIENTO_TRADER WHERE monumoper = @nNumoper
                                                                  AND monumdocu = @nnumdocu
                                                                  AND mocorrela = @nCorrela
								  AND motipoper IN('CI','CIX')
                           ),@User),   --@User     ,
                           ISNULL(( SELECT moterminal FROM MOVIMIENTO_TRADER WHERE monumoper = @nNumoper
                                                                 AND monumdocu = @nnumdocu
                                                                 AND mocorrela = @nCorrela
								 AND motipoper IN('CI','CIX')
                           ),@Terminal) , --@Terminal     ,
                             ISNULL( vi.vicapitalv, 0 ),
                             ISNULL( vi.viinteresv, 0 ),
                             ISNULL( vi.vireajustv, 0 ),
                             0,

                             ISNULL( vi.vicapitalvi, 0 ),
                             ISNULL( vi.viinteresvi, 0 ),
                             ISNULL( vi.vireajustvi, 0 ),
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             vi.vinominalp,
                             vi.vivalcomp,
                             vi.vivalcomu,
                             vi.viinteresv,
                             vi.vireajustv,
                             vi.viinteresvi,
                             vi.vireajustvi,
                             0,
                             0,
                             vi.vivalinip,
                             @suma,
                             vi.Cuenta_Corriente_Inicio,
                             vi.Cuenta_Corriente_Final,
                             vi.Sucursal_Inicio,
                             vi.Sucursal_Final,
                             vi.codigo_carterasuper,
			     'RC',
                             vi.swift_corresponsal,
                             vi.swift_pagamos,
                             cifeccomp   ,
                             a.Codigo_Area,
                             vi.Precio_transferencia  ,
                             vi.Libro_transferencia   ,
                             vi.Interes_transferencia   
                       FROM  CARTERA_COMPRA_PACTO a, CARTERA_VENTA_PACTO vi
                       WHERE cinumdocu    = @nnumdocu AND
                             cicorrela    = @nCorrela AND
                             vi.vinumdocu = @nnumdocu AND
                             vi.vicorrela = @nCorrela AND
                             vi.vinumoper = @nNumoper

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO', 'Msg'    = "Problemas en proceso de recompras, Actualización de cartera  "
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN 1

         END

         UPDATE       CARTERA_DISPONIBLE
                SET   dinominal = dinominal + @nominal,
                      divptirc  = civptirc * (dinominal/cinominal),
                      divptirci = civptirc * (dinominal/cinominal)
                FROM  CARTERA_DISPONIBLE, CARTERA_COMPRA_PACTO
                WHERE dinumdocu = @nnumdocu AND
                      dicorrela = @ncorrela AND
                      ditipoper = 'CI'      AND
                      cinumdocu = @nnumdocu AND
                      cicorrela = @ncorrela

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = "Problemas en proceso de recompras, Actualización de disponiblidad "
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN 1

         END   

         DELETE CARTERA_VENTA_PACTO WHERE vinumdocu = @nnumdocu AND
                           vicorrela = @nCorrela AND
                           vinumoper = @nNumoper                                       

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = "Problemas en proceso de Recompras, Rebajar pacto"
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
/* REVISAR */          FROM  CORTE_VENDIDO
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
            SELECT      @nCantCort = cantidad,
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
                              FROM  CORTE 
                              WHERE conumdocu = @nNumdocu AND
                                    cocorrela = @nCorrela AND
                                    comtocort = @nMontCort
                     ) BEGIN
                      UPDATE       CORTE
                      SET   cocantcortd = cocantcortd + @nCantCort

                      WHERE conumdocu   = @nNumdocu AND
                            cocorrela   = @nCorrela AND
                            comtocort   = @nCantCort

               IF @@ERROR <> 0 BEGIN
                  SELECT 'ESTADO' = 'NO',
                         'Msg' = "Problemas en proceso de Recompras, actualización de cortes"
--                  ROLLBACK TRANSACTION
  	   	  SET nocount off 
                  RETURN 1

               END      

            END ELSE BEGIN
               INSERT INTO CORTE
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
                         'Msg'    = "Problemas en proceso de Recompras , actualización de cortes"
---                  ROLLBACK TRANSACTION
  	          SET nocount off 
                  RETURN 1

               END

            END

         END

      END

      DELETE CORTE_VENDIDO WHERE cvnumdocu = @nnumdocu AND 
         	                    cvcorrela = @nCorrela AND 
                                    cvnumoper = @nNumoper                                     

         IF @@ERROR <> 0 BEGIN
            SELECT 'ESTADO' = 'NO',
                   'Msg'    = "Problemas en eliminación de registros de Cortes Vendidos"
--            ROLLBACK TRANSACTION
	    SET nocount off 
            RETURN

         END


      CONTINUE

   END

/*==============================================================================================================================*/
/*                                                            VALE VISTAS                                                       */
/*==============================================================================================================================*/





		    INSERT INTO VIEW_VALE_VISTA_EMITIDO
			( 	Fecha_Generacion	,  
				Fecha_Emision		,
				Forma_Pago		,
				Id_Sistema		,
				Codigo_Producto		,
				Numero_Operacion	,
				Rut_Cliente		,
				Codigo_Cliente		,
				Documento_Monto		,
				Documento_Numero	,
				Documento_Estado	,
				Documento_Divide	,
				Documento_Protege	,
                                nombre_cliente          ,
				Codigo_Transaccion	,
				Numero_CtaCte		,  
				Codigo_Sucursal		,
				Concepto		,
				Tipo_Operacion		,
				Entregamos_Recibimos
			
			)
                   SELECT
             mofecpro, 
                           mofecpro,
                           moforpagv,
                           'BTR',
                           'RC',
                           monumoper,
                           morutcli,
                           mocodcli,
                           SUM(movalvenp),
                           1,
       			   'G',
                           'N',
                           CASE WHEN moforpagv = 1 THEN 'N'
                                ELSE 'S'
                                END,
                           ISNULL(( SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli ),'N/A') ,
                           CASE WHEN moforpagv = 4 THEN 'A'
                                ELSE '' END ,
                           Cuenta_Corriente_Final,
                           CASE WHEN Sucursal_Final = '' THEN 0 ELSE Sucursal_Final END,
                           '',
                           'C',
			   'E'
                     FROM  MOVIMIENTO_TRADER
                        ,  VIEW_DATOS_GENERALES
                        ,  VIEW_CLIENTE
                     WHERE  moforpagv IN(1,2,4)
		     and mofecpro = fecha_proceso
                     AND clrut    = morutcli
                     AND clcodigo = mocodcli
		     AND codigo_subproducto = 'RC'
                     GROUP BY
                              monumoper
                     ,        mofecpro
                     ,        moforpagv
                     ,        morutcli 
                     ,        mocodcli
                     ,        Cuenta_Corriente_Final
                     ,        Sucursal_Final


                  IF @@ERROR <> 0 BEGIN
                  SELECT 'ESTADO' = 'NO',
                         'MSG'    = 'Problemas en actualización Vale Vistas'
--                         ROLLBACK TRANSACTION
          	         SET NOCOUNT OFF
                         RETURN
                  END



	--UPDATE VIEW_DATOS_GENERALES SET acsw_rc = '1'




	SELECT @ntotalreg = COUNT(*) FROM #TMP
	SELECT	'ESTADO' = 'SI', 'msg' = RTRIM(CONVERT(VARCHAR(7),@ntotalreg))+' Vencimientos'

--	COMMIT TRANSACTION
   
END


GO
