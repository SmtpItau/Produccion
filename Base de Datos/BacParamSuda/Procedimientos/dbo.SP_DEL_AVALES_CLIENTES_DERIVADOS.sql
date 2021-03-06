USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_AVALES_CLIENTES_DERIVADOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEL_AVALES_CLIENTES_DERIVADOS](	@Rut_Cliente		numeric(9, 0)	= -999
						,	@Cod_Cliente		int		= -999
						,	@Rut_Aval		numeric(9, 0)	= -999
						)
AS
BEGIN
	SET NOCOUNT ON

	DELETE	TBL_AVAL_CLIENTE_DERIVADO
	WHERE	(Rut_Cliente	= @Rut_Cliente	OR @Rut_Cliente = -999)
	AND	(Cod_Cliente	= @Cod_Cliente	OR @Cod_Cliente = -999)
	AND	(Rut_Aval	= @Rut_Aval	OR @Cod_Cliente = -999)

	SET NOCOUNT OFF
END
GO
