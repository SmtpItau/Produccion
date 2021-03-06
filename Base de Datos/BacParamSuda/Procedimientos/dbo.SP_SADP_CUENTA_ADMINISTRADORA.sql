USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CUENTA_ADMINISTRADORA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[SP_SADP_CUENTA_ADMINISTRADORA]  
AS  
BEGIN  
   
 DECLARE @dFecha DATETIME  
     SET @dFecha = (SELECT dFechaProceso   
                      FROM bacparamsuda.dbo.SADP_Control);  
  
 SELECT 0          AS CodFondo  
 ,  sBeneficiario       AS Fondo  
	,	    ISNULL(scc.sCuentaCorriente, 'N/A' )	AS CtaCte
 ,       m.mnsimbol          AS Moneda  
 ,  SUM(fmc.MONTO_MOVIMIENTO-fmc.COMISION_UM_MOV)   
    FROM fmparticipes.dbo.fmp_movimientos_cursados fmc  
   INNER   
    JOIN SADP_ConversionMoneda scm  
      ON scm.sSistema ='FFMM'  
     AND scm.iCodMoneda =fmc.COD_MONEDA  
      INNER   
   JOIN bacparamsuda.dbo.SADP_CuentasCorrientes scc  
     ON scc.iRutCliente = 96513630  
    AND scc.iCodCliente = 0   
       AND scc.bPrincipal =1  
       AND scc.id_banco=27     
       AND scc.iCodMoneda =scm.iCodSADP       
  INNER  
   JOIN MONEDA m  
     ON m.mncodmon = iCodSADP             
  WHERE FMC.TIPO_MOVIMIENTO = 'R'  
    AND fmc.fecha_pago=@dFecha  
  GROUP   
     BY iCodSADP,sBeneficiario,sCuentaCorriente ,mnsimbol            
  
  
END  
GO
