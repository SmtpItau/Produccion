USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_REL_USU_CART_FIN]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_REL_USU_CART_FIN]	(	@Usuario	CHAR(15)	= ''
					,	@Sistema	CHAR(05)	= ''
					,	@Producto	CHAR(05)	= ''
					,	@Codigo_Cart	CHAR(10)	= ''
					)
AS
BEGIN

	SET NOCOUNT ON 

	SELECT	Ucf_Usuario
	,	Ucf_Sistema
	,	Ucf_Producto
	,	Ucf_Codigo_Cart
	,	Ucf_Default
	FROM	TBL_REL_USU_CART_FINANCIERA
	WHERE	(Ucf_Usuario		= @Usuario	OR @Usuario	= '')
	AND	(Ucf_Sistema		= @Sistema	OR @Sistema	= '')
	AND	(Ucf_Producto		= @Producto	OR @Producto	= '')
	AND	(Ucf_Codigo_Cart	= @Codigo_Cart	OR @Codigo_Cart	= '')

	SET NOCOUNT OFF

END
GO
