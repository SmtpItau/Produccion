USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_RSG_GRB_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_RSG_GRB_DAT]
		( @clasificador	char(40)	,
		  @glosa	char(20)	)
as
begin

		set nocount on
	
		insert into text_cod_rie select
				clasificador	= 	@clasificador	,
				glosa		=	@glosa
		set nocount off

end

GO
