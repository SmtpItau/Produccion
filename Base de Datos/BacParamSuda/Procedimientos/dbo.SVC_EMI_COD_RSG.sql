USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_EMI_COD_RSG]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create procedure [dbo].[SVC_EMI_COD_RSG]
as
begin
	set nocount on
	select * from text_rie
	set nocount off
end
GO
