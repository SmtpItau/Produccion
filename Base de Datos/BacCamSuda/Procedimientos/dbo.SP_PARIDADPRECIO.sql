USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARIDADPRECIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_PARIDADPRECIO]
 ( @moneda char(8) )
as
begin
 select 
  mnrrda 
   from 
  VIEW_MONEDA 
  where 
  substring(mnnemo,1,3) = @moneda
end



GO
