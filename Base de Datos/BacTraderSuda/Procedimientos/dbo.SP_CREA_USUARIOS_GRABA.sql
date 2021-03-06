USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREA_USUARIOS_GRABA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CREA_USUARIOS_GRABA] 
        ( @tipo          char(1)  ,
                               @usuario       char(15) ,
                               @clave         char(15) ,
                               @nombre        char(40) ,
                               @tipo_usuario  char(15) ,
                               @fecha_expira  datetime )
as
begin
declare  
 @i   numeric(2),
 @cont     numeric(2),
 @char     char(50),
 @rango    numeric(3),
 @sistema  char(3)
if @tipo = 'B'
   select nombre,
          tipo_usuario,
          convert(char(10), fecha_expira, 103),
          clave
     from usuario
    where usuario = @usuario
if @tipo = 'E' or @tipo = 'G'
begin 
   
   delete from control_usuario  where usuario = @usuario  
   
   delete usuario where usuario = @usuario
   if @@error <> 0
   begin
      print 'ERROR_PROC FALLA BORRANDO USUARIO.'
      return 1
   end     
   if @tipo = 'E' 
   begin
      delete GEN_PRIVILEGIOS where usuario = @usuario and tipo_privilegio = 'U'
      if @@error <> 0
      begin
         print 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
         return 1
      end
   end
end
if @tipo = 'G'
begin 
   ----delete from control_usuario  where usuario = @usuario
   insert usuario( usuario,
                        clave,
                        nombre,
                        tipo_usuario,
                        fecha_expira,
                        cambio_clave )
                values( @usuario,
                        @clave,
                        @nombre,
                        @tipo_usuario,
                        @fecha_expira,
                        'S' )
 
   set @i=0   
   set @cont = (select count(*) from SISTEMA_CNT) 
   set @char = 'bccbfwbtrlimpcsscftes'   
   set @rango= 3    
   
   while @i >= @cont  begin
 
 set @sistema = left (@char,@rango)
 set @sistema = right(@sistema,3)
  
 if (select operativo from SISTEMA_CNT where id_sistema = @sistema) = 'S' begin 
 
  insert control_usuario
         ( usuario,
                         id_sistema,
                         nombre,
                         terminal,
                         bloqueado
                         )
                 values( @usuario,
                         @sistema,
                         @nombre,
                         '000000',
                         'N' )
  set @i=@i +1
  set @rango = @rango + 3
   
 end
    
   end   
   if @@error <> 0
   begin
      PRINT 'ERROR_PROC FALLA AGREGANDO USUARIO.'
      return 1
   end
end
return 0
end   /* fin procedimiento */
--select * from GEN_PRIVILEGIOS


GO
