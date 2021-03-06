USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_SERIE_FONDOS_MUTUOS]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_SERIE_FONDOS_MUTUOS]
			       (	
				@Serie			CHAR		(12)	,
				@RutCliente		NUMERIC		(09,0)	,
				@CodCliente		NUMERIC		(05,0)	,
				@CodMoneda		NUMERIC		(05,0) ,
				@Descripcion		VARCHAR		(70)	)
AS
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy
	

DECLARE @CUENTA INTEGER

	IF EXISTS(SELECT Serie FROM FMUTUO_SERIE WHERE SERIE    = @Serie )
--		AND 	Rut_Cliente	= @RutCliente
--		AND	Codigo_Cliente	= @CodCliente) 
		BEGIN	

		UPDATE	FMUTUO_SERIE
		SET		
			Serie		= @Serie		,
			Rut_Cliente	= @RutCliente		,
			Codigo_Cliente	= @CodCliente		,
			Codigo_Moneda	= @CodMoneda		,
			Descripcion	= @Descripcion		

		WHERE	 SERIE    = @Serie
		SELECT 'OK'	

	END ELSE BEGIN

		SELECT @CUENTA=count(*)  
		FROM FMUTUO_SERIE
		WHERE   Rut_Cliente	= @RutCliente
		AND	Codigo_Cliente	= @CodCliente
	
		IF @CUENTA = 0
			BEGIN
			INSERT FMUTUO_SERIE
					(Serie  	,
					Rut_Cliente	,
					Codigo_Cliente	,
					Codigo_Moneda	,
					Descripcion	,
					Codigo_familia
					)                   	

			VALUES		(
					@Serie 		,
					@RutCliente	,
					@CodCliente	,
					@CodMoneda	,
					@Descripcion	,
					98

	   					)

			SELECT "OK"
				
		END ELSE BEGIN
			SELECT "NOK"
		END

	END	
   SET NOCOUNT OFF

END


--SP_ACT_SERIE_FONDOS_MUTUOS 'fmcorp1',96513630,32,999,'FONDO MUTUO CORP'








GO
