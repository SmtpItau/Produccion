USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEECOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LEECOR]
as
begin
 select cclbanco, cclrut, cclctacorta 
          from mecc 
end


GO
