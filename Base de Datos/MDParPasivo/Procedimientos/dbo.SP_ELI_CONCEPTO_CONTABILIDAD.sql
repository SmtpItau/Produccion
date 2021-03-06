USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_CONCEPTO_CONTABILIDAD]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELI_CONCEPTO_CONTABILIDAD]
               ( @icodigo_concepto   CHAR(05)
               )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy


   IF EXISTS (SELECT 1 FROM PERFIL_CONTABILIDAD WHERE codigo_contable = @icodigo_concepto )
   BEGIN

      SELECT 'RELACIONADO'
      RETURN      

   END


   DELETE FROM CONCEPTO_CONTABILIDAD
         WHERE codigo_contable = @icodigo_concepto


   SET NOCOUNT OFF

END

GO
