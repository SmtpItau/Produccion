USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERUSUARIOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERUSUARIOS] 
  (@admin char(15))
as 
begin
set nocount on
 select usuario,nombre 
 from VIEW_USUARIO 
 where usuario <> @admin
end

GO
