USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_PRC_FIN_DIA]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_PRC_FIN_DIA]
AS 
BEGIN

	SET NOCOUNT ON

	UPDATE	text_arc_ctl_dri
	SET	acsw_pd  = 0,
		acsw_co  = 0,
		acsw_dv  = 0,
		acsw_mesa  = 0,
		acsw_fd = 1,
		acsw_tm = 0
	SELECT 'SI','FIN DE DIA   OK......'

	SET NOCOUNT OFF

END

GO
