USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GLOSAPLANILLAS5]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_GLOSAPLANILLAS5]
 ( @codigo numeric(2))
as
begin
 select   codigo
  ,glosa2
  ,glosa
 from    VIEW_FORMA_DE_PAGO
 where codigo = @codigo
end

GO
