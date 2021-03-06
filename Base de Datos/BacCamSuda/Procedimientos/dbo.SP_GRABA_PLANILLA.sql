USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PLANILLA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_GRABA_PLANILLA]
 (
        @entidad                    numeric(3)   ,
        @planilla_fecha             char(10)     ,
        @planilla_numero            numeric(6)   ,
        @interesado_rut             numeric(9)   ,
        @interesado_codigo          numeric(9)   ,
        @interesado_nombre          char(30)     ,
        @interesado_direccion       char(30)     ,
        @interesado_ciudad          char(20)     ,
        @operacion_numero           numeric(7)   ,
        @operacion_fecha            char(10)     ,
        @tipo_documento             numeric(1)   ,
        @tipo_operacion_cambio      numeric(3)   ,
        @codigo_comercio            char(6)      ,
        @concepto                   char(3)      ,
        @pais_operacion             numeric(3)   ,
        @operacion_moneda           numeric(3)   ,
        @monto_origen               numeric(15,2),
        @paridad                    numeric(11,4),
        @monto_dolares              numeric(15,2),
        @tipo_cambio                numeric( 9,2),
        @monto_pesos                numeric(17,2),
        @afecto_derivados           numeric(1)   ,
        @cantidad_acuerdos          numeric(1)   ,
        @autbcch_tipo               char(2)      ,
        @autbcch_numero             numeric(6)   ,
        @autbcch_fecha              char(10)     ,
        @rel_institucion            numeric(3)   ,
        @rel_fecha                  char(10)     ,
        @rel_numero                 numeric(6)   ,
        @rel_arbitraje              char(1)      ,
        @ofi_numero_inscripcion     numeric(8)   ,
        @ofi_fecha_inscripcion      char(10)     ,
        @ofi_fecha_vencimiento      char(10)     ,
        @ofi_nombre_financista      char(30)     ,
        @ofi_fecha_desembolso       char(10)     ,
        @ofi_moneda_desembolso      numeric(3)   ,
        @ofi_monto_desembolso       numeric(15,2),
        @ofi_impuesto_adicional     numeric(13,2),
        @exp_codigo_aduana          numeric(3)   ,
        @exp_declaracion_fecha      char(10)     ,
        @exp_declaracion_numero     char(7)      ,
        @exp_informe_fecha          char(10)     ,
        @exp_informe_numero         char(7)      ,
        @exp_fecha_vence_retorno    char(10)     ,
        @exp_valor_bruto            numeric(15,2),
        @exp_comisiones             numeric(13,2),
        @exp_otros_gastos           numeric(13,2),
        @exp_valor_total            numeric(16,2),
        @exp_plazo_financia         numeric(4)   ,
        @exp_nombre_comprador       char(30)     ,
        @imp_informe_fecha          char(10)     ,
        @imp_informe_numero         numeric(6)   ,
        @imp_declaracion_numero     char(18)     ,
        @imp_forma_pago             numeric(2)   ,
        @imp_embarque_numero        numeric(8)   ,
        @imp_embarque_fecha         char(10)     ,
        @imp_fecha_vence            char(10)     ,
        @imp_valor_mercaderia       numeric(14,2),
        @imp_gastos_fob             numeric(13,2),
        @imp_valor_fob              numeric(14,2),
        @imp_flete                  numeric(13,2),
        @imp_seguro                 numeric(13,2),
        @imp_valor_cif              numeric(14,2),
        @imp_intereses              numeric(14,2),
        @imp_gastos_bancarios       numeric(13,2),
        @der_numero_contrato        numeric(8)   ,
        @der_fecha_inicio           char(10)     ,
        @der_fecha_vence            char(10)     ,
        @der_instrumento            numeric(2)   ,
        @der_precio_contrato        numeric(11,4),
        @der_area_contable          numeric(2)   ,
        @acuerdo_codigo_1           char(7)      ,
        @acuerdo_numero_1           char(17)    ,
        @acuerdo_codigo_2           char(7)      ,
        @acuerdo_numero_2           char(17)    ,
        @acuerdo_codigo_3           char(7)      ,
        @acuerdo_numero_3           char(17)    ,
        @acuerdo_codigo_4           char(7)      ,
        @acuerdo_numero_4           char(17)    ,
        @acuerdo_codigo_5           char(7)      ,
        @acuerdo_numero_5           char(17)    ,
        @obs_1                      char(240)    ,
        @obs_2                      char(240)    ,
        @obs_3                      char(240)
                                  )
