USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSAPLANILLAS3]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_GLOSAPLANILLAS3]
 ( @codigo numeric(5))
as
begin
 select   mncodmon
  ,mnsimbol
  ,mnglosa
 from    VIEW_MONEDA
 where   mncodmon = @codigo
end

GO
