USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_REL_USUARIO_NORMATIVO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEL_REL_USUARIO_NORMATIVO]	(	@Usuario		CHAR(15)	
						,	@Sistema		CHAR(05)	= ''
						,	@Producto		CHAR(05)	= ''
						,	@Codigo_Lib		CHAR(10)	= ''
						,	@Codigo_CartN		CHAR(10)	= ''
						,	@Codigo_SubCartN	CHAR(10)	= ''
						)
AS
BEGIN

	SET NOCOUNT ON 

	DELETE	TBL_REL_USUARIO_NORMATIVO
	WHERE	 Ucn_Usuario		= @Usuario
	AND	(Ucn_Sistema		= @Sistema		OR @Sistema		= '')
	AND	(Ucn_Producto		= @Producto		OR @Producto		= '')
	AND	(Ucn_Codigo_Lib		= @Codigo_Lib		OR @Codigo_Lib		= '')
	AND	(Ucn_Codigo_CartN	= @Codigo_Lib		OR @Codigo_CartN	= '')
	AND	(Ucn_Codigo_SubCartN	= @Codigo_SubCartN	OR @Codigo_SubCartN	= '')

	SET NOCOUNT OFF

END
GO
