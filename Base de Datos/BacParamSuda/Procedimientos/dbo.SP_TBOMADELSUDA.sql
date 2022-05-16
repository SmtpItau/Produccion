USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TBOMADELSUDA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_TBOMADELSUDA]
AS 
BEGIN
	SET NOCOUNT ON
	SELECT   codi_opera 
		,conc_opera 
		,op_concep 
	  FROM  tbomadelsuda 
	ORDER BY codi_opera
	SET NOCOUNT OFF
END
GO
