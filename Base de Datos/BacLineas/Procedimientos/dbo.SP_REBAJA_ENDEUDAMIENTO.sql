USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_REBAJA_ENDEUDAMIENTO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_REBAJA_ENDEUDAMIENTO]
	(	@sistema		CHAR(3)		,
		@numero_operacion	NUMERIC(10)	,
		@Correlativo		NUMERIC(10)
	)
AS
BEGIN
				
	SET NOCOUNT ON
		
	DECLARE @monto_operacion	NUMERIC(19,00)	,
		@monto_utilizado	NUMERIC(19,00)	,
		@rut_cliente		NUMERIC(09,00)	,
		@codigo_cliente		NUMERIC(09,00)	,
		@cantreg 		INTEGER		,
		@contador 		INTEGER
			
	SELECT * INTO #tmp_operaciones
	FROM	detalle_Endeudamiento
	WHERE 	Numero_Operacion = @numero_operacion	AND
		id_sistema 	 = @sistema		AND
		Correlativo	 = @Correlativo
					
	SELECT 	@cantreg = COUNT(*)
	FROM	#tmp_operaciones
							
	SELECT	@contador = 1
	WHILE @contador <= @cantreg
		BEGIN
						
			SET ROWCOUNT @contador
							
			SELECT 	@monto_operacion	= Monto_Afecto		,
				@rut_cliente		= Rut_Cliente		,
				@codigo_cliente		= Codigo_Cliente
			FROM	#tmp_operaciones
							
			SET ROWCOUNT 0
			SELECT @contador = @contador + 1
					
			SELECT @monto_operacion = ISNULL( @monto_operacion ,0)
					
			SELECT 	@monto_utilizado = Utilizado
			FROM 	cliente_Endeudamiento
			WHERE	@rut_cliente		= Rut_Cliente		AND
				@codigo_cliente		= Codigo_Cliente
						
			SELECT 	@monto_utilizado = @monto_utilizado - @monto_operacion
			SELECT 	@monto_utilizado = CASE WHEN @monto_utilizado < 0
							THEN 0
							ELSE @monto_utilizado 
						   END
				
			UPDATE  cliente_Endeudamiento
			SET	Utilizado 	= @monto_utilizado
			WHERE	@rut_cliente	= Rut_Cliente		AND
				@codigo_cliente	= Codigo_Cliente
						
		END
							
	DELETE	detalle_Endeudamiento
	WHERE 	Numero_Operacion = @numero_operacion	AND
		id_sistema 	 = @sistema		AND
		Correlativo	 = @Correlativo
				
	SET NOCOUNT OFF
	
END

/*
BAClineas..sp_rebaja_art84 'BTR', 40836,0

SELECT * FROM DETALLE_ART84
SELECT * FROM CLIENTE_ART84
SP_AUTORIZA_EJECUTAR 'BACUSER'

*/
GO
