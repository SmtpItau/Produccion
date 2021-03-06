USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_OPERACION]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRAR_OPERACION]
   (   @NumOper   NUMERIC(10)   )
AS
BEGIN
   SET NOCOUNT ON

	DECLARE @NumeroMXCLP float
	SET @NumeroMXCLP = 0

	SELECT @NumeroMXCLP = var_moneda2 FROM MFCA 
         WHERE canumoper = @NumOper

	
	IF @NumeroMXCLP > 0
	BEGIN 
		DELETE FROM MFCA WHERE var_moneda2   = @NumeroMXCLP
		DELETE FROM MFMO WHERE moNroOpeMxClp = @NumeroMXCLP
	END 
	ELSE
	BEGIN
		DELETE FROM MFMO WHERE monumoper = @NumOper
		DELETE FROM MFCA WHERE canumoper = @NumOper

        END

END
GO
