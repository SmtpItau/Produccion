USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHEQUEAR_FD]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CHEQUEAR_FD]
  as
  begin
  select acsw_fd from MDAC
  end
  


GO
