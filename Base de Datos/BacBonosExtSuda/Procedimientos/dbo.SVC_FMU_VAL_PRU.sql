USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FMU_VAL_PRU]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SVC_FMU_VAL_PRU] 
( @cVariab	CHAR(10) , @cTipVar CHAR(10) , @cFormu CHAR(100), @param1 CHAR(15) ,@param2 CHAR(15) ,@param3 CHAR(15) ,@param4 CHAR(15) , @Cod_Nemo   CHAR(20) = '' /* MAP 20180103 */ )
AS
BEGIN

	DECLARE @TR		FLOAT		,
		@TE		FLOAT		,
		@TV		FLOAT		,
		@TT		FLOAT		,
		@BA		FLOAT		,
		@BF		FLOAT		,
		@NOM		FLOAT		,
		@MT		FLOAT		,
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
		@TD_SUMINT	FLOAT		,
		@TD_SUMAMO	FLOAT		,
		@TD_SUMFLU	FLOAT		,
		@TD_SUMSAL	FLOAT		,
		@TD_SUMFDE	FLOAT		,
		@V001		FLOAT		,
		@V002		FLOAT		,
		@V003		FLOAT		,
		@V004		FLOAT		,
		@V005		FLOAT		,
		@V006		FLOAT		,
		@V007		FLOAT		,
		@V008		FLOAT		,
		@V009		FLOAT		,
		@V010		FLOAT		,
		@SA		FLOAT		,
		@DI		FLOAT		,
		@DD		FLOAT		,
		@PX_IN		FLOAT		,
		@PX_AM		FLOAT		,
		@SPREAD		FLOAT		,
		@FACTOR		FLOAT		
	   ,  @DUR_MAC        FLOAT  = 0    ,   -- MAP 20180105 uniformización
          @DUR_MOD        FLOAT  = 0      , -- MAP 20180105 
		  @CONVEXI        FLOAT  = 0    	-- MAP 20180105 

		  SELECT  @DUR_MAC = convert(float,0) , @DUR_MOD = convert(float,0) , @CONVEXI = convert(float,0)  -- MAP 20180105 Uniformización

	DECLARE	@NCUP		FLOAT		,
		@FVCP		DATETIME	,
		@INTE		FLOAT		,
		@AMOR		FLOAT		,
		@FLUJ		FLOAT		,
		@SALD		FLOAT		,
		@DIFD		FLOAT

	SET NOCOUNT ON

	DECLARE @cont		INTEGER
	DECLARE @nError		INTEGER

	DECLARE	@fecini		DATETIME,
		@fecvto		DATETIME,
		@DIFDIAS	INTEGER


	SELECT	@nError = 0

	SELECT	@TR	= 10,
		@BA	= 10,
		@SA	= 10,
		@NOM	= 10,
		@VP	= 10,
		@TE	= 10,
		@BF	= 10,
		@CI	= 10,
		@TT	= 10,
		@FE	= '20010131',
		@TV 	= 10,
		@FP	= '20010131',
		@MT	= 10,
		@FC	= '20010131',
		@CT	= 10,
		@DI	= 10,
		@VAN	= 10,
		@FV	= '20010215',
		@DD	= 10,
		@FX	= '20010228',
		@PVP	= 10,
		@VV	= 10,
		@FU	= '20010530',
		@FIP	= '20010131',
		@CAP	= 10,
		@INCTR	= 10,
		@V001	= 10,
		@V002	= 10,
		@V003	= 10,
		@V004	= 10,
		@V005	= 10,
		@V006	= 10,
		@V007	= 10,
		@V008	= 10,
		@V009	= 10,
		@V010	= 10,
		@TD_SUMINT	= 10,
		@TD_SUMAMO	= 10,
		@TD_SUMFLU	= 10,
		@TD_SUMSAL	= 10,
		@TD_SUMFDE	= 10,
		@INDEV		= 10,
		@PRINC		= 10,
		@PX_IN		= 10,
		@PX_AM		= 10,
		@SPREAD		= 10,
		@FACTOR		= 10

