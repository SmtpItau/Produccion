USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSAPLANILLAS1]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_GLOSAPLANILLAS1]
 ( @codigo1 char(6) )
as
begin
 select   tbcodigo1
  ,tbcateg
  ,tbglosa 
 from    VIEW_TABLA_GENERAL_DETALLE
 where   tbcateg   = 3 
   and   tbcodigo1 = @codigo1
end

GO
