USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_TASASPRECIOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_TASASPRECIOS]
 	 @cCodSistema 		CHAR(3)
	,@cCodProducto 		VARCHAR(5)
	,@cCodFamilia 		VARCHAR(5)
	,@cMoneda 		VARCHAR(5)=''
	,@cCodCurva 		VARCHAR(20)=''

AS
BEGIN
	-->CP - COMPRA PROPIA
	-->VP - VENTA PROPIA

	IF @cCodSistema = 'BTR' OR @cCodSistema = 'BEX'
	BEGIN	
		DELETE FROM TBL_MANTENEDORES_TASASPRECIOS
		WHERE codSistema = @cCodSistema
		AND codProducto  = @cCodProducto
		AND codMonFam = CASE WHEN @cCodProducto IN ('VP','CP','VPX','CPX') THEN @cCodFamilia ELSE @cMoneda END
		AND tipoMonFam = CASE WHEN @cCodProducto IN ('VP','CP','VPX','CPX') THEN 'F' ELSE 'M' END
		AND codCurva   = @cCodCurva
	END

	IF @cCodSistema = 'PCS'
	BEGIN	
		DELETE FROM TBL_MANTENEDORES_TASASPRECIOS
		WHERE codSistema = @cCodSistema
		AND codProducto  = @cCodProducto
	END

	IF @cCodSistema = 'BCC' OR @cCodSistema = 'BFW' 
	BEGIN	
		DELETE FROM TBL_MANTENEDORES_TASASPRECIOS
		WHERE codSistema = @cCodSistema
		AND codProducto  = @cCodProducto
		AND codMonFam    = @cMoneda
	END

END
GO
