USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_REL_USU_CART_VOLCKER_RULE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_DEL_REL_USU_CART_VOLCKER_RULE]	
					(	@Usuario	CHAR(15)	
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



	DELETE	TBL_REL_USU_CART_VOLCKER_RULE
	WHERE	 Ucvr_Usuario	= @Usuario
	AND	(Ucvr_Sistema		= @Sistema	OR @Sistema	= '')
	AND	(Ucvr_Producto		= @Producto	OR @Producto	= '')
	AND	(Ucvr_Codigo_Cart	= @Codigo_Cart	OR @Codigo_Cart	= '')

	
	SET NOCOUNT OFF

END

GO
