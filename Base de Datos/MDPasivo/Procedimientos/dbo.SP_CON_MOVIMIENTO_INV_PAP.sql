USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_MOVIMIENTO_INV_PAP]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROC [dbo].[SP_CON_MOVIMIENTO_INV_PAP](
		@TipoConsulta	CHAR(1),
		@fecpro		DATETIME,
		@tipo		CHAR(1),
		@sistema	CHAR(5),
		@producto	CHAR(5),
		@numoper	NUMERIC(10),
		@numdocu	NUMERIC(10),
		@correla	NUMERIC(10),
		@productor	CHAR(5),
		@evento		CHAR(5),
		@archivo	CHAR(3),
		@fechis		datetime,
		@ctipoper	char(5),
		@ctipoperO	char(5),
		@ccartera	char(5))
AS
BEGIN

	DECLARE @dFecpro	DATETIME

	SELECT @dFecpro = Fecha_Proceso FROM view_datos_generales

/*
select 'papeles',
@TipoConsulta,
		@fecpro		,
		@tipo		,
		@sistema	,
		@producto	,
		@numoper	,
		@numdocu	,
		@correla	,
		@productor	,
		@evento		,
		@archivo	,
		@fechis		,
		@ctipoper	,
		@ctipoperO	,
		@ccartera	,
		@texto_ope	
*/


	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'FEC_OPE'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'GLO_OPE'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'NUM_OPE'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'NUM_DOC'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'NUM_COR'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'SERIE'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'GENEMIS'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'MONEMIS'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'NOMINAL'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'PVP'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'TIR'
	UPDATE #campos SET consulta='S' WHERE nombre_campo = 'FEC_VCT_PAP'


-- ***********************************************************
-- ***********************************************************
-- MOVIMIENTO
-- ***********************************************************
-- ***********************************************************


	IF @TipoConsulta = 'M'
	BEGIn


		IF @archivo ='MOV' 
		BEGIN

			INSERT	INTO #operacion(
				fecpro			,
				tipo			,
				sistema			,
				producto		,
				numoper			,
				numdocu			,
				correla			,
				productor		,
				evento			,
				FEC_OPE			,
				TIP_OPE			,
				GLO_OPE			,
				NUM_OPE			,
				NUM_DOC			,
				NUM_COR			,
				SERIE			,
				GENEMIS			,
				MONEMIS			,
				NOMINAL			,
				PVP			,
				TIR			,
				FEC_VCT_PAP		)

			SELECT	@fecpro			,
				@tipo			,
				@sistema		,
				@producto		,
				@numoper		,
				@numdocu		,
				@correla		,
				@productor		,
				@evento			,
				CONVERT(CHAR(10),mofecpro,103),
				motipoper		,
				CASE	WHEN motipoper IN('CPI')	THEN 'COMPRA PROPIA'
					WHEN motipoper IN('VPI')	THEN 'VENTA PROPIA'
					WHEN motipoper IN('TD')		THEN 'TIME DEPOSIT'
					WHEN motipoper IN('VTD')	THEN 'VENCIMIENTO TIME DEPOSIT'
					END		,
				monumoper		,
				monumdocu		,
				correlativo		,
				cod_nemo		,
				emgeneric		,
				mnnemo			,
				monominal		,
				mopvp			,
				motir			,
				CONVERT(CHAR(10),mofecven,103)
			FROM	VIEW_MOVIMIENTO_INVERSION_EXTERIOR,
				VIEW_EMISOR,
				VIEW_MONEDA
			WHERE	mofecpro    = @fechis
			AND	monumoper   = @numoper
			AND	monumdocu   = @numdocu
			AND	correlativo = @correla
			AND	emrut       = morutemi
			AND	mncodmon    = momonemi

		END



		IF @archivo ='DEV'  OR @archivo ='VAL'
		BEGIN

			INSERT	INTO #operacion(
				fecpro			,
				tipo			,
				sistema			,
				producto		,
				numoper			,
				numdocu			,
				correla			,
				productor		,
				evento			,
				FEC_OPE			,
				TIP_OPE			,
				GLO_OPE			,
				NUM_OPE			,
				NUM_DOC			,
				NUM_COR			,
				SERIE			,
				GENEMIS			,
				MONEMIS			,
				NOMINAL			,
				PVP			,
				TIR			,
				FEC_VCT_PAP		)

			SELECT	@fecpro			,
				@tipo			,
				@sistema		,
				@producto		,
				@numoper		,
				@numdocu		,
				@correla		,
				@productor		,
				@evento			,
				CONVERT(CHAR(10),rsfecpro,103),
				rstipoper		,
				CASE	WHEN @archivo ='VAL' 				THEN 'VALORIZACION MERCADO'
					WHEN Codigo_SubProducto='TD'			THEN 'DEVENGAMIENTO TIME DEPOSIT'
					WHEN rstipoper = 'DEV' AND rscartera = '333'	THEN 'DEVENGAMIENTO CARTERA PROPIA'
					WHEN rstipoper = 'VC' 				THEN 'CORTE CUPON'
					END		,
				rsnumoper		,
				rsnumdocu		,
				correlativo		,
				cod_nemo		,
				emgeneric		,
				mnnemo			,
				rsnominal		,
				rspvp			,
				rstir			,
				CONVERT(CHAR(10),rsfecvcto,103)
			FROM	VIEW_RESULTADO_INVERSION_EXTERIOR,
				VIEW_EMISOR,
				VIEW_MONEDA
			WHERE	rsfecpro    = @fechis
			AND	rsnumoper   = @numoper
			AND	rsnumdocu   = @numdocu
			AND	correlativo = @correla
			AND	emrut       = rsrutemis
			AND	mncodmon    = rsmonemi
			AND	rstipoper   = @ctipoper
			AND	rscartera   = @ccartera


		END


	END



