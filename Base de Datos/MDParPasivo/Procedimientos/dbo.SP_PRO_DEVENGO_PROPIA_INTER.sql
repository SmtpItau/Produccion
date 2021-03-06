USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRO_DEVENGO_PROPIA_INTER]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PRO_DEVENGO_PROPIA_INTER]
				(
                                @nNumdocu	NUMERIC	(10,0)	,
		                @nNumoper	NUMERIC	(10,0)  ,
		                @nCorrela	NUMERIC	(03,0)  ,
				@dFechoy	DATETIME	,
				@dFecprox	DATETIME	,
				@fTe_pcdus	FLOAT   	,
				@fTe_pcduf	FLOAT   	,
				@fTe_ptf	FLOAT   	,
				@cDevengo_dolar	CHAR	(01)    
				)

AS
BEGIN

        SET DATEFORMAT dmy

	SET NOCOUNT ON


	DECLARE	@ncatidad_operaciones	INTEGER		,
		@ncontador_operaciones	INTEGER		

	DECLARE	@nRutcart	NUMERIC(10)	,
		@nTipcart	NUMERIC	(05)	,
		@cInstser	CHAR(12)	,
		@cInstcam	CHAR(12)	,
		@fNominal	FLOAT		,
		@fTir		FLOAT		,
		@iCodigo	INTEGER		,
		@dFecemi	DATETIME	,
		@dFecven	DATETIME	,
		@nValcomp_O	FLOAT		,
		@fValcomu_O	FLOAT		,
		@nVpresen_O	FLOAT		,
		@nintMes_O	FLOAT		,
		@nReaMes_O	FLOAT		,
 		@ninteres_O	FLOAT		,
		@nReajuste_O	FLOAT		,
		@fPvp		FLOAT		,
                @cppvpcomp      FLOAT		,
		@dFecucup	DATETIME	,
                @dFecpcup       DATETIME	,
                @cSeriado	CHAR(01)	,
                @cMascara	CHAR(10)	,
                @dFeccomp	DATETIME	,
                @cartera        CHAR(03)	,
                @nrutcli        NUMERIC(10)	,
                @ncodcli        NUMERIC(10)	,
                @codmon         NUMERIC(03)	,
                @carterasuper   CHAR(1)		,
		@FechaPacto	DATETIME	,
		@tipoper	CHAR(3)

		CREATE TABLE #TEMP_DEV_PRO_IN
					(
					rutcart		NUMERIC(09)	,
					tipcart		NUMERIC(05)	,
					instser         CHAR(12)	,
					instcam         CHAR(12)	,
					mascara         CHAR(12)	,
					feccomp         CHAR(10)	,
					tircomp         NUMERIC(19,4)	,
					nominal         NUMERIC(19,4)	,
					valcomp         NUMERIC(19,4)	,
					valcomu         FLOAT		,
					intdia      	NUMERIC(19,4)	,
					readia 		NUMERIC(19,4)	,
					interes     	NUMERIC(19,4)	,
					reajuste        NUMERIC(19,4)	,
					interesmes  	NUMERIC(19,4)	,
					reajustemes     NUMERIC(19,4)	,
					readifmes       NUMERIC(19,4)	,
					seriado         CHAR(1)		,
					codigo 		NUMERIC(05)	,
					valptehoy       NUMERIC(19,4)	,
					valpteman       NUMERIC(19,4) 	,
					amocup 		FLOAT		,
					intcup      	FLOAT		,
					reacup 		FLOAT		,
					flujo  		FLOAT		,
					duration        FLOAT		,
					durmodif        FLOAT		,
					convex 		FLOAT		,
					tasa_float     	FLOAT		,
					monemi 		INTEGER		,
					basemi 		FLOAT		,
					tasemi 		FLOAT		,
					fecemi 		CHAR(10)	,
					fecven 		CHAR(10)	,
					cupon  		INTEGER		,
					pvpcomp         FLOAT		,
					numucup         FLOAT		,
					numpcup         FLOAT		,
					fecucup         CHAR(10)	,
					fecpcup         CHAR(10)	,
					condpacto       CHAR(01)	,
					flag   		CHAR(01)	,
					cppvpcomp       NUMERIC(19,4)	,
					intpcup     	NUMERIC(19,4)	,
					amopcup         NUMERIC(19,4)	,
					reapcup         NUMERIC(19,4)	,
					flupcup         NUMERIC(19,4)	,
					numdocu         NUMERIC(10)	,
					correla         NUMERIC(05)	,
 					numoper         NUMERIC(10)	,
					cartera         VARCHAR(03)	,
					rutcli 		NUMERIC(09)	,
					codcli 		NUMERIC(09)	,
					carterasuper    CHAR(01)	,
					FechaPacto      DATETIME	,
					tipoper		VARCHAR(03)	,
					)


	INSERT #TEMP_DEV_PRO_IN
	EXECUTE Sp_Devengar_Propia_inter 
					'C'         	,
                                	@nNumdocu	,
			                @nNumoper	,
			                @nCorrela	,
					@dFechoy	,
					@dFecprox	,
					@fTe_pcdus	,
					@fTe_pcduf	,
					@fTe_ptf	,
					@cDevengo_dolar


					
	IF @@ERROR<>0
	BEGIN
		SELECT	'NO','Problemas al generar datos de cartera'
		RETURN
	END


	ALTER TABLE #TEMP_DEV_PRO_IN ADD contador INTEGER IDENTITY
	SELECT * INTO #TEM_DEV_PRO_IN FROM #TEMP_DEV_PRO_IN --WHERE nominal > 0


		SELECT @ncatidad_operaciones = (SELECT COUNT(contador)FROM #TEM_DEV_PRO_IN)
		SELECT @ncontador_operaciones = 1

 			WHILE @ncontador_operaciones <= @ncatidad_operaciones
			BEGIN

				SET ROWCOUNT @ncontador_operaciones
				
					SELECT
						@nNumdocu	= numdocu	,
						@nNumoper	= numoper	,
						@nCorrela	= correla	,
						@nRutcart	= rutcart	,
						@nTipcart	= tipcart	,
						@cInstser	= instser	,
						@cInstcam	= instcam	,
						@fNominal	= nominal	,
						@fTir		= tircomp	,
						@iCodigo	= codigo	,
						@dFecemi	= fecemi	,
						@dFecven	= fecven	,
						@nValcomp_O	= valcomp	,
						@fValcomu_O	= valcomu	,
						@nVpresen_O	= valptehoy	,
						@nintMes_O	= interesmes	,
						@nReaMes_O	= reajustemes	,
						@ninteres_O	= interes	,
						@nReajuste_O	= reajuste	,
						@fPvp		= pvpcomp	,
						@cppvpcomp      = cppvpcomp	,
						@dFecucup	= fecucup	,
						@dFecpcup       = fecpcup	,
						@cSeriado	= seriado	,
						@cMascara	= mascara	,
						@dFeccomp	= feccomp	,
						@cartera        = cartera	,
						@nrutcli        = rutcli	,
						@ncodcli        = codcli	,
						@codmon         = 0		,
						@carterasuper   = carterasuper	,
						@FechaPacto	= FechaPacto	,
						@tipoper	= tipoper

					FROM #TEM_DEV_PRO_IN
					WHERE contador = @ncontador_operaciones


				SET ROWCOUNT 0
			
				EXECUTE Sp_Devengar_Propia_Inter	'D'		,
									@nNumdocu	,
							                @nNumoper	,
							                @nCorrela	,
									@dFechoy	,
									@dFecprox	,
									@fTe_pcdus	,
									@fTe_pcduf	,
									@fTe_ptf	,
									@cDevengo_dolar	,
									@nRutcart	,
									@nTipcart	,
									@cInstser	,
									@cInstcam	,
									@fNominal	,
									@fTir		,
									@iCodigo	,
									@dFecemi	,
									@dFecven	,
									@nValcomp_O	,
									@fValcomu_O	,
									@nVpresen_O	,
									@nintMes_O	,
									@nReaMes_O	,
							 		@ninteres_O	,
									@nReajuste_O	,
									@fPvp		,
							                @cppvpcomp      ,
									@dFecucup	,
							                @dFecpcup       ,
							                @cSeriado	,
							                @cMascara	,
							                @dFeccomp	,
							                @cartera        ,
							                @nrutcli        ,
							                @ncodcli        ,
							                @codmon         ,
							                @carterasuper   ,
									@FechaPacto	,
									@tipoper
					
					IF @@ERROR<>0
					BEGIN
						SELECT	'NO','Problemas al Insertar datos a RESULTADO_DEVENGO'
						RETURN
					END

				SELECT @ncontador_operaciones = @ncontador_operaciones + 1
			

			END


	EXECUTE Sp_Devengar_Propia_inter 
					'V'         	,
                                	@nNumdocu	,
			                @nNumoper	,
			                @nCorrela	,
					@dFechoy	,
					@dFecprox	,
					@fTe_pcdus	,
					@fTe_pcduf	,
					@fTe_ptf	,
					@cDevengo_dolar


			
	IF @@ERROR<>0
	BEGIN
		SELECT	'NO','Problemas al actualizar cartera'
		RETURN
	END


	SELECT	'OK','Devengo generado correctamente'


	SET NOCOUNT OFF

END


GO
