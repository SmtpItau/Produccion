USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_AYUDA_CONTRATO_IMPRESO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_AYUDA_CONTRATO_IMPRESO]	(	@Rut_Cliente		NUMERIC(9,0)	= -999
						,	@Cod_Cliente		INT		= -999
						,	@NombreCliente		CHAR(40)	= ''
						)
AS
BEGIN

	SET NOCOUNT ON

	
	SELECT	DISTINCT 
		Rut_Cliente	
	,	Cod_Cliente	
	,	CLI.Clnombre
	,	CLI.Cldv
	FROM	TBL_CONTRATO_IMPRESO	 
	,	BACPARAMSUDA..CLIENTE CLI
	WHERE	(Rut_Cliente		= @Rut_Cliente		OR @Rut_Cliente		= -999	)
	AND	(Cod_Cliente		= @Cod_Cliente		OR @Cod_Cliente		= -999	)
	AND	(CLI.Clrut		= Rut_Cliente
	AND	CLI.Clcodigo		= Cod_Cliente)
	AND	(CLI.Clnombre		>=@NombreCliente	OR @NombreCliente 	= ''    )
	ORDER	
	BY	CLI.Clnombre
	,	Rut_Cliente
	,	Cod_Cliente

	SET NOCOUNT OFF

END

GO