-- SELECT 	@FP	= '20010131'

	DECLARE @SQLString NVARCHAR(1500)
	DECLARE @ParmDefinition NVARCHAR(1500)


	CREATE TABLE #TABLA_DESARROLLO
	(	NCUP	INTEGER,
		FVCP	DATETIME,
		INTE	FLOAT	,
		AMOR	FLOAT	,
		FLUJ	FLOAT	,
		SALD	FLOAT	,
		DIFD	FLOAT	,
		FLDE	FLOAT	,
		FACTOR  FLOAT   )


	INSERT INTO #TABLA_DESARROLLO SELECT  4, '20010315', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT  5, '20010915', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT  6, '20020315', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT  7, '20020915', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT  8, '20030315', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT  9, '20030915', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT 10, '20040315', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT 11, '20040915', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT 12, '20050315', 3.475,   0,   3.475,  100, 100, 100,1.0
	INSERT INTO #TABLA_DESARROLLO SELECT 13, '20050915', 3.475, 100, 103.475,  100, 100, 100,1.0


	CREATE TABLE #TMP_VALORIZACION
	(	TR	FLOAT		,
		BA	FLOAT		,
		SA	FLOAT		,
		NOM	FLOAT		,
		VP	FLOAT		,
		TE	FLOAT		,
		BF	FLOAT		,
		CI	FLOAT		,	 
		TT	FLOAT		,
		FE	DATETIME	,
		TV 	FLOAT		,
		FP	DATETIME	,
		MT	FLOAT		,
		FC	DATETIME	,
		CT	FLOAT		,
		DI	FLOAT		,
		VAN	FLOAT		,
		FV	DATETIME	,
		DD	FLOAT		,
		FX	DATETIME	,
		PVP	FLOAT		,
		VV	FLOAT		,
		FU	DATETIME	,
		FIP	DATETIME	,
		CAP	FLOAT		,
		INCTR	FLOAT		,
		V001	FLOAT		,
		V002	FLOAT		,
		V003	FLOAT		,
		V004	FLOAT		,
		V005	FLOAT		,
		V006	FLOAT		,
		V007	FLOAT		,
		V008	FLOAT		,
		V009	FLOAT		,
		V010	FLOAT		,
		TD_SUMINT	FLOAT	,
		TD_SUMAMO	FLOAT	,
		TD_SUMFLU	FLOAT	,		TD_SUMSAL	FLOAT	,
		TD_SUMFDE	FLOAT	,
		INDEV		FLOAT	,
		PRINC		FLOAT	,
		PX_IN		FLOAT	,
		PX_AM		FLOAT	,
		SPREAD		FLOAT	,
		FACTOR		FLOAT   
		, DUR_MAC         FLOAT           ,   -- MAP 20180105 Uniformización
          DUR_MOD         FLOAT           ,  
          CONVEXI         FLOAT           )  



	INSERT INTO #TMP_VALORIZACION
	SELECT	@TR	,
		@BA	,
		@SA	,
		@NOM	,
		@VP	,
		@TE	,
		@BF	,
		@CI	,	 
		@TT	,
		@FE	,
		@TV 	,
		@FP	,
		@MT	,
		@FC	,
		@CT	,
		@DI	,
		@VAN	,
		@FV	,
		@DD	,
		@FX	,
		@PVP	,
		@VV	,
		@FU	,
		@FIP	,
		@CAP	,
		@INCTR	,
		@V001	,
		@V002	,
		@V003	,
		@V004	,
		@V005	,
		@V006	,
		@V007	,
		@V008	,
		@V009	,
		@V010	,
		@TD_SUMINT	,
		@TD_SUMAMO	,
		@TD_SUMFLU	,
		@TD_SUMSAL	,
		@TD_SUMFDE	,
		@INDEV		,
		@PRINC		,
		@PX_IN		,
		@PX_AM		,
		@SPREAD		,
		@FACTOR
		        , @DUR_MAC, -- MAP 20180105 Uniformización
                @DUR_MOD,
                @CONVEXI


	IF @cTipVar = 'D'
	BEGIN

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
				@cont = NCUP,
				@FACTOR = Factor	
			FROM	#tabla_desarrollo
			WHERE	NCUP > @cont
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

				SET @SQLString = 'UPDATE #tabla_desarrollo SET ' + @cVariab + ' = DATEDIFF(DAY, ' + @param1 + ',' + @param2 + ') WHERE NCUP = @NCUP'

			END
			ELSE
			IF @cFormu = 'DIFDIA_BASE30()'
			BEGIN


				SELECT @fecini = CASE	WHEN @param1 = '@FP' THEN @fp
							WHEN @param1 = '@FE' THEN @fe
							WHEN @param1 = '@FV' THEN @fV
							WHEN @param1 = '@FU' THEN @fu
							WHEN @param1 = '@FX' THEN @fx
							WHEN @param1 = '@FC' THEN @fc
							WHEN @param1 = 'FVCP' THEN @FVCP
							WHEN @param1 = 'FIP' THEN @FIP
							WHEN @param1 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)
							END

				SELECT @fecvto = CASE	WHEN @param2 = '@FP' THEN @fp
							WHEN @param2 = '@FE' THEN @fe
							WHEN @param2 = '@FV' THEN @fV
							WHEN @param2 = '@FU' THEN @fu
							WHEN @param2 = '@FX' THEN @fx
							WHEN @param2 = '@FC' THEN @fc							
                                                        WHEN @param2 = 'FVCP' THEN @FVCP
							WHEN @param2 = 'FIP' THEN @FIP
							WHEN @param2 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)
							END


				EXECUTE Svc_fmu_dif_d30  @fecini, @fecvto, @DIFDIAS OUTPUT


				SET @SQLString = 'UPDATE #tabla_desarrollo SET ' + @cVariab + ' = @DIFDIAS WHERE NCUP = @NCUP'

			END
			ELSE
			BEGIN

				SET @SQLString = 'UPDATE #tabla_desarrollo SET ' + @cVariab + ' = ' + @cFormu + ' WHERE NCUP = @NCUP'

			END


			SET @ParmDefinition = N'@TR FLOAT,
				@BA FLOAT,
				@SA FLOAT,
				@NOM FLOAT,
				@VP FLOAT,
				@TE FLOAT,
				@BF FLOAT,
				@CI FLOAT,	 
				@TT FLOAT,
				@FE DATETIME,
				@TV FLOAT,
				@FP DATETIME,
				@MT FLOAT,
				@FC DATETIME,
				@CT FLOAT,
				@DI FLOAT,
				@VAN FLOAT,
				@FV DATETIME,
				@DD FLOAT,
				@FX DATETIME,
				@PVP FLOAT,
				@VV FLOAT,
				@FU DATETIME,
				@FIP DATETIME,
				@CAP FLOAT,	
				@INCTR FLOAT,
				@V001 FLOAT,
				@V002 FLOAT,
				@V003 FLOAT,
				@V004 FLOAT,
				@V005 FLOAT,
				@V006 FLOAT,
				@V007 FLOAT,
				@V008 FLOAT,
				@V009 FLOAT,
				@V010 FLOAT,
				@NCUP INTEGER,
				@FVCP DATETIME,
				@INTE FLOAT,
				@AMOR FLOAT,
				@FLUJ FLOAT,
				@SALD FLOAT,
				@DIFD FLOAT,
				@INDEV FLOAT,
				@DIFDIAS INTEGER,
				@PX_IN FLOAT,
				@PX_AM FLOAT,
				@SPREAD	FLOAT,
				@FACTOR FLOAT,
				@Cod_Nemo CHAR(20)'		-- MAP 20180103

	EXECUTE sp_executesql @SQLString , @ParmDefinition,	@TR,
								@BA,
								@SA,
								@NOM,
								@VP,
								@TE,
								@BF,
								@CI,	 
								@TT,
								@FE,
								@TV,			
								@FP,
								@MT,
								@FC,
								@CT,
								@DI,
								@VAN,
								@FV,
								@DD,
								@FX,
								@PVP,
								@VV,
								@FU,
								@FIP,
								@CAP,
								@INCTR,
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
								@INDEV,
								@DIFDIAS,
								@PX_IN,
								@PX_AM,
								@SPREAD,
								@FACTOR,
								@Cod_Nemo --MAP 20180103 	


			UPDATE	#tabla_desarrollo
			SET	FLUJ = INTE + AMOR


			SELECT	@TD_SUMINT = SUM(INTE),
				@TD_SUMAMO = SUM(AMOR),
				@TD_SUMFLU = SUM(FLUJ),
				@TD_SUMSAL = SUM(SALD),
				@TD_SUMFDE = SUM(FLDE)
			FROM	#tabla_desarrollo


			UPDATE #TMP_VALORIZACION
			SET	TD_SUMINT = @TD_SUMINT,
				TD_SUMAMO = @TD_SUMAMO,
				TD_SUMFLU = @TD_SUMFLU,
				TD_SUMSAL = @TD_SUMSAL,
				TD_SUMFDE = @TD_SUMFDE

		END


	--	SELECT * from #tabla_desarrollo
