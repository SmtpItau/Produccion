USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_PRC_DEV_ACT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_PRC_DEV_ACT]
(	
          @dFechaproc	DATETIME 
)

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @dFecPro	DATETIME	,
		@dFecCal	DATETIME	,
		@TipFomulas	CHAR(1)		,
		@tipo_cal	FLOAT		,
		@cod_familia	NUMERIC(04)	,
		@cod_nemo	CHAR(20)	,
		@fecha_vcto	DATETIME	,
		@TR		FLOAT		,
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
		@INCTR		FLOAT		,
		@FIP		DATETIME	,
		@CAP		FLOAT		,
		@Retorno	CHAR(1)			


	DECLARE	@rutcart	NUMERIC(9)	,
		@numdocu	char(12)	,
		@nominal	NUMERIC(19, 4)	,
		@fecpago	DATETIME	,
		@valcomu	FLOAT		,
		@tircomp	NUMERIC(9, 4)	,
		@pvpcomp	NUMERIC(19, 4)	,
		@vpcomp		NUMERIC(19, 8)	,
		@fecemi		DATETIME	,
		@fecven		DATETIME	,
		@tasemi		NUMERIC(9, 4)	,
		@basemi		NUMERIC(3)	,
		@monemi		NUMERIC(3)	,
		@vptirc		NUMERIC(19, 4)	,
		@capital	NUMERIC(19, 4)	,
		@interes	NUMERIC(19, 4)	,
		@reajust	NUMERIC(19, 4)	,
		@tipo_tasa	NUMERIC(3)	,
		@reajuste_acum	NUMERIC(19, 4)	,
		@interes_acum	NUMERIC(19, 4)




	DECLARE	@i	INTEGER


	CREATE TABLE #cartera(
			rutcart		NUMERIC(9, 0)	,
			numdocu		char(12)	,
			cod_familia	NUMERIC(4)	,
			cod_nemo	CHAR (20)	,
			nominal		NUMERIC(19, 4)	,
			fecpago		DATETIME	,
			valcomu		FLOAT		,
			tircomp		NUMERIC(19, 4)	,
			pvpcomp		NUMERIC(19, 4)	,
			vpcomp		NUMERIC(19, 8)	,
			fecemi		DATETIME	,
			fecven		DATETIME	,
			tasemi		NUMERIC(19, 4)	,
			basemi		NUMERIC(3, 0)	,
			monemi		NUMERIC(3, 0)	,
			monpag		NUMERIC(3, 0)	,
			vptirc		NUMERIC(19, 4)	,
			capital		NUMERIC(19, 4)	,
			interes		NUMERIC(19, 4)	,
			reajust		NUMERIC(19, 4)	,
			tipo_tasa	NUMERIC(3)	,
			sw		CHAR(1)		)





	INSERT INTO	#cartera
	SELECT	cprutcart	,
		cpnumdocu	,
		cod_familia	,
		cod_nemo	,
		cpnominal	,
		cpfecpago	,
		cpvalcomu	,
		cptircomp	,
		cppvpcomp	,
		cpvpcomp	,
		cpfecemi	,
		cpfecven	,
		cptasemi	,
		cpbasemi	,
		cpmonemi	,
		cpmonpag	,
		cpvptirc	,
		cpcapital	,
		cpinteres	,
		cpreajust	,
		tipo_tasa	,
		'N'
	FROM 	TEXT_CTR_INV
	WHERE	cpnominal  > 0
	AND	cpfecpago <= @dFechaProc


	IF @@ERROR<>0
	BEGIN

		SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
		RETURN
	END




	WHILE 1=1
	BEGIN


		SET ROWCOUNT 1

		SELECT	@i = 0

		SELECT	@i 		= 1		,
			@rutcart	= rutcart	,
			@numdocu	= numdocu	,
			@cod_familia	= cod_familia	,
			@cod_nemo	= cod_nemo	,
			@nominal	= nominal	,
			@fecpago	= fecpago	,
			@valcomu	= valcomu	,
			@tircomp	= tircomp	,
			@pvpcomp	= pvpcomp	,
			@vpcomp		= vpcomp	,
			@fecemi		= fecemi	,
			@fecven		= fecven	,
			@tasemi		= tasemi	,
			@basemi		= basemi	,
			@monemi		= monemi	,
			@vptirc		= vptirc	,
			@capital	= capital	,
			@interes_acum	= interes	,
			@reajuste_acum	= reajust	,
			@tipo_tasa	= tipo_tasa	,
			@interes	= 0		,
			@reajust	= 0		
		FROM	#cartera
		WHERE	sw = 'N'

		SET ROWCOUNT 0


		IF @i = 0	BREAK



