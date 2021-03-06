USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_REVENTA_AUTOMATICA]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
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
   SET DATEFORMAT dmy
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
   DECLARE @ntotalreg2     NUMERIC(10,0)
   DECLARE @fecha_proceso  DATETIME
   DECLARE @numoper        NUMERIC(10)
   DECLARE @valvenc        NUMERIC(19,6)
   DECLARE @Precio_transferencia  FLOAT    ,
           @Libro_transferencia   FLOAT    ,
           @Interes_transferencia FLOAT   

   SET @fecha_proceso    = ( SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES )

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
          valvenc      NUMERIC(19,6)         NOT NULL,
          Precio_transferencia  FLOAT        NOT NULL   ,
          Libro_transferencia   FLOAT        NOT NULL   ,
          Interes_transferencia FLOAT        NOT NULL ,
          registro     INTEGER IDENTITY(1,1) NOT NULL
         )

   CREATE TABLE #TempCp
         (
          numdocu      NUMERIC(10,0)         NOT NULL,
          correla      NUMERIC(03,0)         NOT NULL,
          tipoper      CHAR(03)              NOT NULL,
          nominal      NUMERIC(19,4)         NOT NULL,
          vptirc       NUMERIC(19,4)         NOT NULL,
          registro     INTEGER IDENTITY(1,1) NOT NULL
         )
      
   /*===========================================================================================*/
   /*===========================================================================================*/
   SELECT       @dFeccal  = Fecha_proceso  
          FROM  VIEW_DATOS_GENERALES
   

--   BEGIN TRANSACTION

          INSERT #Temp
              SELECT      cinumdocu,
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
                          ciinstser    ,
                          civalvenc ,
                          Precio_transferencia  ,
                          Libro_transferencia   ,
                          Interes_transferencia
                 FROM     CARTERA_COMPRA_PACTO
                 WHERE    @dFeccal  >= cifecvenp
