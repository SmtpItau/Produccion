USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_EJECUTIVOS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_EJECUTIVOS]
   (   @iTag      INTEGER
   ,   @nCodigo   NUMERIC(9)  = 0
   ,   @cNombre   VARCHAR(40) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 1
   BEGIN
      SELECT Codigo, Nombre
      FROM   TBL_EJECUTIVOS with(nolock)
      WHERE  Estado = 'VIGENTE'
      ORDER BY Nombre
   END

   IF @iTag = 2
   BEGIN
      DECLARE @nCodEjecutivo  NUMERIC(9)
          SET @nCodEjecutivo  = (SELECT MAX(Codigo) FROM TBL_EJECUTIVOS with(nolock) )
          SET @nCodEjecutivo  = @nCodEjecutivo + 1

      INSERT INTO TBL_EJECUTIVOS
      SELECT @nCodEjecutivo, ' ', 'CREACION'

      SELECT Codigo = @nCodEjecutivo
   END

   IF @iTag = 3
   BEGIN
      IF (SELECT Estado FROM TBL_EJECUTIVOS WHERE Codigo = @nCodigo) = 'ELIMINADO'
      BEGIN
         DELETE FROM TBL_EJECUTIVOS
               WHERE Codigo = @nCodigo
      END ELSE
      BEGIN
         UPDATE TBL_EJECUTIVOS
            SET Nombre = @cNombre
            ,   Estado = 'VIGENTE'
          WHERE Codigo = @nCodigo
      END
   END

   IF @iTag = 4
   BEGIN
      DELETE FROM TBL_EJECUTIVOS
            WHERE Estado IN('CREACION', 'ELIMINADO')
   END

   IF @iTag = 5
   BEGIN

      DECLARE @nCliente   VARCHAR(50)
          SET @nCliente   = ''
          SET @nCliente   = isnull((SELECT TOP 1 clnombre FROM BacParamSuda.dbo.CLIENTE cl
                                     INNER JOIN BacParamSuda.dbo.TBL_EJECUTIVOS ej ON ej.Nombre = cl.ejecutivo_comercial
                              WHERE cl.ejecutivo_comercial <> ''
                                AND ej.Codigo = @nCodigo), '')

      IF @nCliente <> ''
      BEGIN
         SELECT -1, 'Ejecutivo Relacionado al cliente : ' + @nCliente
         RETURN
      END

      UPDATE TBL_EJECUTIVOS
         SET Estado = 'ELIMINADO'
       WHERE Codigo = @nCodigo
   
      SELECT 0, 'Ok'
   END

END
GO
