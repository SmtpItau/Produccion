USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_PLAN_DE_CUENTA]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE VIEW [dbo].[VIEW_PLAN_DE_CUENTA]
AS  
SELECT  cuenta,
	descripcion,
	glosa,
	tipo_cuenta,
	cuenta_imputable,
	con_correccion,
	con_centro_costo,
	tipo_moneda,
	prod_asoc,
	cta_sbif,
	tipo_saldo,
	tipo_relacion
FROM BACPARAMSUDA..PLAN_DE_CUENTA





GO
