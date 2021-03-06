USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRORRATEA_TBL_VALORIZACION_VALORMERCADO]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PRORRATEA_TBL_VALORIZACION_VALORMERCADO]
	(	@Serie		CHAR(12)
	,   @Emisor		CHAR(10)
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @nFactor	FLOAT
	DECLARE @nNominal	NUMERIC(21,4)
	DECLARE @tNominal	NUMERIC(21,4)
	DECLARE @nRegistro	NUMERIC(9)
	DECLARE @nFolioGar	NUMERIC(9)
	DECLARE @nCarreGar	NUMERIC(9)
	DECLARE @nFolioBac	NUMERIC(9)
	DECLARE @nCorreBac	NUMERIC(9)

	DECLARE @vCompra	NUMERIC(21,4)

	DECLARE Cursor_Actualizacion_Tbl_Valorizacion	SCROLL CURSOR FOR
	SELECT	Garantia_Numero
		,	Garantia_Correlativo
		,	NumeroDocumento
		,	CorrelativoDocumento
		,	Nominal
	FROM	bdbomesa.Garantia.Tbl_Valorizacion_Instrumento
			inner join	
			(	select	cpnumdocu, cpcorrela, cpnominal, codigo_carterasuper, Fecha_PagoMañana
					,	genemi = Disp.digenemi
				from	BacTraderSuda.dbo.mdcp with(nolock)
						inner join 
						(	select	dinumdocu, dicorrela, digenemi
							from	BacTraderSuda.dbo.mddi with(nolock)
						)	Disp	On	Disp.dinumdocu	= cpnumdocu
									and	Disp.dicorrela	= cpcorrela
			)	cpBAC	On	cpBAC.cpnumdocu = NumeroDocumento
						and	cpBAC.cpcorrela	= CorrelativoDocumento
	WHERE	Nominal		   <> 0
	AND		Serie			= @Serie
	AND		cpBAC.genemi	= @Emisor
	ORDER
	BY		NumeroDocumento
		,	CorrelativoDocumento

	OPEN Cursor_Actualizacion_Tbl_Valorizacion

	FETCH FIRST FROM Cursor_Actualizacion_Tbl_Valorizacion
	INTO 	@nFolioGar
		,	@nCarreGar
		,	@nFolioBac
		,	@nCorreBac
		,	@nNominal

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT	@tNominal				= Nominal
			,	@vCompra				= valorcompraum
		FROM	Tbl_Valorizacion_Instrumento_Agrupada
		WHERE	Garantia_Numero			= @nFolioGar
		AND		NumeroDocumento			= @nFolioBac
		AND		CorrelativoDocumento	= @nCorreBac

		SET		@nFactor				= (@nNominal / @tNominal)

		--------------------------------------------------------------------
		UPDATE	bdbomesa.Garantia.Tbl_Valorizacion_Instrumento
			SET	ValorMercado			= ROUND(@nFactor * GRUPO.ValMerc, 0)
			,	DiferenciaMercado		= ROUND(@nFactor * GRUPO.DifMerc, 0)
			,	TasaMercado				= GRUPO.TasaMerc
		FROM	
			(	SELECT	FolioGar				= Garantia_Numero
					,	NumDocu					= NumeroDocumento
					,	Correlativo				= CorrelativoDocumento
					,	NOM						= Nominal
					,	ValMerc					= ValorMercado
					,	DifMerc					= DiferenciaMercado
					,	TasaMerc				= TasaMercado
				FROM	Tbl_Valorizacion_Instrumento_Agrupada
				WHERE	Garantia_Numero			= @nFolioGar
				AND		NumeroDocumento			= @nFolioBac
				AND		CorrelativoDocumento	= @nCorreBac
			)	GRUPO
		WHERE	Garantia_Numero			= @nFolioGar
		AND		Garantia_Correlativo	= @nCarreGar
		AND		NumeroDocumento			= @nFolioBac
		AND		CorrelativoDocumento	= @nCorreBac

		AND		GRUPO.FolioGar			= Garantia_Numero
		AND		GRUPO.NumDocu			= NumeroDocumento
		AND		GRUPO.Correlativo		= CorrelativoDocumento

		FETCH NEXT FROM Cursor_Actualizacion_Tbl_Valorizacion
		INTO 	@nFolioGar
			,	@nCarreGar
			,	@nFolioBac
			,	@nCorreBac
			,	@nNominal
	END

	CLOSE Cursor_Actualizacion_Tbl_Valorizacion
	DEALLOCATE Cursor_Actualizacion_Tbl_Valorizacion

END
GO