--                      AND (ciinstser <> 'IB' AND ciinstser <> 'TD' AND ciinstser <> 'LBC')
--                      AND  cimascara <> 'CLEAN'
                 ORDER BY cinumdocu

          INSERT #Temp
             SELECT   
                Numero_Operacion,
                Correlativo_Operacion,
                tipo_operacion,
                Nominal,
                Valor_Presente_Tir_Compra,
                Interes_Compra,
                Reajuste_Compra,
                Valor_Compra_UM,
                Valor_Compra,
                Codigo,
                Nominal_Pesos,
                Serie,
                Valor_Final,
                Precio_transferencia  ,
                Libro_transferencia   ,
                Interes_transferencia
           FROM   CARTERA_INTERBANCARIA
           WHERE  @dFeccal  >= Fecha_Vencimiento_Pacto

	   INSERT #TempCp
              SELECT      cpnumdocu,
                          cpcorrela,
                          'CP'     ,
                          cpnominal ,
                          cptircomp  
                 FROM     CARTERA_PROPIA
                 WHERE    @dFeccal  >= cpfecven                                                 
		 AND	  cpcodigo <> 98
                 ORDER BY cpnumdocu



   /*===========================================================================================*/
   /*===========================================================================================*/
   IF (SELECT COUNT(*) FROM #Temp)=0  AND  (SELECT COUNT(*) FROM #TempCp)=0 BEGIN

      SELECT 'ESTADO' ='SI','MSG'=' NO EXISTEN OPERACIONES DE COMPRAS CON PACTOS QUE VENZAN HOY'

      set nocount off	
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
                   @cinstser  = cinstser,
                   @valvenc   = valvenc,
                   @Precio_transferencia   = Precio_transferencia,
                   @Libro_transferencia    = Libro_transferencia,
                   @Interes_transferencia  = Interes_transferencia  
             FROM  #Temp
             WHERE registro   > @suma
      SET ROWCOUNT 0

      IF @cTipoper = '*' BEGIN
         BREAK

      END

      SELECT @mdse = inmdse FROM VIEW_INSTRUMENTO WHERE incodigo=@cod_ser

      IF @mdse = 'S' BEGIN
        SELECT       @tasemi   = 0.0,
                     @basemi   = 0.0
                FROM  VIEW_SERIE
                WHERE semascara = @cinstser

      END ELSE BEGIN
         SELECT       @monemi   = nsmonemi,
                      @tasemi   = ISNULL(nstasemi,0.0),
                      @basemi   = ISNULL(nsbasemi,0.0),
                      @rutemi   = nsrutemi
                FROM  NOSERIE
                WHERE nsnumdocu = @nNumdocu    AND
                   nscorrela = @nCorrela

      END



--Compras con Pacto
      INSERT INTO MOVIMIENTO_TRADER (
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
                         Cuenta_Corriente_Inicio,
                         Cuenta_Corriente_Final,
                         Sucursal_Inicio,
                         Sucursal_Final,
                         moimpreso,
                         Tipo_Inversion,
			 codigo_subproducto,
                         fecha_compra_original,
                         Codigo_Area,
                         Precio_transferencia  ,
                         Libro_transferencia   ,
                         Interes_transferencia 

                       )
             SELECT      @dFeccal,
                        cirutcart,
                        citipcart,
                         cinumdocu,
                         cicorrela,
                         cinumdocuo,
                         cicorrelao,

                         cinumdocu,
                         'RV' ,--ELSE 'CI' END ,

                         'CI' ,
                         ciinstser,
                         cimascara,
                         cicodigo,
                         ciseriado,
                         cifecemi,
                         cifecven,
                         cimonemi,
                         isnull(@tasemi,0),
                         isnull(@basemi,0),
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
                         civalinip+ciinteresci+cireajustci,
                         citaspact,
                         cibaspact,
                         cimonpact,
                         ciforpagi,
                         ciforpagv,
                         '',
                         cirutcli,
                         cicodcli,
                         '',
                           CONVERT( CHAR(15), GETDATE(), 108 ),
                           ISNULL(( SELECT mousuario  FROM MOVIMIENTO_TRADER WHERE monumoper = @nnumdocu
                                                           AND monumdocu = @nnumdocu
                                                           AND mocorrela = @nCorrela
                           ),@User) , 

                           ISNULL(( SELECT moterminal FROM MOVIMIENTO_TRADER WHERE monumoper = @nnumdocu
                                                           AND monumdocu = @nnumdocu
                                                           AND mocorrela = @nCorrela
                           ),@Terminal)    , 

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
                         civalcomp,
                         civalcomu,
                         0,
                         0,
                         ciinteresci,
                         cireajustci,
                         0,
                         0,
                         civalinip,
                         Cuenta_Corriente_Inicio,
                         Cuenta_Corriente_Final,
                         Sucursal_Inicio,
                         Sucursal_Final,
                         '',
                         Tipo_Inversion,
--                         civalvenc,
			  'RV'		,
                        cifeccomp,
                        Codigo_Area,
                        @Precio_transferencia  ,
                        @Libro_transferencia   ,
                        @Interes_transferencia 
                   FROM  CARTERA_COMPRA_PACTO
                   WHERE cinumdocu = @nnumdocu    AND
                         cicorrela = @nCorrela

--Interbancarios
      INSERT INTO MOVIMIENTO_TRADER (
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
                         Cuenta_Corriente_Inicio,
                         Cuenta_Corriente_Final,
                         Sucursal_Inicio,
                         Sucursal_Final,
                         moimpreso,
                         Tipo_Inversion,
--                         monominalp,
			 codigo_subproducto,
                         swift_corresponsal,
                         swift_pagamos,
                         Codigo_Area,
                         Precio_transferencia  ,
                         Libro_transferencia   ,
                         Interes_transferencia 
                       )
             SELECT      @dFeccal,
                         Rut_Cartera,
                         Tipo_Cartera,
                         Numero_Documento,
                         Correlativo_Operacion,
                         Numero_Documento,
                         Correlativo_Operacion,

                         Numero_Operacion,
                         'tipoper'   = CASE WHEN Tipo_Operacion = 'LBC' THEN 'VBC'
                                            WHEN Tipo_Operacion = 'IB'  THEN 'VIB'
                                            WHEN Tipo_Operacion = 'TD'  THEN 'VTD'
                                            WHEN Tipo_Operacion = 'FPD' THEN 'VFP'
                                            ELSE 'RV' END ,--ELSE 'CI' END ,

                         'tipopero'  = CASE WHEN Tipo_Operacion = 'LBC' THEN 'LBC'
                                            WHEN Tipo_Operacion = 'IB'  THEN 'IB'
                                            WHEN Tipo_Operacion = 'TD'  THEN 'TD'
                                            WHEN Tipo_Operacion = 'FPD' THEN 'FPD'
                                            ELSE 'CI' END,
                         Serie,
                         Mascara,
                         codigo,
                         'N',
                         Fecha_Inicio_Pacto,
                         Fecha_Vencimiento_Pacto,
                         Moneda_Pacto,
                         isnull(Tasa_Pacto,0),
                         isnull(Base_Pacto,0),
                         Rut_Cliente,
                         @nominal,
                         @vptirc,
                         @vptirc,
                         Valor_Compra_UM,
                         0,
                         0,
                         Tasa_Pacto,
                         0,
                         0,
                         0,
                         Fecha_Inicio_Pacto,
                         Fecha_Vencimiento_Pacto,
                         Valor_Inicial,
                         Valor_Inicial+Interes_Compra+Reajuste_Compra,
                         Tasa_Pacto,
                         Base_Pacto,
                         Moneda_Pacto,
                         Forma_Pago_Inicio,
                         Forma_Pago_Vencimiento,
                         '',
                         Rut_Cliente,
                         Codigo_Cliente,
                         '',
                           CONVERT( CHAR(15), GETDATE(), 108 ),
                           ISNULL(( SELECT mousuario  FROM MOVIMIENTO_TRADER WHERE monumoper = @nnumdocu
                                                           AND monumdocu = @nnumdocu
                                                           AND mocorrela = @nCorrela
                           ),@User) , 

                           ISNULL(( SELECT moterminal FROM MOVIMIENTO_TRADER WHERE monumoper = @nnumdocu
                                                           AND monumdocu = @nnumdocu
                         AND mocorrela = @nCorrela
                           ),@Terminal)    , 

                         Capital_Compra,
                         Interes_Compra,
                         Reajuste_Compra,
                         0,
                         Capital_Compra,
                         Interes_Compra,
                         Reajuste_Compra,
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         Nominal_Pesos,
                         Valor_Compra,
                         Valor_Compra_UM,
                         0,
                         0,
                         Interes_Compra,
                         Reajuste_Compra,
                         0,
                         0,
                         Valor_Inicial,
                         Cuenta_Corriente_Inicio,
                         Cuenta_Corriente_Final,
                         Sucursal_Inicio,
                         Sucursal_Final,
                         '',
                         Tipo_Inversion,
--                         civalvenc,
			  CASE	WHEN Tipo_Operacion = 'LBC' THEN 'VBC'
				WHEN Tipo_Operacion = 'IB'  THEN 'VIB'
				WHEN Tipo_Operacion = 'TD'  THEN 'VTD'
				WHEN Tipo_Operacion = 'FPD' THEN 'VFP'
				ELSE 'RV' END,
                           swift_corresponsal,
                           swift_pagamos,
                           Codigo_Area,
                           @Precio_transferencia,
                           @Libro_transferencia,
                           @Interes_transferencia
                   FROM  CARTERA_INTERBANCARIA
                   WHERE numero_documento = @nnumdocu    AND
                         Correlativo_Operacion = @nCorrela


      IF @@ERROR <> 0 BEGIN
         SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN GRABACIóN DEL ARCHIVO DE MOVIMIENTOS'
--         ROLLBACK TRANSACTION
  	 set nocount off
         RETURN 
      END

      DELETE CARTERA_COMPRA_PACTO WHERE cinumdocu = @nnumdocu AND cicorrela = @ncorrela

      IF @@ERROR <> 0 BEGIN
         SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DE COMPRAS CON PACTO'
--         ROLLBACK TRANSACTION
   	 set nocount off
         RETURN
      END   

      DELETE CORTE WHERE conumdocu = @nnumdocu AND cocorrela = @ncorrela

      IF @@ERROR <> 0 BEGIN
         SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DE CORTES'
--         ROLLBACK TRANSACTION
	set nocount off
         RETURN
      END         

      UPDATE       CARTERA_DISPONIBLE
             SET   dinominal = dinominal - @nominal,
                   divptirc  = divptirc  + @vptirc
             WHERE dinumdocu = @nnumdocu    AND
                   dicorrela = @ncorrela    AND
                   ditipoper = 'CI'
   
      IF @@ERROR <> 0 BEGIN
         SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DE DISPONIBILIDAD'
--         ROLLBACK TRANSACTION
 	 set nocount off
         RETURN

      END

      CONTINUE
      
   END

   INSERT MOVIMIENTO_TRADER
       		(
		mofecpro				,
		morutcart				,
		motipcart				,
		monumdocu				,
		mocorrela				,
		monumdocuo				,
		mocorrelao				,
		monumoper				,
		motipoper				,
		motipopero				,
		moinstser				,
		momascara				,
		mocodigo				,
		mofecemi				,
		mofecven				,
 		momonemi				,
		motasemi				,

		mobasemi				,
		morutemi				,
		monominal				,
		monumucup				,
		motir				 	,
		mopvp					,
		movpar					,
		motasest				,
		moforpagi				,
		mocondpacto				,
		morutcli				,
		mocodcli				,
		motipret				,
		mohora					,
		mousuario				,

		moterminal				,
		mocapitali				,
		movpreseni				,
		movalcomp				,
		movalcomu				,
		mointeres				,
		moreajuste				,
		moutilidad				,
		moperdida				,
		movalven				,
		movpresen				,
		moseriado				,
		mocorvent 		                ,
                moclave_dcv				,
		modcv					,
		fecha_compra_original			,
		valor_compra_original			,
		valor_compra_um_original		,
		tir_compra_original			,
		valor_par_compra_original		,
		porcentaje_valor_par_compra_original	,

		-- campos fueron agregados el 19/02/2001 
		-- para el banco del desarrollo

		codigo_carterasuper			,
		tipo_cartera_financiera			, 
		mercado					, 
		sucursal				, 
		id_sistema				, 
		fecha_pagomañana			, 
		laminas					, 
		tipo_inversion				,
		cuenta_corriente_inicio			,
		cuenta_corriente_final			,
		sucursal_inicio				,
		sucursal_final		 		,
		codigo_subproducto			,
                Codigo_Area

		)
	SELECT
		
		@fecha_proceso				,
		cprutcart				,
		cptipcart				,
		cpnumdocu				,
		cpcorrela				,
		cpnumdocu				,
               	cpcorrela				,
            
                cpnumdocu                               ,  --		@numoper,
		'VCI'					,
		'CP'					,
		cpinstser				,
		cpmascara				,
		cpcodigo				,

		'cfecemi'				= CASE WHEN cpseriado = 'S' THEN ( SELECT sefecemi FROM VIEW_SERIE   WHERE cpmascara = seserie )
                                                               ELSE                      ( SELECT nsfecemi FROM NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela )
                                                               END   ,
		'cfecven'			        = CASE WHEN cpseriado = 'S' THEN ( SELECT sefecven FROM VIEW_SERIE   WHERE cpmascara = seserie )
                                                               ELSE                      ( SELECT nsfecven FROM NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela )
                                                               END   ,
		'nmonemi'			        = CASE WHEN cpseriado = 'S' THEN ( SELECT semonemi FROM VIEW_SERIE   WHERE cpmascara = seserie )
                                                               ELSE     ( SELECT nsmonemi FROM NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela )
               END   ,
		'ntasemi'				= CASE WHEN cpseriado = 'S' THEN ( SELECT setasemi FROM VIEW_SERIE   WHERE cpmascara = seserie )
                                                               ELSE                      ( SELECT nstasemi FROM NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela )
                                                               END   ,
		'nbasemi'				= ISNULL(CASE WHEN cpseriado = 'S' THEN ( SELECT sebasemi FROM VIEW_SERIE   WHERE cpmascara = seserie )
                                                                      ELSE     ( SELECT nsbasemi FROM NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela )
                                                                      END,0)   ,
		'nrutemi'				= CASE WHEN cpseriado = 'S' THEN ( SELECT serutemi FROM VIEW_SERIE   WHERE cpmascara = seserie )
                                                               ELSE                      ( SELECT nsrutemi FROM NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela )
                                       END   ,

		cpnominal				,
		cpnumucup 				,
		cptircomp				,
		cppvpcomp				,
		cpvpcomp				,
		cptasest				,
		2            				,
		' '					,
		'nrutemi'				= CASE WHEN cpseriado = 'S' THEN ( SELECT serutemi FROM VIEW_SERIE   WHERE cpmascara = seserie )
                                                               ELSE                      ( SELECT nsrutemi FROM NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela )
                                       END   ,
		1         				,
		1			         	,
                CONVERT( CHAR(15), GETDATE(), 108 ),
                ISNULL(( SELECT mousuario  FROM MOVIMIENTO_TRADER WHERE monumoper = @nnumdocu
                                                       AND monumdocu = @nnumdocu
                                                      AND mocorrela = @nCorrela
            AND motipoper = 'CP'
                           ),@User) , 

                ISNULL(( SELECT moterminal FROM MOVIMIENTO_TRADER WHERE monumoper = @nnumdocu
                                                       AND monumdocu = @nnumdocu
                                                       AND mocorrela = @nCorrela
                                                       AND motipoper = 'CP'
                          ),@Terminal)    ,
		isnull(cpcapitalc,0)				,
		isnull(cpcapitalc,0)				,
		isnull(cpcapitalc,0)				,
		isnull(cpvalcomu,0)				,
		isnull(cpinteresc,0)				,
		isnull(cpreajustc,0)				,
		isnull(0,0)			         	,
		isnull(0,0)			         	,
		isnull(cpcapitalc + cpinteresc + cpreajustc,0)  ,		
		isnull(cpcapitalc + cpinteresc + cpreajustc,0)	,
		cpseriado					,
		0                                               ,
                ' '		         			,
		'P'            					,
   	   -- variables fueron agregados el 13/02/2001 
	      -- para el banco del desarrollo
                fecha_compra_original                           ,
                valor_compra_original                           ,
                valor_compra_um_original                        ,
                tir_compra_original                             , 
                valor_par_compra_original                       , 
                porcentaje_valor_par_compra_original            ,
		codigo_carterasuper				,
		tipo_cartera_financiera		         	,
		mercado				         	,
		sucursal					,
		id_sistema					,
		fecha_pagomañana				,
		laminas					        ,
		tipo_inversion					,
		''						,
		''						,
		''						,
		''						,
		'VCI'						,    
                Codigo_Area
   FROM CARTERA_PROPIA
       WHERE cpfecven   <=   @fecha_proceso
       AND   cpcodigo <> 98
         AND cpnominal  > 0

   DELETE CORTE 
   FROM CARTERA_PROPIA
   WHERE cpnumdocu = conumdocu
   AND   cpcorrela = cocorrela
   AND   cpfecven <= @dFeccal
   AND   cpcodigo <> 98

   IF @@ERROR <> 0 BEGIN
       SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN GRABACION DE TABLA DE COMPRA PROPIA'
--       ROLLBACK TRANSACTION
       SET NOCOUNT OFF
       RETURN
   END


/*******************************************************************************************************************************************
                                          VALE VISTA
 *******************************************************************************************************************************************/

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
				Tipo_Operacion	        ,
                                Entregamos_Recibimos
			)
                   SELECT
                           mofecpro,
                           mofecpro,
                           moforpagv,
                           'BTR',
                           motipoper,
                           monumoper,
                           morutcli,
                           mocodcli,
                           CASE WHEN motipoper = 'VIB' THEN  SUM(movpresen)
                                ELSE SUM(movalvenp)
                                END,
                           monumoper,
                           'G',
                           'N',
                           CASE WHEN moforpagv = 1 THEN 'N' 
                                ELSE 'S' 
                                END,
                           ( SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli ) ,
			         CASE WHEN moforpagv = 4 AND momascara = 'ICOL'  THEN 'C'
                                WHEN moforpagv = 4 AND momascara = 'ICAP'  THEN 'A'
                                WHEN moforpagv = 4 AND motipoper = 'RV'    THEN 'C'
                                ELSE ''
                                END ,
                           Cuenta_Corriente_Final,
                           '0',
                           '',
                           'C',
                           (CASE 
                                WHEN moforpagv IN(1,2,4) AND motipoper = 'VIB' THEN 'E'
                                ELSE 'R'
                            END)
                     FROM  MOVIMIENTO_TRADER,VIEW_DATOS_GENERALES
                     WHERE  motipoper = 'VIB'         AND
                            mofecpro  = fecha_proceso
                    GROUP BY
                             motipoper
                    ,        moforpagv
                    ,        morutcli
                    ,        momascara
                    ,        mocodcli
                    ,        Cuenta_Corriente_Final
                    ,        Sucursal_Final
                    ,        mofecpro
                    ,        monumoper

