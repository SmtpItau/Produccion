USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_GEN_MENU]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_GEN_MENU]
 (  
  @primera_vez    char(1)     ,
                @entidad        char(3)     ,
                @indice         numeric(3)  ,
                @nombre_opcion  char(150)    ,
                @nombre_objeto  char(30)    ,
                @posicion       numeric(3)  
 )
as
begin
 set nocount on
 if @primera_vez = 'S'
 begin
 delete GEN_MENU where entidad = @entidad
    if @@error <> 0
    begin 
        set nocount off
        print 'FALLA AGREGANDO BORRANDO MENU'
         select 'ERR'
        return 1
    end
 
 end
 insert GEN_MENU(entidad,
                 indice,
                 nombre_opcion,
                  nombre_objeto,
                  posicion,
                  entidadfox )
          values( @entidad,
                 @indice,
                  @nombre_opcion,
                  @nombre_objeto,
                  @posicion,
                  '' )
 if @@error <> 0
 begin
    set nocount off
    print 'FALLA AGREGANDO OPCION DE MENU'
    select 'ERR'
    return 1
 end
      set nocount off
      select 'OK'
end




GO
