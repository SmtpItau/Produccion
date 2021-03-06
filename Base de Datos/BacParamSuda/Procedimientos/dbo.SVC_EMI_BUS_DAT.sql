USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_EMI_BUS_DAT]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SVC_EMI_BUS_DAT]
			(@RUT		NUMERIC(9)	,
			 @DV		CHAR(1)		,
			 @COD_EMI	NUMERIC(9)	)
AS
BEGIN
SET NOCOUNT ON
	SELECT	CLASIFICACION1	 
	,	CLASIFICACION2	
	,	tipo_corto1	
	,	tipo_largo1	
	,	tipo_corto2	
	,	tipo_largo2     
	FROM 	EMISOR				--text_emi_itl 
	WHERE 	@RUT		= emrut		--RUT_EMI 
	AND 	@DV		= emdv		--DIGITO_VER 
	AND 	@COD_EMI	= emcodigo	--CODIGO

SET NOCOUNT OFF
END
GO
