USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELEENTI]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_SELEENTI]
as
begin
 SELECT entidad FROM GEN_SISTEMAS WHERE sistema LIKE '%CONTAB%'
end

GO
