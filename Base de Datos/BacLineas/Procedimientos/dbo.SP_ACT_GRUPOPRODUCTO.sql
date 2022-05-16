USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_GRUPOPRODUCTO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_GRUPOPRODUCTO]
	(	
		@grupo		CHAR(5)		,
		@glosa		CHAR(35)	,
		@sistema	CHAR(3)		,
		@producto	CHAR(5)
	)
AS
BEGIN
	
	SET NOCOUNT ON

	INSERT INTO GRUPO_PRODUCTO
	SELECT	@grupo		,
		@sistema	,
		@producto	,
		@glosa

	SET NOCOUNT OFF

END

GO
