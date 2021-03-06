USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROC_ENDEUDAMIENTO_BANCO]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_PROC_ENDEUDAMIENTO_BANCO]
			(
			@ntipo	INTEGER
			)
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	DECLARE @cantidad_clientes 	NUMERIC(10)
	DECLARE @contador	 	INTEGER
	DECLARE @rut_cliente		NUMERIC(10)
	DECLARE @codigo_cliente		NUMERIC(10)
	DECLARE @suma			FLOAT
	DECLARE @suma1			FLOAT
	DECLARE @margen			FLOAT

	SELECT @margen	= ((SELECT segundo_tramo FROM DATOS_GENERALES )* 0.90)

	SELECT 	'Rut_Cliente_D'	=	clrut		,
		'Codigo_Cliente_D'=	clcodigo	,
		'Digito_Cliente'=	cldv		,
		'Nombre_Cliente'=	clnombre	,
		'Monto_Inte1446'=	CONVERT(FLOAT,0),
		'Monto_Derivado'=	CONVERT(FLOAT,0),
		'Monto_DivPend' =	CONVERT(FLOAT,0),
		'Monto_VentaPac'=	CONVERT(FLOAT,0),
		'Monto_Total'	=	CONVERT(FLOAT,0),
		'Monto_Dispo'	=	CONVERT(FLOAT,0)
	INTO	 #Temp_Deuda
	FROM 	CLIENTE
	WHERE	cltipcli = 1

	SELECT @cantidad_clientes = (SELECT COUNT(1) FROM #Temp_Deuda)
	SELECT @contador = 1
 
	WHILE @contador <= @cantidad_clientes BEGIN		

		SET ROWCOUNT @contador

		SELECT	@rut_cliente 	= rut_cliente_d,
			@codigo_cliente = codigo_cliente_d
		FROM	#Temp_Deuda


		SET ROWCOUNT 0

-- SELECT * FROM VIEW_TRANSFERENCIA_PENDIENTE
			UPDATE  #Temp_Deuda 
			SET Monto_DivPend = ISNULL((	SELECT	SUM(d.monto_pesos)
							FROM	VIEW_TRANSFERENCIA_PENDIENTE d,
								DATOS_GENERALES
							WHERE	@rut_cliente = d.rut_cliente
							AND	@codigo_cliente  = d.codigo_cliente
							AND	fecha_vencimiento  > fecha_proceso
							and	tipo_operacion = 'C'
							GROUP BY d.rut_cliente,d.codigo_cliente)
							,0),

			   Monto_VentaPac = ISNULL((	SELECT SUM(vivptirv)
							FROM	VIEW_CARTERA_VENTA_PACTO
							WHERE	@rut_cliente = virutcli
							AND	@codigo_cliente = vicodcli
							GROUP BY virutcli, vicodcli)
							,0),


			   Monto_Inte1446 = ISNULL((	SELECT SUM(valor_final)
							FROM	VIEW_CARTERA_INTERBANCARIA
							WHERE	@rut_cliente = rut_cliente
							AND	@codigo_cliente = codigo_cliente
							AND	LTRIM(RTRIM(serie)) = 'ICAP'
							GROUP BY rut_cliente, codigo_cliente)
							,0)+

					    ISNULL((	SELECT	SUM(caequmon1)
							FROM	VIEW_CARTERA_FORWARD
							WHERE	@rut_cliente = cacodigo
							AND	@codigo_cliente = cacodcli
							AND	cacodpos1 = 5
							AND	catipoper = 'A'
							GROUP BY cacodigo, cacodcli,cacodpos1,catipoper)
							,0),
			   Monto_Derivado = 0
						
			WHERE	@rut_cliente = rut_cliente_d
			AND	@codigo_cliente = codigo_cliente_d



			UPDATE	#Temp_Deuda 
			SET	monto_total = ROUND((Monto_Inte1446 + Monto_Derivado + Monto_DivPend + Monto_VentaPac),0),
				Monto_Dispo = ROUND(@margen - (Monto_Inte1446 + Monto_Derivado + Monto_DivPend + Monto_VentaPac),0)
			WHERE	@rut_cliente = rut_cliente_d
			AND	@codigo_cliente = codigo_cliente_d



			UPDATE  #Temp_Deuda 
			SET	Monto_DivPend	= 0,
			   	Monto_VentaPac	= 0,
			   	Monto_Inte1446	= 0,
			   	Monto_Derivado	= 0,
				monto_total	= 0,
				Monto_Dispo	= @margen
			WHERE	@rut_cliente = rut_cliente_d
			AND	@codigo_cliente = codigo_cliente_d



			SELECT @contador = @contador + 1

	END

	IF @ntipo = 0
		SELECT * FROM 	#Temp_Deuda ORDER BY Nombre_Cliente

	IF @ntipo = 1 BEGIN

		DELETE LINEA_ENDEUDAMIENTO_BANCO

		INSERT LINEA_ENDEUDAMIENTO_BANCO
		(
			rut_cliente		,
			codigo_cliente		,
			digito_cliente		,
			nombre_cliente		,
			monto_inte1446		,
			monto_derivado		,
			monto_divPend		,
			monto_ventaPac		,
			monto_total		,
			margen_indivudual	,
			monto_dispo		,
			monto_captacion		,
			monto_pasivos		,
			bloqueado		
		)
		
		SELECT
			Rut_Cliente_D	,
			Codigo_Cliente_D,
			Digito_Cliente	,
			Nombre_Cliente	,
			Monto_Inte1446	,
			Monto_Derivado	,
			Monto_DivPend 	,
			Monto_VentaPac	,
			ROUND((Monto_Inte1446 + Monto_Derivado + Monto_DivPend + Monto_VentaPac),0),
			ROUND(@margen,0)		,
			ROUND(@margen - (Monto_Inte1446 + Monto_Derivado + Monto_DivPend + Monto_VentaPac),0),
			0		,
			0		,
			' '
		FROM #Temp_Deuda
		

	END 
SET NOCOUNT OFF
END







-- sp_helptext sp_lineas_grboperacion
-- sp_helptext SP_LINEA_GRABAR_ENDEUDAMIENTO_BANCO
-- select * from LINEA_ENDEUDAMIENTO_BANCO
-- select * from LINEA_ENDEUDAMIENTO_BANCO
-- sp_helptext SP_ACT_ENDEUDAMIENTO_BANCO
-- sp_helptext SP_BUSCA_ENDEUDAMIENTO
-- sp_helptext SP_CON_ENDEUDAMIENTO_BANCO
-- sp_helptext SP_ELI_ENDEUDAMIENTO
-- sp_helptext SP_GRABA_ENDEUDAMIENTO_DETALLE
-- sp_helptext SP_LINEA_CHEQUEAR_ENDEUDAMIENTO_BANCO
-- sp_helptext SP_LINEA_GRABAR_ENDEUDAMIENTO_BANCO
-- sp_helptext SP_LINEA_REBAJA_ENDEUDAMIENTO_BANCO
-- sp_helptext SP_PROC_ENDEUDAMIENTO_BANCO

GO
