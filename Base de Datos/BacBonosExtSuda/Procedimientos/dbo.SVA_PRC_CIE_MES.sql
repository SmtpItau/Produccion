USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_PRC_CIE_MES]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_PRC_CIE_MES]
as
begin

   set nocount on

	select acsw_mesa from text_arc_ctl_dri

   set nocount off


end


GO
