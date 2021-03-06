USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Llena_Contabiliza_Saldos]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_Llena_Contabiliza_Saldos]
           ( @fecha_hoy       DATETIME
           , @id_sistema      CHAR(3)
           , @producto        VARCHAR(5)
           , @limpiacnt       NUMERIC(1)
           )
AS

BEGIN
 
   SET DATEFORMAT dmy
   SET NOCOUNT ON




   IF @limpiacnt = 1
   BEGIN

      IF EXISTS(SELECT 1 FROM tempdb..sysobjects WHERE NAME = '##CONTABILIZA' )
      BEGIN

         DROP TABLE [DBO].[##CONTABILIZA]

      END

	CREATE TABLE dbo.##CONTABILIZA
	(	Id_Sistema			CHAR   (03)                                
        ,	cProducto			VARCHAR(07)
        ,	cTipo_Plazo			VARCHAR(01)
        ,	cFinanciamiento			VARCHAR(03) 
        ,	cCodigo_Sector			VARCHAR(01)
        ,	cCodigo_Subsector		VARCHAR(02)
        ,	cBanco_Corresponsal		VARCHAR(05)
        ,	cStatus_Cuota			VARCHAR(01)
        ,	cStatus_Colocacion		VARCHAR(01)
        ,	cReajustabilidad		VARCHAR(01)
        ,	cDivisa				VARCHAR(03)
        ,	cTipo_Divisa			VARCHAR(01)
        ,	Valor_Compra			FLOAT DEFAULT 0
        ,	Valor_Presente			FLOAT DEFAULT 0
        ,	Valor_Venta			FLOAT DEFAULT 0
        ,	Utilidad			FLOAT DEFAULT 0
        ,	Perdida				FLOAT DEFAULT 0
        ,	Interes_Papel			FLOAT DEFAULT 0
        ,	Reajuste_Papel			FLOAT DEFAULT 0
        ,	Interes_Pacto			FLOAT DEFAULT 0
        ,	Reajuste_Pacto			FLOAT DEFAULT 0
        ,	Valor_Cupon			FLOAT DEFAULT 0
        ,	NominalPesos			FLOAT DEFAULT 0
        ,	Nominal				FLOAT DEFAULT 0
        ,	Valor_CompraHis			FLOAT DEFAULT 0
        ,	Dif_Ant_Pacto_Pos		FLOAT DEFAULT 0
        ,	Dif_Ant_Pacto_Neg		FLOAT DEFAULT 0
        ,	Dif_Valor_Mercado_Pos		FLOAT DEFAULT 0
        ,	Dif_Valor_Mercado_Neg		FLOAT DEFAULT 0
        ,	Rev_Valor_Mercado_Pos		FLOAT DEFAULT 0
        ,	Rev_Valor_Mercado_Neg		FLOAT DEFAULT 0
        ,	Valor_Futuro			FLOAT DEFAULT 0
        ,	Valor_Perdida_Usd		NUMERIC(19)	DEFAULT 0
        ,	Valor_Utilidad_Usd		NUMERIC(19)	DEFAULT 0
        ,	Valor_Perdida_Clp		NUMERIC(19)	DEFAULT 0
        ,	Valor_Utilidad_Clp		NUMERIC(19)	DEFAULT 0
	,	pago_parcial			FLOAT DEFAULT 0
	,	recaudacion_parcial		FLOAT DEFAULT 0
	,	diferencia_recibida		FLOAT DEFAULT 0
	,	swp_utilidad_mercado		FLOAT DEFAULT 0
	,	swp_perdida_mercado		FLOAT DEFAULT 0
	,	swp_capital_moneda1		FLOAT DEFAULT 0
	,	swp_capital_moneda2		FLOAT DEFAULT 0
	,	swp_diferencia_cambio		FLOAT DEFAULT 0
	,	swp_diferencia_recibida		FLOAT DEFAULT 0
	,	swp_diferencia_recibida_CP	FLOAT DEFAULT 0
	,	swp_diferencia_recibida_SP	FLOAT DEFAULT 0
	,	swp_diferencia_recibida_LB	FLOAT DEFAULT 0
	,	swp_entrega_principales_m1	FLOAT DEFAULT 0
	,	swp_entrega_principales_m2	FLOAT DEFAULT 0
	,	swp_interes_cobrado		FLOAT DEFAULT 0
	,	swp_interes_cobrado_SP		FLOAT DEFAULT 0
	,	swp_interes_cobrado_CP		FLOAT DEFAULT 0
	,	swp_interes_cobrado_LB		FLOAT DEFAULT 0
	,	swp_interes_pagado		FLOAT DEFAULT 0
	,	swp_interes_pagado_SP		FLOAT DEFAULT 0
	,	swp_interes_pagado_CP		FLOAT DEFAULT 0
	,	swp_interes_pagado_LB		FLOAT DEFAULT 0
	,	swp_perd_dif_pre_CP		FLOAT DEFAULT 0
	,	swp_perd_dif_pre_SP		FLOAT DEFAULT 0
	,	swp_perd_dif_pre_LB		FLOAT DEFAULT 0
	,	swp_perd_diferida		FLOAT DEFAULT 0
	,	swp_diferencia_contra		FLOAT DEFAULT 0
	,	swp_dif_pagada_SP		FLOAT DEFAULT 0
	,	swp_dif_pagada_CP		FLOAT DEFAULT 0
	,	swp_dif_pagada_LB		FLOAT DEFAULT 0
	,	swp_reajuste_dev		FLOAT DEFAULT 0
	,	swp_reajuste			FLOAT DEFAULT 0
	,	swp_util_dif_pre_CP		FLOAT DEFAULT 0
	,	swp_util_dif_pre_SP		FLOAT DEFAULT 0
	,	swp_util_dif_pre_LB		FLOAT DEFAULT 0
	,	swp_util_diferida		FLOAT DEFAULT 0
	,	swp_dif_recibida_SP		FLOAT DEFAULT 0
	,	swp_dif_recibida_CP		FLOAT DEFAULT 0
	,	swp_dif_recibida_LB		FLOAT DEFAULT 0
	,	swp_diferencia_favor		FLOAT DEFAULT 0

	,	fwd_capital_mx1			FLOAT DEFAULT 0
	,	fwd_capital_mx2			FLOAT DEFAULT 0
	,	fwd_dif_cambio			FLOAT DEFAULT 0
	,	fwd_dif_pago_cp			FLOAT DEFAULT 0
	,	fwd_dif_pago_sp			FLOAT DEFAULT 0
	,	fwd_dif_pago_lb			FLOAT DEFAULT 0
	,	fwd_perdida_cp			FLOAT DEFAULT 0
	,	fwd_perdida_sp			FLOAT DEFAULT 0
	,	fwd_perdida_lb			FLOAT DEFAULT 0
	,	fwd_utilidad_cp			FLOAT DEFAULT 0
	,	fwd_utilidad_sp			FLOAT DEFAULT 0
	,	fwd_utilidad_lb			FLOAT DEFAULT 0
	,	fwd_difpre_util			FLOAT DEFAULT 0
	,	fwd_difval_util			FLOAT DEFAULT 0
	,	fwd_difpre_Perd			FLOAT DEFAULT 0
	,	fwd_difval_Perd			FLOAT DEFAULT 0

	,	fwd_difpre_util_rv		NUMERIC(19,4) DEFAULT 0
	,	fwd_difpre_Perd_rv		NUMERIC(19,4) DEFAULT 0
	,	fwd_reajuste			NUMERIC(19,4) DEFAULT 0


        ,	Tipo_Cuenta			CHAR   (01)
	,	cproductor			VARCHAR(07)
        ,	Codigo_Evento			CHAR   (03)
        ,	Codigo_Moneda1			INTEGER
        ,	Codigo_Moneda2			INTEGER
        ,	Codigo_Instrumento		INTEGER
        ,	Numero_Operacion		NUMERIC(10)
        ,	Numero_Documento		NUMERIC(10)
        ,	Correlativo			NUMERIC(03)
--	,	nInstancia_Agrupacion		INTEGER DEFAULT 0
	,	Forma_pago			INTEGER
        ,	rut				NUMERIC(9)
        ,	codigo_operacion		CHAR(3)
        ,	mercado				NUMERIC(1)
        ,	fecha_contable			DATETIME
	,	archivo_proceso			CHAR(3)		DEFAULT ''
	,	fecha_historica			DATETIME	DEFAULT ''
        ,	tipoper				CHAR(5)		DEFAULT ''
        ,	tipoperO			CHAR(5)		DEFAULT ''
        ,	cartera				CHAR(5)		DEFAULT ''
        ,	numero_SPOT			NUMERIC(10)	DEFAULT 0
        ,	fecha_referencia		CHAR(8)		DEFAULT ''
        ,	sucursal_contable		NUMERIC(5)      DEFAULT 87
	,	csistema_orig			CHAR(3)		DEFAULT ''
	,	cproducto_orig			CHAR(3)		DEFAULT ''
        )

   END 

   IF @@ERROR <> 0
   BEGIN

      PRINT 'ERROR_PROC FALLA BORRANDO TABLA ##CONTABILIZA.'
      RETURN 1

   END


--**********************************************************
--**********************************************************
-- RENTA FIJA
--**********************************************************
--**********************************************************


   IF @id_sistema = 'BTR'
   BEGIN
	IF 	@producto = 'RP'	EXECUTE Sp_Llena_Contabiliza_Saldos_BTR_REPOS	@fecha_hoy, @id_sistema, @producto
	ELSE IF @producto = 'FLP'	EXECUTE Sp_Llena_Contabiliza_Saldos_BTR_FLP	@fecha_hoy, @id_sistema, @producto
	ELSE IF @producto = 'FPD'	EXECUTE Sp_Llena_Contabiliza_Saldos_BTR_FPD	@fecha_hoy, @id_sistema, @producto
	ELSE				EXECUTE Sp_Llena_Contabiliza_Saldos_BTR		@fecha_hoy, @id_sistema, @producto
   END



   IF @id_sistema = 'BFW'
   BEGIN

	IF 	@producto = '2'		EXECUTE Sp_Llena_Contabiliza_Saldos_BFW_MXMX	@fecha_hoy, @id_sistema, @producto   
	ELSE IF @producto = '7'		EXECUTE Sp_Llena_Contabiliza_Saldos_BFW_FBT	@fecha_hoy, @id_sistema, @producto   
	ELSE				EXECUTE Sp_Llena_Contabiliza_Saldos_BFW		@fecha_hoy, @id_sistema, @producto   

   END


   IF @id_sistema = 'SWP'
   BEGIN

	IF @producto = 'ST'		EXECUTE Sp_Llena_Contabiliza_Saldos_SWP_ST	@fecha_hoy, @id_sistema, @producto
	ELSE IF @producto = 'SM'	EXECUTE Sp_Llena_Contabiliza_Saldos_SWP_SM	@fecha_hoy, @id_sistema, @producto
	ELSE IF @producto = 'SC'	EXECUTE Sp_Llena_Contabiliza_Saldos_SWP_SC	@fecha_hoy, @id_sistema, @producto


   END

   IF @id_sistema = 'INV'
   BEGIN
	EXECUTE Sp_Llena_Contabiliza_Saldos_INV @fecha_hoy, @id_sistema, @producto   
   END

   IF @id_sistema = 'PSV'
   BEGIN
	EXECUTE Sp_Llena_Contabiliza_Saldos_PSV @fecha_hoy, @id_sistema, @producto   
   END

   IF @id_sistema = 'SVL'
   BEGIN
	IF @producto = 'VRF'		EXECUTE Sp_Llena_Contabiliza_Saldos_VAL     @fecha_hoy, @id_sistema, @producto   
	ELSE IF @producto = 'VDR'	EXECUTE Sp_Llena_Contabiliza_Saldos_VAL_DRV @fecha_hoy, @id_sistema, @producto   

   END



	UPDATE	##CONTABILIZA
	SET	cDivisa = LEFT(b.mnsimbol,3)
	FROM	VIEW_MONEDA A,
		VIEW_MONEDA B
	WHERE	a.mnsimbol = cDivisa
	AND	a.canasta = 'S'
	AND	b.mncodmon = a.moneda_canasta


	UPDATE	##CONTABILIZA
	SET	codigo_operacion = LEFT(b.mnsimbol,3)
	FROM	VIEW_MONEDA A,
		VIEW_MONEDA B
	WHERE	a.mnsimbol = codigo_operacion
	AND	a.canasta = 'S'
	AND	b.mncodmon = a.moneda_canasta


	UPDATE	##CONTABILIZA
	SET	codigo_moneda1 = a.moneda_canasta
	FROM	VIEW_MONEDA A
	WHERE	a.mncodmon = codigo_moneda1
	AND	a.canasta = 'S'


	UPDATE	##CONTABILIZA
	SET	codigo_moneda2 = a.moneda_canasta
	FROM	VIEW_MONEDA A
	WHERE	a.mncodmon = codigo_moneda2
	AND	a.canasta = 'S'


   SET NOCOUNT OFF

END

GO
