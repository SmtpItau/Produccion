USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_PFE_CCE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINA_PFE_CCE] 
as
begin
 delete from MD_PFE_CCE
 if @@error<>0 begin 
  SELECT 'NO', 'PROBLEMAS EN ELIMACI¢N DE ARCHIVO DE PFE_CCE'
  return
 end
 SELECT 'SI', 'ELIMNACI¢N OK'
end


GO
