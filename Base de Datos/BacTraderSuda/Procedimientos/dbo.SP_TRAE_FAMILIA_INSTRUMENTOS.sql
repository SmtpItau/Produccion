USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_FAMILIA_INSTRUMENTOS]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_FAMILIA_INSTRUMENTOS]
                                
AS
BEGIN
SET NOCOUNT ON
 
	SELECT incodigo
		,inserie 
	FROM VIEW_INSTRUMENTO (NOLOCK)
    
    RETURN

SET NOCOUNT OFF
END
GO
