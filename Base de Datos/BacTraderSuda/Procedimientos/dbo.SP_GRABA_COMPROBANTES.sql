USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_COMPROBANTES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_COMPROBANTES]( @xsistema  char(3)  ,
     @xtipooperacion  char(5)  ,
     @xnumerooperacion numeric(10) ,
     @xnumerocomprobante numeric(10) ,
     @xtipocomprobante numeric(02) ,
     @xcorrela_pago  numeric(5) ,
     @xcorrelativo  numeric(5) )
as
begin
update GEN_PAGOS_OPERACION set  numero_documento = @xnumerocomprobante,
        estado         = 'A'
      where operacion  =  @xnumerooperacion
        and id_sistema =  @xsistema
       and estado  <> 'n'
       and correla_pago = @xcorrela_pago
           and correlativo = @xcorrelativo
 
end   /* fin procedimiento */

GO
