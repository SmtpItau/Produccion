USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DOCUMENTO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_DOCUMENTO]( @numero_documento  numeric(10) ,
                                @codigo_banco      numeric(3)  )
as 
begin
declare @fecha_hoy      datetime   ,
        @vcamara        char(4)    ,
        @bcentral       char(4)
select @fecha_hoy  = acfecproc from MDAC
--aqui
select @vcamara  = convert(char(4),folio) from GEN_FOLIOS where codigo = 'CAMARA'
select @bcentral = convert(char(4),folio) from GEN_FOLIOS where codigo = 'BCENTRAL'
select forma_pago,
       monto_operacion
  from GEN_PAGOS_OPERACION 
 where numero_documento = @numero_documento
   and codigo_banco     = @codigo_banco
   and tipo_canje       = 'E'
   and (estado = 'A' or estado = 'C')
   and ((fecha_pago  = @fecha_hoy and forma_pago = @vcamara) or 
        (fecha_pago <> @fecha_hoy and forma_pago <> @vcamara and forma_pago <> @bcentral))
 
end   /* fin procedimiento */
--sp_help GEN_PAGOS_OPERACION


GO
