USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDACION_POLITICA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VALIDACION_POLITICA]    
   (   @Id_Sistema    CHAR(3)    
   ,   @CodProducto   VARCHAR(5)    
   ,   @nRutCliente   NUMERIC(10)    
   ,   @nCodCliente   INTEGER    
   ,   @nPlazo        NUMERIC(9)    
   ,   @nMetodologia  NUMERIC(5)  = 1  
   )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   IF @Id_Sistema = 'BFW' AND @CodProducto = '13'    
   BEGIN    
      SELECT 'Codigo'  = -2   -- Correción para proyecto Turing  
      ,      'Estado'  = 'False'    
      ,      'Mensaje' = 'Producto no Aplica Threshold'    
      ,      'Segmento'= 0    
      RETURN    
   END    
    
 -- PRD8800  
   IF @nMetodologia <> 1 AND @nMetodologia <> 4  
   BEGIN  
      SELECT 'Codigo'  = -2  
         ,   'Estado'  = 'False'  
         ,   'Mensaje' = 'No aplica Threshold por Operación. Linea Derivado Consolidada.'  
         ,   'Segmento'= -1  
      RETURN  
   END  
-- PRD8800  
  
    
   DECLARE @LinRutCliente   NUMERIC(10)    
       SET @LinRutCliente   = @nRutCliente    
   DECLARE @LinCodCliente   NUMERIC(10)    
       SET @LinCodCliente   = @nCodCliente    

	--+++CONTROL IDD, jcamposd NO aplica controlar bajo desarrollo IDD    
   --IF EXISTS( SELECT 1 FROM BacLineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @LinRutCliente)    
   --BEGIN    
   --   SET @LinRutCliente = (SELECT TOP 1 clrut_padre    FROM BacLineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @LinRutCliente)    
   --   SET @LinCodCliente = (SELECT TOP 1 clcodigo_padre FROM BacLineas..CLIENTE_RELACIONADO WHERE clrut_hijo = @LinRutCliente)    
   --END    
   -----CONTROL IDD, jcamposd NO aplica controlar bajo desarrollo IDD
    
   DECLARE @nTipoCliente   INTEGER    
       SET @nTipoCliente   = (SELECT cltipcli FROM BacParamSuda.dbo.CLIENTE with(nolock)    
                                             WHERE clrut = @nRutCliente AND clcodigo = @nCodCliente)    
    
   IF @nTipoCliente = 2    
   BEGIN    
      SELECT 'Codigo'  = -2    
         ,   'Estado'  = 'False'    
         ,   'Mensaje' = 'Cliente esta definido como BANCO EXTRANJERO'    
         ,   'Segmento'= -1    
      RETURN    
   END    
    
   DECLARE @iSegmentoCtr   INTEGER    
       SET @iSegmentoCtr   = (SELECT seg_comercial FROM BacParamSuda.dbo.CLIENTE with(nolock)    
                                                  WHERE clrut = @nRutCliente AND clcodigo = @nCodCliente)    

	--+++CONTROL IDD, jcamposd NO aplica controlar bajo desarrollo IDD    
   --DECLARE @iBloqueado    INTEGER    
   --    SET @iBloqueado    = ISNULL(( SELECT CASE WHEN Bloqueado = 'S' THEN 1 ELSE 0 END     
   --                                    FROM BacLineas.dbo.LINEA_GENERAL with(nolock)    
   --                                   WHERE Rut_Cliente    = @LinRutCliente    
   --                                     AND Codigo_Cliente = @LinCodCliente), 0)    
   --IF @iBloqueado = 1    
   --BEGIN    
   --   SELECT 'Codigo'  = -2    
   --      ,   'Estado'  = 'False'    
   --      ,   'Mensaje' = 'Línea General Bloqueada para el Cliente.'    
   --      ,   'Segmento'= -1    
   --   RETURN    
   --END    
	-----CONTROL IDD, jcamposd NO aplica controlar bajo desarrollo IDD    

	--+++CONTROL IDD, jcamposd NO aplica controlar bajo desarrollo IDD    
   -->     Valida Monto de Linea Threshold    
   --DECLARE @LineaCredito  NUMERIC(19,4)    
   --    SET @LineaCredito  = isnull((SELECT isnull(Monto_Linea_Threshold, 0)    
   --                                   FROM BacLineas.dbo.LINEA_GENERAL with(nolock)    
   --                                   WHERE Rut_Cliente    = @LinRutCliente    
   --                                   AND Codigo_Cliente = @LinCodCliente), 0)    
    
   --IF @LineaCredito = 0 OR @LineaCredito IS NULL    
   --BEGIN    
   --   IF @iSegmentoCtr <= 3    
   --   BEGIN    
   --      UPDATE BacLineas.dbo.LINEA_GENERAL    
   --         SET Monto_Linea_Threshold = 1.0    
   --       WHERE Rut_Cliente           = @LinRutCliente    
   --         AND Codigo_Cliente        = @LinCodCliente    
   --   END ELSE    
   --   BEGIN    
   --      SELECT 'Codigo'  = -1    
   --         ,   'Estado'  = 'False'    
   --         ,   'Mensaje' = 'Cliente NO Tiene Línea de Crédito Threshold.'    
   --         ,   'Segmento'= -1    
   --      RETURN    
   --   END    
   --END    
	-----CONTROL IDD, jcamposd NO aplica controlar bajo desarrollo IDD    
	
   -->     Determina el Segmento del CLiente y si ha firmado las Nuevas Condiciones Generales.    
   DECLARE @iSegmento       INTEGER    
   DECLARE @FirmoNuevasCCG  CHAR(1)    
   DECLARE @Clasificacion   CHAR(1)    
    
    SELECT @iSegmento      = ISNULL(seg_comercial, -1)    
      ,    @FirmoNuevasCCG = CASE WHEN nuevo_ccg_firmado = 'S' THEN 'S' ELSE 'N' END    
      ,    @Clasificacion  = CASE WHEN clclsbif = '' or clclsbif = 'NA' or clclsbif = 'SC' THEN 'SC'    
                                  ELSE                                                          clclsbif    
                             END    
      FROM BacParamSuda.dbo.CLIENTE with(nolock)    
     WHERE clrut           = @nRutCliente    
       AND clcodigo        = @nCodCliente    
    
   --> Condiciones Generales Antiguas (NO PIDE THRESHOLD EN PANTALLA    
   IF @FirmoNuevasCCG  = 'N'    
   BEGIN    
      SELECT 'Codigo'  = 0    
      ,      'Estado'  = 'False'    
      ,      'Mensaje' = 'Cliente cumple con normativa antigua del threshold. Aplicara (20%)'    
      ,      'Segmento'= @iSegmento    
      RETURN    
   END    
    
   DECLARE @GlosaSegmento  VARCHAR(100)    
       SET @GlosaSegmento  = isnull((SELECT isnull(SgmDesc , '')--PRD-8800    
                                       FROM BacParamSuda.dbo.TBL_SEGMENTOSCOMERCIALES     
                                       WHERE  SgmCod =  @iSegmento), '')    
    
   IF @iSegmento = -1 OR @iSegmento IS NULL OR @iSegmento = ''    
   BEGIN    
      SELECT 'Codigo'  = -1    
         ,   'Estado'  = 'False'    
         ,   'Mensaje' = 'Cliente debe pertenecer a un Segmento Comercial.'    
         ,   'Segmento'= @iSegmento    
      RETURN    
   END    
    
   -->     Variable para definir Existencia     
   DECLARE @iFound INTEGER    
    
   SET @iFound = -1    
   SET @iFound = (SELECT 1 FROM BacParamSuda.dbo.TBL_CONTROL_THRESHOLD with(nolock)    
                          WHERE Segmento = @iSegmento GROUP BY Segmento )    
    
   IF @iFound = -1    
   BEGIN    
      SELECT 'Codigo'   = @iFound    
         ,   'Estado'   = 'False'    
         ,   'Mensaje'  = 'Debe Parametrizar Tabla de Conrol del Threshold, para el segmento ' + ltrim(rtrim( @GlosaSegmento ))    
         ,   'Segmento' = @iSegmento    
      RETURN    
   END    
    
    
   SET @iFound = -1    
   SET @iFound = (SELECT TOP 1 1 FROM BacParamSuda.dbo.TBL_CONTROL_THRESHOLD with(nolock)    
                                WHERE Segmento = @iSegmento    
                                  AND Modulo   = @Id_Sistema    
                                  AND Producto = @CodProducto    
                                  AND Riesgo   = CASE WHEN @iSegmento = 3 AND @Clasificacion  = 'SC' THEN 'N'    
                                           WHEN @iSegmento = 3 AND @Clasificacion <> 'SC' THEN 'S'    
                                                      ELSE Riesgo    
                                                 END)    
    
   IF @iFound = -1    
   BEGIN    
      SELECT 'Codigo'   = @iFound    
         ,   'Estado'   = 'False'    
         ,   'Mensaje'  = 'No existe tabla de control de Threshold para el segmento ' + ltrim(rtrim( @GlosaSegmento ))    
         ,   'Segmento' = @iSegmento    
      RETURN    
   END    
    
   -->     Valida si puede evaluar los criterios... Si esta fuera del Cuadro Esta Fuera de la Politica.    
   SET @iFound          = -1    
   SET @iFound          = ISNULL((SELECT 1 FROM BacParamSuda.dbo.TBL_CONTROL_THRESHOLD with(nolock)    
                                          WHERE Segmento = @iSegmento    
                                            AND Modulo   = @Id_Sistema    
                                            AND Producto = @CodProducto    
                                            AND Riesgo   = CASE WHEN @iSegmento = 3 AND @Clasificacion  = 'SC' THEN 'N'    
                                                                WHEN @iSegmento = 3 AND @Clasificacion <> 'SC' THEN 'S'    
                                                                ELSE Riesgo    
                                                           END    
                                            AND @nPlazo <= Plazo), -1)    
    
   IF @iFound = -1    
   BEGIN    
      SELECT 'Codigo'   = 0    
       ,   'Estado'   = 'False'    
         ,   'Mensaje'  = 'Fuera de la Politica... Plazo de ' + ltrim(rtrim( @nPlazo )) + ' días se encuentra fuera del rango para el segmento '    
                        + ltrim(rtrim( @GlosaSegmento ))    
         ,   'Segmento' = @iSegmento    
      RETURN    
   END    
    
   SELECT 'Codigo'   = CASE WHEN @iFound = -1 THEN 1                      ELSE @iFound END    
      ,   'Estado'   = CASE WHEN @iFound = -1 THEN 'False'                ELSE 'True'  END    
      ,   'Mensaje'  = CASE WHEN @iFound = -1 THEN 'Fuera de la Politica' ELSE 'Ok'    END    
      ,   'Segmento' = @iSegmento    
       
END    
GO
