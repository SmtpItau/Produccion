USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CODOPER]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CODOPER]
   (@coperador char (15))
as
begin
set nocount on
 select isnull(codoper,'')
 from  BACUSER
 where rtrim(@coperador)=usuario
end
--sp_codoper 'mvillarr'


GO
