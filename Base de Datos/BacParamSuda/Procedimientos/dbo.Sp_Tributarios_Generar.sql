USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tributarios_Generar]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Tributarios_Generar]
	(	@dFecha		DATETIME	)
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS( SELECT 1 FROM SYS.SYSOBJECTS WHERE NAME = 'Tmp_Cuentas_Tributarios' AND type = 'U')
	BEGIN
		DROP TABLE dbo.Tmp_Cuentas_Tributarios
	END

	CREATE TABLE dbo.Tmp_Cuentas_Tributarios
	(	Id_Sistema				varchar(5)			not null default ('')
	,	Canumoper				numeric(21)			not null default (0)
	,	CaCodPos1				varchar(5)			not null default ('')
	,	CaMtoMon1				numeric(21,4)		not null default (0.0)
	,	CaCodMon1				numeric(9)			not null default (0)
	,	CaCodMon2				numeric(9)			not null default (0)

	,	Cuenta_AVR_Activo		numeric(21)			not null default (0)
	,	Utilidad_AVR			numeric(21)			not null default (0)
	,	Cuenta_AVR_Pasivo		numeric(21)			not null default (0)
	,	Perdida_AVR				numeric(21)			not null default (0)
	,	Perdida_Real			numeric(21)			not null default (0)
	,	Utilidad_Real			numeric(21)			not null default (0)
	)

	INSERT INTO dbo.Tmp_Cuentas_Tributarios 
		Execute dbo.Sp_Tributario_Cartera_y_Cuentas			@dFecha

	DECLARE @iStatus	INT

	EXECUTE @iStatus = dbo.Sp_Tributarios_LeeForward	@dFecha

	IF @iStatus <> 0
		SELECT -1, 'Error en la lectura de Forward'
	ELSE
		PRINT 'Lectura de Forward OK'

	EXECUTE @iStatus = dbo.Sp_Tributarios_LeeSwap		@dFecha

	IF @iStatus <> 0
		SELECT -1, 'Error en la lectura de Swap'
	ELSE
		PRINT 'Lectura de Swap OK'

	EXECUTE @iStatus = dbo.Sp_Tributarios_LeeOpciones	@dFecha

	IF @iStatus <> 0
		SELECT -1, 'Error en la lectura de Opciones'
	ELSE
		PRINT 'Lectura de Opciones OK'

	DROP TABLE dbo.Tmp_Cuentas_Tributarios

	UPDATE BacparamSuda.dbo.TBL_TRIBUTARIOS
		SET nMontoSaldoAvrTermino = nMontoCaja + nMontoPatrimonio + nMontoResultado + nMontoLiquidacion

END
GO
