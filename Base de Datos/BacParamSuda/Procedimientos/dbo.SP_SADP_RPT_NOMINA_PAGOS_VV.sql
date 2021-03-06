USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_RPT_NOMINA_PAGOS_VV]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_SADP_RPT_NOMINA_PAGOS_VV]( @dFecProceso DATETIME='')  
AS   
BEGIN   
  
  
 SELECT ml.SISTEMA                AS origen  
 ,  ml.tipo_operacion  
 ,  ISNULL(sme.Descripcion,'ND')           AS sistema  
 ,  ISNULL(spm.Producto,'ND')            AS tipooperacion  
 ,  ml.numero_operacion  
 ,  RTRIM(CONVERT(CHAR(10),sdp.iRutBeneficiario))+'-'+sdp.sDigBeneficiario AS RUT  
 ,  sdp.sNomBeneficiario  
 ,  ISNULL(vsb.Clnombre,'NO DEFINIDO')          AS BANCO  
 ,  sdp.sCtaCte  
 ,  sdp.nMonto    
 ,  fdp.glosa  
 ,  sdp.vNumTransferencia  
   FROM MDLBTR ml  
  INNER   
   JOIN SADP_DETALLE_PAGOS sdp   
     ON ml.sistema= sdp.cModulo  
    AND ml.numero_operacion=sdp.nContrato  
	   AND ml.Secuencia = sdp.iSecuencia	--> Faltaban las secuencias! jbh
    AND sdp.iFormaPago =5    
   LEFT   
   JOIN view_sadp_bancos vsb  
     ON vsb.Clrut= sdp.iRutBanco      
   LEFT   
   JOIN SADP_MODULOS_EXTERNOS sme  
  ON sme.Nemo =ml.sistema  
   LEFT   
   JOIN SADP_PRODUCTO_MODULOEXTERNO spm  
  ON spm.Modulo=ml.sistema  
    AND spm.Codigo=ML.tipo_mercado  
  LEFT   
  JOIN FORMA_DE_PAGO fdp  
    ON FDP.codigo= sdp.iFormaPago       
  WHERE ml.fecha = @dFecProceso   
    AND ml.sistema IN('GPI','FFMM','CDB')  
    AND ml.estado_envio ='E'  
UNION  
 SELECT ml.sistema  
 ,  ml.tipo_operacion  
 , 'BANCO' AS sistema  
 ,ISNULL(PR.descripcion,'ND') as tipooperacion   
 , ml.numero_operacion  
 ,RTRIM(CONVERT(CHAR(10),sdp.iRutBeneficiario))+'-'+sdp.sDigBeneficiario  
 ,sdp.sNomBeneficiario  
 ,ISNULL(vsb.Clnombre,'NO DEFINIDO')  
 ,sdp.sCtaCte  
 ,sdp.nMonto  
 ,  fdp.glosa    
 ,  sdp.vNumTransferencia  
   FROM MDLBTR ml  
  INNER   
   JOIN SADP_DETALLE_PAGOS sdp   
     ON ml.sistema= sdp.cModulo  
    AND ml.numero_operacion=sdp.nContrato   
	   AND ml.Secuencia = sdp.iSecuencia	--> Faltaban las secuencias! jbh
    AND sdp.iFormaPago=5   
   LEFT   
   JOIN view_sadp_bancos vsb  
     ON vsb.Clrut= sdp.iRutBanco      
   LEFT   
   JOIN PRODUCTO   pr with(nolock) ON pr.id_sistema = mL.sistema AND pr.codigo_producto = mL.tipo_mercado  
  LEFT   
  JOIN FORMA_DE_PAGO fdp  
    ON FDP.codigo= sdp.iFormaPago       
  WHERE ml.fecha = @dFecProceso   
    AND ml.sistema NOT IN('GPI','FFMM','CDB')  
    AND ml.estado_envio ='E'  
   
END

GO
