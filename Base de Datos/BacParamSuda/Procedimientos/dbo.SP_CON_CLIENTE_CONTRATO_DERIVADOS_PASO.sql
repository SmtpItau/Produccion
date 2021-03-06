USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CLIENTE_CONTRATO_DERIVADOS_PASO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_CLIENTE_CONTRATO_DERIVADOS_PASO]	(	@Cod_Sistema	CHAR(10)	= ''
							,	@Rut_Cliente	NUMERIC(9,0)	= 0
							,	@Codigo_Cliente	INTEGER		= 0
							,	@Cod_Dcto_Princ CHAR(10)	= ''
							)
AS
BEGIN

	SET NOCOUNT ON
	
	SELECT	Rut_Cliente
	,	Codigo_Cliente 
	,	Cod_Sistema
	,	Cod_Dcto_Princ
	,	Codigo
	,	CLI.Cldv			AS DV_Rut
	,	LTRIM(RTRIM(CLI.Clnombre))	AS Nombre_Cli
	FROM	TBL_CLIENTE_CONTRATO_DERIVADOS	LEFT JOIN CLIENTE			CLI
						ON	CLI.Clrut	= Rut_Cliente
						AND	CLI.Clcodigo	= Codigo_Cliente
	WHERE	(Cod_Sistema	= @Cod_Sistema		OR @Cod_Sistema		= '')
	AND	(Rut_Cliente	= @Rut_Cliente		OR @Rut_Cliente		= 0 )
	AND	(Codigo_Cliente	= @Codigo_Cliente	OR @Codigo_Cliente	= 0 )
	AND	(Cod_Dcto_Princ = @Cod_Dcto_Princ	OR @Cod_Dcto_Princ	= '')
        AND     (Rut_Cliente    = 99500410)
	ORDER BY Cod_Sistema
	,	 Rut_Cliente
	,	 Codigo_Cliente
	,	 Cod_Dcto_Princ
	,	 Codigo

	SET NOCOUNT OFF
END
GO
