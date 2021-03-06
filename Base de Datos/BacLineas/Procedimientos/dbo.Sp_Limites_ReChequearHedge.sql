USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Limites_ReChequearHedge]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Limites_ReChequearHedge](
						@sistema		CHAR(3)		,
						@usuario_operacion	CHAR(15)	,
						@usuario_autoriza	CHAR(15)	
					    )
AS 
BEGIN

	DECLARE @HedgeTotal		NUMERIC(21,04)	,
		@over_min		NUMERIC(21,04)	,
		@over_max		NUMERIC(21,04)	,
		@num_error		INTEGER		,
		@monto_controlar	NUMERIC(21,04)	,
		@supervisor		CHAR(1)		,
		@tipo_operacion		CHAR(1)


	SET NOCOUNT ON

	SELECT  @num_error = 0

	IF NOT EXISTS( 	SELECT 	*
			FROM	aprobacion_hedge
			WHERE	@sistema = sistema		AND
			@usuario_operacion = Usuario		
		     )
		SELECT  @num_error = 4

	SELECT  @monto_controlar = Monto_Operacion * ( CASE WHEN LEFT(Tipo_Operacion,1)='C' THEN 1 ELSE -1 END )	,
		@tipo_operacion  = LEFT(Tipo_Operacion,1)
	FROM	aprobacion_hedge
	WHERE	@sistema = sistema		AND
		@usuario_operacion = Usuario		

        SELECT 	@HedgeTotal = ROUND(achedgeactualfuturo+achedgeactualspot,4) 
        FROM  	view_meac

	SELECT 	@supervisor 	= Supervisor	 	,
		@over_min	= intraday_Minimo	,
		@over_max	= intraday_maximo
	FROM 	view_parametros_operadores_spt
	WHERE   Usuario = @usuario_autoriza

	IF @supervisor = 'S'
		BEGIN

			IF @tipo_operacion = 'C'
				BEGIN
					IF ( @HedgeTotal + @monto_controlar ) > @over_max 
						SELECT @num_error = 1

				END
			ELSE
				BEGIN
					IF ( @HedgeTotal + @monto_controlar ) < @over_min 
						SELECT @num_error = 2

				END

		END
	ELSE
		BEGIN
			SELECT @num_error = 3

		END


	IF @num_error <> 3
		BEGIN
			UPDATE	aprobacion_hedge 
			SET 	Aprobado	= 1			,
				Autoriza	= @usuario_autoriza
			WHERE	@sistema = sistema		AND
				@usuario_operacion = Usuario		
		END

	SELECT @num_error
		
	SET NOCOUNT OFF

END


-- select * from aprobacion_hedge
-- select * from view_parametros_operadores_spt








GO
