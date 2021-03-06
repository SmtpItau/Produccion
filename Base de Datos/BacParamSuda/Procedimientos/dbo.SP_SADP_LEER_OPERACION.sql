USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_OPERACION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_OPERACION]  
 ( @cOrigen CHAR(5)  
 , @iContrato NUMERIC(9)  
 , @cMoneda VARCHAR(5)  
 , @iSecuencia INT=1  
 )  
AS  
BEGIN  
   
 SET NOCOUNT ON  
  
 DECLARE @iMoneda INT  
  SET @iMoneda = (SELECT mncodmon FROM BacParamSuda.dbo.MONEDA WHERE mnnemo = @cMoneda)     
  
 DECLARE @nMonto  NUMERIC(21,0)  
  SET @nMonto  =  (SELECT SUM( nMonto ) FROM dbo.SADP_DETALLE_PAGOS   
        WHERE nContrato = @iContrato AND  iSecuencia = @iSecuencia AND cModulo = @cOrigen AND iMoneda = @iMoneda  
        AND   cEstado  IN('', 'P', 'E', 'PF1', 'PF2')   
                 GROUP BY nContrato, cModulo)  
  
 SELECT  Id    = dPago.Id_Detalle_Pago  
  , Codigo   = fpa.codigo  
  , GlosaPago  = fpa.glosa  
  , Monto   = dPago.nMonto  
  , Saldo   = 0  
  , Rut    = LTRIM(RTRIM( dPago.iRutBeneficiario )) + '-' + LTRIM(RTRIM( dPago.sDigBeneficiario ))  
  , Nombre   = dPago.sNomBeneficiario  
  , CtaCte   = dPago.sCtaCte  
  , Banco   = dPago.sNomBanco  
  , Total   = @nMonto  
  , Moneda   = LTRIM(RTRIM( mn1.mnnemo )) + ' - ' + mn1.mnglosa  
  , Observ   = dPago.cObservaciones  
  , Swift   = dpago.sSwift  
		,   RutBanco  	    = CASE WHEN vsb.clcodigo < 9 THEN LTRIM(RTRIM( iRutBanco)) + '0' + LTRIM(RTRIM( vsb.clcodigo ))
             ELSE     LTRIM(RTRIM( iRutBanco))  + LTRIM(RTRIM( vsb.clcodigo )) END   
		,	Estado			= dpago.cEstado
 FROM dbo.SADP_DETALLE_PAGOS      dPago  
   LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO fpa with(nolock) ON fpa.codigo   = dPago.iFormaPago  
   LEFT JOIN BacParamSuda.dbo.MONEDA   mn1 with(nolock) ON mn1.mncodmon = @iMoneda  
   LEFT JOIN view_sadp_bancos vsb ON vsb.Clrut = dpago.iRutBanco  
 WHERE dPago.nContrato = @iContrato  
 AND  iSecuencia = @iSecuencia  
 AND  dPago.cModulo = @cOrigen  
 AND     dPago.iMoneda = @iMoneda  
 AND  dpago.cEstado IN('', 'P', 'E', 'PF1', 'PF2')  
  
END  
GO