/*                   SELECT
                           mofecpro,
                           mofecpro,
                           moforpagv,
                           'BTR',
                           motipoper,
                           monumoper,
                           morutcli,
                           mocodcli,
                           CASE WHEN motipoper = 'VIB' THEN  SUM(movpresen)
                                ELSE SUM(movalvenp)
                                END,
                           monumoper,
                           'G',
                           'N',
                           CASE WHEN moforpagv = 1 THEN 'N' 
                                ELSE 'S' 
                                END,
                           ( SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli ) ,
                           CASE WHEN moforpagv = 4 AND motipoper = 'RV'    THEN 'C'
                                ELSE ''
                                END ,
                           Cuenta_Corriente_Final,
                           '0',
                           '',
                           'C',
                           (CASE 
                                WHEN moforpagv IN(1,2,4) AND motipoper = 'VIB' THEN 'E'
                                ELSE 'R'
                            END)
                     FROM  MOVIMIENTO_TRADER,VIEW_DATOS_GENERALES
                     WHERE  motipoper = 'RV'          AND
                            mofecpro = fecha_proceso
                     GROUP BY
                             motipoper
                    ,        moforpagv
                    ,        morutcli
                    ,        mocodcli
                    ,        Cuenta_Corriente_Final
                    ,        Sucursal_Final
                    ,        mofecpro
                    ,        monumoper
*/
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
				Tipo_Operacion	        ,
                                Entregamos_Recibimos
			)
                   SELECT
                           mofecpro,
                           mofecpro,
                           moforpagv,
                           'BTR',
                           motipoper,
                           monumoper,
                           morutcli,
                           mocodcli,
                           CASE WHEN motipoper = 'VIB' THEN  SUM(movpresen)
                                ELSE SUM(movalvenp)
                                END,
                           monumoper,
                           'G',
                           'N',
                           CASE WHEN moforpagv = 1 THEN 'N' 
                                ELSE 'S' 
                                END,
                           ( SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli ) ,
                           CASE WHEN moforpagv = 4 AND motipoper = 'RV'    THEN 'C'
                                ELSE ''
                                END ,
                           Cuenta_Corriente_Final,
                           '0',
                           '',
                           'C',
                           (CASE 
                                WHEN moforpagv IN(1,2,4) AND motipoper = 'VIB' THEN 'E'
                                ELSE 'R'
                            END)
                     FROM  MOVIMIENTO_TRADER,VIEW_DATOS_GENERALES
                     WHERE  motipoper = 'RV'          AND
                            mofecpro = fecha_proceso
                     GROUP BY
                             motipoper
                    ,        moforpagv
                    ,        morutcli
                    ,        mocodcli
                    ,        Cuenta_Corriente_Final
                    ,        Sucursal_Final
                    ,        mofecpro
                    ,        monumoper


