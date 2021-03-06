USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_APROBACIONES_ADMINISTRATIVAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[SP_SADP_APROBACIONES_ADMINISTRATIVAS]    
 ( @cOrigen VARCHAR(4)    
 , @nContrato NUMERIC(9)    
 , @nIdPago NUMERIC(9)    
 , @cUsuario VARCHAR(15)    
 )    
AS    
BEGIN    
     
 SET NOCOUNT ON    
    
 DECLARE @iFoundError  SMALLINT    
 DECLARE @oEstado   VARCHAR(5)    
 DECLARE @oUsuario   VARCHAR(15)    
 DECLARE @oFirma1   VARCHAR(15)    
 DECLARE @oFirma2   VARCHAR(15)    
 DECLARE @oError    VARCHAR(100)    
 DECLARE @nFormaPago   INT    
 DECLARE @iSecuencia   NUMERIC(10)  
     
  SET @iFoundError  = 0    
  SET @oEstado   = ''    
  SET @oUsuario   = ''    
  SET @oFirma1   = ''    
  SET @oFirma2   = ''    
  SET @oError    = ''    
  SET @nFormaPago   = 0    
    
 SELECT  @oEstado   = cEstado    
  , @oUsuario   = sUsuario    
  , @oFirma1   = sFirma1    
  , @oFirma2   = sFirma2    
  , @oError    = ''    
  , @nFormaPago   = iFormaPago    
  , @iSecuencia = iSecuencia    
 FROM dbo.SADP_DETALLE_PAGOS    
 WHERE cModulo    = @cOrigen    
 AND  nContrato   = @nContrato    
 AND  Id_Detalle_Pago  = @nIdPago    
    
 --> Validacion por Medio de Pago  
    
 --> Validacion por datos del beneficiario  
  SET @iFoundError = 0    
 SELECT @iFoundError = 1 
 FROM dbo.SADP_DETALLE_PAGOS    
 WHERE cModulo    = @cOrigen    
 AND  nContrato   = @nContrato    
 AND  Id_Detalle_Pago  = @nIdPago    
 AND ( iRutBeneficiario = 0     
   OR sDigBeneficiario = ''     
   OR sNomBeneficiario = ''  )    
     
     
 --> Cambios de estado <--  
  UPDATE dbo.SADP_DETALLE_PAGOS     
  SET  sFirma2   = @cUsuario    
  ,  iFormaPago  = 222      
  ,  cEstado   = 'E'    
  WHERE cModulo   = @cOrigen    
  AND  nContrato  = @nContrato    
  AND  Id_Detalle_Pago = @nIdPago    
    
   UPDATE dbo.MDLBTR     
   SET  estado_envio  = 'E'    
   ,forma_pago = 222         
   WHERE sistema    = @cOrigen    
   AND  numero_operacion = @nContrato    
   AND Secuencia =  @iSecuencia  
    
 SELECT 0, 'Se ha actualizado el estado de la operación.'    
     
END    
  

GO
