USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_tbomadelsuda]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_tbomadelsuda]
AS 
BEGIN

	SET NOCOUNT ON

	SELECT	codi_opera	,
		conc_opera	,
		op_concep	
	FROM 	tbomadelsuda 

	SET NOCOUNT OFF

END





GO