/*******************************************************************************/
--                                    CUPONES
/*******************************************************************************/

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
				Tipo_Operacion	        ,
                                Entregamos_Recibimos	
			)
                    SELECT 
                        RSFECPROX,
                        RSFECPROX,
                        (CASE WHEN rsrutemis = 97029000 THEN 7 ELSE 2 END),  --SOLO CtaCte Bcch o Vale Vista
                        'BTR',
                        (CASE WHEN rsrutemis = 97029000 THEN 'VBC' ELSE 'VCI' END),
                        1,
                        rsrutemis,
                        1,
                        sum(rsflujo),
                        1,
                        'G',
                        'N',
                        'S' ,
                        (SELECT EMNOMBRE FROM VIEW_EMISOR WHERE RSRUTEMIS = EMRUT AND EMCODIGO = 1 ),
                        '',
                        '',
                        '0',
                        '',
                        'C',
                        'R'
                       FROM RESULTADO_DEVENGO , VIEW_DATOS_GENERALES
                    WHERE   RSTIPOPER = 'VC'
                        AND RSFECPROX = fecha_proceso
                    GROUP BY
                             RSFECPROX
                    ,        rstipoper
                    ,        rsrutemis


/*******************************************************************************/

--                     FROM  MOVIMIENTO_TRADER,VIEW_DATOS_GENERALES
--                     WHERE((moforpagv IN(1,2,4) AND motipoper = 'VIB' AND momascara = 'ICAP') OR
--                           (moforpagv IN(4)     AND motipoper = 'VIB' AND momascara = 'ICOL')) 
--           	        AND mofecpro = fecha_proceso

