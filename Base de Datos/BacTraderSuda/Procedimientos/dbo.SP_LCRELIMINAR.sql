USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LCRELIMINAR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LCRELIMINAR]
as
begin
   set nocount on
      delete from mdlcr
      select 'OK'
   set nocount off
end


GO
