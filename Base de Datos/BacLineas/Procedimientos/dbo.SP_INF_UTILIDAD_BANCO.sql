USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_UTILIDAD_BANCO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_UTILIDAD_BANCO]
   (   @FechaD  CHAR(08)  
   ,   @Rut  NUMERIC(10) = 0  
   ,   @Cod      NUMERIC(01) = 0  
   ,   @Modulo   Char(03)    -- Valores Posibles 'PCS' - 'BFW'  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @iValorDO        FLOAT  
   DECLARE @dFechaProceso   DATETIME  
   DECLARE @iFound          INTEGER  
   DECLARE @iAsignado       NUMERIC(21,4)  
   ,       @iOcupado        NUMERIC(21,4)  
   ,       @iDisponible     NUMERIC(21,4)  
  
           
  -- 27 Oct. 2009 . Para evitar que Contratos de Opciones se dupliquen en Informe   
  CREATE TABLE #TEMP_LINEA_TRANSACCION_DETALLE_OPT  
   (   NumeroOperacion      NUMERIC(10,0)  NOT NULL  
   ,   Rut_Cliente          NUMERIC(10,0)  NOT NULL  
   ,   Codigo_Cliente       NUMERIC(09,0)  NOT NULL  
   ,   Id_Sistema           CHAR(03)       NOT NULL  
   ,   Codigo_Producto      CHAR(05)       NOT NULL  
   ,   Linea_Transsaccion   VARCHAR(06)    NOT NULL  
   ,   MontoTransaccion     NUMERIC(19,4)  NOT NULL  
   ,   moneda               NUMERIC(05)    NOT NULL  
   )  
  
   SELECT  @dFechaProceso   = CONVERT(DATETIME,@FechaD)  
  
  
  
   SELECT  @iValorDO        = vmvalor  
   FROM    BacParamSuda.dbo.VALOR_MONEDA  
   WHERE   vmfecha          = @dFechaProceso  
   AND     vmcodigo         = 994  
  
  
   if @Modulo = 'BFW' begin  
   SELECT @iFound           = -1  
   SELECT @iFound           = 0  
   FROM   BacLineas.dbo.LINEA_TRANSACCION l  
          INNER JOIN BacFwdSuda.dbo.MFCA c ON l.NumeroOperacion = c.canumoper AND l.Codigo_Producto = c.cacodpos1  
      WHERE  l.Id_Sistema       = @Modulo  
   AND    L.FechaVencimiento > @dFechaProceso  
   AND   (l.rut_cliente      = @Rut or @Rut = 0)  
   AND   (l.codigo_cliente   = @Cod or @Cod = 0)  
   end  
   else if @Modulo = 'PCS' begin  
      SELECT @iFound           = -1  
      SELECT @iFound           = 0  
      FROM   BacLineas.dbo.LINEA_TRANSACCION l  
             INNER JOIN BacSwapSuda.dbo.Cartera c ON l.NumeroOperacion = c.Numero_operacion AND l.Codigo_Producto = c.tipo_swap and c.estado_flujo = 1 and c.tipo_flujo = 1  
      WHERE  l.Id_Sistema       = @Modulo  
      AND    L.FechaVencimiento > @dFechaProceso  
      AND   (l.rut_cliente      = @Rut or @Rut = 0)  
      AND   (l.codigo_cliente   = @Cod or @Cod = 0)  
   end    
   else begin  
  
      SELECT @iFound           = -1  
      SELECT @iFound           = 0  
      FROM   BacLineas.dbo.LINEA_TRANSACCION l  
--             INNER JOIN LnkOpc.CbMdbOpc.dbo.MoEncContrato c ON l.NumeroOperacion = c.MoNumContrato  ---AND l.Codigo_Producto = c.tipo_swap and c.estado_flujo = 1 and c.tipo_flujo = 1  
--           MAP 02 Octubre se debe leer cartera no de movimientos.  
             INNER JOIN LnkOpc.CbMdbOpc.dbo.CaEncContrato c ON l.NumeroOperacion = c.CaNumContrato  ---AND l.Codigo_Producto = c.tipo_swap and c.estado_flujo = 1 and c.tipo_flujo = 1  
      WHERE  l.Id_Sistema       = @Modulo  
      AND    l.FechaVencimiento > @dFechaProceso  
      AND   (l.rut_cliente      = @Rut or @Rut = 0)  
      AND   (l.codigo_cliente   = @Cod or @Cod = 0)  
  
   end    
  
   -- 27 Oct. 2009 . Para evitar que Contratos de Opciones se dupliquen en Informe   
   IF @Modulo = 'OPT'   
   BEGIN  
        INSERT INTO #TEMP_LINEA_TRANSACCION_DETALLE_OPT  
 SELECT DISTINCT NumeroOperacion  
          ,Rut_Cliente  
         ,Codigo_Cliente   
         ,Id_Sistema  
         ,Codigo_Producto   
         ,Linea_Transsaccion   
         ,MontoTransaccion     
         ,moneda  
 FROM  LINEA_TRANSACCION_DETALLE  
 WHERE Id_Sistema = 'OPT'    
 AND  Linea_Transsaccion = 'LINGEN'  
   
   END  
  
   IF @iFound = 0  
   BEGIN  
  
      SELECT /* L.Id_Sistema   
      ,      */ UB_NOPERACION      = l.NumeroOperacion  
      ,      DESCRIPCION        = P.descripcion  
      ,      Rut                = CONVERT(CHAR(20),LTRIM(RTRIM(CONVERT(NUMERIC(9),S.Rut_Cliente))) + ' - ' + CONVERT(CHAR(1),U.cldv) + ' / ' + LTRIM(RTRIM(U.clcodigo)))  
      ,      Clnombre           = CONVERT(CHAR(25),U.clnombre)   
      ,      mnglosa         = CASE WHEN c.cacodmon2 = 0 THEN RTRIM(Y.mnnemo)  
                                ELSE CASE WHEN l.Codigo_Producto = 2 THEN RTRIM(T.mnnemo) + ' / ' + RTRIM(Y.mnnemo)  
                                                 ELSE                            RTRIM(Y.mnnemo) + ' / ' + RTRIM(T.mnnemo)  
                                            END  
                           END  
      ,      Clase              = CASE WHEN c.catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END  
      ,      UB_PLAZO_RESIDUAL  = c.caplazovto  
      ,      UB_PORUSAMATRIZ    = L.MatrizRiesgo  
      ,      UB_MONTOLPRODUCTO  = S.TotalAsignado   
      ,      UB_UTILIDAD        = ( case when cafecha = @dFechaProceso then 0 else  MontoTransaccion end ) -- MAP20070625, antes era :   
         /* CONVERT(NUMERIC(21,4),CASE WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'D' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) / @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'M' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) * @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda  = 999                    THEN ROUND(fres_obtenido,0)  
                                                             ELSE                                                               0.0   
                                                        END) */  
      ,      UB_MTOTOCUPADO     = Montotransaccion + MontoOriginal  -- MAP20070625   
                /* CONVERT(NUMERIC(21,4),(c.camtomon1 * (L.MatrizRiesgo/100.0)))  
                                + CONVERT(NUMERIC(21,4),CASE WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'D' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) / @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'M' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) * @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda  = 999                    THEN ROUND(fres_obtenido,0)  
                                                             ELSE                                                               0.0   
                                                        END) */  
      ,      UB_MTOTDISPO       =  S.TotalDisponible   
                                -  ( MontoOriginal + MontoTransaccion ) -- MAP20070625  
        /*Antes era: (l.MontoTransaccion + CONVERT(NUMERIC(21,4),CASE WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'D' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) / @iValorDO),0)  
                                                                                   WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'M' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) * @iValorDO),0)  
                                                                                   WHEN fres_obtenido > 0 AND S.moneda  = 999                    THEN ROUND(fres_obtenido,0)  
                                                                                   ELSE                                                               0.0   
                                                                               END)) */  
      ,      Fecha_Desde        = CONVERT(CHAR(10),@dFechaProceso,103)  
      ,      Fecha_Hoy          = CONVERT(CHAR(10),acfecproc,103)  
      ,      Nombre_Bco         = E.acnomprop  
      ,      Nombre_CL          = CONVERT(CHAR(25),U.clnombre)  
      ,      Rut_Sel            = @Rut  
      ,      Cod_Sel            = @Cod  
      ,      UB_MONTOOP         = c.camtomon1  
      ,      UB_MONTOOPDOLAR    = c.camtomon1  
      ,      UB_MONTO_OPMR      = montooriginal -- MAP20070625 antes era CONVERT(NUMERIC(21,4),(c.camtomon1 * (L.MatrizRiesgo/100.0)))  
      ,      pRut = @Rut       -- MAP 20090109 para utilizar el parametro en el reporte  
      ,      pCod = @Cod       -- MAP 20090109 para utilizar el parametro en el reporte  
      ,      pMod = @Modulo    -- MAP 20090109 para utilizar el parametro en el reporte  
      FROM   BacLineas.dbo.LINEA_TRANSACCION          L  
             INNER JOIN BacFwdSuda.dbo.MFCA           C ON L.NumeroOperacion = C.canumoper    AND L.Codigo_Producto = C.cacodpos1  
             LEFT  JOIN BacLineas.dbo.LINEA_SISTEMA   S ON S.Id_Sistema      = L.Id_Sistema   AND S.Rut_Cliente     = L.rut_cliente AND S.Codigo_Cliente = L.codigo_cliente  
             LEFT  JOIN BacParamSuda.dbo.MONEDA       M ON S.moneda          = M.mncodmon  
             LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA V ON v.vmfecha         = @dFechaProceso AND V.vmcodigo        = M.mncodmon  
             LEFT  JOIN BacParamSuda.dbo.PRODUCTO     P ON P.id_sistema      = L.Id_Sistema   AND P.codigo_producto = L.Codigo_Producto  
             LEFT  JOIN BacParamSuda.dbo.CLIENTE      U ON U.clrut           = L.rut_cliente  AND U.clcodigo        = L.codigo_cliente  
             LEFT  JOIN BacParamSuda.dbo.MONEDA       Y ON Y.mncodmon        = c.cacodmon1  
             LEFT  JOIN BacParamSuda.dbo.MONEDA       T ON T.mncodmon        = c.cacodmon2  
      ,      BacFwdSuda.dbo.MFAC                      E  
      WHERE  L.Id_Sistema        = 'BFW'  and @Modulo = 'BFW'  
      AND    L.FechaVencimiento  > E.acfecproc  
  
      AND   (l.rut_cliente       = @Rut or @Rut = 0)  
      AND   (l.codigo_cliente    = @Cod or @Cod = 0)  
      --ORDER BY l.NumeroOperacion  
      union  
      SELECT /*L.Id_Sistema  
      ,      */ UB_NOPERACION      = l.NumeroOperacion  
      ,      DESCRIPCION        = P.descripcion  
      ,    Rut                = CONVERT(CHAR(20),LTRIM(RTRIM(CONVERT(NUMERIC(9),S.Rut_Cliente))) + ' - ' + CONVERT(CHAR(1),U.cldv) + ' / ' + LTRIM(RTRIM(U.clcodigo)))  
      ,      Clnombre           = CONVERT(CHAR(25),U.clnombre)   
      ,      mnglosa            = RTRIM(T.mnnemo)   
      ,      Clase              = 'COMPRA'   
      ,      UB_PLAZO_RESIDUAL  = DATEDIFF(dd,@dFechaProceso,c.fecha_Termino)  
      ,      UB_PORUSAMATRIZ    = L.MatrizRiesgo  
      ,      UB_MONTOLPRODUCTO  = S.TotalAsignado   
      ,      UB_UTILIDAD        = ( case when fecha_Cierre = @dFechaProceso then 0 else  MontoTransaccion end ) -- MAP20070625, antes era :   
         /* CONVERT(NUMERIC(21,4),CASE WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'D' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) / @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'M' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) * @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda  = 999                    THEN ROUND(fres_obtenido,0)  
                                                             ELSE                                                               0.0   
                                                        END) */  
      ,      UB_MTOTOCUPADO     = Montotransaccion + MontoOriginal  -- MAP20070625   
                /* CONVERT(NUMERIC(21,4),(c.camtomon1 * (L.MatrizRiesgo/100.0)))  
                                + CONVERT(NUMERIC(21,4),CASE WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'D' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) / @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'M' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) * @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda  = 999                    THEN ROUND(fres_obtenido,0)  
                    ELSE                                                               0.0   
                                                        END) */  
      ,      UB_MTOTDISPO       =  S.TotalDisponible   
                                -  ( MontoOriginal + MontoTransaccion ) -- MAP20070625  
        /*Antes era: (l.MontoTransaccion + CONVERT(NUMERIC(21,4),CASE WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'D' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) / @iValorDO),0)  
                                                                                   WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'M' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) * @iValorDO),0)  
                                                                                   WHEN fres_obtenido > 0 AND S.moneda  = 999                    THEN ROUND(fres_obtenido,0)  
                                                                                   ELSE                                                               0.0   
                                                                               END)) */  
      ,      Fecha_Desde        = CONVERT(CHAR(10),@dFechaProceso,103)  
      ,      Fecha_Hoy          = CONVERT(CHAR(10),fechaproc,103)    
      ,      Nombre_Bco         = E.nombre  
      ,      Nombre_CL          = CONVERT(CHAR(25),U.clnombre)  
      ,      Rut_Sel            = @Rut  
      ,      Cod_Sel            = @Cod  
      ,      UB_MONTOOP         = c.Compra_saldo + c.Compra_amortiza   
      ,      UB_MONTOOPDOLAR    = ( c.Compra_saldo + c.Compra_amortiza ) * ( case when C.Compra_Moneda = 13 then 1   
                                                                              else  -- Conv a CLP y luego a USD  
                                            isnull( (select vmvalor from bacParamSuda.dbo.Valor_Moneda   
                                                                                              where vmfecha = @dFechaProceso            
                                                                                              and vmcodigo = Compra_moneda), 1 )  
                                                                             / isnull( (select vmvalor from bacParamSuda.dbo.Valor_Moneda   
                                                                                              where vmfecha = @dFechaProceso            
                                                                                              and vmcodigo = 994), 1 )  
                                                                              end )  
                                                                          
      ,      UB_MONTO_OPMR      = montooriginal -- MAP20070625 antes era CONVERT(NUMERIC(21,4),(c.camtomon1 * (L.MatrizRiesgo/100.0)))  
      ,      pRut = @Rut       -- MAP 20090109 para utilizar el parametro en el reporte  
      ,      pCod = @Cod       -- MAP 20090109 para utilizar el parametro en el reporte  
      ,      pMod = @Modulo    -- MAP 20090109 para utilizar el parametro en el reporte  
      FROM   BacLineas.dbo.LINEA_TRANSACCION          L  
             INNER JOIN BacSwapSuda.dbo.Cartera        C ON L.NumeroOperacion = C.numero_operacion   and Estado_flujo = 1 and tipo_flujo = 1 -- MAP no creo que sirva AND L.Codigo_Producto = C.cacodpos1  
             LEFT  JOIN BacLineas.dbo.LINEA_SISTEMA   S ON S.Id_Sistema      = L.Id_Sistema   AND S.Rut_Cliente     = L.rut_cliente AND S.Codigo_Cliente = L.codigo_cliente  
             LEFT  JOIN BacParamSuda.dbo.MONEDA       M ON S.moneda          = M.mncodmon  
             LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA V ON v.vmfecha         = @dFechaProceso AND V.vmcodigo        = M.mncodmon  
             LEFT  JOIN BacParamSuda.dbo.PRODUCTO     P ON P.id_sistema      = L.Id_Sistema   AND P.codigo_producto = ( case when L.Codigo_Producto = 1   
                                                              then 'ST'  
                                                                                                                          when L.Codigo_Producto = 2  
                                                                                                                      then 'SM'  
                                                                                                                          when L.Codigo_Producto = 3  
                                                                                                                      then 'FR'  
                                                                                                                          when L.Codigo_Producto = 4  
                                                                                                                      then 'SP' end )   
             LEFT  JOIN BacParamSuda.dbo.CLIENTE      U ON U.clrut           = L.rut_cliente  AND U.clcodigo        = L.codigo_cliente  
             LEFT  JOIN BacParamSuda.dbo.MONEDA       T ON T.mncodmon        = c.Compra_moneda  
      ,      BacSwapSuda.dbo.SwapGeneral              E  
      WHERE  L.Id_Sistema        = 'PCS' and @Modulo = 'PCS'  
      AND    L.FechaVencimiento  > @dFechaProceso -- E.acfecproc  
  
      AND   (l.rut_cliente       = @Rut or @Rut = 0)  
      AND   (l.codigo_cliente    = @Cod or @Cod = 0)  
--      ORDER BY l.NumeroOperacion  
      union  
      SELECT /* L.Id_Sistema   
      ,      */ UB_NOPERACION   = l.NumeroOperacion  
      ,      DESCRIPCION        = P.descripcion  
      ,      Rut                = CONVERT(CHAR(20),LTRIM(RTRIM(CONVERT(NUMERIC(9),S.Rut_Cliente))) + ' - ' + CONVERT(CHAR(1),U.cldv) + ' / ' + LTRIM(RTRIM(U.clcodigo)))  
      ,      Clnombre           = CONVERT(CHAR(25),U.clnombre)   
      ,      mnglosa            = CASE WHEN C.Moneda = 0 THEN RTRIM(Y.mnnemo)  
	                               ELSE CASE WHEN l.Codigo_Producto = '2' THEN RTRIM(T.mnnemo) + ' / ' + RTRIM(Y.mnnemo)
                                                 ELSE                            RTRIM(Y.mnnemo) + ' / ' + RTRIM(T.mnnemo)  
                                            END  
                           END  
  
      ,      Clase              = 'COMPRA'  --CASE WHEN c.catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END  
      ,      UB_PLAZO_RESIDUAL  = DATEDIFF(dd,@dFechaProceso,l.FechaVencimiento) --c.caplazovto  
      ,      UB_PORUSAMATRIZ    = L.MatrizRiesgo  
      ,      UB_MONTOLPRODUCTO  = S.TotalAsignado   
      ,      UB_UTILIDAD        = l.MontoTransaccion   -- ( case when l.FechaInicio = @dFechaProceso then 0 else  l.MontoTransaccion end ) -- MAP20070625, antes era :   
         /* CONVERT(NUMERIC(21,4),CASE WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'D' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) / @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda <> 999 and M.mnrrda = 'M' THEN ROUND(fres_obtenido / (CONVERT(NUMERIC(21,4),ISNULL(v.vmvalor,1.0)) * @iValorDO),0)  
                                                             WHEN fres_obtenido > 0 AND S.moneda  = 999                    THEN ROUND(fres_obtenido,0)  
                                                             ELSE                                                               0.0   
                                                        END) */  
      ,      UB_MTOTOCUPADO     = l.Montotransaccion + l.MontoOriginal  -- MAP20070625   
               
      ,      UB_MTOTDISPO       =  S.TotalDisponible   
                                -  ( l.MontoOriginal + l.MontoTransaccion ) -- MAP20070625  
         
      ,      Fecha_Desde        = CONVERT(CHAR(10),@dFechaProceso,103)  
      ,      Fecha_Hoy          = CONVERT(CHAR(10),fechaproc,103)  
      ,      Nombre_Bco         = E.nombre  
      ,      Nombre_CL          = CONVERT(CHAR(25),U.clnombre)  
      ,      Rut_Sel            = @Rut  
      ,      Cod_Sel            = @Cod  
      ,      UB_MONTOOP         = C.MontoTransaccion -- c.camtomon1  
      ,      UB_MONTOOPDOLAR    = C.MontoTransaccion -- c.camtomon1  
      ,      UB_MONTO_OPMR      = l.MontoOriginal -- MAP20070625 antes era CONVERT(NUMERIC(21,4),(c.camtomon1 * (L.MatrizRiesgo/100.0)))  
      ,      pRut = @Rut       -- MAP 20090109 para utilizar el parametro en el reporte  
      ,      pCod = @Cod       -- MAP 20090109 para utilizar el parametro en el reporte  
      ,      pMod = @Modulo    -- MAP 20090109 para utilizar el parametro en el reporte  
      FROM   BacLineas.dbo.LINEA_TRANSACCION          L  
             INNER JOIN #TEMP_LINEA_TRANSACCION_DETALLE_OPT    C ON L.NumeroOperacion = C.NumeroOperacion -- 27 Oct. 2009   
             LEFT  JOIN BacLineas.dbo.LINEA_SISTEMA   S ON S.Id_Sistema      = L.Id_Sistema   AND S.Rut_Cliente     = L.rut_cliente AND S.Codigo_Cliente = L.codigo_cliente  
             LEFT  JOIN BacParamSuda.dbo.MONEDA       M ON S.moneda          = M.mncodmon  
      LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA V ON v.vmfecha         = @dFechaProceso AND V.vmcodigo        = M.mncodmon  
   LEFT  JOIN BacParamSuda.dbo.PRODUCTO     P ON P.id_sistema      = L.Id_Sistema   AND P.codigo_producto = L.Codigo_Producto  
             LEFT  JOIN BacParamSuda.dbo.CLIENTE      U ON U.clrut           = L.rut_cliente  AND U.clcodigo        = L.codigo_cliente  
             LEFT  JOIN BacParamSuda.dbo.MONEDA       Y ON Y.mncodmon        = C.Moneda    
             LEFT  JOIN BacParamSuda.dbo.MONEDA       T ON T.mncodmon        = C.Moneda   
      ,      LnkOpc.CbMdbOpc.dbo.OpcionesGeneral   E  
      WHERE  L.Id_Sistema        = 'OPT'  and @Modulo = 'OPT'  
      AND    L.FechaVencimiento  > E.fechaproc  
      AND    L.FechaInicio       = E.fechaproc  
      AND   (l.rut_cliente       = @Rut or @Rut = 0)  
      AND   (l.codigo_cliente    = @Cod or @Cod = 0)  
  
  
  
   END ELSE  
   BEGIN  
  
--select 'debug'   
      -- Si no hay atransacciones muestra lo utilizando por LCR  
      SELECT  @iAsignado       = 0.0  
      ,       @iOcupado        = 0.0  
      ,       @iDisponible     = 0.0  
  
      SELECT  @iAsignado       = sum( TotalAsignado )  
      ,       @iOcupado        = sum( TotalOcupado )  
      ,       @iDisponible     = sum( TotalDisponible )  
      FROM    BacLineas.dbo.LINEA_SISTEMA  
      WHERE   Id_Sistema       = @Modulo   
      AND    (rut_cliente      = @Rut or @Rut = 0)  
      AND    (codigo_cliente   = @Cod or @Cod = 0)  
  
      SELECT UB_NOPERACION      = 0  
      ,      DESCRIPCION        = ''  
      ,      Rut                = CONVERT(CHAR(20),LTRIM(RTRIM(CONVERT(NUMERIC(9),U.Clrut))) + ' - ' + CONVERT(CHAR(1),U.cldv) + ' / ' + LTRIM(RTRIM(U.clcodigo)))  
      ,      Clnombre           = CONVERT(CHAR(25),U.clnombre)   
      ,      mnglosa            = ''  
      ,      Clase              = ''  
      ,      UB_PLAZO_RESIDUAL  = 0  
      ,      UB_PORUSAMATRIZ    = 0.0  
      ,      UB_MONTOLPRODUCTO  = @iAsignado  
      ,      UB_UTILIDAD        = 0.0  
      ,      UB_MTOTOCUPADO     = @iOcupado  
      ,      UB_MTOTDISPO       = @iDisponible  
      ,      Fecha_Desde        = CONVERT(CHAR(10),@dFechaProceso,103)  
      ,      Fecha_Hoy          = CONVERT(CHAR(10),acfecproc,103)  
      ,      Nombre_Bco         = E.acnomprop  
      ,      Nombre_CL          = CONVERT(CHAR(25),U.clnombre)  
      ,      Rut_Sel            = @Rut  
      ,      Cod_Sel            = @Cod  
      ,      UB_MONTOOP         = 0.0  
      ,      UB_MONTOOPDOLAR    = 0.0  
      ,      UB_MONTO_OPMR      = 0.0  
      ,      pRut = @Rut       -- MAP 20090109 para utilizar el parametro en el reporte  
      ,      pCod = @Cod       -- MAP 20090109 para utilizar el parametro en el reporte  
      ,      pMod = @Modulo    -- MAP 20090109 para utilizar el parametro en el reporte  
      FROM   BacParamSuda.dbo.CLIENTE U  
      ,      BacFwdSuda.dbo.MFAC      E  
      WHERE (U.clrut        = @Rut or @Rut = 0)  
      AND   (U.clcodigo         = @Cod or @Cod = 0)  
   END  
  
  
END
GO
