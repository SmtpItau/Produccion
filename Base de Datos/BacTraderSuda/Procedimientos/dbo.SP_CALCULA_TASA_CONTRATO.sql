USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULA_TASA_CONTRATO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
	/*
		declare @nTasaContrato	numeric(9,6)
		Execute dbo.SP_CALCULA_TASA_CONTRATO 'BCU0300221', 32, 2510, 2.98, '20150930', 1, 360, 998, 0.0, '20110201', '20210201', 3.0, 'S', 64047718, 0, 2526.8471, '20150930', '20160201', @nTasaContrato output
		select	@nTasaContrato
	*/

CREATE PROCEDURE  [dbo].[SP_CALCULA_TASA_CONTRATO]
	(	@cinstser		CHAR(10)			-->	'BCU0300221'
	,	@ncodigo 		INTEGER				-->	32
	,	@nnominal		NUMERIC(19,4)		-->	2510
	,	@ntircomp		NUMERIC(09,4)		-->	2.98
	,	@cfecpro		DATETIME			-->	'20150930'
	,	@ctipcart		NUMERIC(05,0)		-->	1
	,	@nbasemi 		NUMERIC(03)			-->	360
	,	@nmonemi 		NUMERIC(03)			-->	998
	,	@ntasest		NUMERIC(09,4)		-->	0.0
	,	@cfecemi   		DATETIME			-->	'20110201'
	,	@cfecven   		DATETIME			-->	'20210201'
	,	@ntasemi		NUMERIC(09,4)		-->	3.0
	,	@nSeriado		CHAR(1)				-->	'S'
	,	@nValcomp		FLOAT				-->	64047718
	,	@nValvenc		FLOAT				-->	0
	,	@nValcomu		FLOAT				-->	2526.8471
	,	@dFecPagHm		DATETIME			-->	'20150930'
	,	@dFecpCup		DATETIME			-->	'20160201'
	,	@nTasaContrato	NUMERIC(09,6)	OUTPUT 
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @fPvp			FLOAT
	DECLARE @fMT			FLOAT
	DECLARE @fMTUM			FLOAT
	DECLARE @fMT_cien		FLOAT
	DECLARE @fVan			FLOAT
	DECLARE @fVpar			FLOAT
	DECLARE @nNumucup		INTEGER
	DECLARE @fIntucup		FLOAT
	DECLARE @fAmoucup		FLOAT
	DECLARE @fSalucup		FLOAT
	DECLARE @nNumpcup		INTEGER
	DECLARE @fIntpcup		FLOAT
	DECLARE @fAmopcup		FLOAT
	DECLARE @fSalpcup		FLOAT
	DECLARE @fDurat			FLOAT
	DECLARE @fConvx			FLOAT
	DECLARE @fDurmo			FLOAT
	DECLARE @nError			INTEGER
	DECLARE @nAmor			INTEGER
	DECLARE @nvalmon		FLOAT
	DECLARE @nvalmonPxpr	FLOAT
	DECLARE @nDias			INTEGER
	DECLARE @cProg			CHAR(10)
	DECLARE @nValVcto		FLOAT
	DECLARE @nCupones		INTEGER
	DECLARE @dFecucup		DATETIME
	DECLARE @nTasaCont		NUMERIC(09,06)
	DECLARE @dFecpro		DATETIME
	DECLARE @nValMonHoy		FLOAT

	SELECT	@dFecpro		= acfecproc
	FROM	MDAC

--	If @ncodigo = 33 OR @ncodigo = 35 OR @ncodigo = 36 OR @ncodigo = 37 OR @ncodigo = 39 OR @nmonemi = 999 --> Bono BCP de Central en Pesos O Pepeles en dolares Cbg 18/08/2004 -- 26/03/2010 se agrega BTP de Tesoreria
	If @ncodigo = 33 OR @ncodigo = 37 OR @ncodigo = 38 OR @ncodigo = 39 OR @ncodigo = 40 OR @nmonemi = 999 --> BCP, XERO, PCX, BCX, BTP
		Select @nValMonHoy = 1
	else
		Select @nValMonHoy = Vmvalor From View_Valor_moneda with(nolock) Where vmcodigo = @nmonemi and Vmfecha = @dFecpro

	Select @nvalmon = 1
	Select @nvalmonPxpr = 1

	if @nSeriado = 'S'
	begin
		Select @nAmor		= (Select senumamort FROM bacparamsuda.dbo.serie with(nolock) /*VIEW_SERIE*/ WHERE seserie = @cinstser)
		Select @nCupones	= (Select secupones	 FROM bacparamsuda.dbo.serie with(nolock) /*VIEW_SERIE*/ WHERE seserie = @cinstser)
	end else 
	Begin
		Select @nAmor		= 0
		Select @nCupones	= 0
	end

	IF @nmonemi <> 999 and @nmonemi <> 13
	BEGIN
		select @nvalmon		= isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmfecha = @cfecven	and vmcodigo = @nmonemi),1)
		Select @nvalmonPxpr = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmfecha = @dFecPagHm	and vmcodigo = @nmonemi),1)
	END ELSE 
	BEGIN
	--	If @ncodigo = 33 OR @ncodigo = 35 OR @ncodigo = 36 OR @ncodigo = 37 OR @ncodigo = 39																			--> Bono BCP de Central en Pesos O Pepeles en dolares Cbg 18/08/2004 -- 26/03/2010 se agrega BTP de Tesoreria
		IF @ncodigo = 33 OR @ncodigo = 37 OR @ncodigo = 38 OR @ncodigo = 39 OR @ncodigo = 40 --> BCP, XERO, PCX, BCX, BTP
		BEGIN
			Select @nvalmon		= 1
			Select @nvalmonPxpr = 1
		END
	END

	Select @nDias = DATEDIFF(DD,(CASE WHEN @dFecPagHm = @cfecpro THEN @cfecpro ELSE @dFecPagHm END) ,@cfecven )
	Select @cProg = ( select inprog from BacParamSuda.dbo.Instrumento with(nolock) where incodigo = @ncodigo )
	Select @cProg = 'SP_' + @cProg

	IF @ntircomp < 0
	BEGIN
		Select @fPvp		= 0
		Select @fMt			= 0
		Select @fMtum		= 0
		Select @fMt_cien	= 0
		Select @fVan		= 0
		Select @fVpar		= 0
		Select @nNumucup	= 0
		Select @dFecucup	= ''
		Select @fIntucup	= 0
		Select @fAmoucup	= 0
		Select @fSalucup	= 0
		Select @nNumpcup	= 0
		Select @fIntpcup	= 0
		Select @fAmopcup	= 0
		Select @fSalpcup	= 0
		Select @fDurat		= 0
		Select @fConvx		= 0
		Select @fDurmo		= 0

		EXECUTE @nError		=	@cProg 2
							,	@dFecpro, @ncodigo, @cinstser, @nmonemi, @cfecemi, @cFecven, @ntasemi, @nbasemi, @ntasest
							,	@nnominal OUTPUT, @ntircomp OUTPUT, @fPvp	  OUTPUT, @fMt		OUTPUT
							,	@fMtum	  OUTPUT, @fMt_cien OUTPUT, @fVan	  OUTPUT, @fVpar	OUTPUT
							,	@nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup	OUTPUT
							,	@fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT, @fIntpcup	OUTPUT
							,	@fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat	  OUTPUT, @fConvx	OUTPUT,	@fDurmo OUTPUT

		SELECT @nValvenc	= ROUND( round( Round( (@fIntpcup + @fAmopcup),6) * @nnominal,6) / 100,6)
		SELECT @nValcomu	= Round( @nValcomp / @nValMonHoy, 4)

		-- VGS 11/07/2006
		IF @dFecpcup = @cFecven
			SELECT @fMtum	= 0.0

		SELECT @nValVcto	= (CASE	WHEN @nAmor  = 1 AND @nSeriado = 'S' THEN	Round((@fMtum + @nValvenc) * @nvalmon,0)
									WHEN @nAmor <> 1 AND @nSeriado = 'S' THEN	Round(@nValvenc * @nvalmon,0)
									ELSE										Round(@nnominal * @nvalmon,0)
								END)
		--	SELECT 'Tasa Negativa'
		--	Select @nTasaContrato	= Round( ( ( (@nValVcto - @nValcomp) / @nValcomp ) * 36000 ) / @nDias ,6)
		If	@ctipcart = 2 /*CARTERA AVILABLE FOR SALE*/
			SELECT @nTasaContrato	= Round(((( @nValVcto - @nValcomu ) / @nValcomu ) * 36000) / @nDias, 6)
		ELSE
			SELECT @nTasaContrato	= @ntircomp

	END ELSE
	BEGIN
		SELECT @nValcomu = (CASE	WHEN @dFecPagHm = @cfecpro THEN @nValcomu 
									ELSE (@nValcomp / @nvalmonPxpr) 
								END)

		IF @ctipcart = 2 -- Cartera Available For Sale
		BEGIN

		--	IF @ncodigo in(4, 31, 32, 33, 34, 35, 36, 38, 39)	--> PRC PRD BCD BCP BCU BCX PCX BTU - CBG 18/04/2004  -- MMP 26/03/2010 Se agrega BTP			
			IF @ncodigo in(4, 31, 32, 33, 34, 36, 38, 39)		-->	PRC PRD BCD BCP BCU BCX PCX BTU - CBG 18/04/2004  -- MMP 26/03/2010 Se agrega BTP
			BEGIN
				Select @fPvp		= 0
				Select @fMt			= 0
				Select @fMtum		= 0
				Select @fMt_cien	= 0
				Select @fVan		= 0
				Select @fVpar		= 0
				Select @nNumucup	= 0
				Select @dFecucup	= ''
				Select @fIntucup	= 0
				Select @fAmoucup	= 0
				Select @fSalucup	= 0
				Select @nNumpcup	= 0
				Select @fIntpcup	= 0
				Select @fAmopcup	= 0
				Select @fSalpcup	= 0
				Select @fDurat		= 0
				Select @fConvx		= 0
				Select @fDurmo		= 0

				EXECUTE @nError		= @cProg 2
									, @dFecpCup, @ncodigo,@cinstser, @nmonemi, @cfecemi, @cFecven,	@ntasemi, @nbasemi, @ntasest
									, @nnominal	OUTPUT, @ntircomp OUTPUT, @fPvp		OUTPUT, @fMt		OUTPUT
									, @fMtum	OUTPUT, @fMt_cien OUTPUT, @fVan		OUTPUT, @fVpar		OUTPUT
									, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup	OUTPUT
									, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT, @fIntpcup	OUTPUT
									, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat	OUTPUT, @fConvx		OUTPUT, @fDurmo OUTPUT

				-- Calcula tasa con el valor del vencimiento proximo cupon
				-- recordar que se valoriza al proximo cupon por lo que la variable dfecpcup esta con
				-- el subsiguiente cupon, por lo que se debe tomar la variable dfecucup, que si contiene el proximo cupon
				-- efectivo ¡¡¡¡¡¡OJO!!!!!!

				Select @nDias = DATEDIFF(DD,(CASE WHEN @dFecPagHm = @cfecpro THEN @cfecpro ELSE @dFecPagHm END) ,@dFecucup )

				-- Calcula el valor al vencimiento del proximo cupon
				-- lo mismo ocurre con los valores de interes cupon y amortización cupon, como en la fecha
				-- del proximo cupon ¡¡¡¡¡¡OJO!!!!!!
				select @nValvenc = ROUND( round( Round( (@fIntucup+@fAmoucup),6) * @nnominal,6) / 100,6)
				select @nTasaContrato = ROUND((((@nValvenc + @fMtum - @nValcomu) / @nValcomu) / @nDias) * 36000,6)
			END ELSE
			
			IF SUBSTRING(@cinstser,1,3) = 'PCD' And @nmonemi = 994
			BEGIN
				IF @dFecPagHm = @cfecpro  -- Pago Hoy
				BEGIN
					IF @nAmor = 1 And @nmonemi <> 999
					BEGIN
						/* Cupón Anterior*/
						SET ROWCOUNT 1

						SELECT	@nNumucup   = tdcupon
							,	@dFecucup   = tdfecven
							,	@fIntucup   = tdinteres
						FROM	BacParamSuda.dbo.Tabla_Desarrollo with(nolock)
						WHERE	tdmascara	= @cinstser
						and		tdfecven    < @dFecpcup
						ORDER
						BY		tdcupon		DESC

						SET ROWCOUNT 0

						SET @nnominal	= (@nCupones-@nNumucup) * (@nnominal * @fIntucup / 100)
						-- Resultado
						SET  @nTasaContrato = Round((( (@nnominal - @nValcomu) / @nValcomu ) * 36000 ) / @nDias ,6)
					END ELSE
					BEGIN
						--	Select ''PCD PAGO HOY 994 Amortizacion > 1 moneda == 999''
						SET @nTasaContrato = @ntircomp
					END
				END ELSE
				BEGIN
					--	Select ''PCD PAGO MAÑANA 994''
	 				SET @nTasaContrato = 0
				END
			END
			ELSE

			IF SUBSTRING(@cinstser,1,4) = 'PDBC' OR SUBSTRING(@cinstser,1,4) = 'DPF' OR SUBSTRING(@cinstser,1,4) = 'DPX'	--jcamposd se suma DPX
			BEGIN
				SET @nTasaContrato = Round((((@nnominal - @nValcomp) / @nValcomp) / @nDias) * 36000,6)
			END ELSE

			IF SUBSTRING(@cinstser,1,4) = 'ZERO' Or SUBSTRING(@cinstser,1,4) = 'CERO'  OR SUBSTRING(@cinstser,1,4) = 'XERO'
			BEGIN
				SET @nTasaContrato = Round((((@nnominal - @nValcomu) / @nValcomu) / @nDias) * 36000,6)
			END ELSE 
			BEGIN
				SET @nTasaContrato = @ntircomp
			END

		END ELSE
		BEGIN
			IF (SUBSTRING(@cinstser,1,4) = 'PDBC' or SUBSTRING(@cinstser,1,3) = 'DPF' or SUBSTRING(@cinstser,1,3) = 'DPX') And @ctipcart = 1  -- Cartera Trading --jcamposd se suma DPX
			BEGIN
				SELECT @nTasaContrato = Round((((@nnominal - @nValcomp) / @nValcomp) / @nDias) * 36000,6)
			END ELSE

			SET @nTasaContrato = @ntircomp
		END
	END

	SELECT @nTasaContrato

	SET NOCOUNT OFF

END
GO
