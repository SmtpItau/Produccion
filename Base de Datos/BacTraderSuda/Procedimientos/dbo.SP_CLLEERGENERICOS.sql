USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLLEERGENERICOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CLLEERGENERICOS]
               (@clnombre1 char(40))
as
begin
   set nocount on
   declare @csql1   varchar(255)
   Declare @csql2   varchar(255)
   select @csql1 = 'SELECT c.clrut, c.cldv, c.clcodigo, c.clnombre, c.clgeneric, c.cldirecc, c.clcomuna, '
   select @csql1 = @csql1 + 'c.clregion, c.clcompint, c.cltipcli, c.clfecingr, c.clctacte, c.clfono, c.clfax '
   select @csql1 = @csql1 + 'FROM VIEW_CLIENTE c, MDAC a WHERE c.clrut <> a.acrutprop and c.clnombre like '''
   select @csql2 = rtrim(@clnombre1) + '%'' order by c.clnombre'

   execute (@csql1+@csql2) 
   
   set nocount oFF
   select 'OK'
   return
end


GO
