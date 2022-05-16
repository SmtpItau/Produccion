USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_TIPO_PERIODO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_TIPO_PERIODO]
AS
BEGIN
	SET NOCOUNT ON
	SELECT	Sistema 
	,		Tabla
	,		Codigo
	,       Glosa
	,       Dias
	,       Meses
	FROM	BacParamSuda..Periodo_Amortizacion
	WHERE	Tabla=1044 
	AND		Sistema = 'pcs'

END
SET NOCOUNT OFF
GO
