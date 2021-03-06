USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_RELACION_CLIENTE]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[SP_ELIMINA_RELACION_CLIENTE]  
   (   @rut1      NUMERIC(10)   
   ,   @codigo1   NUMERIC( 3)   
   ,   @rut2      NUMERIC(10)   
   ,   @codigo2   NUMERIC( 3)   
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @fechaProc DATETIME  
	DECLARE @nTotOcupadoPadre AS NUMERIC(19,4)
	DECLARE @nTotOcupadoHijo AS NUMERIC (19,4)

	SET @nTotOcupadoPadre	= 0
	SET @nTotOcupadoHijo	= 0
   
   SELECT  @fechaProc = acfecproc   
   FROM    VIEW_MDAC  
  
	SET @nTotOcupadoPadre	= (SELECT TotalOcupado FROM LINEA_GENERAL WHERE Rut_Cliente = @rut1 and Codigo_Cliente =  @codigo1)
	SET @nTotOcupadoHijo	= (SELECT TotalOcupado FROM LINEA_GENERAL WHERE Rut_Cliente = @rut2 and Codigo_Cliente =  @codigo2)
	
	--IF @nTotOcupadoPadre = 0 AND @nTotOcupadoHijo = 0
	IF  @nTotOcupadoHijo = 0
   BEGIN    
      DELETE CLIENTE_RELACIONADO  
      WHERE @rut1  = clrut_padre  
      AND   @codigo1  = clcodigo_padre  
      AND   @rut2  = clrut_hijo  
      AND   @codigo2  = clcodigo_hijo  
  
      SELECT 'OK'  
		
   END ELSE  
   BEGIN  
      SELECT  'NO'  
   END  
  END
GO
