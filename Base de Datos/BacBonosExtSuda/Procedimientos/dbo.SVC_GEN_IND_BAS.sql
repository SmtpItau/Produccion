USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_IND_BAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_GEN_IND_BAS]
AS
BEGIN

	SELECT	TBCODIGO1,
		TBGLOSA
	FROM 	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbCATEG = 1101

END


GO
