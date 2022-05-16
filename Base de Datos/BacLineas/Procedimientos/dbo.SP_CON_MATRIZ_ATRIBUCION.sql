USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_MATRIZ_ATRIBUCION]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
  
CREATE PROCEDURE [dbo].[SP_CON_MATRIZ_ATRIBUCION]  
 (  
  @usuario CHAR(15)  
 )  
AS  
BEGIN  
  
 SELECT usuario  ,  
  monto  ,  
  aprueba_linea ,  
  aprueba_limite ,  
  aprueba_tasa ,  
  aprueba_glb,  
  aprueba_limprecio,
  aprueba_bloqclt		--- nuevo campo
 FROM MATRIZ_ATRIBUCION  
 WHERE usuario = @usuario  
  
END  
GO
