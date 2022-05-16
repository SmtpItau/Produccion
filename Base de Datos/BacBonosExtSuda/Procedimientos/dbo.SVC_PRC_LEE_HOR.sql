USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_PRC_LEE_HOR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_PRC_LEE_HOR]
			(	@sw	char(4),
				@fecha	DATETIME	)
as
begin
		select 	max(fec_hor)
		from	text_log_pcs
		where	sw = @sw
		AND	FECHA = @fecha

end	

GO
