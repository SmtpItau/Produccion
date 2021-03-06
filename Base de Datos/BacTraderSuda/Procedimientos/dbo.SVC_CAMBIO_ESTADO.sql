USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_CAMBIO_ESTADO]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_CAMBIO_ESTADO]
   (   @Marca          CHAR(1)     = ''
   ,   @Usuario        VARCHAR(15) = ''
   ,   @Estado         CHAR(1)     = 'P'
   ,   @Documento      NUMERIC(9)
   ,   @Correlativo    NUMERIC(9)
   ,   @NumInterfaz    NUMERIC(9)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @Marca = 'D'
   BEGIN
      UPDATE OP_ENVIADAS_DCV
      SET    madurez   = @Estado
      WHERE  monumdocu = @Documento
      AND    correla   = @Correlativo

      RETURN
   END

   IF @Marca = 'S' OR @Marca = 'N'
   BEGIN
      UPDATE OP_ENVIADAS_DCV 
      SET    Marcado   = @Marca
      ,      Usuario   = CASE WHEN @Marca = 'S' THEN @Usuario ELSE '' END
      WHERE  monumdocu = @Documento
      AND    correla   = @Correlativo
   END ELSE
   BEGIN
      UPDATE OP_ENVIADAS_DCV 
      SET    Estado      = CASE WHEN Estado = 'P' THEN 'E'
                                WHEN Estado = 'E' THEN 'R'
                                WHEN Estado = 'R' THEN 'R'
                                ELSE                   @Estado
                           END
      ,      NumInterfaz = @NumInterfaz
      ,      Marcado     = 'N'
      ,      UsuarioEnv  = @Usuario
      ,      Usuario     = ''
      WHERE  monumdocu   = @Documento
      AND    correla     = @Correlativo

      INSERT INTO OP_ENVIADAS_DCV_HISTORICO
      SELECT CONVERT(CHAR(10),GETDATE(),112)
      ,      CONVERT(CHAR(10),GETDATE(),108)
      ,      O.*
      FROM   OP_ENVIADAS_DCV O
      WHERE  O.monumdocu   = @Documento
      AND    O.correla     = @Correlativo

   END
END



GO
