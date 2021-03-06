USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_OPERACIONES_ENVIO_PAGO_seg]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_NGINE_OPERACIONES_ENVIO_PAGO '20220216'
  
CREATE PROCEDURE [dbo].[SP_NGINE_OPERACIONES_ENVIO_PAGO_seg]  
(  
 @cSistema   CHAR(3)  
 ,@cCodigo_producto VARCHAR(5) =''  
 ,@iRut    NUMERIC(10) = 0  
 ,@iCodCli   NUMERIC(9)  = 0  
 ,@iTipCli   NUMERIC(9)  = 0  
 ,@cTipOper   VARCHAR(5)  =''  
 ,@EstadoConf  CHAR(1)     =''  
 ,@iNumOper   NUMERIC(9)  = 0  
 ,@tbcategoria  NUMERIC(4) = 0 -- 9926=PP y 9927 =EP  
) AS  
BEGIN  
 DECLARE  
  @mnnemo  varchar(8)  
  ,@mnglosa varchar(35)  
  ,@mofecpro datetime  
  
 SET NOCOUNT ON  
    IF OBJECT_ID('tempdb..#tmp_ESTADOS_PAGO')IS NOT NULL   
  DROP TABLE #tmp_ESTADOS_PAGO  
  
 IF OBJECT_ID('tempdb..#tmp_OPERACIONES_CONFIRMADAS')IS NOT NULL   
  DROP TABLE #tmp_OPERACIONES_CONFIRMADAS  
  
 -- FECHA DE PROCESO  
 SELECT  
  @mofecpro = acfecproc  
 FROM VIEW_MDAC  
  
  
 --set @mofecpro ='20160118'  
  
 -->2022.04.13 INI  
  SELECT  
  tbcodigo1,tbglosa,nemo,tbcateg  
  INTO #tmp_ESTADOS_PAGO  
  FROM  
  BACPARAMSUDA..TABLA_GENERAL_DETALLE  
  WHERE tbcateg in (9928,9926,9927)  
  --and tbcateg = (case @tbcategoria when 9928 then 9928 else tbcateg end )  
  
  --if @tbcategoria <> 9927  
  --delete #tmp_ESTADOS_PAGO where tbcateg <> 9927  
  --else  
  --delete #tmp_ESTADOS_PAGO where tbcateg = 9927  
 -->2022.04.13 FIN  
  
 --IF @iSistema = 'BTR'  
 --BEGIN  
 SELECT   
  @mnnemo = ISNULL(mnnemo,'CLP')   
  ,@mnglosa=ISNULL(mnglosa,'')   
 FROM bacparamsuda..MONEDA WHERE mncodmon  = 999  
   
   
 /*********************RENTA FIJA*********************************/  
 INSERT INTO NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
 SELECT  
  --> 2022.04.14 INI Operaciones no deben aparecer  
  @mofecpro  
  ,'Envio'     ='NO'  
  --< 2022.04.14 FIN Operaciones no deben aparecer  
  ,'Sistema'    = 'BTR'--pro.id_sistema      --codigo_producto  
  ,'Numero_operacion'  = mo.monumoper       --numero_operacion  
  ,'Tipo_operacion'  = CONVERT(varchar(10),  
          CASE   
           WHEN mo.motipoper IN('CFM','RFM') THEN 'FFMM'   
           ELSE mo.motipoper  
          END)      --tipo_operacion  
  ,'Glosa_Tipo_operacion' = pro.descripcion  
  ,'Indicador'   = CASE   
         WHEN mo.motipoper in ('CP','CI','ICOL','CFM','RC','RCA','VICAP') THEN 'P'   
         ELSE 'S'   
          END         --indicador  
  ,'Fecha_operacion'  = mofecpro  
  ,'Usuario'    = mousuario        --usuario  
  ,'Moneda'    = CASE   
         WHEN emi.mncodmon = 998 THEN @mnnemo  
         ELSE emi.mnnemo   
          END         --moneda CLP  
  ,'Glosa_Moneda'   = CASE   
         WHEN emi.mncodmon = 998 THEN @mnglosa  
         ELSE emi.mnglosa     --Pesos  
          END  
  ,'Rut_cliente'   = morutcli        --rut_cliente  
  ,'Dv_cliente'   = cl.cldv        --dv_cliente  
  ,'Sucursal'    = 0          --sucursal  
  ,'Monto_operacion'  = sum(mo.movpresen)  
  ,'Forma_pago'   = CASE   
         WHEN mo.motipoper in ('CP','VP','VI','VIX','CI','CIX','ICOL','ICOLX','ICAP','ICAPX','CFM') THEN mo.moforpagi   
          ELSE mo.moforpagv END    --Forma_Pago  
  ,'Glosa_Forma_pago'  = ini.glosa  
  ,'Codigo_valuta'  = ini.diasvalor  
  ,'Nombre_cliente'  = cl.clnombre  
    
  ,'Banco'    = CONVERT(CHAR(4),'') -- se reemplaza por primeros 4 dig del código swift, enviados por banco Itaú  
  ,'CtaCteBenVendedor' = 0--CONVERT(CHAR(15),'')  
  
  ,'Clave_abif'   = CONVERT(CHAR(20),'')  
  ,'Cta_comprador'  = CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN ' ' ELSE 'X' END  
  ,'Codigo_dcv_comprador' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Cta_vendedor'   = '' --CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN 'X' ELSE ' ' END  
  ,'Codigo_dcv_vendedor' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Monto_original'  = sum(mo.momtps)  
  ,'Fecha_inicio'   = mo.mofecpro  
  ,'Tasa_interes'   = CASE WHEN mo.motipoper in ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.motir) ELSE 0 END  
  ,'Interes'    = CASE WHEN mo.motipoper in ('ICOL', 'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.mointeres) ELSE 0 END  
  ,'Monto_vencimiento' = CASE WHEN mo.motipoper in ('VI' ,'CI' ,'ICAP' ,'ICOL',  
                                                                         'VIX','CIX','ICAPX','ICOLX') THEN SUM(mo.movalvenp) *  
                             ISNULL((SELECT   
                               CASE WHEN vmvalor = 0 THEN 1   
                               ELSE vmvalor   
                               END   
                             FROM BacParamSuda..VALOR_MONEDA   
                             WHERE vmcodigo= max(mo.momonpact) and vmfecha = mo.mofecpro),1)   
          WHEN mo.motipoper in ('RC','RC','VICOL','VICAP','VICOLX','VICAPX') THEN sum(mo.momtps)  
                                                                                   ELSE 0  
         END  
  ,'Fecha_vencimiento'  = CASE WHEN mo.motipoper in ('CP','VP' ,'CPX','VPX' ) THEN MAX(mo.mofecven)  
         WHEN mo.motipoper in ('VC','VCI','VCX','VCIX') THEN  mo.mofecpro  
                                                               ELSE  mo.mofecvenp  
         END  
  ,'Reajustabilidad' = CONVERT(CHAR(15),'999')  
  ,'Tasa_Pacto'  = 0   
  ,'Monto_Final'  = sum(mo.momtps)  
  ,'Monto_Nominal'  = CASE WHEN mo.motipoper IN ('VI','CI','VIX','CIX') THEN sum(mo.momtps)  
                    WHEN mo.motipoper IN ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP' ,'RC' ,'RCA' ,'RV' ,'RVA' ,  
                                                                                 'ICOLX','ICAPX','VICOLX','VICAPX','RCX','RCAX','RVX','RVAX') THEN sum(mo.movalinip)  
                                   ELSE 0   
                              END  
  ,'Tasa_descuento'     = 0  
  ,'Valor_tasa'      = 0  
  ,'Custodia'          = 'DCV'  
  ,'Numero_instrumentos' = COUNT(mo.mocorrela)  
  ,'Monto_total'      = sum(mo.momtps)  
  ,'Codigo_mon_mx'  = 0  
  ,'Monto_mx'    = 0  
  ,'Tasa_cambio'   = 0  
  ,'Fecha_valor_mx'  = '19000101'  
  ,'Forma_pago_neg'  = CASE WHEN mo.motipoper in ('CP' ,'VP' ,'VI' ,'CI' ,'ICOL' ,'ICAP' ,'CFM',  
                                                                        'CPX','VPX','VIX','CIX','ICOLX','ICAPX'      ) THEN mo.moforpagi   
          ELSE mo.moforpagv END  
  ,'Sesion'    = ''  
    
  ,'NombreClienteBen_3' = ''  
  ,'NombreClienteBen_4' = ''  
  ,'UsuarioMDP'   = '' -- Se actualiza como gsBAC_User en la aplicación  
  ,'UsuarioIngreso'  = mousuario  
  ,'CargoCtaCte'   = 'N'  
  ,'SobregiroCtaCte'  = 'N'  
  ,'PvpReferencia'  = ''  
  ,'PvpMoneda'   = ''  
  ,'PvpTasaCambio'  = 0  
  ,'PvpMonto'    = 0  
  ,mo.mocodcli  
  ,'Codigo_dcv2'   = CONVERT(CHAR(20),'S/C')  
  ,'Estado'    = 'PP'  
 FROM  BACTRADERSUDA..MDMO mo  
 LEFT JOIN bacparamsuda..CLIENTE cl ON mo.morutcli  = cl.clrut   
          AND mo.mocodcli = cl.clcodigo  
 LEFT JOIN bacparamsuda..MONEDA emi ON emi.mncodmon = CASE   
          WHEN mo.motipoper in ('CI','VI') THEN mo.momonpact   
           ELSE 999  
          END  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ini ON mo.moforpagi = ini.codigo  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ven ON mo.moforpagv = ven.codigo  
 INNER JOIN bacparamsuda..PRODUCTO pro  ON pro.id_sistema = 'BTR'   
            AND pro.codigo_producto = CASE WHEN mo.motipoper = 'IB' THEN mo.moinstser   
                    ELSE mo.motipoper  
                    END  
 WHERE mo.mostatreg   = ''  
  AND (pro.id_sistema   = @cSistema  OR @cSistema ='')  
  AND ini.codigo IS NOT NULL  
  AND ven.codigo IS NOT NULL  
  AND (mo.morutcli           = @iRut   OR @iRut  = 0)  
  AND (mo.mocodcli           = @iCodCli  OR @iCodCli  = 0)  
  AND (cl.cltipcli           = @iTipCli  OR @iTipCli  = 0)  
  AND (mo.motipoper          = @cTipOper  OR @cTipOper = '')  
  AND (mo.monumoper          = @iNumOper  OR @iNumOper = 0)  
  --AND mo.motipoper NOT IN ('TM')  
  AND motipoper IN ('CP', 'VP', 'VI', 'CI', 'RCA', 'RVA', 'RC', 'RV')  
  AND mo.mofecpro = @mofecpro  
  AND mo.monumoper NOT IN (SELECT numero_operacion FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO)  
 GROUP BY  
  pro.id_sistema  
  ,mo.motipoper  
  ,mo.monumoper  
  ,mo.morutcli  
  ,mo.mofecvenp  
  ,mo.mofecpro  
  ,mo.moforpagi  
  ,mo.moforpagv  
  ,mo.mocodcli  
  ,mo.mousuario  
  ,ini.diasvalor  
  ,cl.clnombre  
  ,cl.cldv  
  ,cl.clgeneric  
  ,ini.glosa  
  ,emi.mncodmon  
  ,emi.mnnemo  
  ,emi.mnglosa  
  ,pro.descripcion  
   
 /*********************RENTA FIJA*********************************/  
  
  
 /*********************RENTA FIJA fecha_pagomañana*********************************/  
 INSERT INTO NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
 SELECT  
  --> 2022.04.14 INI Operaciones no deben aparecer  
  @mofecpro  
  ,'Envio'     ='NO'  
  --< 2022.04.14 FIN Operaciones no deben aparecer  
  ,'Sistema'    = 'BTR'--pro.id_sistema      --codigo_producto  
  ,'Numero_operacion'  = mo.monumoper       --numero_operacion  
  ,'Tipo_operacion'  = CONVERT(varchar(10),  
          CASE   
           WHEN mo.motipoper IN('CFM','RFM') THEN 'FFMM'   
           ELSE mo.motipoper  
          END)      --tipo_operacion  
  ,'Glosa_Tipo_operacion' = pro.descripcion  
  ,'Indicador'   = CASE   
         WHEN mo.motipoper in ('CP','CI','ICOL','CFM','RC','RCA','VICAP') THEN 'P'   
         ELSE 'S'   
          END         --indicador  
  ,'Fecha_operacion'  = fecha_pagomañana  
  ,'Usuario'    = mousuario        --usuario  
  ,'Moneda'    = CASE   
         WHEN emi.mncodmon = 998 THEN @mnnemo  
         ELSE emi.mnnemo   
          END         --moneda CLP  
  ,'Glosa_Moneda'   = CASE   
         WHEN emi.mncodmon = 998 THEN @mnglosa  
         ELSE emi.mnglosa     --Pesos  
          END  
  ,'Rut_cliente'   = morutcli        --rut_cliente  
  ,'Dv_cliente'   = cl.cldv        --dv_cliente  
  ,'Sucursal'    = 0          --sucursal  
  ,'Monto_operacion'  = sum(mo.movpresen)  
  ,'Forma_pago'   = CASE   
         WHEN mo.motipoper in ('CP','VP','VI','VIX','CI','CIX','ICOL','ICOLX','ICAP','ICAPX','CFM') THEN mo.moforpagi   
          ELSE mo.moforpagv END    --Forma_Pago  
  ,'Glosa_Forma_pago'  = ini.glosa  
  ,'Codigo_valuta'  = ini.diasvalor  
  ,'Nombre_cliente'  = cl.clnombre  
    
  ,'Banco'    = CONVERT(CHAR(4),'') -- se reemplaza por primeros 4 dig del código swift, enviados por banco Itaú  
  ,'CtaCteBenVendedor' = 0--CONVERT(CHAR(15),'')  
  
  ,'Clave_abif'   = CONVERT(CHAR(20),'')  
  ,'Cta_comprador'  = CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN ' ' ELSE 'X' END  
  ,'Codigo_dcv_comprador' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Cta_vendedor'   = '' --CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN 'X' ELSE ' ' END  
  ,'Codigo_dcv_vendedor' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Monto_original'  = sum(mo.momtps)  
  ,'Fecha_inicio'   = mo.mofecpro  
  ,'Tasa_interes'   = CASE WHEN mo.motipoper in ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.motir) ELSE 0 END  
  ,'Interes'    = CASE WHEN mo.motipoper in ('ICOL', 'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.mointeres) ELSE 0 END  
  ,'Monto_vencimiento' = CASE WHEN mo.motipoper in ('VI' ,'CI' ,'ICAP' ,'ICOL',  
                                                                         'VIX','CIX','ICAPX','ICOLX') THEN SUM(mo.movalvenp) *  
                             ISNULL((SELECT   
                               CASE WHEN vmvalor = 0 THEN 1   
                               ELSE vmvalor   
                               END   
                             FROM BacParamSuda..VALOR_MONEDA   
                             WHERE vmcodigo= max(mo.momonpact) and vmfecha = mo.mofecpro),1)   
          WHEN mo.motipoper in ('RC','RC','VICOL','VICAP','VICOLX','VICAPX') THEN sum(mo.momtps)  
                                                                    ELSE 0  
         END  
  ,'Fecha_vencimiento'  = CASE WHEN mo.motipoper in ('CP','VP' ,'CPX','VPX' ) THEN MAX(mo.mofecven)  
         WHEN mo.motipoper in ('VC','VCI','VCX','VCIX') THEN  mo.mofecpro  
                                                               ELSE  mo.mofecvenp  
         END  
  ,'Reajustabilidad' = CONVERT(CHAR(15),'999')  
  ,'Tasa_Pacto'  = 0   
  ,'Monto_Final'  = sum(mo.momtps)  
  ,'Monto_Nominal'  = CASE WHEN mo.motipoper IN ('VI','CI','VIX','CIX') THEN sum(mo.momtps)  
                    WHEN mo.motipoper IN ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP' ,'RC' ,'RCA' ,'RV' ,'RVA' ,  
                                                                                 'ICOLX','ICAPX','VICOLX','VICAPX','RCX','RCAX','RVX','RVAX') THEN sum(mo.movalinip)  
                                   ELSE 0   
                              END  
  ,'Tasa_descuento'     = 0  
  ,'Valor_tasa'      = 0  
  ,'Custodia'          = 'DCV'  
  ,'Numero_instrumentos' = COUNT(mo.mocorrela)  
  ,'Monto_total'      = sum(mo.momtps)  
  ,'Codigo_mon_mx'  = 0  
  ,'Monto_mx'    = 0  
  ,'Tasa_cambio'   = 0  
  ,'Fecha_valor_mx'  = '19000101'  
  ,'Forma_pago_neg'  = CASE WHEN mo.motipoper in ('CP' ,'VP' ,'VI' ,'CI' ,'ICOL' ,'ICAP' ,'CFM',  
                                                                        'CPX','VPX','VIX','CIX','ICOLX','ICAPX'      ) THEN mo.moforpagi   
          ELSE mo.moforpagv END  
  ,'Sesion'    = ''  
    
  ,'NombreClienteBen_3' = ''  
  ,'NombreClienteBen_4' = ''  
  ,'UsuarioMDP'   = '' -- Se actualiza como gsBAC_User en la aplicación  
  ,'UsuarioIngreso'  = mousuario  
  ,'CargoCtaCte'   = 'N'  
  ,'SobregiroCtaCte'  = 'N'  
  ,'PvpReferencia'  = ''  
  ,'PvpMoneda'   = ''  
  ,'PvpTasaCambio'  = 0  
  ,'PvpMonto'    = 0  
  ,mo.mocodcli  
  ,'Codigo_dcv2'   = CONVERT(CHAR(20),'S/C')  
  ,'Estado'    = 'PP'  
 FROM  BACTRADERSUDA..MDMO mo  
 LEFT JOIN bacparamsuda..CLIENTE cl ON mo.morutcli  = cl.clrut   
          AND mo.mocodcli = cl.clcodigo  
 LEFT JOIN bacparamsuda..MONEDA emi ON emi.mncodmon = CASE   
          WHEN mo.motipoper in ('CI','VI') THEN mo.momonpact   
           ELSE 999  
          END  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ini ON mo.moforpagi = ini.codigo  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ven ON mo.moforpagv = ven.codigo  
 INNER JOIN bacparamsuda..PRODUCTO pro  ON pro.id_sistema = 'BTR'   
            AND pro.codigo_producto = CASE WHEN mo.motipoper = 'IB' THEN mo.moinstser   
                    ELSE mo.motipoper  
                    END  
 WHERE mo.mostatreg   = ''  
  --AND (pro.id_sistema   = @cSistema  OR @cSistema ='')  
  AND ini.codigo IS NOT NULL  
  --AND ven.codigo IS NOT NULL  
  AND (mo.morutcli           = @iRut   OR @iRut  = 0)  
  AND (mo.mocodcli           = @iCodCli  OR @iCodCli  = 0)  
  AND (cl.cltipcli           = @iTipCli  OR @iTipCli  = 0)  
  AND (mo.motipoper          = @cTipOper  OR @cTipOper = '')  
  AND (mo.monumoper          = @iNumOper  OR @iNumOper = 0)  
  AND mo.motipoper NOT IN ('TM')  
  AND motipoper IN ('CP', 'VP', 'VI', 'CI', 'RCA', 'RVA', 'RC', 'RV')  
  AND mo.fecha_pagomañana = @mofecpro  
  AND mo.monumoper NOT IN (SELECT numero_operacion FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO)  
 GROUP BY  
  pro.id_sistema  
  ,mo.motipoper  
  ,mo.monumoper  
  ,mo.morutcli  
  ,mo.mofecvenp  
  ,mo.mofecpro  
  ,mo.moforpagi  
  ,mo.moforpagv  
  ,mo.mocodcli  
  ,mo.mousuario  
  ,ini.diasvalor  
  ,cl.clnombre  
  ,cl.cldv  
  ,cl.clgeneric  
  ,ini.glosa  
  ,emi.mncodmon  
  ,emi.mnnemo  
  ,emi.mnglosa  
  ,pro.descripcion  
  ,mo.fecha_pagomañana  
   
 /*********************RENTA FIJA fecha_pagomañana*********************************/  
  
 /*********************RENTA FIJA ICOL ICAP*********************************/  
 INSERT INTO NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
 SELECT  
  --> 2022.04.14 INI Operaciones no deben aparecer  
  @mofecpro  
  ,'Envio'     ='NO'  
  --< 2022.04.14 FIN Operaciones no deben aparecer  
  ,'Sistema'    = 'BTR'--pro.id_sistema      --codigo_producto  
  ,'Numero_operacion'  = mo.monumoper       --numero_operacion  
  ,'Tipo_operacion'  = CONVERT(varchar(10),  
          CASE   
           WHEN mo.motipoper IN('CFM','RFM') THEN 'FFMM'   
           ELSE mo.motipoper  
          END)      --tipo_operacion  
  ,'Glosa_Tipo_operacion' = pro.descripcion  
  ,'Indicador'   = CASE   
         WHEN mo.motipoper in ('CP','CI','ICOL','CFM','RC','RCA','VICAP') THEN 'P'   
         ELSE 'S'   
          END         --indicador  
  ,'Fecha_operacion'  = mofecpro  
  ,'Usuario'    = mousuario        --usuario  
  ,'Moneda'    = CASE   
         WHEN emi.mncodmon = 998 THEN @mnnemo  
         ELSE emi.mnnemo   
          END         --moneda CLP  
  ,'Glosa_Moneda'   = CASE   
         WHEN emi.mncodmon = 998 THEN @mnglosa  
         ELSE emi.mnglosa     --Pesos  
          END  
  ,'Rut_cliente'   = morutcli        --rut_cliente  
  ,'Dv_cliente'   = cl.cldv        --dv_cliente  
  ,'Sucursal'    = 0          --sucursal  
  ,'Monto_operacion'  = sum(mo.movpresen)  
  ,'Forma_pago'   = CASE   
         WHEN mo.motipoper in ('CP','VP','VI','VIX','CI','CIX','ICOL','ICOLX','ICAP','ICAPX','CFM') THEN mo.moforpagi   
          ELSE mo.moforpagv END    --Forma_Pago  
  ,'Glosa_Forma_pago'  = ini.glosa  
  ,'Codigo_valuta'  = ini.diasvalor  
  ,'Nombre_cliente'  = cl.clnombre  
    
  ,'Banco'    = CONVERT(CHAR(4),'') -- se reemplaza por primeros 4 dig del código swift, enviados por banco Itaú  
  ,'CtaCteBenVendedor' = 0--CONVERT(CHAR(15),'')  
  
  ,'Clave_abif'   = CONVERT(CHAR(20),'')  
  ,'Cta_comprador'  = CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN ' ' ELSE 'X' END  
  ,'Codigo_dcv_comprador' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Cta_vendedor'   = '' --CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN 'X' ELSE ' ' END  
  ,'Codigo_dcv_vendedor' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Monto_original'  = sum(mo.momtps)  
  ,'Fecha_inicio'   = mo.mofecpro  
  ,'Tasa_interes'   = CASE WHEN mo.motipoper in ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.motir) ELSE 0 END  
  ,'Interes'    = CASE WHEN mo.motipoper in ('ICOL', 'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.mointeres) ELSE 0 END  
  ,'Monto_vencimiento' = CASE WHEN mo.motipoper in ('VI' ,'CI' ,'ICAP' ,'ICOL',  
                                                                         'VIX','CIX','ICAPX','ICOLX') THEN SUM(mo.movalvenp) *  
                             ISNULL((SELECT   
                               CASE WHEN vmvalor = 0 THEN 1   
                               ELSE vmvalor   
                               END   
                             FROM BacParamSuda..VALOR_MONEDA   
                             WHERE vmcodigo= max(mo.momonpact) and vmfecha = mo.mofecpro),1)   
          WHEN mo.motipoper in ('RC','RC','VICOL','VICAP','VICOLX','VICAPX') THEN sum(mo.momtps)  
                                                                                   ELSE 0  
         END  
  ,'Fecha_vencimiento'  = CASE WHEN mo.motipoper in ('CP','VP' ,'CPX','VPX' ) THEN MAX(mo.mofecven)  
         WHEN mo.motipoper in ('VC','VCI','VCX','VCIX') THEN  mo.mofecpro  
                                                               ELSE  mo.mofecvenp  
         END  
  ,'Reajustabilidad' = CONVERT(CHAR(15),'999')  
  ,'Tasa_Pacto'  = 0   
  ,'Monto_Final'  = sum(mo.momtps)  
  ,'Monto_Nominal'  = CASE WHEN mo.motipoper IN ('VI','CI','VIX','CIX') THEN sum(mo.momtps)  
                    WHEN mo.motipoper IN ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP' ,'RC' ,'RCA' ,'RV' ,'RVA' ,  
                                                                                 'ICOLX','ICAPX','VICOLX','VICAPX','RCX','RCAX','RVX','RVAX') THEN sum(mo.movalinip)  
                                   ELSE 0   
                              END  
  ,'Tasa_descuento'     = 0  
  ,'Valor_tasa'      = 0  
  ,'Custodia'          = 'DCV'  
  ,'Numero_instrumentos' = COUNT(mo.mocorrela)  
  ,'Monto_total'      = sum(mo.momtps)  
  ,'Codigo_mon_mx'  = 0  
  ,'Monto_mx'    = 0  
  ,'Tasa_cambio'   = 0  
  ,'Fecha_valor_mx'  = '19000101'  
  ,'Forma_pago_neg'  = CASE WHEN mo.motipoper in ('CP' ,'VP' ,'VI' ,'CI' ,'ICOL' ,'ICAP' ,'CFM',  
                                                                        'CPX','VPX','VIX','CIX','ICOLX','ICAPX'      ) THEN mo.moforpagi   
          ELSE mo.moforpagv END  
  ,'Sesion'    = ''  
    
  ,'NombreClienteBen_3' = ''  
  ,'NombreClienteBen_4' = ''  
  ,'UsuarioMDP'   = '' -- Se actualiza como gsBAC_User en la aplicación  
  ,'UsuarioIngreso'  = mousuario  
  ,'CargoCtaCte'   = 'N'  
  ,'SobregiroCtaCte'  = 'N'  
  ,'PvpReferencia'  = ''  
  ,'PvpMoneda'   = ''  
  ,'PvpTasaCambio'  = 0  
  ,'PvpMonto'    = 0  
  ,mo.mocodcli  
  ,'Codigo_dcv2'   = CONVERT(CHAR(20),'S/C')  
  ,'Estado'    = 'PP'  
 FROM  BACTRADERSUDA..MDMO mo  
 LEFT JOIN bacparamsuda..CLIENTE cl ON mo.morutcli  = cl.clrut   
          AND mo.mocodcli = cl.clcodigo  
 LEFT JOIN bacparamsuda..MONEDA emi ON emi.mncodmon = CASE   
          WHEN mo.motipoper in ('CI','VI') THEN mo.momonpact   
           ELSE 999  
          END  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ini ON mo.moforpagi = ini.codigo  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ven ON mo.moforpagv = ven.codigo  
 INNER JOIN bacparamsuda..PRODUCTO pro  ON pro.id_sistema = 'BTR'   
            AND pro.codigo_producto = CASE WHEN mo.motipoper = 'IB' THEN mo.moinstser   
                    ELSE mo.motipoper  
                    END  
 WHERE mo.mostatreg   = ''  
  AND (pro.id_sistema   = @cSistema  OR @cSistema ='')  
  AND ini.codigo IS NOT NULL  
  AND ven.codigo IS NOT NULL  
  AND (mo.morutcli           = @iRut   OR @iRut  = 0)  
  AND (mo.mocodcli           = @iCodCli  OR @iCodCli  = 0)  
  AND (cl.cltipcli           = @iTipCli  OR @iTipCli  = 0)  
  AND (mo.motipoper          = @cTipOper  OR @cTipOper = '')  
  AND (mo.monumoper          = @iNumOper  OR @iNumOper = 0)  
  --AND mo.motipoper NOT IN ('TM')  
  AND motipoper = 'IB'  
  AND moinstser IN ('ICAP', 'ICOL')  
  AND mo.mofecpro = @mofecpro  
  AND mo.monumoper NOT IN (SELECT numero_operacion FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO)  
 GROUP BY  
  pro.id_sistema  
  ,mo.motipoper  
  ,mo.monumoper  
  ,mo.morutcli  
  ,mo.mofecvenp  
  ,mo.mofecpro  
  ,mo.moforpagi  
  ,mo.moforpagv  
  ,mo.mocodcli  
  ,mo.mousuario  
  ,ini.diasvalor  
  ,cl.clnombre  
  ,cl.cldv  
  ,cl.clgeneric  
  ,ini.glosa  
  ,emi.mncodmon  
  ,emi.mnnemo  
  ,emi.mnglosa  
  ,pro.descripcion  
 /*********************RENTA FIJA ICOL ICAP*********************************/  
  
  
 /*********************RENTA FIJA Operaciones CI al vcto.(VCI)/VI *********************************/  
 INSERT INTO NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
 SELECT  
  --> 2022.04.14 INI Operaciones no deben aparecer  
  @mofecpro  
  ,'Envio'     ='NO'  
  --< 2022.04.14 FIN Operaciones no deben aparecer  
  ,'Sistema'    = 'BTR'--pro.id_sistema      --codigo_producto  
  ,'Numero_operacion'  = mo.monumoper       --numero_operacion  
  ,'Tipo_operacion'  = CONVERT(varchar(10),  
          CASE   
           WHEN mo.motipoper IN('CFM','RFM') THEN 'FFMM'   
           ELSE mo.motipoper  
          END)      --tipo_operacion  
  ,'Glosa_Tipo_operacion' = pro.descripcion  
  ,'Indicador'   = CASE   
         WHEN mo.motipoper in ('CP','CI','ICOL','CFM','RC','RCA','VICAP') THEN 'P'   
         ELSE 'S'   
          END         --indicador  
  ,'Fecha_operacion'  = mofecpro  
  ,'Usuario'    = mousuario        --usuario  
  ,'Moneda'    = CASE   
         WHEN emi.mncodmon = 998 THEN @mnnemo  
         ELSE emi.mnnemo   
          END         --moneda CLP  
  ,'Glosa_Moneda'   = CASE   
         WHEN emi.mncodmon = 998 THEN @mnglosa  
         ELSE emi.mnglosa     --Pesos  
          END  
  ,'Rut_cliente'   = morutcli        --rut_cliente  
  ,'Dv_cliente'   = cl.cldv        --dv_cliente  
  ,'Sucursal'    = 0          --sucursal  
  ,'Monto_operacion'  = sum(mo.movpresen)  
  ,'Forma_pago'   = CASE   
         WHEN mo.motipoper in ('CP','VP','VI','VIX','CI','CIX','ICOL','ICOLX','ICAP','ICAPX','CFM') THEN mo.moforpagi   
          ELSE mo.moforpagv END    --Forma_Pago  
  ,'Glosa_Forma_pago'  = ini.glosa  
  ,'Codigo_valuta'  = ini.diasvalor  
  ,'Nombre_cliente'  = cl.clnombre  
    
  ,'Banco'    = CONVERT(CHAR(4),'') -- se reemplaza por primeros 4 dig del código swift, enviados por banco Itaú  
  ,'CtaCteBenVendedor' = 0--CONVERT(CHAR(15),'')  
  
  ,'Clave_abif'   = CONVERT(CHAR(20),'')  
  ,'Cta_comprador'  = CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN ' ' ELSE 'X' END  
  ,'Codigo_dcv_comprador' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Cta_vendedor'   = '' --CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN 'X' ELSE ' ' END  
  ,'Codigo_dcv_vendedor' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Monto_original'  = sum(mo.momtps)  
  ,'Fecha_inicio'   = mo.mofecpro  
  ,'Tasa_interes'   = CASE WHEN mo.motipoper in ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.motir) ELSE 0 END  
  ,'Interes'    = CASE WHEN mo.motipoper in ('ICOL', 'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.mointeres) ELSE 0 END  
  ,'Monto_vencimiento' = CASE WHEN mo.motipoper in ('VI' ,'CI' ,'ICAP' ,'ICOL',  
                                                                         'VIX','CIX','ICAPX','ICOLX') THEN SUM(mo.movalvenp) *  
                             ISNULL((SELECT   
                               CASE WHEN vmvalor = 0 THEN 1   
                               ELSE vmvalor   
                               END   
                             FROM BacParamSuda..VALOR_MONEDA   
                             WHERE vmcodigo= max(mo.momonpact) and vmfecha = mo.mofecpro),1)   
          WHEN mo.motipoper in ('RC','RC','VICOL','VICAP','VICOLX','VICAPX') THEN sum(mo.momtps)  
                                                                                   ELSE 0  
         END  
  ,'Fecha_vencimiento'  = CASE WHEN mo.motipoper in ('CP','VP' ,'CPX','VPX' ) THEN MAX(mo.mofecven)  
         WHEN mo.motipoper in ('VC','VCI','VCX','VCIX') THEN  mo.mofecpro  
                                                               ELSE  mo.mofecvenp  
         END  
  ,'Reajustabilidad' = CONVERT(CHAR(15),'999')  
  ,'Tasa_Pacto'  = 0   
  ,'Monto_Final'  = sum(mo.momtps)  
  ,'Monto_Nominal'  = CASE WHEN mo.motipoper IN ('VI','CI','VIX','CIX') THEN sum(mo.momtps)  
                    WHEN mo.motipoper IN ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP' ,'RC' ,'RCA' ,'RV' ,'RVA' ,  
                                                                                 'ICOLX','ICAPX','VICOLX','VICAPX','RCX','RCAX','RVX','RVAX') THEN sum(mo.movalinip)  
                                   ELSE 0   
                              END  
  ,'Tasa_descuento'     = 0  
  ,'Valor_tasa'      = 0  
  ,'Custodia'          = 'DCV'  
  ,'Numero_instrumentos' = COUNT(mo.mocorrela)  
  ,'Monto_total'      = sum(mo.momtps)  
  ,'Codigo_mon_mx'  = 0  
  ,'Monto_mx'    = 0  
  ,'Tasa_cambio'   = 0  
  ,'Fecha_valor_mx'  = '19000101'  
  ,'Forma_pago_neg'  = CASE WHEN mo.motipoper in ('CP' ,'VP' ,'VI' ,'CI' ,'ICOL' ,'ICAP' ,'CFM',  
                                                                        'CPX','VPX','VIX','CIX','ICOLX','ICAPX'      ) THEN mo.moforpagi   
          ELSE mo.moforpagv END  
  ,'Sesion'    = ''  
    
  ,'NombreClienteBen_3' = ''  
  ,'NombreClienteBen_4' = ''  
  ,'UsuarioMDP'   = '' -- Se actualiza como gsBAC_User en la aplicación  
  ,'UsuarioIngreso'  = mousuario  
  ,'CargoCtaCte'   = 'N'  
  ,'SobregiroCtaCte'  = 'N'  
  ,'PvpReferencia'  = ''  
  ,'PvpMoneda'   = ''  
  ,'PvpTasaCambio'  = 0  
  ,'PvpMonto'    = 0  
  ,mo.mocodcli  
  ,'Codigo_dcv2'   = CONVERT(CHAR(20),'S/C')  
  ,'Estado'    = 'PP'  
 FROM  BACTRADERSUDA..MDMO mo  
 LEFT JOIN bacparamsuda..CLIENTE cl ON mo.morutcli  = cl.clrut   
          AND mo.mocodcli = cl.clcodigo  
 LEFT JOIN bacparamsuda..MONEDA emi ON emi.mncodmon = CASE   
          WHEN mo.motipoper in ('CI','VI') THEN mo.momonpact   
           ELSE 999  
          END  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ini ON mo.moforpagi = ini.codigo  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ven ON mo.moforpagv = ven.codigo  
 INNER JOIN bacparamsuda..PRODUCTO pro  ON pro.id_sistema = 'BTR'   
            AND pro.codigo_producto = CASE WHEN mo.motipoper = 'IB' THEN mo.moinstser   
                    ELSE mo.motipoper  
                    END  
 WHERE mo.mostatreg   = ''  
  AND (pro.id_sistema   = @cSistema  OR @cSistema ='')  
  AND ini.codigo IS NOT NULL  
  AND ven.codigo IS NOT NULL  
  AND (mo.morutcli           = @iRut   OR @iRut  = 0)  
  AND (mo.mocodcli           = @iCodCli  OR @iCodCli  = 0)  
  AND (cl.cltipcli           = @iTipCli  OR @iTipCli  = 0)  
  AND (mo.motipoper          = @cTipOper  OR @cTipOper = '')  
  AND (mo.monumoper          = @iNumOper  OR @iNumOper = 0)  
  --AND mo.motipoper NOT IN ('TM')  
  AND motipoper IN ('VI', 'CI')  
  AND mo.mofecpro = @mofecpro  
  AND mo.monumoper NOT IN (SELECT numero_operacion FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO)  
 GROUP BY  
  pro.id_sistema  
  ,mo.motipoper  
  ,mo.monumoper  
  ,mo.morutcli  
  ,mo.mofecvenp  
  ,mo.mofecpro  
  ,mo.moforpagi  
  ,mo.moforpagv  
  ,mo.mocodcli  
  ,mo.mousuario  
  ,ini.diasvalor  
  ,cl.clnombre  
  ,cl.cldv  
  ,cl.clgeneric  
  ,ini.glosa  
  ,emi.mncodmon  
  ,emi.mnnemo  
  ,emi.mnglosa  
  ,pro.descripcion  
 /*********************RENTA FIJA Operaciones CI al vcto.(VCI)/VI *********************************/  
  
  
   
  
 /*********************RENTA FIJA Operaciones RESULTADO*********************************/  
 INSERT INTO NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
 SELECT  
  --> 2022.04.14 INI Operaciones no deben aparecer  
  @mofecpro  
  ,'Envio'     ='NO'  
  --< 2022.04.14 FIN Operaciones no deben aparecer  
  ,'Sistema'    = 'BTR'--pro.id_sistema      --codigo_producto  
  ,'Numero_operacion'  = mo.rsnumoper       --numero_operacion  
  ,'Tipo_operacion'  = 'VC'/*CONVERT(varchar(10),  
          CASE   
           WHEN MO.RSTIPOPER IN('CFM','RFM') THEN 'FFMM'   
           ELSE MO.RSTIPOPER  
          END)*/      --TIPO_OPERACION  
  ,'GLOSA_TIPO_OPERACION' = 'VCTO.CUPON.'--PRO.descripcion  
  ,'Indicador'   = CASE   
         WHEN mo.rstipoper in ('CP','CI','ICOL','CFM','RC','RCA','VICAP') THEN 'P'   
         ELSE 'S'   
          END         --indicador  
  ,'Fecha_operacion'  = mo.rsfecha       --Fecha_operacion  
  
  ,'Usuario'    = (select top 1 mh.mousuario from bactradersuda..mdmh mh where monumoper = rsnumoper) --mousuario        --usuario  
  ,'Moneda'    = CASE   
         WHEN emi.mncodmon = 998 THEN @mnnemo  
         ELSE emi.mnnemo   
          END         --moneda CLP  
  ,'Glosa_Moneda'   = CASE   
         WHEN emi.mncodmon = 998 THEN @mnglosa  
         ELSE emi.mnglosa     --Pesos  
          END  
  ,'Rut_cliente'   = rsrutcli        --rut_cliente  
  ,'Dv_cliente'   = cl.cldv        --dv_cliente  
  ,'Sucursal'    = 0          --sucursal  
  ,'Monto_operacion'  = sum(mo.rsvppresen)  
  ,'Forma_pago'   = CASE   
         WHEN mo.rstipoper in ('CP','VP','VI','VIX','CI','CIX','ICOL','ICOLX','ICAP','ICAPX','CFM') THEN mo.rsforpagi   
          ELSE mo.rsforpagv END    --Forma_Pago  
  ,'Glosa_Forma_pago'  = ini.glosa  
  ,'Codigo_valuta'  = ini.diasvalor  
  ,'Nombre_cliente'  = cl.clnombre  
    
  ,'Banco'    = CONVERT(CHAR(4),'') -- se reemplaza por primeros 4 dig del código swift, enviados por banco Itaú  
  ,'CtaCteBenVendedor' = 0--CONVERT(CHAR(15),'')  
  
  ,'Clave_abif'   = CONVERT(CHAR(20),'')  
  ,'Cta_comprador'  = CASE WHEN mo.RStipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN ' ' ELSE 'X' END  
  ,'Codigo_dcv_comprador' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Cta_vendedor'   = '' --CASE WHEN mo.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN 'X' ELSE ' ' END  
  ,'Codigo_dcv_vendedor' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Monto_original'  = sum(mo.rsvppresen)  
  ,'Fecha_inicio'   = mo.rsfecha  
  ,'Tasa_interes'   = CASE WHEN mo.RStipoper in ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.RStir) ELSE 0 END  
  ,'Interes'    = CASE WHEN mo.RStipoper in ('ICOL', 'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mo.RSinteres) ELSE 0 END  
  ,'Monto_vencimiento' = CASE WHEN mo.rstipoper in ('VI' ,'CI' ,'ICAP' ,'ICOL',  
                                                                         'VIX','CIX','ICAPX','ICOLX') THEN SUM(mo.rsvppresen) *  
                             ISNULL((SELECT   
                               CASE WHEN vmvalor = 0 THEN 1   
                               ELSE vmvalor   
                               END   
                             FROM BacParamSuda..VALOR_MONEDA   
                             WHERE vmcodigo= max(mo.rsmonpact) and vmfecha = mo.rsfecha),1)   
          WHEN mo.rstipoper in ('RC','RC','VICOL','VICAP','VICOLX','VICAPX') THEN sum(mo.rsvppresen)  
                                                                                   ELSE 0  
         END  
  ,'Fecha_vencimiento'  = CASE WHEN mo.rstipoper in ('CP','VP' ,'CPX','VPX' ) THEN MAX(mo.rsfecvcto)  
         WHEN mo.rstipoper in ('VC','VCI','VCX','VCIX') THEN  mo.rsfecha  
                                                               ELSE  mo.rsfecvtop  
         END  
  ,'Reajustabilidad' = CONVERT(CHAR(15),'999')  
  ,'Tasa_Pacto'  = 0 --CASE WHEN mo.motipoper in ('VI' ,'CI' ,'RC' ,'RV' ,'RCA' ,'RVA'  ,  
                                 --                                        'VIX','CIX','RCX','RVX','RCAX','RVAX' ) THEN max(mo.motaspact)  
                  --  WHEN mo.motipoper in ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP',  
                                 --                                                'ICOLX','ICAPX','VICOLX','VICAPX' )   THEN max(mo.motir)  
                  --                                                                  ELSE 0   
                              --END  
  ,'Monto_Final'  = sum(mo.rsvppresen)  
  ,'Monto_Nominal'  = CASE WHEN mo.rstipoper IN ('VI','CI','VIX','CIX') THEN sum(mo.rsvppresen)  
                    WHEN mo.rstipoper IN ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP' ,'RC' ,'RCA' ,'RV' ,'RVA' ,  
                                                                                 'ICOLX','ICAPX','VICOLX','VICAPX','RCX','RCAX','RVX','RVAX') THEN sum(mo.rsvalinip)  
                                   ELSE 0   
                              END  
  ,'Tasa_descuento'     = 0  
  ,'Valor_tasa'      = 0  
  ,'Custodia'          = 'DCV'  
  ,'Numero_instrumentos' = COUNT(mo.rscorrela)  
  ,'Monto_total'      = sum(mo.rsvppresen)  
  ,'Codigo_mon_mx'  = 0  
  ,'Monto_mx'    = 0  
  ,'Tasa_cambio'   = 0  
  ,'Fecha_valor_mx'  = '19000101'  
  ,'Forma_pago_neg'  = CASE WHEN mo.rstipoper in ('CP' ,'VP' ,'VI' ,'CI' ,'ICOL' ,'ICAP' ,'CFM',  
                                                                        'CPX','VPX','VIX','CIX','ICOLX','ICAPX'      ) THEN mo.rsforpagi   
          ELSE mo.rsforpagv END  
  ,'Sesion'    = ''  
    
  ,'NombreClienteBen_3' = ''  
  ,'NombreClienteBen_4' = ''  
  ,'UsuarioMDP'   = '' -- Se actualiza como gsBAC_User en la aplicación  
  ,'UsuarioIngreso'  = (select top 1 mh.mousuario from bactradersuda..mdmh mh where monumoper = rsnumoper) --mousuario  
  ,'CargoCtaCte'   = 'N'  
  ,'SobregiroCtaCte'  = 'N'  
  ,'PvpReferencia'  = ''  
  ,'PvpMoneda'   = ''  
  ,'PvpTasaCambio'  = 0  
  ,'PvpMonto'    = 0  
  ,mo.rscodcli  
  ,'Codigo_dcv2'   = CONVERT(CHAR(20),'S/C')  
  ,'Estado'    = 'PP'  
 FROM BACTRADERSUDA..MDRS mo  
 LEFT JOIN bacparamsuda..CLIENTE cl ON mo.rsrutcli  = cl.clrut   
          AND mo.rscodcli = cl.clcodigo  
 LEFT JOIN bacparamsuda..MONEDA emi ON emi.mncodmon = CASE   
               WHEN mo.rstipoper in ('CI','VI') THEN mo.rsmonpact   
                ELSE 999  
               END  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ini ON mo.rsforpagi = ini.codigo  
 LEFT JOIN bacparamsuda..FORMA_DE_PAGO ven ON mo.rsforpagv = ven.codigo  
 WHERE  
  ini.codigo IS NOT NULL  
  AND ven.codigo IS NOT NULL  
  AND (mo.rsrutcli           = @iRut   OR @iRut  = 0)  
  AND (mo.rscodcli           = @iCodCli  OR @iCodCli  = 0)  
  AND (cl.cltipcli           = @iTipCli  OR @iTipCli  = 0)  
  AND (mo.rstipoper          = @cTipOper  OR @cTipOper = '')  
  AND (mo.rsnumoper          = @iNumOper  OR @iNumOper = 0)  
  AND MO.rsinstser IN ('ICAP','ICOL')  
  AND MO.rstipoper = 'VC'  
  AND mo.rsfecha = @mofecpro  
  AND mo.rsnumoper NOT IN (SELECT numero_operacion FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO)  
 GROUP BY  
  mo.rstipoper  
  ,mo.rsnumoper  
  ,mo.rsrutcli  
  ,mo.rsfecvtop  
  ,mo.rsfecha  
  ,mo.rsforpagi  
  ,mo.rsforpagv  
  ,mo.rscodcli  
  --,mh.mousuario  
  ,ini.diasvalor  
  ,cl.clnombre  
  ,cl.cldv  
  ,cl.clgeneric  
  ,ini.glosa  
  ,emi.mncodmon  
  ,emi.mnnemo  
  ,emi.mnglosa  
  --,pro.descripcion  
  ,mo.rstipopero  
  ,mo.rsinstser  
 /*********************RENTA FIJA Operaciones RESULTADO*********************************/  
  
  
  
