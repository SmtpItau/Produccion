USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTES_LINEAS_BFW]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LEER_CLIENTES_LINEAS_BFW]    
   (   @iRutCliente   NUMERIC(10)   = 0       
   ,   @iCodCliente   INT			= 0
   )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   CREATE TABLE #TMP_LINEAS_BFW_CLI    
   (   Rut           NUMERIC(10)    
   ,   Codigo			INT
   ,   Nombre        VARCHAR(70)    
   ,   MetodologiaLCR	INT 
   ,   Puntero			INT Identity(1,1)
   )  

   CREATE TABLE #TMP_LINEAS_BFW_CLI_AUX  
   (   Rut				NUMERIC(10)  
   ,   Codigo			INT
   ,   Nombre			VARCHAR(70) 
   ,   MetodologiaLCR	INT 
   ,   Puntero			INT Identity(1,1)
   )    
    
   IF @iRutCliente > 0  
   BEGIN  
  
   INSERT INTO #TMP_LINEAS_BFW_CLI     
      SELECT	clrut
      ,			clcodigo
      ,			substring( clnombre, 1, 70)
      ,			'MetodologiaLCR' = ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1)	
      FROM		BacParamSuda.dbo.CLIENTE 
      WHERE		clrut = @iRutCliente
    
      INSERT INTO #TMP_LINEAS_BFW_CLI  
      SELECT	clrut
      ,			clcodigo
      ,			substring( clnombre, 1, 70)
      ,			'MetodologiaLCR' = ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1)	

      FROM   BacLineas.dbo.CLIENTE_RELACIONADO  
             INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = clrut_hijo and clcodigo = clcodigo_hijo  
      WHERE  (clrut_padre = @iRutCliente)  
    
      UNION  
    
      SELECT	clrut
      ,			clcodigo
      ,			substring( clnombre, 1, 70)
      ,			'MetodologiaLCR' = ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1)	

      FROM   BacLineas.dbo.CLIENTE_RELACIONADO  
             INNER JOIN BacParamSuda.dbo.CLIENTE  ON clrut = clrut_padre and clcodigo = clcodigo_padre  
      WHERE (clrut_hijo = @iRutCliente)  
    
      UPDATE BacLineas.dbo.LINEA_SISTEMA   
      SET    TotalOcupado    = 0    
      ,      TotalExceso     = 0    
      ,      TotalDisponible = TotalAsignado    
      FROM   #TMP_LINEAS_BFW_CLI  
      WHERE  Rut_Cliente     = #TMP_LINEAS_BFW_CLI.Rut  
      AND    Codigo_Cliente  = #TMP_LINEAS_BFW_CLI.Codigo  
      AND    id_sistema      = 'BFW'  
    
      UPDATE BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
      SET    TotalOcupado    = 0    
      ,      TotalExceso     = 0    
      ,      TotalDisponible = TotalAsignado    
      FROM   #TMP_LINEAS_BFW_CLI  
      WHERE  Rut_Cliente     = #TMP_LINEAS_BFW_CLI.Rut  
      AND    Codigo_Cliente  = #TMP_LINEAS_BFW_CLI.Codigo  
      AND    id_sistema      = 'BFW'  
    
   END ELSE    
   BEGIN    
    
      SELECT DISTINCT rut    = clrut  
                    , codigo = clcodigo  
                    , Nombre = substring( clnombre, 1, 70)  
                    , 'MetodologiaLCR' = ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1)	
 
      INTO   #TMP_CLIENTES  
      FROM   BacFwdSuda.dbo.MFCA  
             INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = cacodigo and clcodigo = cacodcli  
    
      INSERT INTO #TMP_CLIENTES  
      SELECT	clrut
      ,			clcodigo
      ,			substring( clnombre, 1, 70)
      ,			'MetodologiaLCR' = ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1)	

      FROM   BacLineas.dbo.CLIENTE_RELACIONADO   
             INNER JOIN #TMP_CLIENTES            ON rut   = clrut_padre and codigo   = clcodigo_padre  
             INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = clrut_hijo  and clcodigo = clcodigo_hijo  
  
      INSERT INTO #TMP_CLIENTES  
      SELECT	clrut
      ,		clcodigo
      ,		substring( clnombre, 1, 70)
      ,		'MetodologiaLCR' = ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1)	

      FROM   BacLineas.dbo.CLIENTE_RELACIONADO   
             INNER JOIN #TMP_CLIENTES            ON rut   = clrut_hijo  and codigo   = clcodigo_hijo  
             INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = clrut_padre and clcodigo = clcodigo_padre  
    
         INSERT INTO #TMP_LINEAS_BFW_CLI    
         (   Rut  
         ,   Codigo  
         ,   Nombre  
      ,	  MetodologiaLCR
         )  
      SELECT DISTINCT rut  
                  ,   codigo  
                  ,   Nombre  
                  ,   MetodologiaLCR
      FROM   #TMP_CLIENTES  
    
      UPDATE BacLineas.dbo.LINEA_SISTEMA   
      SET    TotalOcupado    = 0    
      ,      TotalExceso     = 0    
      ,      TotalDisponible = TotalAsignado    
      WHERE  id_sistema      = 'BFW'  
    
      UPDATE BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
      SET    TotalOcupado    = 0    
      ,      TotalExceso     = 0    
      ,      TotalDisponible = TotalAsignado    
      WHERE  id_sistema      = 'BFW'  
  
   END    
    
--   SELECT	Rut
--   ,		codigo
--   ,		Nombre
--   ,		Puntero 
--   FROM		#TMP_LINEAS_BFW_CLI 
--   WHERE	MetodologiaLCR NOT IN(2,3,5)
--   ORDER BY Puntero  
  
   INSERT INTO #TMP_LINEAS_BFW_CLI_AUX
   SELECT	Rut
   ,		codigo
   ,		Nombre
   ,		MetodologiaLCR 
   FROM		#TMP_LINEAS_BFW_CLI 
   WHERE	MetodologiaLCR NOT IN(2,3,5)
   ORDER BY Puntero  

   SELECT	Rut
   ,		codigo
   ,		Nombre
   ,		Puntero 
   FROM		#TMP_LINEAS_BFW_CLI_AUX 
   WHERE	MetodologiaLCR NOT IN(2,3,5)
   ORDER BY Puntero  

    
END  
GO
