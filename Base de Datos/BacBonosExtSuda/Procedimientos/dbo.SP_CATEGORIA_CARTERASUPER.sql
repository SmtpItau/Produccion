USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CATEGORIA_CARTERASUPER]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_CATEGORIA_CARTERASUPER]
as
begin
   set nocount on
 select nombre_carterasuper
 from   VIEW_CATEGORIA_CARTERASUPER
   set nocount off
end

GO
