USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FINDBASEMONEDA2]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FINDBASEMONEDA2]
               ( @parcodmoneda numeric(03) )
as
begin
set nocount on 
 select  'base' = mnbase
 from VIEW_MONEDA 
 where  mncodmon = @parcodmoneda
set nocount off
end
/*
sp_findbasemoneda 913
*/

GO
