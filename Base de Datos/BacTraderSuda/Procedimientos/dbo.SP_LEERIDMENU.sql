USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERIDMENU]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERIDMENU]
as
begin
      select mopcion 
       from BACMENU 
      where mopcion > 0
      
return
end


GO
