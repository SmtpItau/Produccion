USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SUB_CART_NORM]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_SUB_CART_NORM] ( @opcion			INT	= 0	,
				@Parametro1		CHAR(06)= ''	,
				@Parametro2		CHAR(06)= ''	)
				
AS
BEGIN

SET NOCOUNT ON
	
IF @OPCION = 1 BEGIN 
		SELECT 	A.tbcateg 
		,	A.tbcodigo1 
		,	A.tbtasa 
		,	A.tbfecha                     
		,	A.tbvalor              
		,	A.tbglosa                                            
		,	A.nemo       
		FROM	TABLA_GENERAL_DETALLE	A
		,	TBL_RELACIONES		B
		WHERE	A.tbcateg		= @Parametro1
		AND	A.tbcateg		= B.Rel_IdCodigo2
		AND	A.tbcodigo1		= B.Rel_IdRelacion1
		AND	B.Rel_IdCodigo1		= @Parametro2		
		ORDER 
		BY	 A.tbcodigo1

	END
SET NOCOUNT OFF

END
GO
