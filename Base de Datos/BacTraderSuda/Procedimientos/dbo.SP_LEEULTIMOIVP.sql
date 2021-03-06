USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEULTIMOIVP]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LEEULTIMOIVP]
as
begin
    declare @nvalorivp  float 
    declare @cfechaivp  char(10)
    declare @nvaloriipc float
    declare @cfechaiipc char(10)
    set rowcount 1  
    select @nvalorivp = vmvalor, @cfechaivp   = convert(char(10),vmfecha,101) 
                                                from VIEW_VALOR_MONEDA 
                                                where  vmcodigo = 997  
                                                order by vmfecha desc
    select @nvaloriipc = vmvalor, 
           @cfechaiipc = convert(char(10),vmfecha, 101)
    from VIEW_VALOR_MONEDA
           where vmcodigo = 502
           order by vmfecha desc 
                                   
 
    if rtrim(@cfechaivp)  <> '' select @cfechaivp  = substring(@cfechaivp,4,2)  + '/' + substring(@cfechaivp,1,2)  + '/' +  substring(@cfechaivp,7,4)
    if rtrim(@cfechaiipc) <> '' select @cfechaiipc = substring(@cfechaiipc,4,2) + '/' + substring(@cfechaiipc,1,2) + '/' +  substring(@cfechaiipc,7,4)
    select 'valorivp'  = isnull(@nvalorivp , 0.00), 
           'fechaivp'  = isnull(@cfechaivp ,   ''), 
           'valoripc'  = isnull(@nvaloriipc, 0.00), 
           'fechaiipc' = isnull(@cfechaiipc,   '')
    set rowcount 0
    return
end
                


GO
