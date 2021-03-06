USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_NEW_GRUPO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GENERA_NEW_GRUPO]
   (   @iTag       INTEGER
   ,   @Id         NUMERIC(9) = 0
   ,   @Modulo     CHAR(3)    = ''
   ,   @Contrato   NUMERIC(9) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 0
   BEGIN
      SELECT RegDisponible = ISNULL( MAX( IdGrupo ), 0) + 1 
        FROM TBL_ARCHIVOS_DCV
   END

   IF @iTag = 1
   BEGIN
      UPDATE TBL_ARCHIVOS_DCV 
         SET IdGrupo  = @Id
       WHERE Modulo   = @Modulo
         AND Contrato = @Contrato
   END

END

GO
