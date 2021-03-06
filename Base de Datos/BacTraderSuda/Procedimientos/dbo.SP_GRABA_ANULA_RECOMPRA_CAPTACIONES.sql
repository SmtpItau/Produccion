USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_ANULA_RECOMPRA_CAPTACIONES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_ANULA_RECOMPRA_CAPTACIONES]
						( @nnumope_gen     NUMERIC(10)
						, @nMtoCorte       FLOAT
						, @ncorrela_corte  NUMERIC(5))
AS

/***********************************************************************
NOMBRE         : dbo.SP_GRABA_ANULA_RECOMPRA_CAPTACIONES.StoredProcedure.sql
AUTOR          : SONDA (Unidad de Desarrollo)
FECHA CREACION : 09/08/2011
DESCRIPCION    : Migracion a SQL 2008
HISTORICO DE CAMBIOS
FECHA        AUTOR           DESCRIPCION   
----------------------------------------------------------------------


**********************************************************************/
 BEGIN

/***********************************************************************************
Autor     : Felipe Silva
Motivo    : PARA LA AUNALCION DE OPERACIONES RIC
Fecha     : 19/02/2009


SP_GRABA_ANULA_RECOMPRA_CAPTACIONES ''2009''
**********************************************************************************/
SET NOCOUNT ON

	DECLARE @Factor_Mto		Float
	DECLARE @Factor_Org		Float
			,@Factor_Pes	Float
			,@num_Origen	Numeric(10)
			,@imoneda		Int

	DECLARE @monto_inicio			Float
			,@monto_inicio_pesos	Float
			,@monto_final			Float
			,@valor_ant_presente	Float
			,@valor_presente	    Float


	--+++jcamposd 20161201 no debe eliminar una recompra parcial si existe no recompras para la misma captación
	DECLARE @numeroCertificado	as NUMERIC(10)
			,@FechaMovimiento	as DATETIME	
			,@CantRegistros		as NUMERIC(10)	
	
	SELECT @numeroCertificado = numero_certificado_dcv 
			,@FechaMovimiento = mofecpro	
	FROM MDMO
	WHERE   MOTIPOPER = 'RIC'
	AND     MONUMOPER = @nnumope_gen
	AND     mocorrela = @ncorrela_corte
	
	
	SELECT @CantRegistros = COUNT(*)
	FROM MDMO
	WHERE   MOTIPOPER = 'RIC'
		AND numero_certificado_dcv = @numeroCertificado 
		AND mofecpro = @FechaMovimiento

	IF @CantRegistros > 1
	BEGIN
		SET NOCOUNT OFF
		SELECT 'NO', 0,'NO PUEDE ELIMINAR ESTA RECOMPRA, PORQUE EXISTEN OTRAS OPERACIONES DE RECOMPRA EN EL DIA, CON EL MISMO NUMERO DE CERTIFICADO.'
		RETURN 1	
	END
	-----jcamposd 20161201 no debe eliminar una recompra parcial si existe no recompras para la misma captación

	UPDATE  MDMO
	SET     mostatreg = 'A'
	WHERE   MOTIPOPER = 'RIC'
	AND     MONUMOPER = @nnumope_gen
	AND     mocorrela = @ncorrela_corte

	IF @@ERROR<> 0
	BEGIN
		SET NOCOUNT OFF
		SELECT 'NO', 0,'PROBLEMAS EN GRABACION DE OPERACION DE ANULACION DE RECOMPRA CAPTACION, << MOVIMIENTO DIARIO >>'
		RETURN 1
	END

	--+++jcamposd no lo manega el modelo corpbanca
	--UPDATE  MOVIMIENTO_ORIGINAL
	--SET     mostatreg = 'A'
	--	,  Codigo_Estado_de_Accion = 3
	--WHERE   MOTIPOPER = ''RIC''
	--AND     MONUMOPER = @nnumope_gen
	--AND     mocorrela = @ncorrela_corte

	--IF @@error<> 0
	--BEGIN
	--SET NOCOUNT OFF
	--SELECT ''NO'', 0,''PROBLEMAS EN ANULACION DE OPERACION DE RECOMPRA CAPTACION, << MOVIMIENTO_ORIGINAL >>''
	--RETURN 1
	--END
	-----jcamposd no lo manega el modelo corpbanca
------------------------------------------------------------------------------------------------------------------------
--  Obtencin de Fcator a Aumentar los Nominales de ''CAP''
------------------------------------------------------------------------------------------------------------------------
	SELECT @num_Origen				= Numero_original
			,@imoneda				= Moneda
			,@monto_inicio			= monto_inicio
			,@monto_inicio_pesos	= monto_inicio_pesos
			,@monto_final			= monto_final
			,@valor_ant_presente	= valor_ant_presente
			,@valor_presente		= valor_presente			
	FROM GEN_CAPTACION
	WHERE numero_operacion  = @nnumope_gen
		AND correla_operacion = @ncorrela_corte
		AND tipo_operacion = 'RIC'



	UPDATE GEN_CAPTACION
	SET monto_inicio		= @monto_inicio + monto_inicio
		,monto_inicio_pesos = @monto_inicio_pesos + monto_inicio_pesos
		,monto_final		= @monto_final + monto_final
		,valor_presente	    = @valor_presente + valor_presente
	WHERE numero_operacion   = @num_Origen
	AND correla_operacion    = @ncorrela_corte
	AND tipo_operacion = 'CAP'

	--SELECT @Factor_Org      = monto_final_org / monto_inicio_org
	--	, @Factor_Pes      = monto_inicio_pesos_org  / monto_inicio_org --// monto_inicio_pesos, valor_presente, valor_ant_presente
	--	, @Factor_Mto      = monto_inicio
	--FROM GEN_CAPTACION
	--WHERE numero_operacion  = @num_Origen
	--	AND correla_operacion = @ncorrela_corte
	--	AND tipo_operacion = ''CAP''

	
	--UPDATE GEN_CAPTACION
	--SET monto_inicio       = monto_inicio + @nMtoCorte
	--	,monto_inicio_pesos = Round((monto_inicio + @nMtoCorte) * @Factor_Pes,0)
	--	,monto_final        = Round((monto_inicio + @nMtoCorte) * @Factor_Org, Case @imoneda When 999 Then 0 Else 4 End )
	--	,valor_ant_presente = Round((monto_inicio + @nMtoCorte) * @Factor_Pes,0)
	--	,valor_presente     = Round((monto_inicio + @nMtoCorte) * @Factor_Pes,0)
	--WHERE numero_operacion   = @num_Origen
	--AND correla_operacion  = @ncorrela_corte
	--AND tipo_operacion = ''CAP''

	IF @@ERROR<> 0 
	BEGIN
		SET NOCOUNT OFF
		SELECT 'NO', 0, 'PROBLEMAS AL DEVOLVER NOMINALES EN OPERACION DE CAPTACION, << CAPTACION >>'
		return 1
	END

	DELETE
	FROM GEN_CAPTACION
	WHERE numero_operacion  = @nnumope_gen
		and correla_operacion = @ncorrela_corte
		and tipo_operacion = 'RIC'

	IF @@ERROR<> 0 
	BEGIN
		SET NOCOUNT OFF
		SELECT 'NO', 0, 'PROBLEMAS AL BORRAR DE CARTERA REGISTRO DE RECOMPRA DE CAPTACION, << CAPTACION >>'
		RETURN 1
	END

	SET NOCOUNT OFF
	SELECT 'SI', @NNUMOPE_GEN, 'OPERACION DE CAPTACINONES, GRABADA SATISFACTORIAMENTE '
	RETURN 0
 
END
GO
