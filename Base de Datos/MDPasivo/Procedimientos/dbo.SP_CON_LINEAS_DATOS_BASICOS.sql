USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_LINEAS_DATOS_BASICOS]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_LINEAS_DATOS_BASICOS]
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT dmy
	SET NOCOUNT ON

DECLARE 
         @Fecha_Proceso        DATETIME
    ,    @Moneda_Control       NUMERIC(03)
    ,    @Valor_Moneda         FLOAT
    ,    @Tipo_CambioCierre    FLOAT
    ,    @Monto_Con_Riesgo     FLOAT
    ,    @Monto_Sin_Riesgo     FLOAT
    ,    @Patrimonio_Efectivo  FLOAT
    ,    @Monto_Sobregiro      FLOAT
    ,    @nRut_entidad         NUMERIC(10)
    ,    @nDias_Pacto_Bcch     NUMERIC(3) 
    ,    @nRut_Bcch            NUMERIC(10)
    ,    @nPlaza               NUMERIC(05)
    ,    @nPais                NUMERIC(05)
    ,    @ValidaLineas         CHAR(1)

SELECT @Valor_Moneda         = 1

SELECT 
         @Fecha_Proceso        = fecha_proceso
    ,    @Moneda_Control       = moneda_control
    ,    @Valor_Moneda         = ISNULL(vmvalor,1)
    ,    @Monto_Con_Riesgo     = monto_con_riesgo
    ,    @Monto_Sin_Riesgo     = monto_sin_riesgo
    ,    @Patrimonio_Efectivo  = capital_reserva
    ,    @Monto_Sobregiro      = primer_tramo
    ,    @nRut_entidad         = Rut_Entidad
    ,    @nDias_Pacto_Bcch     = Dias_Pactado_Papel_No_Central
    ,    @nRut_Bcch            = Rut_Bcch
    ,    @nPlaza               = Codigo_Plaza
    ,    @nPais                = Codigo_Pais
    ,    @ValidaLineas         = Valida_Linea

FROM DATOS_GENERALES  WITH (NOLOCK), VALOR_MONEDA  WITH (NOLOCK INDEX=PK_VALOR_MONEDA)
WHERE vmcodigo =* moneda_control
AND   vmfecha  =* fecha_proceso


      EXECUTE Sp_Arbitrajes_TipoCambio_Cierre @Fecha_Proceso
                                            , @Tipo_CambioCierre OUTPUT

SELECT 
         Fecha_Proceso		= @Fecha_Proceso
    ,    Moneda_Control		= @Moneda_Control
    ,    Valor_Moneda		= @Valor_Moneda
    ,    Tipo_CambioCierre	= @Tipo_CambioCierre
    ,    Monto_Con_Riesgo	= @Monto_Con_Riesgo
    ,    Monto_Sin_Riesgo	= @Monto_Sin_Riesgo
    ,    Patrimonio_Efectivo	= @Patrimonio_Efectivo
    ,    Monto_Sobregiro	= @Monto_Sobregiro
    ,    nRut_entidad		= @nRut_entidad
    ,    nDias_Pacto_Bcch	= @nDias_Pacto_Bcch
    ,    nRut_Bcch		= @nRut_Bcch
    ,    nPlaza			= @nPlaza
    ,    nPais			= @nPais
    ,    ValidaLineas		= @ValidaLineas

END





GO
