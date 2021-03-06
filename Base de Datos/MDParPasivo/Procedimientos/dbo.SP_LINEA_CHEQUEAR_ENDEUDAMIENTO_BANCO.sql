USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_CHEQUEAR_ENDEUDAMIENTO_BANCO]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEA_CHEQUEAR_ENDEUDAMIENTO_BANCO]
            (   
	    	@Id_Sistema	CHAR   	(10)	,
            	@nNumoper	NUMERIC	(10)	,
		@cTipoper	CHAR	(01)
            )
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT DMY


	DECLARE @Contador             INTEGER
	,	@Total_Registros      INTEGER
	,	@Total_Disponible     FLOAT
	,	@Total_Disponible_b   FLOAT
	,	@Mto_Operacion        FLOAT
	,	@Rut_Cliente          NUMERIC(09)
	,	@Codigo_Cliente       NUMERIC(09)
	,	@BANCO                CHAR(100)
	,	@tipcli		      CHAR(1)
	,	@iFound		      Integer


         SELECT Rut_Cliente
	,	Codigo_Cliente
	,	NumeroOperacion
	,	'MontoOperacion'=SUM(MontoTransaccion)
	,	contador	= identity(int)
	INTO	#TMP_ENDEUDAMIENTO
	FROM	LINEA_CHEQUEAR WITH (NOLOCK)
	WHERE	NumeroOperacion = @nNumoper
	AND	Id_Sistema	= @Id_Sistema
	AND (	( id_sistema = 'BCC' AND @cTipoper ='C' ) OR
		( id_sistema = 'BTR' AND codigo_producto = 'ICAP' ) OR
		( id_sistema = 'BTR' AND codigo_producto = 'VI' ) OR
		( id_sistema = 'BFW' AND codigo_producto = '5' AND @cTipoper ='A' )	)
	GROUP
	BY	Rut_Cliente
	,	Codigo_Cliente
	,	NumeroOperacion


	
	SET @Total_Registros = @@ROWCOUNT
	SET @Contador = 1

         
	WHILE @Contador <= @Total_Registros
	BEGIN

		SELECT	@Rut_Cliente = Rut_Cliente
		,	@Codigo_cliente = Codigo_cliente
		,	@Mto_Operacion  = MontoOperacion
		FROM	#TMP_ENDEUDAMIENTO
		WHERE 	contador = @Contador

		SET	@Contador = @Contador + 1

		SET	@BANCO = ''

		SELECT	@BANCO = ISNULL(clnombre,''),
			@tipcli= cltipcli
		FROM	CLIENTE WITH (NOLOCK)
		WHERE	clrut = @Rut_Cliente
		AND	clcodigo = @Codigo_Cliente


		IF @tipcli<>1
		BEGIN
			RETURN
		END


		SET	@Total_Disponible = 0.0
		SET	@iFound=0

		SELECT	@iFound=1,
			@Total_Disponible = ((margen_indivudual*0.03) - ISNULL(monto_total,0) )
		FROM	LINEA_ENDEUDAMIENTO_BANCO WITH (NOLOCK)
		WHERE	Rut_Cliente = @Rut_Cliente
		AND	Codigo_Cliente = @Codigo_Cliente



		IF @iFound=0
		BEGIN
			INSERT #TEMP1 VALUES ( LTRIM(LTRIM(@BANCO)) + '  No Existe en Tabla de Endeudamiento Interbancario' )
			RETURN
		END


		IF @Mto_Operacion > @Total_Disponible
			INSERT #TEMP1 VALUES ('Operacion sobrepasa limite individual de Endeudamiento Para ' + @BANCO)


		SET	@Total_Disponible_b = 0.0

		SELECT	@Total_Disponible_b = ISNULL(SUM(monto_total),0)
               	FROM	LINEA_ENDEUDAMIENTO_BANCO WITH (NOLOCK)
		
		SET	@Total_Disponible_b = @Total_Disponible_b + @Mto_Operacion
               	
		IF @Total_Disponible_b > ((SELECT MAX(margen_indivudual) FROM LINEA_ENDEUDAMIENTO_BANCO WITH (NOLOCK))*0.10)
			INSERT #TEMP1 VALUES ('Operacion sobrepasa limite global de endeudamiento con Bancos' )

         END

END


GO
