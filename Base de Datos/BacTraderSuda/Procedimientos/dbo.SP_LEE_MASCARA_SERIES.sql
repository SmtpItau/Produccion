USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_MASCARA_SERIES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEE_MASCARA_SERIES]
                  (@incodigo numeric(3))
as
begin
       select secodigo,semascara 
         from VIEW_SERIE
        where secodigo = @incodigo
end
--sp_lee_mascara_series 20


GO