/*********************RENTA FIJA EXTRANJERA*****************************************/  
-- RENTA FIJA INTERNACIONAL  
 INSERT INTO NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
 SELECT  
  --> 2022.04.14 INI Operaciones no deben aparecer  
  @mofecpro  
  ,'Envio'     = CASE  
          WHEN ao.Estado = 'A' THEN 'NO'  
         END  
  --< 2022.04.14 FIN Operaciones no deben aparecer  
        ,'codigo_producto'  = 'BEX'  
        ,'numero_operacion'  = monumoper  
        ,'tipo_operacion'  = CONVERT(CHAR(10),CASE WHEN m.motipoper IN('CFM','RFM') THEN 'FFMM' ELSE m.motipoper END)  
  ,'glosa_tipo_operacion' = pro.descripcion  
        ,'indicador'            = CASE WHEN m.motipoper in ('CP','CI','ICOL','CFM','RC','RCA','VICAP') THEN 'P' ELSE 'C' END  
        ,'Fecha_operacion'  = mofecpro  
        ,'usuario'    = mousuario  
        ,'Moneda'    = emi.mnnemo       --moneda CLP  
  ,'Glosa_Moneda'   = emi.mnglosa       --Pesos  
        ,'rut_cliente'   = morutcli  
        ,'Dv_cliente'   = g.cldv        --dv_cliente  
  ,'sucursal'    = 0  
        ,'monto_operacion'  = sum(m.monominal)   
        ,'Forma_Pago'   = CASE WHEN m.motipoper in ('CP','VP','VI','VIX','CI','CIX','ICOL','ICOLX','ICAP','ICAPX','CFM') THEN m.forma_pago ELSE m.forma_pago END  
        ,'Glosa_Forma_pago'  = f.glosa        --glosa forma de pago  
  ,'Codigo_valuta'        = f.diasvalor  
        ,'nombre_cliente'  = clnombre  
          
  ,'Banco'    = m.corr_cli_swift  --CONVERT(CHAR(4),'')  
  ,'CtaCteBenVendedor' = m.corr_cli_cta  --CuentaBeneficiario  
  
  ,'Clave_abif'   = CONVERT(CHAR(20),'')  
        ,'Cta_comprador'        = CASE WHEN m.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN ' ' ELSE 'X' END  
        ,'Codigo_dcv_comprador' = CONVERT(CHAR(20),'S/C')  
  ,'Cta_vendedor'   = ''--CASE WHEN m.motipoper in ('CP','CI','CIX','ICOL','ICOLX','CFM','RC','RCA','VICAP','VICAPX') THEN 'X' ELSE ' ' END  
        ,'Codigo_dcv_vendedor' = CONVERT(CHAR(20),'S/C')  
        ,'Monto_original'  = sum(m.momtps)  
        ,'Fecha_inicio'   = mofecpro  
        ,'Tasa_interes'   = CASE WHEN m.motipoper in ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP',  
                                                                         'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(motir) ELSE 0 END  
        ,'Interes'    = CASE WHEN m.motipoper in ('ICOL', 'ICAP' ,'VICOL' ,'VICAP',  
                                             'ICOLX','ICAPX','VICOLX','VICAPX') THEN max(mointeres) ELSE 0 END  
        ,'Monto_vencimiento'    = CASE  
          WHEN m.motipoper in ('VI' ,'CI' ,'ICAP' ,'ICOL',  
                                                                         'VIX','CIX','ICAPX','ICOLX') THEN SUM(movalvenc) *  
               ISNULL((SELECT CASE WHEN vmvalor =0 THEN 1 ELSE vmvalor END   
               FROM BacParamSuda.dbo.VALOR_MONEDA  
               WHERE vmcodigo= max(momonemi) and vmfecha = mofecpro),1)  
          WHEN m.motipoper in ('RC','RC','VICOL','VICAP','VICOLX','VICAPX') THEN sum(m.momtps)  
          ELSE 0   
          END  
        ,'Fecha_vencimiento'    = CASE  
         WHEN  m.motipoper in ('CP','VP' ,'CPX','VPX' ) THEN MAX(mofecven)  
         WHEN  m.motipoper in ('VC','VCI','VCX','VCIX') THEN  mofecpro  
                                    ELSE  mofecven   
          END  
        ,'Reajustabilidad'  = CONVERT(CHAR(15),'999')  
        ,'Tasa_Pacto'   = 0 --CASE  
         --WHEN m.motipoper in ('VI' ,'CI' ,'RC' ,'RV' ,'RCA' ,'RVA'  ,  
                                    --                                     'VIX','CIX','RCX','RVX','RCAX','RVAX' ) THEN 0  
         --WHEN m.motipoper in ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP',  
                                    --                                             'ICOLX','ICAPX','VICOLX','VICAPX' ) THEN max(motir)  
          --ELSE 0   
          --END  
        ,'Monto_Final'   = m.movalvenc  
        ,'Monto_Nominal'  = CASE  
         WHEN m.motipoper IN ('VI','CI','VIX','CIX') THEN 0  
         WHEN m.motipoper IN ('ICOL' ,'ICAP' ,'VICOL' ,'VICAP' ,'RC' ,'RCA' ,'RV' ,'RVA' ,  
                                                                                 'ICOLX','ICAPX','VICOLX','VICAPX','RCX','RCAX','RVX','RVAX') THEN sum(m.momontoemi)  
                                    ELSE 0  
          END  
        ,'tasa_descuento'  = 0  
        ,'valor_tasa'           = 0  
        ,'custodia'             = 'DCV'  
        ,'Numero_instrumentos'  = COUNT(m.mocorrelativo)  
        ,'Monto_total'          = m.momtps  
        ,'codigo_mon_mx'        = 0  
        ,'monto_mx'    = 0  
        ,'tasa_cambio'   = 0  
        ,'fecha_valor_mx'  = ' '  
        ,'Forma_pago_neg'  = CASE WHEN m.motipoper in ('CP' ,'VP' ,'VI' ,'CI' ,'ICOL' ,'ICAP' ,'CFM',  
                                                                        'CPX','VPX','VIX','CIX','ICOLX','ICAPX'      ) THEN m.forma_pago ELSE m.forma_pago END  
        ,'Sesion'    = ''  
  ,'NombreClienteBen_3' = ''  
  ,'NombreClienteBen_4' = ''  
  ,'UsuarioMDP'   = '' -- Se actualiza como gsBAC_User  
  ,'UsuarioIngreso'  = mousuario  
  ,'CargoCtaCte'   = 'N'  
  ,'SobregiroCtaCte'  = 'N'  
  --> 2021.07.01 Campos nuevos en la definición del WS  
  ,'PvpReferencia'  = ''  
  ,'PvpMoneda'   = ''  
  ,'PvpTasaCambio'  = 0  
  ,'PvpMonto'    = 0  
  --< 2021.07.01 Campos nuevos en la definición del WS  
  ,mocodcli  
        ,'Codigo_dcv2'        = CONVERT(CHAR(20),'S/C')  
  ,'Estado'   = CASE  
         WHEN ao.Estado = 'A' THEN 'PP'  
        ELSE ' '  
        END  
    FROM  
  Bacbonosextsuda..TEXT_MVT_DRI     M  
        INNER JOIN Bacbonosextsuda..view_forma_de_pago     f  
   ON M.forma_pago = F.codigo  
        INNER JOIN Bacbonosextsuda..VIEW_CLIENTE           g  
   ON M.MORUTCLI = G.CLRUT   
   AND M.MOCODCLI = G.CLCODIGO  
  INNER JOIN baclineas..aprobacion_operaciones ao  
   ON m.monumoper = ao.numerooperacion  
  INNER JOIN baclineas..detalle_aprobaciones do  
   ON ao.id_sistema = do.id_sistema   
   AND ao.numerooperacion = do.numero_operacion  
  LEFT JOIN bacparamsuda..MONEDA emi  
   ON m.momonpag  = emi.mncodmon  
  INNER JOIN bacparamsuda..PRODUCTO pro  
   ON pro.codigo_producto = m.motipoper  
 WHERE   
   (ao.id_sistema   = @cSistema  OR @cSistema ='')  
  AND (ao.Estado    = @EstadoConf OR @EstadoConf = '')  
  AND  ao.Operador_Ap_Limites  <> ''  
  AND ao.Operador_Ap_Lineas   <> ''  
  AND ao.Operador_Ap_Tasas    <> ''  
  AND ao.Operador_Ap_Grp      <> ''  
  AND F.codigo IS NOT NULL  
  AND (m.morutcli           = @iRut   OR @iRut  = 0)  
  AND (m.mocodcli           = @iCodCli  OR @iCodCli  = 0)  
  AND (G.cltipcli           = @iTipCli  OR @iTipCli  = 0)  
  AND (m.motipoper          = @cTipOper  OR @cTipOper = '')  
  AND (m.monumoper          = @iNumOper  OR @iNumOper = 0)  
  AND m.motipoper NOT IN ('TM')  
  AND m.mofecpro = @mofecpro  
  AND m.monumoper NOT IN (SELECT numero_operacion FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO)  
 GROUP BY  
  ao.Estado  
  ,g.cldv  
  ,f.glosa  
  ,m.motipoper  
  ,m.monumoper  
  ,m.morutcli  
  ,m.mofecven  
  ,m.mofecpro  
  ,m.forma_pago--moforpagi  
  ,m.forma_pago--moforpagv  
  ,m.corr_cli_cta  
  ,m.corr_cli_swift  
  ,mocodcli  
  ,mousuario  
  ,f.diasvalor  
  ,g.clnombre  
  ,momtps--aqui  
  ,m.movalvenc--aqui  
  ,g.clgeneric  
  ,emi.mnnemo  
  ,emi.mnglosa  
  ,pro.codigo_producto  
  ,pro.descripcion  
