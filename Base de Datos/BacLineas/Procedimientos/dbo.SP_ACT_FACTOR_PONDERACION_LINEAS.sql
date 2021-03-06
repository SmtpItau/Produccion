USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_FACTOR_PONDERACION_LINEAS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACT_FACTOR_PONDERACION_LINEAS]      (   @IdSistema      CHAR(03)
                                                      ,   @idMoneda       CHAR(08)
                                                      ,   @Plazo          FLOAT
                                                      ,   @Factor         FLOAT
                                                      ,   @TipoPondera    CHAR(1)
                                                      )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @REGISTRO_AFECTADO   INT

	IF ((@TipoPondera = 'T' AND @idMoneda NOT IN ('CLP','UF','USD','BRL')) OR 
		(@TipoPondera = 'D' AND @idMoneda NOT IN ('CLP','EUR','JPY','GBP','CAD','USD','BRL'))) BEGIN
		SELECT 'ERROR'
		RETURN 999
	END     
		
	SELECT @REGISTRO_AFECTADO = 0
		
	IF @TipoPondera = 'T' BEGIN
			
		UPDATE  TBL_FACTOR_PONDERACION_TASAS
		SET     Fpt_Factor  = @Factor
		WHERE   Fpt_Id_Sistema   = @IdSistema
		AND     Fpt_Moneda       = (CASE WHEN @IdMoneda = 'BRL' THEN 444 ELSE (SELECT mncodmon FROM BACPARAMSUDA.dbo.MONEDA WHERE mnnemo = @IdMoneda) END)
		AND     Fpt_Plazo        = @Plazo
				
		SELECT @REGISTRO_AFECTADO = @@ROWCOUNT
	END
			
	IF @TipoPondera = 'D' BEGIN
			
		UPDATE  TBL_FACTOR_PONDERACION_DIVISAS
		SET     Fpd_Factor   = @Factor
		WHERE   Fpd_Id_Sistema   = @IdSistema
		AND     Fpd_Moneda       = (CASE WHEN @IdMoneda = 'BRL' THEN 444 ELSE (SELECT mncodmon FROM BACPARAMSUDA.dbo.MONEDA WHERE mnnemo = @IdMoneda) END)
		AND     Fpd_Plazo        = @Plazo
			
		SELECT @REGISTRO_AFECTADO = @@ROWCOUNT
	END
			
	IF @REGISTRO_AFECTADO = 0 BEGIN
		IF @TipoPondera = 'T' BEGIN
				
		INSERT	INTO TBL_FACTOR_PONDERACION_TASAS
		(	Fpt_Id_Sistema
		,	Fpt_Moneda
		,	Fpt_Plazo
		,	Fpt_Factor
		)
		SELECT	@IdSistema
		,	(CASE WHEN @IdMoneda = 'BRL' THEN 444 ELSE (SELECT mncodmon FROM BACPARAMSUDA.dbo.MONEDA WHERE  mnnemo = @IdMoneda ) END)
		,	@Plazo
		,	@Factor


		IF @@ERROR <> 0 BEGIN
			PRINT 'ERROR AL INTENTAR INSERTAR EL NUEVO REGISTRO'
			RETURN
		END
	END 
	ELSE IF @TipoPondera = 'D'
		INSERT	INTO TBL_FACTOR_PONDERACION_DIVISAS
		(	Fpd_Id_Sistema
		,	Fpd_Moneda
		,	Fpd_Plazo
		,	Fpd_Factor
		)
		SELECT	@IdSistema
		,	(CASE WHEN @IdMoneda = 'BRL' THEN 444 ELSE (SELECT mncodmon FROM BACPARAMSUDA.dbo.MONEDA WHERE  mnnemo = @IdMoneda ) END)
		,	@Plazo
		,	@Factor

		IF @@ERROR <> 0 BEGIN
			PRINT 'ERROR AL INTENTAR INSERTAR EL NUEVO REGISTRO'
			RETURN
		END

	END

	SET NOCOUNT OFF	

END
GO
