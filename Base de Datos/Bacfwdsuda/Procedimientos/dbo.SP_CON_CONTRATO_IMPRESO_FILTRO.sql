USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CONTRATO_IMPRESO_FILTRO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_CONTRATO_IMPRESO_FILTRO]	(	@Rut_Cliente		NUMERIC(9,0)	= -999
						,	@Cod_Cliente		INT		= -999
						,	@Fecha_Impresion	DATETIME	= ''
						,	@NombreCliente		CHAR(40)	= ''
						)
AS
BEGIN

	SET NOCOUNT ON

	
	SELECT	DISTINCT 
		Rut_Cliente	
	,	Cod_Cliente	
	,	Num_Oper	
	,	CONVERT(CHAR(8),Fecha_Impresion,112)
	,	Hora_Impresion	
	,	CLI.Clnombre
	,	CLI.Cldv
	,	Rut_ApoderadoBco1
	,	Rut_ApoderadoBco2
	,	Rut_ApoderadoCli1
	,	Rut_ApoderadoCli2
	,	Numero_Avales
	,	'DESCRIPCION_CATEGORIA'	= CASE (SELECT Categoria_Dcto 
						FROM	BACPARAMSUDA..TBL_DCTOS_CONTRATOS_DERIVADOS 
						WHERE	Codigo	= Cod_Dcto_Fisico 
						AND	Sistema	= 'BFW')
							WHEN 'Cond_Gral'	THEN 'CONDICIONES GENERALES'
							WHEN 'Espec_Prod'	THEN 'CONTRATOS ESPECIFICOS'
							WHEN 'Promesas'		THEN 'PROMESA'
					  END
	,	'Codigo_Categoria'	= (SELECT Categoria_Dcto 
						FROM	BACPARAMSUDA..TBL_DCTOS_CONTRATOS_DERIVADOS 
						WHERE	Codigo	= Cod_Dcto_Fisico 
						AND	Sistema	= 'BFW')


  

	FROM	TBL_CONTRATO_IMPRESO	 
	,	BACPARAMSUDA..CLIENTE CLI
	WHERE	(Rut_Cliente		= @Rut_Cliente		OR @Rut_Cliente		= -999	)
	AND	(Cod_Cliente		= @Cod_Cliente		OR @Cod_Cliente		= -999	)
	AND	(Fecha_Impresion	= @Fecha_Impresion	OR @Fecha_Impresion	= ''	)
	AND	(CLI.Clrut		= Rut_Cliente
	AND	CLI.Clcodigo		= Cod_Cliente)
	AND	(CLI.Clnombre		>=@NombreCliente	OR @NombreCliente 	= ''    )
	ORDER
	BY	CONVERT(CHAR(8),Fecha_Impresion,112)
	,	Hora_Impresion
	,	Rut_Cliente
	,	Cod_Cliente

	SET NOCOUNT OFF

END

GO