-- ***********************************************************
-- ***********************************************************
-- CARTERA
-- ***********************************************************
-- ***********************************************************

	IF @TipoConsulta = 'C'
	BEGIN

		IF @dFecpro <> @fecpro
		BEGIN
			INSERT	INTO #operacion(
				fecpro			,
				tipo			,
				sistema			,
				producto		,
				numoper			,
				numdocu			,
				correla			,
				productor		,
				evento			,
				FEC_OPE			,
				TIP_OPE			,
				GLO_OPE			,
				NUM_OPE			,
				NUM_DOC			,
				NUM_COR			,
				SERIE			,
				GENEMIS			,
				MONEMIS			,
				TAS_EMI			,
				NOMINAL			,
				PVP			,
				TIR			,
				FEC_COM			,
				FEC_VCT_PAP		,
				PLAZO			,
				VAL_COM			,
				VAL_PRE			,
				VAL_MER			)

			SELECT	@fecpro			,
				@tipo			,
				@sistema		,
				@producto		,
				@numoper		,
				@numdocu		,
				@correla		,
				@productor		,
				@evento			,
				CONVERT(CHAR(10),rsfecpro,103),
				rstipoper		,
				CASE	WHEN Codigo_SubProducto='TD'	THEN 	'TIME DEPOSIT'
					ELSE					'CARTERA PROPIA'
					END		,
				rsnumoper		,
				rsnumdocu		,
				correlativo		,
				cod_nemo		,
				emgeneric		,
				mnnemo			,
				rstasemi		,
				rsnominal		,
				rspvp			,
				rstir			,
				CONVERT(CHAR(10),rsfeccomp,103),
				CONVERT(CHAR(10),rsfecvcto,103),
				DATEDIFF(DAY,rsfecpro,rsfecvcto),
				rsvalcomu		,
				rsvppresen		,
				0
			FROM	VIEW_RESULTADO_INVERSION_EXTERIOR,
				VIEW_EMISOR,
				VIEW_MONEDA
			WHERE	rsfecpro  = @fechis
			AND	rsnumoper = @numoper
			AND	rsnumdocu = @numdocu
			AND	correlativo = @correla
			AND	emrut       = rsrutemis
			AND	mncodmon    = rsmonemi
			AND	rstipoper   = 'DEV'

