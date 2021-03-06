USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_ACT_HOR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_GEN_ACT_HOR]
		(	@sw		char(4)		,
			@fec_hor	datetime	)
as
begin
	if exists(select * from text_log_pcs where @sw = sw AND FECHA = (SELECT ACFECPROC FROM text_arc_ctl_dri)) begin
		update	text_log_pcs set
			fec_hor	= getdate(),
			FECHA = @FEC_HOR
		where	sw	= @sw
		AND 	FECHA = @FEC_HOR
	end
	else begin
		insert into text_log_pcs
			(sw,  fec_hor, FECHA )
		values	(@sw, getdate(),@FEC_HOR)
	end
end

GO
