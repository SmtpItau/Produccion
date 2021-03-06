USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_GRABAR_ENDEUDAMIENTO_BANCO]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEA_GRABAR_ENDEUDAMIENTO_BANCO]
            (   
	    	@Id_Sistema	CHAR   	(10)	,
            	@nNumoper	NUMERIC	(10)	,
		@cTipoper	CHAR	(01)
            )
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @Contador             INTEGER
	,	@Total_Registros      INTEGER
	,	@Total_Disponible     FLOAT
	,	@Total_Disponible_b   FLOAT
	,	@Mto_Operacion        FLOAT
	,	@Rut_Cliente          NUMERIC(09)
	,	@Codigo_Cliente       NUMERIC(09)
	,	@codigo_producto      CHAR(10)
	,	@BANCO                CHAR(100)
	,	@tipcli		      CHAR(1)
	,	@InCodigo             NUMERIC(05)


	SELECT	Rut_Cliente					,
		Codigo_Cliente					,
		NumeroOperacion					,
		codigo_producto					,
		InCodigo					,
		'MontoOperacion'=SUM(MontoTransaccion)
	INTO	#TMP_ENDEUDAMIENTO
	FROM	LINEA_CHEQUEAR  WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
	WHERE	Id_Sistema	= @Id_Sistema
	AND	NumeroOperacion = @nNumoper
	AND (	( id_sistema = 'BCC' AND @cTipoper ='C' ) OR
		( id_sistema = 'BTR' AND  codigo_producto = 'ICAP' ) OR
		( id_sistema = 'BTR' AND  codigo_producto = 'VI' ) OR
		( id_sistema = 'BFW' AND  codigo_producto = '5' AND @cTipoper ='A' )	)
	GROUP
	BY	Rut_Cliente					,
		Codigo_Cliente					,
		NumeroOperacion					,
		codigo_producto					,
		InCodigo

	
	SET @Total_Registros = @@ROWCOUNT
	SET @Contador = 1


	WHILE @Contador <= @Total_Registros
	BEGIN


		SET ROWCOUNT @Contador

		SELECT	@Rut_Cliente	= Rut_Cliente
		,	@Codigo_cliente = Codigo_cliente
		,	@Mto_Operacion  = MontoOperacion
		,	@codigo_producto= codigo_producto
		,	@InCodigo	= InCodigo
		FROM	#TMP_ENDEUDAMIENTO

		SET	ROWCOUNT 0


		SET	@Contador = @Contador + 1


		SELECT	@tipcli= cltipcli
		FROM	CLIENTE WITH(NOLOCK)
		WHERE	clrut = @Rut_Cliente
		AND	clcodigo = @Codigo_Cliente


		IF @tipcli='1'
		BEGIN

	
			IF @id_sistema = 'BCC' AND @cTipoper ='C'
				UPDATE	LINEA_ENDEUDAMIENTO_BANCO
				SET	monto_divPend	= monto_divPend		+ @Mto_Operacion,
					monto_total	= monto_total 		+ @Mto_Operacion,
					monto_dispo	= monto_dispo		- @Mto_Operacion
				WHERE	rut_cliente	= @Rut_Cliente
				AND	codigo_cliente	= @Codigo_Cliente
	
	
			IF @id_sistema = 'BTR' AND  @codigo_producto = 'ICAP'
				UPDATE	LINEA_ENDEUDAMIENTO_BANCO
				SET	monto_inte1446	= monto_inte1446	+ @Mto_Operacion,
					monto_total	= monto_total 		+ @Mto_Operacion,
					monto_dispo	= monto_dispo		- @Mto_Operacion
				WHERE	rut_cliente	= @Rut_Cliente
				AND	codigo_cliente	= @Codigo_Cliente


			IF ( @id_sistema = 'BTR' AND  @codigo_producto = 'VI' ) OR ( @id_sistema = 'BFW' AND  @codigo_producto = '5' AND @cTipoper ='A' )
				UPDATE	LINEA_ENDEUDAMIENTO_BANCO
				SET	monto_ventaPac	= monto_ventaPac	+ @Mto_Operacion,
					monto_total	= monto_total 		+ @Mto_Operacion,
					monto_dispo	= monto_dispo		- @Mto_Operacion
				WHERE	rut_cliente	= @Rut_Cliente
				AND	codigo_cliente	= @Codigo_Cliente
	


		END

	END 

END

GO
