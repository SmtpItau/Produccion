USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_valida_Instrum_Limites_Alco]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

	CREATE PROCEDURE [dbo].[sp_valida_Instrum_Limites_Alco] 
	( 
			@CODIGO_PAPEL	NUMERIC(10)
		,	@Emisor			NUMERIC(9)
	)		
	AS 
	BEGIN
	/* LD1-COR-035 FUSION CORPBANCA - ITAU --> VALIDACION ALCO**/

		
		DECLARE @cSiNo	Char(02)
		If Exists(Select * from view_LIMITE_CONCENTRACION Where Incodigo =  @CODIGO_PAPEL and Rut_Emisor = @Emisor)
			SELECT @cSiNo = 'SI'
		ELSE		
			SELECT @cSiNo = 'NO'
		SELECT @cSiNo
	END



GO
