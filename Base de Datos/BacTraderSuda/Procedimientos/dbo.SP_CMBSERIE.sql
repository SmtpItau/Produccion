USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBSERIE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CMBSERIE]
as 
begin
 set nocount on
 select VIEW_SERIE.secodigo,VIEW_SERIE.semascara
 from VIEW_SERIE 
 order by  semascara
 set nocount off
end


GO
