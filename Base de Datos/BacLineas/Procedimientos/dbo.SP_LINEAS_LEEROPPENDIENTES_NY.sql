USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_LEEROPPENDIENTES_NY]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 --INSERT #TEMP EXECUTE Sp_Lineas_LeerOpPendientes  @cFecha ,@Usuario      

 --sp_helptext Sp_Lineas_LeerOpPendientes '20140408', 'ADMINISTRA'
  --sp_helptext Sp_Lineas_LeerOpPendientes_NY '20140408', 'rfuentes'

  --SELECT * FROM BacBonosExtNY.dbo.TEXT_MVT_DRI


  
CREATE PROCEDURE [dbo].[SP_LINEAS_LEEROPPENDIENTES_NY]  
   (   @cFecha  DATETIME  
   , @Usuario CHAR(15)  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @cFecha_BTR DATETIME  
   DECLARE @cFecha_BFW DATETIME  
   DECLARE @cFecha_BCC DATETIME  
   DECLARE @cFecha_BSW DATETIME  
   DECLARE @cFecha_BEX DATETIME  
     
    SELECT @cFecha_BTR = acfecproc FROM VIEW_MDAC             with (nolock)  
    SELECT @cFecha_BFW = acfecproc FROM VIEW_MFAC             with (nolock)  
    SELECT @cFecha_BCC = acfecpro  FROM VIEW_MEAC             with (nolock)  
    SELECT @cFecha_BSW = fechaproc FROM VIEW_SWAPGENERAL      with (nolock)  
    SELECT @cFecha_BEX = acfecproc FROM VIEW_TEXT_ARC_CTL_DRI with (nolock)  
     
   CREATE TABLE #TEMP1  
   (   Sistema  CHAR(05) ,  
       Cod_Producto CHAR(05) ,  
       Glo_Producto CHAR(40) ,  
       numoper  NUMERIC(10) ,  
       rutcli  NUMERIC(09) ,  
       codcli  NUMERIC(09) ,  
       cliente  CHAR(50) ,  
       moneda  CHAR(05) ,  
       Monto  NUMERIC(19,4) ,  
       Operador         CHAR(15) ,  
       ErrorG  CHAR(2)  ,  
       Pendiente CHAR(1)  ,  
       TipoOpera CHAR(1)    
   )  
  
/*

  --select * from LIMITE_TRANSACCION where NumeroOperacion = 3425
select A.Id_Sistema,A.NumeroOperacion,A.MontoTransaccion,A.Operador from LIMITE_TRANSACCION A 
where a.id_Sistema = 'BEX' AND a.FechaOperacion = '20140408' GROUP BY A.Id_Sistema ,  
     A.NumeroOperacion ,  
            A.MontoTransaccion ,  
            A.Operador 

			select * from LINEA_TRANSACCION_DETALLE where Id_Sistema  = 'BEX'

		
			*/

   INSERT INTO #TEMP1  
   SELECT A.Id_Sistema      ,  
          ' '      ,  
          ''      ,  
          A.NumeroOperacion ,  
          0      ,  
          0      ,  
          ''      ,  
          -- MAP 21 Septiembre  
          CASE WHEN A.Id_Sistema = 'BTR' OR A.Id_Sistema = 'BEX' OR A.Id_Sistema = 'OPT' THEN '$' ELSE 'USD' END,  
          A.MontoTransaccion,  
          A.Operador     ,  
          'NO'      ,  
          'N'               ,  
   ' '      /* ===> Campo agregado solo para migración a SQL Server 2005, pues no permite la ejecución al faltar el campo. JBH   */  
   FROM  LIMITE_TRANSACCION A with (nolock)  
   WHERE A.FechaOperacion   = @cFecha  
   GROUP BY A.Id_Sistema ,  
     A.NumeroOperacion ,  
            A.MontoTransaccion ,  
            A.Operador   
  
   INSERT INTO #TEMP1  
   SELECT A.Id_Sistema  ,  
          ' '   ,  
          ''   ,  
          A.NumeroOperacion ,  
          0   ,  
          0   ,  
          ''   ,  
          -- MAP 21 Septiembre  
          CASE WHEN A.Id_Sistema = 'BTR' or A.Id_Sistema = 'BEX' or  A.Id_Sistema = 'OPT' THEN '$' ELSE 'USD' END,  
          A.MontoTransaccion ,  
          A.Operador  ,  
          'NO'   ,  
          'N'   
   ,' '      /* ===> Campo agregado solo para migración a SQL Server 2005, pues no permite la ejecución al faltar el campo. JBH   */  
   FROM   LINEA_TRANSACCION      A with (nolock),  
          LINEA_TRANSACCION_DETALLE B with (nolock)  
   WHERE  A.NumeroOperacion = B.NumeroOperacion  
   AND    A.NumeroDocumento = B.NumeroDocumento  
   AND    A.NumeroCorrelativo = B.NumeroCorrelativo  
   AND    A.Id_Sistema  = B.Id_Sistema  
   AND  ((A.Id_Sistema          = 'BTR' AND FechaInicio = @cFecha_BTR )  OR  
         (A.Id_Sistema          = 'BFW' AND FechaInicio = @cFecha_BFW )  OR  
         (A.Id_Sistema          = 'PCS' AND FechaInicio = @cFecha_BSW )  OR  
         (A.Id_Sistema          = 'BCC' AND FechaInicio = @cFecha_BCC )  OR  
         (A.Id_Sistema          = 'OPT' AND FechaInicio = @cFecha ))    
   AND    A.NumeroOperacion     NOT IN(SELECT numoper FROM #TEMP1 WHERE numoper = A.NumeroOperacion AND Sistema = A.Id_Sistema)  
   GROUP BY A.Id_Sistema ,  
            A.NumeroOperacion ,  
            A.Operador  ,  
            A.MontoOriginal ,    
            A.FechaVencimiento ,  
            A.FechaInicio ,  
            A.MontoTransaccion  
  
  
   /******* DATOS BONOS **********/  
   INSERT INTO #TEMP1  
   SELECT A.Id_Sistema  ,  
          ' '   ,  
          ''   ,  
          A.NumeroOperacion ,  
          0   ,  
          0   ,  
          ''   ,  
          '$'   ,  
          A.MontoTransaccion ,  
          A.Operador  ,  
          'NO'   ,  
     'N'     
   ,' '      /* ===> Campo agregado solo para migración a SQL Server 2005, pues no permite la ejecución al faltar el campo. JBH   */   
   FROM   LINEA_TRANSACCION  A with (nolock),  
          LINEA_TRANSACCION_DETALLE B with (nolock)  
   WHERE  A.NumeroOperacion = B.NumeroOperacion  
   AND   A.NumeroDocumento = B.NumeroDocumento  
   AND   A.NumeroCorrelativo = B.NumeroCorrelativo  
   AND   A.Rut_cliente  = B.Rut_cliente   
   AND   A.Codigo_cliente = B.Codigo_cliente  
   AND   A.Id_Sistema  = B.Id_Sistema  
   AND  (A.Id_Sistema          = 'BEX' AND FechaInicio = @cFecha_BEX )     
   AND   A.NumeroOperacion     NOT IN(SELECT numoper FROM #TEMP1 WHERE numoper = A.NumeroOperacion AND Sistema = A.Id_Sistema)  
   GROUP BY A.Id_Sistema ,  
     A.NumeroOperacion ,  
     A.Operador  ,  
     A.MontoOriginal ,    
            A.FechaVencimiento ,  
     A.FechaInicio ,  
     A.MontoTransaccion  
  
  
   UPDATE #TEMP1  
      SET Cod_Producto = CASE WHEN Id_Sistema = 'BEX' THEN CASE WHEN Codigo_Producto = 'VP' THEN 'VPX'  
               WHEN Codigo_Producto = 'CP' THEN 'CPX'  
               ELSE Codigo_Producto   
                 END  
                              ELSE                         Codigo_Producto   
                         END  
     FROM LINEA_TRANSACCION  
    WHERE numoper = numerooperacion  
    /* MAP 21 Septiembre */   
    AND   id_sistema = Sistema  
  
  
   UPDATE #TEMP1  
      SET errorG    = 'NO'  
     FROM LINEA_TRANSACCION_DETALLE with (nolock)  
    WHERE numoper   = NumeroOperacion  
      AND Sistema   = Id_Sistema  
      AND Error     = 'S'  
  
   UPDATE #TEMP1   
      SET Glo_Producto  = descripcion  
     FROM VIEW_PRODUCTO with (nolock)  
    WHERE id_sistema  = Sistema  
      AND Cod_Producto  = codigo_producto  
      AND Glo_Producto  = ''  
  
   ------------------------ BTR --------------------------------  
 --UPDATE #TEMP1  
 --SET rutcli = morutcli,  
 -- codcli = mocodcli  
 --FROM VIEW_MDMO   with(nolock)  
 --WHERE numoper = monumoper  
 --AND Sistema = 'BTR'  

 
 --UPDATE #TEMP1  
 --SET pendiente = 'S'  
 --FROM VIEW_MDMO with(nolock)  
 --WHERE Sistema   = 'BTR'  
 --AND monumoper = numoper  
 --AND mostatreg = 'P'  
  
 --UPDATE #TEMP1  
 --SET pendiente = 'N'  
 --FROM VIEW_MDMO with(nolock)  
 --WHERE Sistema = 'BTR'  
 --AND monumoper = numoper  
 --AND mostatreg = 'R'  
  
 --UPDATE #TEMP1  
 --SET monto     = CASE WHEN motipoper = 'CI' OR motipoper = 'VI' THEN (SELECT SUM(movalinip) FROM VIEW_MDMO with (nolock) WHERE monumoper = numoper group by monumoper )  
 --           ELSE CASE WHEN momonemi = 999 THEN (SELECT SUM(movpresen) FROM VIEW_MDMO with (nolock) WHERE monumoper = numoper group by monumoper)  
 --                     ELSE                     (SELECT SUM(monominal) FROM VIEW_MDMO with (nolock) WHERE monumoper = numoper group by monumoper)  
 --                                     END  
 --                           END  
 --       ,    moneda    = CASE WHEN motipoper = 'CI' OR motipoper = 'VI' THEN (SELECT mnnemo FROM VIEW_MONEDA with (nolock) WHERE mncodmon = momonpact)  
 --           ELSE                                           (SELECT mnnemo FROM VIEW_MONEDA with (nolock) WHERE mncodmon = momonemi)  
 --END 
 --FROM VIEW_MDMO   with (nolock)   
 --WHERE Sistema   = 'BTR'  
 --AND monumoper = numoper  
  
 --       IF EXISTS(SELECT 1 FROM #TEMP1 WHERE Sistema = 'BTR')   
 --       BEGIN  
  
 --      UPDATE #TEMP1  
 --      SET   Glo_Producto = CASE  WHEN MOTIPOPER = 'CP' THEN 'COMPRA PROPIA'   
 --    WHEN MOTIPOPER = 'CI' THEN 'COMPRA CON PACTO'   
 --    WHEN MOTIPOPER = 'VP' THEN 'VENTA PROPIA'   
 --    WHEN MOTIPOPER = 'VI' THEN 'VENTA CON PACTO'  
 --    WHEN MOTIPOPER = 'IB' THEN 'INTERBANCARIO'  
 --    WHEN MOTIPOPER = 'FLI' THEN 'FACILIDAD LIQUIDEZ INTRADIA'  
 --    END  
 --         FROM   VIEW_PRODUCTO         with(nolock)  
 --           ,     VIEW_MDMO             with(nolock)  
 --          WHERE  VIEW_PRODUCTO.id_sistema = Sistema  
 --     AND  codigo_producto          = Cod_Producto  
 --            AND  Sistema                  = 'BTR'  
 --            AND  NumOper                  = monumoper  
  
 --      UPDATE #TEMP1         
 --      SET   Glo_Producto = inglosa  
 --         FROM   VIEW_INSTRUMENTO         with(nolock)  
 --           ,     VIEW_MDMO                with(nolock)  
 --          WHERE  incodigo  = mocodigo  
 --     AND  Sistema                  = 'BTR'  
 --            AND  NumOper                  = monumoper  
  
  
 --       END  
  
------------------------ BEX --------------------------------  
 UPDATE #TEMP1  
 SET Cod_Producto = CASE  WHEN Id_Sistema = 'BEX'   
     THEN  CASE  WHEN Codigo_Producto = 'VP' THEN 'VPX'  
       ELSE Codigo_Producto   
      END  
     ELSE Codigo_Producto   
    END  
 FROM LIMITE_TRANSACCION      with(nolock)  
 WHERE numoper = numerooperacion  
        /* MAP 21 Septiembre */   
        AND     Sistema = Id_sistema  
  
 UPDATE #TEMP1   
 SET Glo_Producto = descripcion  
 FROM view_PRODUCTO          with(nolock)  
 WHERE id_sistema  = Sistema  
 AND Cod_Producto = codigo_producto  
 and  Glo_Producto = ''  
 AND Id_Sistema = 'BEX'  
  
 UPDATE #TEMP1  
 SET rutcli = morutcli,  
  codcli = mocodcli  
 ---FROM bacbonosextsuda.dbo.TEXT_MVT_DRI with(nolock) --VIEW_TEXT_MVT_DRI  
  FROM BacBonosExtNY.dbo.TEXT_MVT_DRI with(nolock) --VIEW_TEXT_MVT_DRI  --PRD 21033
 WHERE numoper = monumoper  
 AND Sistema = 'BEX'  
  
 UPDATE #TEMP1  
 SET pendiente = 'S'  
 ---FROM bacbonosextsuda.dbo.TEXT_MVT_DRI with(nolock) --VIEW_TEXT_MVT_DRI  
  FROM BacBonosExtNY.dbo.TEXT_MVT_DRI with(nolock) --VIEW_TEXT_MVT_DRI  --PRD 21033
 WHERE Sistema   = 'BEX'  
 AND monumoper = numoper  
 AND mostatreg = 'P'  
-- AND (mostatreg = '' or  
--  mostatreg = 'P' )  



  
  
 UPDATE #TEMP1  
 SET pendiente = 'N'  
 --FROM bacbonosextsuda.dbo.TEXT_MVT_DRI with(nolock) --VIEW_TEXT_MVT_DRI  
  FROM BacBonosExtNY.dbo.TEXT_MVT_DRI with(nolock) --VIEW_TEXT_MVT_DRI  --PRD 21033
 WHERE Sistema = 'BEX'  
 AND monumoper = numoper  
 AND mostatreg = 'R'  
  
       IF EXISTS(SELECT 1 FROM #TEMP1 WHERE Sistema = 'BEX')  
        BEGIN  
  
       UPDATE #TEMP1  
       SET   Glo_Producto = CASE WHEN motipoper = 'CPX' THEN 'COMPRA' ELSE 'VENTA' END + ' DE ' + descripcion  
          FROM   VIEW_PRODUCTO                 with(nolock)  
            --,     bacbonosextsuda.dbo.TEXT_MVT_DRI with(nolock)   --PRD 21033
			,     BacBonosExtNY.dbo.TEXT_MVT_DRI with(nolock)  
           WHERE  VIEW_PRODUCTO.id_sistema    = Sistema  
      AND  Cod_Producto = ( CASE WHEN Codigo_Producto = 'VP' THEN 'VPX'  
     WHEN Codigo_Producto = 'CP' THEN 'CPX'  
     ELSE Codigo_Producto   
     END )  
             AND  Sistema         = 'BEX'  
             AND  NumOper      = monumoper  
  
            UPDATE #TEMP1  
            SET    monto   = monominal  
               ,   moneda  = (SELECT mnnemo FROM VIEW_MONEDA with(nolock) WHERE mncodmon = momonemi)  
            --FROM   bacbonosextsuda.dbo.TEXT_MVT_DRI with(nolock)  
			FROM   BacBonosExtNY.dbo.TEXT_MVT_DRI with(nolock)  
            WHERE  NumOper      = monumoper  
        AND  Sistema      = 'BEX' 
        END  
  
------------------------ SPOT --------------------------------  
  
 --UPDATE #TEMP1  
 --SET pendiente = 'S'  
 --, cod_producto = case when motipope = 'C' then 'C' else 'V' end  
 --FROM VIEW_MEMO   with(nolock)  
 --WHERE Sistema   ='BCC'   
 --       AND     CONVERT(NUMERIC(10),monumope) = numoper   
 --       AND moestatus ='P'  
  
 --UPDATE #TEMP1  
 --SET pendiente = 'N'  
 --, cod_producto = case when motipope = 'C' then 'C' else 'V' end  
 --FROM VIEW_MEMO   with(nolock)  
 --WHERE Sistema   ='BCC'   
 --       AND     CONVERT(NUMERIC(10),monumope) = numoper   
 --       AND     moestatus ='R'  
  
 --UPDATE #TEMP1  
 --SET rutcli = morutcli,  
 -- codcli = mocodcli  
 --FROM VIEW_MEMO   with(nolock)  
 --WHERE numoper = monumope  
 --AND Sistema = 'BCC'  
  
 --       IF EXISTS(SELECT 1 FROM #TEMP1 WHERE Sistema = 'BCC')   
 --       BEGIN  
  
 --      UPDATE #TEMP1  
 --      SET   Glo_Producto = CASE WHEN MOTIPMER <> 'LIQU' THEN CASE WHEN MOTIPOPE = 'C' THEN 'COMPRA' ELSE 'VENTA' END   
 --                   + ' DE ' + descripcion  
 --       ELSE descripcion END  
 --   FROM   VIEW_PRODUCTO   with(nolock)  
 --           ,     VIEW_MEMO      with(nolock)  
 --          WHERE  VIEW_PRODUCTO.id_sistema = Sistema  
 --     AND  codigo_producto          = Cod_Producto  
 --            AND  cod_producto             = motipmer  
 --            AND  Sistema                  = 'BCC'  
 --            AND  NumOper                  = monumope  
  
 --           UPDATE #TEMP1  
 --           SET    monto   = momonmo  
 --           ,      moneda  = mocodmon  
 --           FROM   VIEW_MEMO   with(nolock)  
 --              ,   #TEMP1  
 --           WHERE  NumOper = monumope  
 --             AND  Cod_Producto    = motipmer  
 --             AND  Sistema         = 'BCC'  
 --       END  
  
------------------------ Forward -------------------------  
  
  
 UPDATE #TEMP1  
 SET rutcli = cacodigo,  
  codcli = cacodcli     
 FROM VIEW_MFCA_NY      with(nolock)  
 WHERE numoper = canumoper  
 AND Sistema = 'BFW'  


 UPDATE #TEMP1  
 SET pendiente = 'S'  
 FROM VIEW_MFCA_NY   with(nolock)  
 WHERE Sistema='BFW' AND CONVERT(NUMERIC(10),canumoper)=numoper AND  
  caestado = 'P'  
  
 UPDATE #TEMP1  
 SET pendiente = 'N'  
        FROM VIEW_MFCA_NY   with(nolock)  
 WHERE Sistema='BFW' AND CONVERT(NUMERIC(10),canumoper)=numoper AND  
  caestado='R'  
  
        IF EXISTS(SELECT 1 FROM #TEMP1 WHERE Sistema = 'BFW')   
        BEGIN  
  
       UPDATE #TEMP1  
       SET   Glo_Producto = CASE WHEN catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END + ' DE ' + descripcion  
          FROM   VIEW_PRODUCTO with(nolock)  
            ,     VIEW_MFCA_NY     with(nolock)  
           WHERE  VIEW_PRODUCTO.id_sistema    = Sistema  
      AND  codigo_producto = Cod_Producto  
             AND  cod_producto    = CONVERT(CHAR(05),cacodpos1)  
             AND  Sistema         = 'BFW'  
             AND  NumOper      = canumoper  
  
              
            UPDATE #TEMP1  
            SET    monto   = camtomon1  
               ,   moneda  = (SELECT mnnemo FROM VIEW_MONEDA with (nolock) WHERE mncodmon = cacodmon1)  
            FROM   VIEW_MFCA_NY   with(nolock)  
            WHERE  NumOper      = canumoper  
              AND  Sistema      = 'BFW'  
        END  


  
------------------------< SWAP >--------------------------------  
  
  
 UPDATE #TEMP1  
 SET rutcli = rut_cliente,  
  codcli = codigo_cliente  
 FROM VIEW_MOVDIARIO_NY with(nolock)  
 WHERE numoper = numero_operacion  
 AND Sistema = 'PCS'  
  
  
 UPDATE #Temp1  
 SET pendiente = 'S'  
 FROM VIEW_CARTERA_NY with(nolock)  
 WHERE Sistema='PCS' AND CONVERT(NUMERIC(10),numero_operacion)=numoper AND  
  (Estado_oper_lineas='P' ) --or  Estado_oper_lineas=' ' )  
  
 UPDATE #Temp1  
 SET pendiente = 'N'  
 FROM VIEW_CARTERA_NY with(nolock)  
 WHERE Sistema='PCS' AND CONVERT(NUMERIC(10),numero_operacion)=numoper AND  
  Estado_oper_lineas='R'  
  
        IF EXISTS(SELECT 1 FROM #TEMP1 WHERE Sistema = 'PCS')   
        BEGIN  
  
       UPDATE #TEMP1  
       SET   Glo_Producto = CASE WHEN tipo_operacion = 'C' THEN 'COMPRA' ELSE 'VENTA' END + ' DE ' + descripcion  
          FROM   VIEW_PRODUCTO with(nolock)  
            ,     VIEW_MOVDIARIO_NY with(nolock)  
           WHERE  VIEW_PRODUCTO.id_sistema    = Sistema  
      AND  codigo_producto = (CASE WHEN Cod_Producto = 1 THEN 'ST'    
       WHEN Cod_Producto = 2 THEN 'SM'   
       WHEN Cod_Producto = 3 THEN 'FR'    
                                          WHEN Cod_Producto = 4 THEN 'SP'    
         END)  
             AND  Sistema         = 'PCS'  
             AND  NumOper         = numero_operacion  
  
        END  
  
  
------------------------ Opciones ----------------------------  
  
 --UPDATE #TEMP1  
 --SET rutcli = RutCliente,  
 -- codcli = Codigo     
 --FROM DBO.TAB_Importada_MoEncContrato  with(nolock)  
 --WHERE numoper = NumContrato  
 --AND Sistema = 'OPT'  
  
  
 --UPDATE #TEMP1  
 --SET pendiente = 'S'  
 --FROM DBO.TAB_Importada_MoEncContrato   with(nolock)  
 --WHERE Sistema='OPT' AND CONVERT(NUMERIC(10),NumContrato)=numoper AND  
 --        Estado = 'P'  
  
 --UPDATE #TEMP1  
 --SET pendiente = 'N'  
 --       FROM DBO.TAB_Importada_MoEncContrato  with(nolock)  
 --WHERE Sistema='OPT' AND CONVERT(NUMERIC(10),NumContrato)=numoper AND  
 -- Estado ='R'  
  
  
 --       IF EXISTS(SELECT 1 FROM #TEMP1 WHERE Sistema = 'OPT')   
 --       BEGIN  
  
 --      UPDATE #TEMP1  
 --      SET   Glo_Producto = CASE WHEN CVEstructura = 'C' THEN 'COMPRA' ELSE 'VENTA' END + ' DE ' + descripcion  
 --         FROM   VIEW_PRODUCTO with(nolock)  
 --           ,     DBO.TAB_Importada_MoEncContrato     with(nolock)  
 --          WHERE  VIEW_PRODUCTO.id_sistema    = Sistema  
 --     AND  codigo_producto = Cod_Producto  
 --            AND  cod_producto    = 'OPT'    
 --            AND  Sistema         = 'OPT'  
 --            AND  NumOper         = NumContrato  
  
  
           
 --           UPDATE #TEMP1  
 --         -- SET    moneda  = (SELECT mnnemo FROM VIEW_MONEDA with (nolock) WHERE mncodmon = 999)
 --         --Se modifica llamada a monedas Rq_7274
	--		SET   moneda  = (SELECT DISTINCT Mon.mnnemo FROM LnkOpc.CbMdbOpc.dbo.MoEncContrato MoEnc
	--							INNER JOIN LnkOpc.CbMdbOpc.dbo.MoDetContrato MoDet ON MoDet.MoNumFolio = MoEnc.MoNumFolio
	--							INNER JOIN bacparamsuda..moneda Mon ON MoDet.MOCODMON1 = Mon.mncodmon
	--						 WHERE MoEnc.MoNumContrato = NumContrato)
 --           FROM   DBO.TAB_Importada_MoEncContrato   with(nolock)  
 --           WHERE  NumOper   = NumContrato  
 --             AND  Sistema      = 'OPT'  
 --       END  
  
  
  
----------------------------< TODOS >------------------------------------------------  
  
 UPDATE #temp1  
 SET cliente         = SUBSTRING(clnombre,1 ,50) -- substring ( clnombre,1 ,70)   
 FROM VIEW_CLIENTE    with(nolock)  
 WHERE clrut  = rutcli  
 AND clcodigo = codcli  
  
  
 SELECT Sistema  ,  
  Glo_Producto ,  
  numoper  ,  
  cliente  ,  
  moneda  ,  
  Monto  ,  
  Operador ,  
  ErrorG  
 FROM #TEMP1  
    WHERE pendiente = 'S'  
 GROUP BY Sistema ,  
  Glo_Producto ,  
  numoper  ,  
  cliente  ,  
  moneda  ,  
  Monto  ,  
  Operador ,  
  ErrorG   
 ORDER  
 BY Sistema  ,  
  numoper  
  
  
 SET NOCOUNT OFF  
  
END

GO
