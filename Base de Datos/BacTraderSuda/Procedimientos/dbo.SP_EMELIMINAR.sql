USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMELIMINAR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_EMELIMINAR]
          (@emrut1 numeric(9,0))
as
begin
   set nocount on
   delete VIEW_EMISOR where emrut = @emrut1
   set nocount off
   select 'OK'
   return
end
--

GO
