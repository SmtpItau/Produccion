USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PrevHabil]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_PrevHabil]
         (   @dfecha    DATETIME
         ,   @nPlaza    NUMERIC(3)
         ,   @dfechasal DATETIME OUTPUT
         )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   DECLARE @iFlag	INTEGER

   SELECT @dfechasal = DATEADD(DAY,-1,@dfecha)

   WHILE (1 = 1)
   BEGIN

      EXECUTE Sp_FechaHabil @dfechasal, @nPlaza, @iFlag OUTPUT

      IF @iFlag = 0
      BEGIN

         BREAK

      END
      SELECT @dfechasal = DATEADD(DAY,-1,@dfechasal)
   END

END



GO
