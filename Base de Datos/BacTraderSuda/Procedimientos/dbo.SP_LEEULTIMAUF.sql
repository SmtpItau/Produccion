USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEULTIMAUF]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LEEULTIMAUF]
as
begin
    declare @nvaloruf  float 
    declare @cfechauf  char(10)
    declare @nvaloripc float
    declare @cfechaipc char(10)
    set rowcount 1  
    select @nvaloruf = vmvalor, @cfechauf   = convert(char(10),vmfecha,101) 
                                              from VIEW_VALOR_MONEDA 
                                              where  vmcodigo = 998  
                                              order by vmfecha desc
    select @nvaloripc = vmvalor, @cfechaipc = convert(char(10),vmfecha,101)
                                              from  VIEW_VALOR_MONEDA 
                                              where vmcodigo = 500  
                                              order by vmfecha desc
 
    if rtrim(@cfechauf)  <> '' select @cfechauf  = substring(@cfechauf,4,2)  + '/' + substring(@cfechauf,1,2)  + '/' +  substring(@cfechauf,7,4)
    if rtrim(@cfechaipc) <> '' select @cfechaipc = substring(@cfechaipc,4,2) + '/' + substring(@cfechaipc,1,2) + '/' +  substring(@cfechaipc,7,4)
    select 'valoruf'  = isnull(@nvaloruf , 0.00), 
           'fechauf'  = isnull(@cfechauf ,   ''), 
           'valoripc' = isnull(@nvaloripc, 0.00), 
           'fechaipc' = isnull(@cfechaipc,   '')
    set rowcount 0
 
    return
end


GO
