USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_ASOCIASION_DERIVADOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_ASOCIASION_DERIVADOS]
   (   @Numero_Credito   NUMERIC(9)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound              INTEGER
   DECLARE @Numero_Derivado     INTEGER
   DECLARE @Modulo_Derivado     CHAR(3)


         SET  @iFound              = -1
      SELECT  @iFound              = 1
      ,       @Numero_Derivado     = Numero_Derivado
      ,       @Modulo_Derivado     = Modulo_Derivado
      FROM    BacParamSuda.dbo.RELACION_CREDITO_DERIVADO
      WHERE   Numero_Credito       = @Numero_Credito

      IF @iFound = 1
      BEGIN
         SELECT -1, 'Crédito tiene asociado el Derivado N° : ' + LTRIM(RTRIM( @Numero_Derivado )) 
                                                + ' Origen : ' + CASE WHEN @Modulo_Derivado = 'BFW' THEN 'FORWARD' ELSE 'SWAP' END
                  ,  Derivado = @Numero_Derivado
         RETURN -1
      END ELSE
      BEGIN
         SELECT @Numero_Derivado
         RETURN
      END

END
GO
