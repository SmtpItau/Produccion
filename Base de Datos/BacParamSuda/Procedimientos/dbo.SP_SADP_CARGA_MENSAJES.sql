USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CARGA_MENSAJES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_CARGA_MENSAJES]  
   (   @par_sistema         CHAR(04)     = ''  
   ,   @par_tp_operacion    CHAR(05)     = ''  
   ,   @par_nr_operacion    NUMERIC(9,0) = 0  
   ,   @iMoneda             INT    = 0  
   ,   @iEstado             CHAR(1)      = 'P'  
   ,   @iMedioPago   INT    = 0  
   ,   @sUser    VARCHAR(15)  = '' -->Para cargar Transacciones de GPI y FFMM   
   )  
AS   
BEGIN  
  
    SET NOCOUNT ON  
  
 SET @par_sistema = LTRIM(RTRIM( @par_sistema ))  
 SET @par_tp_operacion = LTRIM(RTRIM( @par_tp_operacion ))   
  
    DECLARE @fc_proceso  DATETIME  
    DECLARE @fc_procant  DATETIME   
  
    SELECT @fc_proceso  = dFechaProceso  
    ,      @fc_procant  = dFechaAnterior  
    FROM   BacParamSuda.dbo.SADP_Control with(nolock)   
  
    
      
    IF LTRIM(RTRIM(@par_sistema))='GPI' OR LTRIM(RTRIM(@par_sistema))='FFMM'    
  EXECUTE dbo.SP_SADP_CARGA_DATOS_FILIALES  @fc_proceso,@sUser      
  
   
 EXECUTE SP_BTR_CARGA_TABLA_MDLBTR  
  
  
  
 -->  Lee las operaciones desde BAC Agrupados  
    SELECT sistema    = md.sistema  
    ,  tipo_mercado  = md.tipo_mercado  
    ,  tipo_operacion  = md.tipo_operacion  
    ,  estado_envio  = md.estado_envio  
    ,  numero_operacion = MIN( md.numero_operacion )  
    ,  rut_cliente   = md.rut_cliente  
    ,  codigo_cliente  = md.codigo_cliente  
    ,  moneda    = md.moneda  
    ,  monto_operacion  = SUM( md.monto_operacion )  
    ,  forma_pago   = md.forma_pago  
    ,  fecha_operacion  = md.fecha_operacion  
    ,  fecha_vencimiento = md.fecha_vencimiento  
    ,  liquidada   = md.liquidada  
    ,  RecRutBanco   = md.RecRutBanco  
    ,  RecCodBanco   = md.RecCodBanco  
    ,  RecCodSwift   = md.RecCodSwift  
    ,  RecDireccion  = md.RecDireccion  
    ,  RecCtaCte   = md.RecCtaCte  
    ,  Tipo_Movimiento  = md.Tipo_Movimiento  
    ,  GlosaAnticipo  = md.GlosaAnticipo  
    ,  Id_Paquete   = md.Id_Paquete  
    ,  Estado_Paquete  = md.Estado_Paquete  
    ,  Reservado   = md.Reservado  
    ,  MontoCtaCte   = CONVERT(NUMERIC(21,4), 0.0)  
    ,  MontoValVta   = CONVERT(NUMERIC(21,4), 0.0)  
    ,  MontoOtrFpa   = CONVERT(NUMERIC(21,4), 0.0)  
      
    INTO #TMP_LBTR_GRUPO  
    FROM MDLBTR    md  with(nolock)  
    WHERE (md.fecha    = @fc_proceso)  
    AND  (md.Tipo_Movimiento  = 'C'   )  
    AND  (md.Reservado   = ''   )  
    AND  (md.Estado_Paquete  = 'A'   )  
    AND  (md.Id_Paquete   > 0    )  
    AND  (md.sistema       NOT IN( 'GPI', 'CDB', 'FFMM' ))  
    AND  (md.sistema    = @par_sistema   OR @par_sistema      = '')  
    AND  (md.tipo_mercado  = @par_tp_operacion OR @par_tp_operacion = '')  
    AND  (md.numero_operacion = @par_nr_operacion OR @par_nr_operacion = 0 )  
    AND  (md.moneda    = @iMoneda    OR @iMoneda          = 0)  
    AND  (md.estado_envio  = @iEstado    OR @iEstado          = '')  
    --AND  (md.forma_pago   = @iMedioPago   OR @iMedioPago   = 0)  
    AND  (md.forma_pago   = @iMedioPago   OR @iMedioPago   = -1)  
      
    GROUP BY sistema  
   ,   tipo_mercado  
   ,   tipo_operacion  
   ,   estado_envio  
   ,   rut_cliente  
   ,   codigo_cliente  
   ,   moneda  
   ,   forma_pago  
   ,   fecha_operacion  
   ,   fecha_vencimiento  
   ,   liquidada  
   ,   RecRutBanco  
   ,   RecCodBanco  
   ,   RecCodSwift  
   ,   RecDireccion  
   ,   RecCtaCte  
   ,   Tipo_Movimiento  
   ,   GlosaAnticipo  
   ,   Id_Paquete  
   ,   Estado_Paquete  
   ,   Reservado  
  
  
 -->  Lee las operaciones desde BAC Simples  
   SELECT  Estado    = ee.sDescripcion  
   ,    Operacion   = CASE WHEN md.liquidada ='*' THEN pr.descripcion + '  * PM * ' ELSE pr.descripcion END  
   ,    numero_operacion  = CONVERT(NUMERIC(10), md.numero_operacion)  
   ,    Clnombre    = cl.Clnombre  
   ,    mnnemo    = mn.mnnemo  
   ,    monto_operacion  = md.monto_operacion  
   ,    glosa    = fp.glosa  
   ,    perfil    = fp.perfil  
   ,    forma_pago   = md.forma_pago  
   ,    sistema    = md.sistema  
   ,    fecha_operacion  = md.fecha_operacion  
   ,    fecha_vencimiento = md.fecha_vencimiento  
   ,    liquidada   = md.liquidada  
  ,    cltipcli    = cl.cltipcli  
   ,    GlosaAnticipo  = md.GlosaAnticipo  
