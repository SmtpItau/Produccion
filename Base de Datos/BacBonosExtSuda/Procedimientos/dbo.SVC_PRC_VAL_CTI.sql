USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_PRC_VAL_CTI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_PRC_VAL_CTI]
               (
		@dFecPro	DATETIME	,
		@TipFomulas	CHAR(1)		,
		@tipo_cal	FLOAT		,
		@cod_familia	NUMERIC(04)	,
		@cod_nemo	CHAR(20)	,
		@fecha_vcto	DATETIME	,
		@TR		FLOAT	OUTPUT	,
		@TE		FLOAT		,
		@TV		FLOAT		,
		@TT		FLOAT		,
		@BA		FLOAT		,
		@BF		FLOAT		,
		@NOM		FLOAT		,
		@MT		FLOAT	OUTPUT	,
		@VV		FLOAT		,
		@VP		FLOAT		,
		@PVP		FLOAT		,
		@VAN		FLOAT		,
		@FP		DATETIME	,
		@FE		DATETIME	,
		@FV		DATETIME	,
		@FU		DATETIME	,
		@FX		DATETIME	,
		@FC		DATETIME	,
		@CI		FLOAT		,
		@CT		FLOAT		,
		@INDEV		FLOAT		,
		@PRINC		FLOAT		,
		@FIP		DATETIME	,
		@CAP		FLOAT		,
		@INCTR		FLOAT		,
		@SPREAD		FLOAT		,
		@FACTOR		FLOAT		,
                @DUR_MAC        FLOAT 	        ,
                @DUR_MOD        FLOAT 	        ,
                @CONVEXI        FLOAT 	        )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @cVariab	CHAR(10)
	DECLARE @cFormu		CHAR(100)
	DECLARE @cTipForm	CHAR(1)		,
		@param1		CHAR(15) 	,
		@param2		CHAR(15)	,
		@param3		CHAR(15) 	,
		@param4		CHAR(15)

	DECLARE	@fecini		DATETIME,
		@fecvto		DATETIME,
		@DIFDIAS	INTEGER

	DECLARE	@TD_SUMINT	FLOAT		,
		@TD_SUMAMO	FLOAT		,
		@TD_SUMFLU	FLOAT		,
		@TD_SUMSAL	FLOAT		,
		@TD_SUMFDE	FLOAT		,
		@PX_IN		FLOAT		,
		@PX_AM		FLOAT		,
		@DIFDPR		FLOAT		,
		@V001		FLOAT		,
		@V002		FLOAT		,
		@V003		FLOAT		,
		@V004		FLOAT		,
		@V005		FLOAT		,
		@V006		FLOAT		,
		@V007		FLOAT		,
		@V008		FLOAT		,
		@V009		FLOAT		,
		@V010		FLOAT

	DECLARE @cont		INTEGER	,
		@cont_For	INTEGER	,
		@NCUP		FLOAT 	,
		@FVCP 		DATETIME,
		@INTE		FLOAT 	, 
		@AMOR 		FLOAT 	,
		@FLUJ 		FLOAT 	,
		@SALD		FLOAT 	,
		@DIFD 		FLOAT 	
	DECLARE @nError		INTEGER

	DECLARE @Cup_ini	FLOAT
	DECLARE @Cup_Fin	FLOAT

	DECLARE	@Precis		FLOAT 	,
		@z_TR		FLOAT 	,
		@z_Pvp		FLOAT 	,
		@z_MT		FLOAT 	,
		@xMA		FLOAT 	,
		@xME		FLOAT 	,
		@xx		FLOAT


	SELECT	@nError = 0


	DECLARE @SQLString	NVARCHAR(1000)
	DECLARE @SQLString_Pru	NVARCHAR(1000)
	DECLARE @ParmDefinition NVARCHAR(1000)

	CREATE TABLE #CT_TABLA_DESARROLLO
	(	NCUP	INTEGER,
		FVCP	DATETIME,
		INTE	FLOAT	,
		AMOR	FLOAT	,
		FLUJ	FLOAT	,
		SALD	FLOAT	,
		DIFD	FLOAT	,
		FLDE	FLOAT	,
		FACTOR  FLOAT   )

	INSERT	INTO #CT_TABLA_DESARROLLO
	SELECT	num_cupon		,
		fecha_vcto_cupon	,
		interes			,
		amortizacion		,
		flujo			,
		saldo			,
		DATEDIFF(DAY,@dFecPro,fecha_vcto_cupon),
		0			,
		Factor
	FROM	TEXT_DSA
	WHERE	cod_familia = @cod_familia
	AND	cod_nemo    = @cod_nemo
