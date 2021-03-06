USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_PATRIMONIO_GRABA_CUENTAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNT_PATRIMONIO_GRABA_CUENTAS]
	(	@Fecha		DATETIME
	,	@Origen		VARCHAR(5)
	,	@Contrato	NUMERIC(21)
	,	@Cuenta		VARCHAR(20)
	,	@Ajuste		NUMERIC(21,4)
	)
AS
BEGIN
	
	IF EXISTS( SELECT 1 FROM dbo.TBL_PATRIMONIO WHERE	Fecha		= @Fecha
												AND		Origen		= @Origen
												AND		Contrato	= @Contrato	
												AND		Cuenta		= @Cuenta)
	BEGIN
		
		DELETE FROM	dbo.TBL_PATRIMONIO
			  WHERE	Fecha		= @Fecha
				AND	Origen		= @Origen
				AND	Contrato	= @Contrato
				AND	Cuenta		= @Cuenta
	END
	
	
	INSERT INTO dbo.TBL_PATRIMONIO
	(	Fecha
	,	Origen
	,	Contrato
	,	Cuenta
	,	Ajuste
	)
	VALUES
	(	@Fecha
	,	@Origen
	,	@Contrato
	,	@Cuenta
	,	@Ajuste
	)

END
GO
