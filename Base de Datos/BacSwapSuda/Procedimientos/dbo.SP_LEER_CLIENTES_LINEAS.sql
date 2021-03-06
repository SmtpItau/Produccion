USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTES_LINEAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_CLIENTES_LINEAS]    
   (   @iRutCliente   NUMERIC(10)   = 0       
   ,   @iCodCliente   INT	    = 0  
   )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   CREATE TABLE #TMP_LINEAS_SWAP_CLI  
   (   Rut           NUMERIC(10)  
   ,   Codigo			INT
   ,   Nombre        VARCHAR(250)  
   ,   MetodologiaLCR	INT
   ,   Puntero			INT Identity(1,1)
   )

	CREATE TABLE #TMP_LINEAS_SWAP_CLI_AUX
   (   Rut				NUMERIC(10)
   ,   Codigo			INT
   ,   Nombre			VARCHAR(250)
   ,   MetodologiaLCR	INT
   ,   Puntero			INT Identity(1,1)
   )  
  
   CREATE INDEX #ix_Puntero ON #TMP_LINEAS_SWAP_CLI (Puntero)  
  
  IF @iRutCliente > 0  
   BEGIN  
    
      INSERT INTO #TMP_LINEAS_SWAP_CLI  
      SELECT clrut, clcodigo, substring( clnombre, 1, 70)  
        FROM BacParamSuda.dbo.CLIENTE WHERE clrut = @iRutCliente  
   
      INSERT INTO #TMP_LINEAS_SWAP_CLI  
      SELECT clrut, clcodigo, substring( clnombre, 1, 70)  
      FROM   BacLineas.dbo.CLIENTE_RELACIONADO  
             INNER JOIN BacParamSuda.dbo.CLIENTE ON clrut = clrut_hijo and clcodigo = clcodigo_hijo  
      WHERE  (clrut_padre = @iRutCliente)  
  
      UNION  
  
      SELECT clrut, clcodigo, substring( clnombre, 1, 70)  
      FROM   BacLineas.dbo.CLIENTE_RELACIONADO  
             INNER JOIN BacParamSuda.dbo.CLIENTE  ON clrut = clrut_padre and clcodigo = clcodigo_padre  
      WHERE (clrut_hijo = @iRutCliente)  
  
 END ELSE  
 BEGIN  
   INSERT INTO #TMP_LINEAS_SWAP_CLI  
   SELECT DISTINCT    
          'Rut'          = rut_cliente    
   ,      'Codigo'       = codigo_cliente    
   ,      'Nombre'       = clnombre    
   ,	  'MetodologiaLCR'	=	ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1)
 
   FROM   CARTERA        with (nolock)    
          INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = rut_cliente and clcodigo = codigo_cliente    
   WHERE (compra_capital > 0 AND compra_moneda  > 0)  
   AND   (rut_cliente    = @iRutCliente   
   AND    codigo_cliente = @iCodCliente   
       OR @iRutCliente   = 0   
      AND @iCodCliente   = 0)  
   AND    cltipcli      <> 6     
   ORDER BY clnombre  
    
   INSERT INTO #TMP_LINEAS_SWAP_CLI  
   SELECT DISTINCT    
          'Rut'          = rut_cliente    
   ,      'Codigo'       = codigo_cliente    
   ,      'Nombre'       = clnombre    
   ,	  'MetodologiaLCR'	=	ISNULL(BacLineas.dbo.FN_RIEFIN_METODO_LCR( Clrut, Clcodigo, Clrut, Clcodigo ),1)
 
   FROM   CARTERA        with (nolock)    
          INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = rut_cliente and clcodigo = codigo_cliente    
   WHERE (compra_capital > 0 AND compra_moneda  > 0)  
   AND   (rut_cliente    = @iRutCliente   
       OR @iRutCliente   = 0)  
   AND    cltipcli       = 6     
   ORDER BY clnombre  
END  
--   SELECT	Rut
--   ,		codigo
--   ,		Nombre
--   ,		Puntero
--   FROM		#TMP_LINEAS_SWAP_CLI
--   WHERE	MetodologiaLCR NOT IN(2,3,5) 
--   ORDER BY Puntero

   INSERT INTO #TMP_LINEAS_SWAP_CLI_AUX
   SELECT	Rut
   ,		codigo
   ,		Nombre
   ,		MetodologiaLCR
   FROM		#TMP_LINEAS_SWAP_CLI
   WHERE	MetodologiaLCR NOT IN(2,3,5) 
   ORDER BY Puntero

   SELECT	Rut
   ,		codigo
   ,		Nombre
   ,		Puntero
   FROM		#TMP_LINEAS_SWAP_CLI_AUX
   WHERE	MetodologiaLCR NOT IN(2,3,5) 
   ORDER BY Puntero
   
   DROP TABLE #TMP_LINEAS_SWAP_CLI
   DROP TABLE #TMP_LINEAS_SWAP_CLI_AUX
  
   UPDATE SWAPGENERAL  
      SET tasamtm = 0  
    
END
GO
