USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERFAMILIA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERFAMILIA]
AS
BEGIN
   SET NOCOUNT ON
   
	SELECT	incodigo
	,	inserie
	,	inglosa 
	FROM	INSTRUMENTO 
	WHERE	inrutemi in (97029000)
   
   SET NOCOUNT OFF
END

GO
