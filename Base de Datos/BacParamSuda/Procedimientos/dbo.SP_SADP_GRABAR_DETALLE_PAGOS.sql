USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABAR_DETALLE_PAGOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SADP_GRABAR_DETALLE_PAGOS]
 ( @iCorrela   			SMALLINT    
 , @nContrato   		NUMERIC(9)    
 , @cModulo   			CHAR(5)    
 , @cMoneda   			VARCHAR(5)    
 , @iFormaPago  		SMALLINT    
 , @nMonto    			NUMERIC(21,4)    
 , @iRutBeneficiario	NUMERIC(9)    
 , @sDigBeneficiario 	CHAR(1)    
 , @sNomBeneficiario 	VARCHAR(50)    
 , @sNomBanco   		VARCHAR(50)    
 , @sSwift    			VARCHAR(20)    
 , @sCtaCte   			VARCHAR(20)    
 , @sUsuario   			VARCHAR(15)    
 , @cObservaciones  	VARCHAR(255)    
 , @iRutCliente  		NUMERIC(10)  
 , @iCodigo   			SMALLINT  
 , @iIdPago   			NUMERIC(9)    
 , @iSecuencia   		INT    
 )    
AS    
BEGIN    
     
	SET NOCOUNT ON    

	DECLARE @iMoneda 		SMALLINT,
			@newSecuencia 	INT
	SET @iMoneda = (SELECT TOP 1 mncodmon FROM BacParamSuda.dbo.MONEDA WHERE mnnemo = @cMoneda)    
	

	DECLARE @iRutclie NUMERIC(10)    
	DECLARE @sDV  VARCHAR(01)      

	SET @sDV  =(SELECT vsb.Cldv    
	FROM view_sadp_bancos vsb WHERE vsb.Clrut=@iRutCliente);  

	SELECT @newSecuencia = (SELECT MAX(iSecuencia) FROM dbo.SADP_DETALLE_PAGOS WHERE nContrato = @nContrato AND cModulo = @cModulo AND iMoneda = @iMoneda)

	SET @iRutclie = (SELECT rut_cliente    
	FROM mdlbtr, dbo.sadp_control  c WHERE numero_operacion = @nContrato  
	AND sistema    = @cModulo  
	AND moneda    = @iMoneda    
	AND  Secuencia  = @iSecuencia AND c.dFechaProceso = mdlbtr.fecha);  

	---> Si el beneficiario es nuevo, agregarlo a la tabla
	IF NOT EXISTS( SELECT 1 FROM dbo.SADP_BENEFICIARIOS WHERE nRutBeneficiario = @iRutBeneficiario AND nRutBanco = @iRutCliente AND cCtaCte = @sCtaCte )    
	BEGIN    
		INSERT INTO dbo.SADP_BENEFICIARIOS    
		SELECT nRutBeneficiario = @iRutBeneficiario    
		, cDvBeneficiario  = @sDigBeneficiario    
		, cNomBeneficiario = @sNomBeneficiario    
		, nRutBanco   = @iRutCliente    
		, nCodBanco   = @iCodigo    
		, cCtaCte    = @sCtaCte    
	END    

	IF @iCorrela = 1    
	BEGIN    
		---> Primero, cambiar el estado a 'APM'
		UPDATE dbo.SADP_DETALLE_PAGOS    
		SET  cEstado   = 'APM'    
		WHERE nContrato  = @nContrato    
		AND  iSecuencia  = @iSecuencia     
		AND  cModulo   = @cModulo    
		AND  iMoneda   = @iMoneda    

		---> y a 'PF1'
		UPDATE dbo.MDLBTR  
		SET  estado_envio   = 'PF1'  
		,  forma_pago   	= @iFormaPago --> Se agrega forma de pago     
		,  RecCtaCte   		= @sCtaCte 
		,  monto_operacion 	= @nMonto		--> se debe actualizar el monto porque ahora hay una operacion por cada registro de pago (JBH)
		WHERE numero_operacion = @nContrato  
		AND  sistema    = @cModulo  
		AND  moneda    = @iMoneda    
		AND  Secuencia  = @iSecuencia    

		---> Luego, agregar la operación en el detalle
		INSERT INTO dbo.SADP_DETALLE_PAGOS    
		SELECT nContrato   = @nContrato    
		,  cModulo    = @cModulo    
		,  iMoneda    = @iMoneda    
		,  iFormaPago   = @iFormaPago    
		,  nMonto    = @nMonto    
		,  iRutBeneficiario = @iRutBeneficiario    
		,  sDigBeneficiario = @sDigBeneficiario    
		,  sNomBeneficiario = @sNomBeneficiario    
		,  sNomBanco   = @sNomBanco    
		,  sSwift    = @sSwift    
		,  sCtaCte    = @sCtaCte    
		,  sUsuario   = @sUsuario    
		,  sFirma1    = ''    
		,  sFirma2    = ''    
		,  cEstado    = 'PF1'    
		,  cObservaciones  = @cObservaciones     
		,  iRutCliente   = @iRutclie    
		,  iCodigo    = @iCodigo    
		,  iRutBanco           = @iRutCliente    
		,  sDvBanco   = ISNULL(@sDV,'') --> Control para ingreso de operaciones de Vale Vistas
		,  vNumTransferencia = 0    
		,  sEnviadoPor   = ''    
		,  @iSecuencia  
		RETURN
	END  
	---> Solo para los registros siguientes
	SELECT @newSecuencia = @newSecuencia + 1

	INSERT INTO dbo.SADP_DETALLE_PAGOS    
	SELECT nContrato   = @nContrato    
	,  cModulo    = @cModulo    
	,  iMoneda    = @iMoneda    
	,  iFormaPago   = @iFormaPago    
	,  nMonto    = @nMonto    
	,  iRutBeneficiario = @iRutBeneficiario    
	,  sDigBeneficiario = @sDigBeneficiario    
	,  sNomBeneficiario = @sNomBeneficiario    
	,  sNomBanco   = @sNomBanco    
	,  sSwift    = @sSwift    
	,  sCtaCte    = @sCtaCte    
	,  sUsuario   = @sUsuario    
	,  sFirma1    = ''    
	,  sFirma2    = ''    
	,  cEstado    = 'PF1'    
	,  cObservaciones  = @cObservaciones     
	,  iRutCliente   = @iRutclie    
	,  iCodigo    = @iCodigo    
	,  iRutBanco           = @iRutCliente    
	,  sDvBanco   = ISNULL(@sDV,'') --> Control para ingreso de operaciones de Vale Vistas
	,  vNumTransferencia = 0    
	,  sEnviadoPor   = ''    
	---,  @iSecuencia  
	,  @newSecuencia	---> Uso la nueva secuencia que se va incrementando por cada nuevo registro

	---> ahora agrego una nueva operación en MDLBTR con la misma secuencia de SADP_DETALLE_PAGOS
