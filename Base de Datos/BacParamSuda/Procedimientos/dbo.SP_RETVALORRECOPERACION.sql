USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETVALORRECOPERACION]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETVALORRECOPERACION]
	(	@codSistema CHAR(3),
		@numOperacion NUMERIC(9)
	)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @valorRec FLOAT,
		     @tipoCambio FLOAT	

	SELECT @valorRec = ISNULL( (SELECT TOP 1 ISNULL(MontoOriginal, 0.0)
				FROM BacLineas.dbo.LINEA_TRANSACCION
				WHERE Id_Sistema = @codSistema AND
				NumeroOperacion  = @numOperacion), 0.0)
	
	SELECT @valorRec AS 'ValorREC'
END	
GO
