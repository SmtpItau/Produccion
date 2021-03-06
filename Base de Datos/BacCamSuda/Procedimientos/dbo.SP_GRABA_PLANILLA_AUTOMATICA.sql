USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PLANILLA_AUTOMATICA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_GRABA_PLANILLA_AUTOMATICA]
	(	
		@entidad				NUMERIC(3)			-->  1
	,	@tipo_mercado			CHAR(4)				-->  2			PTAS,EMPR,ARBI
	,	@tipo_operacion			CHAR(1)				-->  3			C,V
	,	@operacion_fecha		DATETIME			-->  4			char(8) dtresner
	,	@operacion_numero		NUMERIC(7)			-->  5
	,	@operacion_moneda		NUMERIC(3)			-->  6			CHAR(3), -->	NUMERIC(3),
	,	@interesado_rut			NUMERIC(9)			-->  7
	,	@interesado_codigo		NUMERIC(9)			-->  8
	,	@monto_origen			NUMERIC(19,4)		-->  9
	,	@paridad				NUMERIC(19,8)		--> 10 
	,	@monto_dolares			NUMERIC(19,4)		--> 11			19,8
	,	@tipo_cambio			NUMERIC(19,4)		--> 12			19,8
	,	@monto_pesos			NUMERIC(19,4)		--> 13
	,	@der_numero_contrato	NUMERIC(8)			--> 14
	,	@der_fecha_inicio		DATETIME			--> 15
	,	@der_fecha_vence		DATETIME			--> 16
	,	@der_precio_contrato	NUMERIC(19,4)		--> 17
	,	@der_instrumento		NUMERIC(2)			--> 18
	,	@rel_institucion		NUMERIC(3)			--> 19
	,	@rel_fecha				DATETIME			--> 20
	,	@rel_numero				NUMERIC(10)			--> 21		NUMERIC(6)
	,	@rel_arbitraje			CHAR(1)				--> 22
	,	@codigo_area			VARCHAR(5)			--> 23
	,	@codigo_comercio		CHAR(6)				--> 24
	,	@codigo_concepto		CHAR(3)				--> 25
	,	@planilla_numero		NUMERIC(10)	OUTPUT	--> NUMERIC(6)
	,	@planilla_fecha			DATETIME	OUTPUT	-->	char(8)dtresner
	)
