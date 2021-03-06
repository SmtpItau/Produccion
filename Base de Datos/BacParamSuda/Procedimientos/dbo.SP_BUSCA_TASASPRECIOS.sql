USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_TASASPRECIOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_TASASPRECIOS]
 	 @cCodSistema 	CHAR(3)
	,@cCodProducto 	VARCHAR(5)
	,@cMoneda 	VARCHAR(5)=''
	,@cCodFamilia 	VARCHAR(5)
	,@cCodCurva 	VARCHAR(20)

AS
BEGIN
	IF @cCodSistema = 'BTR' or @cCodSistema = 'BEX' 
	BEGIN	
		SELECT   PlazoDesde  
			,PlazoHasta  
			,Volatilidad            
		FROM TBL_MANTENEDORES_TASASPRECIOS
		WHERE codSistema = @cCodSistema
		AND codProducto  = @cCodProducto
		AND codMonFam = CASE WHEN @cCodProducto IN ('VP','CP','VPX','CPX') THEN @cCodFamilia ELSE @cMoneda END
		AND tipoMonFam = CASE WHEN @cCodProducto IN ('VP','CP','VPX','CPX') THEN 'F' ELSE 'M' END
		AND codCurva   = @cCodCurva
		ORDER BY PlazoDesde
	END

	IF @cCodSistema = 'PCS'
	BEGIN
		SELECT   
			  PlazoDesde  
			,PlazoHasta  
			,RangoDesde            
			,RangoHasta
			,Volatilidad            
		FROM TBL_MANTENEDORES_TASASPRECIOS
		WHERE codSistema = @cCodSistema
		AND codProducto  = @cCodProducto
		ORDER BY PlazoDesde
	END

	IF @cCodSistema = 'BCC' 
	BEGIN
		SELECT   Volatilidad            
		FROM TBL_MANTENEDORES_TASASPRECIOS
		WHERE codSistema = @cCodSistema
		AND codProducto  = @cCodProducto
		AND codMonFam    = @cMoneda
		ORDER BY PlazoDesde
	END

	IF @cCodSistema = 'BFW'
	BEGIN
		SELECT    PlazoDesde  
 			 ,PlazoHasta  
		 	 ,Volatilidad   
		FROM TBL_MANTENEDORES_TASASPRECIOS
		WHERE codSistema = @cCodSistema
		AND codProducto  = @cCodProducto
		AND codMonFam    = @cMoneda
		ORDER BY PlazoDesde
	END
		

END
GO
