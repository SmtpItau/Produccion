USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETMODOCONTROLPRECIOSTASAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETMODOCONTROLPRECIOSTASAS]
		(
			@codModulo CHAR(3)='*'
		)
AS	
BEGIN	
	DECLARE @modoSalida CHAR(1)
	SET NOCOUNT ON
	/* PRD-3860, modo silencioso.  Tiene prioridad el todos (*) sobre los casos particulares */
	IF EXISTS(SELECT ModoOperacion FROM BacParamsuda.dbo.Parametros_ControlPreciosTasas
			WHERE codModulo = '*')
		SELECT @modoSalida = ModoOperacion FROM BacParamsuda.dbo.Parametros_ControlPreciosTasas WHERE codModulo = '*'
	ELSE
		SELECT @modoSalida = ModoOperacion 
		FROM BacParamsuda.dbo.Parametros_ControlPreciosTasas WHERE codModulo = @codModulo

	SELECT @modoSalida
	SET NOCOUNT OFF
END

GO