AS
BEGIN

	DECLARE @ok				NUMERIC(10)
	DECLARE @tipo_cliente	CHAR(3)   
	DECLARE @cliente_tipo	INTEGER
	DECLARE @condicion		CHAR(10)
	DECLARE @Valut			CHAR(10)
	DECLARE @Corres_Donde	CHAR(50)
	DECLARE @Corres_Desde	CHAR(50)
	DECLARE @Corres_Quien	CHAR(50)
		SET	@ok				= 1



	IF @planilla_numero = 0
	BEGIN

		set @planilla_numero	= isnull(	( SELECT correlativo_planilla FROM BacCamSuda.dbo.MEAC ) ,0)

        UPDATE	BAcCamSuda.dbo.MEAC
		SET		correlativo_planilla	= (correlativo_planilla + 1)
		WHERE	acentida				= 'ME'

		IF @@ERROR <> 0
        BEGIN
			SELECT @@ERROR, 'NO SE PUDO CAPTURAR CORRELATIVO PARA PLANILLA AUTOMATICA'
            RETURN -1
		END

		INSERT INTO	BacParamSuda.dbo.Planilla_Spt		-->	VIEW_PLANILLA_SPT
		(	fecha
		,	entidad
		,	planilla_fecha
		,	planilla_numero
		,	NumeroPlanilla_IBS		--> SSe agrega para RQ de Interfaz Poscam
		)
		VALUES
        (	CONVERT(CHAR(8), GETDATE(), 112)
        ,	@entidad
        ,	@planilla_fecha
        ,	@planilla_numero
        ,	0						--> Se crea el numero de Planilla, con valor cero para inicializar el Campo
		)

        IF @@ERROR <> 0
        BEGIN
			SELECT @@ERROR, 'NO SE PUEDE AGREGAR PLANILLA AUTOMATICA'
            RETURN -1
		END
	END

	UPDATE	VIEW_PLANILLA_SPT
	SET		interesado_rut		= @interesado_rut
	,		interesado_codigo	= @interesado_codigo
	,		operacion_numero	= @operacion_numero
	,		operacion_fecha		= @operacion_fecha
	,		operacion_moneda	= @operacion_moneda
	,		monto_origen		= @monto_origen
	,		paridad				= @paridad
	,		monto_dolares		= @monto_dolares
	,		tipo_cambio			= @tipo_cambio
	,		monto_pesos			= @monto_pesos
	,		afecto_derivados	= CASE WHEN @der_numero_contrato > 0 THEN 1 ELSE 0 END
	,		tipo_documento		= 1							--	(CASE WHEN @tipo_operacion      = 'C' THEN 1 ELSE 1 END)   -- 1=ingreso   2=egreso
	WHERE	entidad				= @entidad
    AND		planilla_numero		= @planilla_numero
    AND		planilla_fecha		= convert(char(8), @planilla_fecha, 112)

	IF @@ERROR <> 0 OR @@ROWCOUNT = 0
    BEGIN
		SET		@planilla_numero	= 1   -- no acepta asignacion de cero = 0
		SET		@planilla_fecha		= ''
        SELECT	-1,'NO SE PUEDEN ACTUALIZAR DATOS GENERALES DE PLANILLA AUTOMATICA', @operacion_numero, @planilla_numero, @planilla_fecha
        RETURN	-1
	END

	UPDATE  BacParamSuda.dbo.Planilla_Spt	-->	VIEW_PLANILLA_SPT
	SET		interesado_nombre		= SUBSTRING(a.clnombre, 1, 30)
	,		interesado_direccion	= SUBSTRING(a.cldirecc, 1, 30)
    ,		interesado_ciudad		= isnull(SUBSTRING(b.nombre, 1, 20), '')
    FROM	VIEW_CLIENTE			a 
			LEFT OUTER JOIN VIEW_CIUDAD b ON a.Clciudad = b.codigo_ciudad
	WHERE	entidad                  = @entidad
	AND		planilla_numero          = @planilla_numero
	AND		CONVERT(CHAR(8),planilla_fecha,112)  = CONVERT( CHAR(8), @planilla_fecha , 112)
	AND		interesado_rut           = a.clrut
	AND		interesado_codigo        = a.clcodigo

	IF @tipo_mercado <> 'ARBI'
	BEGIN
		UPDATE	VIEW_PLANILLA_SPT
		SET		pais_operacion		= ISNULL(mncodpais,225)
		FROM	VIEW_MONEDA
		WHERE	entidad             = @entidad              
		AND		planilla_numero     = @planilla_numero      
		AND		planilla_fecha    	= @planilla_fecha 
		AND		operacion_moneda    = mncodmon
	END ELSE
	BEGIN
		UPDATE	VIEW_PLANILLA_SPT
		SET		pais_operacion      = ISNULL(Clpais,225)
		FROM	VIEW_CLIENTE
		WHERE	entidad             = @entidad              
		AND		planilla_numero     = @planilla_numero      
		AND		planilla_fecha    	= @planilla_fecha 
		AND		Clrut 				= @interesado_rut
		AND		Clcodigo			= @interesado_CODIGO
	END

	DECLARE	@der_area_contable		NUMERIC(1)
	SET		@ok						= @der_numero_contrato

	IF @ok > 0
	BEGIN
		SELECT @der_area_contable = (CASE WHEN @tipo_operacion = 'C' THEN 1 ELSE 2 END)
	END

	UPDATE	VIEW_PLANILLA_SPT
	SET		der_numero_contrato     = (CASE WHEN @ok > 0 THEN @der_numero_contrato ELSE  0 END),
			der_fecha_inicio        = (CASE WHEN @ok > 0 THEN @der_fecha_inicio    ELSE '' END),
			der_fecha_vence         = (CASE WHEN @ok > 0 THEN @der_fecha_vence     ELSE '' END),
			der_instrumento         = (CASE WHEN @ok > 0 THEN @der_instrumento     ELSE  0 END),
			der_precio_contrato     = (CASE WHEN @ok > 0 THEN @der_precio_contrato ELSE  0 END),
			der_area_contable       = (CASE WHEN @ok > 0 THEN @der_area_contable   ELSE  0 END)
	WHERE	entidad                 = @entidad              
	AND		planilla_numero         = @planilla_numero      
	AND		CONVERT(CHAR(8),planilla_fecha,112)  = @planilla_fecha

	IF @@ERROR <> 0 OR @@ROWCOUNT = 0 
		SET	@ok = @rel_numero

	IF @rel_arbitraje = 'A'
	BEGIN  --@ok > 0  
		SELECT @Corres_Donde	= ISNULL((SELECT DISTINCT RTRIM(nombre) FROM memo,view_corresponsal WHERE monumope=@operacion_numero AND cod_corresponsal = CONVERT(INTEGER,Swift_Recibimos)),'')
		SELECT @Corres_Desde	= ISNULL((SELECT DISTINCT RTRIM(nombre) FROM memo,view_corresponsal WHERE monumope=@operacion_numero AND cod_corresponsal = CONVERT(INTEGER,Swift_Entregamos)),'')
		SELECT @Corres_Quien	= ISNULL((SELECT DISTINCT RTRIM(nombre) FROM memo,view_corresponsal WHERE monumope=@operacion_numero AND cod_corresponsal = CONVERT(INTEGER,Swift_Corresponsal)),'')
		SELECT @Valut			= (SELECT CONVERT(CHAR(10),MOVALUTA1,103) FROM memo WHERE monumope=@operacion_numero)

		UPDATE	VIEW_PLANILLA_SPT
		SET		rel_institucion    = @rel_institucion,
				rel_fecha          = @rel_fecha,
				rel_arbitraje      = @rel_arbitraje,
				rel_numero         = @rel_numero,
				obs_1              = CASE	WHEN @tipo_operacion = 'C' and operacion_moneda = 13 THEN	'Cliente: '+@Corres_Donde+' Paridad : '+CONVERT(CHAR(28),paridad)+' Credito : '+@Corres_Quien+' Valuta  : '	+	@Valut
											ELSE														'Cliente: '+@Corres_Donde+' Paridad : '+CONVERT(CHAR(28),paridad)+' Debito : '+@Corres_Desde+' Valuta  : '	+	@Valut
										END 
		WHERE	entidad            = @entidad              
		AND		planilla_numero    = @planilla_numero      
		AND		CONVERT(CHAR(8),planilla_fecha,112)  = CONVERT(CHAR(8),@planilla_fecha,112)

		UPDATE	VIEW_PLANILLA_SPT
		SET		rel_institucion		= @rel_institucion,
				rel_fecha			= @planilla_fecha,
				rel_arbitraje		= @rel_arbitraje,
				rel_numero			= @planilla_numero,
				obs_1               = CASE	WHEN @tipo_operacion = 'C' and operacion_moneda <> 13 THEN 'Cliente: '+@Corres_Donde+' Paridad : '+CONVERT(CHAR(28),paridad)+' Credito : '+@Corres_Quien+' Valuta  : '+@Valut
											ELSE 'Cliente: '+@Corres_Donde+' Paridad : '+CONVERT(CHAR(28),paridad)+' Debito : '+@Corres_Donde+' Valuta  : '+@Valut
										END 
		WHERE	entidad             = @entidad              
		AND		planilla_numero		= @rel_numero
		AND		CONVERT(CHAR(8),planilla_fecha,112)  = CONVERT(CHAR(8),@rel_fecha,112)
	END

	IF @@ERROR<>0 OR @@ROWCOUNT = 0
		SET		@tipo_cliente = '000'

	SET		@cliente_tipo = 0

	SELECT	@tipo_cliente	= CONVERT(CHAR(3), (CASE WHEN cltipcli > 9 THEN 0 ELSE cltipcli END) ),
			@cliente_tipo	= ( CASE WHEN cltipcli > 9 THEN 0 ELSE cltipcli END )
	FROM	VIEW_CLIENTE      ,
			VIEW_PLANILLA_SPT
	WHERE	clrut			= interesado_rut 
	AND		clcodigo		= interesado_codigo
	AND		planilla_numero = @planilla_numero     
	AND		convert(char(8),planilla_fecha,112)  = @planilla_fecha 

	SELECT @tipo_cliente	= CASE	WHEN @der_numero_contrato > 0 AND @cliente_tipo > 4 AND @tipo_mercado <> 'ARBI' THEN 'FE' -- forward y/o swaps Empresas
									WHEN @der_numero_contrato > 0 AND @cliente_tipo < 4 AND @tipo_mercado <> 'ARBI' THEN 'FB' -- forward y/o swaps Bancos
									WHEN @der_numero_contrato > 0 AND @cliente_tipo > 4 AND @tipo_mercado = 'ARBI'  THEN 'FAE' -- forward y/o swaps Empresas
									WHEN @der_numero_contrato > 0 AND @cliente_tipo < 4 AND @tipo_mercado = 'ARBI'  THEN 'FAB' -- forward y/o swaps Bancos
									WHEN @tipo_mercado        = 'ARBI'   THEN 'A'   -- arbitraje o spot de moneda
									WHEN @interesado_rut      = 97029000 THEN 'C'   -- banco central de chile
									WHEN @tipo_mercado        = 'EMPR' AND @interesado_rut = 97018000 THEN 'S'  -- Sucursales Empresas
									ELSE @tipo_cliente                    
								END
	SELECT @condicion		= CASE WHEN RTRIM(LTRIM(@tipo_cliente)) IN ('FE','FB','FAE','FAB','A','C') THEN 'USD' ELSE 'CLP' END
	SELECT @condicion		= case	when @tipo_mercado = 'EMPR' and @cliente_tipo <> 4 then @tipo_operacion
									else @tipo_operacion + RTRIM(LTRIM(@condicion)) + RTRIM(LTRIM(@tipo_cliente))

								end

	UPDATE	VIEW_PLANILLA_SPT
	SET		tipo_operacion_cambio   = d.tipo_operacion_cambio,
			codigo_comercio         = (CASE @codigo_comercio WHEN '' THEN d.comercio ELSE @codigo_comercio END),
			concepto                = (CASE @codigo_concepto WHEN '' THEN d.concepto ELSE @codigo_concepto END)
	FROM	CODIGO_PLANILLA_AUTOMATICA d
	WHERE	entidad					= @entidad           
	AND		planilla_numero         = @planilla_numero     
	AND		convert(char(8),planilla_fecha,112)  = @planilla_fecha 
	AND		d.condicion				= @condicion

end
GO
