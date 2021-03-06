USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_IND_ACT_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVA_IND_ACT_CAR]
(
	@Fecha DATETIME
)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE	@FechaVcto		DATETIME
    DECLARE	@PrimerDiaMes	CHAR(12)
	DECLARE	@UltimoDiaMes	CHAR(12)
	DECLARE	@fecpro			DATETIME
	DECLARE	@acfecant		DATETIME

	SELECT  @fecpro       = acfecproc
		,	@acfecant     = acfecante
	FROM	TEXT_ARC_CTL_DRI

	/*******************************************************************************************/
	/* Borrado de la table text_mvt_dri_tas_merc	        			    */
	/*  que fue creada para almacenar informacion del dia para su contabilizacion*/
	/*  por lo cual se debe borrar su contenido para cada inicio de dia                   */
	/*******************************************************************************************/

	DELETE FROM TEXT_MVT_DRI_TAS_MERC

	/*********----------fin*********/

	IF  MONTH ( @fecpro ) <> MONTH( @acfecant ) 
	BEGIN
		SELECT @PrimerDiaMes	= SUBSTRING( ( convert(char(8), @fecpro , 112))  ,1,6)  + '01'
		SELECT @UltimoDiaMes	= CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)
        SELECT @fecpro			= CONVERT(DATETIME,  @UltimoDiaMes ,112)
        SELECT @Fecha			= @fecpro 
	END 

	EXECUTE BACLINEAS..Sp_Exposicion_Maxima_Actualiza_Inicio 'BEX'

	UPDATE	TEXT_CTR_INV
	SET		cpcapital		= rsvalcomu,
			cpinteres		= rsinteres_acum,
			cpreajust		= rsreajuste_acum,
			cpvptirc		= rsvppresenx,
			princdia        = rsprincipal,
            ValorPresentAnt = rsvppresen
	FROM	TEXT_RSU
	WHERE	rsfecpro		= @Fecha
	AND		rsrutcart		= cprutcart
	AND		rsnumdocu		= cpnumdocu
	AND		rstipoper		= 'DEV'
	AND		rscartera		= '333'

	IF @@ERROR<>0
	BEGIN
		SELECT 'NO', 'Proceso de Actualización en la cartera de compras propias a fallado.'
		SET NOCOUNT OFF
		RETURN
	END

	UPDATE	TEXT_CTR_INV
	SET		cptirmerc		= rstirmerc,	-->	AFS
            cppvpmerc		= rspvpmerc,	-->	AFS
            cpvalmerc		= rsvalmerc		-->	AFS
	FROM	TEXT_RSU
	WHERE	rsfecpro		= (select acfecproc from text_arc_ctl_dri)
	AND		rsrutcart		= cprutcart
	AND		rsnumdocu		= cpnumdocu
	AND		rstipoper		= 'DEV'
	AND		rscartera		= '333'

	IF @@ERROR <> 0
	BEGIN
		SELECT 'NO', 'Proceso de actualización en la cartera de mercado ha fallado'
		SET NOCOUNT OFF
		RETURN
	END

	SELECT	@FechaVcto  = acfecproc FROM text_arc_ctl_dri

	UPDATE	TEXT_CTR_INV
	SET		cpcapital	= rsvalcomu,
            cpvalcomu	= rsvalcomu,
			cpinteres	= rsinteres_acum,
			cpreajust	= rsreajuste_acum,
            princdia    = rsprincipal,  
            cpvptirc	= rsprincipal	--cpvptirc - ( rsvalvenc - rsinteres_acum)
	--		ValorPresentAnt = rsvppresen
	FROM	TEXT_RSU
	WHERE	rsfecpro	= @FechaVcto  
	AND		rsrutcart	= cprutcart
	AND		rsnumdocu	= cpnumdocu
	AND		rstipoper	= 'VCP'
	AND		rscartera	= '333'

	SET NOCOUNT OFF

	RETURN
END

GO
