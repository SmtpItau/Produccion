USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_GRILLA_IMPRESION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FILTRO_GRILLA_IMPRESION]  
   (   @Fecha_Inicio     DATETIME  
   ,   @Fecha_Termino    DATETIME  
   ,   @Mercado          CHAR(4)  
   ,   @T_Operacion      CHAR(1)  
   ,   @S_Operacion      CHAR(1)  
   ,   @Rut_Cliente      NUMERIC(10)  
   ,   @Usuario          CHAR(10)  
   ,   @Moneda           CHAR(3)  
   ,   @FP_Recibimos     INT  
   ,   @FP_Pagamos       INT  
   ,   @Carta            NUMERIC(1)  
   )  
AS   
BEGIN  
  
   SET NOCOUNT ON  
  
   IF @S_Operacion = 'V'   
      SET @S_Operacion = ''  
  
   DECLARE @Fecha_Proceso DATETIME  
       SET @Fecha_Proceso = ( SELECT CONVERT(CHAR(08),acfecpro,112) FROM MEAC with(nolock) )  
  
   CREATE TABLE #CARTAS_LIQUIDACION   
      (   N_Operacion  NUMERIC(09)  
      ,   Mercado      CHAR(04)  
      ,   T_Operacion  CHAR(06)  
      ,   S_Operacion  CHAR(02)  
      ,   Nom_Cliente  CHAR(35)  
      ,   Monto_Oper   NUMERIC(19,4)  
      ,   Monto_Pesos  NUMERIC(19,4)  
      ,   Moneda_Oper  CHAR(03)  
      ,   Moneda_Conv  CHAR(03)  
      ,   TCam_Cierre  NUMERIC(19,4)  
      ,   TCam_Costo   NUMERIC(19,4)  
      ,   Par_Cierre   NUMERIC(19,8)  
      ,   Par_Costo    NUMERIC(19,8)  
      ,   FP_Pagamos   CHAR(30)  
      ,   FP_Recibimos CHAR(30)  
      ,   Fecha        DATETIME  
      ,   Hora         CHAR(08)  
      ,   Usuario      CHAR(15)  
      ,   Terminal     CHAR(15)  
      )  
  
   IF @Carta = 1   
   BEGIN    
      -- Carta de Liquidacion con Montos Agrupados  
      INSERT INTO #CARTAS_LIQUIDACION  
      SELECT morutcli  
         ,   CASE WHEN motipmer = 'CCBB' THEN 'EMPR' ELSE motipmer END  
         ,   'COMPRA'   
         ,   'OK'    
         ,   monomcli   
         ,   SUM(momonmo)   
         ,   CASE WHEN motipmer = 'CANJ' THEN SUM(momonmo*motctra) ELSE SUM(momonpe) END  
         ,   'USD'    
         ,   'CLP'    
         ,   0     
         ,   0    
         ,   0    
         ,   0   
         ,   glosa    
         ,   ''     
         ,   movaluta2   
         ,   ''     
         ,   ''     
         ,   ''      
      FROM  MEMO                          with(nolock)  
            INNER JOIN VIEW_FORMA_DE_PAGO with(nolock) ON codigo = moentre  
      WHERE mofech      BETWEEN @Fecha_Inicio AND @Fecha_Termino   -->   AND (mofech      >= @Fecha_Inicio  AND mofech <= @Fecha_Termino)  
      AND   motipope    = 'C'  
      AND   moestatus   NOT IN('A', 'P')  
      AND  (morutcli    = @Rut_Cliente OR @Rut_Cliente = 0)  
      AND   motipmer    IN('PTAS', 'CANJ')  
      AND  (mocodmon    = @Moneda  OR @Moneda  = '')  
      AND  (mooper      = @Usuario OR @Usuario = '')  
      GROUP BY morutcli, monomcli, movaluta2, glosa, motipmer  
      ORDER BY monomcli   
  
      INSERT INTO #CARTAS_LIQUIDACION  
      SELECT morutcli  
         ,   CASE WHEN motipmer = 'CCBB' THEN 'EMPR' ELSE motipmer END --> motipmer    
         ,   'COMPRA'   
         ,   'OK'    
         ,   monomcli   
         ,   SUM(momonmo)   
         ,   CASE WHEN motipmer = 'CANJ' THEN SUM(momonmo*motctra) ELSE SUM(momonpe) END  
         ,   'USD'    
         ,   'CLP'    
         ,   0     
         ,   0    
         ,   0    
         ,   0   
         ,   glosa    
         ,   ''     
         ,   movaluta2   
         ,   ''     
         ,   ''     
         ,   ''      
      FROM  MEMOH                         with(nolock)   
            INNER JOIN VIEW_FORMA_DE_PAGO with(nolock) ON codigo = moentre  
      WHERE mofech      BETWEEN @Fecha_Inicio AND @Fecha_Termino   -->     
      AND   motipope   = 'C'           
      AND   moestatus  NOT IN('A', 'P')  
      AND  (morutcli   = @Rut_Cliente OR @Rut_Cliente = 0)  
      AND  (mocodmon   = @Moneda  OR @Moneda  = '')  
      AND  (mooper     = @Usuario OR @Usuario = '')  
      GROUP BY morutcli, monomcli, movaluta2, glosa, motipmer  
      ORDER BY monomcli  
  
      SELECT * FROM #CARTAS_LIQUIDACION   
  
   END ELSE   
   BEGIN  
      SELECT  'N_Operacion'    = a.monumope   
         ,    'Mercado'        = CASE WHEN a.motipmer = 'CCBB' THEN 'EMPR' ELSE a.motipmer END   
 ,    'T_Operacion'    = a.motipope   
         ,    'S_Operacion'    = CASE WHEN a.moestatus = ''  THEN 'ACTIVA'  
                WHEN a.moestatus = 'M' THEN 'MODIFICADA'  
                                      WHEN a.moestatus = 'A' THEN 'ANULADA'   
                                 END  
         ,    'Nom_Cliente'    = SUBSTRING(a.monomcli, 1, 28)  
         ,    'Monto_Oper'     = a.momonmo     
         ,    'Monto_Pesos'    = a.momonpe     
         ,    'Moneda_Oper'    = a.mocodmon     
         ,    'Moneda_Conv'    = a.mocodcnv     
         ,    'TCam_Cierre'    = a.moticam     
         ,    'TCam_Costo'     = a.motctra     
         ,    'Par_Cierre'     = a.moparme     
         ,    'Par_Costo'      = a.mopartr     
         ,    'FP_Pagamos'     = b.glosa      
         ,    'FP_Recibimos'   = c.glosa      
         ,    'Fecha'          = CONVERT(CHAR(10),mofech,103)   
         ,    'Hora'           = a.mohora     
         ,    'Usuario'        = a.mooper              
         ,    'Terminal'       = a.moterm     
         INTO #MEMO  
         FROM MEMO                                      a with(nolock)  
              left JOIN BacParamSuda.dbo.FORMA_DE_PAGO b with(nolock) ON b.codigo   = a.moentre  
              left JOIN BacParamSuda.dbo.FORMA_DE_PAGO c with(nolock) ON c.codigo   = a.morecib  
         WHERE (a.mofech       BETWEEN @Fecha_Inicio AND @Fecha_Termino)  
         AND   (a.morutcli     = @Rut_Cliente  OR @Rut_Cliente  = 0)  
         AND   (a.moestatus    = @S_Operacion  OR @S_Operacion  = '')  
         AND   (a.motipope     = @T_Operacion  OR @T_Operacion  = '')  
         AND   (a.motipmer     = @Mercado      OR @Mercado      = '')  
         AND   (a.mocodmon     = @Moneda       OR @Moneda       = '')  
         AND   (a.moentre      = @FP_Pagamos   OR @FP_Pagamos   = 0 )  
         AND   (a.morecib      = @FP_Recibimos OR @FP_Recibimos = 0 )  
         AND   (a.mooper       = @Usuario      OR @Usuario      = '')   
         ORDER BY a.monumope  
  
         INSERT INTO #MEMO  
         SELECT 'N_Operacion'  = a.monumope   
            ,   'Mercado'      = CASE WHEN a.motipmer = 'CCBB' THEN 'EMPR' ELSE a.motipmer END  
            ,   'T_Operacion'  = a.motipope   
            ,   'S_Operacion'  = CASE WHEN a.moestatus = ''  THEN 'ACTIVA'  
                                      WHEN a.moestatus = 'M' THEN 'MODIFICADA'  
                                      WHEN a.moestatus = 'A' THEN 'ANULADA'   
                                 END  
            ,   'Nom_Cliente'  = SUBSTRING(a.monomcli, 1, 28)  
            ,   'Monto_Oper'   = a.momonmo     
            ,   'Monto_Pesos'  = a.momonpe     
            ,   'Moneda_Oper'  = a.mocodmon     
            ,   'Moneda_Conv'  = a.mocodcnv     
            ,   'TCam_Cierre'  = a.moticam     
            ,   'TCam_Costo'   = a.motctra     
            ,   'Par_Cierre'   = a.moparme     
            ,   'Par_Costo'    = a.mopartr     
            ,   'FP_Pagamos'   = b.glosa      
            ,   'FP_Recibimos' = c.glosa      
            ,   'Fecha'        = CONVERT(CHAR(10),mofech,103)   
            ,   'Hora'         = a.mohora     
            ,   'Usuario'      = a.mooper              
            ,   'Terminal'     = a.moterm     
          FROM  MEMOH                           a with(nolock)  
                left JOIN VIEW_FORMA_DE_PAGO   b with(nolock) ON b.codigo   = a.moentre  
                left  JOIN VIEW_FORMA_DE_PAGO   c with(nolock) ON c.codigo   = a.morecib  
          WHERE (a.mofech      BETWEEN @Fecha_Inicio AND @Fecha_Termino)  
          AND   (a.morutcli    = @Rut_Cliente  OR @Rut_Cliente  = 0)     
          AND   (a.moestatus   = @S_Operacion  OR @S_Operacion  = '')  
          AND   (a.motipope    = @T_Operacion  OR @T_Operacion  = '')  
          AND   (a.motipmer    = @Mercado      OR @Mercado      = '')      
          AND   (a.mocodmon    = @Moneda       OR @Moneda       = '')       
          AND   (a.moentre     = @FP_Pagamos   OR @FP_Pagamos   = 0)   
          AND   (a.morecib     = @FP_Recibimos OR @FP_Recibimos = 0)  
          AND   (a.mooper      = @Usuario      OR @Usuario      = '')   
          ORDER BY a.monumope  
  
         SELECT * FROM #MEMO ORDER BY N_Operacion  
      END  
  
END  
GO
