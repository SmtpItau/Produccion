USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABATABLA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABATABLA]
   (   @tbcateg    NUMERIC(5)
   ,   @tbcodigo1  CHAR(6)
   ,   @tbtasa     NUMERIC(3)
   ,   @tbfecha    DATETIME
   ,   @tbvalor    NUMERIC(18,6)
   ,   @tbglosa    CHAR(50)
   ,   @nemo       CHAR(10)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS(SELECT 1 FROM TABLA_GENERAL_DETALLE WHERE tbcateg = @tbcateg AND tbcodigo1 = @tbcodigo1)
   BEGIN

      UPDATE TABLA_GENERAL_DETALLE
      SET    tbtasa     = @tbtasa
      ,      tbfecha    = @tbfecha
      ,      tbvalor    = @tbvalor
      ,      tbglosa    = @tbglosa
      ,      nemo       = @nemo
      WHERE  tbcateg    = @tbcateg
      AND    tbcodigo1  = @tbcodigo1

   END ELSE
   BEGIN

      INSERT INTO TABLA_GENERAL_DETALLE
      (   tbcateg
      ,   tbcodigo1
      ,   tbtasa
      ,   tbfecha
      ,   tbvalor
      ,   tbglosa
      ,   nemo
      )
      VALUES
      (   @tbcateg
      ,   @tbcodigo1
      ,   @tbtasa
      ,   @tbfecha
      ,   @tbvalor
      ,   @tbglosa
      ,   @nemo
      )
   END

END

GO
