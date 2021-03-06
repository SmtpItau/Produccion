USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SPUFI_DERIVADOS]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SPUFI_DERIVADOS]
AS
declare @cantreg integer
select @cantreg = (select count(*) from carteramoneda)
insert into cuenta_contable
values('212700400000600', '412700400000700','CLP', 'CLP', 'CO', '', '', 'FWIRF')
insert into cuenta_contable
values('212700400000600', '412700400000700','CLP', 'CLP', 'EF', '', '', 'FWIRF')
BEGIN TRAN
UPDATE CARTERAMONEDA
SET CtaActivo = (select cuenta_activo
  from cuenta_contable
  where tipo_operacion = Tipoope
  and moneda_pago = monedapago
  and moneda_recibe = monedarec
  and cuenta_contable.modalidad = carteramoneda.modalidad)
IF @@ROWCOUNT = @CANTREG
 BEGIN 
     COMMIT TRANSACTION
     PRINT "ACTUALIZACION DE CUENTA ACTIVO REALIZADA CORRECTAMENTE"
 END
ELSE
 BEGIN
     ROLLBACK TRANSACTION
     PRINT "ACTUALIZACION DE CUENTA ACTIVO NO REALIZADA"
 END
BEGIN TRAN
UPDATE CARTERAMONEDA
SET CtaPasivo = (select cuenta_PASIVO
  from cuenta_contable
  where tipo_operacion = Tipoope
  and moneda_pago = monedapago
  and moneda_recibe = monedarec
  and cuenta_contable.modalidad = carteramoneda.modalidad)
IF @@ROWCOUNT = @CANTREG
 BEGIN 
     COMMIT TRANSACTION
     PRINT "ACTUALIZACION DE CUENTA PASIVO REALIZADA CORRECTAMENTE"
 END
ELSE
 BEGIN
     ROLLBACK TRANSACTION
     PRINT "ACTUALIZACION DE CUENTA PASIVO NO REALIZADA"
 END
GO
