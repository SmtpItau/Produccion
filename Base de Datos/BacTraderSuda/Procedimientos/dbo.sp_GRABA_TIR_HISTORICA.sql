USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_GRABA_TIR_HISTORICA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[sp_GRABA_TIR_HISTORICA] ( 	@RUT_CIENTE NUMERIC(10)		,
					@NUMERO_DOCUMENTO NUMERIC(10)	,
					@CORRELA NUMERIC(6)		,
					@TIPO CHAR(10)
				   )
AS
 BEGIN

	IF EXISTS (SELECT cprutcli FROM MDCP WHERE @RUT_CIENTE=cprutcli AND @NUMERO_DOCUMENTO = cpnumdocu AND @CORRELA = cpcorrela)
	BEGIN
		SELECT 'GRABACION EXITOSA'
		UPDATE MDCP SET Tipo_Rentabilidad = @TIPO
		WHERE @RUT_CIENTE=cprutcli AND	@NUMERO_DOCUMENTO = cpnumdocu AND @CORRELA = cpcorrela
	END
	ELSE
	BEGIN	
		SELECT 'NO EXISTE'
	END
	
END
-- Base de Datos --
GO
