USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_CARGA_SI_HIPOTECARIO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_CARGA_SI_HIPOTECARIO]	(	@NroCredito	NUMERIC(10,0)
							,	@CantDiv	INT
							,	@TotalUF	FLOAT
							)
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE	@CantidadDividendos	INT
	DECLARE @FechaHoy		DATETIME
	,	@MtoTotalUF		FLOAT


	SELECT	@FechaHoy		= acfecproc
	FROM	MFAC

	IF EXISTS(SELECT 1 FROM	TBL_CARTERA_FLUJOS WHERE Ctf_Numero_Credito = @NroCredito and (select caantici from mfca where canumoper = Ctf_Numero_OPeracion)<>'A') BEGIN
		SELECT 'YA EXISTE'
	END 
	ELSE BEGIN
		SELECT 'NO EXISTE'
	END
/*
	SELECT	@CantidadDividendos	= COUNT(Ctf_Numero_Dividendo)
	,	@MtoTotalUF		= SUM(Ctf_Monto_Principal)
	FROM	TBL_CARTERA_FLUJOS	
	WHERE	Ctf_Numero_Credito	= @NroCredito

	IF @CantidadDividendos	IS NULL 
		SELECT @CantidadDividendos	= 0

	SELECT	@CantidadDividendos	= @CantidadDividendos + ISNULL((SELECT 1 FROM TBL_CARTERA_FLUJOS_RES WHERE Cfr_Numero_Credito = @NroCredito and Cfr_Estado = 'V' AND Cfr_fecha_vencimiento > @FechaHoy ),0)

	IF @MtoTotalUF IS NULL
		SELECT @MtoTotalUF	= 0

	IF @CantDiv = @CantidadDividendos AND @TotalUF = @MtoTotalUF BEGIN
		SELECT 'YA EXISTE'
	END
	ELSE BEGIN
		SELECT 'NO EXISTE'
	END
*/

	SET NOCOUNT OFF

END

GO
