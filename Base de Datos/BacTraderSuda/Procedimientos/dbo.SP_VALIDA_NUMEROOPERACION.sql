USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_NUMEROOPERACION]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_NUMEROOPERACION]
                     (@xTipoComprobante  NUMERIC(02) ,
        @xNumeroOperacion  NUMERIC(10) )
AS
BEGIN
SET NOCOUNT ON
 IF EXISTS(SELECT Numero_Documento FROM GEN_PAGOS_OPERACION WHERE numero_documento = @xNumeroOperacion AND  CONVERT(NUMERIC(02),Forma_Pago) = @xTipoComprobante)
  BEGIN
             SELECT 'SI', 'NUMERO DE COMPROBANTE YA EXISTE'
      SET NOCOUNT OFF
             RETURN
 END ELSE BEGIN
  IF (SELECT Folio_Actual FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xTipoComprobante AND
            Estado = 'A') > @xNumeroOperacion
   BEGIN
              SELECT 'SI', 'NUMERO DE COMPROBANTE YA NO SE PUEDE ESTABLECER'
       SET NOCOUNT OFF
                     RETURN
  END
 END
SELECT 'NO'
SET NOCOUNT OFF
END


GO
