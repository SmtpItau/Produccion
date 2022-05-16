USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_PRC_CTR_EST]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_PRC_CTR_EST]
as
begin
	select	acsw_pd 	,
		acsw_mesa	,
		acsw_dv		,
		acsw_tm		,
		acsw_fd 	,
		acsw_co
	from text_arc_ctl_dri
end 

GO
