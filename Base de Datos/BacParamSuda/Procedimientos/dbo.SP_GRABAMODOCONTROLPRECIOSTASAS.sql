USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAMODOCONTROLPRECIOSTASAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAMODOCONTROLPRECIOSTASAS]
	(
		@modo CHAR(1)='N'
	)
AS
BEGIN
	SET NOCOUNT ON
	IF NOT EXISTS(SELECT ModoOperacion FROM BacParamsuda..Parametros_ControlPreciosTasas WHERE codModulo = '*')
	BEGIN
		INSERT INTO BacParamsuda..Parametros_ControlPreciosTasas
		VALUES('*',@modo)
	END
	ELSE
	BEGIN
		UPDATE BacParamsuda..Parametros_ControlPreciosTasas
		SET ModoOperacion = @modo
		WHERE codModulo = '*'
	END
	SET NOCOUNT OFF
END
GO
