USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_trae_omadelsuda]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_trae_omadelsuda]( @codigo   NUMERIC(2) )
AS
BEGIN

	SET NOCOUNT ON
	
		
	SELECT	conc_opera	,
		op_concep	,
		codi_oma
	FROM 	tbomadelsuda 
	WHERE 	codi_opera = @codigo 

	SET NOCOUNT OFF

END

-- SELECT * FROM tbomadelsuda






GO
