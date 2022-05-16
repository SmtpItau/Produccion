USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCACODIGOSERIE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCACODIGOSERIE]
  ( @codigo  char(12))
as   
begin
 select  secodigo,semascara
               
 from    VIEW_SERIE 
 where   (semascara= @codigo)  
 
end 


GO
