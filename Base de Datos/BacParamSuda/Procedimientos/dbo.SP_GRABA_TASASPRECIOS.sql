USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_TASASPRECIOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_TASASPRECIOS]
(
 @cCodSistema 		CHAR(3)
,@cCodProducto 	VARCHAR(5)
,@cMoneda 		VARCHAR(5) = ''
,@nVolatilidad 		NUMERIC(19, 4) = 0
,@cFamilia 		VARCHAR(5) = ''
,@cCodCurva 		VARCHAR(20) = ''
,@iPlazoDesde 		INTEGER = 0
,@iPlazoHasta 		INTEGER = 0
,@nRangoDesde 	NUMERIC(19, 4) =0
,@nRangoHasta 	NUMERIC(19, 4) =0

)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @cTipoMdaFam AS CHAR(1)

	SET @cTipoMdaFam = NULL

	IF @cCodSistema='BTR' OR @cCodSistema='BEX'
	BEGIN
		IF LTRIM(RTRIM(@cFamilia)) <> ''
		BEGIN
			SET @cMoneda = @cFamilia
			SET @cTipoMdaFam = 'F'
		END
		ELSE	SET @cTipoMdaFam = 'M'
	
	END 
	IF @cCodSistema = 'BCC'
		SET @cTipoMdaFam = 'M'


	INSERT INTO Bacparamsuda.dbo.Tbl_Mantenedores_TasasPrecios
	(
	 codSistema
	,codProducto
	,codMonFam
	,tipoMonFam
	,RangoDesde
	,RangoHasta
	,PlazoDesde
	,PlazoHasta
	,codCurva
	,Volatilidad
	)
	VALUES
	( 
	  @cCodSistema
	, @cCodProducto 
	, @cMoneda 
	, @cTipoMdaFam
	, @nRangoDesde 
	, @nRangoHasta
	, @iPlazoDesde 
	, @iPlazoHasta 
	, @cCodCurva 
	, @nVolatilidad 
	)
	
	IF @@ERROR <> 0
	 SELECT 'Error'
	ELSE
	 SELECT 'OK'
	

	SET NOCOUNT OFF
END
GO
