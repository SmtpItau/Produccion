USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_MER_VLZ_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_MER_VLZ_CAR] 
( 
       @dFechaproc	DATETIME ,
       @dFechaprox	DATETIME 
)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @DFECPRO	DATETIME	,
		@TIPFOMULAS	CHAR(1)		,
		@TIPO_CAL	FLOAT		,
		@COD_FAMILIA	NUMERIC(04)	,
		@COD_NEMO	CHAR(20)	,
		@FECHA_VCTO	DATETIME	,
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
		@RETORNO	CHAR(1)		
	


	DECLARE	@RUTCART	NUMERIC(9, 0)	,
		@NUMDOCU	NUMERIC(12, 0)	,
		@NOMINAL	NUMERIC(19, 4)	,
		@FECPAGO	DATETIME	,
		@VALCOMU	FLOAT		,
		@TIRCOMP	NUMERIC(19, 4)	,
		@PVPCOMP	NUMERIC(19, 4)	,
		@VPCOMP		NUMERIC(19, 8)	,
		@FECEMI		DATETIME	,
		@FECVEN		DATETIME	,
		@TASEMI		NUMERIC(19, 4)	,
		@BASEMI		NUMERIC(3, 0)	,
		@MONEMI		NUMERIC(3, 0)	,
		@VPTIRC		NUMERIC(19, 4)	,
		@CAPITAL	NUMERIC(19, 4)	,
		@INTERES	NUMERIC(19, 4)	,
		@REAJUST	NUMERIC(19, 4)	,
		@TIPO_TASA	NUMERIC(3)	,
		@REAJUSTE_ACUM	NUMERIC(19, 4)	,
		@INTERES_ACUM	NUMERIC(19, 4)	,
		@TIPO_CALCULO	NUMERIC(3,0)	




	DECLARE	@I	INTEGER,
		@E	INTEGER



	CREATE TABLE #CARTERA(
			RUTCART		NUMERIC(9, 0)	,
			NUMDOCU		NUMERIC(10, 0)	,
			COD_FAMILIA	NUMERIC(5, 0)	,
			COD_NEMO	CHAR (20)	,
			NOMINAL		NUMERIC(19, 4)	,
			FECPAGO		DATETIME	,
			VALCOMU		FLOAT		,
			TIRCOMP		NUMERIC(19, 4)	,
			PVPCOMP		NUMERIC(19, 4)	,
			VPCOMP		NUMERIC(19, 8)	,
			FECEMI		DATETIME	,
			FECVEN		DATETIME	,
			TASEMI		NUMERIC(19, 4)	,
			BASEMI		NUMERIC(3, 0)	,
			MONEMI		NUMERIC(3, 0)	,
			VPTIRC		NUMERIC(19, 4)	,
			CAPITAL		NUMERIC(19, 4)	,
			INTERES		NUMERIC(19, 4)	,
			REAJUST		NUMERIC(19, 4)	,
			TIPO_TASA	NUMERIC(3)	,
			SW		CHAR(1)		,
			TIPO_CAL	NUMERIC(1)	)

	INSERT INTO	#CARTERA
	SELECT	RSRUTCART	,
		RSNUMDOCU	,
		COD_FAMILIA	,
		COD_NEMO	,
		RSNOMINAL	,
		RSFECPAGO	,
		RSVALCOMU	,
		RSTIRMERC	,
		RSPVPMERC	,
		RSVPCOMP	,
		RSFECEMIS	,
		RSFECVCTO	,
		RSTASEMI	,
		RSBASEMI	,
		RSMONEMI	,
		0		,
		0		,
		RSINTERES	,
		RSREAJUSTE	,
		TIPO_TASA	,
		'N'		,
		(CASE 	WHEN (SELECT SW_TIR FROM TEXT_TASA_MERC WHERE RSNUMDOCU = NUMDOCU) = 1 THEN '2' 
			WHEN (SELECT SW_PVP FROM TEXT_TASA_MERC WHERE RSNUMDOCU = NUMDOCU) = 1 THEN '1' END)
	FROM 	TEXT_RSU
	WHERE	RSNOMINAL  > 0
	AND	RSFECPAGO <= @DFECHAPROC
	AND	RSFECVCTO >= @DFECHAPROX

	SELECT 	@E = (SELECT COUNT(*) FROM #CARTERA),
		@I = 0

	WHILE 	1=1
	BEGIN

		SET	ROWCOUNT 1

		

		SELECT	@I 		= @I + 1	,	
			@RUTCART	= RUTCART	,	
			@NUMDOCU	= NUMDOCU	,	
			@COD_FAMILIA	= COD_FAMILIA	,	
			@COD_NEMO	= COD_NEMO	,	--5
			@NOMINAL	= NOMINAL	,	
			@FECPAGO	= FECPAGO	,	
			@VALCOMU	= VALCOMU	,	
			@TIRCOMP	= TIRCOMP	,	
			@PVPCOMP	= PVPCOMP	,	--10
			@VPCOMP		= VPCOMP	,	
			@FECEMI		= FECEMI	,	
			@FECVEN		= FECVEN	,
			@TASEMI		= TASEMI	,
			@BASEMI		= BASEMI	,	--15
			@MONEMI		= MONEMI	,
			@VPTIRC		= VPTIRC	,
			@CAPITAL	= CAPITAL	,
			@INTERES_ACUM	= INTERES	,
			@REAJUSTE_ACUM	= REAJUST	,	--20
			@TIPO_TASA	= TIPO_TASA	,
			@INTERES	= 0		,
			@REAJUST	= 0		,
			@TIPO_CAL	= TIPO_CAL		--24
		FROM	#CARTERA
		WHERE	SW = 'N'

		SET ROWCOUNT 0

		SELECT	@DFECPRO	= @DFECHAPROX	,	--1
			@TIPFOMULAS	= ' '		,
			@TIPO_CAL	= TIPO_CAL	,
			@FECHA_VCTO	= @FECVEN	,
			@TR		= @TIRCOMP	,	--5
			@TE		= @TASEMI	,
			@TV		= @TASEMI	,
			@TT		= @TIPO_TASA	,
			@BA		= @BASEMI	,
			@BF		= @BASEMI	,	--10
			@NOM		= @NOMINAL	,
			@MT		= @VPTIRC	,
			@VV		= 0		,
			@VP		= 0		,
			@PVP		= @PVPCOMP	,	--15
			@VAN		= 0		,
			@FP		= @DFECHAPROX	,
			@FE		= @FECEMI	,
			@FV		= @FECEMI	,
			@FU		= ''		,	--20
			@FX		= ''		,
			@FC		= @FECPAGO	,
			@CI		= 0		,
			@CT		= 0		,
			@INDEV		= 0		,	--25
			@PRINC		= 0		,
			@RETORNO	= 'N'			--27
		FROM #CARTERA
			
			

		EXECUTE Svc_Prc_val_ins		@DFECPRO		,
						@TIPFOMULAS		,
						@TIPO_CAL		,
						@COD_FAMILIA		,
						@COD_NEMO		,
						@FECHA_VCTO		,
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
						@RETORNO
		UPDATE	#cartera
		SET	sw ='S'
		WHERE	rutcart = @rutcart
		AND	numdocu = @numdocu

			UPDATE TEXT_RSU 
				SET 	RSVALMERC = ISNULL(@MT,0)		,
					RSTIRMERC = ISNULL(@TR,0)		,
					RSPVPMERC = ISNULL(@PVP,0)
				where 	@NUMDOCU = rsnumdocu


		IF @I = @E BEGIN BREAK END
	END
	UPDATE text_arc_ctl_dri SET ACSW_TM = 1

	SELECT 'SI','Proceso Realizado con Exito'
	SET NOCOUNT OFF	
	RETURN
END

GO