-- sp_helptext Svc_Fmu_val_pru
	END

	IF @cTipVar = 'C'
	BEGIN


		IF @cFormu = 'CALCULO_TIR()' 
		BEGIN

			SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = @' + @cVariab

		END
		ELSE
		IF @cFormu = 'DIFDIA_REALES()' 
		BEGIN

			IF @param1 = '@FC,@FU' BEGIN
				SELECT @param1 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)
			END
			IF @param2 = '@FC,@FU' BEGIN
				SELECT @param2 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)
			END 

			SET @SQLString	= 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = DATEDIFF(DAY, ' + @param1 + ',' + @param2 + ')'

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
						WHEN @param1 = 'FIP' THEN @FIP
						WHEN @param1 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)
						END

			SELECT @fecvto = CASE	WHEN @param2 = '@FP' THEN @fp
						WHEN @param2 = '@FE' THEN @fe
						WHEN @param2 = '@FV' THEN @fV
						WHEN @param2 = '@FU' THEN @fu
						WHEN @param2 = '@FX' THEN @fx
						WHEN @param2 = '@FC' THEN @fc
						WHEN @param2 = 'FIP' THEN @FIP
						WHEN @param2 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)
						END


			EXECUTE Svc_fmu_dif_d30  @fecini, @fecvto, @DIFDIAS OUTPUT



			SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = @DIFDIAS'


		END
		ELSE
		IF @cFormu = 'DUR_MAC()' or @cFormu = 'DUR_MOD()' or @cFormu = 'CONVEXI()'
		BEGIN
		    SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = 0'
		END
		ELSE
		BEGIN

			SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = ' + @cFormu

		END

		

		SET @ParmDefinition = N'@TR FLOAT,
					@BA FLOAT,
					@SA FLOAT,
					@NOM FLOAT,
					@VP FLOAT,
					@TE FLOAT,
					@BF FLOAT,
					@CI FLOAT,	 
					@TT FLOAT,
					@FE DATETIME,
					@TV FLOAT,
					@FP DATETIME,
					@MT FLOAT,
					@FC DATETIME,
					@CT FLOAT,
					@DI FLOAT,
					@VAN FLOAT,
					@FV DATETIME,
					@DD FLOAT,
					@FX DATETIME,	
					@PVP FLOAT,
					@VV FLOAT,
					@FU DATETIME,
					@FIP DATETIME,
					@CAP FLOAT,
					@INCTR FLOAT,
					@V001 FLOAT,
					@V002 FLOAT,
					@V003 FLOAT,
					@V004 FLOAT,
					@V005 FLOAT,
					@V006 FLOAT,
					@V007 FLOAT,
					@V008 FLOAT,
					@V009 FLOAT,
					@V010 FLOAT,
					@TD_SUMINT FLOAT,
					@TD_SUMAMO FLOAT,
					@TD_SUMFLU FLOAT,
					@TD_SUMSAL FLOAT,
					@TD_SUMFDE FLOAT,
					@INDEV FLOAT,
					@PRINC FLOAT,
					@DIFDIAS INTEGER,
					@PX_IN FLOAT,
					@PX_AM FLOAT,
					@SPREAD FLOAT,
					@FACTOR FLOAT,
					@Cod_Nemo CHAR(20)'        -- MAP 20180103

		EXECUTE sp_executesql @SQLString , @ParmDefinition,	@TR,
								@BA,
								@SA,
								@NOM,
								@VP,
								@TE,
								@BF,
								@CI,	 
								@TT,
								@FE,
								@TV,			
								@FP,
								@MT,
								@FC,
								@CT,
								@DI,
								@VAN,
								@FV,
								@DD,
								@FX,
								@PVP,
								@VV,
								@FU,
								@FIP,
								@CAP,
								@INCTR,
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
								@TD_SUMINT,
								@TD_SUMAMO,
								@TD_SUMFLU,
								@TD_SUMSAL,
								@TD_SUMFDE,
								@INDEV,
								@PRINC,
								@DIFDIAS,
								@PX_IN,
								@PX_AM,
								@SPREAD,
								@FACTOR,
								@Cod_Nemo -- MAP 20180103


	END

	SELECT	@TR	=	TR,
		@BA	=	BA,
		@SA	=	SA,
		@NOM	= 	NOM,
		@VP	=	VP,
		@TE	=	TE,
		@BF	=	BF,
		@CI	=	CI, 
		@TT	= 	TT,
		@FE	=	FE,
		@TV 	=	TV,
		@FP	=	FP,
		@MT	= 	MT,
		@FC	=	FC,
		@CT	= 	CT,
		@DI	=	DI,
		@VAN	= 	VAN,
		@FV	= 	FV,
		@DD	= 	DD,
		@FX	=	FX,
		@PVP	= 	PVP,
		@VV	=	VV,
		@FU	=	FU,
		@FIP	= 	FIP,
		@CAP	= 	CAP,
		@INCTR	= 	INCTR,
		@V001	= 	V001,
		@V002	=	V002,
		@V003	=	V003,
		@V004	=	V004,
		@V005	=	V005,
		@V006	=	V006,
		@V007	=	V007,
		@V008	=	V008,
		@V009	= 	V009,
		@V010   =	V010,
		@TD_SUMINT = TD_SUMINT,
		@TD_SUMAMO = TD_SUMAMO,
		@TD_SUMFLU = TD_SUMFLU,
		@TD_SUMSAL = TD_SUMSAL,
		@TD_SUMFDE = TD_SUMFDE,
		@INDEV	   = INDEV,
		@PRINC	   = PRINC,
		@PX_IN	   = PX_IN,	
		@PX_AM	   = PX_AM,	
		@SPREAD	   = SPREAD,	
		@FACTOR	   = FACTOR
	FROM	#TMP_VALORIZACION

	SELECT  * FROM #TMP_VALORIZACION

	SET NOCOUNT OFF

END

-- sp_invex_valorizador_prueba_formula 'VP','1+110/@tr'
-- Svc_Fmu_val_pru 'V005', 'C', '@NOM *  (@TV +  @SPREAD ) *  @V004 / (  @BA * 100 )', '', '', '', ''
GO
