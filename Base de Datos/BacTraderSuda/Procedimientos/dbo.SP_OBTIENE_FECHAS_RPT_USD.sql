USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTIENE_FECHAS_RPT_USD]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_OBTIENE_FECHAS_RPT_USD]

AS

BEGIN

	SELECT acfecproc,
	       acfecprox 
	  FROM mdac


END
GO
