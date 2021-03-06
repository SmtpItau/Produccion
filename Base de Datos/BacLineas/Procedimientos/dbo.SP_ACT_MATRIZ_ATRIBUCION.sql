USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_MATRIZ_ATRIBUCION]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


 CREATE PROCEDURE [dbo].[SP_ACT_MATRIZ_ATRIBUCION]  
 (  
  @usuario CHAR(15) ,  
  @monto  NUMERIC(19,04) ,  
  @aprueba_linea INTEGER  ,  
  @aprueba_limite INTEGER  ,  
  @aprueba_tasa INTEGER  ,  
  @aprueba_glb  INTEGER  ,  
  @aprueba_limprecio 	INTEGER		,
  @aprueba_bloqclt	INTEGER
  
 )  
AS  
BEGIN  
	SET NOCOUNT ON
 IF EXISTS( SELECT 1 FROM MATRIZ_ATRIBUCION WHERE usuario = @usuario )  
  UPDATE MATRIZ_ATRIBUCION  
  SET usuario  = @usuario  ,  
   monto  = @monto  ,  
   aprueba_linea = @aprueba_linea ,  
   aprueba_limite = @aprueba_limite ,  
   aprueba_tasa = @aprueba_tasa  ,  
   aprueba_glb = @aprueba_glb  ,  
   aprueba_limprecio = @aprueba_limprecio		,
   aprueba_bloqclt = @aprueba_bloqclt		--- nuevo campo
  WHERE usuario = @usuario  
 ELSE  
  INSERT INTO MATRIZ_ATRIBUCION  
  SELECT @usuario ,  
   @monto  ,  
   @aprueba_linea ,  
   @aprueba_limite ,  
   @aprueba_tasa ,  
   @aprueba_glb,  
   @aprueba_limprecio,
   @aprueba_bloqclt
END
GO
