USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_FACTOR_CORRELACIONES_LINEAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_DEL_FACTOR_CORRELACIONES_LINEAS]	(	@IdSistema	CHAR(10)
							,	@MonedaR	CHAR(10)
							,	@PlazoR		CHAR(10)
							,	@MonedaE	CHAR(10)
							,	@PlazoE		CHAR(10)
							)
AS
BEGIN
	SET NOCOUNT ON

	BEGIN TRAN

	DELETE	TBL_CORRELACIONES_LINEAS
	WHERE	Col_Id_Sistema		= @IdSistema
	AND	Col_MonedaAct		= @MonedaR
	AND	Col_CodigoPlazoAct	= @PlazoR
	AND	Col_MonedaPas		= @MonedaE
	AND	Col_CodigoPlazoPas	= @PlazoE
	
	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRAN
		PRINT 'HA OCURRIDO UN ERROR AL INTENTAR ELIMINAR UN FACTOR DE CORRELACION'
		RETURN
	END

	COMMIT TRAN

	SET NOCOUNT OFF
END

GO
