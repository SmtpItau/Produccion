USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNULEER]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MNULEER]
as
begin
       select mnivel,mtexto,mtipo,mopcion from BACMENU order by mnivel
end


GO
