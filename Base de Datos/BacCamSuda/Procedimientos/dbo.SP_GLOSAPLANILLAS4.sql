USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSAPLANILLAS4]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_GLOSAPLANILLAS4]
 ( @codigo numeric(8))
as
begin
 select   clcodban
  ,clgeneric
  ,clnombre
 from    VIEW_CLIENTE
 where   clcodban = @codigo
end

GO
