USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCACOMAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCACOMAS] ( @cglosa varchar(255) output ) 
as
begin
  if charindex ( ',', @cglosa) > 0
     begin
       select @cglosa = char(34) + @cglosa + char(34)
     end
end


GO
