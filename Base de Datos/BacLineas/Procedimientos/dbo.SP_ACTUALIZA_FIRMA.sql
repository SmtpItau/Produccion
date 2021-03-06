USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_FIRMA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_FIRMA]
	(
		@NumOper	NUMERIC(10)
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @NumOperAsoc	NUMERIC(10)
		SET @NumOperAsoc	= (SELECT TOP 1 monumdocu from BACTRADERSUDA.DBO.MDMO WHERE monumoper = @NumOper)

	DECLARE @Firma1			CHAR(10)
		SET @Firma1			= (SELECT TOP 1 mostatreg from BACTRADERSUDA.DBO.MDMO WHERE monumoper = @NumOperAsoc)

	DECLARE @Firma2			CHAR(10)
		SET	@Firma2			= ''

	DECLARE @TipoOper		CHAR(10)
		SET @TipoOper		= (SELECT TOP 1 motipoper from BACTRADERSUDA.DBO.MDMO WHERE monumoper = @NumOperAsoc)


	IF @Firma1 = '' and @TipoOper = 'CP'
	BEGIN
		UPDATE	BACLINEAS.DBO.DETALLE_APROBACIONES
		SET		Firma1				= (SELECT TOP 1 Firma1 FROM BACLINEAS.DBO.DETALLE_APROBACIONES with(nolock) WHERE Numero_Operacion = @NumOper AND Id_Sistema = 'BTR')
		,		Firma2				= (SELECT TOP 1 Firma2 FROM BACLINEAS.DBO.DETALLE_APROBACIONES with(nolock) WHERE Numero_Operacion = @NumOper AND Id_Sistema = 'BTR')
		WHERE	Numero_Operacion	= @NumOperAsoc
	END

END
GO
