USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_PERFIL_VARIABLE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRA_PERFIL_VARIABLE]
   (   @idsistema   CHAR(3)
   ,   @usuario     CHAR(20)
   ,   @fila        NUMERIC(10)
   ,   @FolioPerfil NUMERIC(10) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @fila = -2
   BEGIN
      DELETE PASO_CNT
      WHERE  id_sistema  = @idsistema 
      AND    usuario     = @usuario
      AND    perfil      = @FolioPerfil

      SELECT 'OK'
      RETURN
   END

   IF @fila = -1
   BEGIN
      DELETE  PASO_CNT
      WHERE   id_sistema  = @idsistema 
      AND     usuario     = @usuario
   END ELSE
   BEGIN
      DELETE PASO_CNT 
      WHERE fila          = @fila
      AND   id_sistema    = @idsistema
      AND   usuario       = @usuario
      AND   perfil        = @FolioPerfil
   END

   IF @@ERROR <> 0
   BEGIN
      PRINT  'FALLA BORRANDO BAC_CNT_PASO.'
      SELECT 'OK'
   END

   SELECT 'OK'

END

GO
