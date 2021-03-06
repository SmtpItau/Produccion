USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHKFECHASDEVENGAMIENTO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CHKFECHASDEVENGAMIENTO]
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @dfechaproceso			DATETIME
	DECLARE @dfechaproximoproceso	DATETIME
	DECLARE @dfechacierremes		DATETIME
	DECLARE @ntasaestimadapcdusd	NUMERIC(19,4)
	DECLARE @ntasaestimadapcduf		NUMERIC(19,4)
	DECLARE @ntasaestimadaptf		NUMERIC(19,4)
	DECLARE @sswdevprop				CHAR(01)
	DECLARE @sswdevci				CHAR(01)
	DECLARE @sswdevvi				CHAR(01)
	DECLARE @sswdevib				CHAR(01)
	DECLARE @dFecante				DATETIME
	DECLARE @sswGarantia			CHAR(1)

	SELECT	@dfechaproceso			= acfecproc
		,	@dfechaproximoproceso	= acfecprox
		,	@sswdevprop				= acsw_dvprop
		,	@sswdevci				= acsw_dvci
		,	@sswdevvi				= acsw_dvvi
		,	@sswdevib				= acsw_dvib
		,	@dFecante				= acfecante
		,	@sswGarantia			= acsw_ges
	FROM	BacTraderSuda.dbo.MDAC

	SELECT	@ntasaestimadapcdusd	= ISNULL(vmvalor,0.0)
	FROM	VIEW_VALOR_MONEDA
	WHERE	vmcodigo				= 300 AND vmfecha = @dfechaproceso

	SELECT	@ntasaestimadapcduf		= ISNULL(vmvalor,0.0)
	FROM	VIEW_VALOR_MONEDA
	WHERE	vmcodigo				= 301 AND vmfecha = @dfechaproceso

	SELECT	@ntasaestimadaptf		= ISNULL(vmvalor,0.0)
	FROM	VIEW_VALOR_MONEDA
	WHERE	vmcodigo				= 302 AND vmfecha = @dfechaproceso
	
	SET		@ntasaestimadapcdusd	= ISNULL(@ntasaestimadapcdusd, 0.0)
	SET		@ntasaestimadapcduf		= ISNULL(@ntasaestimadapcduf,  0.0)
	SET		@ntasaestimadaptf		= ISNULL(@ntasaestimadaptf,    0.0)
	SET		@dfechacierremes		= @dfechaproximoproceso

	IF DATEDIFF(MONTH,@dfechaproceso, @dfechaproximoproceso) = 1
	BEGIN
		IF DATEDIFF(DAY,@dfechaproceso, @dfechaproximoproceso) > 1
		BEGIN
			SET	@dfechacierremes		=	CONVERT(CHAR(04),DATEPART(YEAR,@dfechaproximoproceso))
										+	RIGHT( '00' + CONVERT(VARCHAR(02),DATEPART(MONTH, @dfechaproximoproceso)), 2)
										+	'01'
			SET @dfechacierremes		=	DATEADD(DAY,-1,@dfechacierremes)
		END
	END

	SELECT	'fecha_proceso'				= CONVERT(CHAR(10),@dfechaproceso,103)					--> 01
		,	'fecha_proximo_proceso'		= CONVERT(CHAR(10),@dfechaproximoproceso,103)			--> 02
		,	'fecha_cierre_mes'			= CONVERT(CHAR(10),@dfechacierremes,103)				--> 03
		,	'tasa_estimada_pcdusd'		= @ntasaestimadapcdusd									--> 04
		,	'tasa_estimada_pcduf'		= @ntasaestimadapcduf									--> 05
		,	'tasa_estimada_ptf'			= @ntasaestimadaptf										--> 06
		,	'sw_devengo_prop'			= @sswdevprop											--> 07
		,	'sw_devengo_ci'				= @sswdevci												--> 08
		,	'sw_devengo_vi'				= @sswdevvi												--> 09
		,	'sw_devengo_ib'				= @sswdevib												--> 10
		,	'fecha_anterior'			= CONVERT(CHAR(10),@dFecante,103)						--> 11
		,	'sw_DevengoGarantias'		= @sswGarantia											--> 12

	SET NOCOUNT OFF

END
GO
