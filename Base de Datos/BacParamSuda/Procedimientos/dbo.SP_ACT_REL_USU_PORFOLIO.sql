USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_REL_USU_PORFOLIO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_REL_USU_PORFOLIO]	(	@Usuario		CHAR(15)	
					,	@Codigo_Porfolio	CHAR(10)
					,	@Default		CHAR(1)
					)
AS
BEGIN

	SET NOCOUNT ON 

	INSERT INTO 	TBL_REL_USU_PORFOLIO
	(		
		Upf_Usuario
	,	Upf_Codigo_Porfolio
	,	Upf_Default
	)
	VALUES (
	
		@Usuario	
	,	@Codigo_Porfolio
	,	@default	
	)

	SET NOCOUNT OFF

END
GO
