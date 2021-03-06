USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONCARTBOOKEAR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONCARTBOOKEAR]	(	@Parametro1		CHAR(15)= ''	
					,	@Parametro2		CHAR(15)= ''	
					,	@Parametro3		CHAR(15)= ''	
					,	@Parametro4		CHAR(15)= ''	
					,	@Parametro5		CHAR(15)= ''	
					)
AS
BEGIN
SET NOCOUNT ON


		SELECT	DISTINCT
			rcrut   	
		,	RCCODPRO 
		,	rcdv 
		,	rcnumcorr   
		,	tbglosa
		,	Ucf_Default
		FROM	VIEW_TIPO_CARTERA
		,	VIEW_TABLA_GENERAL_DETALLE
		,	VIEW_USU_CART_FINANCIERA --DBO.TBL_REL_USU_CART_FINANCIERA
		WHERE 	(rccodpro		= @Parametro1 OR @Parametro1 = '')
		AND	tbcateg			= @Parametro2
		AND 	rcsistema		= @Parametro3
		AND	(rcrut			= CONVERT(INT,@Parametro4) OR @Parametro4 = '')
		AND	tbcodigo1		= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
		AND	Ucf_Usuario		= @Parametro5
		AND	Ucf_Sistema		= rcsistema
		AND	Ucf_Producto		= rccodpro
		AND	Ucf_Codigo_Cart		= rcrut
		AND 	Ucf_Default 		='S'
		ORDER BY Ucf_Default	DESC


END
SET NOCOUNT OFF

GO
