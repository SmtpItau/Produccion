USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABAR_DETALLE_PAGOS1]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_GRABAR_DETALLE_PAGOS1]  
 ( @iCorrela   SMALLINT  
 , @nContrato   NUMERIC(9)  
 , @cModulo   CHAR(5)  
 , @cMoneda   VARCHAR(5)  
 , @iFormaPago   SMALLINT  
 , @nMonto    NUMERIC(21,4)  
 , @iRutBeneficiario NUMERIC(9)  
 , @sDigBeneficiario CHAR(1)  
 , @sNomBeneficiario VARCHAR(50)  
 , @sNomBanco   VARCHAR(50)  
 , @sSwift    VARCHAR(20)  
 , @sCtaCte   VARCHAR(20)  
 , @sUsuario   VARCHAR(15)  
 , @cObservaciones  VARCHAR(255)  
 ,	@iRutCliente		NUMERIC(10)
,	@iCodigo			SMALLINT
 , @iIdPago   NUMERIC(9)  
 , @iSecuencia   INT  
 )  
AS  
BEGIN  
   
 SET NOCOUNT ON  
  
 DECLARE @iMoneda SMALLINT  
  SET @iMoneda = (SELECT TOP 1 mncodmon FROM BacParamSuda.dbo.MONEDA WHERE mnnemo = @cMoneda)  
    
 DECLARE @iRutclie NUMERIC(10)  
 DECLARE @sDV  VARCHAR(01)    
   
  

 SET @sDV  =(SELECT vsb.Cldv  
	        		   FROM view_sadp_bancos vsb WHERE vsb.Clrut=@iRutCliente);
    
 SET @iRutclie = (SELECT rut_cliente  
	                   FROM mdlbtr		, dbo.sadp_control  c WHERE	numero_operacion = @nContrato
					      AND sistema			 = @cModulo
						  AND moneda			 = @iMoneda  
		AND		Secuencia		= @iSecuencia AND c.dFechaProceso = mdlbtr.fecha);
     
 IF @iCorrela = 1  
 BEGIN  
  UPDATE dbo.SADP_DETALLE_PAGOS  
  SET  cEstado   = 'APM'  
  WHERE nContrato  = @nContrato  
  AND  iSecuencia  = @iSecuencia   
  AND  cModulo   = @cModulo  
  AND  iMoneda   = @iMoneda  
  
  
		UPDATE	dbo.MDLBTR
	SET		estado_envio     = 'PF1'
		,		forma_pago		 = @iFormaPago --> Se agrega forma de pago 		
	,		RecCtaCte		 = @sCtaCte
	WHERE	numero_operacion = @nContrato
	AND		sistema			 = @cModulo
	AND		moneda			 = @iMoneda  
		AND		Secuencia		= @iSecuencia  
	END
	
 INSERT INTO dbo.SADP_DETALLE_PAGOS  
 SELECT nContrato   = @nContrato  
 ,  cModulo    = @cModulo  
 ,  iMoneda    = @iMoneda  
 ,  iFormaPago   = @iFormaPago  
 ,  nMonto    = @nMonto  
 ,  iRutBeneficiario = @iRutBeneficiario  
 ,  sDigBeneficiario = @sDigBeneficiario  
 ,  sNomBeneficiario = @sNomBeneficiario  
 ,  sNomBanco   = @sNomBanco  
 ,  sSwift    = @sSwift  
 ,  sCtaCte    = @sCtaCte  
 ,  sUsuario   = @sUsuario  
 ,  sFirma1    = ''  
 ,  sFirma2    = ''  
 ,  cEstado    = 'PF1'  
 ,  cObservaciones  = @cObservaciones   
 ,  iRutCliente   = @iRutclie  
 ,  iCodigo    = @iCodigo  
 ,  iRutBanco           = @iRutCliente  
	,		sDvBanco			= ISNULL(@sDV,'') --> Control para infgreso de operaciones de Vale Vistas		 
 ,  vNumTransferencia = 0  
 ,  sEnviadoPor   = ''  
	,		@iSecuencia
  
  
 IF NOT EXISTS( SELECT 1 FROM dbo.SADP_BENEFICIARIOS WHERE nRutBeneficiario = @iRutBeneficiario AND nRutBanco = @iRutCliente AND cCtaCte = @sCtaCte )  
 BEGIN  
  INSERT INTO dbo.SADP_BENEFICIARIOS  
  SELECT nRutBeneficiario = @iRutBeneficiario  
   , cDvBeneficiario  = @sDigBeneficiario  
   , cNomBeneficiario = @sNomBeneficiario  
   , nRutBanco   = @iRutCliente  
   , nCodBanco   = @iCodigo  
   , cCtaCte    = @sCtaCte  
 END  
   
END  

GO
