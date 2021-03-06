USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_ENDEUDAMIENTO_BANCO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_ENDEUDAMIENTO_BANCO]

AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

	SELECT 
			rut_cliente		,
			codigo_cliente		,
			digito_cliente		,
			nombre_cliente		,
			monto_inte1446		,
			monto_derivado		,
			monto_divPend		,
			monto_ventaPac		,
			monto_total		,
			margen_indivudual	,
			monto_dispo		,
			monto_captacion		,
			monto_pasivos		,
			bloqueado		
			
	FROM  LINEA_ENDEUDAMIENTO_BANCO
	ORDER BY nombre_cliente
END



GO
