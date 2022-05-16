USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mantenedor_TipoConcepto_Graba]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Mantenedor_TipoConcepto_Graba    fecha de la secuencia de comandos: 03/04/2001 15:18:08 ******/
CREATE PROCEDURE [dbo].[Sp_Mantenedor_TipoConcepto_Graba](
       @codigo  numeric(3),
       @concepto char(50) )
AS
BEGIN
 SET NOCOUNT ON
 IF NOT EXISTS(SELECT 1 FROM TIPOCONCEPTO_FLUJOCAJA WHERE  codigo_concepto = @codigo) BEGIN
  
  INSERT INTO TIPOCONCEPTO_FLUJOCAJA VALUES(
        @codigo,
        @concepto )
  SELECT "INSERTA"
 
 END
 ELSE BEGIN
  
  UPDATE TIPOCONCEPTO_FLUJOCAJA SET 
       codigo_concepto = @codigo,
       concepto = @concepto
     FROM   TIPOCONCEPTO_FLUJOCAJA
     WHERE  codigo_concepto = @codigo
 
  SELECT "MODIFICA"
 END
 SET NOCOUNT OFF
END
       
        






GO