---> Traer los campos faltantes de la misma tabla
	DECLARE @Mfecha 			DATETIME,
			@Mtipo_mercado 		CHAR(12),
			@Mtipo_operacion	CHAR(6),
			@Mfecha_operacion	DATETIME,
			@Mfecha_vencimiento	DATETIME,
			@Mliquidada			CHAR(1),
			@MRecDireccion		VARCHAR(70),
			@MRecCodBanco		NUMERIC(10,0),
			@MTipo_Movimiento	CHAR(1),
			@MGlosaAnticipo		VARCHAR(150),
			@MId_Paquete		NUMERIC(10,0),
			@MEstado_Paquete	CHAR(1),
			@MReservado			CHAR(50)
			

	SELECT 	@Mfecha 			= fecha,
			@Mtipo_mercado 		= tipo_mercado,
			@Mtipo_operacion 	= tipo_operacion,
			@Mfecha_operacion	= fecha_operacion,
			@Mfecha_vencimiento	= fecha_vencimiento,
			@Mliquidada			= liquidada,
			@MTipo_Movimiento	= Tipo_Movimiento,
			@MGlosaAnticipo		= GlosaAnticipo,
			@MId_Paquete		= Id_Paquete,
			@MEstado_Paquete	= Estado_Paquete,
			@MReservado			= Reservado
	FROM dbo.MDLBTR
	WHERE numero_operacion 	= @nContrato  
	AND   sistema    		= @cModulo  
	AND   moneda    		= @iMoneda    
	AND   Secuencia  		= @iSecuencia

	SELECT  @MRecDireccion = Cldirecc,
			@MRecCodBanco  = Cod_Inst
	FROM dbo.CLIENTE
	WHERE Clrut = @iRutCliente
	AND Clcodigo = 1

	INSERT INTO dbo.MDLBTR
	SELECT 	@Mfecha,
			@cModulo,
			@Mtipo_mercado,
			@Mtipo_operacion,
			'PF1',
			@nContrato,
			@iRutClie,
			@iCodigo,
			@iMoneda,
			@nMonto,
			@iFormaPago,
			@Mfecha_operacion,
			@Mfecha_vencimiento,
			@Mliquidada,
			@iRutCliente,
			@MRecCodBanco,
			@sSwift,
			@MRecDireccion,
			@sCtaCte,
			@MTipo_Movimiento,
			@MGlosaAnticipo,
			@MId_Paquete,
			@MEstado_Paquete,
			@MReservado,
			@newSecuencia
END
GO
