USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHAAHORA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FECHAAHORA]
as
begin
 select 
  convert(char(10),acfecproc,103) 
 from 
  MDAC
end

GO
