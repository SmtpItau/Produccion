USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETCURVA_CONTROL_PRECIOTASAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_RETCURVA_CONTROL_PRECIOTASAS]
(	 @codModulo	CHAR(3)
	,@codProducto	VARCHAR(5)
	,@codMoneda	VARCHAR(5)
	,@codCurva	VARCHAR(20) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON

	SELECT @codCurva = a.CodigoCurva
	FROM CURVAS_PRODUCTO a,
	DEFINICION_CURVAS b
	WHERE a.Modulo = @codModulo
	AND a.Producto = @codProducto
	AND a.Moneda   = CONVERT(INT,@codMoneda)
	AND a.CodigoCurva = b.CodigoCurva
---	AND a.TipoTasa = 'N'
END
GO
