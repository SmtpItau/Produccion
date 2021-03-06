USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_ENDEUDAMIENTO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_ENDEUDAMIENTO]
	(	@Rut_cliente	NUMERIC(9)	,
		@Codigo_Cliente	NUMERIC(9)	,
		@sistema	CHAR(3)		,
		@FechaOrigen	CHAR(8)		,
		@FechaVcto	CHAR(8)		,
		@Numoper	NUMERIC(10)	,
		@Correla	NUMERIC(10)	,
		@Monto		FLOAT		,
		@tipoper	CHAR(4)		

	)
AS
BEGIN

	SET NOCOUNT ON
		
	DECLARE @retorno 		CHAR(3)		,
		@porcentaje		NUMERIC(08,04)	,
		@porcentajeTres		NUMERIC(08,04)	,
		@monto_max_deuda	FLOAT		,
		@monto_max_deudaTres	FLOAT		,
		@monto_utilizado	FLOAT		,
		@exceso			FLOAT		,
		@mensaje		FLOAT		,
		@monto_actual		FLOAT		,
		@emisor			CHAR(40)	,
		@mensaje2		CHAR(255)	,
		@monto_utilizadoGra	FLOAT		,
		@mensajeTres		FLOAT	,
		@mensaje2res		CHAR(255)


        SET ROWCOUNT 1        
	SELECT  @Codigo_Cliente = clcodigo
	FROM	view_cliente
	WHERE	clrut = @Rut_cliente
        SET ROWCOUNT 0

	SELECT 	@monto_max_deuda = ( capitalyreserva / 100 ) --( capitalbasico / 100 ) VGS
	FROM	control_financiero

	SELECT 	@monto_utilizadoGra	= SUM(Utilizado)
	FROM	cliente_Endeudamiento

	SELECT 	@porcentaje 		= Porcentaje	,
		@porcentajeTres		= Porcentajetres,
		@monto_utilizado	= Utilizado
	FROM	cliente_Endeudamiento
	WHERE	Rut_Cliente 	= @Rut_cliente		AND
		Codigo_Cliente	= @Codigo_Cliente

	SELECT @porcentaje		= ISNULL( @porcentaje 	, 0 )		,
		@monto_max_deuda	= ISNULL( @monto_max_deuda , 0 )	,
		@porcentajeTres		= ISNULL( @porcentajeTres , 0 )	,
		@monto_utilizado	= ISNULL( @monto_utilizado , 0 )

	SELECT  @monto_max_deuda 	= @monto_max_deuda * @porcentaje	,
		@monto_max_deudaTres	= @monto_max_deuda * @porcentajeTres	,
		@monto_actual	 	= @monto_utilizado + @Monto		,
		@monto_utilizadoGra	= @monto_utilizadoGra+@Monto

	IF @tipoper = 'CP'   ---SELECT *  FROM  sp_help VIEW_EMISOR	    	
			
		SELECT @emisor = emnombre  FROM   VIEW_EMISOR WHERE  @Rut_cliente = emrut 
	  	   	  
	ELSE    
		SELECT @emisor = clnombre  FROM   VIEW_CLIENTE WHERE  @Rut_cliente = Clrut AND @Codigo_Cliente =clcodigo	 
	    

	IF @monto_max_deuda >= @monto_utilizadoGra AND @monto_max_deudaTres >= @monto_actual
		BEGIN

			INSERT INTO detalle_Endeudamiento
				(	Rut_Cliente 		,
					Codigo_Cliente		,
					id_sistema		,
					Numero_Operacion	,
					Numero_Documento	,
					Correlativo		,
					Monto_Afecto		,
					Fecha_Origen		,
					Fecha_Vencimiento 
				)
			SELECT	@Rut_cliente	,
				@Codigo_Cliente	,
				@sistema	,
				@Numoper	,
				@Numoper	,
				@Correla	,
				@Monto		,
				@FechaOrigen	,
				@FechaVcto


			UPDATE 	cliente_Endeudamiento
			SET 	Utilizado 	= @monto_actual
			WHERE	Rut_Cliente 	= @Rut_cliente		AND
				Codigo_Cliente	= @Codigo_Cliente

			SELECT @retorno = 'OK'
			SELECT @retorno 
		END
	ELSE
		BEGIN


			IF @monto_max_deuda < @monto_utilizadoGra BEGIN
				SELECT @exceso = ( @monto_utilizadoGra + @Monto ) - @monto_max_deuda

				SELECT @mensaje	=  @exceso 
				SELECT @mensaje2=  'Cliente : ' + ltrim(rtrim(@emisor)) + ' para el Limite Global (' + CONVERT(CHAR(10),@porcentaje)+'%)' 
				SELECT @retorno =  'NO'


			END
			IF @monto_max_deudaTres < @monto_actual BEGIN
				SELECT @exceso = ( @monto_max_deudaTres + @Monto ) - @monto_actual --@monto_max_deuda

				SELECT @mensajeTres	=  @exceso 
				SELECT @mensaje2res	=  'Cliente : ' + ltrim(rtrim(@emisor)) + ' para el Limite Individual (' + CONVERT(CHAR(10),@porcentajeTres)+'%)' 
				SELECT @retorno =  'NO'


			END
			SELECT @retorno , @mensaje, ltrim(rtrim(@mensaje2)), @mensajeTres, ltrim(rtrim(@mensaje2res))
		END

	SET NOCOUNT OFF

END

-- SELECT * FROM VIEW_CONTROL_FINANCIERO
-- select * from cliente_art84
-- select * from DETALLE_art84

-- sp_autoriza_ejecutar 'bacuser'
---sp_control_art84 92580000, 0, 'BTR', '20030311', '20070401', 66017, 1, 34402913, 'CP'







GO
