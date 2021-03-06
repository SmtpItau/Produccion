USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ULTIMAOPERACION_TICKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ULTIMAOPERACION_TICKET]
AS
BEGIN
SET NOCOUNT ON

	UPDATE SWAPGENERAL   
	SET	AcTicketMesa  = AcTicketMesa  + 1

	IF @@ERROR <> 0
	BEGIN
		SELECT -1, 'No se puede capturar Correlativo de Operacion Ticket Intra Mesa'
		SET NOCOUNT OFF
		RETURN
	END

	----<< Correlativo de Operacion de ticket Intra Mesa

	DECLARE @NumOperacion NUMERIC(7)

	SELECT	AcTicketMesa
	FROM SWAPGENERAL  

   SET NOCOUNT OFF
END

GO
