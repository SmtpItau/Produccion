USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_EMI_CLF_RSG]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create procedure [dbo].[SVC_EMI_CLF_RSG] (@clasificador	char(40)	)
as
begin
	set nocount on
	select	glosa
	from 	text_cod_rie
	where	clasificador =  @clasificador
	set nocount off
end
GO
