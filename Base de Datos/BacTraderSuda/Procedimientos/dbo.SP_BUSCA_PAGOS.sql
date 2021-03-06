USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PAGOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_PAGOS]
                                   (@Nnumoper  INTEGER)
AS
-- Autor		: MIRIAM MORENO
-- Objetivo		: Verificar si quedan FLI sin liberar
-- Fecha de Creacion	: 02-03-2004
-- Modificaciones	:
-- Primera Modificacion	: 02-03-2004
-- Segunda Modificacion	: 02-03-2004
-- Antecedentes Generales : 
BEGIN

  SET NOCOUNT ON

 DECLARE @SiNo   CHAR(3)

   IF NOT EXISTS(SELECT 1 FROM PAGOS_FLI WHERE PANUMOPER = @Nnumoper and (PASTATUS = 'A' OR PASTATUS = 'P') AND PAPTIPOPAGO = 'P')
   BEGIN
      SELECT -1,''
      RETURN
   END ELSE      
   BEGIN
      SELECT 1, 'Esta Operación ya tiene pagos asociados no se puede modificar ni Anular'
      RETURN
   END

   SET NOCOUNT OFF

END


GO
