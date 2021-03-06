USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALCULA_OCUPADO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RECALCULA_OCUPADO]
		(
			@nmonto_asignado		FLOAT
		,	@nmonto_ocupado			FLOAT
		,	@nmoneda_cambio			INTEGER
		,	@nmoneda_actual			INTEGER
		)
as
begin


DECLARE
	@nvalor_mon_cambio 	FLOAT
,	@nvalor_mon_actual	FLOAT
,	@dfecpro		DATETIME
,	@nvalor_act_asig_pesos	FLOAT
,	@nvalor_act_ocup_pesos	FLOAT
,	@nvalor_asignado	FLOAT
,	@nvalor_ocupado		FLOAT
,	@nvalor_disponible	FLOAT
,	@nvalor_exceso		FLOAT

SELECT @dfecpro = acfecproc FROM bactradersuda.dbo.MDAC

IF @nmoneda_cambio = @nmoneda_actual
	RETURN

IF @nmoneda_cambio = 13
	SELECT @nmoneda_cambio = 994

IF @nmoneda_actual = 13 
	SELECT @nmoneda_actual = 994


SELECT 	@nvalor_mon_cambio = isnull(vmvalor,0)
	FROM VIEW_VALOR_MONEDA 
	WHERE vmcodigo = @nmoneda_cambio 
	AND vmfecha = @dfecpro

SELECT 	@nvalor_mon_actual = isnull(vmvalor,0)
	FROM VIEW_VALOR_MONEDA 
	WHERE vmcodigo = @nmoneda_actual
	AND vmfecha = @dfecpro

IF NOT EXISTS(SELECT 1 FROM	VIEW_VALOR_MONEDA 
		WHERE vmcodigo = @nmoneda_cambio 
		AND vmfecha = @dfecpro)
BEGIN
	SELECT @nvalor_mon_cambio = 0
END

IF NOT EXISTS(SELECT 1 FROM	VIEW_VALOR_MONEDA 
		WHERE vmcodigo = @nmoneda_actual
		AND vmfecha = @dfecpro)
BEGIN
	SELECT @nvalor_mon_actual = 0
END


IF @nmoneda_cambio = 999 
	SELECT @nvalor_mon_cambio = 1

IF @nmoneda_actual = 999 
	SELECT @nvalor_mon_actual = 1



IF @nvalor_mon_cambio = 0 
BEGIN
	SELECT 'ERROR'
	,	'Valor de Moneda ' + LTRIM(RTRIM(mnglosa)) + ' No existe para Fecha de Proceso'
	FROM VIEW_MONEDA 
	WHERE mncodmon = @nmoneda_cambio
	RETURN
END						
IF @nvalor_mon_actual = 0 
BEGIN
	SELECT 'ERROR'
	,	'Valor de Moneda ' + LTRIM(RTRIM(mnglosa)) + ' No existe para Fecha de Proceso'
	FROM VIEW_MONEDA 
	WHERE mncodmon = @nmoneda_actual
RETURN
END

IF @nmoneda_actual = 999
BEGIN
	SELECT @nvalor_act_asig_pesos = @nmonto_asignado
	SELECT @nvalor_act_ocup_pesos = @nmonto_ocupado

END ELSE 
BEGIN
	SELECT @nvalor_act_asig_pesos = round(@nmonto_asignado * @nvalor_mon_actual,0)
	SELECT @nvalor_act_ocup_pesos = round(@nmonto_ocupado * @nvalor_mon_actual,0)
END


	SELECT @nvalor_asignado = round(@nvalor_act_asig_pesos / @nvalor_mon_cambio,0)
	SELECT @nvalor_ocupado  = round(@nvalor_act_ocup_pesos / @nvalor_mon_cambio,0)
	SELECT @nvalor_disponible = round(@nvalor_asignado - @nvalor_ocupado,0)
	IF @nvalor_ocupado > @nvalor_asignado
		SELECT @nvalor_exceso = round(@nvalor_ocupado - @nvalor_asignado,0)
	ELSE
		SELECT @nvalor_exceso = 0



SELECT 'SI'
,	@nvalor_ocupado
,	@nvalor_asignado
,	@nvalor_disponible
,	@nvalor_exceso

END
GO
