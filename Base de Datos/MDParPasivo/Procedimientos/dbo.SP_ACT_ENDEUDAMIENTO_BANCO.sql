USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_ENDEUDAMIENTO_BANCO]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACT_ENDEUDAMIENTO_BANCO]
						(
						@Rut_Cliente		NUMERIC(10)	,
						@Codigo_Cliente		NUMERIC(10)	,
						@Digito_Cliente		CHAR(01)	,
						@Nombre_Cliente		CHAR(100)	,
						@Monto_Inte1446		FLOAT		,
						@Monto_Derivado		FLOAT		,
						@Monto_DivPend 		FLOAT		,
						@Monto_VentaPac		FLOAT		,
						@Monto_Total		FLOAT		,
						@Margen_Indiv		FLOAT		,
						@Monto_Dispo		FLOAT
						)

AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


	INSERT LINEA_ENDEUDAMIENTO_BANCO
		(
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
		)
	VALUES
		(
			@Rut_Cliente	,
			@Codigo_Cliente	,
			@Digito_Cliente	,
			@Nombre_Cliente	,
			@Monto_Inte1446	,
			@Monto_Derivado	,
			@Monto_DivPend 	,
			@Monto_VentaPac	,
			@Monto_Total	,
			@Margen_Indiv	,
			@Monto_Dispo	,
			0		,
			0		,
			''
		)

END






GO
