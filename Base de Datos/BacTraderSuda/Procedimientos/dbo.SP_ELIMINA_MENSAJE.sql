USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_MENSAJE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINA_MENSAJE](@xcorrela  float)
as
begin
  delete BAC_MENSAJE where correla = @xcorrela
end

GO
