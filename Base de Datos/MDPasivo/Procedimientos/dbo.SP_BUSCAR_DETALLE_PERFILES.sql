USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_DETALLE_PERFILES]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_BUSCAR_DETALLE_PERFILES]
				(
					@numero NUMERIC(10)
				)
AS 
BEGIN  
	SET DATEFORMAT DMY
	SET NOCOUNT ON

	SELECT	A.folio_perfil 
	,	A.codigo_campo 
	,	A.tipo_movimiento_cuenta 
	,	A.perfil_fijo 
	,	A.codigo_cuenta        
	,	A.correlativo_perfil 
	,	A.codigo_campo_variable 
	,	D.descripcion_campo 
	,	ISNULL(B.descripcion,'NO Existe') 
	FROM	PERFIL_DETALLE_CNT	A
			left join PLAN_DE_CUENTA		B On CONVERT(NUMERIC,ISNULL( CASE	WHEN	LTRIM(RTRIM(B.cuenta)) = '' THEN '0' 
																				ELSE	LTRIM(RTRIM(B.cuenta)) 
																			END ,0) ) = CONVERT(NUMERIC,ISNULL( CASE	WHEN LTRIM(RTRIM(A.codigo_cuenta)) = '' THEN '0' 
																														ELSE  LTRIM(RTRIM(A.codigo_cuenta)) 
																											END ,0))
	,		PERFIL_CNT		C
	,		CAMPO_CNT		D
	WHERE	A.folio_perfil		= C.folio_perfil
	AND		A.folio_perfil		= @numero
	AND		C.id_sistema 		= D.id_sistema
	AND		C.tipo_operacion	= D.tipo_operacion 
	AND		C.tipo_movimiento	= D.tipo_movimiento
   	AND		A.codigo_campo		= D.codigo_campo	
	ORDER 
	BY		A.Correlativo_perfil


END 

GO
