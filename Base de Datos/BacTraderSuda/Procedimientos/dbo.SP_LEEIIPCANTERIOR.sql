USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEIIPCANTERIOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEIIPCANTERIOR]
                  (@nmes integer, @nann integer)
as
begin
    select vmvalor 
      from VIEW_VALOR_MONEDA 
     where vmcodigo = 502
           and   datepart(month,vmfecha) = @nmes 
           and   datepart(year, vmfecha) = @nann
    return
end


GO