-- select * from RESULTADO_DEVENGO

		END
		ELSE
		BEGIN

			INSERT	INTO #operacion(
				fecpro			,
				tipo			,
				sistema			,
				producto		,
				numoper			,
				numdocu			,
				correla			,
				productor		,
				evento			,
				FEC_OPE			,
				TIP_OPE			,
				GLO_OPE			,
				NUM_OPE			,
				NUM_DOC			,
				NUM_COR			,
				SERIE			,
				GENEMIS			,
				MONEMIS			,
				TAS_EMI			,
				NOMINAL			,
				PVP			,
				TIR			,
				FEC_COM			,
				FEC_VCT_PAP		,
				PLAZO			,
				VAL_COM			,
				VAL_PRE			,
				VAL_MER			)

			SELECT	@fecpro			,
				@tipo			,
				@sistema		,
				@producto		,
				@numoper		,
				@numdocu		,
				@correla		,
				@productor		,
				@evento			,
				CONVERT(CHAR(10),@fecpro,103),
				Codigo_SubProducto			,
				CASE WHEN Codigo_SubProducto = 'TD' THEN 'TIME DEPOSIT' ELSE 'CARTERA PROPIA' END,
				cpnumdocu		,
				cpnumdocu		,
				correlativo		,
				cod_nemo		,
				emgeneric		,
				mnnemo			,
				cptasemi		,
				cpnominal		,
				cppvpcomp		,
				cptircomp		,
				CONVERT(CHAR(10),cpfeccomp,103),
				CONVERT(CHAR(10),cpfecven,103),
				DATEDIFF(day,@fecpro,cpfecven),
				cpvalcomu		,
				cpvptirc		,
				0
			FROM	VIEW_CARTERA_INVERSION_EXTERIOR,
				VIEW_EMISOR,
				VIEW_MONEDA
			WHERE	cpnumdocu = @numdocu
			AND	correlativo = @correla
			AND	emrut     = cprutemi
			AND	mncodmon  = cpmonemi

		END

		UPDATE	#operacion
		SET	VAL_MER = valor_mercado
		FROM	view_valorizacion_mercado
		WHERE	fecpro		= @fecpro
		AND	tipo		= @tipo
		AND	sistema		= @sistema
		AND	producto	= @producto
		AND	numoper		= @numoper
		AND	numdocu		= @numdocu
		AND	correla		= @correla
		AND	productor	= @productor
		AND	evento		= @evento
		AND	fecha_valorizacion=@fechis
		AND	id_sistema 	= 'INV'
		AND	numero_documento= @numdocu
		AND	numero_operacion= @numoper
		AND	correlativo	= @correla
		AND	codigo_area	= 'COMEX'

-- select * from view_valorizacion_mercado

		UPDATE #campos SET consulta='S' WHERE nombre_campo = 'TAS_EMI'
		UPDATE #campos SET consulta='S' WHERE nombre_campo = 'FEC_COM'
		UPDATE #campos SET consulta='S' WHERE nombre_campo = 'PLAZO'
		UPDATE #campos SET consulta='S' WHERE nombre_campo = 'VAL_COM'
		UPDATE #campos SET consulta='S' WHERE nombre_campo = 'VAL_PRE'
		UPDATE #campos SET consulta='S' WHERE nombre_campo = 'VAL_MER'


	END






END




-- select * from resultado_devengo where rsfecha = '20030901' and rscartera=111
-- update resultado_devengo set rsfecprox = '20030930' where rscartera=112 and rsfecha = '20030901'

GO