--  	AND	fec_vcto    = @fecha_vcto


	SELECT	@FU = @FE
	SELECT	@FX = @FV

	IF EXISTS( SELECT FVCP FROM #CT_TABLA_DESARROLLO WHERE FVCP < @dFecPro )
		SELECT	@FU = MAX(FVCP) FROM #CT_TABLA_DESARROLLO WHERE FVCP < @dFecPro

	SELECT	@Fx = MIN(FVCP) FROM #CT_TABLA_DESARROLLO WHERE FVCP > @dFecPro
	SELECT	@CI = MIN(NCUP) FROM #CT_TABLA_DESARROLLO WHERE FVCP > @dFecPro
	SELECT	@CT = MAX(NCUP) FROM #CT_TABLA_DESARROLLO 

	SELECT	@V001		= 	10	,
		@V002		= 	10	,
		@V003		= 	10	,
		@V004		= 	10	,
		@V005		= 	10	,
		@V006		= 	10	,
		@V007		= 	10	,
		@V008		= 	10	,
		@V009		= 	10	,
		@V010		= 	10	,
		@PX_IN		=	10	,
		@PX_AM		=	10	

	SELECT	@TD_SUMINT = SUM(INTE),
		@TD_SUMAMO = SUM(AMOR),
		@TD_SUMFLU = SUM(FLUJ),
		@TD_SUMSAL = SUM(SALD),
		@TD_SUMFDE = SUM(FLDE)
	FROM	#CT_TABLA_DESARROLLO
	WHERE	FVCP > @dFecPro

	CREATE TABLE #CT_TMP_VALORIZACION
	(	TR		FLOAT		,
		TE		FLOAT		,
		TV		FLOAT		,
		TT		FLOAT		,
		BA		FLOAT		,
		BF		FLOAT		,
		NOM		FLOAT		,
		MT		FLOAT		,
		VV		FLOAT		,
		VP		FLOAT		,
		PVP		FLOAT		,
		VAN		FLOAT		,
		FP		DATETIME	,
		FE		DATETIME	,
		FV		DATETIME	,
		FU		DATETIME	,
		FX		DATETIME	,
		FC		DATETIME	,
		CI		FLOAT		,
		CT		FLOAT		,
		INDEV		FLOAT		,
		PRINC		FLOAT		,
		FIP		DATETIME	,
		CAP		FLOAT		,
		INCTR		FLOAT		,
		TD_SUMINT	FLOAT		,
		TD_SUMAMO	FLOAT		,
		TD_SUMFLU	FLOAT		,
		TD_SUMSAL	FLOAT		,
		TD_SUMFDE	FLOAT		,
		PX_IN		FLOAT		,
		PX_AM		FLOAT		,
		V001		FLOAT		,
		V002		FLOAT		,
		V003		FLOAT		,
		V004		FLOAT		,
		V005		FLOAT		,
		V006		FLOAT		,
		V007		FLOAT		,
		V008		FLOAT		,
		V009		FLOAT		,
		V010		FLOAT		,		
		SPREAD		FLOAT		,
		FACTOR		FLOAT		,
                DUR_MAC         FLOAT 	        ,
                DUR_MOD         FLOAT 	        ,
                CONVEXI         FLOAT 	        )

	INSERT INTO #CT_TMP_VALORIZACION
	SELECT	@TR,
		@TE,
		@TV,
		@TT,
		@BA,
		@BF,
		@NOM,
		@MT,
		@VV,
		@VP,
		@PVP,
		@VAN,
		@FP,
		@FE,
		@FV,
		@FU,
		@FX,
		@FC,
		@CI,
		@CT,
		@INDEV,
		@PRINC,
		@FIP,
		@CAP,
		@INCTR,
		@TD_SUMINT,
		@TD_SUMAMO,
		@TD_SUMFLU,
		@TD_SUMSAL,
		@TD_SUMFDE,
		@PX_IN,
		@PX_AM,
		@V001,
		@V002,
		@V003,
		@V004,
		@V005,
		@V006,
		@V007,
		@V008,
		@V009,
		@V010,
		@SPREAD,	
		@FACTOR,
                @DUR_MAC,
                @DUR_MOD,
                @CONVEXI

	SELECT @cont = 0

        CREATE TABLE #CT_TMP_FORMULA
        (    Fecha_vcto   DATETIME   NOT NULL DEFAULT('')
        ,    Num_linea    NUMERIC(5) NOT NULL DEFAULT(0)
        ,    variable     CHAR(15)   NOT NULL DEFAULT('')
        ,    formula      CHAR(100)  NOT NULL DEFAULT('')
        ,    Tipo_formula CHAR(1)    NOT NULL DEFAULT('')
        ,    Parametro1   CHAR(15)   NOT NULL DEFAULT('')
        ,    Parametro2   CHAR(15)   NOT NULL DEFAULT('')
        ,    Parametro3   CHAR(15)   NOT NULL DEFAULT('')
        ,    Parametro4   CHAR(15)   NOT NULL DEFAULT('')
        )
/*
	SELECT	Fecha_vcto	,
		Num_linea	,
		variable	,
		formula		,
		Tipo_formula	,
		Parametro1	,
		Parametro2	,
		Parametro3	,
		Parametro4      
	INTO	#CT_TMP_FORMULA
	FROM	text_frm

	DELETE #CT_TMP_FORMULA
*/

	IF @TipFomulas = 'P'
		INSERT INTO #CT_TMP_FORMULA
                SELECT	Fecha_vcto
		,	CONVERT(NUMERIC(5),Num_linea)
		,	CONVERT(CHAR(15),variable)
		,	CONVERT(CHAR(100),formula)
		,	CONVERT(CHAR(1),Tipo_formula)
		,	CONVERT(CHAR(15),Parametro1)
		,	CONVERT(CHAR(15),Parametro2)
		,	CONVERT(CHAR(15),Parametro3)
		,	CONVERT(CHAR(15),Parametro4)
		FROM	text_val_frm
		WHERE	cod_familia = @cod_familia
		AND	cod_nemo    = @cod_nemo
		AND	fecha_vcto  = @fecha_vcto
		AND	Tipo_cal    = @tipo_cal
	ELSE
		INSERT INTO #CT_TMP_FORMULA
                SELECT	Fecha_vcto
		,	CONVERT(NUMERIC(5),Num_linea)
		,	CONVERT(CHAR(15),variable)
		,	CONVERT(CHAR(100),formula)
		,	CONVERT(CHAR(1),Tipo_formula)
		,	CONVERT(CHAR(15),Parametro1)
		,	CONVERT(CHAR(15),Parametro2)
		,	CONVERT(CHAR(15),Parametro3)
		,	CONVERT(CHAR(15),Parametro4)
		FROM	text_frm
		WHERE	cod_familia = @cod_familia
		AND	cod_nemo    = @cod_nemo
		AND	fecha_vcto  = @fecha_vcto
		AND	Tipo_cal    = @tipo_cal
		

	SELECT @cont_For = 0

	WHILE 1=1
	BEGIN

		SELECT	@cVariab = '*'

		SET ROWCOUNT 1

		SELECT	@cont_For	= Num_linea	,
			@cVariab	= variable	,
			@cFormu		= formula	,
			@cTipForm	= Tipo_formula	,
			@param1		= Parametro1	,
			@param2		= Parametro2	,
			@param3		= Parametro3	,
			@param4		= Parametro4     
		FROM 	#CT_TMP_FORMULA
		WHERE	Num_linea > @cont_For
		ORDER BY Num_linea

		SET ROWCOUNT 0


	IF @cVariab = '*' BREAK


	IF @cTipForm = 'D'
	BEGIN

		CREATE TABLE #CT_TMP_Cupones
		(	Cup_ini		FLOAT		,
			Cup_Fin		FLOAT		)

		INSERT INTO #CT_TMP_Cupones SELECT 0, 0


		SET @SQLString = 'UPDATE #CT_TMP_Cupones SET Cup_ini = ' + @param3
		SET @ParmDefinition = N'@CI FLOAT,@CT FLOAT, @Cup_ini FLOAT'
		EXECUTE sp_executesql @SQLString , @ParmDefinition, @CI, @CT, @Cup_ini


		SET @SQLString = 'UPDATE #CT_TMP_Cupones SET Cup_Fin = ' + @param4
		SET @ParmDefinition = N'@CI FLOAT,@CT FLOAT,@Cup_Fin FLOAT'
		EXECUTE sp_executesql @SQLString , @ParmDefinition, @CI, @CT, @Cup_Fin

		SELECT	@Cup_ini = Cup_ini,
			@Cup_fin = Cup_Fin
		FROM	#CT_TMP_Cupones

		SELECT @cont = 0

		WHILE 1=1
		BEGIN

			SELECT @nError = 0

			SET ROWCOUNT 1

			SELECT	@nError = 100,
				@NCUP = NCUP,
				@FVCP = FVCP,
				@INTE = INTE,
				@AMOR = AMOR,
				@FLUJ = FLUJ,
				@SALD = SALD,
				@DIFD = DIFD,
				@cont = NCUP
			FROM	#CT_TABLA_DESARROLLO
			WHERE	NCUP > @cont
			AND	NCUP >= @Cup_Ini
			AND	NCUP <= @Cup_Fin
			ORDER BY NCUP

			SET ROWCOUNT 0

			IF @nError = 0	BREAK

			IF @cFormu = 'DIFDIA_REALES()' 
			BEGIN

				IF @param1 = '@FC,@FU' BEGIN
					SELECT @param1 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)
				END
				IF @param2 = '@FC,@FU' BEGIN
					SELECT @param2 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)
				END 

				SET @SQLString = 'UPDATE #CT_TABLA_DESARROLLO SET ' + @cVariab + ' = DATEDIFF(DAY, ' + @param1 + ',' + @param2 + ') WHERE NCUP = @NCUP'

			END
			ELSE

			IF @cFormu = 'DIFDIA_BASE30()' 
		        BEGIN
				SET @SQLString = 'UPDATE #CT_TABLA_DESARROLLO SET ' + @cVariab + ' = @Var_DIFDIA_30 WHERE NCUP = @NCUP'
			END
			ELSE
			BEGIN
				SET @SQLString = 'UPDATE #CT_TABLA_DESARROLLO SET ' + @cVariab + ' = ' + @cFormu + ' WHERE NCUP = @NCUP'
			END


			SET @ParmDefinition = N'@TR FLOAT, @TE FLOAT ,@TV FLOAT ,@TT FLOAT ,@BA FLOAT ,@BF FLOAT ,@NOM FLOAT ,@MT FLOAT ,@VV FLOAT ,@VP FLOAT ,@PVP FLOAT ,@VAN FLOAT ,@FP DATETIME ,@FE DATETIME ,@FV DATETIME ,@FU DATETIME ,@FX DATETIME ,@FC DATETIME ,@CI FLOAT
                           ,@CT FLOAT ,@INDEV FLOAT,@FIP DATETIME ,@CAP FLOAT ,@INCTR FLOAT ,@TD_SUMINT FLOAT ,@TD_SUMAMO FLOAT ,@TD_SUMFLU FLOAT ,@TD_SUMSAL FLOAT ,@TD_SUMFDE FLOAT ,@PX_IN FLOAT,@PX_AM FLOAT,@V001 FLOAT ,@V002 FLOAT ,@V003 FLOAT 
						   ,@V004 FLOAT ,@V005 FLOAT,@V006 FLOAT ,@V007 FLOAT ,@V008 FLOAT ,@V009 FLOAT ,@V010 FLOAT ,@NCUP INTEGER,@FVCP DATETIME,@INTE FLOAT,@AMOR FLOAT,@FLUJ FLOAT,@SALD FLOAT,@DIFD FLOAT,@SPREAD FLOAT,@FACTOR FLOAT
						   ,@DUR_MAC FLOAT,@DUR_MOD FLOAT,@CONVEXI FLOAT,@cod_nemo CHAR(20)' -- MAP 20180103
		

			EXECUTE sp_executesql @SQLString , @ParmDefinition,	
                                                                @TR,
								@TE,
								@TV,
								@TT,
								@BA,
								@BF,
								@NOM,
								@MT,
								@VV,
								@VP,
								@PVP,
								@VAN,
								@FP,
								@FE,
								@FV,
								@FU,
								@FX,
								@FC,
								@CI,
								@CT,
								@INDEV,
								@FIP,
								@CAP,
								@INCTR,
								@TD_SUMINT,
								@TD_SUMAMO,
								@TD_SUMFLU,
								@TD_SUMSAL,
								@TD_SUMFDE,
								@PX_IN,
								@PX_AM,
								@V001,
								@V002,
								@V003,
								@V004,
								@V005,
								@V006,
								@V007,
								@V008,
								@V009,
								@V010,	
								@NCUP,
								@FVCP,
								@INTE,
								@AMOR,
								@FLUJ,
								@SALD,
								@DIFD,
								@SPREAD,
								@FACTOR,
                                                                @DUR_MAC,
                                                                @DUR_MOD,
                                                                @CONVEXI,
																@cod_nemo -- MAP 20180103


			UPDATE	#CT_TABLA_DESARROLLO
			SET	FLUJ = INTE + AMOR

			SELECT	@TD_SUMINT = SUM(INTE),
				@TD_SUMAMO = SUM(AMOR),
				@TD_SUMFLU = SUM(FLUJ),
				@TD_SUMSAL = SUM(SALD),
				@TD_SUMFDE = SUM(FLDE)
			FROM	#CT_TABLA_DESARROLLO
