USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_OPPENDIENTEPRECIOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BORRA_OPPENDIENTEPRECIOS]
(
	@codSistema 	CHAR(3),
	@codProducto 	CHAR(5),
	@NumOp	NUMERIC(9)
)
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM BacLineas..LINEA_TRANSACCION_DETALLE
	WHERE NumeroOperacion = @NumOp
	AND Id_Sistema = @codSistema
	AND Linea_Transsaccion = 'CTRLPR')
		DELETE FROM BacLineas..LINEA_TRANSACCION_DETALLE
		WHERE NumeroOperacion = @NumOp
		AND Id_Sistema = @codSistema
		AND Linea_Transsaccion = 'CTRLPR'
	
	IF @@ERROR <> 0
		SELECT 'NO'
	ELSE
		SELECT 'OK'

END
GO
