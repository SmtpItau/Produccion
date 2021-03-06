USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MANTENEDOR_TIPOCONCEPTO_ELIMINA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Mantenedor_TipoConcepto_Elimina    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
CREATE PROCEDURE [dbo].[SP_MANTENEDOR_TIPOCONCEPTO_ELIMINA](
       @codigo  numeric(3),
       @concepto char(50) )
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT 1 FROM FLUJOCAJA_OPERACION WHERE Codigo_Concepto = @Codigo) BEGIN
  DELETE FROM FLUJOCAJA_OPERACION WHERE 
       Codigo_Concepto = @Codigo      
  SELECT 'OK'  
 END
 
 IF EXISTS(SELECT 1 FROM TIPOCONCEPTO_FLUJOCAJA WHERE  codigo_concepto = @codigo) BEGIN
 
  DELETE FROM TIPOCONCEPTO_FLUJOCAJA WHERE 
       codigo_concepto = @codigo and
       concepto   = @concepto
  SELECT 'OK'  
 END
 ELSE BEGIN
  
  SELECT 'ERROR'
 END
 SET NOCOUNT OFF
 
END
GO
