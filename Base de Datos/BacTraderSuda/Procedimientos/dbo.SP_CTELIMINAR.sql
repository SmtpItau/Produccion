USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CTELIMINAR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CTELIMINAR] 
               (@ctcateg numeric(4) )
as
begin
set nocount on
       delete  from MDCT where ctcateg = @ctcateg
set nocount off
select 'OK'
end
--execute sp_cleliminar1 14185532,1

GO
