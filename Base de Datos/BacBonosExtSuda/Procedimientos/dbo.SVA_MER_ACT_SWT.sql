USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_MER_ACT_SWT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_MER_ACT_SWT] 
(	
          @SW	NUMERIC(1)	
)
AS
BEGIN


	UPDATE text_arc_ctl_dri SET acsw_tm  =@SW
END



GO
