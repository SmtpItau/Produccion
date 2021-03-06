USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_RSG_GRB_DET]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_RSG_GRB_DET]
	(	@clasificador	char(40)	)
as
begin
	set nocount on
	if not exists(select * from text_rie where @clasificador = clasificador) begin
		insert into text_rie 
			(clasificador)
		values
			(@clasificador)
	end
	set nocount off
end

GO
