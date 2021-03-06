USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_INFORME_BASILEA_DERIVADOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GENERA_INFORME_BASILEA_DERIVADOS]  
   (   @dFecha      DATETIME  
   ,   @MiUsuario   VARCHAR(15)  
   )  
AS  
BEGIN  
-- GENERA_INFORME_BASILEA_DERIVADOS '20110314', 'MM'
   SET NOCOUNT ON  
  
   DECLARE @dFecProcPCS   DATETIME  
   DECLARE @dFecProcBFW   DATETIME  
   DECLARE @dFecProcOPT   DATETIME  
   DECLARE @SrvLink       NUMERIC(05)  
  
       SET @dFecProcPCS = (SELECT fechaproc FROM BacSwapSuda..SWAPGENERAL)  
       SET @dFecProcBFW = (SELECT acfecproc FROM BacFwdSuda..MFAC)  
  
-- 30/04/2009  ' Se modifica para agregar módulo Opciones a Artículo 84    
    EXEC BacParamSuda..SP_VERIFICA_LNKSERVER_OPC 'N' , @SrvLink OUTPUT  
  
    IF  @SrvLink = 0    
    BEGIN          -- Si existe LnkServer para Opciones             
           SELECT @dFecProcOPT = fechaproc   
           FROM LnkOpc.CbMdbOpc.dbo.OpcionesGeneral       
    END            -- Si existe LnkServer para Opciones             
    ELSE  
    BEGIN  
           SET @dFecProcOPT = (SELECT acfecproc FROM BacFwdSuda..MFAC)  
    END  
-- 30/04/2009  ' Se modifica para agregar módulo Opciones a Artículo 84    
  
  
  
   DECLARE @iFound      INTEGER  
   SELECT  @iFound      = -1  
   SELECT  @iFound      = 0  
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE  
   WHERE   Fecha        = @dFecha  
   AND     Tipo_Cambio <> 0  
  
   SELECT Fecha_Proc  
        , 'TotGenEqCredito' = ISNULL(SUM(Tot_Gen_Equiv_Credito),0.0)    
        , 'TotGenCateg3'    = ISNULL(SUM(Tot_Gen_Categ3),0.0)  
        , 'TotGenCateg5'    = ISNULL(SUM(Tot_Gen_Categ5),0.0)  
   INTO #Totales  
   FROM RESUMEN_ART84_DERIVADOS  
   WHERE Modulo='Forward'  
   and   Fecha_Proc = @dFecha  
   GROUP BY Fecha_Proc  
  
  
   IF @iFound = -1  
   BEGIN  
 SELECT   'Fecha_Proc'  = ''   
  ,'NumOpe'       = 0  
  ,'Correla'   = 0  
  ,'Modulo'   = ''   
  ,'Rut'    = ''  
  ,'Clnombre'  = ''  
  ,'Instrumento'   = ''  
  ,'Mascara'       = ''  
  ,'Nocional'      = 0  
  ,'Fecha_Cierre'  = ''  
  ,'Fecha_inicio'  = ''  
  ,'Seriado'   = ''  
  ,'Codigo'    = 0  
  ,'Tir'           = 0  
  ,'CodMoneda'    = 0  
  ,'NemoMoneda'   = ''  
  ,'Producto'  = ''  
  ,'Desc_Prod'     = ''  
  ,'ValorRazonable'= 0.0  
  ,'Plazo'   = 0  
  ,'Valor_Moneda'  = 0.  
  ,'Nocional_CLP'  = 0  
  ,'Factor'        = 0.0  
  ,'Sum_AVR_Positivo' = 0.0  
  ,'Max_Sum_AVR_Cero' = 0.0  
  ,'Equiv_Credito'    = 0.0  
  ,'Monto_Matriz'     = 0.0  
  ,'Cod_Clasif_Cliente'   = 0  
  ,'Glosa_Clasif_Cliente' = ''  
  ,'Categoria_Cliente'    = 0  
  ,'Comp_Bilateral'       = ''  
     ,'FechaEmision'         = ''  
     ,'HoraEmision'          = ''  
     ,'Usuario'   = ''  
  ,'FechaDatos'  = ''  
                ,'Mensaje'   = 'NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY......'  
                ,'TotGenEquivCred'      = 0.0  
  ,'TotGenEquivCateg3'    = 0.0  
  ,'TotGenEquivCateg5'    = 0.0  
  
      RETURN  
  
   END  
  
   SELECT  vmcodigo  
   ,       vmvalor  
   INTO    #Valor_Moneda  
   FROM    BacParamSuda..VALOR_MONEDA  
   WHERE   vmfecha = @dFecha  
  
   INSERT INTO #Valor_Moneda  
   SELECT 999 , 1.0  
  
   INSERT INTO #Valor_Moneda  
   SELECT 13  
   ,      vmvalor  
   FROM   BacParamSuda..VALOR_MONEDA  
   WHERE  vmfecha  = @dFecha  
   AND    vmcodigo = 994  
  
   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --  
   SELECT vmcodigo = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END  
   ,      vmvalor  = Tipo_Cambio  
   INTO   #VALOR_TC_CONTABLE  
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   
   WHERE  Fecha    = @dFecha  
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)  
  
   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --  
   INSERT INTO #VALOR_TC_CONTABLE  
   SELECT vmcodigo  
   ,      vmvalor  
   FROM   #Valor_Moneda  
   WHERE  vmcodigo  IN(994,995,997,998,999)  
  
   CREATE TABLE #TempArt84  
          (  
          RutDeudor     CHAR (15)      ,                        -- 1  
          Modulo        CHAR (10)      ,                        -- 2  
          Tipoper       CHAR (10)      ,                        -- 3    
          Moneda        NUMERIC (05)  ,                       -- 4  
          Monto         NUMERIC(18) NULL DEFAULT (0),           -- 5  
          Fec_Proc      CHAR (08) --DATETIME                    -- 6   
          )  
  
    SELECT  *   
    INTO #TEMP_ART84_DERIVADOS   
    FROM ART84_DERIVADOS  
    WHERE Fecha_Proc = @dFecha  
  
    SELECT  Fecha_Proc  
           ,NumOpe  
           ,Correla  
           ,Modulo  
           ,rut_cliente   
           ,codigo_cliente   
           ,Instrumento  
           ,Mascara  
           ,Nocional  
           ,fecha_Cierre  
           ,fecha_inicio  
           ,Seriado  
           ,Codigo  
           ,Tir  
           ,Moneda  
           ,Producto  
           ,Desc_Prod  
           ,AVR  
           ,Vigencia_Dias  
           ,Valor_Moneda  
           ,Nocional_CLP  
           ,Factor  
           ,Sum_AVR_Positivo  
           ,Max_Sum_AVR_Cero  
           ,Equiv_Credito  
           ,Monto_Matriz  
           ,Acu_Comp_Bilateral  
           ,'clrut_padre'  = ISNULL(clrut_padre,0)  
           ,'clcodigo_padre' = ISNULL(clcodigo_padre,0)  
    INTO  #TEMP_ART84_DERIVADOS_CLI_RELAC  
