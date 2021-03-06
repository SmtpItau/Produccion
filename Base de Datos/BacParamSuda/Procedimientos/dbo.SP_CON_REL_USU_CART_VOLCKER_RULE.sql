USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_REL_USU_CART_VOLCKER_RULE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CON_REL_USU_CART_VOLCKER_RULE]	
(						@Usuario	CHAR(15)	= ''
					,	@Sistema	CHAR(05)	= ''
					,	@Producto	CHAR(05)	= ''
					,	@Codigo_Cart	CHAR(10)	= ''
					)
AS
BEGIN

	SET NOCOUNT ON 

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> MANTENEDOR USUARIO - CARTERA **/
/***********************************************************************/
/*SISTEMA: BACPARAMETROS */



	SELECT	Ucvr_Usuario
	,	Ucvr_Sistema
	,	Ucvr_Producto
	,	Ucvr_Codigo_Cart
	,	Ucvr_Default
	FROM	TBL_REL_USU_CART_VOLCKER_RULE with(nolock)
WHERE	 Ucvr_Usuario		= @Usuario
	AND	(Ucvr_Sistema		= @Sistema	OR @Sistema	= '')
	AND	(Ucvr_Producto		= @Producto	OR @Producto	= '')
	AND	(Ucvr_Codigo_Cart	= @Codigo_Cart	OR @Codigo_Cart	= '')

	SET NOCOUNT OFF

END

GO
