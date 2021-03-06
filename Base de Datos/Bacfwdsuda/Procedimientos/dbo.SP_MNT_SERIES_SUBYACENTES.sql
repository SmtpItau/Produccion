USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_SERIES_SUBYACENTES]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_SERIES_SUBYACENTES]
   (   @Tag     INT
   ,   @Serie   VARCHAR(20)
   ,   @Codigo  INT
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @Tag = 1 --> Buscar
   BEGIN
      SELECT Codigo 
      ,      Serie
      FROM   INSTRUMENTOS_SUBYACENTES 
      WHERE (Serie = @Serie or @Serie = '')
   END

   IF @Tag = 2 --> Grabar
   BEGIN
      IF EXISTS(SELECT 1 FROM INSTRUMENTOS_SUBYACENTES WHERE Codigo = @Codigo AND Serie = @Serie)
      BEGIN
         DELETE INSTRUMENTOS_SUBYACENTES 
         WHERE  Codigo = @Codigo 
         AND    Serie  = @Serie
      END

      INSERT INTO INSTRUMENTOS_SUBYACENTES 
      SELECT secodigo , seserie
      FROM   BacParamSuda..SERIE
      WHERE  seserie = @Serie
   END

   IF @Tag = 3 --> Delete
   BEGIN
      DELETE INSTRUMENTOS_SUBYACENTES 
      WHERE  Codigo = @Codigo 
      AND    Serie  = @Serie
   END

END

GO