as
begin
set nocount on
   begin transaction
 
   declare @ok  numeric(19)
   select @ok = 1
   declare @fecha datetime
-- select @fecha = convert( datetime, @planilla_fecha + ' ' + convert(char(5),getdate(),108))
   select @fecha = convert( datetime, @planilla_fecha , 112 )
   if exists (select planilla_fecha,planilla_numero,entidad
               from VIEW_PLANILLA_SPT
              where convert(char(8),planilla_fecha,112) = @planilla_fecha  and
                    planilla_numero = @planilla_numero and entidad = @entidad)
      and @planilla_numero <> 0
      begin       -- actualizando
          print 'ACTUALIZANDO ...'
          update VIEW_PLANILLA_SPT
             set fecha           = getdate(),
                 entidad         = @entidad,
                 planilla_fecha  = @fecha,
                 planilla_numero = @planilla_numero
           where convert(char(8),planilla_fecha,112) = @planilla_fecha and
                 planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'NO UPDATE'
                 return
             end
      end
   else
      begin       -- actualizando
   if exists (select actual from tbcorrelativos where tabla='planillas' and codigo=1 and pendiente=0)
      begin
  update TBCORRELATIVOS 
     set pendiente = actual 
   where tabla='planillas' and codigo=1
           if @@error<>0
                  begin
                       rollback transaction
                       select 'NO INSERT NO NUMBER'
                       return
                    end
      end
   select @planilla_numero = isnull((select pendiente from tbcorrelativos where tabla='planillas' and codigo=1),0)
          print 'INSERTANDO ...'
          insert VIEW_PLANILLA_SPT(  fecha   ,  entidad, planilla_fecha,  planilla_numero )
                      values( getdate(), @entidad, @fecha        , @planilla_numero )
          if @@error<>0
             begin
                 rollback transaction
                 select 'NO INSERT'
                 return
             end
   else
      begin
  update TBCORRELATIVOS 
     set pendiente = 0, 
         actual    = actual + 1 
   where tabla='planillas' and codigo=1
           if @@error<>0
                  begin
                       rollback transaction
                       select 'NO INSERT NO MODIFY NUMBER'
                       return
                    end
      end
      end
   -- actualizando planilla datos generales
   update VIEW_PLANILLA_SPT
      set interesado_rut        = @interesado_rut,
          interesado_codigo     = @interesado_codigo,
          interesado_nombre     = @interesado_nombre,
          interesado_direccion  = @interesado_direccion,
          interesado_ciudad     = @interesado_ciudad,
          operacion_numero      = @operacion_numero,
          operacion_fecha       = @operacion_fecha,
          tipo_documento        = @tipo_documento,
          tipo_operacion_cambio = @tipo_operacion_cambio,
          codigo_comercio       = @codigo_comercio,
          concepto              = @concepto,
          pais_operacion        = @pais_operacion,
          operacion_moneda      = @operacion_moneda,
          monto_origen          = @monto_origen,
          paridad               = @paridad,
          monto_dolares         = @monto_dolares,
          tipo_cambio           = @tipo_cambio,
          monto_pesos           = @monto_pesos,
          afecto_derivados      = @afecto_derivados,
          cantidad_acuerdos     = @cantidad_acuerdos,
          obs_1                 = @obs_1,
          obs_2                 = @obs_2,
          obs_3                 = @obs_3
    where convert(char(8),planilla_fecha,112) = @planilla_fecha and
          planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'NO UPDATE GENERALES'
                 return
             end
   -- autorizacion bcch
   select @ok = @autbcch_numero 
   UPDATE VIEW_PLANILLA_SPT
      set autbcch_tipo    = (case when @ok > 0 then @autbcch_tipo   else '' end),
          autbcch_numero  = (case when @ok > 0 then @autbcch_numero else  0 end),
          autbcch_fecha   = (case when @ok > 0 then @autbcch_fecha  else '' end)
    where convert(char(8),planilla_fecha,112) = @planilla_fecha and
          planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'NO UPDATE BCCH'
                 return
             end
   -- relacion con planilla ...
   select @ok = @rel_numero 
   update VIEW_PLANILLA_SPT
      set rel_institucion = (case when @ok > 0 then @rel_institucion else 0  end),
          rel_fecha       = (case when @ok > 0 then @rel_fecha       else '' end),
          rel_arbitraje   = (case when @ok > 0 then @rel_arbitraje   else '' end),
          rel_numero      = (case when @ok > 0 then @rel_numero      else 0  end)
    where convert(char(8),planilla_fecha,112) = @planilla_fecha and
          planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'NO UPDATE RELACION'
                 return
             end
   -- operacion financiera internacional o credito externo
   select @ok = @ofi_numero_inscripcion
   update VIEW_PLANILLA_SPT
      set ofi_numero_inscripcion = (case when @ok > 0 then @ofi_numero_inscripcion else  0 end),
          ofi_fecha_inscripcion  = (case when @ok > 0 then @ofi_fecha_inscripcion  else '' end),
          ofi_fecha_vencimiento  = (case when @ok > 0 then @ofi_fecha_vencimiento  else '' end),
          ofi_nombre_financista  = (case when @ok > 0 then @ofi_nombre_financista  else '' end),
          ofi_fecha_desembolso   = (case when @ok > 0 then @ofi_fecha_desembolso   else '' end),
          ofi_moneda_desembolso  = (case when @ok > 0 then @ofi_moneda_desembolso  else  0 end),
          ofi_monto_desembolso   = (case when @ok > 0 then @ofi_monto_desembolso   else  0 end),
          ofi_impuesto_adicional = (case when @ok > 0 then @ofi_impuesto_adicional else  0 end)
    where convert(char(8),planilla_fecha,112) = @planilla_fecha and
          planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'NO UPDATE CREDITO'
                 return
             end
   -- exportaciones
   if @exp_informe_numero = '' 
      select @ok = 0
   else
      select @ok = convert(numeric(19),@exp_informe_numero)
   
   select @ok = (case
                      when @exp_valor_total <> 0 then 1
                      when @ok               > 0 then 1
                      else 0 end)
   update VIEW_PLANILLA_SPT
      set exp_codigo_aduana       = (case when @ok > 0 then @exp_codigo_aduana       else  0 end),
          exp_declaracion_fecha   = (case when @ok > 0 then @exp_declaracion_fecha   else '' end),
          exp_declaracion_numero  = (case when @ok > 0 then @exp_declaracion_numero  else '' end),
          exp_informe_fecha       = (case when @ok > 0 then @exp_informe_fecha       else '' end),
          exp_informe_numero      = (case when @ok > 0 then @exp_informe_numero      else '' end),
          exp_fecha_vence_retorno = (case when @ok > 0 then @exp_fecha_vence_retorno else '' end),
          exp_valor_bruto         = (case when @ok > 0 then @exp_valor_bruto         else  0 end),
          exp_comisiones          = (case when @ok > 0 then @exp_comisiones          else  0 end),
          exp_otros_gastos        = (case when @ok > 0 then @exp_otros_gastos        else  0 end),
          exp_valor_total         = (case when @ok > 0 then @exp_valor_total         else  0 end),
          exp_plazo_financia      = (case when @ok > 0 then @exp_plazo_financia      else  0 end),
          exp_nombre_comprador    = (case when @ok > 0 then @exp_nombre_comprador    else '' end)
     where convert(char(8),planilla_fecha,112) = @planilla_fecha and
           planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'no update exportaciones'
  set nocount off
                 return
             end
   -- importaciones
   select @ok = @imp_informe_numero
   update VIEW_PLANILLA_SPT
      set imp_informe_fecha      = (case when @ok > 0 then @imp_informe_fecha      else '' end),
          imp_informe_numero     = (case when @ok > 0 then @imp_informe_numero     else  0 end),
          imp_declaracion_numero = (case when @ok > 0 then @imp_declaracion_numero else '' end),
          imp_forma_pago         = (case when @ok > 0 then @imp_forma_pago         else  0 end),
          imp_embarque_numero    = (case when @ok > 0 then @imp_embarque_numero    else  0 end),
          imp_embarque_fecha     = (case when @ok > 0 then @imp_embarque_fecha     else '' end),
          imp_fecha_vence        = (case when @ok > 0 then @imp_fecha_vence        else '' end),
          imp_valor_mercaderia   = (case when @ok > 0 then @imp_valor_mercaderia   else  0 end),
          imp_gastos_fob         = (case when @ok > 0 then @imp_gastos_fob         else  0 end),
          imp_valor_fob          = (case when @ok > 0 then @imp_valor_fob          else  0 end),
          imp_flete              = (case when @ok > 0 then @imp_flete              else  0 end),
          imp_seguro             = (case when @ok > 0 then @imp_seguro             else  0 end),
          imp_valor_cif          = (case when @ok > 0 then @imp_valor_cif          else  0 end),
          imp_intereses          = (case when @ok > 0 then @imp_intereses          else  0 end),
          imp_gastos_bancarios   = (case when @ok > 0 then @imp_gastos_bancarios   else  0 end)
    where convert(char(8),planilla_fecha,112) = @planilla_fecha and
          planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'NO UPDATE IMPORTACIONES'
                 return
             end
   -- derivados
   select @ok = @der_numero_contrato
   update view_planilla_spt
      set der_numero_contrato = (case when @ok > 0 then @der_numero_contrato else  0 end),
          der_fecha_inicio    = (case when @ok > 0 then @der_fecha_inicio    else '' end),
          der_fecha_vence     = (case when @ok > 0 then @der_fecha_vence     else '' end),
          der_instrumento     = (case when @ok > 0 then @der_instrumento     else  0 end),
          der_precio_contrato = (case when @ok > 0 then @der_precio_contrato else  0 end),
          der_area_contable   = (case when @ok > 0 then @der_area_contable   else  0 end)
     where convert(char(8),planilla_fecha,112) = @planilla_fecha and
           planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'no update derivados'
  set nocount off
                 return
             end
 -- acuerdos
   select @ok = @cantidad_acuerdos
   update view_planilla_spt
      set acuerdo_codigo_1 = (case when @ok >= 1 then @acuerdo_codigo_1 else '' end),
          acuerdo_numero_1 = (case when @ok >= 1 then @acuerdo_numero_1 else '' end),
          acuerdo_codigo_2 = (case when @ok >= 2 then @acuerdo_codigo_2 else '' end),
          acuerdo_numero_2 = (case when @ok >= 2 then @acuerdo_numero_2 else '' end),
          acuerdo_codigo_3 = (case when @ok >= 3 then @acuerdo_codigo_3 else '' end),
          acuerdo_numero_3 = (case when @ok >= 3 then @acuerdo_numero_3 else '' end),
          acuerdo_codigo_4 = (case when @ok >= 4 then @acuerdo_codigo_4 else '' end),
          acuerdo_numero_4 = (case when @ok >= 4 then @acuerdo_numero_4 else '' end),
          acuerdo_codigo_5 = (case when @ok >= 5 then @acuerdo_codigo_5 else '' end),
          acuerdo_numero_5 = (case when @ok >= 5 then @acuerdo_numero_5 else '' end)
     where convert(char(8),planilla_fecha,112) = @planilla_fecha and
           planilla_numero = @planilla_numero and entidad = @entidad
          if @@error<>0
             begin
                 rollback transaction
                 select 'no update acuerdos'
  set nocount off
                 return
             end
   commit transaction
   select 'ok'
set nocount off
end

GO
