USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_FOLIO_INICIO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_FOLIO_INICIO]
               ( @xTipoDocumento  NUMERIC(2) ,
   @xFolioInicio  NUMERIC(19) )
AS
BEGIN
SET NOCOUNT ON
 IF (SELECT Folio_Termino FROM BAC_TESORERIA_FOLIOS WHERE tipo_documento = @xTipoDocumento
  AND Estado = 'A'   ) >= @xFolioInicio BEGIN
  SELECT 'SI', 'NO SE PUEDE ESTABLECER UN COMPROBANTE MENOR A LOS INGRESADOS ANTERIORMENTE'
                SET NOCOUNT OFF
  RETURN
 END
SELECT 'NO'
SET NOCOUNT OFF
END


GO
