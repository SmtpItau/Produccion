USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PARIDAD]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_GRABA_PARIDAD]
 (  @valor   numeric (17,4)  ,
                @codigo  char    (3)     ,
                @tip     numeric (1)     ,
                @tcambio numeric (17,4) = 0 )
as
begin   
     set nocount on
     begin transaction
     declare @fecha   char(8)
     select  @fecha = convert(char(8),acfecpro,112) from MEAC
     if not exists ( select vmcodigo from VIEW_POSICION_SPT where vmcodigo = @codigo and convert(char(8),vmfecha,112) = @fecha )
        insert into VIEW_POSICION_SPT
                    (    vmcodigo
                        ,vmfecha
                        ,vmposini
                        ,vmparidad
                        ,vmparmes    )
                   values
                    (    @codigo
                        ,@fecha  
                        ,0
                        ,0
                        ,0          )
     -- paridades diarias
     if @tip=3
     begin
     if @tcambio = 0          -- dolar observado
           select @tcambio                     = vmvalor 
             from VIEW_VALOR_MONEDA 
            where vmcodigo                     = 994 
              and convert(char(8),vmfecha,112) = @fecha
     if ( select mnrrda from VIEW_MONEDA where substring(mnnemo,1,3)      =    @codigo) <> 'm'
          select @tcambio = (case @valor when 0 then 0 else (@tcambio / @valor) end)
    else
        select @tcambio = @tcambio * @valor
        update VIEW_VALOR_MONEDA 
           set vmparidad = @valor 
         where vmcodigo  = ( select mncodmon from VIEW_MONEDA where substring(mnnemo,1,3) = @codigo )
           and convert(char(8),vmfecha,112) = @fecha
        update VIEW_POSICION_SPT 
           set vmparidad                    = @valor ,
               vmpreini                     = @tcambio 
         where vmcodigo                     = @codigo 
           and convert(char(8),vmfecha,112) = @fecha
     end
     -- posicion inicial
     if @tip=4
     begin
         update VIEW_VALOR_MONEDA 
            set vmposini =@valor 
          where vmcodigo = ( select mncodmon from VIEW_MONEDA where substring(mnnemo,1,3)=@codigo )
           and convert(char(8),vmfecha,112) = @fecha
         update VIEW_POSICION_SPT 
            set vmposini                     = @valor 
          where vmcodigo                     = @codigo 
            and convert(char(8),vmfecha,112) = @fecha
     end
     -- paridades mensual bcch
     if @tip=5
     update VIEW_POSICION_SPT 
        set vmparmes                     = @valor
      where vmcodigo                     = @codigo 
        and convert(char(8),vmfecha,112) = @fecha
        if @@error <> 0
        begin
            rollback transaction
            select -1, 'ERROR'
        end else    
        begin
            commit transaction    
            select 0, 'OK', @tcambio
        end 
set nocount off
end
GO
