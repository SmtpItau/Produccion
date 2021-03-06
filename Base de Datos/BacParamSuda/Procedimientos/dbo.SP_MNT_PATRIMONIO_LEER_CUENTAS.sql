USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_PATRIMONIO_LEER_CUENTAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNT_PATRIMONIO_LEER_CUENTAS]
	(	@dFecha		DATETIME	)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT  Fecha
		,	Origen
		,	Contrato
		,	Cuenta
		,	Ajuste
		,	Puntero	= ROW_NUMBER() OVER (ORDER BY Fecha)
	FROM	dbo.TBL_PATRIMONIO	with(nolock)
	WHERE	Fecha = @dFecha	

END
GO
