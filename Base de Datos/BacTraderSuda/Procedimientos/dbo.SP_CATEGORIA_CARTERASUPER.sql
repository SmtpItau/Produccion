USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CATEGORIA_CARTERASUPER]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CATEGORIA_CARTERASUPER]
as
begin
   set nocount on
 select nombre_carterasuper
 from   VIEW_CATEGORIA_CARTERASUPER
   set nocount off
end


GO
