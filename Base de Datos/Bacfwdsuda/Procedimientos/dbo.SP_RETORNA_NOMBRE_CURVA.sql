USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_NOMBRE_CURVA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_RETORNA_NOMBRE_CURVA]
(
	@nProducto	INT,
	@nMoneda	INT,
	@cCodigoCurva	VARCHAR(20) OUTPUT
)
AS

BEGIN
	SELECT @cCodigoCurva = CodigoCurva FROM bacparamsuda..curvas_producto 
	WHERE Modulo = 'BFW'
	AND producto	= @nProducto
	AND Moneda	= @nMoneda
END 

GO
