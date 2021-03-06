USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_REL_USU_PORFOLIO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_REL_USU_PORFOLIO]	(	@Usuario		CHAR(15)	= ''
					,	@Codigo_Porfolio	CHAR(10)	= ''
					)
AS
BEGIN

	SET NOCOUNT ON 

	SELECT	Upf_Usuario
	,	Upf_Codigo_Porfolio
	,	Upf_Default
	FROM	TBL_REL_USU_PORFOLIO
	WHERE	(Upf_Usuario		= @Usuario		OR @Usuario		= '')
	AND	(Upf_Codigo_Porfolio	= @Codigo_Porfolio	OR @Codigo_Porfolio	= '')

	SET NOCOUNT OFF

END
GO
