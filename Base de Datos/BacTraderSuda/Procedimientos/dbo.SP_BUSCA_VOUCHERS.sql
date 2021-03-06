USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_VOUCHERS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_VOUCHERS]
            ( @fecha_hoy  datetime )
as 
begin
declare @registros integer
select @registros = count(*)
  from BAC_CNT_DETALLE_VOUCHER, BAC_CNT_VOUCHER
 where BAC_CNT_VOUCHER.numero_voucher = BAC_CNT_DETALLE_VOUCHER.numero_voucher
   and BAC_CNT_VOUCHER.fecha_ingreso  = @fecha_hoy
select @registros,
       BAC_CNT_DETALLE_VOUCHER.numero_voucher,
       BAC_CNT_DETALLE_VOUCHER.cuenta,
       BAC_CNT_DETALLE_VOUCHER.tipo_monto,
       BAC_CNT_DETALLE_VOUCHER.monto
  from BAC_CNT_VOUCHER, BAC_CNT_DETALLE_VOUCHER
 where BAC_CNT_VOUCHER.numero_voucher = BAC_CNT_DETALLE_VOUCHER.numero_voucher
   and BAC_CNT_VOUCHER.fecha_ingreso  = @fecha_hoy
end   /* fin procedimiento */


GO
