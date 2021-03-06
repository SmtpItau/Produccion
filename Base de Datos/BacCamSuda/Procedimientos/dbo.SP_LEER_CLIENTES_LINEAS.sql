USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTES_LINEAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_CLIENTES_LINEAS]      
   (       
           @iRutCliente NUMERIC(9)  = 0       
    )    
AS      
BEGIN      
      
   SET NOCOUNT ON      
      
   DECLARE @dFecha   DATETIME      
       SET @dFecha   = (SELECT acfecpro FROM BacCamSuda.dbo.MEAC with(nolock))      
      
   CREATE TABLE #MisClientes      
   (   Rut      NUMERIC(9)      
   ,   Codigo   INTEGER      
   ,   Nombre   VARCHAR(100) NOT NULL DEFAULT('')      
   )      
      
   CREATE INDEX #ix_MisClientes ON #MisClientes (Nombre)      
     
   IF @iRutCliente <> 0      
      INSERT INTO #MISCLIENTES (Rut, Codigo, Nombre)     
       SELECT clrut, clcodigo, clnombre FROM BacParamSuda.dbo.CLIENTE WHERE clrut = @iRutCliente      
   INSERT INTO #MISCLIENTES (Rut, codigo, nombre)    
   SELECT DISTINCT MORUTCLI, MOCODCLI, MONOMCLI    
     FROM BacCamSuda..MEMOH         
    WHERE movaluta2 >= @dFecha  
   AND   (MORUTCLI       = @iRutCliente OR @iRutCliente = 0)          
   /* No se pueden usar las lineas retenidas  
      debido a que podrían haber clientes  
      que no están retenidos ahora y podrían  
      estar hoy por operaciones de ayer o de hoy  
   */   
  
  
   UNION      
      
    SELECT DISTINCT morutcli, mocodcli, clnombre    
     FROM BacCamSuda.dbo.MEMO      
   INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = morutcli and clcodigo = mocodcli    
    WHERE motipope = 'C'      
   AND   (morutcli          = @iRutCliente OR @iRutCliente = 0)      
      
   UNION      
      
     SELECT DISTINCT morutcli, mocodcli, clnombre    
     FROM BacCamSuda.dbo.MEMO      
   INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = morutcli and clcodigo = mocodcli    
    WHERE motipope   = 'V'      
      AND movaluta2 <> movaluta1      
      AND movaluta2  > movaluta1      
   AND   (morutcli          = @iRutCliente OR @iRutCliente = 0)      
      
   -- PROD-13828   
   -- No se integrará a los Padres ni a los hijos  
   -- solo a clientes que han operado directo.  
   -- Por ejemplo si hay una familia de hijos todos con   
   -- rut distintos al padre cada hijo imputará sobre  
   -- su padre y si el padre imputa al final como   
   -- no tiene operaciones limpiará las lineas.  
   /*  
 INSERT INTO #MISCLIENTES    
 SELECT DISTINCT clrut_hijo, clcodigo_hijo, clnombre    
   FROM BacLineas.dbo.CLIENTE_RELACIONADO     
        INNER JOIN #MISCLIENTES      ON clrut_Padre = Rut AND clcodigo_Padre = codigo    
        INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = clrut_Hijo and clcodigo = clcodigo_Hijo    
    
 INSERT INTO #MISCLIENTES    
 SELECT DISTINCT clrut_Padre, clcodigo_Padre, clnombre    
   FROM BacLineas.dbo.CLIENTE_RELACIONADO     
        INNER JOIN #MISCLIENTES      ON clrut_Hijo = Rut AND clcodigo_Hijo = codigo    
        INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = clrut_Padre and clcodigo = clcodigo_Padre    
    */  
    
    
/*    
   UPDATE #MisClientes      
      SET Nombre   = clnombre,      
   Codigo   = clcodigo      
     FROM BacParamSuda..CLIENTE with(nolock)      
    WHERE clrut    = Rut      
      AND clcodigo = 1      
*/    
      
 /*    
   UPDATE  BacLineas.dbo.LINEA_SISTEMA     
   SET    TotalOcupado    = 0    
   ,    TotalExceso     = 0    
   ,    TotalDisponible = TotalAsignado    
     FROM #MisClientes       
   WHERE   id_sistema      = 'BCC'    
   and     rut_cliente     = @nRutCliente    
      
   UPDATE  BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO    
   SET    TotalOcupado    = 0    
   ,    TotalExceso     = 0    
   ,    TotalDisponible = TotalAsignado    
   WHERE   id_sistema      = 'BCC'    
   and     rut_cliente     = @nRutCliente    
 */    
      
   SELECT DISTINCT Rut, Codigo, Nombre    
     FROM #MisClientes     
 ORDER BY Nombre    
END    
GO
