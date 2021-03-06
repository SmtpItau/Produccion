USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPERACIONES_GRUPO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_OPERACIONES_GRUPO]
   (   @nIdGrupo   NUMERIC(9)   
   ,   @cChange    CHAR(1)   = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @cChange = ''
      SELECT Modulo, Contrato 
        FROM TBL_ARCHIVOS_DCV with(nolock) WHERE IdGrupo = @nIdGrupo

   IF @cChange = 'S'
      UPDATE TBL_ARCHIVOS_DCV SET Estado = 'E' WHERE IdGrupo = @nIdGrupo

END

GO
