USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_EMI_BUS_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_EMI_BUS_DAT]
			(@RUT		NUMERIC(9)	,
			 @DV		CHAR(1)		,
			 @COD_EMI	NUMERIC(9)	)
AS
BEGIN
SET NOCOUNT ON
	IF EXISTS(SELECT * FROM text_emi_itl 
		  WHERE @RUT = RUT_EMI 
		  AND @DV = DIGITO_VER AND CODIGO = @COD_EMI) 
	BEGIN
		SELECT	CLASIFICACION1	, 
			CLASIFICACION2	,
			tipo_corto1	,
			tipo_largo1	,
			tipo_corto2	,
			tipo_largo2     
		FROM 	text_emi_itl 
		WHERE 	@RUT = RUT_EMI 
		AND 	@DV = DIGITO_VER 
		AND 	CODIGO = @COD_EMI
	END 
SET NOCOUNT OFF
END


GO