/*********************RENTA FIJA EXTRANJERA*****************************************/  
  
  
  
  
  
    
/**************************ENVIO A PAGO SWAP**********************************/  
-- SWAP se agregan solamente flujo PAGAMOS y quedan afuera las operaciones tipo FRA   
 --ENTREGA COMPENSACION  
 INSERT INTO NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
 SELECT DISTINCT   
  --> 2022.04.14 INI Operaciones no deben aparecer  
  @mofecpro  
  ,'Envio'     =  'NO'/*CASE  
          WHEN ao.Estado = 'A' THEN 'NO'  
         END*/  
  --< 2022.04.14 FIN Operaciones no deben aparecer  
  ,'Sistema'    = 'PCS'--pro.id_sistema       --codigo_producto  
  ,'Numero_operacion'  = mo.NUMERO_OPERACION       --numero_operacion  
  
  ,'Tipo_operacion'  = tg.nemo  
  ,'Glosa_Tipo_operacion' = tg.tbglosa  
  ,'Indicador'   = CASE   
         WHEN mo.tipo_flujo in (1) THEN 'S'  --'P'   
         ELSE 'P'--'S'   
          END           --indicador  
  ,'Fecha_operacion'  = CH.fecha_cierre --mo.fecha_cierre        --Fecha_operacion  
  
  ,'Usuario'    = mo.operador         --mousuario  
  ,'Moneda'    = CASE   
         WHEN mo.tipo_flujo = 1 THEN emi.mnnemo --mo.compra_moneda  
         ELSE pac.mnnemo --mo.venta_moneda   
          END           --moneda CLP  
  ,'Glosa_Moneda'   =  CASE   
         WHEN mo.tipo_flujo = 1 THEN emi.mnglosa  
         ELSE pac.mnglosa  
          END  
  ,'Rut_cliente'   = MO.Rut_Contraparte-- mo.rut_cliente        --rut_cliente  
  ,'Dv_cliente'   = cl.cldv          --dv_cliente  
  ,'Sucursal'    = 0            --sucursal  
  ,'Monto_operacion'  = abs(mo.MontoM1)--aqui SUM((CASE WHEN mo.tipo_flujo IN (1) THEN CH.compra_capital ELSE CH.venta_capital END))--SUM((CASE WHEN mo.tipo_flujo IN (1) THEN mo.compra_capital ELSE mo.venta_capital END))         --monto_operacion  
  
  ,'Forma_pago'   =  mo.FormaPago1--CASE WHEN mo.tipo_flujo IN (1) THEN mo.FormaPago1 ELSE mo.FormaPago2 END --CASE WHEN mo.tipo_flujo IN (1) THEN mo.recibimos_documento ELSE mo.pagamos_documento END           --Forma_Pago  
  ,'Glosa_Forma_pago'  = ini.glosa  
  ,'Codigo_valuta'  = ini.diasvalor  
  ,'Nombre_cliente'  = cl.clnombre  
    
  ,'Banco'    = CONVERT(CHAR(4),'') -- se reemplaza por primeros 4 dig del código swift, enviados por banco Itaú  
  ,'CtaCteBenVendedor' = 0  
  ,'Clave_abif'   = CONVERT(CHAR(20),'')  
  ,'Cta_comprador'  = CASE WHEN mo.tipo_flujo in (1) THEN ' ' ELSE 'X' END  
  ,'Codigo_dcv_comprador' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Cta_vendedor'   = ''  
  ,'Codigo_dcv_vendedor' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Monto_original'  = SUM(CH.compra_capital) --SUM((CASE WHEN mo.tipo_flujo in (1) THEN CH.compra_capital ELSE CH.venta_capital END))--SUM((CASE WHEN mo.tipo_flujo in (1) THEN mo.compra_capital ELSE mo.venta_capital END))--aqui sum(mo.momtps)  
  ,'Fecha_inicio'   = CH.fecha_inicio --mo.fecha_inicio  
  ,'Tasa_interes'   = CASE WHEN mo.tipo_flujo in (1) THEN max(CH.compra_valor_tasa) ELSE 0 END--MOTIR--CASE WHEN mo.tipo_flujo in (1) THEN max(mo.compra_valor_tasa) ELSE 0 END--MOTIR  
  ,'Interes'    = CASE WHEN mo.tipo_flujo in (1) THEN max(CH.compra_interes) ELSE 0 END--mointeres--CASE WHEN mo.tipo_flujo in (1) THEN max(mo.compra_interes) ELSE 0 END--mointeres  
                    
  ,'Monto_vencimiento' = abs(mo.MontoM1)  
        /*CASE WHEN mo.tipo_flujo in (1) THEN SUM(ch.compra_capital) *  
                         ISNULL((SELECT   
                           CASE WHEN vmvalor = 0 THEN 1   
                           ELSE vmvalor   
                           END   
                         FROM BacParamSuda..VALOR_MONEDA   
                         WHERE vmcodigo= max((CASE WHEN mo.tipo_flujo in (1) THEN mo.compra_moneda ELSE mo.venta_moneda END))   
                          and vmfecha = ch.fecha_cierre),1)   
          WHEN mo.tipo_flujo in (1) THEN sum(mo.compra_moneda)--momtps  
                                                                                   ELSE 0  
         END*/  
  ,'Fecha_vencimiento'  = MAX(mo.fechaLiquidacion)--MAX(ch.fecha_termino)--MAX(mo.fecha_termino)  
  ,'Reajustabilidad' = CONVERT(CHAR(15),'999')  
  ,'Tasa_Pacto'  = 0  
  ,'Monto_Final'  = abs(mo.MontoM1)--sum(ch.venta_capital)  
       --SUM((CASE WHEN mo.tipo_flujo in (1) THEN ch.compra_capital ELSE ch.venta_capital END))--momtps  
  ,'Monto_Nominal' = --sum(ch.venta_capital)  
        SUM((CASE WHEN mo.tipo_flujo in (1) THEN ch.compra_capital ELSE ch.venta_capital END))  
        /*  
        CASE WHEN mo.tipo_flujo in (1) THEN SUM(MO.compra_moneda)--AQUI sum(mo.momtps)  
                    WHEN mo.tipo_flujo in (1) THEN SUM(MO.compra_moneda)--AQUI sum(mo.movalinip)  
                                   ELSE 0   
                              END*/  
  ,'Tasa_descuento'     = 0  
  ,'Valor_tasa'      = 0  
  ,'Custodia'          = 'DCV'--AQUI  
  ,'Numero_instrumentos' = mo.Correlativo--COUNT(MO.Correlativo)--COUNT(MO.numero_flujo)--AQUI COUNT(mo.mocorrela)  
  ,'Monto_total'      = SUM((CASE WHEN mo.tipo_flujo in (1) THEN ch.compra_capital ELSE ch.venta_capital END))--AQUI sum(mo.momtps)  
  ,'Codigo_mon_mx'  = 0  
  ,'Monto_mx'    = 0  
  ,'Tasa_cambio'   = 0  
  ,'Fecha_valor_mx'  = '19000101'  
  ,'Forma_pago_neg'  = CASE WHEN mo.tipo_flujo in (1) THEN MO.FormaPago1--mo.moforpagi   
          ELSE MO.FormaPago2 END --mo.moforpagv END  
  ,'Sesion'    = ''  
    
  ,'NombreClienteBen_3' = ''  
  ,'NombreClienteBen_4' = ''  
  ,'UsuarioMDP'   = '' -- Se actualiza como gsBAC_User en la aplicación  
  ,'UsuarioIngreso'  = MO.operador--MO.usuario  
  ,'CargoCtaCte'   = 'N'  
  ,'SobregiroCtaCte'  = 'N'  
  --> 2021.07.01 Campos nuevos en la definición del WS  
  ,'PvpReferencia'  = ''  
  ,'PvpMoneda'   = ''  
  ,'PvpTasaCambio'  = 0  
  ,'PvpMonto'    = 0  
  --< 2021.07.01 Campos nuevos en la definición del WS  
  ,mo.Codigo_Contraparte   --mo.mocodcli  
  ,'Codigo_dcv2'   = CONVERT(CHAR(20),'S/C')  
  ,'Estado'    = 'PP'/*CASE  
          WHEN ao.Estado = 'A' THEN 'PP'  
         ELSE ' '  
         END*/  
  
 FROM BACPARAMSUDA..TBL_CAJA_DERIVADOS MO  
 INNER JOIN BacSwapSuda..Carterahis CH ON CH.numero_operacion = MO.Numero_Operacion  
 INNER JOIN BACSWAPSUDA..SWAPGENERAL G ON  1=1  
 LEFT JOIN BACPARAMSUDA..CLIENTE CL ON MO.Rut_Contraparte  = CL.CLRUT   
          AND MO.Codigo_Contraparte = CL.CLCODIGO  
 LEFT JOIN BACPARAMSUDA..MONEDA EMI  
          ON CASE WHEN MO.COMPRA_MONEDA = 998 THEN 999   
           ELSE MO.COMPRA_MONEDA  
           END = EMI.MNCODMON  
 LEFT JOIN BACPARAMSUDA..MONEDA PAC ON CASE WHEN MO.VENTA_MONEDA = 998 THEN 999   
           ELSE MO.VENTA_MONEDA   
           END = PAC.MNCODMON  
 LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO INI   ON MO.FormaPago1 = INI.CODIGO  
 LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO VEN   ON MO.FormaPago2 = VEN.CODIGO  
 INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE TG ON MO.Producto = TG.TBCODIGO1  
              AND TG.TBCATEG = 9937  
 WHERE MO.fecha_Vence_Flujo = G.fechaproc--MO.fechaliquidacion = G.fechaproc  
 --> 2022.04.14 INI cvegasan Pto 1 al parecer falta un filtro por la fecha ya que se repiten las fechas de inicio  
 AND ch.fecha_vence_flujo=G.fechaproc--AND ch.fechaliquidacion=G.fechaproc  
 --< 2022.04.14 INI cvegasanPto 1 al parecer falta un filtro por la fecha ya que se repiten las fechas de inicio  
 AND  (@cSistema = 'PCS' or @cSistema = '')  
   
 AND (mo.Rut_Contraparte   = @iRut   OR @iRut  = 0)  
 AND (mo.Codigo_Contraparte  = @iCodCli  OR @iCodCli  = 0)  
 AND (cl.cltipcli   = @iTipCli  OR @iTipCli  = 0)  
 --AND (mo.tipo_swap  = @cTipOper  OR @cTipOper = '')  
 AND (mo.numero_operacion = @iNumOper  OR @iNumOper = 0)  
 AND mo.numero_operacion NOT IN (SELECT numero_operacion FROM bacparamsuda..NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO)  
 AND mo.Producto <>3 --> Quedan afuera los FRA  
 and mo.Modalidad_Pago ='C'  
 AND MO.MontoM1  <> 0.0                                                            -- Pagamos_Monto  
 AND MO.Modulo = 'PCS'  
 GROUP BY   
  mo.numero_operacion  
  --,CH.compra_capital--,mo.compra_capital  
  --,CH.tipo_swap--mo.tipo_swap  
  --,CH.tipo_operacion--mo.tipo_operacion  
  ,CH.fecha_cierre--mo.fecha_cierre  
  ,mo.operador  
  --,emi.mncodmon  
  ,emi.mnnemo  
  ,pac.mnnemo  
  ,emi.mnglosa  
  ,pac.mnglosa  
  ,mo.Rut_Contraparte--mo.rut_cliente  
  ,cl.cldv  
  ,mo.FormaPago1--mo.recibimos_documento  
  ,mo.FormaPago2---mo.pagamos_documento  
  ,ini.glosa  
  ,ini.diasvalor  
  ,cl.clnombre  
  --,cl.clgeneric  
  ,ch.fecha_inicio--mo.fecha_inicio  
  --,ch.compra_valor_tasa--mo.compra_valor_tasa  
  --,mo.compra_moneda  
  --,ch.fecha_termino--mo.fecha_termino  
  ,mo.Codigo_Contraparte--mo.codigo_cliente  
  --,mo.Estado_oper_lineas  
  ,mo.tipo_flujo  
  --,mo.compra_moneda  
  --,mo.venta_moneda  
  ,tg.nemo  
  ,tg.tbglosa  
  ,mo.Correlativo  
  ,mo.MonedaM1  
  ,mo.MontoM1  
  --,ch.venta_capital  
  --,MontoM1Local  
  --,CH.venta_capital  
    
  
 --ENTREGA FISICA  
 INSERT INTO NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
 SELECT DISTINCT   
  --> 2022.04.14 INI Operaciones no deben aparecer  
  @mofecpro  
  ,'Envio'     =  'NO'/*CASE  
          WHEN ao.Estado = 'A' THEN 'NO'  
         END*/  
  --< 2022.04.14 FIN Operaciones no deben aparecer  
  ,'Sistema'    = 'PCS'--pro.id_sistema       --codigo_producto  
  ,'Numero_operacion'  = mo.NUMERO_OPERACION       --numero_operacion  
  
  ,'Tipo_operacion'  = tg.nemo  
  ,'Glosa_Tipo_operacion' = tg.tbglosa  
  ,'Indicador'   = CASE   
         WHEN mo.tipo_flujo in (1) THEN 'S'--'P'   
         ELSE 'P'--'S'   
          END           --indicador  
  ,'Fecha_operacion'  = CH.fecha_cierre --mo.fecha_cierre        --Fecha_operacion  
  
  ,'Usuario'    = mo.operador         --mousuario  
  ,'Moneda'    = CASE   
         WHEN mo.tipo_flujo = 1 THEN emi.mnnemo --mo.compra_moneda  
         ELSE pac.mnnemo --mo.venta_moneda   
          END           --moneda CLP  
  ,'Glosa_Moneda'   =  CASE   
         WHEN mo.tipo_flujo = 1 THEN emi.mnglosa  
         ELSE pac.mnglosa  
          END  
  ,'Rut_cliente'   = MO.Rut_Contraparte-- mo.rut_cliente        --rut_cliente  
  ,'Dv_cliente'   = cl.cldv          --dv_cliente  
  ,'Sucursal'    = 0            --sucursal  
  ,'Monto_operacion'  = abs(mo.MontoM2)--aqui SUM((CASE WHEN mo.tipo_flujo IN (1) THEN CH.compra_capital ELSE CH.venta_capital END))--SUM((CASE WHEN mo.tipo_flujo IN (1) THEN mo.compra_capital ELSE mo.venta_capital END))         --monto_operacion  
  
  ,'Forma_pago'   =  mo.FormaPago1--CASE WHEN mo.tipo_flujo IN (1) THEN mo.FormaPago1 ELSE mo.FormaPago2 END --CASE WHEN mo.tipo_flujo IN (1) THEN mo.recibimos_documento ELSE mo.pagamos_documento END           --Forma_Pago  
  ,'Glosa_Forma_pago'  = ini.glosa  
  ,'Codigo_valuta'  = ini.diasvalor  
  ,'Nombre_cliente'  = cl.clnombre  
    
  ,'Banco'    = CONVERT(CHAR(4),'') -- se reemplaza por primeros 4 dig del código swift, enviados por banco Itaú  
  ,'CtaCteBenVendedor' = 0  
  ,'Clave_abif'   = CONVERT(CHAR(20),'')  
  ,'Cta_comprador'  = CASE WHEN mo.tipo_flujo in (1) THEN ' ' ELSE 'X' END  
  ,'Codigo_dcv_comprador' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Cta_vendedor'   = ''  
  ,'Codigo_dcv_vendedor' = CONVERT(CHAR(20),'S/C')    -- tiene campo moclave_dcv  
  ,'Monto_original'  = SUM(CH.compra_capital) --SUM((CASE WHEN mo.tipo_flujo in (1) THEN CH.compra_capital ELSE CH.venta_capital END))--SUM((CASE WHEN mo.tipo_flujo in (1) THEN mo.compra_capital ELSE mo.venta_capital END))--aqui sum(mo.momtps)  
  ,'Fecha_inicio'   = CH.fecha_inicio --mo.fecha_inicio  
  ,'Tasa_interes'   = CASE WHEN mo.tipo_flujo in (1) THEN max(CH.compra_valor_tasa) ELSE 0 END--MOTIR--CASE WHEN mo.tipo_flujo in (1) THEN max(mo.compra_valor_tasa) ELSE 0 END--MOTIR  
  ,'Interes'    = CASE WHEN mo.tipo_flujo in (1) THEN max(CH.compra_interes) ELSE 0 END--mointeres--CASE WHEN mo.tipo_flujo in (1) THEN max(mo.compra_interes) ELSE 0 END--mointeres  
                    
  ,'Monto_vencimiento' = abs(mo.MontoM2)  
        /*CASE WHEN mo.tipo_flujo in (1) THEN SUM(ch.compra_capital) *  
                         ISNULL((SELECT   
                           CASE WHEN vmvalor = 0 THEN 1   
                           ELSE vmvalor   
                           END   
                         FROM BacParamSuda..VALOR_MONEDA   
                         WHERE vmcodigo= max((CASE WHEN mo.tipo_flujo in (1) THEN mo.compra_moneda ELSE mo.venta_moneda END))   
                          and vmfecha = ch.fecha_cierre),1)   
          WHEN mo.tipo_flujo in (1) THEN sum(mo.compra_moneda)--momtps  
                                                                                   ELSE 0  
         END*/  
  ,'Fecha_vencimiento'  = MAX(mo.fechaLiquidacion)--MAX(ch.fecha_termino)--MAX(mo.fecha_termino)  
  ,'Reajustabilidad' = CONVERT(CHAR(15),'999')  
  ,'Tasa_Pacto'  = 0  
  ,'Monto_Final'  = abs(mo.MontoM2)--sum(ch.venta_capital)  
       --SUM((CASE WHEN mo.tipo_flujo in (1) THEN ch.compra_capital ELSE ch.venta_capital END))--momtps  
  ,'Monto_Nominal' = --sum(ch.venta_capital)  
        SUM((CASE WHEN mo.tipo_flujo in (1) THEN ch.compra_capital ELSE ch.venta_capital END))  
        /*  
        CASE WHEN mo.tipo_flujo in (1) THEN SUM(MO.compra_moneda)--AQUI sum(mo.momtps)  
                    WHEN mo.tipo_flujo in (1) THEN SUM(MO.compra_moneda)--AQUI sum(mo.movalinip)  
                                   ELSE 0   
                              END*/  
  ,'Tasa_descuento'     = 0  
  ,'Valor_tasa'      = 0  
  ,'Custodia'          = 'DCV'--AQUI  
  ,'Numero_instrumentos' = mo.Correlativo--COUNT(MO.Correlativo)--COUNT(MO.numero_flujo)--AQUI COUNT(mo.mocorrela)  
  ,'Monto_total'      = SUM((CASE WHEN mo.tipo_flujo in (1) THEN ch.compra_capital ELSE ch.venta_capital END))--AQUI sum(mo.momtps)  
  ,'Codigo_mon_mx'  = 0  
  ,'Monto_mx'    = 0  
  ,'Tasa_cambio'   = 0  
  ,'Fecha_valor_mx'  = '19000101'  
  ,'Forma_pago_neg'  = CASE WHEN mo.tipo_flujo in (1) THEN MO.FormaPago1--mo.moforpagi   
          ELSE MO.FormaPago2 END --mo.moforpagv END  
  ,'Sesion'    = ''  
    
  ,'NombreClienteBen_3' = ''  
  ,'NombreClienteBen_4' = ''  
  ,'UsuarioMDP'   = '' -- Se actualiza como gsBAC_User en la aplicación  
  ,'UsuarioIngreso'  = MO.operador--MO.usuario  
  ,'CargoCtaCte'   = 'N'  
  ,'SobregiroCtaCte'  = 'N'  
  --> 2021.07.01 Campos nuevos en la definición del WS  
  ,'PvpReferencia'  = ''  
  ,'PvpMoneda'   = ''  
  ,'PvpTasaCambio'  = 0  
  ,'PvpMonto'    = 0  
  --< 2021.07.01 Campos nuevos en la definición del WS  
  ,mo.Codigo_Contraparte   --mo.mocodcli  
  ,'Codigo_dcv2'   = CONVERT(CHAR(20),'S/C')  
  ,'Estado'    = 'PP'/*CASE  
          WHEN ao.Estado = 'A' THEN 'PP'  
         ELSE ' '  
         END*/  
  
 FROM BACPARAMSUDA..TBL_CAJA_DERIVADOS MO  
 INNER JOIN BacSwapSuda..Carterahis CH ON CH.numero_operacion = MO.Numero_Operacion  
 INNER JOIN BACSWAPSUDA..SWAPGENERAL G ON  1=1  
 LEFT JOIN BACPARAMSUDA..CLIENTE CL ON MO.Rut_Contraparte  = CL.CLRUT   
          AND MO.Codigo_Contraparte = CL.CLCODIGO  
 LEFT JOIN BACPARAMSUDA..MONEDA EMI  
          ON CASE WHEN MO.COMPRA_MONEDA = 998 THEN 999   
           ELSE MO.COMPRA_MONEDA  
           END = EMI.MNCODMON  
 LEFT JOIN BACPARAMSUDA..MONEDA PAC ON CASE WHEN MO.VENTA_MONEDA = 998 THEN 999   
           ELSE MO.VENTA_MONEDA   
           END = PAC.MNCODMON  
 LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO INI   ON MO.FormaPago1 = INI.CODIGO  
 LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO VEN   ON MO.FormaPago2 = VEN.CODIGO  
 INNER JOIN BACPARAMSUDA..TABLA_GENERAL_DETALLE TG ON MO.Producto = TG.TBCODIGO1  
              AND TG.TBCATEG = 9937  
 --INNER JOIN BACLINEAS..APROBACION_OPERACIONES AO  ON MO.NUMERO_OPERACION = AO.NUMEROOPERACION  
 WHERE MO.fecha_Vence_Flujo = G.fechaproc--MO.fechaliquidacion = G.fechaproc  
 --> 2022.04.14 INI cvegasan Pto 1 al parecer falta un filtro por la fecha ya que se repiten las fechas de inicio  
 AND ch.fecha_vence_flujo=G.fechaproc--AND ch.fechaliquidacion=G.fechaproc  
 --< 2022.04.14 INI cvegasanPto 1 al parecer falta un filtro por la fecha ya que se repiten las fechas de inicio  
 AND  (@cSistema = 'PCS' or @cSistema = '')  
 AND (mo.Rut_Contraparte   = @iRut   OR @iRut  = 0)  
 AND (mo.Codigo_Contraparte  = @iCodCli  OR @iCodCli  = 0)  
 AND (cl.cltipcli   = @iTipCli  OR @iTipCli  = 0)  
 --AND (mo.tipo_swap  = @cTipOper  OR @cTipOper = '')  
 AND (mo.numero_operacion = @iNumOper  OR @iNumOper = 0)  
 AND mo.numero_operacion NOT IN (SELECT numero_operacion FROM bacparamsuda..NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO)  
 AND mo.Producto <>3 --> Quedan afuera los FRA  
 and mo.Modalidad_Pago ='E'  
 AND MO.MontoM2  <> 0.0      
 GROUP BY   
  mo.numero_operacion  
  --,CH.compra_capital--,mo.compra_capital  
  --,CH.tipo_swap--mo.tipo_swap  
  --,CH.tipo_operacion--mo.tipo_operacion  
  ,CH.fecha_cierre--mo.fecha_cierre  
  ,mo.operador  
  --,emi.mncodmon  
  ,emi.mnnemo  
  ,pac.mnnemo  
  ,emi.mnglosa  
  ,pac.mnglosa  
  ,mo.Rut_Contraparte--mo.rut_cliente  
  ,cl.cldv  
  ,mo.FormaPago1--mo.recibimos_documento  
  ,mo.FormaPago2---mo.pagamos_documento  
  ,ini.glosa  
  ,ini.diasvalor  
  ,cl.clnombre  
  --,cl.clgeneric  
  ,ch.fecha_inicio--mo.fecha_inicio  
  --,ch.compra_valor_tasa--mo.compra_valor_tasa  
  --,mo.compra_moneda  
  --,ch.fecha_termino--mo.fecha_termino  
  ,mo.Codigo_Contraparte--mo.codigo_cliente  
  --,mo.Estado_oper_lineas  
  ,mo.tipo_flujo  
  --,mo.compra_moneda  
  --,mo.venta_moneda  
  ,tg.nemo  
  ,tg.tbglosa  
  ,mo.Correlativo  
  ,mo.MonedaM1  
  --,mo.MontoM2Local  
  --,ch.venta_capital  
  ,MontoM2  
  --,CH.venta_capital  
