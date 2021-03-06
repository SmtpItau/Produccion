USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DET_BLOQUEOS_CLIENTES_OPT]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DET_BLOQUEOS_CLIENTES_OPT]
	(
		 @bCliente		NUMERIC(9,0)
		,@bCodigo		INTEGER 
		,@descMotivo	VARCHAR(70) OUTPUT
	)	
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT rutCliente FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES
			WHERE rutCliente = @bCliente AND codCliente = @bCodigo AND blqOpciones = 'S')
		SELECT 	@descMotivo = mb.descMotivo
		FROM BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES bc
		INNER JOIN BacParamsuda.dbo.CLIENTE cl ON rutCliente = cl.Clrut AND codCliente = cl.Clcodigo
		INNER JOIN BacParamsuda.dbo.TBL_MOTIVOS_BLOQUEOCLIENTES mb  ON mb.codMotivo = bc.codMotivo
		WHERE rutCliente = @bCliente
		AND codCliente = @bCodigo
	ELSE
		SELECT 	@descMotivo = ''
	
	SET NOCOUNT OFF
END
GO
