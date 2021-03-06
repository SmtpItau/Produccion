USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_AYUDACLIENTE_NOBANCOS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_AYUDACLIENTE_NOBANCOS]  
   (   @nRutcli   NUMERIC(9,0)  
	, @nCodigo   NUMERIC(9,0)  
	, @nSw			NUMERIC (1,0)
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @MtoLineaThresHold   NUMERIC(19,4)  
       SET @MtoLineaThresHold   = isnull((SELECT isnull(Monto_Linea_Threshold ,0)  
                                     FROM LINEA_GENERAL  
                             WHERE rut_cliente = @nrutcli   
                                             AND codigo_cliente=@ncodigo), 0)  
  
	IF EXISTS(SELECT 1 FROM CLIENTE_RELACIONADO WHERE (@nRutcli = clrut_hijo  AND @nCodigo = clcodigo_hijo and @nSw = 0)) 
   BEGIN  
      SELECT	'SI'  
			, 'nombre' = (SELECT Clnombre FROM VIEW_CLIENTE WHERE clrut = clrut_padre AND clcodigo = clcodigo_padre)  
         	, 'clcodigo_padre' = clcodigo_padre  
			, 'AfectaLinea' = (SELECT Afecta_Lineas_Hijo FROM CLIENTE_RELACIONADO WHERE @nRutcli = clrut_hijo AND @nCodigo = clcodigo_hijo)
      FROM   CLIENTE_RELACIONADO  
      WHERE  clrut_hijo     = @nRutcli  
      AND    clcodigo_hijo  = @nCodigo  
  
   END ELSE  
   BEGIN  
      SELECT 'RUT' = STR(clrut) + '-' + cldv  
         ,   'clcodigo'   =  clcodigo  
         ,   'clnombre'          = clnombre  
         ,   'clrut'   = STR(clrut)  
         ,   'cldv'   = cldv  
      ,      'Existe' = 'N'  
         ,   'mtoThreshold'  = @MtoLineaThresHold  
      FROM   bacparamsuda..CLIENTE
      WHERE  cltipcli <> 1  
      AND    clrut    = @nRutcli  
      AND    clcodigo = @nCodigo  
   END  
  
END  
GO