SELECT 	@rutcart	,
	@numdocu	,
	@cod_familia	,
	@cod_nemo	,
	@nominal	,
	@fecpago	
	


		SELECT	@dFecPro	= @dFechaproc	,
			@TipFomulas	= ''		,
			@tipo_cal	= 2		,
			@fecha_vcto	= @fecven	,
			@TR		= @tircomp	,
			@TE		= @tasemi	,
			@TV		= @tasemi	,
			@TT		= @tipo_tasa	,
			@BA		= @basemi	,
			@BF		= @basemi	,
			@NOM		= @nominal	,
			@MT		= @vptirc	,
			@VV		= 0		,
			@VP		= 0		,
			@PVP		= @pvpcomp	,
			@VAN		= 0		,
			@FP		= @dFechaproc	,
			@FE		= @fecemi	,
			@FV		= @fecemi	,
			@FU		= ''		,
			@FX		= ''		,
			@FC		= @fecpago	,
			@CI		= 0		,
			@CT		= 0		,
			@INDEV		= 0		,
			@PRINC		= 0		,
			@FIP		= @fecpago	,
			@INCTR		= 0		,
			@CAP		= @capital	,
			@Retorno	= 'N'		



		EXECUTE Svc_Prc_val_ins		@dFecPro		,
						@TipFomulas		,
						@tipo_cal		,
						@cod_familia		,
						@cod_nemo		,
						@fecha_vcto		,
						@TR		OUTPUT	,
						@TE		OUTPUT	,
						@TV		OUTPUT	,
						@TT		OUTPUT	,
						@BA		OUTPUT	,
						@BF		OUTPUT	,
						@NOM		OUTPUT	,
						@MT		OUTPUT	,
						@VV		OUTPUT	,
						@VP		OUTPUT	,
						@PVP		OUTPUT	,
						@VAN		OUTPUT	,
						@FP		OUTPUT	,
						@FE		OUTPUT	,
						@FV		OUTPUT	,
						@FU		OUTPUT	,
						@FX		OUTPUT	,
						@FC		OUTPUT	,
						@CI		OUTPUT	,
						@CT		OUTPUT	,
						@INDEV		OUTPUT	,
						@PRINC		OUTPUT	,
						@FIP		OUTPUT	,
						@CAP		OUTPUT	,
						@INCTR		OUTPUT	,
						@Retorno		,
						@monemi

						

		IF @@ERROR<>0
		BEGIN

			SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
			RETURN
		END



select	@CAP,
	@INCTR,
	@MT,
	@FU,
	@FX

		UPDATE	Text_ctr_inv
		SET	cpinteres	= @INCTR,
			cpfecucup	= @FU,
			cpfecpcup	= @FX
		WHERE	cpnumdocu	= @numdocu




/*
		IF @fecpago < @FU
		BEGIN

			SELECT	@dFecPro	= DATEADD(DAY,1,@FU)

			SELECT	@TipFomulas	= ''		,
				@tipo_cal	= 2		,
				@fecha_vcto	= @fecven	,
				@TR		= @tircomp	,
				@TE		= @tasemi	,
				@TV		= @tasemi	,
				@TT		= @tipo_tasa	,
				@BA		= @basemi	,
				@BF		= @basemi	,
				@NOM		= @nominal	,
				@MT		= @vptirc	,
				@VV		= 0		,
				@VP		= 0		,
				@PVP		= @pvpcomp	,
				@VAN		= 0		,
				@FP		= @dFecPro	,
				@FE		= @fecemi	,
				@FV		= @fecemi	,
				@FU		= ''		,
				@FX		= ''		,
				@FC		= @fecpago	,
				@CI		= 0		,
				@CT		= 0		,
				@INDEV		= 0		,
				@PRINC		= 0		,
				@FIP		= @fecpago	,
				@INCTR		= 0		,
				@CAP		= @capital	,
				@Retorno	= 'N'		


			EXECUTE Svc_Prc_val_ins
						@dFecPro		,
						@TipFomulas		,
						@tipo_cal		,
						@cod_familia		,
						@cod_nemo		,
						@fecha_vcto		,
						@TR		OUTPUT	,
						@TE		OUTPUT	,
						@TV		OUTPUT	,
						@TT		OUTPUT	,
						@BA		OUTPUT	,
						@BF		OUTPUT	,
						@NOM		OUTPUT	,
						@MT		OUTPUT	,
						@VV		OUTPUT	,
						@VP		OUTPUT	,
						@PVP		OUTPUT	,
						@VAN		OUTPUT	,
						@FP		OUTPUT	,
						@FE		OUTPUT	,
						@FV		OUTPUT	,
						@FU		OUTPUT	,
						@FX		OUTPUT	,
						@FC		OUTPUT	,
						@CI		OUTPUT	,
						@CT		OUTPUT	,
						@INDEV		OUTPUT	,
						@PRINC		OUTPUT	,
						@FIP		OUTPUT	,
						@CAP		OUTPUT	,
						@INCTR		OUTPUT	,
						@Retorno		,
						@monemi




			UPDATE	Text_ctr_inv
			SET	cpinteres	= @INCTR
			WHERE	cpnumdocu	= @numdocu

		END
*/


		UPDATE	Text_ctr_inv
		SET	cpvptirc	= cpvalcomu + cpinteres
		WHERE	cpnumdocu	= @numdocu


		UPDATE	#cartera
		SET	sw ='S'
		WHERE	rutcart = @rutcart
		AND	numdocu = @numdocu

		IF @@ERROR<>0
		BEGIN

			SELECT 'NO','PROBLEMAS EN DEVENGAMIENTO'
			RETURN
		END

	END



	SET NOCOUNT OFF

	SELECT 'SI','ACTUALIZACION DE DEVENGAMIENTO OK......'

	RETURN

END


GO
