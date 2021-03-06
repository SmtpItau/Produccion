USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_ACTUALIZA_LIMITE_CONCENTRACION_AN]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_ACTUALIZA_LIMITE_CONCENTRACION_AN] 
( 		@SERIE_PAPEL    CHAR(20),
		@NOMINAL_PAPEL 	FLOAT   ,
		@PRODUCTO	CHAR(5) ,
		@EMISOR		NUMERIC(09)
)
AS BEGIN
/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/

SET NOCOUNT ON

	DECLARE @DISPONIBLE 	FLOAT		,
		@OUTSTANDING	FLOAT		,
		@RESULTADO	FLOAT		,
		@CODIGO_SERIE	NUMERIC(5)
		
	EXEC SP_TARE_CODIGO_SERIE @SERIE_PAPEL, @CODIGO_SERIE OUTPUT

	IF @PRODUCTO = 'CP'
	BEGIN

		UPDATE 	view_LIMITE_CONCENTRACION
		SET  Outstanding = Outstanding - @NOMINAL_PAPEL
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR

		UPDATE 	view_LIMITE_CONCENTRACION
		SET  Outstandig_Total = Outstanding + Outstanding_Filial
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR

		UPDATE 	view_LIMITE_CONCENTRACION
		SET  disponible = Monto_Limite - Outstandig_Total
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR
	
	END	

	IF @PRODUCTO = 'VP'
	BEGIN
		UPDATE 	view_LIMITE_CONCENTRACION
		SET  Outstanding = Outstanding + @NOMINAL_PAPEL
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR

		UPDATE 	view_LIMITE_CONCENTRACION
		SET  Outstandig_Total = Outstanding + Outstanding_Filial
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR

		UPDATE 	view_LIMITE_CONCENTRACION
		SET  disponible = Monto_Limite - Outstandig_Total
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR
	END	


	SELECT Outstandig_Total , disponible FROM view_LIMITE_CONCENTRACION WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR

SET NOCOUNT OFF

END

GO
