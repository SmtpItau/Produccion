USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_MER_VLZ_INS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVA_MER_VLZ_INS]	
(	
			@dFechaproc	DATETIME	
		    ,	@docu		char(12)	
		    ,	@tir_aux	numeric(19,4)	
		    ,	@pvp_aux	numeric(19,4)	
		    ,	@tipo_calcu	numeric(1)
		    ,	@TipoValoriza	CHAR(02)	= ''						
)
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE @DFECPRO	DATETIME	
	,	@FECHA_VCTO	DATETIME	
	,	@FP		DATETIME	
	,	@FE		DATETIME	
	,	@FV		DATETIME	
	,	@FU		DATETIME	
	,	@FX		DATETIME	
	,	@FC		DATETIME	
	,	@FIP		DATETIME	
	,	@FECPAGO	DATETIME	
	,	@FECEMI		DATETIME	
	,	@FECVEN		DATETIME	
	,	@RUTCART	NUMERIC(09, 0)	
	,	@NUMDOCU	NUMERIC(12, 0)	
	,	@NOMINAL	NUMERIC(19, 4)	
	,	@TIRCOMP	NUMERIC(19, 4)	
	,	@PVPCOMP	NUMERIC(19, 4)	
	,	@VPCOMP		NUMERIC(19, 8)	
	,	@TASEMI		NUMERIC(19, 4)	
	,	@BASEMI		NUMERIC(03, 0)	
	,	@MONEMI		NUMERIC(03, 0)	
	,	@VPTIRC		NUMERIC(19, 4)	
	,	@CAPITAL	NUMERIC(19, 4)	
	,	@INTERES	NUMERIC(19, 4)	
	,	@REAJUST	NUMERIC(19, 4)	
	,	@REAJUSTE_ACUM	NUMERIC(19, 4)	
	,	@INTERES_ACUM	NUMERIC(19, 4)	
	,	@TIPO_CALCULO	NUMERIC(03, 0)	
	,	@TIPO_TASA	NUMERIC(03)	
	,	@COD_FAMILIA	NUMERIC(04)	
	,	@TR		FLOAT		
	,	@TE		FLOAT		
	,	@TV		FLOAT		
	,	@TT		FLOAT		
	,	@BA		FLOAT		
	,	@BF		FLOAT		
	,	@NOM		FLOAT		
	,	@MT		FLOAT		
	,	@VV		FLOAT		
	,	@VP		FLOAT		
	,	@PVP		FLOAT		
	,	@VAN		FLOAT		
	,	@CI		FLOAT		
	,	@CT		FLOAT		
	,	@INDEV		FLOAT		
	,	@PRINC		FLOAT		
	,	@INCTR		FLOAT		
	,	@TIPO_CAL	FLOAT		
	,	@CAP		FLOAT		
	,	@SPREAD		FLOAT		
	,	@VALCOMU	FLOAT		
	,	@TIPFOMULAS	CHAR(1)		
	,	@RETORNO	CHAR(1)		
	,	@COD_NEMO	CHAR(20)	

	DECLARE	@I	INTEGER
	,	@E	INTEGER

	CREATE TABLE #CARTERA	(	RUTCART		NUMERIC(9, 0)	,
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
					TIPO_CAL	NUMERIC(1)	
				)

