USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_OPE_STG_NUM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_OPE_STG_NUM]
AS 
BEGIN

	SELECT MAX(monumoper) FROM text_mvt_dri
END


GO
