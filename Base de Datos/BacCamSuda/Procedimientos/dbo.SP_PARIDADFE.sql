USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARIDADFE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_PARIDADFE]
 (
 @moneda char(3),
 @fecha datetime
 )
as
begin
 select vmparmes 
 from VIEW_POSICION_SPT 
 where vmcodigo= @moneda 
   and vmfecha = @fecha
end



GO
