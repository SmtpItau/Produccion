USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GrbMfca_findur]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_GrbMfca_findur]
(
	@Fecha_proceso		AS DATETIME,
	@Sistema			AS CHAR(3),
	@Producto			AS CHAR(4),
	@Numero_operacion	AS NUMERIC(10),
	@Monto				AS FLOAT,
	@Rut_contraparte	AS CHAR(15),
	@Codigo_cliente		AS NUMERIC(5),
	@Monto_Garantias	AS FLOAT,
	@Tipo_operación 	AS CHAR(1),
	@Tipo_negocio 		AS NUMERIC(5),
	@Tipo_porcentaje 	AS NUMERIC(5),
	@Fecha_vencimiento	AS DATETIME,
	@MTM_proyectado		AS FLOAT
)
AS
BEGIN
	SET NOCOUNT OFF

	INSERT INTO [dbo].[mfca_findur](
		[Fecha_proceso]		,
		[Sistema] 			,
		[Producto] 			,
		[Numero_operación] 	,
		[Monto]				,
		[Rut_Contraparte]	,
		[Codigo_cliente]	,
		[Monto_Garantias] 	,
		[Tipo_operación] 	,
		[Tipo_negocio] 		,
		[Tipo_porcentaje] 	,
		[Fecha_vencimiento]	,
		[MTM_proyectado])
	SELECT 
		@Fecha_proceso		,
		@Sistema			,
		@Producto			,
		@Numero_operacion	,
		@Monto				,
		@Rut_contraparte	,
		@Codigo_cliente		,
		@Monto_Garantias	,
		@Tipo_operación 	,
		@Tipo_negocio 		,
		@Tipo_porcentaje 	,
		@Fecha_vencimiento	,
		@MTM_proyectado		
	SET NOCOUNT ON;
END

GO
