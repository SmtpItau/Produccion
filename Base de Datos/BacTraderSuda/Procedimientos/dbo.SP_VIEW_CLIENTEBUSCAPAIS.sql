USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VIEW_CLIENTEBUSCAPAIS]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** objeto:  procedimiento  almacenado dbo.sp_VIEW_CLIENTEbuscapais    fecha de la secuencia de comandos: 05/04/2001 13:13:44 ******/
CREATE procedure [dbo].[SP_VIEW_CLIENTEBUSCAPAIS]
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