--                          (moforpagv IN(1,2,4)
--                       AND motipoper IN('RV')
--                          )

--                     GROUP BY
--                              motipoper
--                     ,        moforpagv
--                     ,        morutcli
--                     ,        mocodcli
--                     ,        Cuenta_Corriente_Final
--                     ,        Sucursal_Final
--                     ,        momascara
--                     ,        mofecpro
--                     ,        monumoper

          
/*******************************************************************************************************************************************
                                          Actualizacion de campo diferencia_contable de la tabla valorizacion_mercado
 *******************************************************************************************************************************************/

         update valorizacion_mercado
         set   diferencia_contable = (diferencia_mercado * (valor_nominal - monominal)) / valor_nominal
         from  MOVIMIENTO_TRADER
         where monumdocu = numero_documento
         and   mocorrela = correlativo
         and   motipoper = 'VCI'
         and   rut_cartera=rut_cartera
         and   numero_documento=@nnumdocu
         and   correlativo=@ncorrela
         and   tipo_operacion = 'CP'
         and   fecha_valorizacion = DATEADD(dd,-1,RTRIM(LTRIM(STR(DATEPART(year,@fecha_proceso)))) + CASE WHEN LEN(RTRIM(LTRIM(STR(DATEPART(month,@fecha_proceso))))) = 1 THEN "0" + RTRIM(LTRIM(STR(DATEPART(month,@fecha_proceso)))) ELSE RTRIM(LTRIM(STR(DATEPART(month,@fecha_proceso)))) END + "01")
	 and   mofecpro = @fecha_proceso 
