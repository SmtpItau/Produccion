USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_FACTOR_CORRELACIONES_LINEAS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ACT_FACTOR_CORRELACIONES_LINEAS]	(	@IdSistema	CHAR(03)	
							,	@MonedaR	CHAR(10)
							,	@PlazoR		CHAR(10)
							,	@MonedaE	CHAR(10)
							,	@PlazoE		CHAR(10)
							,	@Factor		NUMERIC(11,8)
							,	@FactorDiv	NUMERIC(11,8)
							)
AS
BEGIN
	
	SET NOCOUNT ON

	BEGIN TRAN

	UPDATE	TBL_CORRELACIONES_LINEAS
	SET	Col_Factor	= @Factor
	,	Col_FactorMLMX	= @FactorDiv
	WHERE	Col_Id_Sistema		= @IdSistema
	AND	Col_MonedaAct		= @MonedaR
	AND	Col_CodigoPlazoAct	= @PlazoR
	AND	Col_MonedaPas		= @MonedaE
	AND	Col_CodigoPlazoPas	= @PlazoE

	IF @@ROWCOUNT = 0 BEGIN

		INSERT INTO TBL_CORRELACIONES_LINEAS
		(	Col_Id_Sistema
		,	Col_MonedaAct
		,	Col_CodigoPlazoAct
		,	Col_MonedaPas
		,	Col_CodigoPlazoPas
		,	Col_Factor
		,	Col_FactorMLMX
		)
		VALUES
		(	@IdSistema
		,	@MonedaR
		,	@PlazoR
		,	@MonedaE
		,	@PlazoE
		,	@Factor
		,	@FactorDiv
		)

		IF @@ERROR <> 0 BEGIN
			ROLLBACK TRAN
			PRINT 'HA OCURRIDO UN ERROR AL INTENTAR INSERTAR EL REGISTRO'
			RETURN
		END
	END

	UPDATE	TBL_CORRELACIONES_LINEAS
	SET	Col_FactorMLMX	= Col_FactorMLMX
	WHERE	Col_Id_Sistema		= @IdSistema
	AND	Col_MonedaAct		= @MonedaR
	AND	Col_CodigoPlazoAct	= @PlazoR

	IF @@ERROR <> 0 BEGIN 
		ROLLBACK TRAN
		PRINT 'HA OCURRIDO UN ERROR AL INTENTAR MODIFICAR EL REGISTRO'
		RETURN
	END

	COMMIT TRAN

	SET NOCOUNT OFF

END

GO