--			WHERE	FVCP > @dFecpro

			UPDATE #CT_TMP_VALORIZACION
			SET	TD_SUMINT = @TD_SUMINT,
				TD_SUMAMO = @TD_SUMAMO,
				TD_SUMFLU = @TD_SUMFLU,
				TD_SUMSAL = @TD_SUMSAL,
				TD_SUMFDE = @TD_SUMFDE

		END

	END

	IF @cTipForm = 'C'
	BEGIN
                         IF @cFormu = 'DUR_MAC()' 
		         BEGIN
                            EXECUTE Svc_Prc_val_DurMac @dFecPro , @TipFomulas , @cod_familia , @cod_nemo , @NOM , @TR , 1 , @DUR_MAC OUTPUT 
                            SET     @SQLString = 'UPDATE #CT_TMP_VALORIZACION SET ' + @cVariab + ' = @DUR_MAC ' -- + @cVariab
                         END ELSE
                         IF @cFormu = 'DUR_MOD()'    
		         BEGIN
                            EXECUTE Svc_Prc_val_DurMac @dFecPro , @TipFomulas , @cod_familia , @cod_nemo , @NOM , @TR , 2 , @DUR_MOD OUTPUT 
                            SET     @SQLString = 'UPDATE #CT_TMP_VALORIZACION SET ' + @cVariab + ' = @DUR_MOD ' -- + @cVariab
                         END ELSE
                         IF @cFormu = 'CONVEXI()' 
		         BEGIN
                            EXECUTE Svc_Prc_val_DurMac @dFecPro , @TipFomulas , @cod_familia , @cod_nemo , @NOM , @TR , 3 , @CONVEXI OUTPUT 
                            SET     @SQLString = 'UPDATE #CT_TMP_VALORIZACION SET ' + @cVariab + ' = @CONVEXI ' --+ @cVariab
                         END ELSE


		IF @cFormu = 'DIFDIA_REALES()' 
		BEGIN
			IF @param1 = '@FC,@FU' BEGIN
				SELECT @param1 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)
			END
			IF @param2 = '@FC,@FU' BEGIN
				SELECT @param2 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)
			END 
			SET @SQLString		= 'UPDATE #CT_TMP_VALORIZACION SET ' + @cVariab + ' = DATEDIFF(DAY, ' + @param1 + ',' + @param2 + ')'

		END
		ELSE
		IF @cFormu = 'DIFDIA_BASE30()'
		BEGIN

			-- CACULO DE @Var_DIFDIA_30

			SELECT @fecini = CASE	WHEN @param1 = '@FP' THEN @fp
						WHEN @param1 = '@FE' THEN @fe
						WHEN @param1 = '@FV' THEN @fV
						WHEN @param1 = '@FU' THEN @fu
						WHEN @param1 = '@FX' THEN @fx
						WHEN @param1 = '@FC' THEN @fc
						WHEN @param1 = '@FIP' THEN @fip
						WHEN @param1 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)
						END

			SELECT @fecvto = CASE	WHEN @param2 = '@FP' THEN @fp
						WHEN @param2 = '@FE' THEN @fe
						WHEN @param2 = '@FV' THEN @fV
						WHEN @param2 = '@FU' THEN @fu
						WHEN @param2 = '@FX' THEN @fx
						WHEN @param2 = '@FC' THEN @fc
						WHEN @param2 = '@FIP' THEN @fip
						WHEN @param1 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)
						END


			EXECUTE svc_fmu_dif_d30  @fecini, @fecvto, @DIFDIAS OUTPUT

			SET @SQLString = 'UPDATE #CT_TMP_VALORIZACION SET ' + @cVariab + ' = @DIFDIAS'
		END
		ELSE
		BEGIN
			SET @SQLString = 'UPDATE #CT_TMP_VALORIZACION SET ' + @cVariab + ' = ' + @cFormu
		END

		SET @ParmDefinition = N'@TR FLOAT, @TE FLOAT ,@TV FLOAT ,@TT FLOAT ,@BA FLOAT ,@BF FLOAT ,@NOM FLOAT ,@MT FLOAT ,@VV FLOAT ,@VP FLOAT ,@PVP FLOAT ,@VAN FLOAT ,@FP DATETIME ,@FE DATETIME ,@FV DATETIME ,@FU DATETIME ,@FX DATETIME ,@FC DATETIME ,@CI FLOAT 
                   ,@CT FLOAT ,@INDEV FLOAT,@PRINC FLOAT,@FIP DATETIME,@CAP FLOAT,@INCTR FLOAT,@TD_SUMINT FLOAT ,@TD_SUMAMO FLOAT ,@TD_SUMFLU FLOAT ,@TD_SUMSAL FLOAT ,@TD_SUMFDE FLOAT ,@PX_IN FLOAT,@PX_AM FLOAT,@V001 FLOAT ,@V002 FLOAT ,@V003 FLOAT 
				   ,@V004 FLOAT,@V005 FLOAT,@V006 FLOAT ,@V007 FLOAT ,@V008 FLOAT ,@V009 FLOAT ,@V010 FLOAT ,@DIFDIAS INTEGER,@SPREAD FLOAT,@FACTOR FLOAT,@DUR_MAC FLOAT,@DUR_MOD FLOAT,@CONVEXI FLOAT,@cod_nemo CHAR(20)' -- MAP 20180103

		EXECUTE sp_executesql @SQLString , @ParmDefinition,@TR,
								@TE,
								@TV,
								@TT,
								@BA,
								@BF,
								@NOM,
								@MT,
								@VV,
								@VP,
								@PVP,
								@VAN,
								@FP,
								@FE,
								@FV,
								@FU,
								@FX,
								@FC,
								@CI,
								@CT,
								@INDEV,
								@PRINC,
								@FIP,
								@CAP,
								@INCTR,
								@TD_SUMINT,
								@TD_SUMAMO,
								@TD_SUMFLU,
								@TD_SUMSAL,
								@TD_SUMFDE,
								@PX_IN,
								@PX_AM,
								@V001,
								@V002,
								@V003,
								@V004,
								@V005,
								@V006,
								@V007,
								@V008,
								@V009,
								@V010,
								@DIFDIAS,
								@SPREAD,
								@FACTOR,
                                                                @DUR_MAC,
                                                                @DUR_MOD,
                                                                @CONVEXI,
																@cod_nemo -- MAP 20180103


	END

		SELECT	@TR		= TR		,
			@TE		= TE		,
			@TV		= TV		,
			@TT		= TT		,
			@BA		= BA		,
			@BF		= BF		,
			@NOM		= NOM		,
			@MT		= MT		,
			@VV		= VV		,
			@VP		= VP		,
			@PVP		= PVP		,
			@VAN		= VAN		,
			@FP		= FP		,
			@FE		= FE		,
			@FV		= FV		,
			@FU		= FU		,
			@FX		= FX		,
			@FC		= FC		,
			@CI		= CI		,
			@CT		= CT		,
			@INDEV		= INDEV		,
			@PRINC		= PRINC		,
			@FIP		= FIP		,
			@CAP		= CAP		,
			@INCTR		= INCTR		,
			@TD_SUMINT	= TD_SUMINT	,
			@TD_SUMAMO	= TD_SUMAMO	,
			@TD_SUMFLU	= TD_SUMFLU	,
			@TD_SUMSAL	= TD_SUMSAL	,
			@TD_SUMFDE	= TD_SUMFDE	,
			@PX_IN		= PX_IN		,
			@PX_AM		= PX_AM		,
			@V001		= V001		,
			@V002		= V002		,
			@V003		= V003		,
			@V004		= V004		,
			@V005		= V005		,
			@V006		= V006		,
			@V007		= V007		,
			@V008		= V008		,
			@V009		= V009		,
			@V010		= V010		,
			@SPREAD		= SPREAD	,
			@FACTOR 	= FACTOR        , 
                        @DUR_MAC        = DUR_MAC       ,
                        @DUR_MOD        = DUR_MOD       ,
                        @CONVEXI        = CONVEXI
		FROM	#CT_TMP_VALORIZACION

	END
        drop table #CT_TMP_FORMULA

	SET NOCOUNT OFF

END
GO
