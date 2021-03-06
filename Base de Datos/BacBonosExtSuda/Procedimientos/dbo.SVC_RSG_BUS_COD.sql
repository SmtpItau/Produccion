USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RSG_BUS_COD]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_RSG_BUS_COD]
		(	@Glosa 	char(40)	)
as
begin

	set nocount on
	declare @cont	float
	if exists( select * from text_cod_rie where @glosa = clasificador) begin
		select 	@cont = (select	count(*)
			from 	text_cod_rie
			where 	@glosa = clasificador)

		select	1		,
			Glosa		,
			@cont
		from 	text_cod_rie
		where 	@glosa = clasificador
	end 
	else begin
		select 0
	end 
set nocount off
end

GO
