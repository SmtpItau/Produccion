USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_CAR_SUP]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_GEN_CAR_SUP]
as
begin
   set nocount on

	SELECT	TBGLOSA 
	FROM VIEW_TABLA_GENERAL_DETALLE 
	WHERE TBCATEG = 1111 

   set nocount off
end


GO