,    Estado_Paquete  = md.Estado_Paquete  
   ,    IdPaquete   = md.Id_Paquete  
   ,    MontoCtaCte   = CONVERT(NUMERIC(21,4), 0.0)  
   ,    MontoValVta   = CONVERT(NUMERIC(21,4), 0.0)  
   ,    MontoOtrFpa   = CONVERT(NUMERIC(21,4), 0.0)  
   ,    md.Secuencia          
   INTO    #TMP_RETORNO  
   FROM    MDLBTR      md with(nolock)  
     LEFT JOIN SADP_EstadosEnvio ee with(nolock) ON ee.sCodigo  = md.estado_envio  
     LEFT JOIN CLIENTE   cl with(nolock) ON cl.clrut   = md.rut_cliente AND cl.clcodigo = md.codigo_cliente  
     LEFT JOIN PRODUCTO   pr with(nolock) ON pr.id_sistema = md.sistema AND pr.codigo_producto = md.tipo_mercado  
     LEFT JOIN MONEDA    mn with(nolock) ON mn.mncodmon  = md.moneda  
     LEFT JOIN FORMA_DE_PAGO  fp with(nolock) ON fp.codigo  = md.forma_pago   
   WHERE  (md.fecha    = @fc_proceso)  
   AND   (md.Tipo_Movimiento = 'C')  
   AND   (md.Reservado   = '')  
   AND   (md.Estado_Paquete = 'D')  
   AND   (md.Id_Paquete  = 0)  
   AND   (md.sistema   NOT IN( 'GPI', 'CDB', 'FFMM' ))  
   AND   (md.sistema   = @par_sistema  OR @par_sistema      = '')  
   AND   (md.tipo_mercado  = @par_tp_operacion OR @par_tp_operacion = '')  
   AND   (md.numero_operacion = @par_nr_operacion     OR @par_nr_operacion = 0 )  
   AND   (md.moneda   = @iMoneda              OR @iMoneda          = 0)  
   AND   (md.estado_envio  = @iEstado              OR @iEstado          = '')  
   --AND   (md.forma_pago  = @iMedioPago   OR @iMedioPago   = 0)   
   AND   (md.forma_pago  = @iMedioPago   OR @iMedioPago   = -1)   
   ORDER BY md.sistema, md.numero_operacion   
  
  
   INSERT INTO #TMP_RETORNO  
   SELECT  Estado  = ee.sDescripcion     
   ,    Operacion  = CASE WHEN md.liquidada = '*' THEN pr.descripcion + '  * PM * ' ELSE pr.descripcion END  
   ,    numero_operacion = CONVERT(NUMERIC(10), md.numero_operacion)  
   ,    Clnombre  = cl.Clnombre  
   ,    mnnemo  = mn.mnnemo  
   ,    monto_operacion = md.monto_operacion  
   ,    glosa  = fp.glosa  
   ,    perfil  = fp.perfil  
   ,    forma_pago  = md.forma_pago  
   ,    sistema  = md.sistema  
   ,    fecha_operacion = @fc_proceso  
   ,    fecha_vencimiento = md.fecha_vencimiento  
   ,    liquidada  = md.liquidada  
   ,    cltipcli  = cl.cltipcli  
   ,    GlosaAnticipo = md.GlosaAnticipo     
   ,    Estado_Paquete = md.Estado_Paquete  
   ,    IdPaquete  = md.Id_Paquete  
   ,    MontoCtaCte  = CONVERT(NUMERIC(21,4), 0.0)  
   ,    MontoValVta  = CONVERT(NUMERIC(21,4), 0.0)  
   ,    MontoOtrFpa  = CONVERT(NUMERIC(21,4), 0.0)  
   ,    1  
   FROM    #TMP_LBTR_GRUPO    md  
        LEFT JOIN SADP_EstadosEnvio ee with(nolock) ON ee.sCodigo  = md.estado_envio  
        LEFT JOIN CLIENTE   cl with(nolock) ON cl.clrut   = md.rut_cliente AND cl.clcodigo = md.codigo_cliente  
        LEFT JOIN MONEDA    mn with(nolock) ON mn.mncodmon  = md.moneda   
        LEFT JOIN FORMA_DE_PAGO  fp with(nolock) ON fp.codigo  = md.forma_pago   
        LEFT JOIN PRODUCTO   pr with(nolock) ON pr.id_sistema = md.sistema AND pr.codigo_producto = md.tipo_mercado  
   ORDER BY md.sistema , md.numero_operacion  
  
 -->    lee operaciones desde los modulos externos  
 INSERT INTO #TMP_RETORNO  
 SELECT Estado   = ee.sDescripcion  
  , Operacion   = pe.Producto  
  , numero_operacion = md.numero_operacion  
  , Clnombre   = isnull( dbo.FXCLIENTE( md.rut_cliente, md.codigo_cliente, md.sistema ), '')  
  , mnnemo    = mn.mnnemo  
  , monto_operacion  = md.monto_operacion  
  , glosa    = CASE WHEN grup.oPag > 1 THEN 'MULTIPLES PAGOS' ELSE fp.glosa END  
  , perfil    = CASE WHEN grup.oPag > 1 THEN ' ' ELSE fp.perfil END  
  , forma_pago   = md.forma_pago  
  , sistema    = md.sistema  
  , fecha_operacion  = md.fecha_operacion  
  , fecha_vencimiento = md.fecha_vencimiento  
  , liquidada   = md.liquidada  
  , cltipcli   = 0  
  , GlosaAnticipo  = md.GlosaAnticipo  
  , Estado_Paquete  = md.Estado_Paquete  
  , IdPaquete   = md.Id_Paquete  
  , MontoCtaCte   = CONVERT(NUMERIC(21,4), 0.0)  
  , MontoValVta   = CONVERT(NUMERIC(21,4), 0.0)  
  , MontoOtrFpa   = CONVERT(NUMERIC(21,4), 0.0)  
  , Secuencia   = md.secuencia  
  FROM MDLBTR          md  
   INNER JOIN SADP_EstadosEnvio    ee with(nolock) ON ee.sCodigo = CASE WHEN md.estado_envio = '-'  THEN 'PF1' ELSE md.estado_envio END   
   LEFT  JOIN SADP_PRODUCTO_MODULOEXTERNO  pe with(nolock) ON pe.Modulo = md.sistema AND pe.Codigo = md.tipo_mercado  
   LEFT  JOIN BacParamSuda.dbo.MONEDA   mn with(nolock) ON mn.mncodmon = md.moneda  
   LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp with(nolock) ON fp.codigo = md.forma_pago  
   LEFT  JOIN ( SELECT oMod       = cmodulo  
                             ,  oCon       = ncontrato  
                             , iSec    = iSecuencia  
                             ,  oPag       = COUNT(1)   
         FROM BacParamSuda.dbo.SADP_DETALLE_PAGOS c  
                 WHERE c.cEstado<>'APM'     
      GROUP BY cmodulo ,  ncontrato, iSecuencia  
      )             grup ON grup.oMod = md.sistema AND grup.oCon = md.numero_operacion AND grup.iSec=md.secuencia   
 WHERE md.fecha   = @fc_proceso  
 AND  md.tipo_movimiento = 'C'  
 AND  md.Reservado  = ''  
 AND  md.Estado_Paquete = 'D'  
 AND  md.Id_Paquete  = 0  
 AND  md.sistema   IN('GPI','CDB','FFMM')  
 AND    (md.sistema   = @par_sistema   OR @par_sistema   = '')  
 AND    (md.tipo_mercado  = @par_tp_operacion  OR @par_tp_operacion = '')  
 AND    (md.numero_operacion = @par_nr_operacion     OR @par_nr_operacion = 0 )  
 AND    (md.moneda   = @iMoneda              OR @iMoneda    = 0)  
 AND    (md.estado_envio  = @iEstado              OR @iEstado    = '')  
 AND    (md.forma_pago  = @iMedioPago   OR @iMedioPago   = -1)  
 ORDER BY md.sistema, md.numero_operacion  
  
 SELECT cOrigen  = dp.cModulo  
  , nOperacion = dp.nContrato   
  , iSecuencia = dp.isecuencia   
  , iFPago  = CASE WHEN dp.iFormaPago = 103 OR dp.iFormaPago = 105 THEN 1  
                               WHEN dp.iFormaPago = 5                          THEN 2  
                               ELSE                                                 3  
                          END  
  , nMonto  = SUM( dp.nMonto )  
 INTO #TMP_MONTOS  
 FROM BacParamSuda.dbo.SADP_DETALLE_PAGOS dp  
   INNER JOIN #TMP_RETORNO      re ON re.sistema = dp.cModulo AND re.numero_operacion = dp.nContrato AND re.secuencia=dp.isecuencia  
 WHERE dp.cModulo IN('GPI','CDB','FFMM')  
 AND  dp.cEstado NOT IN('APM')  
 GROUP BY dp.cModulo, dp.nContrato, dp.iSecuencia, CASE WHEN dp.iFormaPago = 103 OR dp.iFormaPago = 105 THEN 1  
                                            WHEN dp.iFormaPago = 5                          THEN 2  
                                            ELSE                                                 3  
                                       END  
  
 UPDATE #TMP_RETORNO  
 SET  MontoCtaCte      = nMonto  
 ,  MontoValVta      = 0.0  
 ,  MontoOtrFpa      = 0.0  
    FROM    #TMP_MONTOS  
    WHERE   #TMP_RETORNO.sistema   = #TMP_MONTOS.cOrigen  
    AND     #TMP_RETORNO.numero_operacion = #TMP_MONTOS.nOperacion  
    AND     #TMP_RETORNO.secuencia = #TMP_MONTOS.isecuencia  
    AND     #TMP_MONTOS.iFPago    = 1  
  
    UPDATE #TMP_RETORNO  
 SET  MontoValVta      = nMonto  
    FROM    #TMP_MONTOS  
    WHERE   #TMP_RETORNO.sistema   = #TMP_MONTOS.cOrigen  
    AND     #TMP_RETORNO.numero_operacion = #TMP_MONTOS.nOperacion  
 AND     #TMP_RETORNO.secuencia = #TMP_MONTOS.isecuencia      
    AND     #TMP_MONTOS.iFPago    = 2  
  
    UPDATE #TMP_RETORNO  
 SET  MontoOtrFpa      = nMonto  
    FROM    #TMP_MONTOS  
    WHERE   #TMP_RETORNO.sistema   = #TMP_MONTOS.cOrigen  
    AND     #TMP_RETORNO.numero_operacion = #TMP_MONTOS.nOperacion  
 AND     #TMP_RETORNO.secuencia = #TMP_MONTOS.isecuencia      
    AND     #TMP_MONTOS.iFPago    = 3  
  
 SELECT Estado  
  , Operacion  
  , numero_operacion  
  , Clnombre  
  , mnnemo  
  , monto_operacion  
  , glosa  
  , perfil  
  , forma_pago  
  , sistema  
  , fecha_operacion  
  , fecha_vencimiento  
  , liquidada  
  , cltipcli  
  , GlosaAnticipo  
  , Estado_Paquete  
  , IdPaquete  
  , dbo.fxReferencia(sistema,numero_operacion)  
  , MontoCtaCte  
  , MontoValVta  
  , MontoOtrFpa  
  , Secuencia   
 FROM #TMP_RETORNO  
ORDER BY Estado_Paquete  
  , Estado  
  , IdPaquete DESC  
  , sistema  
  , Operacion  
  , Clnombre  
  , mnnemo  
  , perfil  
  , numero_operacion  
  
END  
GO
