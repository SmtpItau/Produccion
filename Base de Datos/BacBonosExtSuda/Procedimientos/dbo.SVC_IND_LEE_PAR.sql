USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_IND_LEE_PAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_IND_LEE_PAR]
as 
begin
          select convert(char(10) ,
                 acfecproc,103), 
                 convert(char(10) ,
                 acfecprox,103), 
                 acsw_pd 
          from text_arc_ctl_dri

          return 
end


GO
