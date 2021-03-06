USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CANJE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_GRABA_CANJE]( @tipo_canje      char(1)     ,
                            @nro_docto       numeric(10) ,
                            @tipo_docto      char(4)     ,
                            @monto           float       ,
                            @codigo_banco    numeric(5)  ,
                            @fecha_cobro     datetime    )
as 
begin
if @tipo_canje = 'e' 
   update GEN_PAGOS_OPERACION 
      set estado       = 'c',
          fecha_cobro  = @fecha_cobro
    where numero_documento = @nro_docto
      and forma_pago       = @tipo_docto
      and tipo_canje       = @tipo_canje
      and monto_operacion  = @monto
      and codigo_banco     = @codigo_banco
else
   update GEN_PAGOS_OPERACION 
      set estado       = 'C',
          codigo_banco = @codigo_banco,
          fecha_cobro  = @fecha_cobro
    where numero_documento = @nro_docto
      and forma_pago       = @tipo_docto
      and tipo_canje       = @tipo_canje
      and monto_operacion  = @monto
end   /* fin procedimiento */


GO
