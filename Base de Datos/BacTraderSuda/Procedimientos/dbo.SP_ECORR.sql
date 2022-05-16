USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ECORR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ECORR]
     (
       @ctacorta  char (15)
     --@codigo numeric(9,0),
     --@cod numeric (9,0)
     )
as
begin
 begin transaction
  
  delete  MECC where  cclctacorta = @ctacorta  --cclrut=@codigo and cclcodig = @cod
  if @@error<>0
  begin
   rollback transaction
                        select  @@error
   return
  end
 commit transaction
             SELECT 'OK'
end
--sp_ecorr 91584000
 

GO
