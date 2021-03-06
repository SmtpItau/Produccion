USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_AUTORIZA_MVTOS_MANUALES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_SADP_AUTORIZA_MVTOS_MANUALES]    
 ( @dFecha    DATETIME    
 , @cUsuario   VARCHAR(15)    
 , @id_Transaccion  NUMERIC(9)    
 )    
AS    
BEGIN    
     
 SET NOCOUNT ON    
    
 BEGIN TRANSACTION    
    
 DECLARE @iMaxFolioMdlbtr NUMERIC(9)    
  SET @iMaxFolioMdlbtr = ( SELECT MAX( numero_operacion ) FROM MDLBTR )    
    
 INSERT INTO MDLBTR    
 SELECT fecha    = @dFecha    
  , sistema    = mm.sOrigen    
  , tipo_mercado  = mm.Tipo_Operacion    
  , tipo_operacion  = mm.Tipo_Operacion    
  , estado_envio  = (CASE WHEN iFormadPago = 0 THEN 'PF1' ELSE 'PF2' END)    
  , numero_operacion = @iMaxFolioMdlbtr + mm.id_Transaccion    
  , rut_cliente   = mm.RutCliente    
  , codigo_cliente  = 1    
  , moneda    = mm.sMoneda    
  , monto_operacion  = mm.Monto    
  , forma_pago   = (CASE WHEN iFormadPago = 1 THEN 128 WHEN iFormadPago = 2 THEN 5 when mm.iFormadPago = 3 THEN 103 when mm.iFormadPago = 4 THEN 134 ELSE 0 END)       
  , fecha_operacion  = mm.dFechaCarga    
  , fecha_vencimiento = mm.dFechaMovto    
  , liquidada   = ''    
  , RecRutBanco   = isnull(bb.Clrut, 0)    
  , RecCodBanco   = isnull(bb.Clcodigo, 0)    
  , RecCodSwift   = isnull(bb.Clswift, '')    
  , RecDireccion  = isnull(bb.Cldirecc,'')    
  , RecCtaCte   = mm.sCuenta    
  , Tipo_Movimiento  = mm.Movimiento    
  , GlosaAnticipo  = ''    
  , Id_Paquete   = 0    
  , Estado_Paquete  = 'D'    
  , Reservado   = ''    
  , 1    
 FROM BacParamSuda.dbo.SADP_MOVIMIENTOS_MANUALES    mm    
   LEFT  JOIN BacParamSuda.dbo.VIEW_SADP_BANCOS   bb ON bb.Clrut= mm.iBanco    
 WHERE mm.sUserAutoriza = ''    
 AND  mm.id_Transaccion   = @id_Transaccion    
 AND  mm.dFechaMovto  = @dFecha    
     
     
IF @@ERROR <> 0   
 BEGIN    
  ROLLBACK TRANSACTION    
  RETURN    
 END    
     
 INSERT INTO SADP_DETALLE_PAGOS    
 SELECT nContrato   = @iMaxFolioMdlbtr + mm.id_Transaccion    
  , cModulo    = mm.sOrigen    
  , iMoneda    = mm.sMoneda    
  , forma_pago   = (CASE WHEN iFormadPago = 1 THEN 128 WHEN iFormadPago = 2 THEN 5 when mm.iFormadPago = 3 THEN 103 when mm.iFormadPago = 4 THEN 134 ELSE 0 END)    
  , nMonto    = mm.Monto    
  , iRutBeneficiario = mm.RutCliente    
  , sDigBeneficiario = mm.sDvBeneficiario    
  , sNomBeneficiario = mm.sBeneficiario    
  , sNomBanco   = isnull(bb.Clnombre,'')    
  , sSwift    = isnull(bb.Clswift, '')    
  , sCtaCte    = mm.sCuenta    
  , sUsuario   = @cUsuario    
  , sFirma1    = @cUsuario    
  , sFirma2    = ''    
  , cEstado    = (CASE WHEN iFormadPago = 0 THEN 'PF1' ELSE 'PF2' END)    
  , cObservaciones  = ''    
  , iRutCliente   = mm.RutCliente    
  , iCodigo    = 1    
  , iRutBanco   = isnull(bb.Clrut, 0)    
  , sDvBanco   = isnull(bb.cldv, '')    
  , vNumTransferencia = 0    
  , sEnviadoPor   = @cUsuario    
  ,1    
 FROM BacParamSuda.dbo.SADP_MOVIMIENTOS_MANUALES    mm    
   LEFT  JOIN BacParamSuda.dbo.VIEW_SADP_BANCOS   bb ON bb.Clrut= mm.iBanco    
 WHERE mm.sUserAutoriza = ''    
 AND  mm.id_Transaccion   = @id_Transaccion    
 AND  mm.dFechaMovto  = @dFecha    
    
 IF @@ERROR <> 0   
 BEGIN    
  ROLLBACK TRANSACTION    
  RETURN    
 END    
    
 UPDATE BacParamSuda.dbo.SADP_MOVIMIENTOS_MANUALES    
 SET  sUserAutoriza  = @cUsuario    
 WHERE sUserAutoriza  = ''    
 AND  id_Transaccion  = @id_Transaccion    
    
 COMMIT TRANSACTION    
    
END
    
GO
