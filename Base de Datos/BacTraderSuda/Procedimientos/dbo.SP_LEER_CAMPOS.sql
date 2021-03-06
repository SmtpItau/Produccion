USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CAMPOS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LEER_CAMPOS]
                               (@sistema          char(6),
                                @tipo_movimiento  char(6),
                                @tipo_operacion   char(6))
                              
as
begin
  select 
         id_sistema ,
         tipo_movimiento,
         tipo_operacion,
         codigo_campo,
         descripcion_campo,
         nombre_campo_tabla,
         tipo_administracion_campo,
         tabla_campo,
         campo_tabla,
         campos_tablas                  
    from VIEW_CAMPO_CNT 
   where id_sistema = @sistema
        and tipo_movimiento = @tipo_movimiento
        and tipo_operacion  = @tipo_operacion
 and tipo_administracion_campo = 'v' 
end 
-- select * from bac_cnt_campos
-- sp_leer_campos 'btr','mov','cp'


GO
