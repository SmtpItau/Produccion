USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FINDBASE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FINDBASE]
as
begin
  select  mncodmon , 
   mnnemo  ,
   mnbase 
  from 
   VIEW_MONEDA
  where 
   isnull(mnmx,'')<> 'C'
 
end
-- sp_findbase '$$'
 --  select * from mdpa


GO