/**************************ENVIO A PAGO SWAP**********************************/  
-->2022.04.13 operaciones deben comenzar como Envio Pago automatico  
  UPDATE NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
  SET estado = 'EPA'  
  where envio='NO'  
  
  UPDATE NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO  
  SET estado = 'APA'  
  where envio='SI'  
--<2022.04.13  
  

 -- Salida de datos hacia la grilla  
 SELECT  
  oc.Envio     --1  
  ,oc.Sistema     --2  
  ,oc.Numero_operacion  --3  
  ,oc.Tipo_operacion   --4  
  ,oc.Glosa_Tipo_operacion --5  
  ,oc.Indicador    --6  
  --> 2022.04.18 INI Agregar campo "Tipo evento" pago/cobro  
  ,'Glosa_indicador'= CASE  
        WHEN oc.Indicador='P' THEN 'PAGO'  
        WHEN oc.Indicador='S' THEN 'COBRO'  
       END  
  --> 2022.04.18 FIN Agregar campo "Tipo evento" pago/cobro  
  ,oc.Fecha_operacion   --7  
  ,oc.Usuario     --8  
  ,oc.Moneda     --9  
  ,oc.Glosa_Moneda   --10  
  ,oc.Rut_cliente  
  ,oc.Dv_cliente  
  ,oc.Sucursal  
  ,oc.Monto_operacion  
  ,oc.Forma_pago  
  ,oc.Glosa_Forma_pago  
  ,oc.Codigo_valuta  
  ,oc.Nombre_cliente  
  ,oc.Banco      
  ,oc.CtaCteBenVendedor  --20  
  ,oc.Clave_abif  
  ,oc.Cta_comprador  
  ,oc.Codigo_dcv_comprador  
  ,oc.Cta_vendedor  
  ,oc.Codigo_dcv_vendedor  
  ,oc.Monto_original  
  ,oc.Fecha_inicio     
  ,oc.Tasa_interes     
  ,oc.Interes      
  ,oc.Monto_vencimiento  --30  
  ,Fecha_vencimiento= oc.fecha_proceso--oc.Fecha_vencimiento  --31  
  ,Fecha_liquidacion = Fecha_vencimiento  
  ,oc.Reajustabilidad    
  ,oc.Tasa_Pacto      
  ,oc.Monto_Final     
  ,oc.Monto_Nominal     
  ,oc.Tasa_descuento     
  ,oc.Valor_tasa      
  ,oc.Custodia      
  ,oc.Numero_instrumentos  --40  
  ,oc.Monto_total    --41  
  ,oc.Codigo_mon_mx     
  ,oc.Monto_mx      
  ,oc.Tasa_cambio     
  ,oc.Fecha_valor_mx   
  ,oc.Forma_pago_neg     
  ,oc.Sesion  
  ,oc.NombreClienteBen_3  
  ,oc.NombreClienteBen_4  
  ,oc.UsuarioMDP    --50  
  ,oc.UsuarioIngreso   --51  
  ,oc.CargoCtaCte  
  ,oc.SobregiroCtaCte  
  --> 2021.07.01 Campos nuevos en la definición del WS  
  ,oc.PvpReferencia  
  ,oc.PvpMoneda  
  ,oc.PvpTasaCambio  
  ,oc.PvpMonto  
  --< 2021.07.01 Campos nuevos en la definición del WS  
  ,oc.Cod_cliente     
  ,oc.Codigo_dcv2     
  ,oc.Estado     --60     
  ,ep.Tbglosa     --61  
  ,oc.fecha_proceso  
 FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO oc  
 INNER JOIN #tmp_ESTADOS_PAGO  ep ON oc.estado = ep.nemo--revison  
 INNER JOIN bacparamsuda..PRODUCTO pro on oc.Tipo_operacion=pro.codigo_producto  
 WHERE  
 (oc.Sistema    = @cSistema   or @cSistema='')  
 AND (oc.Tipo_operacion = @cCodigo_producto or @cCodigo_producto='')  
 AND (oc.rut_cliente  = @iRut    or @iRut=0)  
 and oc.envio= ( case when @tbcategoria=  9926 then  'NO'   
      when @tbcategoria = 9927 then  'SI'   
      end  
      )  
 --> 2022.04.14 INI Operaciones no deben aparecer  
 and oc.fecha_proceso = @mofecpro  
 --< 2022.04.14 FIN Operaciones no deben aparecer  
 ORDER BY oc.Sistema,oc.Numero_operacion, oc.Tipo_operacion  
  
  
 --select * from #tmp_ESTADOS_PAGO   
  
 SET NOCOUNT OFF  
END  
GO