/*******************************************************************************************************************************************/
/*******************************************************************************************************************************************/

   DELETE CARTERA_INTERBANCARIA WHERE Fecha_Vencimiento_Pacto <= @dFeccal AND tipo_operacion in ('IB','TD','LBC', 'FPD')
 
   IF @@ERROR <> 0 BEGIN 
--      ROLLBACK TRANSACTION
      SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE INTERBANCARIOS'
      SET NOCOUNT OFF
      RETURN
   END
   

   DELETE CARTERA_PROPIA WHERE cpfecven <= @dFeccal AND cpcodigo <> 98

   IF @@ERROR <> 0 BEGIN 
--      ROLLBACK TRANSACTION
      SELECT 'ESTADO' = 'NO', 'MSG' = 'PROBLEMAS EN ELIMINACIóN DE TABLA DE COMPRAS PROPIAS'
	SET NOCOUNT OFF
    RETURN
   END

   SELECT @ntotalreg  = COUNT(*) FROM #Temp
   SELECT @ntotalreg2 = COUNT(*) FROM #TempCp 

   SELECT 'ESTADO' = 'SI',
          'Msg' = RTRIM( CONVERT(VARCHAR(7),@ntotalreg))+' Vencimientos' + SPACE(100) + RTRIM( CONVERT(VARCHAR(7),@ntotalreg2))+' Vencimientos'


   DROP TABLE #TeMP

   SET NOCOUNT OFF
END



GO
