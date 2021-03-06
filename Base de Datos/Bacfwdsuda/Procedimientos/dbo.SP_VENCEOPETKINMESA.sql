USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VENCEOPETKINMESA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VENCEOPETKINMESA](
	@Fecha_Proceso		CHAR(8)
)
AS 
BEGIN
   SET NOCOUNT ON
		BEGIN TRANSACTION

		DELETE	TBL_CARTICKETFWD
		WHERE	FechaVencimiento < @Fecha_Proceso

		UPDATE	TBL_MOV_TICKETFWD
		SET	Estado	= 'X'
		WHERE	FechaVencimiento < @Fecha_Proceso
		

		IF @@error <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -1, 'NO SE PUEDE ACTUALIZAR LOS DATOS'
			RETURN
			END
		ELSE
			COMMIT TRANSACTION
		SELECT 0
END

GO
