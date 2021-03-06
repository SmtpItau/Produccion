USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_ACTUALIZA_FECHAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_SADP_ACTUALIZA_FECHAS] ( @dFecha DATETIME)    
AS    
BEGIN    
    
 SET NOCOUNT ON    
      
 DECLARE @dFecpro DATETIME    
 ,  @dFecant DATETIME    
 ,  @dFecprx DATETIME    
     
 SELECT  @dfecAnt = dFechaProceso     
 ,  @dFecprx = DATEADD(DAY,1,@dFecha)    
  FROM bacparamsuda.dbo.SADP_CONTROL    
      
 UPDATE SADP_CONTROL    
    SET dFechaAnterior = @dFecant    
 ,  dFechaProceso = @dFecha    
 ,  dFechaProxima = @dFecprx    
 ,  bSwCargaFFMM = 0    
 ,  bSwCargaCDB = 0    
 ,  bConeccionListener = 0;    
    
    
    
 INSERT INTO dbo.SADP_DETALLE_PAGOS_HISTORICO    
 ( [Fecha]    
 , [nContrato]    
 , [cModulo]    
 , [iMoneda]    
 , [iFormaPago]    
 , [nMonto]    
 , [iRutBeneficiario]    
 , [sDigBeneficiario]    
 , [sNomBeneficiario]    
 , [sNomBanco]    
 , [sSwift]    
 , [sCtaCte]    
 , [sUsuario]    
 , [sFirma1]    
 , [sFirma2]    
 , [cEstado]    
 , [cObservaciones]    
 , [iRutCliente]    
 , [iCodigo]    
 , [iRutBanco]    
 , [sDvBanco]    
 , [vNumTransferencia]    
 , [sEnviadoPor]    
 , [iSecuencia]    
 )    
 SELECT    
  @dfecAnt     
 , [nContrato]    
 , [cModulo]    
 , [iMoneda]    
 , [iFormaPago]    
 , [nMonto]    
 , [iRutBeneficiario]    
 , [sDigBeneficiario]    
 , [sNomBeneficiario]    
 , [sNomBanco]    
 , [sSwift]    
 , [sCtaCte]    
 , [sUsuario]    
 , [sFirma1]    
 , [sFirma2]    
 , [cEstado]    
 , [cObservaciones]    
 , [iRutCliente]    
 , [iCodigo]    
 , [iRutBanco]    
 , [sDvBanco]    
 , [vNumTransferencia]    
 , [sEnviadoPor]    
 , [iSecuencia]    
  FROM  SADP_DETALLE_PAGOS sdp    
        
    
 TRUNCATE TABLE SADP_DETALLE_PAGOS      
    
END     
  
GO