--  REQ. 7619  
    FROM  #TEMP_ART84_DERIVADOS RIGHT OUTER JOIN BACLINEAS..CLIENTE_RELACIONADO  ON clrut_hijo      = rut_cliente  
                                                                               AND  clcodigo_hijo   = codigo_cliente              
    WHERE Fecha_Proc      = @dFecha  
    AND  (Vigencia_Dias   > 0  OR  Modulo = 'OPT')    -- AND   Vigencia_Dias   > 0    
  
    UPDATE #TEMP_ART84_DERIVADOS_CLI_RELAC  
    SET  rut_cliente = ISNULL(clrut_padre,rut_cliente)  
        ,codigo_cliente = ISNULL(clcodigo_padre,codigo_cliente)  
    FROM BACPARAMSUDA..CLIENTE   
    WHERE rut_cliente     = clrut   
    AND   codigo_cliente  = clcodigo  
  
      
    UPDATE #TEMP_ART84_DERIVADOS_CLI_RELAC  
    SET Acu_Comp_Bilateral = ClCompBilateral  
    FROM BACPARAMSUDA..CLIENTE   
    WHERE rut_cliente     = clrut   
    AND   codigo_cliente  = clcodigo  
  
  
    SELECT  Fecha_Proc  
           ,NumOpe  
           ,Correla  
           ,Modulo  
           ,rut_cliente   
           ,codigo_cliente   
           ,Instrumento  
           ,Mascara  
           ,Nocional  
           ,fecha_Cierre  
           ,fecha_inicio  
           ,Seriado  
           ,Codigo  
           ,Tir  
           ,Moneda  
           ,Producto  
           ,Desc_Prod  
           ,AVR  
           ,Vigencia_Dias  
           ,Valor_Moneda  
           ,Nocional_CLP  
           ,Factor  
           ,Sum_AVR_Positivo  
           ,Max_Sum_AVR_Cero  
           ,Equiv_Credito  
           ,Monto_Matriz  
           ,Acu_Comp_Bilateral  
 INTO  #TEMP_ART84_DERIVADOS_COMP_BILATERAL  
 FROM #TEMP_ART84_DERIVADOS_CLI_RELAC  
 where  clrut_padre <> 0  
 and Acu_Comp_Bilateral = 'S'  
  
  
    DELETE FROM #TEMP_ART84_DERIVADOS                 
    WHERE NumOpe IN (SELECT NumOpe FROM #TEMP_ART84_DERIVADOS_COMP_BILATERAL)   
  
    INSERT INTO #TEMP_ART84_DERIVADOS  
    SELECT * FROM  #TEMP_ART84_DERIVADOS_COMP_BILATERAL   
    WHERE Acu_Comp_Bilateral = 'S'  
  
  
   IF NOT EXISTS(SELECT Fecha_Proc FROM ART84_DERIVADOS WHERE Fecha_Proc = @dFecha)  
   BEGIN  
  
       IF (@dFecha = @dFecProcPCS) AND  (@dFecha = @dFecProcBFW) AND  (@dFecha = @dFecProcOPT)  
       BEGIN   
  
  SELECT   'Fecha_Proc'  = ''   
   ,'NumOpe'       = 0  
   ,'Correla'   = 0  
   ,'Modulo'   = ''   
   ,'Rut'    = ''  
   ,'Clnombre'  = ''  
   ,'Instrumento'   = ''  
   ,'Mascara'       = ''  
   ,'Nocional'      = 0  
   ,'Fecha_Cierre'  = ''  
   ,'Fecha_inicio'  = ''  
   ,'Seriado'   = ''  
   ,'Codigo'    = 0  
   ,'Tir'           = 0  
   ,'CodMoneda'    = 0  
   ,'NemoMoneda'   = ''  
   ,'Producto'  = ''  
   ,'Desc_Prod'     = ''  
   ,'ValorRazonable'= 0.0  
   ,'Plazo'   = 0  
   ,'Valor_Moneda'  = 0.  
   ,'Nocional_CLP'  = 0  
   ,'Factor'        = 0.0  
   ,'Sum_AVR_Positivo' = 0.0  
   ,'Max_Sum_AVR_Cero' = 0.0  
   ,'Equiv_Credito'    = 0.0  
   ,'Monto_Matriz'     = 0.0  
   ,'Cod_Clasif_Cliente'   = 0  
   ,'Glosa_Clasif_Cliente' = ''  
   ,'Categoria_Cliente'    = 0  
  
   ,'Comp_Bilateral'       = ''  
             ,'FechaEmision'         = ''  
       ,'HoraEmision'          = ''  
             ,'Usuario'   = ''  
          ,'FechaDatos'  = ''  
                        ,'Mensaje'   = 'DEBE GENERAR INTERFAZ ARTICULO 84.....'  
                        ,'TotGenEquivCred'      = 0.0  
   ,'TotGenEquivCateg3'    = 0.0  
   ,'TotGenEquivCateg5'    = 0.0  
                        ,'TotGenEquivCred'      = 0.0  
                        ,'TotGenEquivCateg3'    = 0.0  
                        ,'TotGenEquivCateg5'    = 0.0  
  
       END  
       ELSE  
       BEGIN   
                /*******************************************  
                  Proceso Reporte basilea no procesará  
                  más para cumplir con el caracter   
                  de ser reporte.  
                *********************************************/  
                /*  
  EXECUTE BacFwdSuda..Sp_Carga_Tabla_Art84BFW  
                EXECUTE BacSwapSuda..Sp_Carga_Tabla_Art84PCS                 
                  
                INSERT INTO #TempArt84    
                EXECUTE Sp_Calcula_Art84_Derivados @dFecha */  
  
                IF @@ROWCOUNT = 0             
                BEGIN   
  
   SELECT   'Fecha_Proc'  = ''   
    ,'NumOpe'       = 0  
    ,'Correla'   = 0  
    ,'Modulo'   = ''   
    ,'Rut'    = ''  
    ,'Clnombre'  = ''  
    ,'Instrumento'   = ''  
    ,'Mascara'       = ''  
    ,'Nocional'      = 0  
    ,'Fecha_Cierre'  = ''  
    ,'Fecha_inicio'  = ''  
    ,'Seriado'   = ''  
    ,'Codigo'    = 0  
    ,'Tir'           = 0  
    ,'CodMoneda'    = 0  
    ,'NemoMoneda'   = ''  
    ,'Producto'  = ''  
    ,'Desc_Prod'     = ''  
    ,'ValorRazonable'= 0.0  
    ,'Plazo'   = 0  
    ,'Valor_Moneda'  = 0.  
    ,'Nocional_CLP'  = 0  
    ,'Factor'        = 0.0  
    ,'Sum_AVR_Positivo' = 0.0  
    ,'Max_Sum_AVR_Cero' = 0.0  
    ,'Equiv_Credito'    = 0.0  
    ,'Monto_Matriz'     = 0.0  
    ,'Cod_Clasif_Cliente'   = 0  
    ,'Glosa_Clasif_Cliente' = ''  
    ,'Categoria_Cliente'    = 0  
    ,'Comp_Bilateral'       = ''  
              ,'FechaEmision'         = ''  
              ,'HoraEmision'          = ''  
              ,'Usuario'   = ''  
           ,'FechaDatos'  = ''  
                         ,'Mensaje'   = 'GENERAR PRIMERO INTERFAZ ART 84...'  
                                ,'TotGenEquivCred'      = 0.0  
           ,'TotGenEquivCateg3'    = 0.0  
           ,'TotGenEquivCateg5'    = 0.0  
                
                          
                END  
                ELSE            
                BEGIN  
   SELECT   'Fecha_Proc'  = A.Fecha_Proc  
    ,'NumOpe'       = A.NumOpe        
    ,'Correla'   = A.Correla   
    ,'Modulo'   = A.Modulo   
    ,'Rut'    = CONVERT(CHAR(11),REPLICATE('0', 9 - LEN(LTRIM(RTRIM(clRut)))) + LTRIM(RTRIM(CONVERT(CHAR(10),ClRut))) + '-' + CONVERT(CHAR(1),clDv))  
    ,'Clnombre'  = Clnombre  
    ,'Instrumento'   = A.Instrumento            
    ,'Mascara'       = A.Mascara  
    ,'Nocional'      = A.Nocional  
    ,'Fecha_Cierre'  = A.fecha_Cierre  
    ,'Fecha_inicio'  = A.fecha_Inicio  
    ,'Seriado'   = A.Seriado  
    ,'Codigo'    = A.Codigo  
    ,'Tir'           = A.Tir  
    ,'CodMoneda'    = A.Moneda  
    ,'NemoMoneda'   = mnnemo  
    ,'Producto'  = A.Producto  
    ,'Desc_Prod'     = A.Desc_Prod  
    ,'ValorRazonable'= A.AVR  
    ,'Plazo'   = A.Vigencia_Dias  
    ,'Valor_Moneda'  = A.Valor_Moneda  
    ,'Nocional_CLP'  = A.Nocional_CLP  
    ,'Factor'        = A.Factor  
    ,'Sum_AVR_Positivo' = A.Sum_AVR_Positivo  
    ,'Max_Sum_AVR_Cero' = A.Max_Sum_AVR_Cero  

     -- Contingencia: 11-Mayo-2011. Reporte no cuadra
    ,'Equiv_Credito'    = R.Tot_Gen_Equiv_Credito

    ,'Monto_Matriz'     = A.Monto_Matriz  
    ,'Cod_Clasif_Cliente'   = Cltipcli  
    ,'Glosa_Clasif_Cliente' = tbglosa  
    ,'Categoria_Cliente'    = (CASE WHEN Cltipcli = 1 THEN 3 ELSE 5 END)   
    ,'Comp_Bilateral'   = A.Acu_Comp_Bilateral  
              ,'FechaEmision'         = CONVERT(CHAR(10),GETDATE(),103)  
              ,'HoraEmision'          = CONVERT(CHAR(10),GETDATE(),108)  
              ,'Usuario'   = @MiUsuario  
           ,'FechaDatos'  = CONVERT(CHAR(10),@dFecha, 103)  
           ,'Mensaje'   =''  
                                ,'TotGenEquivCred'      = TotGenEqCredito  
           ,'TotGenEquivCateg3'    = TotGenCateg3  
           ,'TotGenEquivCateg5'    = TotGenCateg5  
   FROM #TEMP_ART84_DERIVADOS A --ART84_DERIVADOS  
             LEFT JOIN RESUMEN_ART84_DERIVADOS R ON R.Fecha_Proc = @dFecha 
                                                and R.Rut_Cliente = A.rut_cliente 
                                                and R.Codigo_Cliente = 1 
                                                and R.Modulo = 'Forward'
                        ,    #Totales      B  
                 ,    BacParamSuda..Cliente  
                 ,    BacParamSuda..Moneda        
                 ,    BacParamSuda..tabla_general_detalle  
           WHERE A.Fecha_Proc = @dFecha  
                          AND @dFecha = B.Fecha_Proc  
                   AND A.rut_cliente = Clrut  
     AND A.codigo_cliente = clcodigo  
                   AND A.Moneda = mncodmon  
     AND tbcateg = 72   
                          AND Cltipcli = tbcodigo1  
                          AND  (Vigencia_Dias   > 0  OR  A.Modulo = 'OPT')    -- AND   Vigencia_Dias   > 0                            AND Vigencia_Dias > 0    -- MAP 20090302 Se descartan los vencidos.
                END  
       END       
   END  
   ELSE  
   BEGIN    
  
  SELECT   'Fecha_Proc'  = A.Fecha_Proc  
   ,'NumOpe'       = A.NumOpe        
   ,'Correla'   = A.Correla   
   ,'Modulo'   = A.Modulo   
   ,'Rut'    = CONVERT(CHAR(11),REPLICATE('0', 9 - LEN(LTRIM(RTRIM(clRut)))) + LTRIM(RTRIM(CONVERT(CHAR(10),ClRut))) + '-' + CONVERT(CHAR(1),clDv))  
   ,'Clnombre'  = Clnombre  
   ,'Instrumento'   = A.Instrumento            
   ,'Mascara'       = A.Mascara  
   ,'Nocional'      = A.Nocional  
   ,'Fecha_Cierre'  = A.fecha_Cierre  
   ,'Fecha_inicio'  = A.fecha_Inicio  
   ,'Seriado'   = A.Seriado  
   ,'Codigo'    = A.Codigo  
   ,'Tir'           = A.Tir  
   ,'CodMoneda'    = A.Moneda  
   ,'NemoMoneda'   = mnnemo  
   ,'Producto'  = A.Producto  
   ,'Desc_Prod'     = A.Desc_Prod  
   ,'ValorRazonable'= A.AVR  
   ,'Plazo'   = A.Vigencia_Dias  
   ,'Valor_Moneda'  = A.Valor_Moneda  
   ,'Nocional_CLP'  = A.Nocional_CLP  
   ,'Factor'        = A.Factor  
   ,'Sum_AVR_Positivo' = A.Sum_AVR_Positivo  
   ,'Max_Sum_AVR_Cero' = A.Max_Sum_AVR_Cero  

-- Contingencia: 11-Mayo-2011. Reporte no cuadra
   ,'Equiv_Credito'    = R.Tot_Gen_Equiv_Credito

   ,'Monto_Matriz'     = A.Monto_Matriz  
   ,'Cod_Clasif_Cliente'   = Cltipcli  
   ,'Glosa_Clasif_Cliente' = tbglosa  
   ,'Categoria_Cliente'    = (CASE WHEN Cltipcli = 1 THEN 3  ELSE  5 END)   
   ,'Comp_Bilateral'       = A.Acu_Comp_Bilateral  
             ,'FechaEmision'         = CONVERT(CHAR(10),GETDATE(),103)  
             ,'HoraEmision'          = CONVERT(CHAR(10),GETDATE(),108)  
             ,'Usuario'   = @MiUsuario  
          ,'FechaDatos'  = CONVERT(CHAR(10),@dFecha, 103)  
                        ,'Mensaje'   =''  
   ,'TotGenEquivCred'      = TotGenEqCredito  
   ,'TotGenEquivCateg3'    = TotGenCateg3  
   ,'TotGenEquivCateg5'    = TotGenCateg5  
         FROM #TEMP_ART84_DERIVADOS A --ART84_DERIVADOS  

-- Contingencia: 11-Mayo-2011. Reporte no cuadra
             LEFT JOIN RESUMEN_ART84_DERIVADOS R ON R.Fecha_Proc = @dFecha 
                                                and R.Rut_Cliente = A.rut_cliente 
                                                and R.Codigo_Cliente = 1 
                                                and R.Modulo = 'Forward'
-- Contingencia: 11-Mayo-2011. Reporte no cuadra

         ,    #Totales      B  
         ,    BacParamSuda..Cliente  
         ,    BacParamSuda..Moneda        
         ,    BacParamSuda..tabla_general_detalle  
         WHERE A.Fecha_Proc = @dFecha  
           AND @dFecha = B.Fecha_Proc  
           AND A.rut_cliente = Clrut  
    AND A.codigo_cliente = clcodigo  
           AND A.Moneda = mncodmon  
    AND tbcateg = 72   
           AND Cltipcli = tbcodigo1  
           AND  (Vigencia_Dias   > 0  OR  A.Modulo = 'OPT')    -- AND   Vigencia_Dias   > 0      -- MAP 20090302 Se descartan los vencidos. 
  
   END   
  
END  
GO
