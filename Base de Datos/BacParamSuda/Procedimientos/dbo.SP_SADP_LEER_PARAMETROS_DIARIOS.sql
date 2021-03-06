USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_PARAMETROS_DIARIOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_PARAMETROS_DIARIOS]   
AS  
BEGIN  
 DECLARE @dFecpro DATETIME  
 ,  @dFecant DATETIME  
 ,  @dFecprx DATETIME  
   
   
 SELECT  
  dFechaAnterior,  
  dFechaProxima,  
  dFechaProxima,  
  CASE WHEN bCierreDia =0 THEN  'NO' ELSE 'OK' END  
  dFechaProxima,          
  bSwCargaFFMM,  
  bSwCargaCDB,  
  bEnvioLBTR,  
  bEnvioVVista,  
  bEnvioCtaCte,  
  idTx_Manual  
 FROM SADP_CONTROL;  
END
GO
