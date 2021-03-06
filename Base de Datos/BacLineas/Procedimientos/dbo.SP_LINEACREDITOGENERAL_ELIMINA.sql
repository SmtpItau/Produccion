USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_ELIMINA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_ELIMINA]
		(	@rutcliente 	NUMERIC(9)	,
			@codcliente 	NUMERIC(9)
		)
AS 
BEGIN

	SET NOCOUNT ON

	DELETE LINEA_GENERAL
	 WHERE rut_cliente    = @rutcliente
	   AND codigo_cliente = @codcliente

	SET NOCOUNT OFF
END
GO
