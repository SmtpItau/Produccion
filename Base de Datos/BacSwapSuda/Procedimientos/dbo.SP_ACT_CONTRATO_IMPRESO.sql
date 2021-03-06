USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CONTRATO_IMPRESO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ACT_CONTRATO_IMPRESO]	(	@Rut_Cliente		NUMERIC(9,0)	
					,	@Cod_Cliente		INTEGER	
					,	@Num_Oper		NUMERIC(9,0)
					,	@Cod_Dcto_Fisico	CHAR(10)	
					,	@Cod_Dcto		CHAR(10)	
					,	@Rut_ApoderadoBco1	NUMERIC(9,0)	
					,	@Rut_ApoderadoBco2	NUMERIC(9,0)	
					,	@Rut_ApoderadoCli1	NUMERIC(9,0)	
					,	@Rut_ApoderadoCli2	NUMERIC(9,0)	
					,	@Cantidad_Avales	INTEGER	
					,	@ConceptoDcto		CHAR(10)
					)
AS
BEGIN

	SET NOCOUNT ON
	
	INSERT TBL_CONTRATO_IMPRESO
	(	Rut_Cliente	
	,	Cod_Cliente	
	,	Num_Oper	
	,	Fecha_Impresion	
	,	Hora_Impresion	
	,	Cod_Dcto_Fisico	
	,	Cod_Dcto	
	,	Rut_ApoderadoBco1
	,	Rut_ApoderadoBco2
	,	Rut_ApoderadoCli1
	,	Rut_ApoderadoCli2
	,	Numero_Avales
	,	Categoria_Dcto
	)
	VALUES
	(	@Rut_Cliente
	,	@Cod_Cliente
	,	@Num_Oper
	,	CONVERT(CHAR(8),GETDATE(),112)
	,	CONVERT(CHAR(8),GETDATE(),108)
	,	@Cod_Dcto_Fisico
	,	@Cod_Dcto
	,	@Rut_ApoderadoBco1
	,	@Rut_ApoderadoBco2
	,	@Rut_ApoderadoCli1
	,	@Rut_ApoderadoCli2
	,	@Cantidad_Avales
	,	@ConceptoDcto
	)

	SET NOCOUNT OFF

END

GO
