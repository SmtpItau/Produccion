USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INT_BUS_CFM]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_INT_BUS_CFM]
as 
begin
	select tbcodigo1,tbglosa from VIEW_TABLA_GENERAL_DETALLE where tbcateg = 1107
end

GO
