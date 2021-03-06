USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGADATOS_RECEPTOR_BENEFICIARIO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGADATOS_RECEPTOR_BENEFICIARIO]
   (   @NumOperacion    NUMERIC(10)
   ,   @RecRutBanco	NUMERIC(10)
   ,   @RecCodBanco	NUMERIC(10)
   ,   @RecCodSwift	VARCHAR(20)
   ,   @RecDireccion	VARCHAR(70)
   ,   @RecCtaCte	VARCHAR(20)
   ,   @cSistema        CHAR(3)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Id_Paquete  NUMERIC(9)
       SET @Id_Paquete  = ISNULL((SELECT Id_Paquete FROM MDLBTR WHERE sistema = @cSistema AND numero_operacion = @NumOperacion AND Estado_Paquete = 'A'),0)

   IF @Id_Paquete > 0
   BEGIN
      UPDATE MDLBTR
         SET RecRutBanco  = @RecRutBanco
         ,   RecCodBanco  = @RecCodBanco
         ,   RecCodSwift  = @RecCodSwift
         ,   RecDireccion = @RecDireccion
         ,   RecCtaCte    = @RecCtaCte
       WHERE Id_Paquete   = @Id_Paquete
   END ELSE
   BEGIN
      UPDATE MDLBTR
        SET  RecRutBanco      = @RecRutBanco
         ,   RecCodBanco      = @RecCodBanco
         ,   RecCodSwift      = @RecCodSwift
         ,   RecDireccion     = @RecDireccion
         ,   RecCtaCte        = @RecCtaCte
      WHERE  numero_operacion = @NumOperacion
   END

END
GO
