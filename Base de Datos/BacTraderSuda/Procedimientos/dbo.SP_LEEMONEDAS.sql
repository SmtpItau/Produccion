USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEMONEDAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEMONEDAS]
as
begin   
  select 
  mnnemo,
  mnglosa,
  mnbase,
  mnvalor 
 from 
  VIEW_MONEDA  
end


GO
