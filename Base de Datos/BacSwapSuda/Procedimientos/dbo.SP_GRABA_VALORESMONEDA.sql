USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_VALORESMONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_VALORESMONEDA]
	(	@xCodigo	NUMERIC(3)
	,	@xFecha		DATETIME
	,	@xValor		NUMERIC(19,4)
	)
AS
BEGIN

	SET NOCOUNT OFF
	SELECT 'SI'  
RETURN

/*
	SET NOCOUNT ON  
   
	IF EXISTS(SELECT * FROM View_Valor_Moneda WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha)
		UPDATE View_Valor_Moneda SET vmvalor = @xValor WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha
	ELSE
		INSERT INTO View_Valor_Moneda(	vmcodigo	,
				vmfecha	,
				vmvalor	)
		VALUES(		@xCodigo	,
				@xFecha	,
				@xValor	)

	IF @@ERROR <> 0 
	BEGIN
		SET NOCOUNT OFF
		SELECT 'NO'  
		RETURN
	END

	SET NOCOUNT OFF
	SELECT 'SI'  
*/

END
GO
