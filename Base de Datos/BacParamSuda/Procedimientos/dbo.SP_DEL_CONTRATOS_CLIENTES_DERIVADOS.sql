USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_CONTRATOS_CLIENTES_DERIVADOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEL_CONTRATOS_CLIENTES_DERIVADOS]	(	@Sistema	CHAR(10)
							,	@Rutcli		NUMERIC(9,0)	= 0
							,	@CodCli		INTEGER		= 0
							)
AS 
BEGIN

	SET NOCOUNT ON

	DELETE	TBL_CLIENTE_CONTRATO_DERIVADOS
	WHERE	Cod_Sistema	= @Sistema
	AND	(Rut_Cliente	= @Rutcli	OR @Rutcli = 0)
	AND	(Codigo_Cliente	= @CodCli	OR @CodCli = 0)

	SET NOCOUNT OFF
END
GO
