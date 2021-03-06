USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DESBLOQUEARINST]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_DESBLOQUEARINST]
                          (@rutcart numeric(09,0),
                           @numdocu numeric(10,0),
                           @correla numeric(03,0),
                           @hwnd numeric,
                           @usuario char(15))
as
begin
      set nocount on
 if exists( select * from mdbl where blrutcart = @rutcart and blnumdocu = @numdocu and blcorrela = @correla )
 begin
  delete mdbl
  where  blrutcart = @rutcart 
  and  blnumdocu = @numdocu 
  and  blcorrela = @correla  
  and  blhwnd   = @hwnd
  and  blusuario = @usuario
                set nocount off
  SELECT 'SI' 
 end
 else
         begin
                set nocount off
  select 'NO' 
         end
end

GO
