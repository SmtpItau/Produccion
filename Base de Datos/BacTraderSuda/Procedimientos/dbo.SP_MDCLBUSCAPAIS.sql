USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDCLBUSCAPAIS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDCLBUSCAPAIS]
                ( @npais  numeric ( 05, 00 ) )
as
begin
   select case 
          when rtrim( tbglosa ) = 'CHILE' then '1' else '0' end
   from   VIEW_TABLA_GENERAL_DETALLE
   where  tbcateg                                   = 180 and 
          convert ( numeric ( 05, 00 ), tbcodigo1 ) = @npais
end


GO
