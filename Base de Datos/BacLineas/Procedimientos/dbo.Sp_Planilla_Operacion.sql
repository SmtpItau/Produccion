USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Planilla_Operacion]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Planilla_Operacion]	( 
					@condicion VARCHAR (10)
					)
AS
BEGIN

	SET NOCOUNT OFF

	SELECT 	a.comercio							,
		a.concepto							,
		ISNULL(b.glosa,"NO EXISTE CODIGO COMERCIO")			,
		a.tipo_documento						,
		a.tipo_operacion_cambio 
	FROM 	codigo_planilla_automatica 	a	, 
		codigo_comercio 		b
	WHERE 	a.condicion             = @condicion     AND
--                a.tipo_operacion_cambio = b.codigo_oma   AND              
                a.comercio              = b.codigo_relacion
	SET NOCOUNT ON

END

-- select * from codigo_planilla_automatica where condicion='VCLP1'
-- sp_planilla_operacion 'CCLP1'













GO
