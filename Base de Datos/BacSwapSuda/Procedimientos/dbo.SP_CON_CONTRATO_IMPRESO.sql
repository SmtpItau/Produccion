USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CONTRATO_IMPRESO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_CONTRATO_IMPRESO]	(	@Rut_Cliente		NUMERIC(9,0)	= -999
					,	@Cod_Cliente		INTEGER		= -999
					,	@Num_Oper		NUMERIC(9,0)	= -999
					,	@Fecha_Impresion	DATETIME	= ''
					,	@Hora_Impresion		CHAR(8)		= ''
					,	@Cod_Dcto_Fisico	CHAR(10)	= ''
					,	@Cod_Dcto		CHAR(10)	= ''
					,	@ConceptoDcto		CHAR(10)	= ''
					)
AS
BEGIN

	SET NOCOUNT ON
	
	SELECT	CIM.Rut_Cliente	
	,	CIM.Cod_Cliente	
	,	CIM.Num_Oper	
	,	CONVERT(CHAR(8),CIM.Fecha_Impresion,112)
	,	CIM.Hora_Impresion	
	,	CIM.Cod_Dcto_Fisico	
	,	CIM.Cod_Dcto	
	,	CIM.Rut_ApoderadoBco1
	,	CIM.Rut_ApoderadoBco2
	,	CIM.Rut_ApoderadoCli1
	,	CIM.Rut_ApoderadoCli2
	,	CIM.Numero_Avales
	,	'Nombre_ApoderadoBco1'	= (SELECT apnombre FROM BACPARAMSUDA..CLIENTE_APODERADO APOC
						WHERE 	APOC.aprutcli	= CIM.Rut_Cliente
						AND	APOC.apcodcli	= CIM.Cod_Cliente
						AND	APOC.aprutapo	= CIM.Rut_ApoderadoBco1)
	,	'Nombre_ApoderadoBco2'	= (SELECT apnombre FROM BACPARAMSUDA..CLIENTE_APODERADO APOC
						WHERE 	APOC.aprutcli	= CIM.Rut_Cliente
						AND	APOC.apcodcli	= CIM.Cod_Cliente
						AND	APOC.aprutapo	= CIM.Rut_ApoderadoBco2)
	,	'Nombre_ApoderadoCli1'	= (SELECT apnombre FROM BACPARAMSUDA..CLIENTE_APODERADO APOC
						WHERE 	APOC.aprutcli	= CIM.Rut_Cliente
						AND	APOC.apcodcli	= CIM.Cod_Cliente
						AND	APOC.aprutapo	= CIM.Rut_ApoderadoCli1)
	,	'Nombre_ApoderadoCli2'	= (SELECT apnombre FROM BACPARAMSUDA..CLIENTE_APODERADO APOC
						WHERE 	APOC.aprutcli	= CIM.Rut_Cliente
						AND	APOC.apcodcli	= CIM.Cod_Cliente
						AND	APOC.aprutapo	= CIM.Rut_ApoderadoCli2)
	FROM	TBL_CONTRATO_IMPRESO	CIM	
	WHERE	(CIM.Rut_Cliente	= @Rut_Cliente		OR @Rut_Cliente		= -999	)
	AND	(CIM.Cod_Cliente	= @Cod_Cliente		OR @Cod_Cliente		= -999	)
	AND	(CIM.Num_Oper		= @Num_Oper		OR @Num_Oper		= -999	)
	AND	(CIM.Fecha_Impresion	= @Fecha_Impresion	OR @Fecha_Impresion	= ''	)
	AND	(CIM.Hora_Impresion	= @Hora_Impresion	OR @Hora_Impresion	= ''	)
	AND	(CIM.Cod_Dcto_Fisico	= @Cod_Dcto_Fisico	OR @Cod_Dcto_Fisico	= ''	)
	AND	(CIM.Cod_Dcto		= @Cod_Dcto		OR @Cod_Dcto		= ''	)
	AND	(CIM.Categoria_Dcto	= @ConceptoDcto		OR @ConceptoDcto	= ''	)
	ORDER
	BY	CIM.Fecha_Impresion
	,	CIM.Hora_Impresion
	,	CIM.Rut_Cliente
	,	CIM.Cod_Cliente

	SET NOCOUNT OFF

END
GO
