USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_VALORESMONEDA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_VALORESMONEDA]
					(
					@xCodigo	NUMERIC(3)		,
					@xFecha		DATETIME		,
					@xValor		NUMERIC(19,4)		)
AS

BEGIN
SET NOCOUNT ON  
--BEGIN TRANSACTION      
   
--     IF EXISTS(SELECT * FROM Valor_Moneda (INDEX=vm01) WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha)
     IF EXISTS(SELECT * FROM Valor_Moneda WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha)
            UPDATE Valor_Moneda SET		vmvalor = @xValor WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha
     ELSE
            INSERT INTO VALOR_MONEDA(	vmcodigo	,
				vmfecha	,
				vmvalor	)
		VALUES(		@xCodigo	,
				@xFecha	,
				@xValor	)

IF @@ERROR <> 0 BEGIN
  SET NOCOUNT OFF
  SELECT 'NO'
  RETURN
END

--COMMIT TRANSACTION
SET NOCOUNT OFF
SELECT 'SI'
END

-- Sp_Graba_ValoresMoneda 127,'20000202',0
GO
