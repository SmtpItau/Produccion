USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCLEERCODIGO_VOLCKER_RULE]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_MDRCLEERCODIGO_VOLCKER_RULE]		(	
							@ncodpro					CHAR(5)
						,	@Id_Sistema				    CHAR(3)
						,	@Cat_Cartera_VolckerRule	CHAR(10)
						)
AS
BEGIN
	SET NOCOUNT ON 

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> MANTENEDOR CARTERA VOLCKER RULE**/
/***********************************************************************/
/*SISTEMA: BACPARAMETROS */



	SELECT	tcvr.Id_Cartera_VR     
	,      	tgd.TBGLOSA  
		FROM	TBL_CARTERA_PRODUCTO_VOLCKER_RULE tcvr with(nolock)
	inner join 	TABLA_GENERAL_DETALLE  tgd with(nolock)
	on tgd.tbcodigo1 = tcvr.Id_Cartera_VR
	and tgd.tbcateg = @Cat_Cartera_VolckerRule
	WHERE	Id_Sistema	= @Id_Sistema 
	AND	(Id_Producto	= @ncodpro or @ncodpro = '')
	AND	tbcateg			= @Cat_Cartera_VolckerRule		
	
	ORDER 
	BY	Id_Cartera_VR

   SET NOCOUNT OFF
END

GO
