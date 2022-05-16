USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_FAMILIA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINA_FAMILIA](@xserie  char(12))
as
begin
 delete VIEW_INSTRUMENTO where inserie = @xserie
if @@error <> 0 begin
  select 'NO'
  return
end
SELECT 'SI'
end

GO
