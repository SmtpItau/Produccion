USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_INFORME_AUDITORIA1_1]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_INFORME_AUDITORIA1_1]
	(
		 @fecha				DATETIME
		,@modulo			CHAR(5)
		,@NumOper			NUMERIC(9,0)
		,@UsuarioModifica	VARCHAR(15)
		,@UsuarioAprueba	VARCHAR(15)
		,@UsuarioReporte	VARCHAR(15)
		,@titulo			VARCHAR(255)
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE  @i INT
			,@nReg INT
			,@var_iFormaPago SMALLINT
			,@var_nomFormaPago CHAR(30)
			,@var_monto_operacion NUMERIC(21,4)
			,@var_iRutBeneficiario NUMERIC(9,0)
			,@var_sDigBeneficiario CHAR(1)
			,@var_sNomBanco VARCHAR(50)
			,@var_sSwift VARCHAR(20)
			,@var_sCtaCte VARCHAR(40)
			,@var_iRutCliente NUMERIC(10,0)
			,@var_iCodigo SMALLINT
			,@key_sistema CHAR(5)
			,@key_numero_operacion NUMERIC(9,0)
			,@var1_iFormaPago SMALLINT
			,@var1_nomFormaPago CHAR(30)
			,@var1_monto_operacion NUMERIC(21,4)
			,@var1_iRutBeneficiario NUMERIC(9,0)
			,@var1_sDigBeneficiario CHAR(1)
			,@var1_sNomBanco VARCHAR(50)
			,@var1_sSwift VARCHAR(20)
			,@var1_sCtaCte VARCHAR(40)
			,@var1_iRutCliente NUMERIC(10,0)
			,@var1_iCodigo SMALLINT
			,@key1_sistema CHAR(5)
			,@key1_numero_operacion NUMERIC(9,0)
			,@linea VARCHAR(2000)
			,@paso SMALLINT

	SELECT	@paso = 0

	CREATE TABLE #tmpDetModif (
		Indice INT
		,detalleModificados VARCHAR(255)
		)

	CREATE TABLE #tmpRevisar (
		Indice INT IDENTITY
		,Id_Detalle_Pago INT
		,fechaProceso DATETIME
		,fecha DATETIME
		,sistema CHAR(5)
		,nomsistema VARCHAR(50)
		,numero_operacion NUMERIC(9,0)
		,estado_envio CHAR(1)
		,cEstado CHAR(3)
		,sUsuario VARCHAR(15)
		,iFormaPago SMALLINT
		,nomFormaPago CHAR(30)
		,tipo_operacion CHAR(6)
		,nomtipo_operacion VARCHAR(50)
		,monto_operacion NUMERIC(21,4)
		,iRutBeneficiario NUMERIC(9,0)
		,sDigBeneficiario CHAR(1)
		,sNomBeneficiario VARCHAR(50)
		,sNomBanco VARCHAR(50)
		,sSwift VARCHAR(20)
		,sCtaCte VARCHAR(40)
		,iRutCliente NUMERIC(10,0)
		,iCodigo SMALLINT
		,usuarioModifica VARCHAR(15)
		,usuarioAprueba VARCHAR(15)
		,usuarioReporte VARCHAR(15)
		,titulo VARCHAR(255)
		,camposModificados VARCHAR(2000)
		)

	CREATE TABLE #MDTMP2 (
			Id_Detalle_Pago INT,
			fecha DATETIME,
			fechaProceso DATETIME,
			sistema CHAR(5),
			nomsistema VARCHAR(50),
			numero_operacion NUMERIC(9,0),
			iFormaPago SMALLINT,
			nomFormaPago CHAR(30),
			tipo_operacion CHAR(6),
			nomtipo_operacion VARCHAR(50),
			monto_operacion NUMERIC(21,4),
			iRutBeneficiario NUMERIC(9,0),
			sDigBeneficiario CHAR(1),
			sNomBeneficiario VARCHAR(50),
			sNomBanco VARCHAR(50),
			sSwift VARCHAR(20),
			sCtaCte VARCHAR(40),
			iRutCliente NUMERIC(10,0),
			iCodigo SMALLINT,
			estado_envio CHAR(1),
			cEstado CHAR(3),
			sDescripcion VARCHAR(50),
			sUsuario VARCHAR(15),
			usuarioModifica VARCHAR(15),
			usuarioAprueba VARCHAR(15),
			cObservaciones VARCHAR(255),
			sFirma1 VARCHAR(15),
			sFirma2 VARCHAR(15) )


	INSERT INTO #MDTMP2

	SELECT	dp.Id_Detalle_Pago
			,md.fecha
			,getdate()
			,md.sistema
			,''
			,md.numero_operacion
			,dp.iFormaPago
			,fp.glosa
			,md.tipo_operacion
			,md.tipo_operacion
			,md.monto_operacion
			,dp.iRutBeneficiario
			,dp.sDigBeneficiario
			,dp.sNomBeneficiario
			,dp.sNomBanco
			,dp.sSwift
			,dp.sCtaCte
			,dp.iRutCliente
			,dp.iCodigo
			,md.estado_envio
			,dp.cEstado
			,ee.sDescripcion
			,dp.sUsuario
			,''			--- Usuario modifica en blanco por ahora
			,CASE		--- Usuario Autoriza o aprueba
					WHEN (dp.sFirma1 <> '') AND (dp.cEstado ='PF2') THEN dp.sFirma1
					WHEN (dp.sFirma2 <> '') AND (dp.cEstado = 'P') THEN dp.sFirma2
					ELSE ''
			 END
			,dp.cObservaciones
			,dp.sFirma1
			,dp.sFirma2

	FROM	MDLBTR md
	INNER JOIN SADP_DETALLE_PAGOS dp
		ON dp.cModulo = md.sistema
		AND dp.nContrato = md.numero_operacion
	INNER JOIN SADP_ESTADOSENVIO ee
		ON md.estado_envio = ee.sCodigo
	INNER JOIN FORMA_DE_PAGO fp
		ON dp.iFormaPago = fp.codigo
	WHERE	md.fecha = @fecha
		AND (md.sistema = @modulo OR @modulo = 'TODOS')
		AND (md.numero_operacion = @NumOper OR @NumOper = 0)
	ORDER BY md.sistema, md.numero_operacion

	UPDATE #MDTMP2
	SET fechaProceso = dFechaProceso
	FROM SADP_CONTROL

	UPDATE #MDTMP2
	SET nomsistema = sis.nombre_sistema
	FROM BacParamsuda..SISTEMA_CNT sis
	WHERE sis.id_sistema = sistema

	UPDATE #MDTMP2
	SET nomsistema = me.Descripcion
	FROM BacParamsuda..SADP_MODULOS_EXTERNOS me
	WHERE me.Nemo = sistema
	AND nomsistema = ''

	UPDATE #MDTMP2
	SET nomtipo_operacion = Producto
	FROM BacParamsuda..SADP_PRODUCTO_MODULOEXTERNO me
	WHERE me.Modulo = sistema
	AND me.CodInterno = tipo_operacion

	/* Buscar al usuario que modificÃ³ */
	--- Seleccionar primero los registros con estado 'APM'
	SELECT DISTINCT 
		Id_Detalle_Pago
		,nContrato
		,cModulo
		,iFormaPago
		,nMonto
		,iRutBeneficiario
		,sDigBeneficiario
		,sNomBeneficiario
		,sNomBanco
		,sSwift
		,sCtaCte
		,iRutCliente
		,iCodigo
	INTO #ListaTmp				
	FROM SADP_DETALLE_PAGOS
	WHERE cEstado = 'APM'

	UPDATE #MDTMP2
	SET usuarioModifica = sUsuario
	FROM #ListaTmp lt
	WHERE #MDTMP2.cEstado = 'PF1'
	AND sistema = lt.cModulo
	AND numero_operacion = lt.nContrato

	DROP TABLE #ListaTmp

	IF @UsuarioAprueba <> ''
	--- Filtrar por Usuario AprobÃ³:
	BEGIN
		SELECT @paso = 1
		SELECT DISTINCT 
		numero_operacion,
		sistema
		INTO #MDTMP3
		FROM #MDTMP2
		WHERE usuarioAprueba = @UsuarioAprueba

		INSERT INTO #tmpRevisar

		SELECT 
		t2.Id_Detalle_Pago,
		t2.fechaProceso,
		t2.fecha,
		t2.sistema,
		t2.nomsistema,
		t2.numero_operacion,
		t2.estado_envio,
		t2.cEstado,
		CASE WHEN t2.usuarioModifica <> '' THEN t2.usuarioModifica
			 WHEN t2.usuarioAprueba <> '' THEN t2.usuarioAprueba
			 ELSE ''
		END AS 'sUsuario',
		t2.iFormaPago,
		t2.nomFormaPago,
		t2.tipo_operacion,
		t2.nomtipo_operacion,
		t2.monto_operacion,
		t2.iRutBeneficiario,
		t2.sDigBeneficiario,
		t2.sNomBeneficiario,
		t2.sNomBanco,
		t2.sSwift,
		t2.sCtaCte,
		t2.iRutCliente,
		t2.iCodigo,
		t2.usuarioModifica,
		t2.usuarioAprueba,
		@UsuarioReporte,
		@titulo,
		''

		FROM #MDTMP2 t2
		INNER JOIN #MDTMP3 t3
			ON t2.numero_operacion = t3.numero_operacion
			AND t2.sistema = t3.sistema
		ORDER BY t2.sistema, t2.numero_operacion, t2.Id_Detalle_Pago
		DROP TABLE #MDTMP3
	END

	IF @UsuarioModifica <> ''
	--- Filtrar por Usuario que ModificÃ³
	BEGIN
		SELECT @paso = 2
		SELECT DISTINCT 
		numero_operacion,
		sistema
		INTO #MDTMP4
		FROM #MDTMP2
		WHERE usuarioModifica = @UsuarioModifica

		INSERT INTO #tmpRevisar

		SELECT
		t2.Id_Detalle_Pago,
		t2.fechaProceso,
		t2.fecha,
		t2.sistema,
		t2.nomsistema,
		t2.numero_operacion,
		t2.estado_envio,
		t2.cEstado,
		CASE WHEN t2.usuarioModifica <> '' THEN t2.usuarioModifica
			 WHEN t2.usuarioAprueba <> '' THEN t2.usuarioAprueba
			 ELSE ''
		END AS 'sUsuario',
		t2.iFormaPago,
		t2.nomFormaPago,
		t2.tipo_operacion,
		t2.nomtipo_operacion,
		t2.monto_operacion,
		t2.iRutBeneficiario,
		t2.sDigBeneficiario,
		t2.sNomBeneficiario,
		t2.sNomBanco,
		t2.sSwift,
		t2.sCtaCte,
		t2.iRutCliente,
		t2.iCodigo,
		t2.usuarioModifica,
		t2.usuarioAprueba,
		@UsuarioReporte,
		@titulo,
		''

		FROM #MDTMP2 t2
		INNER JOIN #MDTMP4 t4
			ON t2.numero_operacion = t4.numero_operacion
			AND t2.sistema = t4.sistema
		ORDER BY t2.sistema, t2.numero_operacion, t2.Id_Detalle_Pago
		DROP TABLE #MDTMP4
	END

	IF @paso = 0 
	BEGIN

		INSERT INTO #tmpRevisar

		SELECT 
		Id_Detalle_Pago,
		fechaProceso,
		fecha,
		sistema,
		nomsistema,
		numero_operacion,
		estado_envio,
		cEstado,
		sUsuario,
		iFormaPago,
		nomFormaPago,
		tipo_operacion,
		nomtipo_operacion,
		monto_operacion,
		iRutBeneficiario,
		sDigBeneficiario,
		sNomBeneficiario,
		sNomBanco,
		sSwift,
		sCtaCte,
		iRutCliente,
		iCodigo,
		usuarioModifica,
		usuarioAprueba,
		@UsuarioReporte,
		@titulo,
		''
		FROM #MDTMP2
		ORDER BY sistema, numero_operacion, Id_Detalle_Pago
	END

	---------------------------------------------------------------------------------------
	--- Revisar ahora si se modificaron campos y dejar en camposModificados el resultado
	---------------------------------------------------------------------------------------
	SELECT	@nReg = COUNT(*) FROM #tmpRevisar
	SELECT	@i = 1

	SELECT	 @var_iFormaPago		= iFormaPago
			,@var_nomFormaPago		= nomFormaPago
			,@var_monto_operacion	= monto_operacion
			,@var_iRutBeneficiario	= iRutBeneficiario
			,@var_sDigBeneficiario	= sDigBeneficiario
			,@var_sNomBanco			= sNomBanco
			,@var_sSwift			= sSwift
			,@var_sCtaCte			= sCtaCte
			,@var_iRutCliente		= iRutCliente
			,@var_iCodigo			= iCodigo
			,@key_sistema			= sistema
			,@key_numero_operacion	= numero_operacion
	FROM #tmpRevisar
	WHERE Indice = @i
	SELECT @i = @i + 1

	SELECT @linea = ''

	WHILE @i <= @nReg
	BEGIN
			SELECT	 @var1_iFormaPago		= iFormaPago
					,@var1_nomFormaPago		= nomFormaPago
					,@var1_monto_operacion	= monto_operacion
					,@var1_iRutBeneficiario	= iRutBeneficiario
					,@var1_sDigBeneficiario	= sDigBeneficiario
					,@var1_sNomBanco		= sNomBanco
					,@var1_sSwift			= sSwift
					,@var1_sCtaCte			= sCtaCte
					,@var1_iRutCliente		= iRutCliente
					,@var1_iCodigo			= iCodigo
					,@key1_sistema			= sistema
					,@key1_numero_operacion	= numero_operacion
			FROM #tmpRevisar
			WHERE Indice = @i
		
		IF @key_sistema = @key1_sistema AND @key1_numero_operacion = @key_numero_operacion
		--- Estamos en el mismo nÃºmero de operaciÃ³n
		BEGIN
			---- Compara cada uno de los campos modificables
			IF @var1_iFormaPago <> @var_iFormaPago
			BEGIN
				SELECT @linea = @linea + '<*Forma de Pago de '+CONVERT(VARCHAR(10),@var_iFormaPago) + ' '+ RTRIM(@var_nomFormaPago) + ' a ' +  CONVERT(VARCHAR(10),@var1_iFormaPago) + ' '+ RTRIM(@var1_nomFormaPago) + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Forma de Pago de '+CONVERT(VARCHAR(10),@var_iFormaPago) + ' '+ RTRIM(@var_nomFormaPago) + ' a ' +  CONVERT(VARCHAR(10),@var1_iFormaPago) + ' '+ RTRIM(@var1_nomFormaPago)
			END		

			IF @var1_monto_operacion <> @var_monto_operacion
			BEGIN
				SELECT @linea = @linea + '<*Monto de ' + CONVERT(VARCHAR(30),@var_monto_operacion) + ' a ' + CONVERT(VARCHAR(30),@var1_monto_operacion) + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Monto de ' + CONVERT(VARCHAR(30),@var_monto_operacion) + ' a ' + CONVERT(VARCHAR(30),@var1_monto_operacion)
			END	
				
			IF @var1_iRutBeneficiario <> @var_iRutBeneficiario
			BEGIN
				SELECT @linea = @linea + '<*Rut Beneficiario de ' + CONVERT(VARCHAR(10), @var_iRutBeneficiario) + ' a ' + CONVERT(VARCHAR(10), @var1_iRutBeneficiario) + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Rut Beneficiario de ' + CONVERT(VARCHAR(10), @var_iRutBeneficiario) + ' a ' + CONVERT(VARCHAR(10), @var1_iRutBeneficiario)
			END
			
			IF @var1_sDigBeneficiario <> @var_sDigBeneficiario
			BEGIN
				SELECT @linea = @linea + '<*Digito Beneficiario de ' + @var_sDigBeneficiario + ' a ' + @var1_sDigBeneficiario + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Digito Beneficiario de ' + @var_sDigBeneficiario + ' a ' + @var1_sDigBeneficiario
			END
				
			IF @var1_sNomBanco <> @var_sNomBanco
			BEGIN
				SELECT @linea = @linea + '<*Nombre del Banco de ' + RTRIM(@var_sNomBanco) + ' a ' + RTRIM(@var1_sNomBanco) + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Nombre del Banco de ' + RTRIM(@var_sNomBanco) + ' a ' + RTRIM(@var1_sNomBanco)
			END
			
			IF @var1_sSwift <> @var_sSwift
			BEGIN
				SELECT @linea = @linea + '<*Swift de ' + RTRIM(@var_sSwift) + ' a ' + RTRIM(@var1_sSwift) + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Swift de ' + RTRIM(@var_sSwift) + ' a ' + RTRIM(@var1_sSwift)
			END	
				
			IF @var1_sCtaCte <> @var_sCtaCte
			BEGIN
				SELECT @linea = @linea + '<*Cta. Cte. de ' + RTRIM(@var_sCtaCte) + ' a ' + RTRIM(@var1_sCtaCte) + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Cta. Cte. de ' + RTRIM(@var_sCtaCte) + ' a ' + RTRIM(@var1_sCtaCte)
			END	
				
				
			IF @var1_iRutCliente <> @var_iRutCliente
			BEGIN
				SELECT @linea = @linea + '<*Rut Cliente de ' + CONVERT(VARCHAR(10),@var_iRutCliente) + ' a ' + CONVERT(VARCHAR(10),@var1_iRutCliente) + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Rut Cliente de ' + CONVERT(VARCHAR(10),@var_iRutCliente) + ' a ' + CONVERT(VARCHAR(10),@var1_iRutCliente)
			END	
				
			IF @var1_iCodigo <> @var_iCodigo
			BEGIN
				SELECT @linea = @linea + '<*Codigo Cliente de ' + CONVERT(VARCHAR(10), @var_iCodigo) + ' a ' + CONVERT(VARCHAR(10), @var1_iCodigo) + '*>'
				INSERT INTO #tmpDetModif
				SELECT @i,
				'Codigo Cliente de ' + CONVERT(VARCHAR(10), @var_iCodigo) + ' a ' + CONVERT(VARCHAR(10), @var1_iCodigo)
			END	
				
			/*	
			UPDATE #tmpRevisar
			SET camposModificados = @linea
			WHERE Indice = @i
			*/
			
			
			SELECT @linea = ''
		END
		ELSE
			SELECT	 @var_iFormaPago		= iFormaPago
					,@var_nomFormaPago		= nomFormaPago
					,@var_monto_operacion	= monto_operacion
					,@var_iRutBeneficiario	= iRutBeneficiario
					,@var_sDigBeneficiario	= sDigBeneficiario
					,@var_sNomBanco			= sNomBanco
					,@var_sSwift			= sSwift
					,@var_sCtaCte			= sCtaCte
					,@var_iRutCliente		= iRutCliente
					,@var_iCodigo			= iCodigo
					,@key_sistema			= sistema
					,@key_numero_operacion	= numero_operacion
					FROM #tmpRevisar
					WHERE Indice = @i

		SELECT	@i = @i + 1,
				@linea = ''
		
			
	END


	SELECT * FROM #tmpRevisar
	SELECT * FROM #tmpDetModif

	DROP TABLE #MDTMP2
	DROP TABLE #tmpRevisar
	DROP TABLE #tmpDetModif
END
GO
