USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHEQUEAR_RCRV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CHEQUEAR_RCRV]
  as
  begin
  select acsw_rc,acsw_rv from MDAC
  end
  

GO
