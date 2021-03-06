USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_ZAP]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_ZAP]
(	
        @fecante	DATETIME,
	@fecproc	DATETIME,
	@fecprox	DATETIME
)

AS
BEGIN

-- sva_zap '20011129','20011130','20011203'

	DELETE	TEXT_CTR_INV
	DELETE	TEXT_MVT_DRI
	DELETE	text_ctr_cpr
	DELETE	TEXT_RSU
	DELETE	text_tsp_ctr
	DELETE	text_log_pcs
	DELETE	text_itf_bct
	

	UPDATE	text_arc_ctl_dri
	SET	acfecante	= @fecante	,
		acfecproc	= @fecproc	,
		acfecprox	= @fecprox	,
		acsw_pd		= 1		,
		acsw_co		= 0		,
		acsw_dv		= 0		,
		acsw_mesa	= 0		,
		acsw_fd		= 0		,
		acnumoper 	= 1


END

GO
