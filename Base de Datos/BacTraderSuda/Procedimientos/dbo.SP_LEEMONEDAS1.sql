USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEMONEDAS1]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEMONEDAS1]
as
begin   
 select mnglosa, mnnemo 
  from  VIEW_MONEDA  
 
end
   


GO
