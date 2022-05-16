USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[sp_instrumentos_bonex]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_instrumentos_bonex]
as
begin
	set nocount on

	select	cod_familia, nom_familia 
	from	BacBonosExtSuda.dbo.text_fml_inm with(nolock)
	order 
	by		cod_familia

end

GO
