USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_MI_MEMO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAR_MI_MEMO] 
as 
begin
set nocount on
 select  monumdocu ,
         mofecpro  ,
  moinstser 
 
 from  mdmo
set nocount off
end


GO
