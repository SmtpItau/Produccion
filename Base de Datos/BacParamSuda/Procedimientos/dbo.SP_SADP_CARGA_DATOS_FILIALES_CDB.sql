USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CARGA_DATOS_FILIALES_CDB]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_CARGA_DATOS_FILIALES_CDB]( @dFechaProceso DATETIME, @sUsuario VARCHAR(15) )  
AS   
BEGIN  
 SET NOCOUNT ON;  
  
 DECLARE @iNumMov  NUMERIC(10) ;  
   
  SET @iNumMov  = (SELECT iNumMovCDB  FROM SADP_CONTROL);  
   
 DECLARE @sFecha DATETIME  
  SET @sFecha  =(SELECT sc.dFechaProceso FROM SADP_Control sc);  
  
 SELECT *, 'Estado'=CONVERT(CHAR(1),''), 'Nombre'=CONVERT(CHAR(50),''), 'DV'=CONVERT(VARCHAR(1),'') INTO #t_mdlbtr FROM MDLBTR WHERE 1=2  
   
   
 CREATE TABLE #Cuentas   
 ( Rut   NUMERIC(09)  
 , dvx   VARCHAR(01)  
 , rutdvx  VARCHAR(15)  
 , nombrex  VARCHAR(50)  
 , dire  VARCHAR(70)  
 , forpago  VARCHAR(70)  
 , codBanco INT  
 , Cuenta  VARCHAR(70)  
 , codforPago SMALLINT  
 , Tipo  VARCHAR(10) )   
  
  
 INSERT INTO #Cuentas  
 SELECT p.per_id                 AS Rut  
 ,    p.per_dv       COLLATE SQL_Latin1_General_CP1_CI_AS AS dvx  
 ,    p.per_rutdv      COLLATE SQL_Latin1_General_CP1_CI_AS AS Rutdvx    
 ,    SUBSTRING(p.per_raz_social,1,50) COLLATE SQL_Latin1_General_CP1_CI_AS AS nombrex  
 ,    SUBSTRING(ISNULL(DirFEPART.sDire,''),1,50)  COLLATE SQL_Latin1_General_CP1_CI_AS AS dire  
 ,    ISNULL(forma_pago,'NA')   COLLATE SQL_Latin1_General_CP1_CI_AS AS ForPago  
 ,    ISNULL( banREL.ban_equivale,0)           AS CodBanco  
 ,    ISNULL(identific_docto,'')  COLLATE SQL_Latin1_General_CP1_CI_AS AS Cuenta  
 ,    CONVERT(SMALLINT,0)              AS codForPago  
 ,    mov.cod_movto    
   FROM LNKBACBDC72.BDC72.DBO.TBCTMSCF fac  
  INNER    
   JOIN LNKBACBDC72.BDC72.DBO.PERSONA p   
  ON fac.rut_cli = p.per_rutdv  
   LEFT   
   JOIN (SELECT per_id   AS iRut  
   ,     dir_presentacion AS sDire  
   ,    com_id  
     FROM LNKBACBDC72.BDC72.DBO.DIRECCION  
       INNER   
        JOIN (SELECT per_id   AS iRut  
     ,      MAX(dir_id) AS dirCode  
             FROM LNKBACBDC72.BDC72.DBO.Direccion  
      WHERE par_tdi_id ='TDIREFPART'    
      GROUP        
      BY per_id) AS DirFPART  
    ON DirFPART.irut = irut  
         AND DirFPART.dirCode = dir_id) DirFEPART  
         ON  DirFEPART.iRut = P.per_id  
   LEFT   
   JOIN lnkbacbdc72.bdc72.dbo.tbctmvto mov  
  ON mov.folio_comp_adj = fac.folio_comp_fac   
   LEFT  
   JOIN sadp_rel_bancos_cdb banrel   
     ON banREL.ban_id = cod_bco_pago  COLLATE SQL_Latin1_General_CP1_CI_AS     
  WHERE fec_pago    =  CONVERT(CHAR(10),@dFechaProceso,121)  
    AND fac.mercado   = 'AC'  
 UNION     
 SELECT p.per_id                 AS Rut  
 ,    p.per_dv       COLLATE SQL_Latin1_General_CP1_CI_AS AS dvx  
 ,    p.per_rutdv      COLLATE SQL_Latin1_General_CP1_CI_AS AS Rutdvx    
 ,    substring(p.per_raz_social,1,50)     collate SQL_Latin1_General_CP1_CI_AS AS nombrex  
 ,    SUBSTRING(ISNULL(DirFEPART.sDire,''),1,50)  COLLATE SQL_Latin1_General_CP1_CI_AS AS dire  
 ,    ISNULL(forma_pago,'NA')   COLLATE SQL_Latin1_General_CP1_CI_AS AS ForPago  
 ,    ISNULL(banrel.ban_equivale,0)           AS CodBanco  
 ,    ISNULL(identific_docto,'')   COLLATE SQL_Latin1_General_CP1_CI_AS AS Cuenta  
 ,    CONVERT(SMALLINT,0)              AS codForPago  
 ,    mov.cod_movto    
   FROM LNKBACBDC72.BDC72.DBO.TBCTMVTO mov  
  INNER    
   JOIN LNKBACBDC72.BDC72.DBO.persona p   
  ON mov.rut_cli = p.per_rutdv  
   LEFT   
   JOIN (SELECT  per_id  AS iRut  
  ,  dir_presentacion AS sDire  
  , com_id  
     FROM LNKBACBDC72.BDC72.DBO.direccion  
    INNER   
     JOIN (SELECT per_id      AS iRut,    
    MAX(dir_id)  AS dirCode  
      FROM LNKBACBDC72.BDC72.DBO.Direccion  
     WHERE par_tdi_id ='TDIREFPART'    
     GROUP        
        BY per_id) as DirFPART  
       ON DirFPART.irut = irut  
      AND DirFPART.dirCode = dir_id) DirFEPART  
      ON  DirFEPART.iRut = P.per_id  
 LEFT JOIN SADP_REL_BANCOS_CDB banREL ON banREL.ban_id = cod_bco_pago collate SQL_Latin1_General_CP1_CI_AS           
  WHERE mov.fec_liquid= CONVERT(CHAR(10),@dFechaProceso,121)  
    AND mov.ind_anulado != 'A'  
    AND (  
       ( mov.mercado     = 'AC' AND ( mov.cod_movto  = 'DIPE') )  
    OR (mov.MERCADO      = 'RF' AND ( mov.COD_MOVTO in ('PACU', 'VTIF', 'VIRF','CIRF','CIIF') ) )  
    OR (mov.MERCADO      =''  AND NEMO   = 'PACTO'    AND mov.COD_MOVTO IN ('ABMN', 'CAMN'))-->'ABDO' ) )  
        )  
  GROUP   
     BY  
        p.per_id  
 ,    p.per_rutdv  
 ,  p.per_dv         
 ,    p.per_raz_social  
 ,    DirFEPART.sDire  
 ,    forma_pago  
 ,    banREL.ban_equivale  
 ,    identific_docto  
 ,    mov.cod_movto  
   
 /* Actualiza el Codigo Interno   
 -------------------------------------------------------------------------------------------------- */  
 UPDATE #Cuentas SET codForPago =  CONVERT(SMALLINT,srf.nCodInterno)  
   FROM #Cuentas ct  
  INNER   
   JOIN  SADP_RELACION_FPAGO srf  
     ON srf.cOrigen= 'CDB'  
    AND srf.nCodExterno =  ct.ForPago     ;  
     
 /* Proceso de Carga de Informacion de Bolsa de Comercio movimiento de Acciones  
 -------------------------------------------------------------------------------------------------- */  
 SELECT IDENTITY(NUMERIC(10))  AS Registro  
 ,    cta.rut      AS xRut    
 ,    SUM(monto_total)    AS Monto  
 ,    cta.dvx          --> Cambio 1309  
 ,    cta.nombrex         --> Cambio 1309  
   INTO #temp  
   FROM LNKBACBDC72.bdc72.dbo.TBCTMSCF  fac  
  INNER   
   JOIN (select distinct rut,Rutdvx,dvx,nombrex from #cuentas) cta  
     ON cta.Rutdvx collate SQL_Latin1_General_CP1_CI_AS  = fac.rut_cli  
  WHERE fec_pago    = CONVERT(CHAR(10),@dFechaProceso,121)  
    AND fac.mercado   = 'AC'  
  GROUP  
     BY cta.rut,cta.dvx,nombrex  
 HAVING SUM(monto_total)>0  
  
 UPDATE #temp  
    SET monto= CASE WHEN ISNULL(fMontoSaldo,0)<=0   THEN 0   
       WHEN  (MONTO <= ISNULL(fMontoSaldo,0)) THEN MONTO   
       WHEN (MONTO >= ISNULL(fMontoSaldo,0)) THEN ISNULL(fMontoSaldo,0) END         
   FROM #temp   
   LEFT    
   JOIN SADP_CUENTA_CAJA scc  
     ON scc.iRutCliente = xRut  
    AND dFechaSaldo = @dFechaProceso  
         
 DELETE FROM #temp WHERE monto <= 0;  
   
  
 INSERT INTO #t_mdlbtr  
 ( fecha                     
 , sistema   
 , tipo_mercado   
 , tipo_operacion   
 , estado_envio   
 , numero_operacion                          
 , rut_cliente                               
 , codigo_cliente                            
 , moneda                                    
 , monto_operacion              
 , forma_pago                                
 , fecha_operacion           
 , fecha_vencimiento         
 , liquidada   
 , RecRutBanco                               
 , RecCodBanco                               
 , RecCodSwift            
 , RecDireccion                                                             
 , RecCtaCte              
 , Tipo_Movimiento   
 , GlosaAnticipo                                                                                                                                            
 , Id_Paquete                                
 , Estado_Paquete   
 , Reservado  
 , Nombre  
 , dv  
 , secuencia)  
 SELECT DISTINCT @dFechaProceso  
 , 'CDB'  
 , 'ACC'  
 , 'ACC'  
 , 'P'  
 , registro+isnull(@iNumMov,0)  
 , t.xrut  
 , 1  
 , 999  
 , Monto    
 , CASE WHEN isnull(cta.codForPago,0) =103 AND codbanco <>27 THEN 134 ELSE isnull(cta.codForPago,0) END   
 , @dFechaProceso  
 , @dFechaProceso  
 , ''  
 , t.xrut  
 , CONVERT(NUMERIC(10),CodBanco)  
 , ISNULL(vsb.Clswift,'') --> Codigo Swift  
 , SUBSTRING(Dire,1,40)  
 , CONVERT(VARCHAR,Cuenta)  
 , 'C'  
 , ''  
 , 0  
 , 'D'  
 , ''  
 , t.Nombrex  
 , t.DVx  
 , 1  
  FROM  #temp t  
  LEFT    
  JOIN  #cuentas cta  
    ON cta.Rut= t.xrut     
   AND  tipo='CAMN'   
    LEFT   
    JOIN view_sadp_bancos vsb  
    ON cod_inst = CodBanco  
   AND cod_inst <>0  
   
  
  SET @iNumMov  = (SELECT MAX(numero_operacion)   
                     FROM #t_mdlbtr);  
    
    
  UPDATE sadp_control   
     SET iNumMovCDB = @iNumMov ;  
  
  
       
 SELECT a.fec_liquid       AS FechaPago   
 ,    CASE WHEN SEC_MOVTO_ASOC = 0   
    THEN a.sec_movto   
    ELSE SEC_MOVTO_ASOC END   AS Registro  
 ,  p.per_id		
 ,  p.per_dv					AS DVx
 ,    p.per_raz_social      AS Nombrex  
 ,    a.monto        AS Monto  
 ,    ISNULL(DirFEPART.sDire,'')   AS Dire  
 ,    CASE WHEN A.MERCADO      ='' AND NEMO      = 'PACTO'    then 'RF'   
    ELSE A.MERCADO      END AS MERCADO   
 ,    CASE WHEN A.MERCADO      ='' AND NEMO      = 'PACTO'    then SUBSTRING(COD_MOVTO,1,1)+'PACT'   
    ELSE A.COD_MOVTO END AS cod_movto  
 ,  a.cod_movto     AS tipooo   
 ,  999       AS  MONEDAD  
  INTO #tempoS  
   FROM LNKBACBDC72.BDC72.DBO.TBCTMVTO A  
  INNER    
   JOIN LNKBACBDC72.BDC72.DBO.persona p   
  ON a.rut_cli = p.per_rutdv  
   LEFT   
   JOIN (SELECT  per_id  AS iRut  
  ,  dir_presentacion AS sDire  
  , com_id  
   FROM LNKBACBDC72.BDC72.DBO.direccion  
    INNER   
     JOIN (SELECT per_id      AS iRut,    
    MAX(dir_id)  AS dirCode  
      FROM LNKBACBDC72.BDC72.DBO.Direccion  
     WHERE par_tdi_id ='TDIREFPART'    
     GROUP        
        BY per_id) as DirFPART  
       ON DirFPART.irut = irut  
      AND DirFPART.dirCode = dir_id) DirFEPART  
      ON  DirFEPART.iRut = P.per_id  
  WHERE a.fec_liquid= CONVERT(CHAR(10),@dFechaProceso,121)  
    AND A.ind_anulado != 'A'  
    AND (  
       ( A.mercado     = 'AC' AND ( A.cod_movto  = 'DIPE') )  
  
-->    OR (A.MERCADO      = 'RF' AND ( A.COD_MOVTO in ('PACU', 'VTIF', 'VIRF','CIRF','CIIF') ) )  
-->    OR (A.MERCADO      =''  AND NEMO            = 'PACTO'    AND A.COD_MOVTO IN ('ABMN', 'CAMN'))-->'ABDO' ) )  
--    OR (A.MERCADO    = 'MO' AND NEMO            = 'DOLAR'    AND ( A.COD_MOVTO   = 'ABMN' OR A.COD_MOVTO = 'CAMN') )  
        )  
 INSERT INTO #Tempos  
 SELECT DISTINCT a.fec_liquid       AS FechaPago  
 ,  CONVERT(NUMERIC(10),sec_comprom )  
 ,    p.per_id    
 ,    p.per_dv     AS DVx  
 ,    SUBSTRING(p.per_raz_social,1,30)      AS Nombrex  
 ,    a.cantidad_comprom     AS Monto  
 ,    SUBSTRING(ISNULL(DirFEPART.sDire,''),1,30)   AS Dire  
 ,    'RF'  
 ,    'APACT'   
 ,    'PACT'     
 ,  CASE WHEN tipo_reaj_comp='UF' THEN 998 when tipo_reaj_comp='US' THEN 13 when tipo_reaj_comp='NR' THEN 999 ELSE 0 END    
   FROM LNKBACBDC72.BDC72.DBO.TBCPMSPC a  
  INNER    
   JOIN  LNKBACBDC72.BDC72.DBO.persona p   
  ON a.rut_cli = p.per_rutdv  
   LEFT   
   JOIN (SELECT  per_id  AS iRut  
  ,  dir_presentacion AS sDire  
  , com_id  
   FROM  LNKBACBDC72.BDC72.DBO.direccion  
    INNER   
     JOIN (SELECT per_id      AS iRut,    
    MAX(dir_id)  AS dirCode  
      FROM  LNKBACBDC72.BDC72.DBO.Direccion  
     WHERE par_tdi_id ='TDIREFPART'    
     GROUP        
        BY per_id) as DirFPART  
       ON DirFPART.irut = irut  
      AND DirFPART.dirCode = dir_id) DirFEPART  
      ON  DirFEPART.iRut = P.per_id  
  WHERE a.fec_liquid= CONVERT(CHAR(10),@dFechaProceso,121)  
  
 INSERT INTO #t_mdlbtr  
  ( fecha                     
  , sistema   
  , tipo_mercado   
  , tipo_operacion   
  , estado_envio   
  , numero_operacion                          
  , rut_cliente                               
  , codigo_cliente                            
  , moneda                                    
  , monto_operacion                           
  , forma_pago                                
  , fecha_operacion           
  , fecha_vencimiento         
  , liquidada   
  , RecRutBanco                               
  , RecCodBanco                               
  , RecCodSwift            
  , RecDireccion                                                             
  , RecCtaCte              
  , Tipo_Movimiento   
  , GlosaAnticipo                                                                                                                                            
  , Id_Paquete                                
  , Estado_Paquete   
  , Reservado  
  , Nombre  
  , dv  
  , secuencia)  
    
  SELECT DISTINCT @sFecha    
  ,  'CDB'  
  ,  mercado  
  ,  cod_movto  
  ,  'P'  
  ,  registro  
  ,  per_id  
  ,  1  
  ,  monedad  
  ,  Monto    
  ,  0  -->  CASE WHEN isnull(cta.codForPago,0) =103 AND codbanco <>27 THEN 134 ELSE isnull(cta.codForPago,0) END  
  ,  @dFechaProceso  
  ,  @dFechaProceso  
  ,  ''  
  ,  per_id  
  ,  0  --> CONVERT(NUMERIC(10),CodBanco)  
  ,  ''  --> ISNULL(vsb.Clswift,'') --> Codigo Swift  
  ,  dire --> SUBSTRING(cta.Dire,1,40)  
  ,  ''  --> CONVERT(VARCHAR,Cuenta)  
  ,  'C'  
  ,  ''  
  ,  0  
  ,  'D'  
  ,  ''  
  ,     Nombrex --> SUBSTRING(cta.Nombrex,1,30)  
  ,  DVx  
  ,  1  
  FROM  #tempos  
