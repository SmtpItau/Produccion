USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_DISCREPANCIAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_DISCREPANCIAS]
   (   @MiTag         CHAR(1)
   ,   @Codigo        NUMERIC(9)   = 0
   ,   @Descripcion   VARCHAR(100) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @MiTag = 'C'
   BEGIN
      SELECT Codigo , Descripcion
         FROM DISCREPANCIAS

      RETURN
   END

   IF @MiTag = 'E'
   BEGIN
      DELETE 
         FROM DISCREPANCIAS

      SELECT 0 , 'Eliminación sin problemas.' , @Codigo
      RETURN
   END

   IF @MiTag = 'G'
   BEGIN
      IF EXISTS( SELECT 1 FROM DISCREPANCIAS WHERE codigo = @Codigo)
      BEGIN
         SELECT -1 , 'Existe un código repetido en la lista, se debe cambiar.', @Codigo
         RETURN
      END ELSE
      BEGIN
         INSERT INTO DISCREPANCIAS
         SELECT @Codigo , @Descripcion

         SELECT 0 , 'Grabación sin problemas del registro.' , @Codigo
      END
   END

END

GO
