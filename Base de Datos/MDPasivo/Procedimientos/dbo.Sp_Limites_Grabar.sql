USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Limites_Grabar]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Limites_Grabar]
				(
				@dFecPro 	DATETIME	,
				@nNumoper	NUMERIC	(10,0)	,
				@cSistema	CHAR	(03)	,
				@cProducto	CHAR	(05)	,
				@nCodGrupo	CHAR	(10)	,
				@nCodInst	NUMERIC	(05,0)	,
				@nMonto		NUMERIC	(19,4)	,
				@nMontoMX1	NUMERIC	(19,4)	,
				@dFecvctop	DATETIME	,
				@cUsuario	CHAR	(15)	,
				@cCheckLimOp	CHAR	(1)	,
				@cCheckLimInst	CHAR	(1)     ,
                                @cTipo_Control  CHAR    (10) = ' ',
				@Moneda1	NUMERIC	(05)	,
				@Moneda2	NUMERIC	(05)	,
				@nMontoMX2	NUMERIC	(19,4)	,
				@cTipoper	CHAR(01)	
			)
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON


	DECLARE	@moneda		NUMERIC(05)
	DECLARE @nMontoFinal	NUMERIC(19,4)
	DECLARE @Tipo_Moneda1	INTEGER
	DECLARE @Tipo_Moneda2	INTEGER

	DECLARE @cTipo_Moneda   	CHAR(1)
        DECLARE @cTipo_Moneda_Pac  	CHAR(1)
        DECLARE @cFuerte        	CHAR(1)
        DECLARE @nParidad       	FLOAT
        DECLARE @cNemo          	CHAR(8)


	SELECT	@Tipo_Moneda1 = mnextranj FROM MONEDA WITH (NOLOCK INDEX=PK_MONEDA) WHERE mncodmon = @Moneda1
	SELECT	@Tipo_Moneda2 = mnextranj FROM MONEDA WITH (NOLOCK INDEX=PK_MONEDA) WHERE mncodmon = @Moneda2


        SET DATEFORMAT dmy
 
        IF EXISTS( 	SELECT 1 FROM LIMITE_TRANSACCION WITH (NOLOCK INDEX=IX_LIMITE_TRANSACCION) 
                	WHERE	NumeroOperacion	= @nNumoper
                    	AND 	id_sistema	= @CSistema
	      		AND 	InCodigo	= @nCodInst
			AND 	Tipo_control	= 'CPREC')
			AND 	@cTipo_Control	= 'CPREC'
	BEGIN
		RETURN
	END


	IF @Moneda1 = @Moneda2
	BEGIN
		SET @Moneda = @Moneda1
	END
	ELSE
		IF @Moneda1 = 13 OR @Moneda2 = 13
		BEGIN
			SET @Moneda = 13
		END
		ELSE
			IF @Tipo_Moneda1 = 0    			--Extranjera --@Moneda1 NOT IN(999,998,997,994,995)
			BEGIN
				SET @Moneda = @Moneda1
			END
			ELSE
				IF @Tipo_Moneda2 = 0    			--Extranjera --@Moneda2 NOT IN(999,998,997,994,995)
				BEGIN
					SET @Moneda = @Moneda2
				END
				ELSE
					SET @Moneda = @Moneda1



	SELECT @cTipo_Moneda= mnextranj, @cFuerte= mnrrda, @cNemo=mnnemo
	FROM MONEDA WITH (NOLOCK INDEX=PK_MONEDA) WHERE mncodmon=@Moneda


	IF @cTipo_Moneda = 1
		SET @nMontoFinal = @nMonto
	ELSE
		IF @Moneda = 13
			SET @nMontoFinal = @nMontoMX1
		ELSE
			SET @nMontoFinal = @nMontoMX2


	IF @cSistema = 'SWP'
	BEGIN

		IF @Moneda1 = 13
			SELECT	@nMontoFinal 	= @nMontoMX1,
				@moneda 	= @Moneda1
		ELSE
			IF @Moneda2 = 13
				SELECT	@nMontoFinal	= @nMontoMX2,
					@moneda 	= @Moneda2
			ELSE
				SELECT	@nMontoFinal	= @nMontoMX1,
					@moneda 	= @Moneda1

	END


	INSERT INTO	LIMITE_TRANSACCION
	VALUES	     (	@dFecPro 	,
		        @nNumoper	,
        		@cSistema	,
	        	@cProducto	,
		        @nCodGrupo	,
        		@nCodInst	,
	        	@nMontoFinal	,
        		@dFecvctop	,
	        	@cUsuario	,
        		@cCheckLimOp	,
	        	@cCheckLimInst	,
                        @cTipo_Control  ,
			@Moneda
			
			/*nuevos*/	
			/*@Moneda1	,
			@Moneda2	,
			@nMontoMX2	,
			@cTipoper	,
			@nMonto		,
			@nMontoMX1	*/
			
		)


END

GO
