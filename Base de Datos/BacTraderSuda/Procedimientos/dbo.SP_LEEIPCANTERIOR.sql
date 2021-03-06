USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEIPCANTERIOR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEIPCANTERIOR]
               (@cfecha char(10))
as
begin
    if datepart(month,@cfecha) = 1
        select vmvalor from VIEW_VALOR_MONEDA where vmfecha = '12/01/' + convert(char(4),datepart(year,@cfecha) - 1) 
        and    vmcodigo = 500
    else
        select vmvalor from VIEW_VALOR_MONEDA where vmfecha = @cfecha 
        and    vmcodigo = 500
    return
end 


GO
