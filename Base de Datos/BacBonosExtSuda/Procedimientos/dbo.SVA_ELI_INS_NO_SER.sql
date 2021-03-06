USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_ELI_INS_NO_SER]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SVA_ELI_INS_NO_SER] 
	(@cod_familia	NUMERIC(5)
	,@cod_nemo		CHAR(20)
	
	)	
AS 
BEGIN

	IF EXISTS( SELECT * FROM text_rsu WHERE cod_familia = @cod_familia and cod_nemo = @cod_nemo)
	BEGIN
		SELECT 'NO', 'Existe Información Relacionado con este instrumento'
		RETURN

	END


	IF EXISTS( SELECT * FROM text_mvt_dri WHERE cod_familia = @cod_familia and cod_nemo = @cod_nemo)
	BEGIN
		SELECT 'NO', 'Existe Información Relacionado con este instrumento'
		RETURN

	END


	IF EXISTS( SELECT * FROM text_ctr_cpr WHERE cod_familia = @cod_familia and cod_nemo = @cod_nemo)
	BEGIN
		SELECT 'NO', 'Existe Información Relacionado con este instrumento'
		RETURN

	END


	DELETE text_frm 
	WHERE 	cod_familia = @cod_familia
			AND cod_nemo    = @cod_nemo	

	DELETE TEXT_DSA 
	WHERE	cod_familia = @cod_familia 	
		AND cod_nemo    = @cod_nemo

	DELETE text_ident
	WHERE	cod_nemo  = @cod_nemo

	DELETE Tbl_Clasificacion_Instrumento 
	WHERE Nemo = @cod_nemo


END


GO