--	WHILE nContador <= 2 BEGIN
						
		SELECT	@DFECPRO	= ''
		,	@FECHA_VCTO	= ''
		,	@FP		= ''
		,	@FE		= ''
		,	@FV		= ''	
		,	@FU		= ''	
		,	@FX		= ''	
		,	@FC		= ''	
		,	@FIP		= ''	
		,	@FECPAGO	= ''	
		,	@FECEMI		= ''	
		,	@FECVEN		= ''	
		,	@RUTCART	= 0	
		,	@NUMDOCU	= 0
		,	@BASEMI		= 0
		,	@MONEMI		= 0
		,	@TIPO_CALCULO	= 0
		,	@TIPO_TASA	= 0
		,	@COD_FAMILIA	= 0
		,	@NOMINAL	= 0.0
		,	@TIRCOMP	= 0.0
		,	@PVPCOMP	= 0.0
		,	@VPCOMP		= 0.0
		,	@TASEMI		= 0.0
		,	@VPTIRC		= 0.0
		,	@CAPITAL	= 0.0
		,	@INTERES	= 0.0
		,	@REAJUST	= 0.0
		,	@REAJUSTE_ACUM	= 0.0
		,	@INTERES_ACUM	= 0.0	
		,	@TR		= 0.0		
		,	@TE		= 0.0		
		,	@TV		= 0.0		
		,	@TT		= 0.0		
		,	@BA		= 0.0		
		,	@BF		= 0.0		
		,	@NOM		= 0.0		
		,	@MT		= 0.0		
		,	@VV		= 0.0		
		,	@VP		= 0.0		
		,	@PVP		= 0.0		
		,	@VAN		= 0.0		
		,	@CI		= 0.0		
		,	@CT		= 0.0		
		,	@INDEV		= 0.0		
		,	@PRINC		= 0.0		
		,	@INCTR		= 0.0		
		,	@TIPO_CAL	= 0.0		
		,	@CAP		= 0.0		
		,	@SPREAD		= 0.0		
		,	@VALCOMU	= 0.0		
		,	@TIPFOMULAS	= ''
		,	@RETORNO	= ''
		,	@COD_NEMO	= ''	
						
--		IF @nContador = 1 BEGIN 

		IF @TIPOVALORIZA IN ( '','BT') BEGIN
		
			INSERT #CARTERA
			(	RUTCART	
			,	NUMDOCU	
			,	COD_FAMILIA
			,	COD_NEMO
			,	NOMINAL	
			,	FECPAGO	
			,	VALCOMU	
			,	TIRCOMP	
			,	PVPCOMP	
			,	VPCOMP	
			,	FECEMI	
			,	FECVEN	
			,	TASEMI	
			,	BASEMI	
			,	MONEMI	
			,	VPTIRC	
			,	CAPITAL
			,	INTERES
			,	REAJUST
			,	TIPO_TASA
			,	SW
			,	TIPO_CAL
			)
			SELECT	RSRUTCART	
			,	RSNUMDOCU	
			,	COD_FAMILIA	
			,	COD_NEMO	
			,	RSNOMINAL	
			,	RSFECPAGO	
			,	RSVALCOMU	
			,	@tir_aux	
			,	@pvp_aux	
			,	RSVPCOMP	
			,	RSFECEMIS	
			,	RSFECVCTO	
			,	CASE WHEN Cod_familia <> 2006 THEN RSTASEMI	ELSE rstir END -->+++jcamposd 20161027
			,	RSBASEMI	
			,	RSMONEMI	
			,	0		
			,	0		
			,	RSINTERES	
			,	RSREAJUSTE	
			,	TIPO_TASA	
			,	'N'		
			,	@tipo_calcu		
			FROM 	TEXT_RSU
			WHERE	rsfecpro  = @dFechaproc
			AND	rsnumoper = @docu	
		END

