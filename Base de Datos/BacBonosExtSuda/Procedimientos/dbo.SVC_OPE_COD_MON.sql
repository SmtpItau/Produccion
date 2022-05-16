USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_OPE_COD_MON]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_OPE_COD_MON]
AS 
BEGIN
	SELECT	MNCODMON,
		MNGLOSA
	FROM 	VIEW_moneda
	ORDER	BY	MNGLOSA
END

GO
