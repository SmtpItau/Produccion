USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EFORP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_EFORP]
                  (@codigo numeric (2,0))
as
begin
      set nocount on
  delete VIEW_FORMA_DE_PAGO where codigo=@codigo
  if @@error<>0 
                  begin
                     set nocount off
                     select  'NO'
                     return
  end
            set nocount off
            SELECT  'SI'
end


GO
