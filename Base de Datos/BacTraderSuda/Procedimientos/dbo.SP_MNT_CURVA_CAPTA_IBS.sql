USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_CURVA_CAPTA_IBS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MNT_CURVA_CAPTA_IBS]
   (   @iMiTag   INTEGER
   ,   @IdCurva  VARCHAR(50) = ''
   ,   @iMoneda  INTEGER     = 0
   ,   @iPlazoD  INTEGER     = 0
   ,   @iPlazoH  INTEGER     = 0
   ,   @iTasa    FLOAT       = 0.0
   ,   @iMonFil  INTEGER     = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iMiTag = 1
   BEGIN
      SELECT SUBSTRING(mnnemo,1,3) + ' - ' + SUBSTRING(mnglosa,1,17)
      ,      PlazoDesde
      ,      PlazoHasta
      ,      Tasa
      ,      Moneda
      ,      IdCurva
      FROM   CURVA_CAPTACIONES_IBS
             LEFT JOIN BacParamSuda..MONEDA ON mncodmon = Moneda
      WHERE  IdCurva = @IdCurva
      AND   (Moneda  = @iMonFil or @iMonFil = 0)
      ORDER BY Moneda , PlazoDesde , PlazoHasta
      RETURN
   END
   
   IF @iMiTag = 2
   BEGIN
      IF @iMonFil > 0
         DELETE CURVA_CAPTACIONES_IBS WHERE IdCurva = @IdCurva AND Moneda = @iMonFil
      ELSE
         DELETE CURVA_CAPTACIONES_IBS

      IF @@ERROR <> 0
         SELECT -1 , 'Error en la Eliminación de Cuervas.'

      RETURN
   END

   IF @iMiTag = 3
   BEGIN
      IF EXISTS(SELECT 1 FROM CURVA_CAPTACIONES_IBS WHERE IdCurva = @IdCurva AND Moneda = @iMoneda AND (PlazoDesde >= @iPlazoD AND PlazoHasta <= @iPlazoH))
      BEGIN
         UPDATE CURVA_CAPTACIONES_IBS
         SET    Tasa          = @iTasa
         WHERE  IdCurva       = @IdCurva
         AND    Moneda        = @iMoneda 
         AND   (PlazoDesde   >= @iPlazoD AND PlazoHasta <= @iPlazoH)

         IF @@ERROR <> 0
            SELECT -1 , 'Error en la Actualización de Cuervas.'

      END ELSE
      BEGIN
         INSERT INTO CURVA_CAPTACIONES_IBS
         SELECT @IdCurva
         ,      @iMoneda
         ,      @iPlazoD
         ,      @iPlazoH
         ,      @iTasa

         IF @@ERROR <> 0
            SELECT -1 , 'Error en la Grabación de Cuervas.'
      END
      RETURN
   END

   IF @iMiTag = 4
   BEGIN
      SELECT SUBSTRING(mnnemo,1,3) + ' - ' + SUBSTRING(mnglosa,1,17)
      ,      mncodmon
      FROM   BacParamSuda..MONEDA
      WHERE  mntipmon IN(2,3)
      RETURN
   END

   IF @iMiTag = 5
   BEGIN
      SELECT DISTINCT IdCurva
      FROM   CURVA_CAPTACIONES_IBS
      RETURN
   END

END



GO
