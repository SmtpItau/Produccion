USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LCRPARMDAGRUMDA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LCRPARMDAGRUMDA]
   (   @iTag         INTEGER
   ,   @LCRParMda1   NUMERIC(18,0)   = 0
   ,   @LCRParMda2   NUMERIC(18,0)   = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @cNemoMon1    CHAR(3)
   DECLARE @cNemoMon2    CHAR(3)
   DECLARE @LCRGruMdaCod CHAR(8)      

   IF @iTag = 0
   BEGIN
      SELECT mncodmon, mnnemo, mnglosa 
        FROM BacParamSuda.dbo.MONEDA with(nolock) WHERE mntipmon IN(2, 3) ORDER BY mnnemo
   END

   IF @iTag = 1
   BEGIN
      SELECT uno.mnnemo
           , LCRParMda1
           , dos.mnnemo
           , LCRParMda2
           , LCRGruMdaCod
        FROM LCRPARMDAGRUMDA
             INNER JOIN BacParamSuda.dbo.MONEDA uno ON uno.mncodmon = LCRParMda1
             INNER JOIN BacParamSuda.dbo.MONEDA dos ON dos.mncodmon = LCRParMda2
      ORDER BY uno.mnnemo, dos.mnnemo
   END

   IF @iTag = 2
   BEGIN   
      SET @cNemoMon1   = (SELECT mnnemo FROM BacParamSuda.dbo.MONEDA WHERE mncodmon = @LCRParMda1)
      SET @cNemoMon2   = (SELECT mnnemo FROM BacParamSuda.dbo.MONEDA WHERE mncodmon = @LCRParMda2)
      SET @LCRGruMdaCod= LTRIM(RTRIM(@cNemoMon1)) + '_' + LTRIM(RTRIM(@cNemoMon2))

      IF NOT EXISTS( SELECT 1 FROM LCRPARMDAGRUMDA WHERE LCRParMda1 = @LCRParMda1 AND LCRParMda2 = @LCRParMda2)
      BEGIN
         INSERT INTO LCRPARMDAGRUMDA (LCRParMda1,  LCRParMda2,  LCRGruMdaCod)
                               VALUES(@LCRParMda1, @LCRParMda2, @LCRGruMdaCod)

         --> DELETE FROM LCRPARMDAGRUMDA
         --> WHERE LCRParMda1 = @LCRParMda1 AND LCRParMda2 = @LCRParMda2
      END
   END

   IF @iTag = 3
   BEGIN
      RETURN
      --> DELETE FROM LCRPARMDAGRUMDA
   END

   IF @iTag = 4
   BEGIN
      SET @LCRGruMdaCod = (SELECT LCRGruMdaCod FROM LCRPARMDAGRUMDA WHERE LCRParMda1 = @LCRParMda1 AND LCRParMda2 = @LCRParMda2)

      IF EXISTS( SELECT 1 FROM LCRRIEPARMDAPON WHERE lcrgrumdacod = @LCRGruMdaCod)
      BEGIN
         SELECT -1, 'Par de Monedas se encuentra en uso ' + LTRIM(RTRIM( @LCRGruMdaCod )) + '. No se puede eliminar'
      END ELSE
      BEGIN
         DELETE FROM LCRPARMDAGRUMDA
               WHERE LCRGruMdaCod   = @LCRGruMdaCod
      END
   END

END
GO
