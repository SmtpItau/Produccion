USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_ValoresMoneda_extranjera]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Graba_ValoresMoneda_extranjera]
                                          (	@xCodigo		NUMERIC(3)		,
						@xFecha		DATETIME		,
						@xValor		NUMERIC(19,4)		)
AS
BEGIN
      
   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET NOCOUNT ON  

     IF EXISTS(SELECT 1 FROM VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha)
            UPDATE VALOR_MONEDA WITH (ROWLOCK)
		SET		vmvalor_BO = @xValor 
		WHERE vmcodigo = @xCodigo AND vmfecha = @xFecha
     ELSE
            INSERT INTO VALOR_MONEDA WITH (ROWLOCK)
			(	
				vmcodigo	
				,vmfecha	
				,vmvalor
				,vmvalor_BO
			)
		VALUES	(		
				@xCodigo
				,@xFecha	
				,0 
				,@xValor	

			)


     END

	IF @@ERROR <> 0 BEGIN
	  SELECT "NO"
	  RETURN



SELECT "SI"
END


GO
