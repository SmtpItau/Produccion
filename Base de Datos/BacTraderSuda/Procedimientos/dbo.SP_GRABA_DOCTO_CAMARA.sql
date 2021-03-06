USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_DOCTO_CAMARA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_GRABA_DOCTO_CAMARA]( @numero_documento     numeric(10)   ,
                                   @codigo_banco         numeric(3)    ,
                                   @modo                 char(1)       ,
                                   @camara               char(1)       ,
                                   @forma_pago           char(4)       ,
                                   @monto_operacion      float         ,
                                   @codigo_banco2        numeric(3)    )
as 
begin
declare @fecha_hoy      datetime ,
        @forma_pago_or  char(4)  ,
        @vcamara        char(4)
select @vcamara  = convert(char(4),folio) from GEN_FOLIOS where codigo = 'CAMARA'
select @fecha_hoy = acfecproc from MDAC
select @forma_pago_or = forma_pago
  from GEN_PAGOS_OPERACION
 where numero_documento = @numero_documento
   and codigo_banco     = @codigo_banco
select * 
  into #paso 
  from GEN_PAGOS_OPERACION
 where numero_documento = @numero_documento
   and codigo_banco     = @codigo_banco
update #PASO set tipo_canje   = 'r', 
                 fecha_pago   = @fecha_hoy,
                 tipo_ingreso = @camara
insert into GEN_PAGOS_OPERACION select * from #PASO
if @@error <> 0 
begin
   PRINT 'ERROR_PROC FALLA AGREGANDO PAGOS OPERACION (REVERSA)'
   return 1
end
if @modo = 'M'
begin
   if @forma_pago_or <> @forma_pago and @forma_pago = @vcamara
      select @camara = 'M'
   update #PASO set codigo_banco    = @codigo_banco2,
                    monto_operacion = @monto_operacion,
                    forma_pago      = @forma_pago,
                    fecha_pago      = @fecha_hoy,
      tipo_canje      = 'E',
                    tipo_ingreso    = @camara
   insert into gen_pagos_operacion select * from #PASO
   if @@error <> 0 
   begin
      PRINT 'ERROR_PROC FALLA AGREGANDO PAGOS OPERACION'
      return 1
   end
end
return 0
end   /* fin procedimiento */
--select * from gen_pagos_operacion 

GO
