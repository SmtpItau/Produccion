USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_RSG_ELI_COD]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


create procedure [dbo].[SVA_RSG_ELI_COD]
			(	@clasificador 	char(40)	)
as
begin
	set nocount on
	delete from text_cod_rie where @clasificador = clasificador
	set nocount off
end	
GO
