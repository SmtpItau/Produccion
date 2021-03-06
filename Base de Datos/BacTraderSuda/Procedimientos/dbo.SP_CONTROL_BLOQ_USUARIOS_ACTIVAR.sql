USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_ACTIVAR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_ACTIVAR](
       @usuario char(10),
       @id_sistema char(3),
       @fechaproceso datetime,
       @fechasistema datetime)
       
as
begin
 declare 
   @nombre   char(50), 
   @terminal  char(6),
   @cont   numeric(2), 
   @tmp   char(6),
   @tmp2   char(6),
   @nombre_us  char(50) 
 set nocount on
    set @tmp='111111'   
  set @tmp2='100000'   
  set @cont= (select count(*) from VIEW_USUARIO_ACTIVO where usuario = @usuario) +1
  
  
  set @terminal = right(@tmp2,6)
  set @terminal= right(@tmp,@cont) + @terminal  
  set @cont = 1  
cambio_terminal:
  
  
     if @cont < 7 begin --not exists(select 1 from usuario_activo where terminal = '6' and usuario = @usuario) begin 
  if exists (select 1 from VIEW_USUARIO_ACTIVO where usuario = @usuario and terminal = @cont) begin
   set @cont = @cont +1  
   goto cambio_terminal
    
  end
  if exists(select 1 from VIEW_USUARIO where usuario = @usuario) begin 
 
   set @nombre_us = (select nombre from VIEW_USUARIO where usuario=@usuario)
  end 
  else begin
   set @nombre_us = (select nombre from VIEW_USUARIO where usuario= left(@usuario,len(@usuario)))
  end
  insert into VIEW_USUARIO_ACTIVO (
    usuario,
    id_sistema,
    terminal,
    fechaproceso,
    fechasistema
    )
   values (
    @usuario,
    @id_sistema,
    @cont,
    @fechaproceso,
    @fechasistema
    )
  select @cont,@usuario  
  if @@error <> 0 begin
   select 'ERROR'
  
  end
 
    end
    else begin
  select 'LLENO','LLENO'
    end 
 
 set nocount off
end
--delete from view_usuario_Activo
--select * from view_usuario_activo

GO
