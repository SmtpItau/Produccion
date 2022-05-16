USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINAART84]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINAART84]
as
begin
 delete from MD_ART84
 if @@error<>0 begin 
  SELECT 'NO', 'PROBLEMAS EN ELIMACI¢N DE ARCHIVO DE ARTICULO 84'
  return
 end
 SELECT 'SI', 'ELIMNACI¢N OK'
end
                                                                                                   
-- sp_eliminaart84

GO
