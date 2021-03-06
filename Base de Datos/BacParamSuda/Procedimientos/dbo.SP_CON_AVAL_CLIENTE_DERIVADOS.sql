USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_AVAL_CLIENTE_DERIVADOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_AVAL_CLIENTE_DERIVADOS]	(	@Rut_Cliente	NUMERIC(9,0)	= -999
						,	@Cod_Cliente	INTEGER		= -999
						,	@Rut_Aval	NUMERIC(9,0)	= -999
						)
AS
BEGIN
	
	SET NOCOUNT ON

	SELECT	Rut_Cliente
	,	Cod_Cliente
	,	Rut_Aval
	,	DV_Aval
	,	Nombre_Aval
	,	Razon_Social_Aval
	,	Profesion_Aval
	,	Direccion_Aval
	,	Comuna_Aval
	,	Ciudad_Aval
	,	Rut_Apod_Aval_1
	,	Dv_RAA_1
	,	Nom_Apod_Aval_1
	,	Rut_Apod_Aval_2
	,	Dv_RAA_2
	,	Nom_Apod_Aval_2
	,	Regimen_Conyuga_Aval
	,	Rut_Conyuge_Aval
	,	Dv_RCA
	,	Nom_Conyuge_Aval
	,	Profesion_Conyuge_Aval
	FROM	BACPARAMSUDA..TBL_AVAL_CLIENTE_DERIVADO
	WHERE	(Rut_Cliente	= @Rut_Cliente	OR @Rut_Cliente	= -999)
	AND	(Cod_Cliente	= @Cod_Cliente	OR @Cod_Cliente	= -999)
	AND	(Rut_Aval	= @Rut_Aval	OR @Rut_Aval	= -999)

	SET NOCOUNT OFF

END
GO
