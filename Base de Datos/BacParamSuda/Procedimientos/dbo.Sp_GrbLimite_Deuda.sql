USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GrbLimite_Deuda]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_GrbLimite_Deuda]
				(
				@nNumoper	NUMERIC	(10,0)	,
				@nRutcli	NUMERIC	(09,0)	,
				@nCodcli	NUMERIC	(09,0)	,
				@nMonto		NUMERIC	(19,2)	,
				@nExceso	NUMERIC	(19,2)	,
				@cUsuario	CHAR	(12)	,
				@nMtoEndeuda	NUMERIC	(19,2)	,
				@cTipoper	CHAR	(10)	,
				@cMensaje	CHAR	(30)	,
				@dFecven	DATETIME	,
				@iPlazo		INTEGER
				)
AS

------ LD1-COR-035 LIMITE ENDEUDAMIENTO
/***********************************************************************
NOMBRE         : dbo.Sp_GrbLimite_Deuda.StoredProcedure.sql
AUTOR          : SONDA (Unidad de Desarrollo)
FECHA CREACION : 09/08/2011
DESCRIPCION    : Migracion a SQL 2008
HISTORICO DE CAMBIOS
FECHA        AUTOR           DESCRIPCION   
----------------------------------------------------------------------


**********************************************************************/
BEGIN
	SET NOCOUNT OFF

	UPDATE	LIMITE_TOTAL_ENDEUDAMIENTO
	SET	outstanding	= outstanding+@nMonto
	WHERE	rut_cliente=@nRutcli AND @nCodcli=codigo_cliente

	INSERT INTO
	CONTROL_LIMITES_GENERALES
		(
		Codigo_Tipo_Limite	,
		Codigo_Limite		,
		Descripcion_Limite	,
		Numero_operacion	,
		Tipo_Operacion		,
		Serie			,
		Monto_Operacion		,
		Monto_Linea		,
		Exceso			,
		Fecha_Exceso		,
		Plazo			,
		Trader			,
		Trader_Autorizador	,
		Rut_Cliente		,
		Codigo_Cliente
		)
	VALUES
		(
		2			, -- Limites Endeudamiento
		1			,
		@cMensaje		,
		@nNumoper		,
		@cTipoper		,
		@cTipoper		,
		@nMonto			,
		@nMonto			,
		@nExceso		,
		@dFecven		,
		@iPlazo			,
		@cUsuario		,
		@cUsuario		,
		@nRutcli		,
		@nCodcli
		)

	SET NOCOUNT ON
END

GO
