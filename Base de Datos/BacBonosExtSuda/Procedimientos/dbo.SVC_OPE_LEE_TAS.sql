USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_OPE_LEE_TAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_OPE_LEE_TAS]
AS
BEGIN

	SELECT NEMO, TBTASA, tbglosa
	from	VIEW_TABLA_GENERAL_DETALLE
	where	tbCATEG = 1108
END

GO
