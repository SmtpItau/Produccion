USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_ANU_CMP_PPA_IM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVA_ANU_CMP_PPA_IM]
(
    @NumDocu CHAR (12)
)

/*

JBH, 02-11-2009, Anulación de movimientos intramesas

*/

AS
BEGIN
	SET NOCOUNT ON
	DECLARE @fec_pago datetime	
	SELECT @fec_pago = mofecpago FROM MOV_ticketbonext WHERE MONUMOPER = @NumDocu

	IF @fec_pago >= (SELECT acfecproc FROM text_arc_ctl_dri) 
	BEGIN
		if exists(SELECT monumdocu FROM MOV_ticketbonext WHERE monumdocu = @NumDocu AND mostatreg ='' AND motipoper='VP')
		BEGIN	 
			SELECT '1','La operaci½n de compras registra ventas asociadas al instrumento que compone la operaci½n que está anulando'
		END
		ELSE
		BEGIN
			DELETE 
			FROM 	CAR_ticketbonext	
			WHERE	cpnumdocu = @NumDocu

			UPDATE  MOV_ticketbonext	
			SET	MOSTATREG = 'A'
			WHERE	MONUMOPER = @NumDocu

			SELECT '2', 'Operación Anulada Exitosamente'
		END
	END 
	ELSE
	BEGIN
		SELECT '1', 'Esta Operación Ya No Se Puede Anular'
	END
	SET NOCOUNT OFF
END

GO
