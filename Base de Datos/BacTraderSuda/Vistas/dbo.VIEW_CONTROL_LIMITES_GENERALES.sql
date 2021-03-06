USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CONTROL_LIMITES_GENERALES]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_CONTROL_LIMITES_GENERALES]
AS
	SELECT	Codigo_Tipo_Limite	,
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
		Codigo_Cliente		,
		id_sistema
	FROM bacparamsuda..CONTROL_LIMITES_GENERALES

GO
