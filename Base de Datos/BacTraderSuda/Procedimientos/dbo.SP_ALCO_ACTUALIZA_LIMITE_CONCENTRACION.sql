USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_ACTUALIZA_LIMITE_CONCENTRACION]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_ACTUALIZA_LIMITE_CONCENTRACION] 
( 			@SERIE_PAPEL    CHAR(20),
			@NOMINAL_PAPEL 	FLOAT   ,
			@EMISOR			NUMERIC(09)
)
AS BEGIN

SET NOCOUNT ON

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/
/***********************************************************************/

	DECLARE @CODIGO_SERIE	NUMERIC(5)
		
	EXEC SP_TARE_CODIGO_SERIE @SERIE_PAPEL, @CODIGO_SERIE OUTPUT



	/******* Incrementa el monto ocupado o Outstanding ********************/

		UPDATE 	view_LIMITE_CONCENTRACION
		SET  Outstanding = Outstanding + @NOMINAL_PAPEL
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR
	
	/***************************/

	/******** Actualiza los montos de los de Total Ocupado y Disponible *****************/
		UPDATE 	view_LIMITE_CONCENTRACION
		SET  Outstandig_Total = Outstanding + Outstanding_Filial
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR

		UPDATE 	view_LIMITE_CONCENTRACION
		SET  disponible = Monto_Limite - Outstandig_Total
		WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR
	
	/****************************/

	SELECT Outstandig_Total , disponible FROM view_LIMITE_CONCENTRACION WHERE incodigo = @CODIGO_SERIE AND Rut_Emisor = @EMISOR

SET NOCOUNT OFF

END

GO
