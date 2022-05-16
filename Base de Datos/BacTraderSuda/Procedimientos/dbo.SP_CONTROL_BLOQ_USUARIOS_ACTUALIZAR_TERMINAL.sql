USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_ACTUALIZAR_TERMINAL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_ACTUALIZAR_TERMINAL](
        @usuario char(10)
            )
as
begin
 declare 
  @cont numeric(2),
  @i numeric(2),
  @j      numeric(2)
 set nocount on
 
 set @cont= (select count(*) from usuario_activo where usuario = @usuario) +1  
 
    set @i=1
    set @j=1     
 
    while @i<=@cont  begin 
 if exists (select * from usuario_activo where usuario = @usuario and terminal=@i ) begin
      
  update usuario_activo set  terminal  = @j
     where usuario  = @usuario and
      terminal = @i 
      
 
  
  set @j=@j+1
  select 'OK'
 end
 else begin
  
  select 'ERROR'
 end
 
    set @i=@i +1
    end
 set nocount off
end


GO
