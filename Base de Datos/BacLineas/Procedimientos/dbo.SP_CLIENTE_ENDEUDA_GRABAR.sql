USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTE_ENDEUDA_GRABAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLIENTE_ENDEUDA_GRABAR]
		(	@rut		NUMERIC(9,0)	,
			@codigo		NUMERIC(9,0)	,
			@garantia	NUMERIC(19,0)	,
			@endeudamiento	NUMERIC(19,0)	,
			@porcentaje	NUMERIC(7,4)	,
			@porcentaje3	NUMERIC(7,4)
		)
AS
BEGIN

	SET NOCOUNT ON

	IF EXISTS(	SELECT 	* 
			FROM	cliente_endeudamiento 
			WHERE 	Rut_Cliente = @rut AND 
				Codigo_Cliente = @codigo
		)
		BEGIN
			UPDATE	cliente_endeudamiento
			SET	Garantia 	= @garantia		,
				Endeudamiento	= @endeudamiento	,
				Porcentaje	= @porcentaje		,
				Porcentajetres	= @porcentaje3		
			WHERE	Rut_Cliente	= @rut 		AND 
				Codigo_Cliente	= @codigo
		END
	ELSE
		BEGIN
			INSERT INTO cliente_endeudamiento
				(	Rut_Cliente	,
					Codigo_Cliente	,
					Porcentaje	,
					Endeudamiento	,
					Garantia	,
					Utilizado    	,
					Porcentajetres
				)
			VALUES	(	@rut		,
					@codigo		,
					@porcentaje	,
					@endeudamiento	,
					@garantia	,
					0		,
					@Porcentaje3
				)
		END

	SET NOCOUNT OFF

END
GO
