USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_RUTINAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_RUTINAS]
as
begin
set nocount on
 select inserie, inglosa ,inprog   from VIEW_INSTRUMENTO order by inserie , inglosa
end


GO
