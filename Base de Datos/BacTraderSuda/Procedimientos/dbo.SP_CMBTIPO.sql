USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBTIPO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CMBTIPO]
as 
begin
 set nocount on
 select incodigo,inserie
 from instrumento
 order by  inserie
 set nocount off
end


GO
