USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGECARGAMONEDAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_HEDGECARGAMONEDAS]	
					  					 					 					 
AS
BEGIN

SET NOCOUNT ON 

	SELECT 	mncodmon 
	,	mnnemo   
	,	mnglosa   
	FROM 	BACPARAMSUDA..MONEDA WITH(NOLOCK)
	WHERE  	MNMX ='C'
	ORDER BY mnglosa
 
		
END
SET NOCOUNT OFF

GO
