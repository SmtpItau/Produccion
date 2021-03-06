USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0120C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE  [dbo].[SP_MD0120C]
                             ( @xvalven    float   , 
                               @xtir       float   ,
                               @xbaseemi   float   ,
                               @xfecven    char(10),
                               @xfeccal    char(10),
                               @zprecio    float   ,
                               @xunimon    integer ,
                               @modcal     integer )
                    
as
begin
    declare @xmt     float
    declare @xpvp    float
    declare @xvp     float
    declare @fecha   integer 
    declare @vmvalor float
    declare @result  float
    declare @result1 float
    if @xunimon = 999
       select @vmvalor = 1.0
    else
       select @vmvalor = VIEW_VALOR_MONEDA .vmvalor from VIEW_VALOR_MONEDA  where VIEW_VALOR_MONEDA.vmcodigo = @xunimon
                                                and   VIEW_VALOR_MONEDA.vmfecha  = @xfeccal
    select @fecha = datediff( day, @xfecven, @xfeccal )
    if @modcal = 1
       begin
          select @xmt    = 0.0
          select @xpvp   = 0.0
          select @xvp    = 0.0
       end
    if @modcal = 2
       begin
          execute Sp_Div @xtir, @xbaseemi, @result OUTPUT
          select @result1 = ( @result * @fecha )
          execute Sp_Div @result1, 100.0, @result1 OUTPUT
          select @result1 = @result1 + 1.0
          execute Sp_Div @xvalven, @result1, @xmt OUTPUT 
          select @xpvp    = 0.0
          select @xvp     = 0.0
       end
    if @modcal = 3
       begin
          execute Sp_Div @zprecio, @vmvalor, @xmt OUTPUT
          execute Sp_Div @xvalven, @xmt, @result OUTPUT
          select @result  = ( @result - 1.0 ) * 100.0
          select @result1 = ( @fecha * @xbaseemi )
          execute Sp_Div @result, @result1, @xtir OUTPUT
          select @xpvp    = 0.0
          select @xvp     = 0.0  
       end
     select 'XMT'  = @xmt,
            'XTIR' = @xtir
     return
end


GO
