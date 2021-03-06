USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIBERAOPERACIONGTIA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIBERAOPERACIONGTIA]
   (   @codSistema     CHAR(3)
   ,   @numOperacion   NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_Registro_Garantias WHERE Sistema = @codSistema AND OperacionSistema = @numOperacion)
   BEGIN

      BEGIN TRANSACTION

      IF EXISTS(SELECT 1 FROM Bacparamsuda..tbl_Garantias_Faltantes WHERE NumGarantia IN(SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias
		                                                                                               WHERE Sistema = @codSistema AND OperacionSistema = @numOperacion))
      BEGIN
         DELETE Bacparamsuda..tbl_Garantias_Faltantes
          WHERE NumGarantia IN (SELECT NumeroOperacion FROM Bacparamsuda..tbl_registro_garantias
			                              WHERE Sistema        = @codSistema
			                                AND OperacionSistema = @numOperacion)

         IF @@ERROR <> 0
         BEGIN
            ROLLBACK TRANSACTION
            RETURN
         END
      END

      DELETE Bacparamsuda..tbl_Registro_Garantias
       WHERE Sistema        = @codSistema
	 AND OperacionSistema = @numOperacion

      IF @@ERROR <> 0
      BEGIN
         ROLLBACK TRANSACTION
         RETURN
      END

      COMMIT TRANSACTION

   END

   SET NOCOUNT OFF

END
GO
