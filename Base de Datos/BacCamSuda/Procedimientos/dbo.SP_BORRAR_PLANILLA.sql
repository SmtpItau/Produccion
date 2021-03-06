USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_PLANILLA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_BORRAR_PLANILLA] 
  (
  @entidad numeric(2),
  @fecha  char(8),
  @numplan numeric(7)
  ) 
as
begin
set nocount on
begin transaction
      -- valida existencia de planilla
      if not exists (select * from  view_planilla_spt
                              where (@fecha   = '' or convert(char(8),planilla_fecha,112) = @fecha) 
                                and (@numplan = 0  or planilla_numero = @numplan))
      begin
    select -1,'NO EXISTE PLANILLA PARA SER ELIMINADA'
    set nocount off
    return -1
      end
      -- elimina planilla
      delete from  VIEW_PLANILLA_SPT
            where (@fecha   = '' or convert(char(8),planilla_fecha,112) = @fecha) 
       and (@numplan = 0  or planilla_numero  = @numplan)                
      if @@error <> 0
      begin
    rollback transaction
    select -1,'NO SE PUEDE ELIMINAR PLANILLA'
           set nocount off
    return -1
      end
      -- valida existencia y elimina detalle de intereses
      if exists (select * from TBDETALLEINTERESES
                          where (@fecha   = '' or convert(char(8),planilla_fecha,112) = @fecha)
                            and (@numplan =  0 or planilla_numero = @numplan) )
      begin
           delete from TBDETALLEINTERESES
                 where (@fecha   = '' or convert(char(8),planilla_fecha,112) = @fecha)
                   and (@numplan =  0 or planilla_numero = @numplan)
   
           if @@error <> 0
           begin
                rollback transaction
           select -1,'NO SE PUEDEN BORRAR LOS INTERESES DE ESTA PLANILLA'
                 set nocount off
         return -1
    end
      end
commit transaction
select 0, 'OK'
 set nocount off
end




GO