/*     LEFT   
     JOIN #cuentas cta  
    ON cta.Rut= per_id  
   AND tipo COLLATE SQL_Latin1_General_CP1_CI_AS =tipooo     
       LEFT   
       JOIN view_sadp_bancos vsb  
         ON cod_inst = CodBanco  
   AND cod_inst <>0 */             
    WHERE monto>0  
      
--    SELECT * FROM #t_mdlbtr  
  
 DELETE #t_mdlbtr     
   FROM #t_mdlbtr PAGOS   
  INNER   
   JOIN dbo.SADP_PRODUCTO_MODULOEXTERNO b  
     ON b.Modulo=pagos.sistema  
    AND b.Codigo = tipo_operacion  
  INNER   
   JOIN mdlbtr Pago  
     ON pago.fecha = pagos.fecha  
    AND pago.sistema=pagos.sistema  
    AND pago.tipo_operacion=b.CodInterno  
    AND pago.numero_operacion = pagos.numero_operacion    
  
 UPDATE #t_mdlbtr  set RecCtaCte = REPLACE(RecCtaCte ,'-','');  
  
 UPDATE #t_mdlbtr  SET forma_pago = 128 WHERE forma_pago = 134 AND monto_operacion>1000000000  --Mayor a 1000000000 se cambia a LBTR  
  
 INSERT INTO mdlbtr  
  ( fecha                     
  , sistema   
  , tipo_mercado   
  , tipo_operacion   
  , estado_envio   
  , numero_operacion                          
  , rut_cliente                               
  , codigo_cliente                            
  , moneda                                    
  , monto_operacion                           
  , forma_pago                                
  , fecha_operacion           
  , fecha_vencimiento         
  , liquidada   
  , RecRutBanco            
  , RecCodBanco                               
  , RecCodSwift            
  , RecDireccion                                                             
  , RecCtaCte              
  , Tipo_Movimiento   
  , GlosaAnticipo                                                                            
  , Id_Paquete                                
  , Estado_Paquete   
  , Reservado  
  , Secuencia)   
   
 SELECT a.fecha                     
  , substring(a.sistema,1,5)   
  , a.tipo_operacion -->a.tipo_mercado   
  , substring(b.CodInterno,1,6)   
  , 'PF2'-->a.estado_envio   
  , a.numero_operacion                          
  , a.rut_cliente                               
  , a.codigo_cliente                            
  , a.moneda                                    
  , a.monto_operacion  
  , isnull(CASE  WHEN ISNULL(a.forma_pago,0) <>0 THEN a.forma_pago   
      ELSE sv.id_FormaPago END,0)   
    
  , a.fecha_operacion           
  , a.fecha_vencimiento         
  , a.liquidada   
  , isnull(a.RecRutBanco,0)                               
  , isnull(a.RecCodBanco,0)                               
  , isnull(a.RecCodSwift,'')    
  , isnull(substring(a.RecDireccion,1,70),'')                                                             
  , isnull(a.RecCtaCte,'')              
  , ISNULL(b.sMovimiento,'N')   
  , a.GlosaAnticipo                                                                                                                                            
  , a.Id_Paquete                                
  , a.Estado_Paquete   
  , a.Reservado  
  , 1   
  FROM #t_mdlbtr a  
  LEFT   
   JOIN dbo.SADP_PRODUCTO_MODULOEXTERNO b  
     ON b.Modulo=a.sistema  
    AND b.Codigo = tipo_operacion  
   LEFT   
   JOIN SADP_VALORDEFAULT sv  
     ON sv.Origen  = a.sistema  
       AND sv.Mercado = a.tipo_operacion  
       AND sv.Moneda  = a.moneda  
 where a.rut_cliente <> 96665450  
 ORDER BY a.fecha                     
  , substring(a.sistema,1,5)   
  , a.tipo_operacion -->a.tipo_mercado   
  , substring(b.CodInterno,1,6)   
  , a.numero_operacion                          
  
  
  INSERT INTO SADP_DETALLE_PAGOS  
  ( nContrato                                 
  , cModulo   
  , iMoneda   
  , iFormaPago   
  , nMonto                                    
  , iRutBeneficiario                          
  , sDigBeneficiario   
  , sNomBeneficiario                                     
  , sNomBanco                                            
  , sSwift                 
  , sCtaCte                
  , sUsuario          
  , sFirma1    
  , sFirma2           
  , cEstado   
  , cObservaciones  
  , iRutCliente                               
  , iCodigo  
  , iRutBanco  
  ,   sDvBanco  
  )  
  
  SELECT  
   CONVERT(NUMERIC(10),a.numero_operacion)   /* nContrato   */  
  , CONVERT(CHAR(5),a.sistema)      /* cModulo    */  
  , CONVERT(SMALLINT,a.moneda)      /* iMoneda    */  
  , isnull(CASE  WHEN ISNULL(a.forma_pago,0) <>0 THEN a.forma_pago   
      ELSE sv.id_FormaPago END,0)   
  , a.monto_operacion        /* nMonto    */  
  , CONVERT(INT,a.rut_cliente)                      /* iRutBeneficiario  */         
  , isnull(a.dv,'')         /* sDigBeneficiario  */  
  , ISNULL(SUBSTRING(a.Nombre,1,30),'')    /* sNomBeneficiario  */  
  , ISNULL(vsb.clnombre,'')       /* sNomBanco   */  
  , isnull(a.RecCodSwift,'') --ISNULL(vsb.clswift,'')       /* sSwift    */  
  , isnull(a.RecCtaCte,'')  --ISNULL(scc.sCuentaCorriente,'')     /* sCtaCte    */  
  , @sUsuario          /* sUsuario    */  
  , @sUsuario          /* sFirma1    */     
  , ''            /* sFirma2    */  
  , 'PF2'           /* cEstado    */  
  ,   ''            /* cObservaciones  */    
  ,   CONVERT(INT,a.rut_cliente)      /* iRutCliente   */  
  ,   1            /* iCodigo    */  
  , ISNULL(clrut,0)  
  , ISNULL(cldv,'')  
  FROM #t_mdlbtr a  
     LEFT      
     JOIN SADP_CuentasCorrientes scc  
    ON iRutCliente     = CONVERT(INT,a.rut_cliente)  
      AND scc.iCodCliente = 1  
      AND scc.bPrincipal = 1 --> Indica que es la principal   
     LEFT  
     JOIN VIEW_SADP_BANCOS vsb  
       ON vsb.Clswift     = a.RecCodSwift  
      AND cod_inst    <>0  
     LEFT   
     JOIN SADP_VALORDEFAULT sv  
       ON sv.Origen  = a.sistema  
         AND sv.Mercado = a.tipo_operacion  
         AND sv.Moneda  = a.moneda  
   where a.rut_cliente <> 96665450  
  
 UPDATE SADP_DETALLE_PAGOS   
    SET sNomBeneficiario= dbo.fxCliente( iRutBeneficiario,1,'CDB')  
   FROM SADP_DETALLE_PAGOS  
  INNER   
   JOIN MDLBTR m ON SADP_DETALLE_PAGOS.nContrato=m.numero_operacion  AND m.fecha=@dFechaProceso   
  WHERE cmodulo='CDB'  
   
 UPDATE SADP_DETALLE_PAGOS   
    SET SADP_DETALLE_PAGOS.iFormaPago = 222,  
      SADP_DETALLE_PAGOS.cestado ='E'  
   FROM SADP_DETALLE_PAGOS  
  INNER   
   JOIN MDLBTR m   
     ON SADP_DETALLE_PAGOS.nContrato=m.numero_operacion    
    AND m.fecha=@dFechaProceso   
  WHERE cmodulo='CDB'  
     AND SADP_DETALLE_PAGOS.iFormaPago=0  
  
 UPDATE SADP_DETALLE_PAGOS   
    SET SADP_DETALLE_PAGOS.iFormaPago = 0  
 ,    SADP_DETALLE_PAGOS.cEstado = 'PF1'        
   FROM SADP_DETALLE_PAGOS  
  INNER   
   JOIN MDLBTR m   
     ON SADP_DETALLE_PAGOS.nContrato=m.numero_operacion    
    AND m.fecha=@dFechaProceso   
  WHERE cmodulo='CDB'  
    AND m.tipo_mercado='APACT'  
   --> AND SADP_DETALLE_PAGOS.iFormaPago=0  
  
 UPDATE mdlbtr SET mdlbtr.forma_pago = 222, estado_envio='E'   
 WHERE fecha=@dFechaProceso   
  and sistema='CDB'  
  AND forma_pago=0  
    
 UPDATE mdlbtr SET mdlbtr.forma_pago = 0  
        , mdlbtr.estado_envio = 'PF1'  
 WHERE fecha=@dFechaProceso   
  AND sistema='CDB'  
  AND tipo_mercado='APACT'   
  
 UPDATE SADP_CONTROL  
    SET bSwCargaCDB = 1  
  
END  
GO
