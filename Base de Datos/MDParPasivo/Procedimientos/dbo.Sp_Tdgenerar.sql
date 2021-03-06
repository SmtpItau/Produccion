USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tdgenerar]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Tdgenerar]
				(
				@semascara	CHAR	(12)	,
				@sefecha	DATETIME	,
				@setera		NUMERIC	(9,4)	, 
				@secupones	NUMERIC	(3,0)	,
				@senumamor	NUMERIC (3,0)	,
				@sepervcup	NUMERIC (2,0)	,
				@nDecimales	INTEGER
				)
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

	DECLARE	@cDato		CHAR	(10) 	,
		@cFecha		DATETIME	,
		@inte		NUMERIC (9,4)	,
		@cupo		NUMERIC (3,0)	,
		@namo		NUMERIC (3,0)	,
		@pvcu		NUMERIC (2,0)	,
		@nDec		INTEGER		,
		@num_amo	INTEGER		,
		@n		NUMERIC (19,6)	,
		@f		INTEGER		,
		@ntp		NUMERIC (19,6)	,
		@flujo		NUMERIC (19,6)	,
		@aux_s		NUMERIC (19,6)	,
		@aux_cupo	INTEGER		,
		@aux_inte	NUMERIC (19,6)	,
		@aux_amo	NUMERIC (19,6)	,
		@aux_fluj	NUMERIC (19,6)

	SELECT	@cDato		= @semascara	,
		@cFecha		= @sefecha	,
		@inte		= @setera	,
		@cupo		= @secupones	,
		@namo		= @senumamor	,
		@pvcu		= @sepervcup	,
		@nDec		= @nDecimales

	SELECT	@num_amo	= @cupo - @namo
	SELECT	@n		= (@pvcu / 12.0)
	SELECT	@ntp		=  (POWER ((1.0 + @inte / 100.0), @n) - 1.0) * 100.0

	IF @num_amo=0.0 
		SELECT	@flujo	= (100.0 * @ntp / 100.0) * POWER((1.0 + @ntp / 100.0), @cupo)  / ( POWER((1.0 + @ntp / 100.0), @cupo ) - 1.0 )
	ELSE
		SELECT	@flujo	= (100.0 * @ntp / 100.0) * POWER((1.0 + @ntp / 100.0), @namo)  / ( POWER((1.0 + @ntp / 100.0), @namo ) - 1.0 )
   
	SELECT	@flujo	= ROUND(@flujo, @nDec)
	SELECT	@aux_s	= 100.0
	SELECT	@f	= 0

	SELECT	'mascara'	= SPACE(12)			,
		'fecha'		= SPACE(10)			,
		'cupon'		= 0				,
		'interes'	= CONVERT(NUMERIC(19,6),0)	,
		'amort'		= CONVERT(NUMERIC(19,6),0)	,
		'flujo'		= CONVERT(NUMERIC(19,6),0)	,
		'saldo'		= CONVERT(NUMERIC(19,6),0)
	INTO	#Temp

	DELETE FROM #Temp

	WHILE @f<>@cupo
	BEGIN
		SELECT	@f 		= @f + 1
		SELECT	@aux_cupo	= @f
		SELECT	@aux_inte	= ROUND(((@ntp / 100.0) * @aux_s), @nDec)

		IF @f=@cupo
		BEGIN
			SELECT	@aux_amo	= @aux_s
			SELECT	@aux_fluj	= (@aux_amo) + (@aux_inte)
		END
		ELSE                                                       
			IF @namo=@cupo
			BEGIN
				SELECT	@aux_fluj	= @flujo
				SELECT	@aux_amo	= (@flujo) - (@aux_inte)
			END
			ELSE
				IF @f<=@num_amo
				BEGIN
					SELECT	@aux_amo	= 0.0
					SELECT	@aux_fluj	= @aux_inte
				END
				ELSE
				BEGIN
					SELECT	@aux_fluj	= @flujo
					SELECT	@aux_amo	= (@flujo) - (@aux_inte)
				END
                                                                
				SELECT	@aux_s	= ( @aux_s ) - ( @aux_amo )

				IF @sefecha<>' '
					SELECT	@cFecha	= DATEADD(MONTH, @aux_cupo * @pvcu, @sefecha)

				IF @sefecha=' '
					SELECT	@cFecha	= NULL
   
				INSERT INTO #Temp
						(
						mascara				,
						fecha				,
						cupon				,
						interes				,
						amort				,
						flujo				,
						saldo
						)
				VALUES
						(
						@semascara			,
						CONVERT(CHAR(10),@cFecha,103)	,
						@aux_cupo			,
						@aux_inte			,
						@aux_amo			,
						@aux_fluj			,
						@aux_s
						)
			END

			SELECT	mascara					,
				'fecha'	= CONVERT(CHAR(10),fecha,103)	,
				cupon					,
				interes					,
				amort					,
				flujo					,
				saldo
			FROM	#Temp

END


GO