--		ELSE IF @nContador = 2 BEGIN
		IF @TIPOVALORIZA = 'LT' BEGIN --LIBRE DE TRADING
			INSERT #CARTERA
			(	RUTCART	
			,	NUMDOCU	
			,	COD_FAMILIA
			,	COD_NEMO
			,	NOMINAL	
			,	FECPAGO	
			,	VALCOMU	
			,	TIRCOMP	
			,	PVPCOMP	
			,	VPCOMP	
			,	FECEMI	
			,	FECVEN	
			,	TASEMI	
			,	BASEMI	
			,	MONEMI	
			,	VPTIRC	
			,	CAPITAL
			,	INTERES
			,	REAJUST
			,	TIPO_TASA
			,	SW
			,	TIPO_CAL
			) 
			SELECT	Clt_RutCart
			,	Clt_NumDocu
			,	Clt_Codigo
			,	Clt_Instrum
			,	Clt_Nominal_MonCont
			,	Clt_FechaIni
			,	Clt_MonConv
			,	@tir_aux	
			,	@pvp_aux	
			,	0
			,	Clt_FechaIni
			,	Clt_FechaFin
			,	Clt_TasaEmi
			,	Clt_BaseEmi
			,	Clt_MonEmi
			,	0
			,	0
			,	0
			,	0
			,	Clt_TipoTasa
			,	'N'
			,	@tipo_calcu		
			FROM	BACTRADERSUDA..TBL_CARTERA_LIBRE_TRADING
			WHERE	Clt_FechaProc	= @dFechaproc
			AND	Clt_Sistema	= 'BEX'
			AND	Clt_NumOper	= @docu				
		END
	
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
		
		SELECT	@DFECPRO	= @dFechaproc	,	--1
			@TIPFOMULAS	= ' '		,
			@TIPO_CAL	= TIPO_CAL	,
			@FECHA_VCTO	= @FECVEN	,
			@TR		= @TIRCOMP	,	--5
			@TE		= @TASEMI	,
			@TV		= @TASEMI	,
			@TT		= @TIPO_TASA	,
			@BA		= @BASEMI	,
			@BF		= @BASEMI	,	--10
			@NOM	= @NOMINAL	,
			@MT		= @VPTIRC	,
			@VV		= 0		,
			@VP		= 0		,
			@PVP	= @PVPCOMP	,	--15
			@VAN	= 0		,
			@FP		= @dFechaproc	,
			@FE		= @FECEMI	,
			@FV		= @FECVEN	,
			@FU		= ''		,	--20
			@FX		= ''		,
			@FC		= @FECPAGO	,
			@CI		= 0		,
			@CT		= 0		,
			@INDEV	= 0		,	--25
			@PRINC	= 0		,
			@FIP	= @dFechaproc	,
			@INCTR	= 0		,
			@CAP	= @VPTIRC	,
			@RETORNO= 'N'		,	--27
			@SPREAD	= 0
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
						@FIP		OUTPUT	,
						@INCTR		OUTPUT	,
						@CAP		OUTPUT	,
						@SPREAD		OUTPUT	,
						@RETORNO		,
						@MONEMI
	

		IF @TIPOVALORIZA = '' BEGIN

			SELECT 	'SI'
			,	'MT'		= @MT	
			,	'TR'		= @TR	
			,	'PVP'		= @PVP	
			,	'NUMDOCU' 	= @docu
		END
		ELSE IF @TIPOVALORIZA = 'LT' BEGIN
			UPDATE BACTRADERSUDA..TBL_CARTERA_LIBRE_TRADING
			SET	Clt_TM_PP_Val	= @TR
			,	Clt_VPTM_ValAct	= @MT
			,	Clt_Res_VM_VP	= @MT - Clt_VPTC_ValAct
			WHERE	Clt_FechaProc	= @dFechaproc
			AND	Clt_Sistema	= 'BEX'
			AND	Clt_NumOper	= @docu
		END
		ELSE IF @TIPOVALORIZA = 'BT' BEGIN
			UPDATE	TEXT_RSU
			SET	RsTirmercParPrx		= @MT 
			,	RsTirmercCLPParPrx	= @MT * CASE WHEN @MONEMI = 999 THEN 1 ELSE ISNULL(vmValor,1) END
			FROM	TEXT_RSU	LEFT JOIN BACPARAMSUDA..VALOR_MONEDA
						ON	vmFecha		= @dFechaproc
						AND	vmCodigo	= CASE WHEN @MONEMI = 13 THEN 994 ELSE @MONEMI END
			WHERE	rsfecpro	= @dFechaproc
			AND	rsnumoper	= @docu	
		END

	SET NOCOUNT OFF	
END
GO
