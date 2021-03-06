USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTENER_FXALL]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_OBTENER_FXALL] 
		(	@NumOper	    Numeric(10,0)
		,	@Sistema		VarChar(50)	
		,	@Modulo			VarChar(10)	
		)
AS 
BEGIN

SELECT	Id			
,		ReAplicacion	
,		RePantalla	    
,		ReModuloBac	    
,		ReOperacion	    
,		ReFechaApp	    
,		RefechaSys	    
FROM	TBL_REGISTRO_INGRESO_OPERACION WITH (NOLOCK)
WHERE	ReOperacion = @NumOper 
AND		rtrim(ltrim(RePantalla))  = rtrim(ltrim(@Sistema)) 
AND		rtrim(ltrim(ReModuloBac)) = rtrim(ltrim(@Modulo))

END





GO
