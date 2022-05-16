USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OVERNIGTH_TRAECLIENTE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_OVERNIGTH_TRAECLIENTE] --0,'deutsche securities c. de bolsa  ltda.'
 ( @rut numeric(9) = 0,
  @nombre char(70) = '' )
as
begin
 select 
  clrut
  ,clnombre
  ,clcodigo
  ,cldv
 from
  VIEW_CLIENTE
 where 
  ( clrut    = @rut       or @rut    = 0 )
 and ( clnombre = @nombre or @nombre = '')
  
end



GO
