USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_NUMEROCOMPROBANTE]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_NUMEROCOMPROBANTE]
               (@xTipoComprobante NUMERIC(02))
AS
BEGIN
 DECLARE @xNroGenFolio  NUMERIC(10)
 
IF EXISTS(SELECT * FROM BAC_TESORERIA_FOLIOS WHERE Tipo_Documento = @xTipoComprobante AND Estado = 'A') BEGIN
 IF (SELECT Folio_Termino - Folio_Actual FROM BAC_TESORERIA_FOLIOS WHERE 
     Tipo_Documento = @xTipoComprobante AND 
     Estado = 'A') = 0 BEGIN
     UPDATE BAC_TESORERIA_FOLIOS SET Estado = 'N' WHERE tipo_documento = @xTipoComprobante AND Estado = 'A'
 IF EXISTS(SELECT * FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xTipoComprobante AND Estado = '') BEGIN
    SET ROWCOUNT 1
    UPDATE BAC_TESORERIA_FOLIOS SET Estado = 'A' WHERE tipo_documento = @xTipoComprobante AND Estado = ''
    SET ROWCOUNT 0
 END ELSE BEGIN
  SELECT 'NO','NO SE PUEDE ESTABLECER SIGUIENTE NUMERO DE COMPROBANTE'
  RETURN 
 END
 END
 SELECT @xNroGenFolio = Folio_Actual FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xTipoComprobante AND Estado = 'A'
END ELSE BEGIN
 IF EXISTS(SELECT * FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xTipoComprobante AND Estado = '') BEGIN
    SET ROWCOUNT 1
    UPDATE BAC_TESORERIA_FOLIOS SET Estado = 'A' WHERE tipo_documento = @xTipoComprobante AND Estado = ''
    SET ROWCOUNT 0
    SELECT @xNroGenFolio = Folio_Actual FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xTipoComprobante AND Estado = 'A'  
 END ELSE BEGIN
  SELECT 'NO','NO SE PUEDE ESTABLECER SIGUIENTE NUMERO DE COMPROBANTE'
  RETURN
 END
END
 SELECT 'SI',@xNroGenFolio
END

GO
