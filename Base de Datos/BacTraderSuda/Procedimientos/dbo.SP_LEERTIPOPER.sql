USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERTIPOPER]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERTIPOPER]
            (   @usuario  char(15))  -- usuario         ) 
as
begin
        select  tipoper  
          from  BACUSER
          where usuario = @usuario
end

GO
