USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_TIP_TAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






create procedure [dbo].[SVC_GEN_TIP_TAS] 
(
   @codigo NUMERIC (3)
)
AS
BEGIN

	SELECT	TBCODIGO1,		
		TBGLOSA
	FROM 	VIEW_TABLA_GENERAL_DETALLE 
	WHERE	tbCATEG = 1042 and @codigo = tbcodigo1

END


GO
