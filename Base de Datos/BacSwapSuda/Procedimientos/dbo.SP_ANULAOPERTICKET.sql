USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULAOPERTICKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_ANULAOPERTICKET]
   (   @numoperacion    NUMERIC(10)   )
AS
BEGIN
	SET NOCOUNT ON

	DELETE	TBL_CARTICKETSWAP
	WHERE	numero_operacion = @numoperacion

	DELETE	TBL_CARTICKETSWAP
	WHERE	numero_operacion_relacional = @numoperacion

	DELETE	TBL_FLJTICKETSWAP
	WHERE	numero_operacion_relacional = @numoperacion

	DELETE	TBL_FLJTICKETSWAP
	WHERE	numero_operacion = @numoperacion




	UPDATE	TBL_MOVTICKETSWAP
	SET	Estado	= 'A'
	WHERE	numero_operacion = @numoperacion

	--- JBH, 17-12-2009 Anular también el movimiento espejo
	UPDATE	TBL_MOVTICKETSWAP
	SET	Estado	= 'A'
	WHERE	numero_operacion_relacional = @numoperacion
	--- fin JBH

	IF @@ERROR <> 0
	BEGIN
		SELECT -1, 'Error: al Anular Operación Ticket Intra Mesa'
		RETURN 
	END

	SELECT 'OK'
	SET NOCOUNT OFF
END



GO
